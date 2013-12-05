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
	groups = {snappy=3, flammable=2, sickle=1},
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
