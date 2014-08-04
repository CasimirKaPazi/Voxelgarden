conifer = {}

--
-- Nodes
--

minetest.register_node("conifer:sapling", {
	description = "Conifer Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"conifer_sapling.png"},
	inventory_image = "conifer_sapling.png",
	wield_image = "conifer_sapling.png",
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
	},
	groups = {snappy=2, dig_immediate=3, sapling=1, flammable=2, attached_node=1, dissolve=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_alias("conifers:sapling", "conifer:sapling")
minetest.register_alias("nodetest:conifersapling", "conifer:sapling")

minetest.register_node("conifer:tree", {
	description = "Conifer Tree",
	tiles = {"conifer_tree_top.png", "conifer_tree_top.png", "conifer_tree.png"},
	groups = {tree=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("conifers:trunk", "conifer:tree")
minetest.register_alias("nodetest:conifertree", "conifer:tree")

for i=1,2 do
	minetest.register_node("conifer:leaves_"..i, {
		description = "Conifer Leaves",
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = {"conifer_leaves_"..i..".png"},
		paramtype = "light",
		waving = 1,
		groups = {snappy=3, leafdecay=4, flammable=2, leaves=1, fall_damage_add_percent=COUSHION},
		drop = {
			max_items = 1,
			items = {
				{
					-- player will get sapling with 1/30 chance
					items = {'conifer:sapling'},
					rarity = 30,
				},
				{
					-- player will get leaves only if he get no saplings,
					-- this is because max_items is 1
					items = {"conifer:leaves_"..i..""},
				}
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})
	minetest.register_alias("nodetest:coniferleaves_"..i, "conifer:leaves_"..i)
end
minetest.register_alias("conifers:leaves", "conifer:leaves_1")
minetest.register_alias("conifers:leaves_special", "conifer:leaves_2")

minetest.register_node("conifer:tree_horizontal", {
	description = "Conifer Tree",
	tiles = {
		"conifer_tree.png", 
		"conifer_tree.png",
		"conifer_tree.png^[transformR90", 
		"conifer_tree.png^[transformR90", 
		"conifer_tree_top.png", 
		"conifer_tree_top.png" 
	},
	paramtype2 = "facedir",
	groups = {tree_horizontal=1, choppy=2, flammable=1, melt=750},
	melt = "default:coal_block",
	sounds = default.node_sound_wood_defaults(),
})
minetest.register_alias("conifers:trunk_reversed", "conifer:tree_horizontal")
minetest.register_alias("nodetest:conifertree_horizontal", "conifer:tree_horizontal")

--
-- Crafting definition
--

minetest.register_craft({
	output = 'conifer:tree_horizontal 2',
	recipe = {
		{'', 'conifer:tree'},
		{'conifer:tree', ''},
	}
})

minetest.register_craft({
	output = 'conifer:tree 2',
	recipe = {
		{'', 'conifer:tree_horizontal'},
		{'conifer:tree_horizontal', ''},
	}
})

--
-- Grow tree
--

minetest.register_abm({
	nodenames = {"conifer:sapling"},
	interval = 13,
	chance = 50,
	action = function(pos, node)
		local ground_name = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.registered_nodes[ground_name].groups.soil
		if not is_soil or is_soil == 0 then return end
		local snow = false
		if ground_name == "default:dirt_with_snow" then
			snow = true
		end
		-- When to close to other trees, turn to decoration.
		r = math.random(1, 2)
		if minetest.find_node_near(pos, r, {"group:tree", "group:sapling"}) then
			minetest.set_node(pos, {name="conifer:leaves_"..math.random(1, 2)})
			return
		end
		local above_name = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
		if above_name ~= "air" and above_name ~= "ignore" then return end
		-- Otherwise grow a tree.
--		print("A conifer sapling grows into a tree at "..minetest.pos_to_string(pos))
		local vm = minetest.get_voxel_manip()
		local minp, maxp = vm:read_from_map({x=pos.x-8, y=pos.y, z=pos.z-8}, {x=pos.x+8, y=pos.y+32, z=pos.z+8})
		local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		local data = vm:get_data()
		conifer.grow_conifertree(data, a, pos, math.random(1, 4) == 1, snow, math.random(1,100000))
		vm:set_data(data)
		vm:write_to_map(data)
		vm:update_map()
        end
})

dofile(minetest.get_modpath("conifer").."/trees.lua")
