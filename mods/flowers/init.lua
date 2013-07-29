-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Map Generation
dofile(minetest.get_modpath("flowers").."/mapgen.lua")

-- Aliases for original flowers mod
minetest.register_alias("flowers:flower_dandelion_white", "flowers:dandelion_white")
minetest.register_alias("flowers:flower_dandelion_yellow", "flowers:dandelion_yellow")
minetest.register_alias("flowers:flower_geranium", "flowers:geranium")
minetest.register_alias("flowers:flower_rose", "flowers:rose")
minetest.register_alias("flowers:flower_tulip", "flowers:tulip")
minetest.register_alias("flowers:flower_viola", "flowers:viola")
minetest.register_alias("flowers:flower_pot", "flowers:pot")
minetest.register_alias("flowers:flower_potted_dandelion_white", "flowers:pot_dandelion_white")
minetest.register_alias("flowers:flower_potted_dandelion_yellow", "flowers:pot_dandelion_yellow")
minetest.register_alias("flowers:flower_potted_geranium", "flowers:pot_geranium")
minetest.register_alias("flowers:flower_potted_rose", "flowers:pot_rose")
minetest.register_alias("flowers:flower_potted_tulip", "flowers:pot_tulip")
minetest.register_alias("flowers:flower_potted_viola", "flowers:pot_viola")

-- Flowers

minetest.register_node("flowers:dandelion_white", {
	description = "White Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_white.png" },
	inventory_image = "flowers_dandelion_white.png",
	wield_image = "flowers_dandelion_white.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_white=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("flowers:dandelion_yellow", {
	description = "Yellow Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_dandelion_yellow.png" },
	inventory_image = "flowers_dandelion_yellow.png",
	wield_image = "flowers_dandelion_yellow.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_yellow=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("flowers:geranium", {
	description = "Blue Geranium",
	drawtype = "plantlike",
	tiles = { "flowers_geranium.png" },
	inventory_image = "flowers_geranium.png",
	wield_image = "flowers_geranium.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("flowers:rose", {
	description = "Rose",
	drawtype = "plantlike",
	tiles = { "flowers_rose.png" },
	inventory_image = "flowers_rose.png",
	wield_image = "flowers_rose.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_red=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("flowers:tulip", {
	description = "Tulip",
	drawtype = "plantlike",
	tiles = { "flowers_tulip.png" },
	inventory_image = "flowers_tulip.png",
	wield_image = "flowers_tulip.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_orange=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("flowers:viola", {
	description = "Viola",
	drawtype = "plantlike",
	tiles = { "flowers_viola.png" },
	inventory_image = "flowers_viola.png",
	wield_image = "flowers_viola.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,dig_immediate=3,flammable=2,flower=1,flora=1,attached_node=1,color_violet=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- Pot
minetest.register_node("flowers:pot", {
	description = "Flowerpot",
	drawtype = "plantlike",
	tiles = { "flowers_pot.png" },
	inventory_image = "flowers_pot.png",
	wield_image = "flowers_pot.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot",
	recipe = {
	        { "default:clay_brick", "", "default:clay_brick" },
	        { "", "default:clay_brick", "" }
	},
})

-- Flowers in pot
minetest.register_node("flowers:pot_cactus", {
	description = "Cactus",
	drawtype = "plantlike",
	tiles = { "flowers_pot_cactus.png" },
	inventory_image = "flowers_pot_cactus.png",
	wield_image = "flowers_pot_cactus.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_cactus",
	recipe = {
	        { "default:cactus" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_dandelion_white", {
	description = "White Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_pot_dandelion_white.png" },
	inventory_image = "flowers_pot_dandelion_white.png",
	wield_image = "flowers_pot_dandelion_white.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:dandelion_white"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_dandelion_white",
	recipe = {
	        { "flowers:dandelion_white" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_dandelion_yellow", {
	description = "Yellow Dandelion",
	drawtype = "plantlike",
	tiles = { "flowers_pot_dandelion_yellow.png" },
	inventory_image = "flowers_pot_dandelion_yellow.png",
	wield_image = "flowers_pot_dandelion_yellow.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:dandelion_yellow"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_dandelion_yellow",
	recipe = {
	        { "flowers:dandelion_yellow" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_geranium", {
	description = "Geranium",
	drawtype = "plantlike",
	tiles = { "flowers_pot_geranium.png" },
	inventory_image = "flowers_pot_geranium.png",
	wield_image = "flowers_pot_geranium.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:geranium"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_geranium",
	recipe = {
	        { "flowers:geranium" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_rose", {
	description = "Rose",
	drawtype = "plantlike",
	tiles = { "flowers_pot_rose.png" },
	inventory_image = "flowers_pot_rose.png",
	wield_image = "flowers_pot_rose.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:rose"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_rose",
	recipe = {
	        { "flowers:rose" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_tulip", {
	description = "Tulip",
	drawtype = "plantlike",
	tiles = { "flowers_pot_tulip.png" },
	inventory_image = "flowers_pot_tulip.png",
	wield_image = "flowers_pot_tulip.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:tulip"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		endd
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_tulip",
	recipe = {
	        { "flowers:tulip" },
	        { "flowers:pot" }
	},
})

minetest.register_node("flowers:pot_viola", {
	description = "Viola",
	drawtype = "plantlike",
	tiles = { "flowers_pot_viola.png" },
	inventory_image = "flowers_pot_viola.png",
	wield_image = "flowers_pot_viola.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
--		local inv = clicker:get_inventory()
--		if inv:room_for_item("flowers:pot") then
			node.name = "flowers:viola"
			minetest.env:set_node(pos, node)
			minetest.sound_play("default_break_glass", {pos,gain = 1.0})
--			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
--			inv:add_item("main", "flowers:pot")
--		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_craft( {
	output = "flowers:pot_viola",
	recipe = {
	        { "flowers:viola" },
	        { "flowers:pot" }
	},
})
