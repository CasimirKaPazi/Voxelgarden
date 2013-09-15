perlinore = {}

function perlinore.generate_ore(
								minp, maxp, seed,
								name, wherein,
								height_min, height_max,
								inverse_chance, scale, noise_min, noise_max
								)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local t1 = os.clock()
	local pr = PseudoRandom(seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local a = VoxelArea:new{
			MinEdge={x=emin.x, y=emin.y, z=emin.z},
			MaxEdge={x=emax.x, y=emax.y, z=emax.z},
	}

	local data = vm:get_data()

	local c_ore  = minetest.get_content_id(name)

	local sidelen = maxp.x - minp.x + 1

	local noise = minetest.get_perlin_map(
			{offset=0, scale=1, spread={x=scale, y=scale, z=scale}, seed=5, octaves=5, persist=0.6},
			{x=sidelen, y=sidelen, z=sidelen}
	)
	local nvals = noise:get3dMap_flat({x=minp.x, y=minp.y, z=minp.z})

	local ni = 1
	for z = minp.z, maxp.z do
	for y = minp.y, maxp.y do
	for x = minp.x, maxp.x do
			if nvals[ni] > noise_min and nvals[ni] < noise_max then
				local pos={x=x,y=y,z=z}
				if minetest.get_node(pos).name == wherein then
					if pr:next(1,inverse_chance) == 1 then
						local vi = a:index(x, y, z)
						data[vi] = c_ore
					end
				end
			end
			ni = ni + 1
	end
	end
	end

	vm:set_data(data)
      
	vm:calc_lighting(
			{x=minp.x-16, y=minp.y, z=minp.z-16},
			{x=maxp.x+16, y=maxp.y, z=maxp.z+16}
	)

	vm:write_to_map(data)
 
	print(string.format("elapsed time: %.2fms", (os.clock() - t1) * 1000))
end

minetest.register_on_generated(function(minp, maxp, seed)
	perlinore.generate_ore(
		minp, maxp, seed,
		"default:stone_with_coal", 	"default:stone",	-- name, wherein
		-20000,  64,									-- height_min, height_max
		6, 200, -0.02, 0.02								-- inverse chance, scale, noise_min, noise_max
	)
end)

