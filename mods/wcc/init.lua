--[[
  weighted companion cube for minetest
	by Melkor
	
	Weighted Companion Cube for Celeron55' MineTest
  texture and nodebox Made By Melkor 
  Licence:
  Textures WTFPL
  Code WTFPL
--]]

dofile(minetest.get_modpath("wcc").."/mapgen.lua")

minetest.register_node("wcc:wcc", {
	description = 'Weighted Companion Cube',
	is_ground_content = true,
	groups = {falling_node=1},
	tiles = {
		"wcc_wcc.png",
	},
	drawtype = "nodebox",
	sunlight_propagates = false,
	paramtype = 'light',
	paramtype2 = "facedir",
		node_box = {
		type = "fixed",
		fixed = {
-- lets do it!
--		main body
			{-0.43750,-0.43750,-0.43750, 0.43750,0.43750,0.43750},
--		extras
			{-0.50000,0.18750,-0.50000,	-0.18750,0.50000,-0.18750},
			{-0.50000,-0.50000,-0.50000,	-0.18750,-0.18750,-0.18750},
			{-0.50000,0.18750,0.18750,		-0.18750,0.50000,0.50000},
			{-0.50000,-0.50000,0.18750,	-0.18750,-0.18750,0.50000},
			{0.18750,0.18750,0.18750,		0.50000,0.50000,0.50000},
			{0.18750,-0.50000,0.18750,		0.50000,-0.18750,0.50000},
			{0.18750,0.18750,-0.50000,		0.50000,0.50000,-0.18750},
			{0.18750,-0.50000,-0.50000,	0.50000,-0.18750,-0.18750},
		},
	},
})
