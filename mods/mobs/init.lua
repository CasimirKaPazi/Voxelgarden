
local path = minetest.get_modpath("mobs")


-- Mobs Api

mobs = {}
mobs.mod = "redo"
mobs.version = "20180808"


-- Intllib
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP .. "/intllib.lua")
mobs.intllib = S


-- CMI support check
local use_cmi = minetest.global_exists("cmi")


-- Invisibility mod check
mobs.invis = {}
if minetest.global_exists("invisibility") then
	mobs.invis = invisibility
end


-- creative check
local creative_mode_cache = minetest.settings:get_bool("creative_mode")
function mobs.is_creative(name)
	return creative_mode_cache or minetest.check_player_privs(name, {creative = true})
end

-- Mob functions
--dofile(path .. "/functions.lua")

-- Mob API
dofile(path .. "/api.lua")

-- Rideable Mobs
dofile(path .. "/mount.lua")

minetest.log("action", "[MOD] Mobs Redo loaded")
