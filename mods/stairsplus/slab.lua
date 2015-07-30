-- Node will be called <modname>slab_<subname>

function stairsplus.register_slab(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--

	minetest.register_node(":".. modname .. ":slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_node(":stairs:slab_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = ":stairs:slab_" .. drop,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_node(":".. modname .. ":slab_" .. subname .. "_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop .. "_inverted",
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})
--
-- crafting
--

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. " 6",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. " 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_inverted"},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname},
			{modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname .. "_inverted"},
			{modname .. ":slab_" .. subname .. "_inverted"},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname},
			{modname .. ":slab_" .. subname},
		},
	})

--
-- cooking
--

	minetest.register_craft({
		type = "cooking",
		output = ":stairs:slab_stone",
		recipe = ":stairs:slab_cobble",
	})

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":slab_stone_inverted",
		recipe = modname .. ":slab_cobble_inverted",
	})

end
