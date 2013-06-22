-- Node will be called <modname>:corner_<subname>

function stairsplus.register_corner(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--
	
	minetest.register_node(modname .. ":corner_" .. subname, {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0, 0.5, 0},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_wall", modname .. ":corner_" .. subname)
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_half", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_half",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_wall_half", modname .. ":corner_" .. subname .. "_half")
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_half_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_half_inverted",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_wall_half_inverted", modname .. ":corner_" .. subname .. "_half_inverted")
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_inner", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_inner",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_inner", modname .. ":corner_" .. subname .. "_inner")
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_outer", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_outer",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0, 0.5, 0.5},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_outer", modname .. ":corner_" .. subname .. "_outer")
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_inner_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_inner_inverted",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0.5, 0, 0.5},
				{-0.5, -0.5, -0.5, 0, 0, 0},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_inner_inverted", modname .. ":corner_" .. subname .. "_inner_inverted")
	
	minetest.register_node(modname .. ":corner_" .. subname .. "_outer_inverted", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":corner_" .. drop .. "_outer_inverted",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
				{-0.5, -0.5, 0, 0, 0, 0.5},
			},
		},
		sounds = sounds,
	})
	
	minetest.register_alias(modname .. ":stair_" .. subname .. "_outer_inverted", modname .. ":corner_" .. subname .. "_outer_inverted")

--
-- crafting
--

	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. " 8",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{recipeitem, recipeitem, ""},
			{recipeitem, "", ""},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. " 8",
		recipe = {
			{recipeitem, recipeitem, recipeitem},
			{"", recipeitem, recipeitem},
			{"", "", recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_wall 2",
		recipe = {
			{modname .. ":corner_" .. subname, modname .. ":corner_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_wall 2",
		recipe = {
			{modname .. ":corner_" .. subname .. "_inverted", modname .. ":corner_" .. subname .. "_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":stair_" .. subname .. " 2",
		recipe = {
			{modname .. ":corner_" .. subname .. "_wall"},
			{modname .. ":corner_" .. subname .. "_wall"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_inner",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom", modname .. ":stair_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_inner",
		recipe = {
			{modname .. ":corner_" .. subname .. "_half"},
			{modname .. ":slab_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_inner_inverted",
		recipe = {
			{modname .. ":slab_" .. subname},
			{modname .. ":corner_" .. subname .. "_half"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_outer 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":slab_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_half 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":panel_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_inner_inverted",
		recipe = {
			{modname .. ":corner_" .. subname .. "_inner"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_outer_inverted",
		recipe = {
			{modname .. ":corner_" .. subname .. "_outer"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_inner",
		recipe = {
			{modname .. ":corner_" .. subname .. "_inner_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_outer",
		recipe = {
			{modname .. ":corner_" .. subname .. "_outer_inverted"},
		},
	})

	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_half 2",
		recipe = {
			{modname .. ":corner_" .. subname},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname,
		recipe = {
			{modname .. ":corner_" .. subname .. "_half"},
			{modname .. ":corner_" .. subname .. "_half"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname,
		recipe = {
			{modname .. ":corner_" .. subname .. "_half_inverted"},
			{modname .. ":corner_" .. subname .. "_half_inverted"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_half_inverted",
		recipe = {
			{modname .. ":corner_" .. subname .. "_half"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":corner_" .. subname .. "_half",
		recipe = {
			{modname .. ":corner_" .. subname .. "_half_inverted"},
		},
	})

--
-- cooking
--
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone",
		recipe = modname .. ":corner_cobble",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_half",
		recipe = modname .. ":corner_cobble_half",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_half_inverted",
		recipe = modname .. ":corner_cobble_half_inverted",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_inner",
		recipe = modname .. ":corner_cobble_inner",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_outer",
		recipe = modname .. ":corner_cobble_outer",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_inner_inverted",
		recipe = modname .. ":corner_cobble_inner_inverted",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":corner_stone_outer_inverted",
		recipe = modname .. ":corner_cobble_outer_inverted",
	})

end
