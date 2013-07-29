-- ========= SOIL =========
dofile(minetest.get_modpath("farming").."/soil.lua")

-- ========= HOES =========
dofile(minetest.get_modpath("farming").."/hoes.lua")

-- ========= WHEAT =========
dofile(minetest.get_modpath("farming").."/wheat.lua")

-- ========= COTTON =========
dofile(minetest.get_modpath("farming").."/cotton.lua")

-- ========= WEED =========
dofile(minetest.get_modpath("farming").."/weed.lua")

-- ========= Alias =========
-- [[
minetest.register_alias("garden:weed", "farming:weed")
minetest.register_alias("garden:string", "farming:string")
minetest.register_alias("garden:cotton", "farming:cotton")
minetest.register_alias("garden:cotton_1", "farming:cotton_1")
minetest.register_alias("garden:cotton_2", "farming:cotton_2")
minetest.register_alias("garden:cotton_3", "farming:cotton_3")
minetest.register_alias("garden:wheat_1", "farming:wheat_1")
minetest.register_alias("garden:wheat_2", "farming:wheat_2")
minetest.register_alias("garden:wheat_3", "farming:wheat_3")
minetest.register_alias("garden:wheat_4", "farming:wheat_4")
minetest.register_alias("garden:wheat", "farming:wheat")
minetest.register_alias("garden:flour", "farming:flour")
minetest.register_alias("garden:dough", "farming:dough")
minetest.register_alias("garden:bread", "farming:bread")
minetest.register_alias("garden:soil", "farming:soil")
minetest.register_alias("garden:soil_wet", "farming:soil_wet")
minetest.register_alias("garden:hoe_wood", "farming:hoe_wood")
minetest.register_alias("garden:hoe_stone", "farming:hoe_stone")
minetest.register_alias("garden:hoe_steel", "farming:hoe_steel")
--]]
