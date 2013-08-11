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
		6, 300, -0.02, 0.02								-- inverse chance, scale, noise_min, noise_max
	)
end)


-- legacy function

--[[
perlinore = {}
--
-- Ore generation
--
-- Spreads the ore randomly within the perlin-noise given borders.

function perlinore.generate_ore(
					name, wherein, minp, maxp, seed,
					chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max,
					noise_min, noise_max
					)
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local ore_noise1
	local ore_noise2
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	
	-- perlin. Only done if borders are defined.
	if type(noise_min) == "number" or type(noise_max) == "number" then
		if type(noise_min) ~= "number" then
			noise_min = -2
		end
		if type(noise_max) ~= "number" then
			noise_max = 2
		end
		ore_noise1 = minetest.env:get_perlin(seed, 3, 0.7, 233)
	end
	
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			
			-- perlin
			if type(noise_min) == "number" or type(noise_max) == "number" then
				ore_noise2 = (ore_noise1:get3d(p0))
			end
			
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.env:get_node(p2).name == wherein then
							
							-- perlin
							if type(noise_min) == "number" or type(noise_max) == "number" then
								if ore_noise2 >= noise_min and ore_noise2 <= noise_max then
									minetest.env:set_node(p2, {name=name})
								end
							else
								minetest.env:set_node(p2, {name=name})
							end
							
					end
				end
			end
			end
			end
		end
	end
	--print("generate_perlinore done")
end

minetest.register_on_generated(function(minp, maxp, seed)
	perlinore.generate_ore(
		"default:stone_with_coal", 	"default:stone",
		minp, maxp,	seed+22215,
		1/5/5/5,    3, 10,
		-30000,  64,									-- hight
		-0.05, 0.05										-- perlin values
		)
end)--]]
