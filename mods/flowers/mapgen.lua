local function register_mgv6_flower(name)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.006,
			spread = {x = 100, y = 100, z = 100},
			seed = 436,
			octaves = 3,
			persist = 0.5
		},
		y_min = 1,
		y_max = 300,
		decoration = "flowers:"..name,
	})
end

local function register_mgv6_mushroom(name)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.04,
			spread = {x = 100, y = 100, z = 100},
			seed = 7133,
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
	register_mgv6_flower("rose")
	register_mgv6_flower("tulip")
	register_mgv6_flower("dandelion_yellow")
	register_mgv6_flower("geranium")
	register_mgv6_flower("viola")
	register_mgv6_flower("dandelion_white")

	register_mgv6_mushroom("mushroom_brown")
	register_mgv6_mushroom("mushroom_red")
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
