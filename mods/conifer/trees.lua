local c_air = minetest.get_content_id("air")
local c_ignore = minetest.get_content_id("ignore")
local c_conifertree = minetest.get_content_id("conifer:tree")
local c_coniferleaves_1 = minetest.get_content_id("conifer:leaves_1")
local c_coniferleaves_2 = minetest.get_content_id("conifer:leaves_2")

function conifer.grow_conifertree(data, a, pos, special_leaves, seed)
	local pr = PseudoRandom(seed)
	local th = pr:next(12, 24)
	local x, y, z = pos.x, pos.y, pos.z
	local coniferleaves = c_coniferleaves_1
	if special_leaves then
		coniferleaves = c_coniferleaves_2
	end
	
	-- Roots
	for xi = -1, 1 do
		local vi1 = a:index(x+xi, y, z)
		local vi2 = a:index(x+xi, y-1, z)
		if a:contains(x+xi, y-1, z) and data[vi2] == c_air then
			data[vi2] = c_conifertree
		elseif a:contains(x+xi, y, z) and data[vi1] == c_air then
			data[vi1] = c_conifertree
		end
	end
	for zi = -1, 1 do
		local vi1 = a:index(x, y, z+zi)
		local vi2 = a:index(x, y-1, z+zi)
		if a:contains(x, y-1, z+zi) and data[vi2] == c_air then
			data[vi2] = c_conifertree
		elseif a:contains(x, y, z+zi) and data[vi1] == c_air then
			data[vi1] = c_conifertree
		end
	end
	
	-- Trunk
	for yy = y, y+th-1 do
		local vi = a:index(x, yy, z)
		if
			a:contains(x, yy, z)
			and (data[vi] == c_air
			or data[vi] == c_coniferleaves_1
			or data[vi] == c_coniferleaves_2
			or yy == y)
		then
			data[vi] = c_conifertree
		end
	end
	
	-- Leaves
	local leaves_a = VoxelArea:new{MinEdge={x=-4, y=0, z=-4}, MaxEdge={x=4, y=th+3, z=4}}
	local leaves_buffer = {}

	-- Add leaves on the top
	leaves_buffer[leaves_a:index(0,		th+1,	0)]		= true
	leaves_buffer[leaves_a:index(0,		th,		-1)]	= true
	leaves_buffer[leaves_a:index(0,		th,		1)]		= true
	leaves_buffer[leaves_a:index(0,		th,		0)]		= true
	leaves_buffer[leaves_a:index(-1,	th,		0)]		= true
	leaves_buffer[leaves_a:index(1,		th,		0)]		= true

	-- Add rings of leaves randomly
	local d = 0
	for yi = th+1, 5, -1 do
	for xi = -d, d do
	for zi = -d, d do
		if math.abs(xi) + math.abs(zi) <= d or math.abs(zi) + math.abs(xi) <= d then
		leaves_buffer[leaves_a:index(xi, yi, zi)] = true
		end
	end
	end
	d = d + 1
	if d > math.random(2,4) then d = 1 end
	end
	
	-- Add the leaves
	for yi = leaves_a.MinEdge.y, leaves_a.MaxEdge.y do
	for xi = leaves_a.MinEdge.x, leaves_a.MaxEdge.x do
	for zi = leaves_a.MinEdge.z, leaves_a.MaxEdge.z do
		if a:contains(x+xi, y+yi, z+zi) then
			local vi = a:index(x+xi, y+yi, z+zi)
			if data[vi] == c_air or data[vi] == c_ignore then
				if leaves_buffer[leaves_a:index(xi, yi, zi)] then
					data[vi] = coniferleaves
				end
			end
		end
	end
	end
	end
end
