-- Node will be called <modname>slab_<subname>

function stairsplus.register_quater_slab(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--

	minetest.register_node(":".. modname .. ":slab_" .. subname .. "_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop .. "_quarter",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_node(":".. modname .. ":slab_" .. subname .. "_quarter_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop .. "_quarter_inverted",
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0.25, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_node(":".. modname .. ":slab_" .. subname .. "_three_quarter", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop .. "_three_quarter",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0.25, 0.5},
		},
		sounds = sounds,
	})

	minetest.register_node(":".. modname .. ":slab_" .. subname .. "_three_quarter_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		is_ground_content = false,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":slab_" .. drop .. "_three_quarter_inverted",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.25, -0.5, 0.5, 0.5, 0.5},
		},
		sounds = sounds,
	})

--
-- crafting
--

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 6",
		recipe = {
			{modname .. ":slab_" .. subname, modname .. ":slab_" .. subname, modname .. ":slab_" .. subname},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter_inverted 6",
		recipe = {
			{modname .. ":slab_" .. subname .. "_inverted", modname .. ":slab_" .. subname .. "_inverted", modname .. ":slab_" .. subname .. "_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_three_quarter_inverted",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
		},
	})

	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. " 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter"},
			{modname .. ":slab_" .. subname .. "_quarter"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_inverted 1",
		recipe = {
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
			{modname .. ":slab_" .. subname .. "_quarter_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":slab_" .. subname .. "_quarter 6",
		recipe = {
			{modname .. ":slab_" .. subname .. "_three_quarter"},
			{modname .. ":slab_" .. subname .. "_three_quarter"},
		},
	})

--
-- cooking
--

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":slab_stone_quarter",
		recipe = modname .. ":slab_stone_crumbled_quarter",
	})

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":slab_stone_quarter_inverted",
		recipe = modname .. ":slab_stone_crumbled_quarter_inverted",
	})

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":slab_stone_three_quarter",
		recipe = modname .. ":slab_stone_crumbled_three_quarter",
	})

	minetest.register_craft({
		type = "cooking",
		output = modname .. ":slab_stone_three_quarter_inverted",
		recipe = modname .. ":slab_stone_crumbled_three_quarter_inverted",
	})

end
