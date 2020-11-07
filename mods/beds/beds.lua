-- support for MT game translation.
local S = minetest.get_translator("beds")

beds.register_bed("beds:bed", {
	description = S("Bed"),
	inventory_image = "beds_bed.png",
	wield_image = "beds_bed.png",
	tiles = {
		bottom = {
			"beds_bed_top_bottom.png^[transformR90",
			"beds_bed_under.png",
			"beds_bed_side_bottom_r.png",
			"beds_bed_side_bottom_r.png^[transformfx",
			"beds_bed_under.png",
			"beds_bed_side_bottom.png"
		},
		top = {
			"beds_bed_top_top.png^[transformR90",
			"beds_bed_under.png",
			"beds_bed_side_top_r.png",
			"beds_bed_side_top_r.png^[transformfx",
			"beds_bed_side_top.png",
			"beds_bed_under.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "beds:bed_bottom",
	burntime = 32,
})
