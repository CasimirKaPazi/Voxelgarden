-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into doc/lua_api.txt

WATER_ALPHA = 160
WATER_VISC = 1
LAVA_VISC = 7
LIGHT_MAX = 14

-- Definitions made by this mod that other mods can use too
default = {}

-- Load other files
dofile(minetest.get_modpath(minetest.get_current_modname()).."/functions.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/hand.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/nodes.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/tools.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/craftitems.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/crafting.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/mapgen.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/leafdecay.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/player.lua")


-- Support old code
function default.spawn_falling_node(p, nodename)
	spawn_falling_node(p, nodename)
end

-- Horrible crap to support old code
-- Don't use this and never do what this does, it's completely wrong!
-- (More specifically, the client and the C++ code doesn't get the group)
function default.register_falling_node(nodename, texture)
	minetest.log("error", debug.traceback())
	minetest.log('error', "WARNING: default.register_falling_node is deprecated")
	if minetest.registered_nodes[nodename] then
		minetest.registered_nodes[nodename].groups.falling_node = 1
	end
end

-- END
