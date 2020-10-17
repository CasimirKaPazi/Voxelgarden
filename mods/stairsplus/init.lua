-- Load support for MT game translation.
local S = minetest.get_translator("hunger")

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
		S("Wooden Stairs"),
		S("Wooden Corner"),
		S("Wooden Slab"),
		S("Wooden Wall"),
		S("Wooden Panel"),
		S("Wooden Microblock"),
		"wood",
		default.node_sound_wood_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "stone", "default:stone",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_stone.png"},
		S("Stone Stairs"),
		S("Stone Corner"),
		S("Stone Slab"),
		S("Stone Wall"),
		S("Stone Panel"),
		S("Stone Microblock"),
		"stone_crumbled",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "stone_crumbled", "default:stone_crumbled",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1, oddly_breakable_by_hand=1},
		{"default_stone_crumbled.png"},
		S("Crumbled Stairs"),
		S("Crumbled Corner"),
		S("Crumbled Slab"),
		S("Crumbled Wall"),
		S("Crumbled Panel"),
		S("Crumbled Microblock"),
		"stone_crumbled",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "cobble", "default:cobble",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_cobble.png"},
		S("Cobblestone Stairs"),
		S("Cobblestone Corner"),
		S("Cobblestone Slab"),
		S("Cobblestone Wall"),
		S("Cobblestone Panel"),
		S("Cobblestone Microblock"),
		"cobble",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "brick", "default:brick",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_brick.png"},
		S("Brick Stairs"),
		S("Brick Corner"),
		S("Brick Slab"),
		S("Brick Wall"),
		S("Brick Panel"),
		S("Brick Microblock"),
		"brick",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "steelblock", "default:steelblock",
		{snappy=1,bendy=2,cracky=1,melty=2,level=2, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_steel_block.png"},
		S("Steel Block Stairs"),
		S("Steel Block Corner"),
		S("Steel Block Slab"),
		S("Steel Block Wall"),
		S("Steel Block Panel"),
		S("Steel Microblock"),
		"steelblock",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "desert_stone", "default:desert_stone",
		{cracky=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_desert_stone.png"},
		S("Desert Stone Stairs"),
		S("Desert Stone Corner"),
		S("Desert Stone Slab"),
		S("Desert Stone Wall"),
		S("Desert Stone Panel"),
		S("Desert Stone Microblock"),
		"desert_stone",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "glass", "default:glass",
		{cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_glass.png"},
		S("Glass Stairs"),
		S("Glass Corner"),
		S("Glass Slab"),
		S("Glass Wall"),
		S("Glass Panel"),
		S("Glass Microblock"),
		"glass",
		default.node_sound_glass_defaults(),
		true)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "sandstone", "default:sandstone",
		{crumbly=2, cracky=2, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_sandstone.png"},
		S("Sandstone Stairs"),
		S("Sandstone Corner"),
		S("Sandstone Slab"),
		S("Sandstone Wall"),
		S("Sandstone Panel"),
		S("Sandstone Microblock"),
		"sandstone",
		default.node_sound_stone_defaults()
		)

stairsplus.register_stair_and_slab_and_panel_and_micro("stairsplus", "stonebrick", "default:stonebrick",
		{cracky=1, not_in_creative_inventory=1, not_in_craft_guide=1},
		{"default_stone_brick.png"},
		S("Stone Brick Stairs"),
		S("Stone Brick Corner"),
		S("Stone Brick Slab"),
		S("Stone Brick Wall"),
		S("Stone Brick Panel"),
		S("Stone Brick Microblock"),
		"stonebrick",
		default.node_sound_stone_defaults()
		)

minetest.register_craft({
	output = "mesecons_pressureplates:pressure_plate_wood_off",
	recipe = {
		{"group:wood", "group:stick", "group:wood"},
	},
})

minetest.register_craft({
	output = "mesecons_pressureplates:pressure_plate_stone_off",
	recipe = {
		{"group:stone", "group:stick", "group:stone"},
	},
})
