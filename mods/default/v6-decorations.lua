minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:water_source"},
	sidelen = 16,
	noise_params = {
		offset = -0.4,
		scale = 0.7,
		spread = {x = 200, y = 200, z = 200},
		seed = 354,
		octaves = 3,
		persist = 0.7
	},
	y_min = 0,
	y_max = 64,
	schematic = minetest.get_modpath("default") .. "/schematics/papyrus_with_roots.mts",
	spawn_by = "group:soil",
	num_spawn_by = 1,
	flags = "liquid_surface",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"group:soil"},
	sidelen = 16,
	noise_params = {
		offset = -0.3,
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

	-- Cacti
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x = 100, y = 100, z = 100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 300,
		decoration = "default:cactus",
		height = 3,
		height_max = 5,
	})

	-- Long grasses
	for length = 1, 5 do
		minetest.register_decoration({
			deco_type = "simple",
			place_on = {"default:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.06,
				spread = {x = 100, y = 100, z = 100},
				seed = 329,
				octaves = 3,
				persist = 0.8
			},
			y_min = 1,
			y_max = 300,
			decoration = "default:grass_"..length,
		})
	end

	-- Ferns
	for length = 1, 3 do
		minetest.register_decoration({
			deco_type = "simple",
			place_on = {"default:dirt_with_grass", "default:dirt_with_coniferous_litter", "default:dirt_with_rainforest_litter"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.04,
				spread = {x = 100, y = 100, z = 100},
				seed = 800+length,
				octaves = 3,
				persist = 0.65
			},
			y_min = 6,
			y_max = 31000,
			decoration = "default:fern_" .. length,
		})
	end

	-- Dry shrubs
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 300,
		decoration = "default:dry_shrub",
	})

	-- Corals
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.5,
			scale = 0.60,
			spread = {x = 100, y = 100, z = 100},
			seed = 7013,
			octaves = 3,
			persist = 0.1,
		},
		y_min = -64,
		y_max = -2,
		decoration = "default:coral_brown",
		height = 1,
		height_max = 2,
		flags = "force_placement",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.5,
			scale = 0.64,
			spread = {x = 100, y = 100, z = 100},
			seed = 7013,
			octaves = 3,
			persist = 0.1,
		},
		y_min = -64,
		y_max = -2,
		decoration = "default:coral_orange",
		height = 1,
		height_max = 2,
		flags = "force_placement",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.5,
			scale = 0.63,
			spread = {x = 100, y = 100, z = 100},
			seed = 7013,
			octaves = 3,
			persist = 0.1,
		},
		y_min = -64,
		y_max = -2,
		decoration = "default:coral_purple",
		height = 1,
		height_max = 2,
		flags = "force_placement",
	})

	-- Seaweed
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt"},
		-- Same params as grass.
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.06,
			spread = {x = 100, y = 100, z = 100},
			seed = 329,
			octaves = 3,
			persist = 0.8
		},
		y_min = -64,
		y_max = -2,
		-- We use a schematic to replace the dirt.
		schematic = {
			size = {x = 1, y = 1, z = 1},
			data = { {name = "default:seaweed"} },
		},
		flags = "force_placement",
	})

	minetest.register_decoration({
		name = "default:marram_grass",
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 4,
		noise_params = {
			offset = -0.7,
			scale = 4.0,
			spread = {x = 16, y = 16, z = 16},
			seed = 513337,
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
		y_max = 6,
		y_min = 4,
		decoration = {
			"default:marram_grass_1",
			"default:marram_grass_2",
			"default:marram_grass_3",
		},
	})
