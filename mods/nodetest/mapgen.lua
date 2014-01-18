minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodetest:rock",
	wherein        = {"default:stone"},
	clust_scarcity = 6*6*6,
	clust_num_ores = 1,
	clust_size     = 3,
	height_min     = -64,
	height_max     = 1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "nodetest:rock",
	wherein        = {"default:dirt", "default:dirt_with_grass"},
	clust_scarcity = 30*30*30,
	clust_num_ores = 8,
	clust_size     = 8,
	height_min     = -64,
	height_max     = 1024,
})
