minetest.register_on_generated(function(minp, maxp, seed)
	if maxp.y <= 128 and minp.y >= -32 then
		-- Generate papyrus
		local perlin1 = minetest.get_perlin(354, 3, 0.7, 100)
		-- Assume X and Z lengths are equal
		local divlen = 8
		local divs = (maxp.x-minp.x)/divlen+1;
		for divx=0,divs-1 do
		for divz=0,divs-1 do
			local x0 = minp.x + math.floor((divx+0)*divlen)
			local z0 = minp.z + math.floor((divz+0)*divlen)
			local x1 = minp.x + math.floor((divx+1)*divlen)
			local z1 = minp.z + math.floor((divz+1)*divlen)
			-- Determine papyrus amount from perlin noise
			local papyrus_amount = math.floor(perlin1:get2d({x=x0, y=z0}) ^ 3 * 5 - 1)
			-- Find random positions for papyrus based on this random
			local pr = PseudoRandom(seed+1)
			for i=0,papyrus_amount do
				local x = pr:next(x0, x1)
				local z = pr:next(z0, z1)
				-- Find ground level (0...15)
				local ground_y = nil
				for y=maxp.y,minp.y,-1 do
					local nn = minetest.get_node({x=x,y=y,z=z}).name
					if nn ~= "air" and nn~= "ignore" then
						local is_leaves = minetest.registered_nodes[nn].groups.leaves
						if is_leaves == nil or is_leaves == 0 then
							ground_y = y
							break
						end
					end
				end
				if ground_y then
					local p = {x=x,y=ground_y,z=z}
					local n = minetest.get_node(p).name
					local p_above = {x=x,y=ground_y+1,z=z}
					local p_under = {x=x,y=ground_y-1,z=z}
					-- papyrus on grass
					if n == "default:dirt_with_grass" and
							minetest.find_node_near(p, 2, "default:water_source") then
						default.make_papyrus(p_above, pr:next(1, 5))
					-- papyrus roots
					elseif minetest.get_node(p_under).name == "default:dirt"
							and n == "default:water_source" then
						minetest.set_node(p, {name="default:papyrus_roots"})
						default.make_papyrus(p_above, pr:next(1, 5))
					end
				end
			end
		end
		end
--	end
	end
end)
