-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14
COUSHION = -10 -- Falling damage gets reduced by 10 percent.

-- Define default max stack
local stack = minetest.setting_get("stack_max")
if not stack then
	stack = 90
end
minetest.nodedef_default.stack_max = stack
minetest.craftitemdef_default.stack_max = stack
minetest.nodedef_default.liquid_range = 4
minetest.tooldef_default.range = 4.0

-- Set time to dawn on new game
minetest.register_on_newplayer(function(player)
	if minetest.get_gametime() < 5 then
		minetest.set_timeofday(0.2)
	end
end)

-- Definitions made by this mod that other mods can use too
default = {}

-- Load files
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/leafdecay.lua")
dofile(minetest.get_modpath("default").."/player.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
