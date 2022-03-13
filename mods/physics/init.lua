dofile(minetest.get_modpath(minetest.get_current_modname()).."/falling.lua")

if minetest.settings:get_bool("physics_liquid_falling") then
	dofile(minetest.get_modpath(minetest.get_current_modname()).."/liquids_falling.lua")
else
	dofile(minetest.get_modpath(minetest.get_current_modname()).."/liquids_static.lua")
end
