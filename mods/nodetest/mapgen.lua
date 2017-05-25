minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:water_source"},
	sidelen = 16,
	noise_params = {
		offset = -0.45,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	y_min = 0,
	y_max = 64,
	schematic = minetest.get_modpath("nodetest") .. "/schematics/papyrus_with_roots.mts",
	spawn_by = "group:soil",
	num_spawn_by = 1,
	flags = "liquid_surface",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"group:soil"},
	sidelen = 16,
	noise_params = {
		offset = -0.35,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	y_min = 1,
	y_max = 300,
	decoration = "default:papyrus",
	height = 3,
	height_max = 5,
	spawn_by = "default:water_source",
	num_spawn_by = 1,
})
