local random = math.random

local c_air = minetest.get_content_id("air")
local c_leaves_1 = minetest.get_content_id("conifer:leaves_1")
local c_leaves_2 = minetest.get_content_id("conifer:leaves_2")
local c_snow = minetest.get_content_id("default:snow")

local function add_trunk_and_leaves(data, a, pos, tree_cid, leaves_special, height, snow)
	local x, y, z = pos.x, pos.y, pos.z
	local leaves_cid = c_leaves_1
	if leaves_special then leaves_cid = c_leaves_2 else end

	-- Trunk
	for y_dist = 0, height - 1 do
		local vi = a:index(x, y + y_dist, z)
		if y_dist == 0 or data[vi] == c_air or data[vi] == c_leaves_1 or data[vi] == c_leaves_2 then
			data[vi] = tree_cid
		end
	end

	-- Add rings of leaves randomly
	local d = 0
	for yi = height+1, 4 + random(0, 2), -1 do
	for xi = -d, d do
	for zi = -d, d do
		if math.abs(xi) + math.abs(zi) <= d or math.abs(zi) + math.abs(xi) <= d then
			local vi = a:index(x + xi, y + yi, z + zi)
			if data[vi] == c_air then
				if leaves_special then
					data[vi] = c_leaves_2
				else
					data[vi] = c_leaves_1
				end
				-- Cover in snow
				if snow and random(1, 2) == 1 then
					local vi_snow = a:index(x + xi, y + yi + 1, z + zi)
					if data[vi_snow] == c_air then
						data[vi_snow] = c_snow
					end
				end
			end
		end
	end
	end
	d = d + 1
	if d > random(2,4) then d = 1 end
	end
end

local c_tree = minetest.get_content_id("conifer:tree")

function conifer.grow_tree(pos, leaves_special, snow)
	local x, y, z = pos.x, pos.y, pos.z
	local height = random(12, 24)

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
			{x = pos.x - 3, y = pos.y - 1, z = pos.z - 3},
			{x = pos.x + 3, y = pos.y + height + 1, z = pos.z + 3}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	add_trunk_and_leaves(data, a, pos, c_tree, leaves_special, height, snow)

	-- Roots
	for xi = -1, 1 do
		local vi_1 = a:index(x+xi, y,	z)
		local vi_2 = a:index(x+xi, y-1,	z)
		if data[vi_2] == c_air then
			data[vi_2] = c_tree
		elseif data[vi_1] == c_air then
			data[vi_1] = c_tree
		end
	end
	for zi = -1, 1 do
		local vi_1 = a:index(x, y,	z+zi)
		local vi_2 = a:index(x, y-1,	z+zi)
		if data[vi_2] == c_air then
			data[vi_2] = c_tree
		elseif data[vi_1] == c_air then
			data[vi_1] = c_tree
		end
	end

	vm:set_data(data)
	vm:write_to_map()
	vm:update_map()
end

function conifer.grow_conifersapling(pos)
	if not default.can_grow(pos) then return true end
	if minetest.find_node_near(pos, 3, {"group:tree", "group:sapling"}) then
		minetest.set_node(pos, {name="conifer:leaves_"..random(1, 2)})
		return
	end
	conifer.grow_tree(pos, random(1, 4) == 1)
end

minetest.register_lbm({
	name = "conifer:convert_saplings_to_node_timer",
	nodenames = {"conifer:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(random(6000, 48000))
	end
})
