-- mods/default/tools.lua

--
-- The Hand
--

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=1.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[2]=3.00, [3]=0.70}, uses=0, maxlevel=1},
			snappy = {times={[3]=0.40}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=7.00,[2]=5.00,[3]=1.50}, uses=0, maxlevel=3}
		},
		damage_groups = {fleshy=1},
	},
})

--
-- Tool definition
--

-- Picks
minetest.register_tool("default:pick_wood", {
	description = "Wooden Pickaxe",
	inventory_image = "default_tool_woodpick.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[3]=1.60}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})
minetest.register_tool("default:pick_stone", {
	description = "Stone Pickaxe",
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 1.3,
		max_drop_level=0,
		groupcaps={
			cracky = {times={[2]=2.0, [3]=1.20}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("default:pick_copper", {
	description = "Copper Pickaxe",
	inventory_image = "default_tool_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=5.00, [2]=1.80, [3]=1.00}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("default:pick_steel", {
	description = "Steel Pickaxe",
	inventory_image = "default_tool_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			cracky = {times={[1]=4.00, [2]=1.60, [3]=0.80}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("default:pick_mese", {
	description = "Mese Pickaxe",
	inventory_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=3,
		groupcaps={
			cracky = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=8, maxlevel=3},
			crumbly = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=8, maxlevel=3},
			snappy = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=8, maxlevel=3},
			choppy = {times={[1]=2.0, [2]=1.0, [3]=0.50}, uses=8, maxlevel=3}
		},
		damage_groups = {fleshy=5},
	},
})

-- Shovels
minetest.register_tool("default:shovel_wood", {
	description = "Wooden Shovel",
	inventory_image = "default_tool_woodshovel.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=3.00, [2]=1.60, [3]=0.60}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})
minetest.register_tool("default:shovel_stone", {
	description = "Stone Shovel",
	inventory_image = "default_tool_stoneshovel.png",
	tool_capabilities = {
		full_punch_interval = 1.4,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=1.80, [2]=1.20, [3]=0.50}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})
minetest.register_tool("default:shovel_copper", {
	description = "Copper Shovel",
	inventory_image = "default_tool_coppershovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.70, [2]=1.10, [3]=0.50}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("default:shovel_steel", {
	description = "Steel Shovel",
	inventory_image = "default_tool_steelshovel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.90, [3]=0.40}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=3},
	},
})

-- Axes
minetest.register_tool("default:axe_wood", {
	description = "Wooden Axe",
	inventory_image = "default_tool_woodaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			choppy = {times={[2]=2.50, [3]=2.00}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
})
minetest.register_tool("default:axe_stone", {
	description = "Stone Axe",
	inventory_image = "default_tool_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.50, [3]=1.30}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	},
})
minetest.register_tool("default:axe_copper", {
	description = "Copper Axe",
	inventory_image = "default_tool_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.80, [2]=1.40, [3]=1.20}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})
minetest.register_tool("default:axe_steel", {
	description = "Steel Axe",
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.30, [3]=1.00}, uses=20, maxlevel=2},
		},
		damage_groups = {fleshy=4},
	},
})

-- Swords
minetest.register_tool("default:sword_wood", {
	description = "Wooden Sword",
	inventory_image = "default_tool_woodsword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.60, [3]=0.45}, uses=5, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	}
})
minetest.register_tool("default:sword_stone", {
	description = "Stone Sword",
	inventory_image = "default_tool_stonesword.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			snappy={times={[2]=1.40, [3]=0.40}, uses=20, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	}
})
minetest.register_tool("default:sword_copper", {
	description = "Copper Sword",
	inventory_image = "default_tool_coppersword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=3.0, [2]=1.30, [3]=0.40}, uses=15, maxlevel=2},
		},
		damage_groups = {fleshy=5},
	}
})
minetest.register_tool("default:sword_steel", {
	description = "Steel Sword",
	inventory_image = "default_tool_steelsword.png",
	tool_capabilities = {
		full_punch_interval = 0.8,
		max_drop_level=1,
		groupcaps={
			snappy={times={[1]=2.5, [2]=1.20, [3]=0.35}, uses=30, maxlevel=2},
		},
		damage_groups = {fleshy=6},
	}
})
