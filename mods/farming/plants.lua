--
-- Weed
--

minetest.register_node("farming:weed", {
	description = "Weed",
	paramtype = "light",
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
			{ items = {'farming:wheat'}, rarity = 5 },
			{ items = {'farming:cotton'}, rarity = 15 },
		}
	},
	groups = {snappy=3, flammable=2, sickle=1, attached_node=1},
	sounds = default.node_sound_leaves_defaults()
})

minetest.register_abm({
	nodenames = {"farming:soil_wet", "farming:soil"},
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

-- ========= FUEL =========
minetest.register_craft({
	type = "fuel",
	recipe = "farming:weed",
	burntime = 1
})

--
-- Wheat
--

minetest.register_craftitem("farming:wheat", {
	description = "Wheat",
	inventory_image = "farming_wheat.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:wheat_1")
	end
})

local max_stage = 4
local stages = farming.register_stages(max_stage, "farming:wheat")

minetest.override_item("farming:wheat_"..max_stage.."", {
		drop = {
			max_items = 4,
			items = {
				{ items = {'farming:wheat'} },
				{ items = {'farming:wheat'}, rarity = 2 },
				{ items = {'farming:wheat'}, rarity = 3},
				{ items = {'farming:wheat'}, rarity = 5},
			}
		}
	}
)

farming.register_growing(max_stage, stages, 57, 10, 10)

minetest.register_craft({
	output = "farming:dough",
	type = "shapeless",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"},
})

minetest.register_craftitem("farming:dough", {
	description = "Dough",
	inventory_image = "farming_dough.png",
})

minetest.register_craft({
	type = "cooking",
	output = "farming:bread",
	recipe = "farming:dough",
	cooktime = 10
})

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(4)
})

minetest.register_node("farming:straw", {
  description = "Straw",
	tiles = {"farming_straw.png"},
	drop = "farming:wheat 9",
	groups = {snappy=3, fall_damage_add_percent=COUSHION, flammable=2},
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

-- ========= FUEL =========
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

--
-- Cotton
--

minetest.register_craftitem("farming:cotton", {
	description = "Cotton",
	inventory_image = "farming_cotton.png",
	wield_image = "farming_cotton.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:cotton_1")
	end
})

local max_stage = 3
local stages = {}
local stages = farming.register_stages(max_stage, "farming:cotton")

minetest.override_item("farming:cotton_"..max_stage.."", {
		on_rightclick = function(pos, node, clicker)
			local inv = clicker:get_inventory()
			if inv:room_for_item("main", "farming:cotton") then
				minetest.add_node(pos, {name="farming:cotton_2"})	
				minetest.sound_play("default_dig_crumbly", {pos,gain = 1.0})
				inv:add_item("main", "farming:cotton")
			else
				minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
			end
		end
	}
)

farming.register_growing(max_stage, stages, 57, 20, 10)

minetest.register_craftitem("farming:string", {
	description = "String",
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

-- ========= FUEL =========
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
