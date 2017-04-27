-- mods/default/mapgen.lua

--
-- Aliases for map generator outputs
--

minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:water_source")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_dirt_with_snow", "default:dirt_with_snow")
minetest.register_alias("mapgen_snow", "default:snow")
minetest.register_alias("mapgen_snowblock", "default:snowblock")
minetest.register_alias("mapgen_ice", "default:ice")

-- Flora
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")

-- Dungeons
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")
minetest.register_alias("mapgen_desert_sand", "default:desert_sand")
minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
minetest.register_alias("mapgen_stair_cobble", "stairsplus:stair_cobble")
minetest.register_alias("mapgen_sandstone", "default:sandstone")
minetest.register_alias("mapgen_sandstonebrick", "default:sandstone")
minetest.register_alias("mapgen_stair_sandstone", "stairsplus:stair_sandstone")

--
-- Ore generation
--
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -63,
	y_max     = -32,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 25*25*25,
	clust_num_ores = 27,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 25*25*25,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -255,
	y_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 20*20*20,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:mese",
	wherein        = "default:stone",
	clust_scarcity = 42*42*42,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -63,
	y_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -1024,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 32,
	clust_size     = 4,
	y_min     = -4096,
	y_max     = -2048,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:sand",
	clust_scarcity = 20*20*20,
	clust_num_ores = 32,
	clust_size     = 6,
	y_max     = 0,
	y_min     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:dirt",
	clust_scarcity = 20*20*20,
	clust_num_ores = 32,
	clust_size     = 6,
	y_max     = 16,
	y_min     = -10,
})

function default.make_papyrus(pos, size)
	for y=0,size-1 do
		local p = {x=pos.x, y=pos.y+y, z=pos.z}
		local nn = minetest.get_node(p).name
		if minetest.registered_nodes[nn] and
			minetest.registered_nodes[nn].buildable_to then
			minetest.set_node(p, {name="default:papyrus"})
		else
			return
		end
	end
end

function default.make_cactus(pos, size)
	for y=0,size-1 do
		local p = {x=pos.x, y=pos.y+y, z=pos.z}
		local nn = minetest.get_node(p).name
		if minetest.registered_nodes[nn] and
			minetest.registered_nodes[nn].buildable_to then
			minetest.set_node(p, {name="default:cactus"})
		else
			return
		end
	end
end

-- facedir: 0/1/2/3 (head node facedir value)
-- length: length of rainbow tail
function default.make_nyancat(pos, facedir, length)
	local tailvec = {x=0, y=0, z=0}
	if facedir == 0 then
		tailvec.z = 1
	elseif facedir == 1 then
		tailvec.x = 1
	elseif facedir == 2 then
		tailvec.z = -1
	elseif facedir == 3 then
		tailvec.x = -1
	else
		print("default.make_nyancat(): Invalid facedir: "+dump(facedir))
		facedir = 0
		tailvec.z = 1
	end
	local p = {x=pos.x, y=pos.y, z=pos.z}
	minetest.set_node(p, {name="default:nyancat", param2=facedir})
	for i=1,length do
		p.x = p.x + tailvec.x
		p.z = p.z + tailvec.z
		minetest.set_node(p, {name="default:nyancat_rainbow", param2=facedir})
	end
end

