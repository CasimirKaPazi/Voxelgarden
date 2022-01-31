-- mods/default/tools.lua
-- support for MT game translation.
local S = default.get_translator

-- To stay simple all tools use maxlevel 3.
-- The engine assumes maxlevel=1, so we have to specify it.
-- Uses are affected by level differnece of tool and node by a factor d^3.
-- To get the uses we want, we divide by 3^3.

-- Dig times are divided by leveldiff. Therefor we multiply everything by 3.

--
-- The Hand
--

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=1,z=1.5},
	range = 4.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps = {
			crumbly = {times={[2]=2.50*3, [3]=1.00*3}, uses=0, maxlevel=3},
			snappy = {times={[3]=0.60*3}, uses=0, maxlevel=3},
			oddly_breakable_by_hand = {times={[1]=1.80*3,[2]=1.20*3,[3]=0.40*3}, uses=0}
		},
		damage_groups = {fleshy=1},
	},
})

--
-- Tool definition
--

-- Picks
minetest.register_tool("default:pick_wood", {
	description = S("Wooden Pickaxe"),
	inventory_image = "default_tool_woodpick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[3]=1.2*3}, uses=30/27, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	sound = {breaks = "default_tool_breaks"},
})
minetest.register_tool("default:pick_stone", {
	description = S("Stone Pickaxe"),
	inventory_image = "default_tool_stonepick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[3]=0.75*3}, uses=120/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_copper", {
	description = S("Copper Pickaxe"),
	inventory_image = "default_tool_copperpick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[2]=1.00*3, [3]=0.60*3}, uses=90/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool(":default:pick_bronze", {
	description = S("Bronze Pickaxe"),
	inventory_image = "default_tool_bronzepick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[2]=0.75*3, [3]=0.45*3}, uses=180/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_steel", {
	description = S("Steel Pickaxe"),
	inventory_image = "default_tool_steelpick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[1]=1.50*3, [2]=0.60*3, [3]=0.30*3}, uses=210/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:pick_mese", {
	description = S("Mese Pickaxe"),
	inventory_image = "default_tool_mesepick.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			cracky = {times={[1]=1.0*3, [2]=0.40*3, [3]=0.20*3}, uses=45/27, maxlevel=3},
			crumbly = {times={[1]=1.0*3, [2]=0.40*3, [3]=0.20*3}, uses=45/27, maxlevel=3},
			snappy = {times={[1]=1.0*3, [2]=0.40*3, [3]=0.20*3}, uses=45/27, maxlevel=3},
			choppy = {times={[1]=1.0*3, [2]=0.40*3, [3]=0.20*3}, uses=45/27, maxlevel=3}
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Shovels
minetest.register_tool("default:shovel_wood", {
	description = S("Wooden Shovel"),
	inventory_image = "default_tool_woodshovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[2]=1.50*3, [3]=0.60*3}, uses=30/27, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_stone", {
	description = S("Stone Shovel"),
	inventory_image = "default_tool_stoneshovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[1]=1.20*3, [2]=0.80*3, [3]=0.40*3}, uses=120/27, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_copper", {
	description = S("Copper Shovel"),
	inventory_image = "default_tool_coppershovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[1]=0.80*3, [2]=0.70*3, [3]=0.30*3}, uses=90/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool(":default:shovel_bronze", {
	description = S("Bronze Shovel"),
	inventory_image = "default_tool_bronzeshovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[1]=0.70*3, [2]=0.60*3, [3]=0.25*3}, uses=180/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:shovel_steel", {
	description = S("Steel Shovel"),
	inventory_image = "default_tool_steelshovel.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[1]=0.60*3, [2]=0.45*3, [3]=0.20*3}, uses=210/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Axes
minetest.register_tool("default:axe_wood", {
	description = S("Wooden Axe"),
	inventory_image = "default_tool_woodaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			choppy = {times={[2]=1.50*3, [3]=1.20*3}, uses=30/27, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_stone", {
	description = S("Stone Axe"),
	inventory_image = "default_tool_stoneaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			choppy={times={[1]=1.00*3, [2]=0.80*3, [3]=0.60*3}, uses=120/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_copper", {
	description = S("Copper Axe"),
	inventory_image = "default_tool_copperaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			choppy={times={[1]=0.80*3, [2]=0.60*3, [3]=0.40*3}, uses=90/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool(":default:axe_bronze", {
	description = S("Bronze Axe"),
	inventory_image = "default_tool_bronzeaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			choppy={times={[1]=0.70*3, [2]=0.50*3, [3]=0.30*3}, uses=180/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:axe_steel", {
	description = S("Steel Axe"),
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			choppy={times={[1]=0.60*3, [2]=0.40*3, [3]=0.20*3}, uses=210/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

-- Swords
minetest.register_tool("default:sword_wood", {
	description = S("Wooden Sword"),
	inventory_image = "default_tool_woodsword.png",
	range = 3.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			snappy={times={[2]=2.8*3, [3]=0.60*3}, uses=90/27, maxlevel=3},
		},
		damage_groups = {fleshy=1},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_stone", {
	description = S("Stone Sword"),
	inventory_image = "default_tool_stonesword.png",
	range = 3.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			snappy={times={[2]=1.20*3, [3]=0.50*3}, uses=360/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_copper", {
	description = S("Copper Sword"),
	inventory_image = "default_tool_coppersword.png",
	range = 3.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			snappy={times={[1]=2.8*3, [2]=1.10*3, [3]=0.40*3}, uses=240/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_bronze", {
	description = S("Bronze Sword"),
	inventory_image = "default_tool_bronzesword.png",
	range = 3.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			snappy={times={[1]=2.6*3, [2]=1.00*3, [3]=0.30*3}, uses=360
/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:sword_steel", {
	description = S("Steel Sword"),
	inventory_image = "default_tool_steelsword.png",
	range = 3.0,
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			snappy={times={[1]=2.4*3, [2]=0.90*3, [3]=0.20*3}, uses=540/27, maxlevel=3},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool("default:spearwood", {
	description = S("Wooden Spear"),
	inventory_image = "default_spearwood.png",
	wield_image = "default_spearwood.png^[transformFX",
	range = 5,
	tool_capabilities = {
		full_punch_interval = 1,
		groupcaps={
			snappy={times={[2]=1.6*3, [3]=0.40*3}, uses=10/27, maxlevel=3},
		},
		damage_groups = {fleshy=2},
	}
})

minetest.register_tool("default:spearstone", {
	description = S("Stone Spear"),
	inventory_image = "default_spearstone.png",
	wield_image = "default_spearstone.png^[transformFX",
	range = 5,
	tool_capabilities = {
		full_punch_interval = 1.2,
		groupcaps={
			snappy={times={[2]=1.4*3, [3]=0.30*3}, uses=20/27, maxlevel=3},
		},
		damage_groups = {fleshy=3},
	}
})
