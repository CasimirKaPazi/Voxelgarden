-- support for MT game translation.
local S = minetest.get_translator("nodetest")

minetest.register_tool("nodetest:spearwood", {
	description = S("Wooden Spear"),
	inventory_image = "nodetest_spearwood.png",
	wield_image = "nodetest_spearwood.png^[transformFX",
	range = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		groupcaps={
			snappy={times={[2]=1.6*3, [3]=0.40*3}, uses=10/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	}
})

minetest.register_tool("nodetest:spearstone", {
	description = S("Stone Spear"),
	inventory_image = "nodetest_spearstone.png",
	wield_image = "nodetest_spearstone.png^[transformFX",
	range = 5,
	tool_capabilities = {
		full_punch_interval = 1.2,
		groupcaps={
			snappy={times={[2]=1.4*3, [3]=0.30*3}, uses=20/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	}
})
