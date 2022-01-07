local random = math.random

function default.can_grow(pos)
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then return false end
	if minetest.get_item_group(node_under.name, "soil") == 0 then
		minetest.remove_node(pos)
		return false
	end
	return true
end

function default.enough_light(pos)
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 10 then
		return false
	end
	return true
end

local c_air = minetest.get_content_id("air")
local c_apple = minetest.get_content_id("default:apple")

local function add_trunk_and_leaves(data, a, pos, tree_cid, leaves_cid,
		height, size, iters, is_apple_tree)
	local x, y, z = pos.x, pos.y, pos.z

	-- Trunk
	for y_dist = 0, height - 1 do
		local vi = a:index(x, y + y_dist, z)
		if y_dist == 0 or data[vi] == c_air or data[vi] == leaves_cid then
			data[vi] = tree_cid
		end
	end

	-- Force leaves near the trunk
	for z_dist = -1, 1 do
	for y_dist = -size, 1 do
		local vi = a:index(x - 1, y + height + y_dist, z + z_dist)
		for x_dist = -1, 1 do
			if data[vi] == c_air then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
			vi = vi + 1
		end
	end
	end

	-- Randomly add leaves in 2x2x2 clusters.
	for i = 1, iters do
		local clust_x = x + random(-size, size - 1)
		local clust_y = y + height + random(-size, 0)
		local clust_z = z + random(-size, size - 1)

		for xi = 0, 1 do
		for yi = 0, 1 do
		for zi = 0, 1 do
			local vi = a:index(clust_x + xi, clust_y + yi, clust_z + zi)
			if data[vi] == c_air then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
		end
		end
		end
	end
end


local c_tree = minetest.get_content_id("default:tree")
local c_leaves = minetest.get_content_id("default:leaves")

function default.grow_tree(pos, is_apple_tree, bad)
	--[[
		NOTE: Tree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	if bad then
		error("Deprecated use of default.grow_tree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(4, 6)

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
			{x = pos.x - 2, y = pos.y, z = pos.z - 2},
			{x = pos.x + 2, y = pos.y + height + 1, z = pos.z + 2}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_tree, c_leaves, height, 2, 8, is_apple_tree)

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end

local c_jungletree = minetest.get_content_id("default:jungletree")
local c_jungleleaves = minetest.get_content_id("default:jungleleaves")

function default.grow_jungletree(pos, bad)
	--[[
		NOTE: Tree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	if bad then
		error("Deprecated use of default.grow_jungletree")
	end

	local x, y, z = pos.x, pos.y, pos.z
	local height = random(8, 12)

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
			{x = pos.x - 3, y = pos.y - 1,  z = pos.z - 3},
			{x = pos.x + 3, y = pos.y + height + 1, z = pos.z + 3})
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_jungletree, c_jungleleaves, height, 3, 30, false)

	-- Roots
	for z_dist = -1, 1 do
		local vi_1 = a:index(x - 1, y - 1, z + z_dist)
		local vi_2 = a:index(x - 1, y,     z + z_dist)
		for x_dist = -1, 1 do
			if random(1, 3) >= 2 then
				if data[vi_1] == c_air then
					data[vi_1] = c_jungletree
				elseif data[vi_2] == c_air then
					data[vi_2] = c_jungletree
				end
			end
			vi_1 = vi_1 + 1
			vi_2 = vi_2 + 1
		end
	end

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end

function default.grow_sapling(pos)
	if not default.can_grow(pos) then return true end
	if minetest.find_node_near(pos, 1, {"group:tree", "group:sapling"}) then
		minetest.set_node(pos, {name="default:grass_"..math.random(1, 5)})
		return
	end
	-- Restart the timer with a shorter timeout, as we just wait for enough light
	if not default.enough_light(pos) then
		minetest.get_node_timer(pos):start(math.random(30, 480))
		return
	end
	default.grow_tree(pos, math.random(1, 8) == 1)
end

function default.grow_junglesapling(pos)
	if not default.can_grow(pos) then return true end
	if minetest.find_node_near(pos, 1, {"group:tree", "group:sapling"}) then
		if math.random(1,10) == 1 then
			minetest.set_node(pos, {name="default:emergent_jungle_sapling"})
		else
			minetest.set_node(pos, {name="default:junglegrass"})
		end
		return
	end
	if not default.enough_light(pos) then
		minetest.get_node_timer(pos):start(math.random(30, 480))
		return
	end
	default.grow_jungletree(pos)
end

function default.grow_emergent_junglesapling(pos)
	if not default.can_grow(pos) then return true end
	if minetest.find_node_near(pos, 3, {"group:tree"}) then
		return
	end
	if not default.enough_light(pos) then
		minetest.get_node_timer(pos):start(math.random(30, 480))
		return
	end
	local path = minetest.get_modpath("default") ..
		"/schematics/emergent_jungle_tree.mts"
	minetest.place_schematic({x = pos.x - 3, y = pos.y - 5, z = pos.z - 3},
		path, "random", nil, false)
end

minetest.register_lbm({
	name = "default:convert_saplings_to_node_timer",
	nodenames = {"default:sapling", "default:junglesapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 4800))
	end
})

--
-- Sapling 'on place' function to check protection of node and resulting tree volume
--

function default.sapling_on_place(itemstack, placer, pointed_thing,
		sapling_name, minp_relative, maxp_relative, interval)
	-- Position of sapling
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local pdef = node and minetest.registered_nodes[node.name]

	if pdef and pdef.on_rightclick and
			not (placer and placer:is_player() and
			placer:get_player_control().sneak) then
		return pdef.on_rightclick(pos, node, placer, itemstack, pointed_thing)
	end

	if not pdef or not pdef.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		pdef = node and minetest.registered_nodes[node.name]
		if not pdef or not pdef.buildable_to then
			return itemstack
		end
	end

	local player_name = placer and placer:get_player_name() or ""
	-- Check sapling position for protection
	if minetest.is_protected(pos, player_name) then
		minetest.record_protection_violation(pos, player_name)
		return itemstack
	end
	-- Check tree volume for protection
	if minetest.is_area_protected(
			vector.add(pos, minp_relative),
			vector.add(pos, maxp_relative),
			player_name,
			interval) then
		minetest.record_protection_violation(pos, player_name)
		-- Print extra information to explain
--		minetest.chat_send_player(player_name,
--			itemstack:get_definition().description .. " will intersect protection " ..
--			"on growth")
		minetest.chat_send_player(player_name,
		    S("@1 will intersect protection on growth.",
			itemstack:get_definition().description))
		return itemstack
	end

	minetest.log("action", player_name .. " places node "
			.. sapling_name .. " at " .. minetest.pos_to_string(pos))

	local take_item = not minetest.is_creative_enabled(player_name)
	local newnode = {name = sapling_name}
	local ndef = minetest.registered_nodes[sapling_name]
	minetest.set_node(pos, newnode)

	-- Run callback
	if ndef and ndef.after_place_node then
		-- Deepcopy place_to and pointed_thing because callback can modify it
		if ndef.after_place_node(table.copy(pos), placer,
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	-- Run script hook
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Deepcopy pos, node and pointed_thing because callback can modify them
		if callback(table.copy(pos), table.copy(newnode),
				placer, table.copy(node or {}),
				itemstack, table.copy(pointed_thing)) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end

	return itemstack
end
