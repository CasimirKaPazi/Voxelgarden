-- mods/default/craftitems.lua

--
-- Crafting items
--

minetest.register_craftitem("default:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = {stick=1},
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
})

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
})

minetest.register_craftitem("default:coal_lump", {
	description = "Coal Lump",
	inventory_image = "default_coal_lump.png",
})

minetest.register_craftitem("default:iron_lump", {
	description = "Iron Lump",
	inventory_image = "default_iron_lump.png",
})

minetest.register_craftitem("default:tin_lump", {
	description = "Tin Lump",
	inventory_image = "default_tin_lump.png",
})

minetest.register_craftitem("default:copper_lump", {
	description = "Copper Lump",
	inventory_image = "default_copper_lump.png",
})

minetest.register_craftitem("default:mese_crystal", {
	wield_scale = {x=1,y=1,z=0},
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay Lump",
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "default_steel_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:copper_ingot", {
	description = "Copper Ingot",
	inventory_image = "default_copper_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:tin_ingot", {
	description = "Tin Ingot",
	inventory_image = "default_tin_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:bronze_ingot", {
	description = "Bronze Ingot",
	inventory_image = "default_bronze_ingot.png",
	groups = {metal_ingot=1},
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	wield_scale = {x=1,y=1,z=0},
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "default_obsidian_shard.png",
})
