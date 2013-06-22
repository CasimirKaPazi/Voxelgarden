-- Node will be called <modname>micro_<subname>

function stairsplus.register_micro(modname, subname, recipeitem, groups, images, description, drop, sounds, sunlight)

--
-- nodes
--

	minetest.register_node(modname .. ":micro_" .. subname .. "_bottom", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":micro_" .. drop .. "_bottom",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0, 0, 0.5},
		},
		sounds = sounds,
	})
	
	minetest.register_node(modname .. ":micro_" .. subname .. "_top", {
		description = description,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		sunlight_propagates = sunlight,
		groups = groups,
		drop = modname .. ":micro_" .. drop .. "_top",
		node_box = {
			type = "fixed",
			fixed = {-0.5, 0, 0, 0, 0.5, 0.5},
		},
		sounds = sounds,
	})

--
-- crafting
--
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_bottom 8",
		recipe = {
			{"default:stick"},
			{recipeitem},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_top 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = modname .. ":micro_" .. subname .. "_bottom 1",
		recipe = {
			{modname .. ":micro_" .. subname .. "_top"},
		},
	})
	
	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":micro_" .. subname .. "_bottom", "", modname .. ":micro_" .. subname .. "_bottom"},
			{modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname .. "_bottom", modname .. ":micro_" .. subname .. "_bottom"},
		},
	})
	
	minetest.register_craft({
		output = recipeitem,
		recipe = {
			{modname .. ":micro_" .. subname .. "_top", modname .. ":micro_" .. subname .. "_top", modname .. ":micro_" .. subname .. "_top"},
			{modname .. ":micro_" .. subname .. "_top", "", modname .. ":micro_" .. subname .. "_top"},
			{modname .. ":micro_" .. subname .. "_top", modname .. ":micro_" .. subname .. "_top", modname .. ":micro_" .. subname .. "_top"},
		},
	})

--
-- cooking
--
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":micro_stone_bottom",
		recipe = modname .. ":micro_cobble_bottom",
	})
	
	minetest.register_craft({
		type = "cooking",
		output = modname .. ":micro_stone_top",
		recipe = modname .. ":micro_cobble_top",
	})
end
