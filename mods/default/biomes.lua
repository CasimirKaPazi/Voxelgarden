minetest.clear_registered_biomes()
-- Below 0
minetest.register_biome({
	name = "Dirt",
	node_top = "default:dirt",			depth_top = 3,
	y_min = -32000,					y_max = 0,
	heat_point = 30,				humidity_point = 40,
})

minetest.register_biome({
	name = "Sand",
	node_top = "default:sand",			depth_top = 3,
	y_min = -32000,					y_max = 3,
	heat_point = 90,				humidity_point = 40,
})

minetest.register_biome({
	name = "Desert_Sand",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 3,
	y_min = -32000,					y_max = 3,
	heat_point = 100,				humidity_point = 10,
})

-- Over 0
-- Woods
minetest.register_biome({
	name = "Conifer",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 05,				humidity_point = 50,
})
-- Transition Conifer-Tree
minetest.register_biome({
	name = "CT",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	y_min = 1,					y_max = 32000,
	heat_point = 10,				humidity_point = 55,
})

minetest.register_biome({
	name = "Tree",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	y_min = 1,					y_max = 32000,
	heat_point = 50,				humidity_point = 60,
})
-- Transition Tree-Jungle
minetest.register_biome({
	name = "TJ",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	y_min = 1,					y_max = 32000,
	heat_point = 80,				humidity_point = 70,
})

minetest.register_biome({
	name = "Jungle",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	y_min = 1,					y_max = 32000,
	heat_point = 90,				humidity_point = 70,
})

-- Plains
minetest.register_biome({
	name = "Snow",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	node_water_top = "default:ice",			depth_water_top = 1,
	y_min = 1,					y_max = 32000,
	heat_point = 00,				humidity_point = 30,
})

minetest.register_biome({
	name = "Grass",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	y_min = 1,					y_max = 32000,
	heat_point = 50,				humidity_point = 20,
})

minetest.register_biome({
	name = "Desert",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 8,
	y_min = 1,					y_max = 32000,
	heat_point = 80,				humidity_point = 10,
})

-- Special Biomes
minetest.register_biome({
	name = "Gravel",
	node_top = "air",				depth_top = 1,
	node_filler = "default:gravel",			depth_filler = 1,
	y_min = 1,					y_max = 32000,
	heat_point = -20,				humidity_point = -20,
})

minetest.register_biome({
	name = "Glacier",
	node_top = "default:snowblock",			depth_top = 2,
	node_filler = "default:ice",			depth_filler = 5,
	node_water_top = "default:ice",			depth_water_top = 1,
	y_min = 1,					y_max = 32000,
	heat_point = -10,				humidity_point = 30,
})

-- Decoration

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.025,
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_1.mts",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.010,
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_2.mts",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.04,
	biomes = {"Conifer", "CT"},
	decoration = {"default:snow"},
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	fill_ratio = 0.035,
	biomes = {"Tree", "CT", "TJ"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
	y_min = 0,
	y_max = 32000,
})

--[[
for i=1,5 do
	minetest.register_decoration({
		deco_type = "simple",
		place_on = "default:dirt_with_grass",
		sidelen = 16,
		fill_ratio = 0.17,
		biomes = {"Laubwald"},
		decoration = {"default:grass_"..i},
		y_min = 0,
		y_max = 32000,
	})
end
--]]

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.045,
	biomes = {"Jungle", "TJ"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_jungletree.mts",
	y_min = 0,
	y_max = 32000,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:cactus"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"Jungle", "TJ"},
	decoration = {"default:junglegrass"},
	y_min = 0,
	y_max = 32000,
})
