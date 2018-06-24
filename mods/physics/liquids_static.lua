-- If the water edge is a straight line flowing has 3 neighbors,
-- everything curved inwards would be more, anything outwards would be less.

local function count_source(pos, source)
	local p0 = {x=pos.x-1, y=pos.y, z=pos.z-1}
	local p1 = {x=pos.x+1, y=pos.y, z=pos.z+1}
	local ps = minetest.find_nodes_in_area(p0, p1, {source})
	return #ps
end

minetest.register_abm({
	label = "Renew water",
	nodenames = {"default:water_flowing"},
	neighbors = {"default:water_source"},
	interval = 1,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		if node.param2 ~= 0 and node.param2 ~= 7 then return end
		if count_source(pos, "default:water_source") >= 4 then
			minetest.set_node(pos, {name = "default:water_source"})
		end
	end
})

minetest.register_abm({
	label = "Renew lava",
	nodenames = {"default:lava_flowing"},
	neighbors = {"default:lava_source"},
	interval = 1,
	chance = 10,
	catch_up = false,
	action = function(pos, node)
		if node.param2 ~= 0 and node.param2 ~= 7 then return end
		if count_source(pos, "default:lava_source") >= 4  then
			minetest.set_node(pos, {name = "default:lava_source"})
		end
	end
})
