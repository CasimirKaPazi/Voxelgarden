-- mods/default/functions.lua

--
-- Default node sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=1.0}
	table.dug = table.dug or
			{name="default_dug_node", gain=1.0}
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
			{name="default_break_glass", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

--
-- Furnace ABM
--

local function swap_node(pos,name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

-- When you overwrite this, also copy the swap_node function above.
function default.abm_furnace(pos, node, active_object_count, active_object_count_wider)
	local meta = minetest.get_meta(pos)
	for i, name in ipairs({
		"fuel_totaltime",
		"fuel_time",
		"src_totaltime",
		"src_time"
	}) do
		if meta:get_string(name) == "" then
			meta:set_float(name, 0.0)
		end
	end

	local inv = meta:get_inventory()
	local srclist = inv:get_list("src")
	local cooked = nil
	local aftercooked
		
	if srclist then
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
	end

	local was_active = false

	if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		was_active = true
		meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
		meta:set_float("src_time", meta:get_float("src_time") + 1)
		if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
			-- check if there's room for output in "dst" list
			if inv:room_for_item("dst",cooked.item) then
				-- Put result in "dst" list
				inv:add_item("dst", cooked.item)
				-- take stuff from "src" list
				inv:set_stack("src", 1, aftercooked.items[1])
			else
				print("Could not insert '"..cooked.item:to_string().."'")
			end
			meta:set_string("src_time", 0)
		end
	end

	if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		local percent = math.floor(meta:get_float("fuel_time") /
				meta:get_float("fuel_totaltime") * 100)
		meta:set_string("infotext","Furnace active: "..percent.."%")
		swap_node(pos,"default:furnace_active")
		meta:set_string("formspec",
			"size[8,9]"..
			"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
					(100-percent)..":default_furnace_fire_fg.png]"..
			"list[current_name;fuel;2,3;1,1;]"..
			"list[current_name;src;2,1;1,1;]"..
			"list[current_name;dst;5,1;2,2;]"..
			"list[current_player;main;0,5;8,4;]")
		return
	end

	local fuel = nil
	local afterfuel
	local cooked = nil
	local fuellist = inv:get_list("fuel")
	local srclist = inv:get_list("src")

	if srclist then
		cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
	end
	if fuellist then
		fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
	end

	if not fuel or fuel.time <= 0 then
		meta:set_string("infotext","Furnace out of fuel")
		swap_node(pos,"default:furnace")
		meta:set_string("formspec", default.furnace_inactive_formspec)
		return
	end

	if cooked.item:is_empty() then
		if was_active then
			meta:set_string("infotext","Furnace is empty")
			swap_node(pos,"default:furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
		end
		return
	end

	meta:set_string("fuel_totaltime", fuel.time)
	meta:set_string("fuel_time", 0)

	inv:set_stack("fuel", 1, afterfuel.items[1])
end

--
-- Grow grass
--

minetest.register_abm({
	nodenames = {"default:dirt"},
	interval = 2,
	chance = 200,
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
	nodenames = {"default:dirt_with_grass"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})

minetest.register_abm({
	nodenames = {"default:dirt_with_snow"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		if name == "default:snow" or "default:snowblock" then return end
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})


--
-- Lavacooling
--

default.cool_lava_source = function(pos)
	minetest.set_node(pos, {name="default:stone"})
end

default.cool_lava_flowing = function(pos)
	minetest.set_node(pos, {name="default:cobble"})
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_flowing(pos, node, active_object_count, active_object_count_wider)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_source(pos, node, active_object_count, active_object_count_wider)
	end,
})

--
-- Papyrus and cactus growing
--

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 80,
	chance = 30,
	action = function(pos, node)
		pos.y = pos.y - 1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "sand") ~= 0 then
			pos.y = pos.y + 1
			local height = 0
			while minetest.get_node(pos).name == "default:cactus" and height < 4 do
				height = height + 1
				pos.y = pos.y + 1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:cactus"})
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"default:dirt", "default:dirt_with_grass", "default:papyrus_roots"},
	interval = 47,
	chance = 30,
	action = function(pos, node)
		pos.y = pos.y - 1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "soil") > 0 or name == "nodetest:papyrus_roots" then
			if not minetest.find_node_near(pos, 3, {"group:water"}) then
				return
			end
			pos.y = pos.y + 1
			local height = 0
			while minetest.get_node(pos).name == "default:papyrus" and height < 5 do
				height = height + 1
				pos.y = pos.y + 1
			end
			if height < math.random(0, 5) then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:papyrus"})
				end
			end
		end
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
