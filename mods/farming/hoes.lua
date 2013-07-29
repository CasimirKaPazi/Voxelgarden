local function create_soil(pos)
	if pos == nil then
		return false
	end
	local above = minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if above.name == "air" then
		minetest.env:set_node(pos, {name = "farming:soil"})
		return true
	end
	return false
end

local function create_soil_mese(pos)
	if pos == nil then
		return false
	end
	local nn = minetest.env:get_node(pos).name
	if nn ~= "default:dirt" and nn ~= "default:dirt_with_grass" and nn ~= "default:dirt_with_grass_footsteps" then
		return false
	end
	local above = minetest.env:get_node({x=pos.x, y=pos.y+1, z=pos.z})
	if above.name == "air" then
		minetest.env:set_node(pos, {name = "farming:soil"})
		return true
	end
	return false
end

minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger then return end
	if oldnode.name == "default:dirt" or oldnode.name == "default:dirt_with_grass" or oldnode.name == "default:dirt_with_grass_footsteps" then
		local wield_name = digger:get_wielded_item():get_name()
		if wield_name == "farming:hoe_wood" or wield_name == "farming:hoe_stone" or wield_name == "farming:hoe_steel" then
			if create_soil(pos) then
				digger:get_inventory():remove_item("main", "default:dirt")
			end
		elseif wield_name == "farming:hoe_mese" then
			if create_soil(pos) then
				digger:get_inventory():remove_item("main", "default:dirt")
				if create_soil_mese({x=pos.x+1, y=pos.y, z=pos.z}) then
					digger:get_inventory():remove_item("main", "default:dirt")
				end
				if create_soil_mese({x=pos.x-1, y=pos.y, z=pos.z}) then
					digger:get_inventory():remove_item("main", "default:dirt")
				end
				if create_soil_mese({x=pos.x, y=pos.y, z=pos.z+1}) then
					digger:get_inventory():remove_item("main", "default:dirt")
				end
				if create_soil_mese({x=pos.x, y=pos.y, z=pos.z-1}) then
					digger:get_inventory():remove_item("main", "default:dirt")
				end
			end
		end
	end
end)

minetest.register_tool("farming:hoe_wood", {
	description = "Wood Hoe",
	inventory_image = "farming_hoe_wood.png",
	tool_capabilities = {
		full_punch_interval = 1.2,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=3.20, [2]=0.90, [3]=0.70}, uses=10, maxlevel=1},
		}
	},
})

minetest.register_craft({
	output = "farming:hoe_wood",
	recipe = {
		{"group:wood", "group:wood"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})

minetest.register_craft({
	output = "farming:hoe_wood",
	recipe = {
		{"default:wood", "default:wood"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})

minetest.register_tool("farming:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "farming_hoe_stone.png",
	tool_capabilities = {
		full_punch_interval = 1.4,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=1.70, [2]=0.80, [3]=0.60}, uses=20, maxlevel=1},
		}
	},
})

minetest.register_craft({
	output = "farming:hoe_stone",
	recipe = {
		{"group:stone", "group:stone"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})

minetest.register_craft({
	output = "farming:hoe_stone",
	recipe = {
		{"default:cobble", "default:cobble"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})

minetest.register_tool("farming:hoe_steel", {
	description = "Steel Hoe",
	inventory_image = "farming_hoe_steel.png",
	tool_capabilities = {
		full_punch_interval = 1.1,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.60, [2]=0.70, [3]=0.30}, uses=30, maxlevel=2},
		}
	},
})

minetest.register_craft({
	output = "farming:hoe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})

minetest.register_tool("farming:hoe_mese", {
	description = "Mese Hoe",
	inventory_image = "farming_hoe_mese.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			crumbly = {times={[1]=1.50, [2]=0.60, [3]=0.10}, uses=50, maxlevel=2},
		}
	},
})

minetest.register_craft({
	output = "farming:hoe_mese",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal"},
		{"", "default:stick"},
		{"", "default:stick"}
	}
})
