--
-- Function
--

function farming.hoe_on_use(itemstack, placer, pos, uses)
	if pos == nil then
		return
	end
	local under = minetest.get_node(pos)
	local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
	local above = minetest.get_node(pos_above)
	-- check for rightclick
	local reg_node = minetest.registered_nodes[under.name]
	if reg_node.on_rightclick then
		reg_node.on_rightclick(pos, under, placer)
		return
	end
	if under.name ~= "default:dirt"
	and under.name ~= "default:dirt_with_grass"
	and under.name ~= "default:dirt_with_grass_footsteps"
	then
		return
	end
	if above.name ~= "air" then
		return
	end
	
	minetest.set_node(pos, {name = "farming:soil"})
	
	minetest.sound_play("default_dig_crumbly", {
		pos = pos,
		gain = 0.5,
	})
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

--
-- Hoes
--

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
	on_place = function(itemstack, placer, pointed_thing)
		return farming.hoe_on_use(itemstack, placer, pointed_thing.under, 30)
	end
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
	on_place = function(itemstack, placer, pointed_thing)
		return farming.hoe_on_use(itemstack, placer, pointed_thing.under, 60)
	end
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
	on_place = function(itemstack, placer, pointed_thing)
		return farming.hoe_on_use(itemstack, placer, pointed_thing.under, 120)
	end
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
	on_place = function(itemstack, placer, pointed_thing)
		d = 1
		for xi = -d, d do
		for zi = -d, d do
			pos = {x=pointed_thing.under.x+xi, y=pointed_thing.under.y, z=pointed_thing.under.z+zi}
			farming.hoe_on_use(itemstack, placer, pos, 240)
		end
		end
	end
})

--
-- Crafts
--

minetest.register_craft({
	output = "farming:hoe_wood",
	recipe = {
		{"group:wood", "group:wood"},
		{"", "group:stick"},
		{"", "group:stick"}
	}
})

minetest.register_craft({
	output = "farming:hoe_stone",
	recipe = {
		{"group:stone", "group:stone"},
		{"", "group:stick"},
		{"", "group:stick"}
	}
})

minetest.register_craft({
	output = "farming:hoe_steel",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick"},
		{"", "group:stick"}
	}
})

minetest.register_craft({
	output = "farming:hoe_mese",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal"},
		{"", "group:stick"},
		{"", "group:stick"}
	}
})
