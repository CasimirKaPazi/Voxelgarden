minetest.clear_registered_biomes()

-- Below sea level
minetest.register_biome({
	name = "Dirt",
	node_top = "default:dirt",			depth_top = 3,
	node_filler = "default:stone",			depth_filler = 1,
	height_min = -31000,				height_max = 0,
	heat_point = 50,				humidity_point = 60,
})

minetest.register_biome({
	name = "Sand",
	node_top = "default:sand",			depth_top = 3,
	node_filler = "default:stone",			depth_filler = 1,
	height_min = -31000,				height_max = 3,
	heat_point = 90,				humidity_point = 50,
})

-- Over sea level
-- Woods

minetest.register_biome({
	name = "Conifer",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	height_min = 1,					height_max = 31000,
	heat_point = 10,				humidity_point = 60,
})
-- Transition Conifer-Tree
minetest.register_biome({
	name = "CT",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	height_min = 1,					height_max = 31000,
	heat_point = 20,				humidity_point = 65,
})

minetest.register_biome({
	name = "Tree",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	height_min = 1,					height_max = 31000,
	heat_point = 50,				humidity_point = 70,
})
-- Transition Tree-Jungle
minetest.register_biome({
	name = "TJ",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	height_min = 1,					height_max = 31000,
	heat_point = 80,				humidity_point = 80,
})

minetest.register_biome({
	name = "Jungle",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 4,
	height_min = 1,					height_max = 31000,
	heat_point = 90,				humidity_point = 80,
})

-- Plains
minetest.register_biome({
	name = "Snow",
	node_top = "default:dirt_with_snow",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 2,
	height_min = 1,					height_max = 31000,
	heat_point = 10,				humidity_point = 20,
})

minetest.register_biome({
	name = "Grass",
	node_top = "default:dirt_with_grass",		depth_top = 1,
	node_filler = "default:dirt",			depth_filler = 3,
	height_min = 1,					height_max = 31000,
	heat_point = 60,				humidity_point = 20,
})

minetest.register_biome({
	name = "Desert",
	node_top = "default:desert_sand",		depth_top = 3,
	node_filler = "default:desert_stone",		depth_filler = 5,
	height_min = 1,					height_max = 31000,
	heat_point = 90,				humidity_point = 20,
})

-- Special Biomes
minetest.register_biome({
	name = "Gravel",
	node_top = "air",				depth_top = 1,
	node_filler = "default:gravel",			depth_filler = 1,
	height_min = 1,					height_max = 31000,
	heat_point = -20,				humidity_point = -20,
})

minetest.register_biome({
	name = "Deep Snow",
	node_top = "default:snow_block",		depth_top = 3,
	node_filler = "default:dirt",			depth_filler = 1,
	height_min = 1,					height_max = 31000,
	heat_point = 00,				humidity_point = 30,
})

-- Decoration

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	fill_ratio = 0.035,
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_1.mts",
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	fill_ratio = 0.020,
	biomes = {"Conifer", "CT"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/conifer_conifertree_2.mts",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_snow", "default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	fill_ratio = 0.05,
	biomes = {"Conifer", "CT"},
	decoration = {"default:snow"},
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass", "default:dirt"},
	sidelen = 16,
	fill_ratio = 0.045,
	biomes = {"Tree", "CT", "TJ"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_tree.mts",
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
	})
end
--]]

minetest.register_decoration({
	deco_type = "schematic",
	place_on = "default:dirt_with_grass",
	sidelen = 16,
	fill_ratio = 0.055,
	biomes = {"Jungle", "TJ"},
	flags = "place_center_x, place_center_z",
	schematic = minetest.get_modpath("default").."/schematics/default_jungletree.mts",
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:cactus"},
	sidelen = 16,
	fill_ratio = 0.15,
	biomes = {"Jungle", "TJ"},
	decoration = {"default:junglegrass"},
})
