--
-- Papyrus growing
--

minetest.register_abm({
	nodenames = {"nodetest:papyrus_roots"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="default:papyrus"})
		end
	end,
})

--
-- Grow trees
--

minetest.register_abm({
	nodenames = {"nodetest:conifersapling"},
	interval = 13,
	chance = 50,
	action = function(pos, node)
		local is_soil = minetest.registered_nodes[minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name].groups.soil
		if is_soil == nil or is_soil == 0 then return end
		-- When to close to other trees, turn to decoration.
		r = math.random(1, 3)
		if minetest.find_node_near(pos, r, {"group:tree", "group:sapling"}) then
			minetest.set_node(pos, {name="nodetest:coniferleaves_"..math.random(1, 2)})
			return
		end
		local above_name = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if above_name ~= "air" and above_name ~= "ignore" then return end
		-- Otherwise grow a tree.
		print("A conifer sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		nodetest.grow_conifertree(data, a, pos, math.random(1, 4) == 1, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
        end
})
