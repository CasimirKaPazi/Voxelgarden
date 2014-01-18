minetest.register_tool("nodetest:spearwood", {
	description = "Wooden Spear",
	inventory_image = "nodetest_spearwood.png",
	wield_image = "nodetest_spearwood.png^[transformFX",
	tool_capabilities = {
		full_punch_interval = 1,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.6, [3]=0.40}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	}
})

minetest.register_tool("nodetest:spearstone", {
	description = "Stone Spear",
	inventory_image = "nodetest_spearstone.png",
	wield_image = "nodetest_spearstone.png^[transformFX",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.4, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	}
})