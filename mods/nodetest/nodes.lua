-- mods/default/nodes.lua

--
-- Node definitions
--

minetest.register_node("nodetest:desert_sandstone", {
	description = "Desert Sandstone",
	tiles = {"nodetest_desert_sandstone.png"},
	is_ground_content = true,
	melt = "default:lava_source",
	groups = {crumbly=2, cracky=2, melt=3000},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_alias("default:desertsandstone", "nodetest:desert_sandstone")
minetest.register_alias("default:desert_sandstone", "nodetest:desert_sandstone")

minetest.register_node("nodetest:rock", {
	description = "Rock",
	tiles = {"nodetest_rock.png"},
	inventory_image = "nodetest_rock_item.png",
	wield_image = "nodetest_rock_item.png",
	is_ground_content = true,
	melt = "default:lava_flowing",
	groups = {cracky=3, stone=2, oddly_breakable_by_hand=1, melt=2900},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("nodetest:tree_horizontal", {
	description = "Tree",
	tiles = {
		"default_tree.png", 
		"default_tree.png",
		"default_tree.png^[transformR90", 
		"default_tree.png^[transformR90", 
		"default_tree_top.png", 
		"default_tree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("default:tree_horizontal", "nodetest:tree_horizontal")

minetest.register_node("nodetest:jungletree_horizontal", {
	description = "Jungle Tree",
		tiles = {
		"default_jungletree.png", 
		"default_jungletree.png",
		"default_jungletree.png^[transformR90", 
		"default_jungletree.png^[transformR90", 
		"default_jungletree_top.png", 
		"default_jungletree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("default:jungletree_horizontal", "nodetest:jungletree_horizontal")

minetest.register_node("nodetest:papyrus_roots", {
	description = "Papyrus Roots",
	tiles = {"nodetest_papyrus_roots.png"},
	paramtype = "light",
	is_ground_content = true,
	liquids_pointable = true,
	after_dig_node = function(pos, node, metadata, digger)
			node.name = "default:papyrus"
			default.dig_up(pos, node, digger)
		end,
	groups = {snappy=3,flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("default:papyrus_roots", "nodetest:papyrus_roots")

-- Conifers

minetest.register_node("nodetest:conifersapling", {
	description = "Conifer Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"nodetest_conifersapling.png"},
	inventory_image = "nodetest_conifersapling.png",
	wield_image = "nodetest_conifersapling.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, dig_immediate=3, sapling=1, flammable=2, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("conifers:sapling", "nodetest:conifersapling")

minetest.register_node("nodetest:conifertree", {
	description = "Conifer Tree",
	tiles = {"nodetest_conifertree_top.png", "nodetest_conifertree_top.png", "nodetest_conifertree.png"},
	groups = {tree=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("conifers:trunk", "nodetest:conifertree")

minetest.register_node("nodetest:coniferleaves_1", {
	description = "Conifer Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"nodetest_coniferleaves_1.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=4, flammable=2, leaves=1, fall_damage_add_percent=COUSHION},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'nodetest:conifersapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'nodetest:coniferleaves_1'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("conifers:leaves", "nodetest:coniferleaves_1")

minetest.register_node("nodetest:coniferleaves_2", {
	description = "Conifer Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"nodetest_coniferleaves_2.png"},
	paramtype = "light",
	waving = 1,
	groups = {snappy=3, leafdecay=4, flammable=2, leaves=1, fall_damage_add_percent=COUSHION},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'nodetest:conifersapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'nodetest:coniferleaves_2'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("conifers:leaves_special", "nodetest:coniferleaves_2")

minetest.register_node("nodetest:conifertree_horizontal", {
	description = "Conifer Tree",
	tiles = {
		"nodetest_conifertree.png", 
		"nodetest_conifertree.png",
		"nodetest_conifertree.png^[transformR90", 
		"nodetest_conifertree.png^[transformR90", 
		"nodetest_conifertree_top.png", 
		"nodetest_conifertree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("conifers:trunk_reversed", "nodetest:conifertree_horizontal")
