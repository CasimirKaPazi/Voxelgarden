-- Export functions
farming = {}

-- ========= API =========
dofile(minetest.get_modpath("farming").."/api.lua")

-- ========= SOIL =========
dofile(minetest.get_modpath("farming").."/soil.lua")

-- ========= HOES =========
dofile(minetest.get_modpath("farming").."/hoes.lua")

-- ========= PLANTS =========
dofile(minetest.get_modpath("farming").."/plants.lua")
