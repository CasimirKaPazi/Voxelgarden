-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Map Generation
dofile(minetest.get_modpath("flowers").."/mapgen.lua")

-- Aliases for original flowers mod
minetest.register_alias("flowers:flower_dandelion_white", "flowers:dandelion_white")
minetest.register_alias("flowers:flower_dandelion_yellow", "flowers:dandelion_yellow")
minetest.register_alias("flowers:flower_geranium", "flowers:geranium")
minetest.register_alias("flowers:flower_rose", "flowers:rose")
minetest.register_alias("flowers:flower_tulip", "flowers:tulip")
minetest.register_alias("flowers:flower_viola", "flowers:viola")

local flowers = {
--	flower name,		desc			color
	{"dandelion_white",	"White Dandelion",	{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_white=1}},
	{"dandelion_yellow",	"Yellow Dandelion",	{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_yellow=1}},
	{"geranium",		"Blue Geranium",	{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_blue=1}},
	{"rose",		"Rose",			{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_red=1}},
	{"tulip",		"Tulip",		{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_orange=1}},
	{"viola",		"Viola",		{dig_immediate=3, flammable=2, flower=1, flora=1, attached_node=1, dissolve=1, color_violet=1}},
}

-- Flowers
for _, row in ipairs(flowers) do
	local name = row[1]
	local desc = row[2]
	local groups = row[3]
	minetest.register_node("flowers:"..name, {
		description = desc,
		drawtype = "plantlike",
		tiles = {"flowers_"..name..".png"},
		inventory_image = "flowers_"..name..".png",
		wield_image = "flowers_"..name..".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
		},
	})
end
