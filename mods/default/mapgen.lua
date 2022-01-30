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

function default.make_papyrus(pos, size)
	for y=0,size-1 do
		local p = {x=pos.x, y=pos.y+y, z=pos.z}
		local nn = minetest.get_node(p).name
		if minetest.registered_nodes[nn] and
			minetest.registered_nodes[nn].buildable_to then
			minetest.set_node(p, {name="default:papyrus"})
		else
			return
		end
	end
end

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

function default.register_mgv6_decorations()
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
			place_on = {"default:dirt_with_grass"},
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
end

default.register_mgv6_decorations()
