--
-- Crafting definition
--

minetest.register_craft({
	output = 'default:wood 2',
	recipe = {
		{'group:tree_horizontal'},
	}
})

minetest.register_craft({
	output = 'nodetest:tree_horizontal 2',
	recipe = {
		{'', 'default:tree'},
		{'default:tree', ''},
	}
})

minetest.register_craft({
	output = 'default:tree 2',
	recipe = {
		{'', 'nodetest:tree_horizontal'},
		{'nodetest:tree_horizontal', ''},
	}
})

minetest.register_craft({
	output = 'nodetest:jungletree_horizontal 2',
	recipe = {
		{'', 'default:jungletree'},
		{'default:jungletree', ''},
	}
})

minetest.register_craft({
	output = 'default:jungletree 2',
	recipe = {
		{'', 'nodetest:jungletree_horizontal'},
		{'nodetest:jungletree_horizontal', ''},
	}
})

minetest.register_craft({
	output = 'nodetest:papyrus_roots',
	recipe = {
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
		{'default:papyrus', 'default:papyrus', 'default:papyrus'},
	}
})

minetest.register_craft({
	output = 'default:papyrus 9',
	recipe = {
		{'nodetest:papyrus_roots'},
	}
})

minetest.register_craft({
	output = 'nodetest:desert_sandstone',
	recipe = {
		{'default:desert_sand', 'default:desert_sand'},
		{'default:desert_sand', 'default:desert_sand'},
	}
})

minetest.register_craft({
	output = 'default:desert_sand 4',
	recipe = {
		{'nodetest:desert_sandstone'},
	}
})

minetest.register_craft({
	output = 'nodetest:rock',
	recipe = {
		{'default:cobble', 'default:cobble'},
		{'default:cobble', 'default:cobble'},
	}
})

minetest.register_craft({
	output = 'default:cobble 4',
	recipe = {
		{'nodetest:rock'},
	}
})

minetest.register_craft({
	output = 'nodetest:bone 9',
	recipe = {
		{'bones:bones'},
	}
})

minetest.register_craft({
	output = 'bones:bones',
	recipe = {
		{'nodetest:bone', 'nodetest:bone', 'nodetest:bone'},
		{'nodetest:bone', 'nodetest:bone', 'nodetest:bone'},
		{'nodetest:bone', 'nodetest:bone', 'nodetest:bone'},
	}
})

minetest.register_craft({
	output = 'dye:white',
	recipe = {
		{'nodetest:bone'},
	}
})

minetest.register_craft({
	output = 'nodetest:spearwood',
	recipe = {
		{'', '', 'default:stick'},
		{'', 'default:stick', ''},
		{'default:stick', '', ''},
	}
})

minetest.register_craft({
	output = 'nodetest:spearstone',
	recipe = {
		{'', '', 'group:stone'},
		{'', 'default:stick', ''},
		{'default:stick', '', ''},
	}
})

minetest.register_craft({
	output = 'default:clay_lump 4',
	recipe = {
		{'default:clay'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "default:coal_lump",
	recipe = "group:tree_horizontal",
})

minetest.register_craft({
	output = 'nodetest:seedling 4',
	recipe = {
		{'group:sapling'},
	}
})

minetest.register_craft({
	output = "nodetest:bonfire",
	recipe = {
		{"", "group:wood", ""},
		{"group:wood", "group:leaves", "group:wood"},
	}
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree_horizontal",
	burntime = 30,
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "nodetest:desert_sandstone",
})
