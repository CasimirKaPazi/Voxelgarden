if minetest.setting_getbool("enable_damage") == true then

players_hunger = {}

-- no_drown privilege
minetest.register_privilege("no_hunger", {
	description = "Player wont feel hunger",
	give_to_singleplayer = false
})

local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer >= 180 then --720 for one day
		timer = 0
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if players_hunger[name] == nil then
				players_hunger[name] = 0
			end
			players_hunger[name] = 1
--			print("[hunger] hunger for "..name.."")
        end
    end
end)

do_hunger = function(player)
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
	minetest.after(10, do_hunger, digger)
end)

minetest.register_on_placenode(function(pos, node, placer)
	minetest.after(10, do_hunger, placer)
end)

end
