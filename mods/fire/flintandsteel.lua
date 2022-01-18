-- support for MT game translation.
local S = minetest.get_translator("fire")

local function strike_fire(user, pointed_thing)
	-- Fire priviledge
	local name = user:get_player_name()
	if not minetest.get_player_privs(name)["fire"] then 
		minetest.chat_send_player(name, S("You need the 'fire' privilege."))
		return
	end
	-- Use tinder, place flame
	if pointed_thing.type == "node" then
		local n_pointed_above = minetest.get_node(pointed_thing.above)
		if not n_pointed_above.name == "air" then return end
		local tinder = user:get_inventory():get_stack("main", user:get_wield_index()+1):get_name()
		if tinder == "fire:tinder" then
			user:get_inventory():remove_item("main", "fire:tinder")
			minetest.add_node(pointed_thing.above, {name="fire:basic_flame"})
			return true
		else
			minetest.chat_send_player(name, S("You need tinder right to the tool."))
		end
	end
end

minetest.register_craftitem("fire:tinder", {
	description = S("Tinder"),
	inventory_image = "flint_tinder.png",
})

minetest.register_tool("fire:flint_and_steel", {
	description = S("Fire Striker"),
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
	output = 'fire:flint_and_steel',
	recipe = {
		{'default:flint', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'fire:tinder',
	recipe = {
		{'farming:cotton'},
	}
})

minetest.register_craft({
	output = 'fire:tinder',
	recipe = {
		{'farming:wheat'},
	}
})

minetest.register_craft({
	output = 'fire:tinder',
	recipe = {
		{'default:paper'},
	}
})
