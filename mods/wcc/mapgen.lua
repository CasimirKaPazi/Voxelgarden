minetest.register_on_generated(function(minp, maxp, seed)
	local file = io.open(minetest.get_worldpath().."/wcc.txt", "r")
	if file then
		return
	end
	if maxp.y >= 2 and minp.y <= 0 then
	local pr = PseudoRandom(seed+1)
		local x = pr:next(minp.x, maxp.x)
		local z = pr:next(minp.z, maxp.z)
		-- Find ground level (0...15)
		local ground_y = nil
		for y=30,0,-1 do
			if minetest.env:get_node({x=x,y=y,z=z}).name ~= "air"
			and minetest.env:get_node({x=x,y=y,z=z}).name ~= "default:leaves" 
			and minetest.env:get_node({x=x,y=y,z=z}).name ~= "default:jungleleaves" then
				ground_y = y
				break
			end
		end
	
		if ground_y then
			local p = {x=x,y=ground_y+1,z=z}
			local nn = minetest.env:get_node(p).name
			local nn_ground = minetest.env:get_node({x=x,y=ground_y,z=z}).name
			-- Check if the node can be replaced
			if minetest.registered_nodes[nn] and
			minetest.registered_nodes[nn].buildable_to and
			minetest.registered_nodes[nn_ground].walkable and
			nn_ground ~= "ignore" then
				minetest.env:set_node(p,{name="wcc:wcc"})
				local file = io.open(minetest.get_worldpath().."/wcc.txt", "w")
				file:write(minetest.pos_to_string(p))
				file:close()
				print("[wcc] generated!")
			end
		end
	end
end)

