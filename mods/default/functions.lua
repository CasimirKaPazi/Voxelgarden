-- mods/default/functions.lua

--
-- Default node sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "", gain = 1.0}
	table.dug = table.dug or
			{name = "default_dug_node", gain = 0.25}
	table.place = table.place or
			{name = "default_place_node_hard", gain = 1.0}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_hard_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_hard_footstep", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_dirt_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "default_dirt_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_sand_footstep", gain = 0.05}
	table.dug = table.dug or
			{name = "default_sand_footstep", gain = 0.15}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_gravel_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_gravel_footstep", gain = 0.1}
	table.dig = table.dig or
			{name = "default_gravel_dig", gain = 0.35}
	table.dug = table.dug or
			{name = "default_gravel_dug", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_wood_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_wood_footstep", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_grass_footstep", gain = 0.45}
	table.dug = table.dug or
			{name = "default_grass_footstep", gain = 0.7}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_glass_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "default_glass_footstep", gain = 0.5}
	table.dug = table.dug or
			{name = "default_break_glass", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_ice_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_ice_footstep", gain = 0.3}
	table.dig = table.dig or
			{name = "default_ice_dig", gain = 0.5}
	table.dug = table.dug or
			{name = "default_ice_dug", gain = 0.5}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_metal_footstep", gain = 0.4}
	table.dig = table.dig or
			{name = "default_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "default_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "default_place_node_metal", gain = 0.5}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_water_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_water_footstep", gain = 0.2}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_snow_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_snow_footstep", gain = 0.2}
	table.dig = table.dig or
			{name = "default_snow_footstep", gain = 0.3}
	table.dug = table.dug or
			{name = "default_snow_footstep", gain = 0.3}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

--
-- Grow grass
--

minetest.register_abm({
	label = "Grass spread",
	nodenames = {"default:dirt"},
	neighbors = {"default:dirt_with_grass", "default:dirt_with_grass_footsteps"},
	interval = 2,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none"
				and (minetest.get_node_light(above) or 0) >= 11 then
			if name == "default:snow" or name == "default:snowblock" then
				minetest.set_node(pos, {name = "default:dirt_with_snow"})
			else
				minetest.set_node(pos, {name = "default:dirt_with_grass"})
			end
		end
	end
})

minetest.register_abm({
	label = "Grass spread",
	nodenames = {"default:dirt"},
	neighbors = {
		"group:spreading_dirt_type",
		"group:grass",
		"group:dry_grass",
		"default:snow",
	},
	interval = 7,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 10 then
			return
		end
		if minetest.get_item_group(minetest.get_node(above).name, "liquid") > 0 then
			return
		end

		-- Look for spreading dirt-type neighbours
		local p2 = minetest.find_node_near(pos, 1, "group:spreading_dirt_type")
		if p2 then
			local n3 = minetest.get_node(p2)
			minetest.set_node(pos, {name = n3.name})
			return
		end

		-- Else, any seeding nodes on top?
		local name = minetest.get_node(above).name
		-- Snow check is cheapest, so comes first
		if name == "default:snow" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		elseif minetest.get_item_group(name, "dry_grass") ~= 0 then
			minetest.set_node(pos, {name = "default:dirt_with_dry_grass"})
		elseif minetest.get_item_group(name, "flora") ~= 0 then
			minetest.set_node(pos, {name = "default:dirt_with_grass"})
		end
	end
})

