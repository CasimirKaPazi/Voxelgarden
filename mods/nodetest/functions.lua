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

minetest.register_abm({
	nodenames = {"group:dissolve"},
	neighbors = {"group:liquid"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if nodedef and nodedef.liquidtype ~= "none" then
			if liquid_finite then
				minetest.set_node(pos, {name = "air"})
			else
				minetest.set_node(pos, {name = name})
			end
		end
	end,
})
