local liquid_finite = minetest.setting_getbool("liquid_finite")

--
-- Papyrus growing
--

minetest.register_abm({
	nodenames = {"nodetest:papyrus_roots"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="default:papyrus"})
		end
	end,
})

--
-- Remove nodes in liquids
--

local function dissolve(pos_dissolve, pos_liquid)
	local node = minetest.get_node(pos_liquid)
	local name = node.name
	local nodedef = minetest.registered_nodes[name]
	if nodedef and nodedef.liquidtype ~= "none" then
		local min_level = 8 - nodedef.liquid_range
		if node.param2 == 0 or node.param2 == 240 then
			minetest.set_node(pos_dissolve, {name = nodedef.liquid_alternative_flowing, param2 = 7})
		elseif node.param2 > min_level then		
			minetest.set_node(pos_dissolve, {name = name, param2 = node.param2-1})
		end
		return true
	end
end

minetest.register_abm({
	nodenames = {"group:dissolve"},
	neighbors = {"group:liquid"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		if dissolve(pos, {x=pos.x, y=pos.y+1, z=pos.z}) then return end
		if dissolve(pos, {x=pos.x+1, y=pos.y, z=pos.z}) then return end
		if dissolve(pos, {x=pos.x-1, y=pos.y, z=pos.z}) then return end
		if dissolve(pos, {x=pos.x, y=pos.y, z=pos.z+1}) then return end
		if dissolve(pos, {x=pos.x, y=pos.y, z=pos.z-1}) then return end
	end,
})

--
-- Turn seedling to flower
--

minetest.register_abm({
	nodenames = {"nodetest:seedling"},
	interval = 11,
	chance = 20,
	catch_up = false,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		if (minetest.get_node_light(above) or 0) >= 11 then
			local flower_choice = math.random(1, 7)
			local flower
			if flower_choice == 1 then
				flower = "flowers:tulip"
			elseif flower_choice == 2 then
				flower = "flowers:rose"
			elseif flower_choice == 3 then
				flower = "flowers:viola"
			elseif flower_choice == 4 then
				flower = "flowers:geranium"
			elseif flower_choice == 5 then
				flower = "flowers:dandelion_white"
			elseif flower_choice == 6 then
				flower = "flowers:dandelion_yellow"
			elseif flower_choice == 7 then
				flower = "air"
			end
			minetest.set_node(pos, {name=flower})
		end
	end
})
