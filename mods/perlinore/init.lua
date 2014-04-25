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
	
	print ("[perlin_ore] chunk minp ("..minp.x.." "..minp.y.." "..minp.z..")")
	
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
				local pos={x=x, y=y, z=z}
				local node_name = minetest.get_node(pos).name
				local vi = a:index(x, y, z)
				if node_name == wherein and pr:next(1,inverse_chance) == 1 then
					data[vi] = c_ore
				else
					data[vi] = minetest.get_content_id(node_name)
				end
			end
			ni = ni + 1
	end
	end
	end

	vm:set_data(data)
	vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[perlin_ore] "..chugent.." ms")
end

if minetest.setting_getbool("perlin_ore") then
	minetest.register_on_generated(function(minp, maxp, seed)
		perlinore.generate_ore(
			minp, maxp, seed,
			"default:stone_with_coal", "default:stone",	-- name, wherein
			-20000, 64,							-- height_min, height_max
			6, 200, -0.02, 0.02						-- inverse chance, scale, noise_min, noise_max
		)
	end)
else
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "default:stone",
		clust_scarcity = 11*11*11,
		clust_num_ores = 8,
		clust_size     = 3,
		height_min     = -31000,
		height_max     = 64,
	})
end