minetest.register_abm({
	label = "Grass covered",
	nodenames = {
		"group:spreading_dirt_type",
	},
	interval = 8,
	chance = 100,
	catch_up = false,
	action = function(pos, node)
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef and not ((nodedef.sunlight_propagates or
				nodedef.paramtype == "light") and
				nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})


--
-- Lavacooling
--

default.cool_lava = function(pos, node)
	if node.name == "default:lava_source" then
		minetest.set_node(pos, {name = "default:obsidian"})
	else -- Lava flowing
		minetest.set_node(pos, {name = "default:molten_rock"})
	end
	minetest.sound_play("default_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.25})
end

minetest.register_abm({
	label = "Lava cooling",
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"group:cools_lava", "group:water"},
	interval = 1,
	chance = 2,
	catch_up = false,
	action = function(...)
		default.cool_lava(...)
	end,
})

minetest.register_abm({
	label = "Molten rock cooling",
	nodenames = {"default:molten_rock"},
	neighbors = {"group:cools_lava", "group:water"},
	interval = 11,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:stone_crumbled"})
	end,
})

--
-- Papyrus and cactus growing
--

function default.grow_cactus(pos, node)
	pos.y = pos.y - 1
	local node = minetest.get_node(pos)
	if minetest.get_item_group(node.name, "sand") == 0 then
		return
	end
	pos.y = pos.y + 1
	local height = 0
	node = minetest.get_node(pos)
	while node.name == "default:cactus" and height < 5 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if node.name ~= "air" then return end
	-- Increased chance for figs to grow the taller the cactus is.
	if height < math.random(2, 5) then
		minetest.set_node(pos, {name="default:cactus"})
	else
		minetest.set_node(pos, {name="default:cactus_fig"})
	end
	return true
end

function default.grow_papyrus(pos, node)
	pos.y = pos.y - 1
	local node = minetest.get_node(pos)
	if minetest.get_item_group(node.name, "soil") == 0 then
		return
	end
	if not minetest.find_node_near(pos, 3, {"group:water"}) then
		return
	end
	pos.y = pos.y + 1
	node = minetest.get_node(pos)
	local height = 0
	while node.name == "default:papyrus" and height < 5 do
		height = height + 1
		pos.y = pos.y + 1
		node = minetest.get_node(pos)
	end
	if height < math.random(0, 5) and node.name == "air" then
		minetest.set_node(pos, {name="default:papyrus"})
		return true
	end
end

minetest.register_abm({
	nodenames = {"default:coral_brown", "default:coral_orange", "default:coral_purple"},
	neighbors = {"air"},
	interval = 17,
	chance = 5,
	catch_up = false,
	action = function(pos, node)
		if not minetest.find_node_near(pos, 1, "group:water") then
			minetest.set_node(pos, {name = "default:coral_skeleton"})
		end
	end,
})

-- Wrapping the functions in abm action is necessary to make overriding them possible.
minetest.register_abm({
	label = "Grow cactus",
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 70,
	chance = 30,
	action = function(...)
		default.grow_cactus(...)
	end,
})

minetest.register_abm({
	label = "Grow cactus from fig",
	nodenames = {"default:cactus_fig"},
	neighbors = {"group:sand"},
	interval = 7,
	chance = 3,
	action = function(pos, node)
		local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if minetest.get_item_group(node_under.name, "sand") ~= 0 then
			minetest.set_node(pos, {name="default:cactus"})
		end
	end,
})

minetest.register_abm({
	label = "Grow papyrus",
	nodenames = {"default:papyrus"},
	neighbors = {"default:dirt", "default:dirt_with_grass", "default:papyrus_roots"},
	interval = 40,
	chance = 30,
	action = function(...)
		default.grow_papyrus(...)
	end,
})

minetest.register_abm({
	nodenames = {"default:seedling"},
	interval = 11,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		if (minetest.get_node_light(above) or 0) >= 11 then
			local flower_choice = math.random(1, 7)
			local flower
			if flower_choice == 1 then
				flower = "flowers:tulip"
			elseif flower_choice == 2 then
				flower = "flowers:rose"
			elseif flower_choice == 3 then
				flower = "flowers:viola"
			elseif flower_choice == 4 then
				flower = "flowers:geranium"
			elseif flower_choice == 5 then
				flower = "flowers:dandelion_white"
			elseif flower_choice == 6 then
				flower = "flowers:dandelion_yellow"
			elseif flower_choice == 7 then
				flower = "air"
			end
			minetest.set_node(pos, {name=flower})
		end
	end
})

function default.place_kelp(itemstack, placer, pos)
	if minetest.get_node(pos).name ~= "default:sand" then
		return itemstack
	end

	local height = math.random(4, 6)
	local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
	local node_top = minetest.get_node(pos_top)
	local def_top = minetest.registered_nodes[node_top.name]
	
	if placer then
		local player_name = placer:get_player_name()
		if minetest.is_protected(pos, player_name)
			and minetest.is_protected(pos_top, player_name) then
			minetest.chat_send_player(player_name, "Node is protected")
			minetest.record_protection_violation(pos, player_name)
			return itemstack
		end
	end

	if def_top and def_top.liquidtype == "source" and
			minetest.get_item_group(node_top.name, "water") > 0 then
		minetest.set_node(pos, {name = "default:sand_with_kelp",
			param2 = height * 16})
		if itemstack and not minetest.settings:get_bool("creative_mode") then
			itemstack:take_item()
		end
	end

	return itemstack
end

minetest.register_abm({
	label = "Grow Kelp",
	nodenames = {"default:sand_with_small_kelp"},
	interval = 11,
	chance = 50,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:sand"})
		default.place_kelp(nil, nil, pos)
	end,
})

-- Dig upwards
function default.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end

-- Rotate symmetric nodes 
function default.rotate_horizontal(pos)
	local node = minetest.get_node(pos)
	if node.param2 == 2 then
		node.param2 = 0
	elseif node.param2 == 3 then
		node.param2 = 1
	else
		return
	end
	minetest.set_node(pos, node)
end

--
-- NOTICE: This method is not an official part of the API yet.
-- This method may change in future.
--

function default.can_interact_with_node(player, pos)
	if player and player:is_player() then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
	else
		return false
	end

	local meta = minetest.get_meta(pos)
	local owner = meta:get_string("owner")

	if not owner or owner == "" or owner == player:get_player_name() then
		return true
	end

	-- Is player wielding the right key?
	local item = player:get_wielded_item()
	if minetest.get_item_group(item:get_name(), "key") == 1 then
		local key_meta = item:get_meta()

		if key_meta:get_string("secret") == "" then
			local key_oldmeta = item:get_metadata()
			if key_oldmeta == "" or not minetest.parse_json(key_oldmeta) then
				return false
			end

			key_meta:set_string("secret", minetest.parse_json(key_oldmeta).secret)
			item:set_metadata("")
		end

		return meta:get_string("key_lock_secret") == key_meta:get_string("secret")
	end

	return false
end
