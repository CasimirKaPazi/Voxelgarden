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

minetest.register_craftitem("flint:tinder", {
	description = "Tinder",
	inventory_image = "flint_tinder.png",
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
	output = 'flint:firestriker',
	recipe = {
		{'default:steel_ingot', 'default:small_stone'},
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

-- Alias

minetest.register_alias("nodetest:rock", "default:gravel")
minetest.register_alias("flint:silex_ore", "default:gravel")
minetest.register_alias("flint:silex", "default:small_stone")
