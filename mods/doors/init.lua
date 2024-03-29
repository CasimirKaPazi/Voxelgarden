-- Load support for MT game translation.
local S = minetest.get_translator("doors")

dofile(minetest.get_modpath("doors").."/functions.lua")

doors:register_door("doors:door_wood", {
	description = S("Wooden Door"),
	inventory_image = "doors_wood_b.png",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1},
	tiles = {"doors_wood_b.png"},
})

minetest.register_craft({
	output = "doors:door_wood_1 2",
	recipe = {
		{"group:wood", "group:wood"},
		{"group:wood", "group:wood"},
		{"group:wood", "group:wood"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wood_1",
	burntime = 16,
})

doors:register_door("doors:door_wood_window", {
	description = S("Wooden Window"),
	inventory_image = "doors_wood_a.png",
	groups = {snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=2, door=1},
	tiles = {"doors_wood_a.png"},
})

minetest.register_craft({
	output = "doors:door_wood_window_1 2",
	recipe = {
		{"group:wood", "group:wood"},
		{"group:stick", "group:stick"},
		{"group:wood", "group:wood"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wood_window_1",
	burntime = 16,
})

doors:register_door("doors:door_steel", {
	description = S("Steel Door"),
	inventory_image = "doors_steel_b.png",
	groups = {snappy=1, cracky=1, door=1},
	tiles = {"doors_steel_b.png"},
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:door_steel 2",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})

doors:register_door("doors:steel_bars", {
	description = S("Steel Bars"),
	inventory_image = "doors_steel_bars.png",
	groups = {snappy=1, cracky=1, door=1},
	tiles = {"doors_steel_bars.png"},
	only_placer_can_open = true,
})

minetest.register_craft({
	output = "doors:steel_bars_1 2",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:stick", "default:stick"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})

doors:register_door("doors:door_glass", {
	description = S("Glass Door"),
	inventory_image = "default_glass.png",
	groups = {oddly_breakable_by_hand=3, door=1},
	tiles = {"default_glass.png"},
})

minetest.register_craft({
	output = "doors:door_glass_1 2",
	recipe = {
		{"default:glass", "default:glass"},
		{"default:glass", "default:glass"},
		{"default:glass", "default:glass"}
	}
})

doors:register_door("doors:door_wattle", {
	description = S("Wattle Door"),
	inventory_image = "doors_wattle.png",
	groups = {snappy = 1, oddly_breakable_by_hand=3, door=1, flammable=2},
	tiles = {"doors_wattle.png"},
})

minetest.register_craft({
	output = "doors:door_wattle_1 2",
	recipe = {
		{"default:stick", "default:stick"},
		{"default:stick", "default:stick"},
		{"default:stick", "default:stick"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wattle_1",
	burntime = 3,
})

doors.register_fencegate("doors:gate_wood", {
	description = S("Fence Gate"),
	texture = "default_wood.png",
	material = "default:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

minetest.register_alias("doors:door_wood", "doors:door_wood_1")
minetest.register_alias("doors:door_wood_t_1", "doors:door_wood_window_1")
minetest.register_alias("doors:door_wood_t_2", "doors:door_wood_window_2")
minetest.register_alias("doors:door_wood_b_1", "doors:door_wood_1")
minetest.register_alias("doors:door_wood_b_2", "doors:door_wood_2")

minetest.register_alias("doors:door_steel", "doors:door_steel_1")
minetest.register_alias("doors:door_steel_t_1", "doors:door_steel_1")
minetest.register_alias("doors:door_steel_t_2", "doors:door_steel_2")
minetest.register_alias("doors:door_steel_b_1", "doors:door_steel_1")
minetest.register_alias("doors:door_steel_b_2", "doors:door_steel_2")
