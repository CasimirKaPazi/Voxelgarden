-- mods/default/craftitems.lua

--
-- Crafting items
--

-- support for MT game translation.
local S = minetest.get_translator("nodetest")

minetest.register_craftitem("nodetest:bone", {
	description = S("Bone"),
	inventory_image = "nodetest_bone.png",
})