function generate_nyancats(seed, minp, maxp)
	local y_min = -31000
	local y_max = 31000
	if maxp.y < y_min or minp.y > y_max then
		return
	end
	local y_min = math.max(minp.y, y_min)
	local y_max = math.min(maxp.y, y_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed + 9324342)
	local max_num_nyancats = math.floor(volume / (16*16*16))
	for i=1,max_num_nyancats do
		if pr:next(0, 4000) == 0 then
			local x0 = pr:next(minp.x, maxp.x)
			local y0 = pr:next(minp.y, maxp.y)
			local z0 = pr:next(minp.z, maxp.z)
			local p0 = {x=x0, y=y0, z=z0}
			default.make_nyancat(p0, pr:next(0,3), pr:next(3,15))
		end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)

	-- Generate nyan rats
	generate_nyancats(seed, minp, maxp)
	
	if maxp.y <= 128 and minp.y >= -32 then
		-- Generate cactuses
		local perlin1 = minetest.get_perlin(230, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0, divs-1 do
		for divz=0, divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine cactus amount from perlin noise
			local cactus_amount = math.floor(perlin1:get2d({x=x0, y=z0}) * 5 - 3)
			-- Find random positions for cactus based on this random
			local pr = PseudoRandom(seed % 8000)
			for i=0, cactus_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=maxp.y, minp.y, -1 do
					local nn = minetest.get_node({x=x, y=y, z=z}).name
					if nn ~= "air" and nn~= "ignore" then
						local is_leaves = minetest.registered_nodes[nn].groups.leaves
						if is_leaves == nil or is_leaves == 0 then
							ground_y = y
							break
						end
					end
				end
				-- If desert sand, make cactus
				if ground_y then
					local ground_node = minetest.get_node({x=x, y=ground_y, z=z}).name
					if ground_node == "default:desert_sand" or ground_node == "default:sand" then
						default.make_cactus({x=x, y=ground_y+1, z=z}, pr:next(3, 4))
					end
				end
			end
		end
		end
		-- Generate grass
		local perlin1 = minetest.get_perlin(329, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0, divs-1 do
		for divz=0, divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine grass amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 13)
			-- Find random positions for grass based on this random
			local pr = PseudoRandom(seed+1)
			for i=0, grass_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=maxp.y, minp.y, -1 do
					local nn = minetest.get_node({x=x, y=y, z=z}).name
					if nn ~= "air" and nn~= "ignore" then
						local is_leaves = minetest.registered_nodes[nn].groups.leaves
						if is_leaves == nil or is_leaves == 0 then
							ground_y = y
							break
						end
					end
				end
				
				if ground_y then
					local p = {x=x, y=ground_y+1, z=z}
					local nn = minetest.get_node(p).name
					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and
						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x, y=ground_y, z=z}).name
						-- If dirt with grass, add grass
						if nn == "default:dirt_with_grass" then
							minetest.set_node(p, {name="default:grass_"..pr:next(1, 5)})
						
						-- If jungletree, add junglegrass
						elseif nn == "default:jungletree" then
							minetest.set_node(p, {name="default:junglegrass"})
						elseif nn == "default:cactus" then
							minetest.set_node(p, {name="default:junglegrass"})
						end
					end
				end
				
			end
		end
		end
		-- Generate dry shrub
		local perlin1 = minetest.get_perlin(329, 3, 0.6, 100)
		-- Assume X and Z lengths are equal
		local divlen = 16
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0, divs-1 do
		for divz=0, divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine grass amount from perlin noise
			local grass_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3)
			-- Find random positions for grass based on this random
			local pr = PseudoRandom(seed % 8000)
			for i=0, grass_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=maxp.y, minp.y, -1 do
					local nn = minetest.get_node({x=x, y=y, z=z}).name
					if nn ~= "air" and nn~= "ignore" then
						local is_leaves = minetest.registered_nodes[nn].groups.leaves
						if is_leaves == nil or is_leaves == 0 then
							ground_y = y
							break
						end
					end
				end
				
				if ground_y then
					local p = {x=x, y=ground_y+1, z=z}
					local nn = minetest.get_node(p).name
					-- Check if the node can be replaced
					if minetest.registered_nodes[nn] and
						minetest.registered_nodes[nn].buildable_to then
						nn = minetest.get_node({x=x, y=ground_y, z=z}).name
						-- If desert sand, add dry shrub
						if nn == "default:desert_sand" then
							minetest.set_node(p,{name="default:dry_shrub"})
						end
					end
				end
				
			end
		end
		end
	end
end)

