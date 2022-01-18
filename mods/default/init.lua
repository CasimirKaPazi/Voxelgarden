-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- Load support for MT game translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}
default.player_attached = {}
default.LIGHT_MAX = 14
default.COUSHION = -10 -- Falling damage gets reduced by 10 percent.

-- To be loaded in separate Lua files.
default.get_translator = S

-- Define default max stack
local stack = minetest.settings:get("stack_max")
if not stack then
	stack = 60
end
minetest.nodedef_default.stack_max = stack
minetest.craftitemdef_default.stack_max = stack
if minetest.settings:get_bool("physics_liquid_falling") then
	minetest.nodedef_default.liquid_range = 1
else
	minetest.nodedef_default.liquid_range = 2
end

minetest.register_on_joinplayer(function(player)
	local physics = player:get_physics_override()
	physics.jump = 1.25
	player:set_physics_override(physics)
end)

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/gui.lua")
dofile(default_path.."/functions.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/furnace.lua")
dofile(default_path.."/chests.lua")
dofile(default_path.."/tools.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/crafting.lua")
if minetest.get_mapgen_setting("mg_name") ~= "v6" then
	dofile(default_path.."/biomes.lua")
end
dofile(default_path.."/mapgen.lua")
dofile(default_path.."/leafdecay.lua")
dofile(default_path.."/trees.lua")
dofile(default_path.."/aliases.lua")
dofile(default_path.."/legacy.lua")
