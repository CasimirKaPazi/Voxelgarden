-- minetest/wool/init.lua
-- Load support for MT game translation.
local S = minetest.get_translator("wool")

-- Backwards compatibility with jordach's 16-color wool mod
minetest.register_alias("wool:dark_blue", "wool:blue")
minetest.register_alias("wool:gold", "wool:yellow")

local wool = {}
-- This uses a trick: you can first define the recipes using all of the base
-- colors, and then some recipes using more specific colors for a few non-base
-- colors available. When crafting, the last recipes will be checked first.
wool.dyes = {
	{"white",      S("White Wool"),      nil},
	{"grey",       S("Grey Wool"),       "basecolor_grey"},
	{"black",      S("Black Wool"),      "basecolor_black"},
	{"red",        S("Red Wool"),        "basecolor_red"},
	{"yellow",     S("Yellow Wool"),     "basecolor_yellow"},
	{"green",      S("Green Wool"),      "basecolor_green"},
	{"cyan",       S("Cyan Wool"),       "basecolor_cyan"},
	{"blue",       S("Blue Wool"),       "basecolor_blue"},
	{"magenta",    S("Magenta Wool"),    "basecolor_magenta"},
	{"orange",     S("Orange Wool"),     "excolor_orange"},
	{"violet",     S("Violet Wool"),     "excolor_violet"},
	{"brown",      S("Brown Wool"),      "unicolor_dark_orange"},
	{"pink",       S("Pink Wool"),       "unicolor_light_red"},
	{"dark_grey",  S("Dark Grey Wool"),  "unicolor_darkgrey"},
	{"dark_green", S("Dark Green Wool"), "unicolor_dark_green"},
}

for _, row in ipairs(wool.dyes) do
	local name = row[1]
	local desc = row[2]
	local craft_color_group = row[3]
	-- Node Definition
	minetest.register_node("wool:"..name, {
		description = desc,
		tiles = {"wool_"..name..".png"},
		groups = {snappy=2,oddly_breakable_by_hand=3,flammable=3,wool=1, fall_damage_add_percent=default.COUSHION},
		sounds = default.node_sound_leaves_defaults(),
	})
	if craft_color_group then
		-- Crafting from dye and white wool
		minetest.register_craft({
			type = "shapeless",
			output = 'wool:'..name..'',
			recipe = {'group:dye,'..craft_color_group, 'group:wool'},
		})
	end
	minetest.register_craft({
		type = "fuel",
		recipe = "wool:"..name,
		burntime = 4,
	})
end

