-- support for MT game translation.
local S = default.get_translator

--
-- Weed
--

minetest.register_node("farming:weed", {
	description = S("Weed"),
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drawtype = "plantlike",
	tiles = {"farming_weed.png"},
	inventory_image = "farming_weed.png",
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+4/16, 0.5}
		},
	},
	drop = {
		max_items = 1,
		items = {
			{ items = {'farming:wheat'}, rarity = 8 },
			{ items = {'farming:cotton'}, rarity = 13 },
		}
	},
	groups = {snappy=3, flammable=2, sickle=1, falling_node=1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_abm({
	nodenames = {"farming:soil", "farming:soil_wet", "farming:soil_footsteps", "farming:soil_wet_footsteps"},
	interval = 23,
	chance = 23,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.get_node(pos).name == "air" then
			node.name = "farming:weed"
			minetest.set_node(pos, node)
		end
	end
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:weed",
	burntime = 1
})

--
-- Wheat
--

minetest.register_craftitem("farming:wheat", {
	description = S("Wheat"),
	inventory_image = "farming_wheat.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end
})

local max_stage = 4
local stages = farming.register_stages(max_stage, "farming:wheat")

minetest.override_item("farming:wheat_"..max_stage, {
	drop = {
		max_items = 4,
		items = {
			{ items = {"farming:wheat 2"} },
			{ items = {"farming:wheat"}, rarity = 2},
			{ items = {"farming:wheat"}, rarity = 4},
		}
	}
})

-- Use different names for textures
-- To be compatible with texturepacks expecting 8 stages.
minetest.override_item("farming:wheat_1", {
	tiles = {"farming_wheat_2.png"},
})
minetest.override_item("farming:wheat_2", {
	tiles = {"farming_wheat_4.png"},
})
minetest.override_item("farming:wheat_3", {
	tiles = {"farming_wheat_6.png"},
})
minetest.override_item("farming:wheat_4", {
	tiles = {"farming_wheat_8.png"},
})

farming.register_growing(max_stage, stages, 57, 10, 10)

minetest.register_craft({
	output = "farming:dough",
	type = "shapeless",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"},
})

minetest.register_craftitem("farming:dough", {
	description = S("Dough"),
	inventory_image = "farming_dough.png",
})

minetest.register_craft({
	type = "cooking",
	output = "farming:bread",
	recipe = "farming:dough",
	cooktime = 10
})

minetest.register_craftitem("farming:bread", {
	description = S("Bread"),
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(4)
})

minetest.register_node("farming:straw", {
  description = S("Straw"),
	tiles = {"farming_straw.png"},
	drop = "farming:wheat 9",
	groups = {snappy=3, fall_damage_add_percent=default.COUSHION, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("darkage:straw", "farming:straw")

minetest.register_craft({
	output = "farming:straw",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	},
})

minetest.register_craft({
	output = 'farming:wheat 9',
	recipe = {
		{'farming:straw'},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:wheat",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:straw",
	burntime = 10
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 32,
	fill_ratio = 0.0001,
	y_min = 1,
	y_max = 300,
	decoration = "farming:wheat_"..max_stage,
})

--
-- Cotton
--

minetest.register_craftitem("farming:cotton", {
	description = S("Cotton"),
	inventory_image = "farming_cotton.png",
	wield_image = "farming_cotton.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_1")
	end
})

local max_stage = 3
local stages = {}
local stages = farming.register_stages(max_stage, "farming:cotton")

minetest.override_item("farming:cotton_"..max_stage, {
	after_dig_node = function(pos, node, clicker, itemstack)
		minetest.add_node(pos, {name="farming:cotton_1"})
	end,

	drop = {
		max_items = 3,
		items = {
			{ items = {"farming:cotton"} },
			{ items = {"farming:cotton"}, rarity = 2},
			{ items = {"farming:cotton"}, rarity = 4},
		}
	}
})

-- Use different names for textures
-- To be compatible with texturepacks expecting 8 stages.
minetest.override_item("farming:cotton_1", {
	tiles = {"farming_cotton_2.png"},
})
minetest.override_item("farming:cotton_2", {
	tiles = {"farming_cotton_4.png"},
})
minetest.override_item("farming:cotton_3", {
	tiles = {"farming_cotton_8.png"},
})

farming.register_growing(max_stage, stages, 57, 15, 10)

minetest.register_craftitem("farming:string", {
	description = S("String"),
	inventory_image = "farming_string.png",
})

minetest.register_craft({
	output = "farming:string 2",
	recipe = {
		{"farming:cotton", "farming:cotton"},
	}
})

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:string",
	burntime = 1
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:cotton",
	burntime = 1
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 32,
	fill_ratio = 0.0001,
	y_min = 1,
	y_max = 300,
	decoration = "farming:cotton_"..max_stage,
})
