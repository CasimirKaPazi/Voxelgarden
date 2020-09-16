-- Load support for MT game translation.
local S = minetest.get_translator("mobs_flat")

local path = minetest.get_modpath("mobs_flat")

mobs_flat = {}

dofile(path .. "/oerkki.lua")
dofile(path .. "/omsk.lua")
dofile(path .. "/dustdevil.lua")
dofile(path .. "/rat.lua")
dofile(path .. "/dungeonmaster.lua")
