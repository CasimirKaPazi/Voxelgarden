

-- TODO: remake schematics/*.mts files and remove aliases:
minetest.register_alias("base:jungletree", "default:jungletree")
minetest.register_alias("base:leaves", "default:leaves")
minetest.register_alias("base:dirt", "default:dirt")
minetest.register_alias("base:tree", "default:tree")
minetest.register_alias("base:sand", "default:sand")
minetest.register_alias("base:stone", "default:stone")


minetest.register_biome({
	name           = "default_normal",
	
	height_min     = 3,
	height_max     = 40,
	heat_point     = 40.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "default_forest",
	
	height_min     = 3,
	height_max     = 40,
	heat_point     = 40.0,
	humidity_point = 55.0,
})

minetest.register_biome({
	name           = "default_jungle",
	
	height_min     = 3,
	height_max     = 40,
	heat_point     = 60.0,
	humidity_point = 70.0,
})

minetest.register_biome({
	name           = "default_firforest",
	
	height_min     = 3,
	height_max     = 40,
	heat_point     = 20.0,
	humidity_point = 55.0,
})

minetest.register_biome({
	name           = "default_highland",
	
	height_min     = 41,
	height_max     = 31000,
	heat_point     = 40.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "default_ocean_sand",
	
	node_top       = "base:sand",
	depth_top      = 3,
	node_filler    = "base:stone",
	depth_filler   = 0,
	
	height_min     = -31000,
	height_max     = 2,
	heat_point     = 40.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "default_ocean_dirt",
	
	height_min     = -31000,
	height_max     = 2,
	heat_point     = 20.0,
	humidity_point = 40.0,
})

minetest.register_biome({
	name           = "default_desert",
	
	node_top       = "base:sand",
	depth_top      = 20,
	node_filler    = "base:stone",
	
	height_min     = 3,
	height_max     = 80,
	heat_point     = 90.0,
	humidity_point = 0.0,
})



minetest.register_biome({
	name           = "Ocean",

	node_top       = "default:sand",
	depth_top      = 3,
	node_filler    = "default:stone",
	depth_filler   = 0,

	height_min     = -31000,
	height_max     = 0,
	heat_point     = 40.0,
	humidity_point = 40.0
})

minetest.register_biome({
	name           = "Gravel Ocean",

	node_top       = "default:gravel",
	depth_top      = 3,
	node_filler    = "default:stone",
	depth_filler   = 0,

	node_dust_water = "default:ice",

	height_min     = -31000,
	height_max     = 0,
	heat_point     = -10.0,
	humidity_point = 60.0
})

minetest.register_biome({
	name           = "Beach",

	node_top       = "default:sand",
	depth_top      = 3,
	node_filler    = "default:sandstone",
	depth_filler   = 3,

	height_min     = 1,
	height_max     = 3,
	heat_point     = 50.0,
	humidity_point = 10.0
})

minetest.register_biome({
	name           = "Gravel Beach",

	node_top       = "default:gravel",
	depth_top      = 2,
	node_filler    = "default:stone",
	depth_filler  = 0,

	node_dust      = "default:snow",
	node_dust_water = "default:ice",

	height_min     = 1,
	height_max     = 3,
	heat_point     = -10.0,
	humidity_point = 60.0
})


minetest.register_biome({
	name           = "Snow Plains",

	node_dust      = "default:snow",
	node_dust_water = "default:ice",

	height_min     = 1,
	height_max     = 20,
	heat_point     = -10.0,
	humidity_point = 50.0
})

minetest.register_biome({
	name           = "Plains",

	height_min     = 1,
	height_max     = 20,
	heat_point     = 40.0,
	humidity_point = 50.0
})

minetest.register_biome({
	name           = "Hills",

	height_min     = 21,
	height_max     = 40,
	heat_point     = 40.0,
	humidity_point = 50.0
})

minetest.register_biome({
	name           = "Snow Hills",

	node_dust      = "default:snow",
	node_dust_water = "default:ice",

	height_min     = 21,
	height_max     = 300,
	heat_point     = -10.0,
	humidity_point = 50.0
})

minetest.register_biome({
	name           = "Extreme Hills",

	height_min     = 41,
	height_max     = 300,
	heat_point     = 40.0,
	humidity_point = 50.0
})

minetest.register_biome({
	name           = "Desert",

	node_top       = "default:desert_sand",
	depth_top      = 3,
	node_filler    = "default:desert_stone",
	depth_filler   = 10,

	height_min     = 3,
	height_max     = 15,
	heat_point     = 90.0,
	humidity_point = 0.0
})


--trees
--[[ TODO
minetest.register_decoration({
	deco_type = "schematic",
	place_on  = "default:dirt_with_grass",
	sidelen   = 8,
	schematic = "treewprob.mts",
	flags     = "place_center_x, place_center_z",
	noise_params = {
		offset  = 1/120,
		scale   = 0.04,
		spread  = {x=125, y=125, z=125},
		seed    = 2,
		octaves = 4,
		persist = 0.66
	}
})
]]

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.005,
	biomes = {"default_normal"},
	schematic = minetest.get_modpath("default").."/schematics/base_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 8,
	fill_ratio = 0.1,
	biomes = {"default_forest"},
	schematic = minetest.get_modpath("default").."/schematics/base_tree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 8,
	fill_ratio = 0.2,
	biomes = {"default_jungle"},
	schematic = minetest.get_modpath("default").."/schematics/base_jungletree.mts",
	flags = "place_center_x, place_center_z",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"default_firforest"},
	schematic = minetest.get_modpath("default").."/schematics/base_fir.mts",
	flags = "place_center_x, place_center_z",
})

--papyrus
minetest.register_decoration({
	deco_type  = "simple",
	place_on   = "default:dirt_with_grass",
	sidelen    = 8,
	decoration = "default:papyrus",
	height     = 2,
	height_max = 4,
	noise_params = {
		offset  = 0,
		scale   = 0.3,
		spread  = {x=100, y=100, z=100},
		seed    = 354,
		octaves = 3,
		persist = 0.7
	},
	spawn_by = "default:water_source",
	num_spawn_by = 1
})

--cactuses
minetest.register_decoration({
	deco_type  = "simple",
	place_on   = "default:desert_sand",
	sidelen    = 4,
	decoration = "default:cactus",
	height     = 3,
	height_max = 4,
	noise_params = {
		offset  = 0,
		scale   = 1 / 25,
		spread  = {x=100, y=100, z=100},
		seed    = 230,
		octaves = 3,
		persist = 0.6
	}
})

--grass
minetest.register_decoration({
	deco_type  = "simple",
	place_on   = "default:dirt_with_grass",
	sidelen    = 4,
	decoration = {
		"default:grass_1",
		"default:grass_2",
		"default:grass_3",
		"default:grass_4",
		"default:grass_5"
	},
	height      = 1,
	noise_params = {
		offset  = 1 / 4,
		scale   = 1 / 6, -- originally ^3 as well...
		spread  = {x=100, y=100, z=100},
		seed    = 329,
		octaves = 3,
		persist = 0.6
	}
})

--desert shrubs
minetest.register_decoration({
	deco_type  = "simple",
	place_on   = "default:desert_sand",
	sidelen     = 4,
	decoration = "default:dry_shrub",
	height     = 1,
	noise_params = {
		offset  = 0,
		scale   = 1 / 12, -- originally ^3 as well...
		spread  = {x=100, y=100, z=100},
		seed    = 329,
		octaves = 3,
		persist = 0.6
	}
})
