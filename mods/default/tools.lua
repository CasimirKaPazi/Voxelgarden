-- mods/default/tools.lua
-- support for MT game translation.
local S = default.get_translator

-- To stay simple tools don't use maxlevel.
-- The engine assumes maxlevel=0, so we have to specify 0
-- A bug adds + 1 to uses, so we subtract 1.

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
			crumbly = {times={[2]=2.50, [3]=1.00}, uses=0, maxlevel=0},
			snappy = {times={[3]=0.60}, uses=0, maxlevel=0},
			oddly_breakable_by_hand = {times={[1]=1.80,[2]=1.20,[3]=0.40}, uses=0}
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
			cracky = {times={[3]=1.2}, uses=30-1, maxlevel=0},
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
			cracky = {times={[3]=0.75}, uses=120-1, maxlevel=0},
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
			cracky = {times={[2]=1.00, [3]=0.60}, uses=90-1, maxlevel=0},
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
			cracky = {times={[2]=0.75, [3]=0.45}, uses=120-1, maxlevel=0},
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
			cracky = {times={[1]=1.50, [2]=0.60, [3]=0.30}, uses=180-1, maxlevel=0},
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
			cracky = {times={[1]=1.0, [2]=0.40, [3]=0.20}, uses=45-1, maxlevel=0},
			crumbly = {times={[1]=1.0, [2]=0.40, [3]=0.20}, uses=45-1, maxlevel=0},
			snappy = {times={[1]=1.0, [2]=0.40, [3]=0.20}, uses=45-1, maxlevel=0},
			choppy = {times={[1]=1.0, [2]=0.40, [3]=0.20}, uses=45-1, maxlevel=0}
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
			crumbly = {times={[2]=1.50, [3]=0.60}, uses=30-1, maxlevel=0},
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
			crumbly = {times={[1]=1.20, [2]=0.80, [3]=0.40}, uses=120-1, maxlevel=0},
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
			crumbly = {times={[1]=0.80, [2]=0.70, [3]=0.30}, uses=90-1, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
})

minetest.register_tool(":default:shovel_bronze", {
	description = S("Bronze Shovel"),
	inventory_image = "default_tool_bronzeshovel.png",
	wield_image = "default_tool_bronzeshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.5,
		groupcaps={
			crumbly = {times={[1]=0.70, [2]=0.60, [3]=0.25}, uses=120-1, maxlevel=0},
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
			crumbly = {times={[1]=0.60, [2]=0.45, [3]=0.20}, uses=180-1, maxlevel=0},
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
			choppy = {times={[2]=1.50, [3]=1.20}, uses=30-1, maxlevel=0},
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
			choppy={times={[1]=1.00, [2]=0.80, [3]=0.60}, uses=120-1, maxlevel=0},
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
			choppy={times={[1]=0.80, [2]=0.60, [3]=0.40}, uses=90-1, maxlevel=0},
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
			choppy={times={[1]=0.70, [2]=0.50, [3]=0.30}, uses=120-1, maxlevel=0},
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
			choppy={times={[1]=0.60, [2]=0.40, [3]=0.20}, uses=180-1, maxlevel=0},
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
			snappy={times={[2]=2.8, [3]=0.60}, uses=90-1, maxlevel=0},
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
			snappy={times={[2]=1.20, [3]=0.50}, uses=360-1, maxlevel=0},
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
			snappy={times={[1]=2.8, [2]=1.10, [3]=0.40}, uses=240-1, maxlevel=0},
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
			snappy={times={[1]=2.6, [2]=1.00, [3]=0.30}, uses=360
-1, maxlevel=0},
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
			snappy={times={[1]=2.4, [2]=0.90, [3]=0.20}, uses=540-1, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
})
