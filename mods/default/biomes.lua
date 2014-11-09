-- Biomes for mapgen v7 and v5

minetest.register_biome({
	name = "forest",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	height_min = 2,					height_max =50,
	heat_point = 50,				humidity_point = 80,
})

minetest.register_biome({
	name = "meadow",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	height_min = 2,					height_max = 60,
	heat_point = 50,				humidity_point = 30,
})

minetest.register_biome({
	name = "beach",
	node_top = "default:sand",			depth_top = 2,
	height_min = -500,				height_max = 2,
	heat_point = 40,				humidity_point = 50,
})

minetest.register_biome({
	name = "seafloor",
	node_top = "default:dirt",			depth_top = 2,
	height_min = -500,				height_max = 0,
	heat_point = 10,				humidity_point = 30,
})

minetest.register_biome({
	name = "seafloor-coast",
	node_top = "default:dirt_with_grass",			depth_top = 2,
	height_min = 0,					height_max = 2,
	heat_point = 10,				humidity_point = 30,
})

minetest.register_biome({
	name = "tropical_beach",
	node_top = "default:sand",			depth_top = 5,
	height_min = -500, 				height_max = 3,
	heat_point = 90.0,				humidity_point = 50,
})

minetest.register_biome({
	name = "jungle",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	height_min = 2,					height_max = 60,
	heat_point = 85,				humidity_point = 80,
})

minetest.register_biome({
	name = "desert",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 57,
	height_min = 2,					height_max = 60,
	heat_point = 90,				humidity_point = 20,
})

minetest.register_biome({
	name = "mountain",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 1,
	height_min = 61,				height_max = 80,
							humidity_point = 80,
})

minetest.register_biome({
	name = "alpine",
	node_top = "default:snowblock",			depth_top = 1,
	node_filler = "default:dirt_with_snow",		depth_filler = 1,
	height_min = 81,				height_max = 128,
							humidity_point = 50,
})

minetest.register_biome({
	name = "peak",
	node_top = "default:snow",			depth_top = 1,
	node_filler = "default:snowblock",		depth_filler = 2,
	height_min = 129,				height_max = 300,
							humidity_point = 30,
})

minetest.register_biome({
	name = "prairie",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	height_min = 10,				height_max = 60,
	heat_point = 40,				humidity_point = 20,
})

minetest.register_biome({
	name = "papyrus",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	height_min = 1,					height_max = 1,
	heat_point = 60,				humidity_point = 50,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.037,
	biomes = {"forest"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 80,
	fill_ratio = 0.003,
	biomes = {"meadow"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.057,
	biomes = {"jungle"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_jungletree.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.047,
	biomes = {"mountain"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_1.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.037,
	biomes = {"mountain"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_2.mts",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.17,
	biomes = {"jungle"},
	decoration = {"default:junglegrass"},
})
