-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Definitions made by this mod that other mods can use too
default = {}
default.player_attached = {}
default.LIGHT_MAX = 14
default.COUSHION = -10 -- Falling damage gets reduced by 10 percent.

-- Define default max stack
local stack = minetest.settings:get("stack_max")
if not stack then
	stack = 90
end
minetest.nodedef_default.stack_max = stack
minetest.craftitemdef_default.stack_max = stack
minetest.nodedef_default.liquid_range = 2

-- Set time to dawn on new game
minetest.register_on_newplayer(function(player)
	if minetest.get_gametime() < 5 then
		minetest.set_timeofday(0.25)
	end
end)

minetest.register_on_respawnplayer(function(player)
	if minetest.is_singleplayer() then
		minetest.set_timeofday(0.25)
	end
end)

-- Load files
dofile(minetest.get_modpath("default").."/gui.lua")
dofile(minetest.get_modpath("default").."/functions.lua")
dofile(minetest.get_modpath("default").."/nodes.lua")
dofile(minetest.get_modpath("default").."/furnace.lua")
dofile(minetest.get_modpath("default").."/tools.lua")
dofile(minetest.get_modpath("default").."/craftitems.lua")
dofile(minetest.get_modpath("default").."/crafting.lua")
if minetest.get_mapgen_params().mgname ~= "v6" then
	dofile(minetest.get_modpath("default").."/biomes.lua")
end
dofile(minetest.get_modpath("default").."/mapgen.lua")
dofile(minetest.get_modpath("default").."/leafdecay.lua")
dofile(minetest.get_modpath("default").."/trees.lua")
dofile(minetest.get_modpath("default").."/aliases.lua")

-- Legacy:
WATER_ALPHA = minetest.registered_nodes["default:water_source"].alpha
WATER_VISC = minetest.registered_nodes["default:water_source"].liquid_viscosity
LAVA_VISC = minetest.registered_nodes["default:lava_source"].liquid_viscosity
LIGHT_MAX = default.LIGHT_MAX
