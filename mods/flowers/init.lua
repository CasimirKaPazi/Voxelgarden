-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.
flowers = {}
-- Map Generation
dofile(minetest.get_modpath("flowers").."/mapgen.lua")

-- Aliases for original flowers mod
minetest.register_alias("flowers:flower_dandelion_white", "flowers:dandelion_white")
minetest.register_alias("flowers:flower_dandelion_yellow", "flowers:dandelion_yellow")
minetest.register_alias("flowers:flower_geranium", "flowers:geranium")
minetest.register_alias("flowers:flower_rose", "flowers:rose")
minetest.register_alias("flowers:flower_tulip", "flowers:tulip")
minetest.register_alias("flowers:flower_viola", "flowers:viola")

flowers.datas = {
--	flower name,		desc			color
	{"dandelion_white",	"White Dandelion",	{flower=1, flora=1, color_white=1}},
	{"dandelion_yellow",	"Yellow Dandelion",	{flower=1, flora=1, color_yellow=1}},
	{"geranium",		"Blue Geranium",	{flower=1, flora=1, color_blue=1}},
	{"rose",		"Rose",			{flower=1, flora=1, color_red=1}},
	{"tulip",		"Tulip",		{flower=1, flora=1, color_orange=1}},
	{"viola",		"Viola",		{flower=1, flora=1, color_violet=1}},
	{"mushroom_brown",	"Brown Mushroom",	{}},
	{"mushroom_red",	"Red Mushroom",		{}},
}

-- Flowers
for _, row in ipairs(flowers.datas) do
	local name = row[1]
	local desc = row[2]
	local groups = row[3]
	groups.dig_immediate = 3
	groups.flammable = 2
	groups.falling_node = 1
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
		floodable = true,
		groups = groups,
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0.25, 0.25},
		},
	})
end

minetest.override_item("flowers:mushroom_brown", {on_use = minetest.item_eat(1)} )
minetest.override_item("flowers:mushroom_red", {on_use = minetest.item_eat(-1)} )
