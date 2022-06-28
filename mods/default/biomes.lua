--[[
List of Biomes:

underground

sea_dirt
sea_sand
sea_gravel

icesheet
taiga
conifer
forest
rainforest
deep_rainforest

tundra
snowy_grassland
grassland
savanna

cold_desert
gravel
sandstone_desert
desert
rocky_desert
--]]

-- below -256
minetest.register_biome({
	name = "underground",
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	node_cave_liquid = {"default:water_source", "default:lava_source"},
	y_min = -32000,
	y_max = -128,
	heat_point = 50,
	humidity_point = 50,
})

-- -128 to 0
minetest.register_biome({
	name = "sea_dirt",
	node_top = "default:dirt",
	depth_top = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_min = -127,
	y_max = 0,
	heat_point = 50,
	humidity_point = 55,
})

minetest.register_biome({
	name = "sea_sand",
	node_top = "default:sand",
	depth_top = 3,
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	node_dungeon = "default:sandstone",
	node_dungeon_stair = "stairsplus:stair_sandstone",
	y_min = -127,
	y_max = 8, -- create beaches
	heat_point = 100,
	humidity_point = 50,
})

minetest.register_biome({
	name = "sea_gravel",
	node_top = "default:gravel",
	depth_top = 3,
	node_filler = "default:stone",
	depth_filler = 3,
	node_riverbed = "default:gravel",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_min = -127,
	y_max = 5,
	heat_point = 30,
	humidity_point = -60,
})

-- Above 0
-- Forests

minetest.register_biome({
	name = "icesheet",
	node_top = "default:snowblock",
	depth_top = 2,
	node_stone = "default:ice",
	node_water_top = "default:ice",
	depth_water_top = 3,
	node_riverbed = "default:gravel",
	depth_riverbed = 2,
	node_river_water = "default:ice",
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = -25,
	humidity_point = 50,
})

minetest.register_biome({
	name = "taiga",
	node_top = "default:dirt_with_snow",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 2,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 0,
	humidity_point = 50,
})

minetest.register_biome({
	name = "tc-blend",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 2,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 10,
	humidity_point = 50,
})

minetest.register_biome({
	name = "conifer",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 2,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 25,
	humidity_point = 50,
})

minetest.register_biome({
	name = "forest",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "rainforest",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 80,
	humidity_point = 50,
})

minetest.register_biome({
	name = "deep_rainforest",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 100,
	humidity_point = 50,
})

-- Grasslands

minetest.register_biome({
	name = "tundra",
	node_top = "default:permafrost_with_stones",
	depth_top = 1,
	node_filler = "default:permafrost",
	depth_filler = 3,
	node_riverbed = "default:gravel",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 5,
	humidity_point = 20,
})

minetest.register_biome({
	name = "snowy_grassland",
	node_top = "default:dirt_with_snow",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 30,
	humidity_point = 20,
})

minetest.register_biome({
	name = "grassland",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 50,
	humidity_point = 20,
})

minetest.register_biome({
	name = "gs-blend",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 5,
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 70,
	humidity_point = 20,
})

minetest.register_biome({
	name = "savanna",
	node_top = "default:dry_dirt_with_dry_grass",
	depth_top = 1,
	node_filler = "default:dry_dirt",
	depth_filler = 5,
	node_stone = "default:desert_stone",
	node_riverbed = "default:dirt",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	y_max = 31000,
	y_min = 1,
	heat_point = 75,
	humidity_point = 20,
})

-- Deserts

minetest.register_biome({
	name = "cold_desert",
	node_top = "default:snowblock",
	node_filler = "default:sand",
	depth_filler = 3,
	node_riverbed = "default:gravel",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	depth_top = 1,
	y_max = 31000,
	y_min = 1,
	heat_point = 5,
	humidity_point = -10,
})

minetest.register_biome({
	name = "gravel",
	node_top = "default:gravel",
	node_filler = "default:gravel",
	depth_filler = 3,
	node_riverbed = "default:gravel",
	depth_riverbed = 2,
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairsplus:stair_cobble",
	depth_top = 1,
	y_max = 31000,
	y_min = 1,
	heat_point = 25,
	humidity_point = -25, -- squeze out gravel biomes to make them rare
})

minetest.register_biome({
	name = "sandstone_desert",
	node_top = "default:sand",
	depth_top = 2,
	node_stone = "default:sandstone",
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	node_dungeon = "default:sandstone",
	node_dungeon_stair = "stairsplus:stair_sandstone",
	y_max = 31000,
	y_min = 1,
	heat_point = 50,
	humidity_point = -10,
})

minetest.register_biome({
	name = "desert",
	node_top = "default:desert_sand",
	depth_top = 3,
	node_stone = "default:desert_stone",
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	node_dungeon = "default:sandstone",
	node_dungeon_stair = "stairsplus:stair_sandstone",
	y_max = 31000,
	y_min = 1,
	heat_point = 75,
	humidity_point = -10,
})

minetest.register_biome({
	name = "rocky_desert",
	node_top = "default:desert_stone",
	depth_top = 1,
	node_stone = "default:desert_stone",
	node_riverbed = "default:sand",
	depth_riverbed = 2,
	node_dungeon = "default:sandstone",
	node_dungeon_stair = "stairsplus:stair_sandstone",
	y_max = 31000,
	y_min = 1,
	heat_point = 95,
	humidity_point = -10,
})
