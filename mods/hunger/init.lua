hunger = {}
players_hunger	= {}
players_timer	= {}

-- no_drown privilege
minetest.register_privilege("no_hunger", {
	description = "Player will feel no hunger",
	give_to_singleplayer = false
})

if minetest.setting_getbool("enable_damage") == true then

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer < 1 then return end
	timer = 0
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		if players_hunger[name] == nil then
			players_hunger[name] = 0
		end
		if players_timer[name] == nil then
			players_timer[name] = 0
		end
		players_timer[name] = players_timer[name] + 1
		local health = player:get_hp()
		local timer = 180 * health / 20
		if players_timer[name] >= timer then  --720 equals one day
			players_hunger[name] = 1
			players_timer[name] = 0
		end
--		print("[hunger] hunger for "..name.."")
	end
end)

hunger.check = function(player)
	if not player then return end
	local name = player:get_player_name()
	if minetest.get_player_privs(name)["no_hunger"] then
		return
	end
	if players_hunger[name] == nil then
		players_hunger[name] = 0
	end
	if players_hunger[name] > 0 then
		count = players_hunger[name]
		local inv = player:get_inventory()
		-- deal damage, play sound
		local new_hp = math.max(0, (player:get_hp() - 1))
		player:set_hp(new_hp)
		local pos_sound  = player:getpos()
		minetest.sound_play("hunger_stomach",{pos = pos_sound, gain = 1.0, max_hear_distance = 16})
		minetest.chat_send_player(name, "You are hungry.")
		players_hunger[name] = 0
--		print("[hunger] "..name.." is hungry")
	end
end

minetest.register_on_dignode(function(pos, oldnode, digger)
	minetest.after(10, hunger.check, digger)
end)

minetest.register_on_placenode(function(pos, node, placer)
	minetest.after(10, hunger.check, placer)
end)

end
