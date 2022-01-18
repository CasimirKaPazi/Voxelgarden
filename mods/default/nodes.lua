-- mods/default/nodes.lua
-- support for MT game translation.
local S = default.get_translator

--
-- Node definitions
--

minetest.register_node("default:stone", {
	description = S("Stone"),
	tiles = {"default_stone.png"},
	groups = {cracky=3, stone=1},
	drop = 'default:stone_crumbled',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_crumbled", {
	description = S("Crumbled Stone"),
	tiles = {"default_stone_crumbled.png"},
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone", {
	description = S("Desert Stone"),
	tiles = {"default_desert_stone.png"},
	groups = {cracky=3, stone=1},
	drop = 'default:desert_stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:granite", {
	description = S("Granite"),
	tiles = {"default_granite.png"},
	groups = {cracky=1, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_coal", {
	description = S("Coal Ore"),
	tiles = {"default_stone.png^default_mineral_coal.png"},
	groups = {cracky=3},
	drop = 'default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_iron", {
	description = S("Iron Ore"),
	tiles = {"default_stone.png^default_mineral_iron.png"},
	groups = {cracky=2},
	drop = 'default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_copper", {
	description = S("Copper Ore"),
	tiles = {"default_stone.png^default_mineral_copper.png"},
	groups = {cracky=3},
	drop = 'default:copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_tin", {
	description = S("Tin Ore"),
	tiles = {"default_stone.png^default_mineral_tin.png"},
	groups = {cracky = 3},
	drop = "default:tin_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_mese", {
	description = S("Mese Crystal Ore"),
	tiles = {"default_stone.png^default_mineral_mese.png"},
	groups = {cracky=1},
	drop = "default:mese_crystal",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stonebrick", {
	description = S("Stone Brick"),
	tiles = {"default_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:meselamp", {
	description = S("Mese Lamp"),
	drawtype = "glasslike",
	tiles = {"default_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})

minetest.register_node("default:dirt_with_grass", {
	description = S("Dirt with Grass"),
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt_with_grass_footsteps", {
	description = S("Dirt with Grass and Footsteps"),
	tiles = {"default_grass.png^default_grass_footsteps.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	groups = {crumbly=3, not_in_creative_inventory=1, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt_with_snow", {
	description = S("Dirt with Snow"),
	tiles = {"default_snow.png", "default_dirt.png", "default_dirt.png^default_snow_side.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:dirt", {
	description = S("Dirt"),
	tiles = {"default_dirt.png"},
	groups = {crumbly=3, falling_node=1, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:permafrost", {
	description = S("Permafrost"),
	tiles = {"default_permafrost.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("default:permafrost_with_stones", {
	description = S("Permafrost with Stones"),
	tiles = {"default_permafrost.png^default_stones.png",
		"default_permafrost.png",
		"default_permafrost.png^default_stones_side.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_node("default:permafrost_with_moss", {
	description = S("Permafrost with Moss"),
	tiles = {"default_moss.png", "default_permafrost.png",
		{name = "default_permafrost.png^default_moss_side.png",
			tileable_vertical = false}},
	groups = {cracky = 3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
})

minetest.register_node("default:sand", {
	description = S("Sand"),
	tiles = {"default_sand.png"},
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("default:desert_sand", {
	description = S("Desert Sand"),
	tiles = {"default_desert_sand.png"},
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("default:gravel", {
	description = S("Gravel"),
	tiles = {"default_gravel.png"},
	groups = {crumbly=2, falling_node=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.3},
	}),
	drop = {
		max_items = 1,
		items = {
			{items = {"default:flint"}, rarity = 16},
			{items = {"default:gravel"}}
		}
	}
})

minetest.register_node("default:sandstone", {
	description = S("Sandstone"),
	tiles = {"default_sandstone.png"},
	groups = {crumbly=2, cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:clay", {
	description = S("Clay"),
	tiles = {"default_clay.png"},
	groups = {crumbly=3},
	drop = 'default:clay_lump 4',
	sounds = default.node_sound_dirt_defaults({
		footstep = "",
	}),
})

minetest.register_node("default:brick", {
	description = S("Brick Block"),
	tiles = {"default_brick.png"},
	is_ground_content = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:tree", {
	description = S("Tree"),
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:tree_horizontal", {
	description = S("Tree"),
	tiles = {
		"default_tree.png", 
		"default_tree.png",
		"default_tree.png^[transformR90", 
		"default_tree.png^[transformR90", 
		"default_tree_top.png", 
		"default_tree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree_horizontal=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		default.rotate_horizontal(pos)
	end,
})

minetest.register_node("default:jungletree", {
	description = S("Jungle Tree"),
	tiles = {"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	is_ground_content = false,
	groups = {tree=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:jungletree_horizontal", {
	description = S("Jungle Tree"),
		tiles = {
		"default_jungletree.png", 
		"default_jungletree.png",
		"default_jungletree.png^[transformR90", 
		"default_jungletree.png^[transformR90", 
		"default_jungletree_top.png", 
		"default_jungletree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree_horizontal=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		default.rotate_horizontal(pos)
	end,
})

minetest.register_node("default:jungleleaves", {
	description = S("Jungle Leaves"),
	drawtype = "allfaces_optional",
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
	description = S("Jungle Sapling"),
	drawtype = "plantlike",
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

minetest.register_node("default:emergent_jungle_sapling", {
	description = S("Emergent Jungle Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"default_emergent_jungle_sapling.png"},
	inventory_image = "default_emergent_jungle_sapling.png",
	wield_image = "default_emergent_jungle_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	on_timer = function(pos)
		default.grow_emergent_junglesapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		falling_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
})

minetest.register_node("default:aspen_tree", {
	description = S("Aspen Tree"),
	tiles = {"default_aspen_tree_top.png", "default_aspen_tree_top.png",
		"default_aspen_tree.png"},
	is_ground_content = false,
	groups = {tree = 1, choppy = 3, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:aspen_tree_horizontal", {
	description = S("Aspen Tree"),
	tiles = {
		"default_aspen_tree.png", 
		"default_aspen_tree.png",
		"default_aspen_tree.png^[transformR90", 
		"default_aspen_tree.png^[transformR90", 
		"default_aspen_tree_top.png", 
		"default_aspen_tree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree_horizontal=1, choppy=2, flammable=1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		default.rotate_horizontal(pos)
	end,
})

minetest.register_node("default:aspen_leaves", {
	description = S("Aspen Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"default_aspen_leaves.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	trunk = "default:aspen_tree",
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{items = {"default:aspen_sapling"}, rarity = 20},
			{items = {"default:aspen_leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:aspen_sapling", {
	description = S("Aspen Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"default_aspen_sapling.png"},
	inventory_image = "default_aspen_sapling.png",
	wield_image = "default_aspen_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = function(pos)
		default.grow_aspen_tree_sapling(pos)
	end,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 3,
		falling_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(300, 1500))
	end,
})

minetest.register_node("default:junglegrass", {
	description = S("Jungle Grass"),
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
	description = S("Leaves"),
	drawtype = "allfaces_optional",
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
	description = S("Cactus"),
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"default_cactus_top.png", "default_cactus_top.png", "default_cactus_side.png"},
	use_texture_alpha = "clip",
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
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875},
		}
	},
	damage_per_second = 1,
	sounds = default.node_sound_wood_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
		default.dig_up(pos, {name = "default:cactus_fig"}, digger)
	end,
})

minetest.register_node("default:cactus_fig", {
	description = S("Cactus Fig"),
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
	description = S("Papyrus"),
	drawtype = "plantlike",
	tiles = {"default_papyrus.png"},
	inventory_image = "default_papyrus.png",
	wield_image = "default_papyrus.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
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

minetest.register_node("default:papyrus_roots", {
	description = S("Papyrus Roots"),
	tiles = {"default_papyrus_roots.png"},
	paramtype = "light",
	is_ground_content = true,
	liquids_pointable = true,
	after_dig_node = function(pos, node, metadata, digger)
			node.name = "default:papyrus"
			default.dig_up(pos, node, digger)
		end,
	groups = {snappy=3, flammable=2, oddly_breakable_by_hand=1, soil=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:bookshelf", {
	description = S("Bookshelf"),
	tiles = {"default_wood.png", "default_wood.png", "default_bookshelf.png"},
	is_ground_content = false,
	groups = {choppy=3, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:glass", {
	description = S("Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"default_glass.png", "default_glass_detail.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, oddly_breakable_by_hand=3, glass = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("default:fence_wood", {
	description = S("Wooden Fence"),
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

minetest.register_node("default:ladder", {
	description = S("Ladder"),
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
	floodable = true,
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
	description = S("Wooden Planks"),
	tiles = {"default_wood.png"},
	is_ground_content = false,
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=3, wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("default:water_flowing", {
	description = S("Flowing Water"),
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
	use_texture_alpha = "blend",
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
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
	description = S("Water Source"),
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
	use_texture_alpha = "blend",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
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
	description = S("River Water Dummy Node"),
	drawtype = "liquid",
	tiles = {"default_water.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	drop = "",
	liquidtype = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source = "default:water_source",
	liquid_renewable = false,
	groups = {water=3, liquid=3, not_in_creative_inventory=1},
})

-- Replace dummy node with real water
minetest.register_lbm({
	label = "Replace river water",
	name = "default:replace_river_water",
	nodenames = {"default:river_water_source"},
	run_at_every_load = true,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:water_source"})
	end
})

minetest.register_node("default:lava_flowing", {
	description = S("Flowing Lava"),
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
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
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
	description = S("Lava Source"),
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
	is_ground_content = false,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
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
  description = S("Molten Rock"),
  tiles = {
    {name="default_moltenrock_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=6.0}}
  },
  light_source = 5,
  groups = {cracky=2, hot=3, igniter=1},
  sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:torch", {
	description = S("Torch"),
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
	description = S("Sign"),
	drawtype = "signlike",
	tiles = {"default_sign_wall.png"},
	inventory_image = "default_sign_wall.png",
	wield_image = "default_sign_wall.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	floodable = true,
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
		meta:set_string("infotext", S("\"@1\"", ""))
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
		meta:set_string("infotext", S("\"@1\"", fields.text))
	end,
})

minetest.register_node("default:cobble", {
	description = S("Cobblestone"),
	tiles = {"default_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:mossycobble", {
	description = S("Mossy Cobblestone"),
	tiles = {"default_mossycobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:coalblock", {
	description = S("Coal Block"),
	tiles = {"default_coal_block.png"},
	is_ground_content = false,
	groups = {cracky=3, flammable=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:steelblock", {
	description = S("Steel Block"),
	tiles = {"default_steel_block.png"},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:copperblock", {
	description = S("Copper Block"),
	tiles = {"default_copper_block.png"},
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:tinblock", {
	description = S("Tin Block"),
	tiles = {"default_tin_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:bronzeblock", {
	description = S("Bronze Block"),
	tiles = {"default_bronze_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("default:mese", {
	description = S("Mese"),
	tiles = {"default_mese_block.png"},
	is_ground_content = false,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_gold", {
	description = S("Gold Ore"),
	tiles = {"default_stone.png^default_mineral_gold.png"},
	groups = {cracky = 2},
	drop = "default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:goldblock", {
	description = S("Gold Block"),
	tiles = {"default_gold_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_metal_defaults(),
})


minetest.register_node("default:stone_with_diamond", {
	description = S("Diamond Ore"),
	tiles = {"default_stone.png^default_mineral_diamond.png"},
	groups = {cracky = 1},
	drop = "default:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:diamondblock", {
	description = S("Diamond Block"),
	tiles = {"default_diamond_block.png"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:nyancat", {
	description = S("Nyan Rat"),
	tiles = {"default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
		"default_nc_side.png", "default_nc_back.png", "default_nc_front.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:rainbow", {
	description = S("Rainbow"),
	tiles = {"default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90", "default_nc_rb.png", "default_nc_rb.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {cracky=2},
	sounds = default.node_sound_defaults(),
})

minetest.register_node("default:sapling", {
	description = S("Sapling"),
	drawtype = "plantlike",
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
	description = S("Apple"),
	drawtype = "plantlike",
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
	-- Use static selection box for all cases
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
		wall_bottom = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
		wall_side = {-0.2, -0.5, -0.2, 0.2, 0, 0.2},
	},
	groups = {fleshy=3, dig_immediate=3, flammable=2, attached_node=1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:dry_shrub", {
	description = S("Dry Shrub"),
	drawtype = "plantlike",
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
	description = S("Grass"),
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
		description = S("Grass"),
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

minetest.register_node("default:fern_1", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_fern_1.png"},
	inventory_image = "default_fern_1.png",
	wield_image = "default_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	floodable = true,
	groups = {snappy = 3, flammable = 3, flora = 1, falling_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("default:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("default:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"default_fern_" .. i .. ".png"},
		inventory_image = "default_fern_" .. i .. ".png",
		wield_image = "default_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		floodable = true,
		groups = {snappy = 3, flammable = 3, flora = 1, falling_node=1,
			not_in_creative_inventory=1},
		drop = "default:fern_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("default:marram_grass_1", {
	description = S("Marram Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_marram_grass_1.png"},
	inventory_image = "default_marram_grass_1.png",
	wield_image = "default_marram_grass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1, marram_grass = 1,
		falling_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("default:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("default:marram_grass_" .. i, {
		description = S("Marram Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_marram_grass_" .. i .. ".png"},
		inventory_image = "default_marram_grass_" .. i .. ".png",
		wield_image = "default_marram_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
			grass = 1, marram_grass = 1, not_in_creative_inventory = 1},
		drop = "default:marram_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("default:ice", {
	description = S("Ice"),
	tiles = {"default_ice.png"},
	paramtype = "light",
	liquids_pointable = true,
	sunlight_propagates = true,
	groups = {cracky=3, slippery = 3, cools_lava = 1},
	is_ground_content = false,
	sounds = default.node_sound_ice_defaults(),
})

minetest.register_node("default:snow", {
	description = S("Snow"),
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
	description = S("Snow Block"),
	tiles = {"default_snow.png"},
	groups = {crumbly=3, cools_lava = 1, fall_damage_add_percent=default.COUSHION,},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("default:sand_with_kelp", {
	description = S("Kelp"),
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {{name = "default_kelp.png", tileable_vertical = true}},
	inventory_image = "default_kelp.png",
	wield_image = "default_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),
	on_use = minetest.item_eat(2),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end
		local pos = pointed_thing.under
		itemstack = default.place_kelp(itemstack, placer, pos)

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node("default:sand_with_small_kelp", {
	description = S("Small Kelp"),
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	special_tiles = {{name = "default_kelp.png", tileable_vertical = true}},
	inventory_image = "default_small_kelp.png",
	wield_image = "default_small_kelp.png",
	paramtype = "light",
	paramtype2 = "leveled",
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 2.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),
	on_use = minetest.item_eat(1),

	on_place = function(itemstack, placer, pointed_thing)
		-- Call on_rightclick if the pointed node defines it
		if pointed_thing.type == "node" and placer and
				not placer:get_player_control().sneak then
			local node_ptu = minetest.get_node(pointed_thing.under)
			local def_ptu = minetest.registered_nodes[node_ptu.name]
			if def_ptu and def_ptu.on_rightclick then
				return def_ptu.on_rightclick(pointed_thing.under, node_ptu, placer,
					itemstack, pointed_thing)
			end
		end

		local pos = pointed_thing.under
		if minetest.get_node(pos).name ~= "default:sand" then
			return itemstack
		end

		local height = math.random(2, 3)
		local pos_top = {x = pos.x, y = pos.y + height, z = pos.z}
		local node_top = minetest.get_node(pos_top)
		local def_top = minetest.registered_nodes[node_top.name]
		local player_name = placer:get_player_name()

		if def_top and def_top.liquidtype == "source" and
				minetest.get_item_group(node_top.name, "water") > 0 then
			if not minetest.is_protected(pos, player_name) and
					not minetest.is_protected(pos_top, player_name) then
				minetest.set_node(pos, {name = "default:sand_with_small_kelp",
					param2 = height * 16})
				if not minetest.settings:get_bool("creative_mode") then
					itemstack:take_item()
				end
			else
				minetest.chat_send_player(player_name, "Node is protected")
				minetest.record_protection_violation(pos, player_name)
			end
		end

		return itemstack
	end,

	after_destruct  = function(pos, oldnode)
		minetest.set_node(pos, {name = "default:sand"})
	end
})

minetest.register_node(":default:coral_brown", {
	description = S("Brown Coral"),
	tiles = {"default_coral_brown.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:coral_orange", {
	description = S("Orange Coral"),
	tiles = {"default_coral_orange.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:coral_purple", {
	description = S("Purple Coral"),
	tiles = {"default_coral_purple.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:coral_skeleton", {
	description = S("Coral Skeleton"),
	tiles = {"default_coral_skeleton.png"},
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:seaweed", {
	description = S("Dirt with Seaweed"),
	tiles = {"default_dirt.png^default_seaweed_top.png", "default_dirt.png"},
	special_tiles = {{name = "default_seaweed.png",
tileable_vertical = false}},
	inventory_image = "default_seaweed.png",
	drawtype = "plantlike_rooted",
	waving = 1,
	groups = {crumbly=3, falling_node=1, soil=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.1},
	}),
})

minetest.register_node("default:obsidian", {
	description = S("Obsidian"),
	tiles = {"default_obsidian.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1},
})

minetest.register_node("default:obsidian_glass", {
	description = S("Obsidian Glass"),
	drawtype = "glasslike_framed_optional",
	tiles = {"default_obsidian_glass.png", "default_obsidian_glass_detail.png"},
	paramtype = "light",
	paramtype2 = "glasslikeliquidlevel",
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky = 3, glass = 1},
})

minetest.register_node("default:seedling", {
	description = S("Seedling"),
	drawtype = "torchlike",
	tiles = {"default_seedling.png"},
	inventory_image = "default_seedling.png",
	wield_image = "default_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	floodable = true,
	is_ground_content = true,
	groups = {snappy=3, dig_immediate=3, flammable=3, attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("default:bonfire", {
	description = S("Bonfire"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {
		{name="default_bonfire_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	inventory_image = "default_bonfire.png",
	wield_image = "default_bonfire.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	drop = "",
	damage_per_second = 1,
	light_source = 12,
	groups = {snappy=3, attached_node=1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, 0, 0.375},
	},
})
