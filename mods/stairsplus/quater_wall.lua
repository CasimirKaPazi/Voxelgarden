-- Node will be called <modname>wall_<subname>

function stairsplus.register_quater_wall(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--

	minetest.register_node(":".. modname .. ":wall_" .. subname .. "_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":wall_" .. drop .. "_quarter",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0.25, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_alias(modname .. ":slab_" .. subname .. "_quarter_wall", modname .. ":wall_" .. subname .. "_quarter")

	minetest.register_node(":".. modname .. ":wall_" .. subname .. "_three_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":wall_" .. drop .. "_three_quarter",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.25, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_alias(modname .. ":slab_" .. subname .. "_three_quarter_wall", modname .. ":wall_" .. subname .. "_three_quarter")

--
-- crafting
--

	minetest.register_craft({
		output = modname .. ":wall_" .. subname .. "_quarter 6",
		recipe = {
			{modname .. ":wall_" .. subname},
			{modname .. ":wall_" .. subname},
			{modname .. ":wall_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":wall_" .. subname .. "_three_quarter 1",
		recipe = {
			{modname .. ":wall_" .. subname .. "_quarter", modname .. ":wall_" .. subname .. "_quarter", modname .. ":wall_" .. subname .. "_quarter"},
		},
	})

--
-- cooking
--

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":wall_stone_quarter",
		recipe = modname .. ":wall_cobble_quarter",
	})

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":wall_stone_three_quarter",
		recipe = modname .. ":wall_cobble_three_quarter",
	})
end
