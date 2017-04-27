minetest.register_privilege("fire", {
	description = "Player can set fire.",
	give_to_singleplayer = true
})

local function strike_fire(user, pointed_thing)
	-- Fire priviledge
	local name = user:get_player_name()
	if not minetest.get_player_privs(name)["fire"] then 
		minetest.chat_send_player(name, "You need the fire privilege.")
		return
	end
	-- Use tinder, place flame
	if pointed_thing.type == "node" then
		local n_pointed_above = minetest.get_node(pointed_thing.above)
		if not n_pointed_above.name == "air" then return end
		local tinder = user:get_inventory():get_stack("main", user:get_wield_index()+1):get_name()
		if tinder == "flint:tinder" then
			user:get_inventory():remove_item("main", "flint:tinder")
			minetest.add_node(pointed_thing.above, {name="fire:basic_flame"})
			return true
		else
			minetest.chat_send_player(name, "You need tinder right to the tool.")
		end
	end
end

-- Items

minetest.register_node("flint:silex_ore", {
	description = "Flint Block",
	tiles = {"default_gravel.png^flint_silex_ore.png"},
	is_ground_content = true,
	drop = "flint:silex 4",
	groups = {crumbly=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craftitem("flint:silex", {
	description = "Silex",
	inventory_image = "flint_silex.png",
	groups = {stone=2},
})

minetest.register_craftitem("flint:tinder", {
	description = "Tinder",
	inventory_image = "flint_tinder.png",
})

-- Tools

minetest.register_tool("flint:handaxe", {
	description = "Handaxe",
	inventory_image = "flint_handaxe.png",
	tool_capabilities = {
		groupcaps={
			choppy={times={[1]=3.60, [2]=2.20, [3]=2.00}, uses=10, maxlevel=3},
			fleshy={times={[2]=1.00, [3]=0.60}, uses=15, maxlevel=1},
			crumbly={times={[1]=1.70, [2]=0.70, [3]=0.50}, uses=5, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0, maxlevel=3},
		},
		damage_groups = {fleshy=2}
	},
})

minetest.register_tool("flint:firestriker", {
	description = "Fire Striker",
	inventory_image = "flint_firestriker.png",
	range = 2.0,
	on_place = function(itemstack, user, pointed_thing)
			if strike_fire(user, pointed_thing) then
				itemstack:add_wear(65535/15)
			end
			return itemstack
		end
})

-- Craft

minetest.register_craft({
	type = 'shapeless',
	output = 'flint:firestriker',
	recipe = {'flint:silex', 'default:steel_ingot'},
})

minetest.register_craft({
	output = 'flint:handaxe',
	recipe = {
		{'flint:silex'},
	}
})

minetest.register_craft({
	output = 'flint:tinder',
	recipe = {
		{'farming:cotton'},
	}
})

minetest.register_craft({
	output = 'flint:tinder',
	recipe = {
		{'farming:wheat'},
	}
})

minetest.register_craft({
	output = 'flint:tinder',
	recipe = {
		{'default:paper'},
	}
})

minetest.register_craft({
	output = 'flint:silex 4',
	recipe = {
		{'nodetest:rock'},
	}
})

minetest.register_craft({
	output = 'nodetest:rock',
	recipe = {
		{'flint:silex', 'flint:silex'},
		{'flint:silex', 'flint:silex'},
	}
})

-- Mapgen

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "flint:silex_ore",
	wherein        = {"default:gravel", "default:stone"},
	clust_scarcity = 8*8*8,
	clust_num_ores = 1,
	clust_size     = 3,
	y_min     = -32,
	y_max     = 1024,
})
-- Alias

minetest.register_alias("nodetest:rock", "flint:silex_ore")
