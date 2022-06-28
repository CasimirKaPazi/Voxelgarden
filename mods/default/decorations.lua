-- Decoration

-- Dirt type patches.
-- Must come before all decorations.
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 4,
	noise_params = {
		offset = -1.5,
		scale = -1.5,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 4,
		persist = 0.8
	},
	biomes = {"savanna"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dry_dirt",
	place_offset_y = -1,
	flags = "force_placement",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 4,
	noise_params = {
		offset = -1,
		scale = 1.5,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 4,
		persist = 0.8
	},
	biomes = {"gs-blend"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dry_dirt_with_dry_grass",
	place_offset_y = -1,
	flags = "force_placement",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 4,
	noise_params = {
		offset = -1,
		scale = 1.5,
		spread = {x = 200, y = 200, z = 200},
		seed = 329,
		octaves = 4,
		persist = 0.8
	},
	biomes = {"tc-blend"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dirt_with_snow",
	place_offset_y = -1,
	flags = "force_placement",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_snow"},
	sidelen = 4,
	noise_params = {
		offset = 0,
		scale = 2,
		spread = {x = 250, y = 250, z = 250},
		seed = 154,
		octaves = 2,
		persist = 2.00
	},
	biomes = {"conifer", "taiga", "tc-blend"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dirt_with_coniferous_litter",
	place_offset_y = -1,
	flags = "force_placement",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 4,
	noise_params = {
		offset = 0,
		scale = 1,
		spread = {x = 250, y = 250, z = 250},
		seed = 680,
		octaves = 1,
		persist = 1.00
	},
	biomes = {"rainforest", "deep_rainforest"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:dirt_with_rainforest_litter",
	place_offset_y = -1,
	flags = "force_placement",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:permafrost_with_stones"},
	sidelen = 4,
	noise_params = {
		offset = 0,
		scale = 0.8,
		spread = {x = 250, y = 250, z = 250},
		seed = 680,
		octaves = 1,
		persist = 1.00
	},
	biomes = {"permafrost"},
	y_max = 31000,
	y_min = 1,
	decoration = "default:permafrost_with_moss",
	place_offset_y = -1,
	flags = "force_placement",
})

for i = 1, 5 do
	minetest.register_decoration({
		name = "default:dry_grass_" .. i,
		deco_type = "simple",
		place_on = {"default:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.01,
			scale = 0.05,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"savanna", "gs-blend"},
		y_max = 31000,
		y_min = 1,
		decoration = "default:dry_grass_" .. i,
	})
end

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.020,
		spread = {x = 250, y = 250, z = 250},
		seed = 153,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"conifer", "tc-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_1.mts",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.010,
		spread = {x = 250, y = 250, z = 250},
		seed = 154,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"conifer", "tc-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_2.mts",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.01,
		scale = 0.010,
		spread = {x = 250, y = 250, z = 250},
		seed = 155,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"taiga", "tc-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/pine_tree.mts",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.018,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 538,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"forest", "grassland", "gs-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
	rotation = "random",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.00,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 539,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"forest", "grassland", "gs-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_apple_tree.mts",
	rotation = "random",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.003,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 570,
		octaves = 2,
		persist = 0.7
	},
	biomes = {"forest", "grassland"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/aspen_tree.mts",
	rotation = "random",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dry_dirt_with_dry_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.003,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 570,
		octaves = 2,
		persist = 0.7
	},
	biomes = {"savanna", "gs-blend"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/acacia_tree.mts",
	rotation = "random",
	y_min = 1,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = 0.02,
		scale = 0.030,
		spread = {x = 250, y = 250, z = 250},
		seed = 680,
		octaves = 2,
		persist = 0.66
	},
	biomes = {"rainforest", "deep_rainforest"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_jungletree.mts",
	rotation = "random",
	y_min = 1,
	y_max = 32000,
})

local chunksize = tonumber(minetest.get_mapgen_setting("chunksize"))
if chunksize >= 5 then
	minetest.register_decoration({
		name = "default:emergent_jungle_tree",
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
		sidelen = 80,
		noise_params = {
			offset = 0.0,
			scale = 0.0025,
			spread = {x = 250, y = 250, z = 250},
			seed = 690,
			octaves = 3,
			persist = 0.7
		},
		biomes = {"deep_rainforest"},
		y_max = 64,
		y_min = 1,
		schematic = minetest.get_modpath("default") ..
				"/schematics/emergent_jungle_tree.mts",
		flags = "place_center_x, place_center_z",
		rotation = "random",
		place_offset_y = -4,
	})
end

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter", "default:cactus"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"rainforest", "deep_rainforest"},
	decoration = {"default:junglegrass"},
	y_min = 1,
	y_max = 32000,
})

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
	y_max = 1,
	biomes = {"sea_dirt", "sea_sand", "sea_gravel"},
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
	y_max = 30000,
	biomes = {"forest", "rainforest", "deep_rainforest", "grassland", "savanna", "gs-blend"},
	decoration = "default:papyrus",
	height = 3,
	height_max = 5,
	spawn_by = "default:water_source",
	num_spawn_by = 1,
})

-- Cacti
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:sand", "default:dry_dirt"},
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
	biomes = {"sandstone_desert", "desert", "rocky_desert", "savanna", "sea_sand", "gs-blend"},
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
		biomes = {"conifer", "forest", "rainforest", "deep_rainforest"},
		decoration = "default:fern_" .. length,
	})
end

-- Dry shrubs
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:sand"},
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
	biomes = {"sandstone_desert", "desert"},
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
	biomes = {"sea_sand"},
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
	biomes = {"sea_sand"},
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
	biomes = {"sea_sand"},
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
	biomes = {"sea_dirt"},
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
		flags = "absvalue"
	},
	y_min = 1,
	y_max = 8,
	biomes = {"sea_sand"},
	decoration = {
		"default:marram_grass_1",
		"default:marram_grass_2",
		"default:marram_grass_3",
	},
})
