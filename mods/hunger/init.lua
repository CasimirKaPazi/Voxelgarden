hunger = {}
local player_is_active = {}
local player_step = {}
local player_bar = {}
local base_interval = 0.5

-- no_hunger privilege
minetest.register_privilege("no_hunger", {
	description = "Player will feel no hunger.",
	give_to_singleplayer = false
})

-- Hunger bar
function hunger.update_bar(player, full)
	if not player then return end
	if not full then return end
	local name = player:get_player_name()
	if minetest.get_player_privs(name)["no_hunger"] then
		player:hud_remove(player_bar[name])
		return
	end
	if player_bar[name] then
		player:hud_change(player_bar[name], "number", full)
	else
		player_bar[name] = player:hud_add({
			hud_elem_type = "statbar",
			position = {x=0.5,y=1.0},
			text = "hunger.png",
			number = full,
			dir = 1,
			offset = {x=(9*24)-6,y=-(3*24+8)},
			size = {x=16, y=16},
		})
	end
end

if minetest.settings:get_bool("enable_damage") == true then

-- Prevent players from starving while afk (<--joke)
minetest.register_on_dignode(function(pos, oldnode, player)
	if not player then return end
	local name = player:get_player_name()
	player_is_active[name] = true
end)

minetest.register_on_placenode(function(pos, node, player)
	if not player then return end
	local name = player:get_player_name()
	player_is_active[name] = true
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	local full = player:get_attribute("hunger")
	if not full then full = 20 end
	hunger.update_bar(player, full)
	player:set_attribute("hunger", full)
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	full = 20
	hunger.update_bar(player, full)
	player:set_attribute("hunger", full)
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
	if not player then return end
	if not hp_change then return end
	local full = player:get_attribute("hunger")
	-- For each health, we add 2 full
	if full + 2*hp_change > 20 then
		full = 20
	else
		full = full + 2*hp_change
	end
	local headpos  = player:get_pos()
	headpos.y = headpos.y + 1
	minetest.sound_play("hunger_eating", {pos = headpos, gain = 1.0, max_hear_distance = 32})
	hunger.update_bar(player, full)
	player:set_attribute("hunger", full)
end)

-- Main function
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer < base_interval then return end
	timer = 0
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local hp = player:get_hp()
		local full = player:get_attribute("hunger")
		if minetest.get_player_privs(name)["no_hunger"] then
			if player_bar[name] then
				player:hud_remove(player_bar[name])
			end
			return
		end
		if not player_is_active[name] then return end
		-- The hunger interval for each player depends on the health
		if not player_step[name] or player_step[name] >= 20 then
			player_step[name] = 0
		end
		player_step[name] = player_step[name] + 1
		if player_step[name] < hp then return end
		player_step[name] = 0
		if not full then full = 20 end
		full = full - 1
		if full <= 0 then
			player:set_hp(hp - 1)
			full = 20
			local pos_sound  = player:get_pos()
			minetest.chat_send_player(name, "You are hungry.")
		end
		player_is_active[name] = false
		hunger.update_bar(player, full)
		player:set_attribute("hunger", full)
	end
end)

end
