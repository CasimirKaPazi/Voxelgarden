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

-- Use tools right click to place nodes
minetest.tooldef_default.on_place = function(itemstack, user, pointed)
	if not pointed then return end
	local above = minetest.env:get_node(pointed.above)
	local inv = user:get_inventory()
	local idx = user:get_wield_index()+1
	local stack = inv:get_stack("main", idx)
	local success
	stack, success = minetest.item_place(stack, user, pointed)
	if success then --if item was placed, put modified stack back in inv
		inv:set_stack("main", idx, stack)
	end
end

-- Set time to dawn on new game
minetest.register_on_newplayer(function(player)
	if minetest.get_gametime() < 5 then
		minetest.set_timeofday(0.22)
	end
end)

minetest.register_on_respawnplayer(function(player)
	if minetest.is_singleplayer() then
		minetest.set_timeofday(0.22)
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
dofile(minetest.get_modpath("default").."/aliases.lua")
