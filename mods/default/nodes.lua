-- mods/default/nodes.lua

--
-- Node definitions
--

minetest.register_node("default:stone", {
	description = "Stone",
	tiles = {"default_stone.png"},
	groups = {cracky=3, stone=1},
	drop = 'default:cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone", {
	description = "Desert Stone",
	tiles = {"default_desert_stone.png"},
	groups = {cracky=3, stone=1},
	drop = 'default:desert_stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_coal", {
	description = "Coal Ore",
	tiles = {"default_stone.png^default_mineral_coal.png"},
	groups = {cracky=3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_iron", {
	description = "Iron Ore",
	tiles = {"default_stone.png^default_mineral_iron.png"},
	groups = {cracky=2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_copper", {
	description = "Copper Ore",
	tiles = {"default_stone.png^default_mineral_copper.png"},
	groups = {cracky=3},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_tin", {
	description = "Tin Ore",
	tiles = {"default_stone.png^default_mineral_tin.png"},
	groups = {cracky = 3},
	drop = "default:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_mese", {
	description = "Mese Crystal Ore",
	tiles = {"default_stone.png^default_mineral_mese.png"},
	groups = {cracky=1},
	drop = "default:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stonebrick", {
	description = "Stone Brick",
	tiles = {"default_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:dirt_with_grass", {
	description = "Dirt with Grass",
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt_with_grass_footsteps", {
	description = "Dirt with Grass and Footsteps",
	tiles = {"default_grass.png^default_grass_footsteps.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, not_in_creative_inventory=1, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt_with_snow", {
	description = "Dirt with Snow",
	tiles = {"default_snow.png", "default_dirt.png", "default_dirt.png^default_snow_side.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt", {
	description = "Dirt",
	tiles = {"default_dirt.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:sand", {
	description = "Sand",
	tiles = {"default_sand.png"},
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("default:desert_sand", {
	description = "Desert Sand",
	tiles = {"default_desert_sand.png"},
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("default:gravel", {
	description = "Gravel",
	tiles = {"default_gravel.png"},
	groups = {crumbly=2, falling_node=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.3},
	}),
	drop = "default:small_stone 4",
})

minetest.register_node("default:sandstone", {
	description = "Sandstone",
	tiles = {"default_sandstone.png"},
	groups = {crumbly=2, cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:clay", {
	description = "Clay",
	tiles = {"default_clay.png"},
	groups = {crumbly=3},
	drop = 'default:clay_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("default:brick", {
	description = "Brick Block",
	tiles = {"default_brick.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tree", {
	description = "Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:jungletree", {
	description = "Jungle Tree",
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:jungleleaves", {
	description = "Jungle Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_jungleleaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	trunk = "default:jungletree",
	groups = {snappy=3, leafdecay=3, flammable=2, leaves=1, fall_damage_add_percent=default.COUSHION},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/25 chance
				items = {'default:junglesapling'},
				rarity = 25,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:jungleleaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:junglesapling", {
	description = "Jungle Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_junglesapling.png"},
	inventory_image = "default_junglesapling.png",
	wield_image = "default_junglesapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	on_timer = function(pos)
		default.grow_junglesapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, dig_immediate=3, sapling=1, flammable=2, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 4800))
	end,
})

minetest.register_node("default:junglegrass", {
	description = "Jungle Grass",
	drawtype = "plantlike",
	visual_scale = 1.3,
	tiles = {"default_junglegrass.png"},
	inventory_image = "default_junglegrass.png",
	wield_image = "default_junglegrass.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy=3, flammable=2, flora=1, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
})

minetest.register_node("default:leaves", {
	description = "Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	trunk = "default:tree",
	groups = {snappy=3, leafdecay=2, flammable=2, leaves=1, fall_damage_add_percent=default.COUSHION},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'default:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'default:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:cactus", {
	description = "Cactus",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	groups = {snappy=1, choppy=3, flammable=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.5, -0.375, 0.5, 0.5},
			{0.375, -0.5, -0.5, 0.375, 0.5, 0.5},
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.375},
			{-0.5, -0.5, -0.375, 0.5, 0.5, -0.375},
			{-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}
	},
	sounds = default.node_sound_wood_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
		default.dig_up(pos, {name = "default:cactus_fig"}, digger)
	end,
})

minetest.register_node("default:cactus_fig", {
	description = "Cactus Fig",
	drawtype = "plantlike",
	tiles = {"default_cactus_fig.png"},
	inventory_image = "default_cactus_fig_item.png",
	wield_image = "default_cactus_fig_item.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {oddly_breakable_by_hand=3, flammable=3, flora=1, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.25, 0.25},
	},
	damage_per_second = 1,
	on_use = minetest.item_eat(1),
})

minetest.register_node("default:papyrus", {
	description = "Papyrus",
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("default:bookshelf", {
	description = "Bookshelf",
	tiles = {"default_wood.png", "default_wood.png", "default_bookshelf.png"},
	is_ground_content = false,
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:glass", {
	description = "Glass",
	drawtype = "glasslike_framed_optional",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("default:fence_wood", {
	description = "Wooden Fence",
	drawtype = "fencelike",
	tiles = {"default_wood.png"},
	inventory_image = "default_fence.png",
	wield_image = "default_fence.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:rail", {
	description = "Rail",
	drawtype = "raillike",
	tiles = {"default_rail.png", "default_rail_curved.png", "default_rail_t_junction.png", "default_rail_crossing.png"},
	inventory_image = "default_rail.png",
	wield_image = "default_rail.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {bendy=2, dig_immediate=2, falling_node=1},
})

minetest.register_node("default:ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles = {"default_ladder.png"},
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {choppy=3, oddly_breakable_by_hand=3, flammable=2},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:wood", {
	description = "Wooden Planks",
	tiles = {"default_wood.png"},
	is_ground_content = false,
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=3, wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
	},
	alpha = 160,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = false,
	drop = "",
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = {a=128, r=50, g=100, b=150},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("default:water_source", {
	description = "Water Source",
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = false,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	post_effect_color = {a=128, r=50, g=100, b=150},
	is_ground_content = false,
	groups = {water=3, liquid=3, puts_out_fire=1},
})

-- Dummy node for valleys mapgen.
minetest.register_node("default:river_water_source", {
	description = "River Water Dummy Node",
	drawtype = "liquid",
	tiles = {"default_water.png"},
	alpha = 160,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = false,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_renewable = false,
	groups = {water=3, liquid=3, not_in_creative_inventory=1},
})

if minetest.get_mapgen_params().mgname == "valleys" then
	minetest.register_lbm({
        label = "Replace river water",
		name = "default:replace_river_water",
		nodenames = {"default:river_water_source"},
        run_at_every_load = true,
		action = function(pos, node)
			minetest.set_node(pos, {name = "default:water_source"})
		end
	})
end

minetest.register_node("default:lava_flowing", {
	description = "Flowing Lava",
	drawtype = "flowingliquid",
	tiles = {"default_lava.png"},
	special_tiles = {
		{
			image="default_lava_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
		{
			image="default_lava_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.3}
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid", 
	light_source = 10,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = false,
	drop = "",
	liquidtype = "flowing",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	groups = {lava=3, liquid=2, igniter=1, not_in_creative_inventory=1},
})

minetest.register_node("default:lava_source", {
	description = "Lava Source",
	drawtype = "liquid",
	tiles = {
		{name="default_lava_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name="default_lava_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0},
			backface_culling = false,
		}
	},
	paramtype = "light",
	light_source = 10,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = false,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source = "default:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4*2,
	post_effect_color = {a=192, r=255, g=64, b=0},
	is_ground_content = false,
	groups = {lava=3, liquid=2, igniter=1},
})

minetest.register_node("default:molten_rock", {
  description = "Molten Rock",
  tiles = {
    {name="default_moltenrock_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=6.0}}
  },
  light_source = 5,
  groups = {cracky=2, hot=3, igniter=1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:torch", {
	description = "Torch",
	drawtype = "torchlike",
	--tiles = {"default_torch_on_floor.png", "default_torch_on_ceiling.png", "default_torch.png"},
	tiles = {
		{name="default_torch_on_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="default_torch_on_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="default_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = 11,
	is_ground_content = false,
	floodable = true,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.125, -0.125, -0.125, 0.125, 0.5, 0.125},
		wall_bottom = {-0.125, -0.5, -0.125, 0.125, 0.125, 0.125},
		wall_side = {-0.5, -0.375, -0.1, -0.25, 0.25, 0.125},
	},
	groups = {choppy=2, dig_immediate=3, flammable=1, attached_node=1},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:sign_wall", {
	description = "Sign",
	drawtype = "signlike",
	tiles = {"default_sign_wall.png"},
	inventory_image = "default_sign_wall.png",
	wield_image = "default_sign_wall.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups = {choppy=2, dig_immediate=2, attached_node=1},
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		--local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local player_name = sender:get_player_name() or ""
		if minetest.is_protected(pos, player_name) then
			minetest.record_protection_violation(pos, player_name)
			return
		end
		local meta = minetest.get_meta(pos)
		if not fields.text then return end
		print(player_name.." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"'..fields.text..'"')
	end,
})

minetest.register_node("default:chest", {
	description = "Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2, oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,8.5]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,4.75;8,4;]"..
				"listring[current_name;main]"..
				"listring[current_player;main]"
		)
		meta:set_string("infotext", "Chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("default:chest_locked", {
	description = "Locked Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_lock.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy=2, oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		if has_locked_chest_privilege(meta, clicker) then
			local pos = pos.x .. "," .. pos.y .. "," ..pos.z
			minetest.show_formspec(clicker:get_player_name(), "default:chest_locked",
				"size[8,8.5]"..
				"list[nodemeta:".. pos .. ";main;0,0;8,4;]"..
				"list[current_player;main;0,4.75;8,4;]"..
				"listring[nodemeta:".. pos .. ";main]"..
				"listring[current_player;main]"
			)
		end
	end,
})

minetest.register_node("default:cobble", {
	description = "Cobblestone",
	tiles = {"default_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:mossycobble", {
	description = "Mossy Cobblestone",
	tiles = {"default_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:coalblock", {
	description = "Coal Block",
	tiles = {"default_coal_block.png"},
	is_ground_content = false,
	groups = {cracky=3, flammable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:steelblock", {
	description = "Steel Block",
	tiles = {"default_steel_block.png"},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:copperblock", {
	description = "Copper Block",
	tiles = {"default_copper_block.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tinblock", {
	description = "Tin Block",
	tiles = {"default_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:bronzeblock", {
	description = "Bronze Block",
	tiles = {"default_bronze_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:mese", {
	description = "Mese",
	tiles = {"default_mese_block.png"},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:nyancat", {
	description = "Nyan Rat",
	tiles = {"default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
		"default_nc_side.png", "default_nc_back.png", "default_nc_front.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:rainbow", {
	description = "Rainbow",
	tiles = {"default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90", "default_nc_rb.png", "default_nc_rb.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:sapling", {
	description = "Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_sapling.png"},
	inventory_image = "default_sapling.png",
	wield_image = "default_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	on_timer = function(pos)
		default.grow_sapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, dig_immediate=3, sapling=1, flammable=2, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 4800))
	end,
})

minetest.register_node("default:apple", {
	description = "Apple",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_apple.png"},
	inventory_image = "default_apple.png",
	wield_image = "default_apple.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	buildable_to = true,
	floodable = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {fleshy=3, dig_immediate=3, flammable=2, attached_node=1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:dry_shrub", {
	description = "Dry Shrub",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_dry_shrub.png"},
	inventory_image = "default_dry_shrub.png",
	wield_image = "default_dry_shrub.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy=3, flammable=3, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0.5, 0.375},
	},
})

minetest.register_node("default:grass_1", {
	description = "Grass",
	drawtype = "plantlike",
	tiles = {"default_grass_1.png"},
	-- Use texture of a taller grass stage in inventory.
	inventory_image = "default_grass_3.png",
	wield_image = "default_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy=3, flammable=3, flora=1, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	on_place = function(itemstack, placer, pointed_thing)
		-- Place a random grass node.
		local stack = ItemStack("default:grass_"..math.random(1,5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 "..itemstack:get_count()-(1-ret:get_count()))
	end,
})

for i=2,5 do
	minetest.register_node("default:grass_"..i.."", {
		description = "Grass",
		drawtype = "plantlike",
		tiles = {"default_grass_"..i..".png"},
		inventory_image = "default_grass_"..i..".png",
		wield_image = "default_grass_"..i..".png",
		paramtype = "light",
		sunlight_propagates = true,
		waving = 1,
		walkable = false,
		buildable_to = true,
		floodable = true,
		drop = "default:grass_1",
		groups = {snappy=3, flammable=3, flora=1, falling_node=1, not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
	})
end

minetest.register_node("default:ice", {
	description = "Ice",
	tiles = {"default_ice.png"},
	paramtype = "light",
	liquids_pointable = true,
	sunlight_propagates = true,
	groups = {cracky=3, slippery = 3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("default:snow", {
	description = "Snow",
	tiles = {"default_snow.png"},
	inventory_image = "default_snowball.png",
	wield_image = "default_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	leveled = 7,
	leveled_full = "default:snowblock",
	drawtype = "nodebox",
	node_box = {
		type = "leveled",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+2/16, 0.5},
		},
	},
	groups = {crumbly=3, falling_node=1, fall_damage_add_percent=default.COUSHION},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
	on_construct = function(pos)
		pos.y = pos.y - 1
		local bottom = minetest.get_node(pos) 
		if bottom.name == "default:dirt_with_grass"
			or bottom.name == "default:dirt_with_grass_footsteps" then
			minetest.set_node(pos, {name="default:dirt_with_snow"})
		end
	end,
})

minetest.register_node("default:snowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	groups = {crumbly=3, fall_damage_add_percent=default.COUSHION},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})
