local function register_mgv6_flower(name, seed)
	local seed = seed or 0
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.01,
			scale = 0.03,
			spread = {x = 10, y = 10, z = 10},
			seed = 436+seed,
			octaves = 3,
			persist = 0.5
		},
		y_min = 1,
		y_max = 300,
		decoration = "flowers:"..name,
	})
end

local function register_mgv6_mushroom(name, seed)
	local seed = seed or 0
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.04,
			spread = {x = 100, y = 100, z = 100},
			seed = 7133+seed,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 300,
		decoration = "flowers:"..name,
		spawn_by = "group:tree",
		num_spawn_by = 1,
	})
end

function flowers.register_mgv6_decorations()
	register_mgv6_flower("rose", 1)
	register_mgv6_flower("tulip", 2)
	register_mgv6_flower("dandelion_yellow", 3)
	register_mgv6_flower("geranium", 4)
	register_mgv6_flower("viola", 5)
	register_mgv6_flower("dandelion_white", 6)

	register_mgv6_mushroom("mushroom_brown", 1)
	register_mgv6_mushroom("mushroom_red", 2)
	-- TODO: Add waterlily
--	register_mgv6_waterlily()
end


--
-- Detect mapgen to select functions
--

-- TODO: Other mapgens
-- local mg_name = minetest.get_mapgen_setting("mg_name")
-- if mg_name == "v6" then
	flowers.register_mgv6_decorations()
-- else
-- 	flowers.register_decorations()
-- end
