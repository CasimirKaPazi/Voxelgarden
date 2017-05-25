--
-- Water renewable
--

-- If the water edge is a straight line flowing has 3 neighbors,
-- everything curved inwards would be more, anything outwards would be less.

local direct = {
	{x = 1,  y = 0, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 0,  y = 0, z = 1},
	{x = 0,  y = 0, z = -1},
}

local diagonal = {
	{x = 1,  y = 0, z = 1},
	{x = -1, y = 0, z = 1},
	{x = 1,  y = 0, z = -1},
	{x = -1, y = 0, z = -1},
}

local function check_for_source(pos, candidates, source)
	if not source then return end
	local count = 0
	for _, p in ipairs(candidates) do
		local s_pos = {x = pos.x + p.x, y = pos.y + p.y, z = pos.z + p.z}
		if minetest.get_node(s_pos).name == source then
			count = count +1
		end
	end
	return count
end

local function renew_liquid(pos, source)
		-- Direct neighbors
		local count_direct = check_for_source(pos, direct, source)
		if count_direct <= 1 then return false end
		-- Diagonal neighbors
		local count_diagonal = check_for_source(pos, diagonal, source)
		if count_direct + count_diagonal >= 4 then
			return true
		end
		return false
end

local source_pos = {
-- First check the node directely above for falling down.
	{x = 0,  y = 0, z = 0},
-- Then check sideways to flow downsteam.
	{x = 1,  y = 0, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 0,  y = 0, z = 1},
	{x = 0,  y = 0, z = -1},
-- Check diagonal
	{x = 1,  y = 0, z = 1},
	{x = -1, y = 0, z = 1},
	{x = 1,  y = 0, z = -1},
	{x = -1, y = 0, z = -1},
}

local function register_dynamic_liquid(source, flowing)
	minetest.register_abm({
		label = "Liquid physics "..source,
		nodenames = {flowing},
		neighbors = {source},
		interval = 1,
		chance = 5,
		catch_up = false,
		action = function(pos, node)
			-- Flowing down
			above = {x = pos.x, y = pos.y + 1, z = pos.z}
			for _, p in ipairs(source_pos) do
				local s_pos = {x = above.x + p.x, y = above.y + p.y, z = above.z + p.z}
				local n_checked = minetest.get_node(s_pos)
				if n_checked.name == source then
					node.name = source
					n_checked.name = flowing
					minetest.set_node(s_pos, n_checked) -- Replace with flowing to avoid air under water
					minetest.set_node(pos, node)
					return
				end
			end
			-- Renewable
			if renew_liquid(pos, source) then
				minetest.set_node(pos, {name = source})
			end
		end
	})
end

register_dynamic_liquid("default:water_source", "default:water_flowing")
register_dynamic_liquid("default:lava_source", "default:lava_flowing")
