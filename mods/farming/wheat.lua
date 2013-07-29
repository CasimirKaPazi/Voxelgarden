minetest.register_craftitem("farming:wheat", {
	description = "Wheat",
	inventory_image = "farming_wheat.png",
	on_place = function(itemstack, placer, pointed_thing)
		local under = minetest.env:get_node(pointed_thing.under)
		local above = minetest.env:get_node(pointed_thing.above)
		-- check for rightclick
		local reg_node = minetest.registered_nodes[under.name]
		if reg_node.on_rightclick then
			reg_node.on_rightclick(pointed_thing.under, under, placer)
			return
		end
		-- place plant
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and under.name == farming_soil then
				above.name = "farming:wheat_1"
				minetest.env:place_node(pointed_thing.above, above, placer)
				minetest.sound_play("default_place_node", {pos = np, gain = 0.5})
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:wheat_1", {
	description = "Wheat Plant",
	inventory_image = "farming_wheat_1.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, -0.25, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_2", {
	description = "Wheat Plant",
	inventory_image = "farming_wheat_2.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_3", {
	description = "Wheat Plant",
	inventory_image = "farming_wheat_3.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_wheat_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:wheat_4", {
	description = "Wheat Plant",
	inventory_image = "farming_wheat_4.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_wheat_4.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {'farming:wheat'} },
			{ items = {'farming:wheat'} },
			{ items = {'farming:wheat'}, rarity = 2},
			{ items = {'farming:wheat'}, rarity = 5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:wheat_1", "farming:wheat_2", "farming:wheat_3"},
	interval = 52, --52
	chance = 11, --11
	action = function(pos, node)
		pos.y = pos.y-1
		local ground_name = minetest.env:get_node(pos).name
		if ground_name ~= "farming:soil_wet" and ground_name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.env:get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:wheat_1" then
			node.name = "farming:wheat_2"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:wheat_2" then
			node.name = "farming:wheat_3"
			minetest.env:set_node(pos, node)
		elseif node.name == "farming:wheat_3" then
			node.name = "farming:wheat_4"
			minetest.env:set_node(pos, node)
		end
	end
})

minetest.register_craftitem("farming:flour", {
	description = "Flour",
	liquids_pointable = true,
	on_use = function (itemstack, user, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if minetest.env:get_node(pointed_thing.under).name ~= "default:water_source" and minetest.env:get_node(pointed_thing.under).name ~= "default:water_flowing" then
			return
		end
		minetest.env:remove_node(pointed_thing.under)
		local count = user:get_wielded_item():get_count()
		itemstack:replace("farming:dough "..count.."")
		return itemstack
	end,
	inventory_image = "farming_flour.png",
})

minetest.register_craft({
	output = "farming:flour",
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
	on_use = minetest.item_eat(10)
})

if not minetest.get_modpath("darkage") then
	minetest.register_node(":darkage:straw", {
		description = "Straw",
		tiles = {"darkage_straw.png"},
		is_ground_content = true,
		groups = {snappy=3, flammable=2},
		sounds = default.node_sound_leaves_defaults(),
	})
end

minetest.register_craft({
	output = "darkage:straw",
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
