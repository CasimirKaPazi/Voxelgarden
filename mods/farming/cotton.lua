minetest.register_craftitem("farming:cotton", {
	description = "Cotton",
	inventory_image = "farming_cotton.png",
	wield_image = "farming_cotton.png",
	on_place = function(itemstack, placer, pointed_thing)
		local under = minetest.get_node(pointed_thing.under)
		local above = minetest.get_node(pointed_thing.above)
		-- check for rightclick
		local reg_node = minetest.registered_nodes[under.name]
		if reg_node.on_rightclick then
			reg_node.on_rightclick(pointed_thing.under, under, placer)
			return
		end
		-- place plant
		for _,farming_soil in ipairs(farming_soil) do
			if above.name == "air" and under.name == farming_soil then
				above.name = "farming:cotton_1"
				minetest.place_node(pointed_thing.above, above)
				minetest.sound_play("default_place_node", {pos = pointed_thing.above, gain = 0.5})
				if minetest.setting_getbool("creative_mode") then
					return
				end
				itemstack:take_item(1)
				return itemstack
			end
		end
	end
})

minetest.register_node("farming:cotton_1", {
	description = "Cotton Plant",
	inventory_image = "farming_cotton_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_cotton_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, sickle=1, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_2", {
	description = "Cotton Plant",
	inventory_image = "farming_cotton_2.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_cotton_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming:cotton_3", {
	description = "Cotton Plant",
	inventory_image = "farming_cotton_3.png",
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_cotton_3.png"},
	drop = "farming:cotton",
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "farming:cotton") then
			minetest.add_node(pos, {name="farming:cotton_2"})	
			minetest.sound_play("default_dig_crumbly", {pos,gain = 1.0})
			inv:add_item("main", "farming:cotton")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, attached_node=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_abm({
	nodenames = {"farming:cotton_1", "farming:cotton_2"},
	interval = 57,
	chance = 22,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" and minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		if minetest.get_node_light(pos) < 8 then
			return
		end
		if node.name == "farming:cotton_1" then
			node.name = "farming:cotton_2"
			minetest.set_node(pos, node)
		elseif node.name == "farming:cotton_2" then
			node.name = "farming:cotton_3"
			minetest.set_node(pos, node)
		end
	end
})

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
