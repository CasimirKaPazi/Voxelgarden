-- mods/default/craftitems.lua

--
-- Crafting items
--

-- support for MT game translation.
local S = default.get_translator

minetest.register_craftitem("nodetest:bone", {
	description = S("Bone"),
	inventory_image = "nodetest_bone.png",
})
