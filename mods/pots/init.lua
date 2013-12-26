-- See README.txt for licensing and other information.

-- Aliases for original flowers mod)
minetest.register_alias("flowers:flower_pot",						"pots:pot")
minetest.register_alias("flowers:flower_potted_dandelion_white",	"pots:dandelion_white")
minetest.register_alias("flowers:flower_potted_dandelion_yellow",	"pots:dandelion_yellow")
minetest.register_alias("flowers:flower_potted_geranium",			"pots:geranium")
minetest.register_alias("flowers:flower_potted_rose",				"pots:rose")
minetest.register_alias("flowers:flower_potted_tulip",				"pots:tulip")
minetest.register_alias("flowers:flower_potted_viola",				"pots:viola")

minetest.register_alias("flowers:pot",						"pots:pot")
minetest.register_alias("flowers:pot_dandelion_white",		"pots:dandelion_white")
minetest.register_alias("flowers:pot_dandelion_yellow",		"pots:dandelion_yellow")
minetest.register_alias("flowers:pot_geranium",				"pots:geranium")
minetest.register_alias("flowers:pot_rose",					"pots:rose")
minetest.register_alias("flowers:pot_tulip",				"pots:tulip")
minetest.register_alias("flowers:pot_viola",				"pots:viola")
minetest.register_alias("flowers:pot_cactus",				"pots:cactus")

--
-- Nodes
--

-- Pot
minetest.register_node("pots:pot", {
	description = "Flowerpot",
	drawtype = "plantlike",
	tiles = { "pots_pot.png" },
	inventory_image = "pots_pot.png",
	wield_image = "pots_pot.png",
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

-- Flowers in pot
minetest.register_node("pots:cactus", {
	description = "Cactus",
	drawtype = "plantlike",
	tiles = { "pots_cactus.png" },
	inventory_image = "pots_cactus.png",
	wield_image = "pots_cactus.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "default:cactus"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:dandelion_white", {
	description = "White Dandelion",
	drawtype = "plantlike",
	tiles = { "pots_dandelion_white.png" },
	inventory_image = "pots_dandelion_white.png",
	wield_image = "pots_dandelion_white.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:dandelion_white"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:dandelion_yellow", {
	description = "Yellow Dandelion",
	drawtype = "plantlike",
	tiles = { "pots_dandelion_yellow.png" },
	inventory_image = "pots_dandelion_yellow.png",
	wield_image = "pots_dandelion_yellow.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:dandelion_yellow"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:geranium", {
	description = "Geranium",
	drawtype = "plantlike",
	tiles = { "pots_geranium.png" },
	inventory_image = "pots_geranium.png",
	wield_image = "pots_geranium.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:geranium"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:rose", {
	description = "Rose",
	drawtype = "plantlike",
	tiles = { "pots_rose.png" },
	inventory_image = "pots_rose.png",
	wield_image = "pots_rose.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:rose"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:tulip", {
	description = "Tulip",
	drawtype = "plantlike",
	tiles = { "pots_tulip.png" },
	inventory_image = "pots_tulip.png",
	wield_image = "pots_tulip.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:tulip"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

minetest.register_node("pots:viola", {
	description = "Viola",
	drawtype = "plantlike",
	tiles = { "pots_viola.png" },
	inventory_image = "pots_viola.png",
	wield_image = "pots_viola.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "flowers:viola"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

-- Seedling
minetest.register_node("pots:seedling", {
	description = "Seedling",
	drawtype = "plantlike",
	tiles = { "pots_seedling.png" },
	inventory_image = "pots_seedling.png",
	wield_image = "pots_seedling.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	groups = {snappy=3,dig_immediate=3,attached_node=1},
	on_rightclick = function(pos, node, clicker)
		local inv = clicker:get_inventory()
		if inv:room_for_item("main", "pots:pot") then
			node.name = "air"
			minetest.set_node(pos, node)
			minetest.sound_play("default_dug_node", {pos,gain = 1.0})
			inv:add_item("main", "pots:pot")
		else
			minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
		end
	end,
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
	},
})

--
-- Craft
--

-- Pot
minetest.register_craft( {
	output = "pots:pot",
	recipe = {
	        { "default:clay_brick", "", "default:clay_brick" },
	        { "", "default:clay_brick", "" }
	},
})

-- Flowers in pot
minetest.register_craft( {
	output = "pots:cactus",
	recipe = {
	        { "default:cactus" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:dandelion_white",
	recipe = {
	        { "flowers:dandelion_white" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:dandelion_yellow",
	recipe = {
	        { "flowers:dandelion_yellow" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:geranium",
	recipe = {
	        { "flowers:geranium" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:rose",
	recipe = {
	        { "flowers:rose" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:tulip",
	recipe = {
	        { "flowers:tulip" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:viola",
	recipe = {
	        { "flowers:viola" },
	        { "pots:pot" }
	},
})

-- Seedling
minetest.register_craft( {
	output = "pots:seedling",
	recipe = {
	        { "default:sapling" },
	        { "pots:pot" }
	},
})

minetest.register_craft( {
	output = "pots:seedling",
	recipe = {
	        { "default:junglesapling" },
	        { "pots:pot" }
	},
})


--
-- ABM
--

minetest.register_abm({
	nodenames = {"pots:seedling"},
	interval = 3,
	chance = 131,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if (minetest.get_node_light(above) or 0) >= 11 then
			local flower_choice = math.random(1, 21)
			local flower
			if flower_choice <= 1 then
				flower = "pots:tulip"
			elseif flower_choice <= 3 then
				flower = "pots:rose"
			elseif flower_choice <= 6 then
				flower = "pots:viola"
			elseif flower_choice <= 10 then
				flower = "pots:flower_geranium"
			elseif flower_choice <= 15 then
				flower = "pots:dandelion_white"
			elseif flower_choice <= 21 then
				flower = "pots:dandelion_yellow"
			end
			minetest.set_node(pos, {name=flower})
		end
	end
})
