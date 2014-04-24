-- See README.txt for licensing and other information.
minetest.register_alias("flowers:flower_pot",					"pots:pot")
minetest.register_alias("flowers:pot",						"pots:pot")

--
-- Function called on right click. 
--

local function plant_pot(pos, node, clicker)
	local inv = clicker:get_inventory()
	if inv:room_for_item("main", "pots:pot") then
		minetest.set_node(pos, node)
		minetest.sound_play("default_dug_node", {pos,gain = 1.0})
		inv:add_item("main", "pots:pot")
	else
		minetest.chat_send_player(clicker:get_player_name(), "Your inventory is full.")
	end
end

--
-- Definitions
--

local definitions = {
--	{name,					desc,				new_node,					craft_input},
	{"cactus",				"Cactus",			"default:cactus",			"default:cactus"},
	{"dandelion_white",		"White Dandelion",	"flowers:dandelion_white",	"flowers:dandelion_white"},
	{"dandelion_yellow",	"Yellow Dandelion",	"flowers:dandelion_yellow",	"flowers:dandelion_yellow"},
	{"geranium",			"Geranium",			"flowers:geranium",			"flowers:geranium"},
	{"rose",				"Rose",				"flowers:rose",				"flowers:rose"},
	{"tulip",				"Tulip",			"flowers:tulip",			"flowers:tulip"},
	{"viola",				"Viola",			"flowers:viola",			"flowers:viola"},
	{"seedling",			"Seedling",			"air",						"group:sapling"},
}

for _, row in ipairs(definitions) do
	local name = row[1]
	local desc = row[2]
	local new_node = row[3]
	local craft_input = row[4]
	minetest.register_node("pots:"..name, {
		description = desc,
		drawtype = "plantlike",
		tiles = {"pots_"..name..".png"},
		inventory_image = "pots_"..name..".png",
		wield_image = "pots_"..name..".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = false,
		groups = {snappy=3,dig_immediate=3,attached_node=1},
		on_rightclick = function(pos, node, clicker)
			node.name = new_node
			plant_pot(pos, node, clicker)
		end,
		sounds = default.node_sound_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 },
		},
	})
	minetest.register_craft( {
		output = "pots:"..name,
		recipe = {
			    { craft_input },
			    { "pots:pot" }
		},
	})
	minetest.register_alias("flowers:flower_potted_"..name,		"pots:"..name)
	minetest.register_alias("flowers:pot_"..name,			"pots:"..name)
end

-- Pot
minetest.register_node("pots:pot", {
	description = "Flower Pot",
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

minetest.register_craft( {
	output = "pots:pot",
	recipe = {
	        { "default:clay_brick", "", "default:clay_brick" },
	        { "", "default:clay_brick", "" }
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
			local flower_choice = math.random(1, 6)
			local flower
			if flower_choice == 1 then
				flower = "pots:tulip"
			elseif flower_choice == 2 then
				flower = "pots:rose"
			elseif flower_choice == 3 then
				flower = "pots:viola"
			elseif flower_choice == 4 then
				flower = "pots:geranium"
			elseif flower_choice == 5 then
				flower = "pots:dandelion_white"
			elseif flower_choice == 6 then
				flower = "pots:dandelion_yellow"
			end
			minetest.set_node(pos, {name=flower})
		end
	end
})
