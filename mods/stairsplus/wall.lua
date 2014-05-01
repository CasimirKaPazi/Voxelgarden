-- Node will be called <modname>wall_<subname>

function stairsplus.register_wall(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--

	minetest.register_node(modname .. ":wall_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":wall_" .. drop,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_alias(modname .. ":slab_" .. subname .. "_wall", modname .. ":wall_" .. subname)

--
-- crafting
--

	minetest.register_craft({
		output = modname .. ":wall_" .. subname .. " 6",
		recipe = {
			{recipeitem},
			{recipeitem},
			{recipeitem},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":wall_" .. subname, modname .. ":wall_" .. subname},
		},
	})

--
-- cooking
--

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":wall_stone",
		recipe = modname .. ":wall_cobble",
	})
end
