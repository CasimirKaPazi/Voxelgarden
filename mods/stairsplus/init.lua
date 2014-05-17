print("[stairsplus] loaded.")

stairsplus = {}

dofile(minetest.get_modpath(minetest.get_current_modname()).."/stair.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/corner.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/slab.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/quater_slab.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/wall.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/quater_wall.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/panel.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/micro.lua")

-- Nodes will be called <modname>:{stair,corner,slab,wall,panel,micro}_<subname>
function stairsplus.register_stair_and_slab_and_panel_and_micro(modname, subname, recipeitem, groups, images, desc_stair, desc_corner, desc_slab, desc_wall, desc_panel, desc_micro, drop, sounds, sunlight)
	stairsplus.register_stair(modname, subname, recipeitem, groups, images, desc_stair, drop, sounds, sunlight)
	stairsplus.register_corner(modname, subname, recipeitem, groups, images, desc_corner, drop, sounds, sunlight)
	stairsplus.register_slab(modname, subname, recipeitem, groups, images, desc_slab, drop, sounds, sunlight)
	stairsplus.register_wall(modname, subname, recipeitem, groups, images, desc_slab, drop, sounds, sunlight)
	stairsplus.register_panel(modname, subname, recipeitem, groups, images, desc_panel, drop, sounds, sunlight)
	stairsplus.register_micro(modname, subname, recipeitem, groups, images, desc_micro, drop, sounds, sunlight)
end

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "wood", "default:wood",
		{snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=1},
		{"default_wood.png"},
		"Wooden Stairs",
		"Wooden Corner",
		"Wooden Slab",
		"Wooden Wall",
		"Wooden Panel",
		"Wooden Microblock",
		"wood",
		default.node_sound_wood_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "stone", "default:stone",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_stone.png"},
		"Stone Stairs",
		"Stone Corner",
		"Stone Slab",
		"Stone Wall",
		"Stone Panel",
		"Stone Microblock",
		"cobble",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "cobble", "default:cobble",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_cobble.png"},
		"Cobblestone Stairs",
		"Cobblestone Corner",
		"Cobblestone Slab",
		"Cobblestone Wall",
		"Cobblestone Panel",
		"Cobblestone Microblock",
		"cobble",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "brick", "default:brick",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_brick.png"},
		"Brick Stairs",
		"Brick Corner",
		"Brick Slab",
		"Brick Wall",
		"Brick Panel",
		"Brick Microblock",
		"brick",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "steelblock", "default:steelblock",
		{snappy=1,bendy=2,cracky=1,melty=2,level=2, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_steel_block.png"},
		"Steel Block Stairs",
		"Steel Block Corner",
		"Steel Block Slab",
		"Steel Block Wall",
		"Steel Block Panel",
		"Steel Microblock",
		"steelblock",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "desert_stone", "default:desert_stone",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_desert_stone.png"},
		"Desert Stone Stairs",
		"Desert Stone Corner",
		"Desert Stone Slab",
		"Desert Stone Wall",
		"Desert Stone Panel",
		"Desert Stone Microblock",
		"desert_stone",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "glass", "default:glass",
		{cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_glass.png"},
		"Glass Stairs",
		"Glass Corner",
		"Glass Slab",
		"Glass Wall",
		"Glass Panel",
		"Glass Microblock",
		"glass",
		default.node_sound_glass_defaults(),
		true)
