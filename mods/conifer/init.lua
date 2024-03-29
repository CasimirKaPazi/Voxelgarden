-- Load support for MT game translation.
local S = minetest.get_translator("conifer")

conifer = {}

minetest.register_alias("mapgen_pine_tree", "conifer:tree")
minetest.register_alias("mapgen_pine_needles", "conifer:leaves_1")

--
-- Nodes
--

minetest.register_node("conifer:sapling", {
	description = S("Conifer Sapling"),
	drawtype = "plantlike",
	tiles = {"conifer_sapling.png"},
	inventory_image = "conifer_sapling.png",
	wield_image = "conifer_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	on_timer = function(pos)
		conifer.grow_conifersapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, dig_immediate=3, sapling=1, flammable=2, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(600, 9600))
	end,
})

minetest.register_node("conifer:tree", {
	description = S("Conifer Tree"),
	tiles = {"conifer_tree_top.png", "conifer_tree_top.png", "conifer_tree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

for i=1,2 do
	minetest.register_node("conifer:leaves_"..i, {
		description = S("Conifer Leaves"),
		drawtype = "allfaces_optional",
		tiles = {"conifer_leaves_"..i..".png"},
		paramtype = "light",
		waving = 1,
		is_ground_content = false,
		trunk = "conifer:tree",
		groups = {
				snappy=3,
				leafdecay=4,
				flammable=2,
				leaves=1,
				fall_damage_add_percent=default.COUSHION
			},
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get sapling with 1/rarity chance
					items = {'conifer:sapling'},
					rarity = 40,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {"conifer:leaves_"..i..""},
				}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_alias("conifers:leaves", "conifer:leaves_1")
minetest.register_alias("conifers:leaves_special", "conifer:leaves_2")

minetest.register_node("conifer:tree_horizontal", {
	description = S("Conifer Tree"),
	tiles = {
		"conifer_tree.png", 
		"conifer_tree.png",
		"conifer_tree.png^[transformR90", 
		"conifer_tree.png^[transformR90", 
		"conifer_tree_top.png", 
		"conifer_tree_top.png" 
	},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree_horizontal=1, choppy=2, flammable=1},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		default.rotate_horizontal(pos)
	end,
})

--
-- Crafting definition
--

minetest.register_craft({
	output = 'conifer:tree_horizontal 2',
	recipe = {
		{'', 'conifer:tree'},
		{'conifer:tree', ''},
	}
})

minetest.register_craft({
	output = 'conifer:tree 2',
	recipe = {
		{'', 'conifer:tree_horizontal'},
		{'conifer:tree_horizontal', ''},
	}
})

dofile(minetest.get_modpath("conifer").."/trees.lua")
