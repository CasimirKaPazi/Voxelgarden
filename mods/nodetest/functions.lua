--
-- Papyrus growing
--

minetest.register_abm({
	nodenames = {"nodetest:papyrus_roots"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="default:papyrus"})
		end
	end,
})

--
-- Turn seedling to flower
--

minetest.register_abm({
	nodenames = {"nodetest:seedling"},
	interval = 11,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		if (minetest.get_node_light(above) or 0) >= 11 then
			local flower_choice = math.random(1, 7)
			local flower
			if flower_choice == 1 then
				flower = "flowers:tulip"
			elseif flower_choice == 2 then
				flower = "flowers:rose"
			elseif flower_choice == 3 then
				flower = "flowers:viola"
			elseif flower_choice == 4 then
				flower = "flowers:geranium"
			elseif flower_choice == 5 then
				flower = "flowers:dandelion_white"
			elseif flower_choice == 6 then
				flower = "flowers:dandelion_yellow"
			elseif flower_choice == 7 then
				flower = "air"
			end
			minetest.set_node(pos, {name=flower})
		end
	end
})
