-- beds/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("beds")

beds = {}
beds.player = {}
beds.bed_position = {}
beds.pos = {}
beds.spawn = {}

local modpath = minetest.get_modpath("beds")

-- Load files

dofile(modpath .. "/functions.lua")
dofile(modpath .. "/api.lua")
dofile(modpath .. "/beds.lua")
dofile(modpath .. "/spawns.lua")
