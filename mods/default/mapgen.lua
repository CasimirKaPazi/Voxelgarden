-- mods/default/mapgen.lua

--
-- Aliases for map generator outputs
--

minetest.register_alias("mapgen_air", "air")
minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_dirt_with_snow", "default:dirt_with_snow")
minetest.register_alias("mapgen_snow", "default:snow")
minetest.register_alias("mapgen_snowblock", "default:snowblock")
minetest.register_alias("mapgen_ice", "default:ice")

-- Flora
minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")

-- Dungeons
minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")
minetest.register_alias("mapgen_desert_sand", "default:desert_sand")
minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
minetest.register_alias("mapgen_stair_cobble", "stairsplus:stair_cobble")
minetest.register_alias("mapgen_sandstone", "default:sandstone")
minetest.register_alias("mapgen_sandstonebrick", "default:sandstone")
minetest.register_alias("mapgen_stair_sandstone", "stairsplus:stair_sandstone")

--
-- Ore generation
--

minetest.register_ore({
	ore_type       = "sheet",
	ore            = "air",
	wherein        = {"default:stone", "default:desert_stone"},
	column_height_min = 1,
	column_height_max = 12,
	column_midpoint_factor = 0.6,
	noise_params = {
	    offset  = -1.3,
	    scale   = 3,
	    spread  = {x=100, y=100, z=100},
	    seed    = 8565,
	    octaves = 1,
	    persist = 0.5,
	    flags = "eased",
	},
	noise_threshold = 1.6,
	y_min     = -31000,
	y_max     = 64,
})

minetest.register_ore({
	ore_type       = "sheet",
	ore            = "default:granite",
	wherein        = {"default:stone", "default:desert_stone"},
	column_height_min = 1,
	column_height_max = 8,
	column_midpoint_factor = 0.3,
	noise_params = {
	    offset  = -1.3,
	    scale   = 3,
	    spread  = {x=100, y=100, z=100},
	    seed    = 79533,
	    octaves = 3,
	    persist = 0.5,
	    flags = "eased",
	},
	noise_threshold = 1.6,
	y_min     = -31000,
	y_max     = 64,
})

minetest.register_ore({
	ore_type       = "sheet",
	ore            = "default:sandstone",
	wherein        = {"default:stone", "default:desert_stone"},
	column_height_min = 1,
	column_height_max = 10,
	column_midpoint_factor = 0.3,
	noise_params = {
	    offset  = -1.3,
	    scale   = 3,
	    spread  = {x=100, y=100, z=100},
	    seed    = 18953,
	    octaves = 3,
	    persist = 0.5,
	    flags = "eased",
	},
	noise_threshold = 1.6,
	y_min     = -31000,
	y_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:gravel",
	wherein        = {"default:dirt", "default:stone"},
	clust_scarcity = 16*16*16,
	clust_num_ores = 48,
	clust_size     = 4,
	y_max     = 31000,
	y_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:sand",
	wherein        = {"default:dirt", "default:stone"},
	clust_scarcity = 22*22*22,
	clust_num_ores = 48,
	clust_size     = 4,
	y_max     = 31000,
	y_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:ice",
	wherein        = {"default:stone"},
	clust_scarcity = 30*30*30,
	clust_num_ores = 96,
	clust_size     = 5,
	y_max     = -512,
	y_min     = -31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -127,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 23*23*23,
	clust_num_ores = 20,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:steelblock",
	wherein        = "default:stone",
	clust_scarcity = 27*27*27,
	clust_num_ores = 20,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -4096,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 23*23*23,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -511,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 20*20*20,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -512,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:mese",
	wherein        = "default:stone",
	clust_scarcity = 42*42*42,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min     = -127,
	y_max     = 1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -1023,
	y_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_tin",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -1023,
	y_max          = 1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_tin",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:copperblock",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -2048,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:tinblock",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -2048,
})

-- Gold

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 5,
	clust_size     = 3,
	y_max          = -256,
	y_min          = -31000,
})

-- Diamond

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = 31000,
	y_min          = 1025,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 4,
	clust_size     = 3,
	y_max          = -512,
	y_min          = -31000,
})

minetest.register_ore({
	ore_type       = "sheet",
	ore            = "default:coalblock",
	wherein        = {"default:stone"},
	column_height_min = 5,
	column_height_max = 10,
	column_midpoint_factor = 0.3,
	noise_params = {
	    offset  = -1.3,
	    scale   = 3,
	    spread  = {x=100, y=100, z=100},
	    seed    = 18953,
	    octaves = 3,
	    persist = 0.5,
	    flags = "eased",
	},
	noise_threshold = 1.6,
	y_min     = -31000,
	y_max     = -2048,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:sand",
	clust_scarcity = 20*20*20,
	clust_num_ores = 32,
	clust_size     = 6,
	y_max     = 0,
	y_min     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:dirt",
	clust_scarcity = 20*20*20,
	clust_num_ores = 32,
	clust_size     = 6,
	y_max     = 16,
	y_min     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_crumbled",
	wherein        = "default:stone",
	clust_scarcity = 6*6*6,
	clust_num_ores = 6,
	clust_size     = 4,
	y_min     = -31000,
	y_max     = 1024,
})
