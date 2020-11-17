-- Load support for MT game translation.
local S = minetest.get_translator("hunger")

hunger = {}
local player_is_active = {}
local player_step = {}
local player_bar = {}
local player_heal_time = {}
local base_interval = 5
local heal_interval = 20

-- no_hunger privilege
minetest.register_privilege("no_hunger", {
	description = S("Player will feel no hunger."),
	give_to_singleplayer = false
})

-- Hunger bar
function hunger.new_bar(player, full)
	local name = player:get_player_name()
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

-- Change display
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
		hunger.new_bar(player, full)
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
	local meta = player:get_meta()
	local full = meta:get_int("hunger")
	if not full then
		full = 20
		meta:set_int("hunger", full)
	end
	hunger.new_bar(player, full)
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	full = 20
	hunger.update_bar(player, full)
	meta:set_int("hunger", full)
end)

minetest.register_on_newplayer(function(player)
	local meta = player:get_meta()
	local full = meta:get_int("hunger")
	full = 20
	meta:set_int("hunger", full)
	hunger.new_bar(player, full)
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
	if not player then return end
	if not hp_change then return end
	if itemstack:take_item() == nil then return end
	-- Restore default behaviour when player can feel no hunger
	local name = player:get_player_name()
	local meta = player:get_meta()
	if minetest.get_player_privs(name)["no_hunger"] then
		player:set_hp(player:get_hp() + hp_change)
	else
		local full = meta:get_int("hunger")
		if full + hp_change > 20 then
			full = 20
		else
			full = full + hp_change
		end
		hunger.update_bar(player, full)
		meta:set_int("hunger", full)
	end

	local headpos  = player:get_pos()
	headpos.y = headpos.y + 1
	local sound = "hunger_eating"
	if def and def.sound and def.sound.eat then
		sound = def.sound.eat
	end
	core.sound_play(sound, {
		pos = player:get_pos(),
		max_hear_distance = 16
	}, true)

	if replace_with_item then
		if itemstack:is_empty() then
			itemstack:add_item(replace_with_item)
		else
			local inv = player:get_inventory()
			-- Check if inv is null, since non-players don't have one
			if inv and inv:room_for_item("main", {name=replace_with_item}) then
				inv:add_item("main", replace_with_item)
			else
				local pos = player:get_pos()
				pos.y = math.floor(pos.y + 0.5)
				core.add_item(pos, replace_with_item)
			end
		end
	end

	return itemstack
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
		local meta = player:get_meta()
		local full = tonumber(meta:get_int("hunger"))
		if not full then full = 20 end
		if minetest.get_player_privs(name)["no_hunger"] then
			if player_bar[name] then
				player:hud_remove(player_bar[name])
			end
			return
		end
		-- heal when hunger there is hunger
		if player_heal_time[name] then
			player_heal_time[name] = player_heal_time[name] + 1
		else
			player_heal_time[name] = 0
		end
		if player_heal_time[name] >= heal_interval / full then
			player:set_hp(hp + 1)
			player_heal_time[name] = 0
		end
		-- hurt when no saturation is left
		if full <= 0 then
			player:set_hp(hp - 1)
			local pos_sound  = player:get_pos()
			minetest.chat_send_player(name, S("You are hungry."))
		end
		-- reduce saturation when player is active
		if not player_is_active[name] then return end
		-- The hunger interval for each player depends on the health
		if not player_step[name] or player_step[name] >= 20 then
			player_step[name] = 0
		end
		player_step[name] = player_step[name] + 1
		if player_step[name] < hp then return end
		player_step[name] = 0
		full = full - 1
		player_is_active[name] = false
		hunger.update_bar(player, full)
		meta:set_int("hunger", full)
	end
end)

end
