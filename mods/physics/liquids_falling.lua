-- If the water edge is a straight line flowing has 3 neighbors,
-- everything curved inwards would be more, anything outwards would be less.
-- Water nodes propagate downwards to fill holes.

local function count_source(pos, source)
	local p0 = {x=pos.x-1, y=pos.y, z=pos.z-1}
	local p1 = {x=pos.x+1, y=pos.y, z=pos.z+1}
	local ps = minetest.find_nodes_in_area(p0, p1, {source})
	return #ps
end

local source_pos = {
-- First check the node directely above for falling down.
	{x = 0,  y = 1, z = 0},
-- Then check sideways to flow downsteam.
	{x = 1,  y = 1, z = 0},
	{x = -1, y = 1, z = 0},
	{x = 0,  y = 1, z = 1},
	{x = 0,  y = 1, z = -1},
}

local function register_dynamic_liquid(source, flowing)
	minetest.register_abm({
		label = "Liquid physics "..source,
		nodenames = {flowing},
		neighbors = {source},
		interval = 1,
		chance = 1,
		catch_up = false,
		action = function(pos, node)
			-- For param5 = 15 there is almost always a source to move,
			-- we just need to find where it is.
			if node.param2 == 15 or node.param2 == 7 then
				-- Flowing down
				for _, p in ipairs(source_pos) do
					local s_pos = {x = pos.x + p.x, y = pos.y + p.y, z = pos.z + p.z}
					local n_checked = minetest.get_node(s_pos)
					if n_checked.name == source then
						node.name = source
						-- Replace with flowing to avoid air under water
						minetest.set_node(s_pos, {name = "air"})
						minetest.set_node(pos, {name = source})
						return
					end
				end
			end
			if node.param2 == 0 or node.param2 == 7 then
				-- Renewable
				if count_source(pos, source) >= 5 then
					minetest.set_node(pos, {name = source})
				end
			end
		end
	})
end

register_dynamic_liquid("default:water_source", "default:water_flowing")
register_dynamic_liquid("default:lava_source", "default:lava_flowing")
