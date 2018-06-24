-- mods/default/functions.lua

--
-- Default node sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=1.0}
	table.dug = table.dug or
			{name="default_dug_node", gain=0.5}
	table.place = table.place or
			{name="default_place_node", gain=0.5}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.3}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=0.2}
	--table.dug = table.dug or
	--		{name="default_dirt_break", gain=0.5}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_grass_footstep", gain=0.2}
	--table.dug = table.dug or
	--		{name="default_dirt_break", gain=0.25}
	table.dug = table.dug or
			{name="", gain=0.25}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.4}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_dig_crumbly", gain=0.2}
	table.dig = table.dig or
			{name="default_dig_crumbly", gain=0.4}
	table.dug = table.dug or
			{name="", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.3}
	table.dug = table.dug or
			{name="default_break_glass", gain=0.5}
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
	label = "Grass new",
	nodenames = {"group:flora"},
	neighbors = {"default:dirt"},
	interval = 2,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		local under = {x=pos.x, y=pos.y-1, z=pos.z}
		local name = minetest.get_node(under).name
		if name == "default:dirt" then
			minetest.set_node(under, {name = "default:dirt_with_grass"})
		end
	end
})

minetest.register_abm({
	label = "Grass covered",
	nodenames = {
		"default:dirt_with_grass",
		"default:dirt_with_snow",
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
		minetest.set_node(pos, {name = "default:molten_rock"})
	else -- Lava flowing
		minetest.set_node(pos, {name = "default:stone"})
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
		minetest.set_node(pos, {name = "default:stone"})
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
