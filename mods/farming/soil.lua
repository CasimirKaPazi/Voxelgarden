local footsteps = {"", "_footsteps"}

for _, f in ipairs(footsteps) do

minetest.register_node("farming:soil"..f, {
	tiles = {"default_dirt.png^farming_soil"..f..".png", "default_dirt.png"},
	drop = "default:dirt",
	groups = {crumbly=2, falling_node=1, soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_node("farming:soil_wet"..f, {
	tiles = {"default_dirt.png^farming_soil_wet"..f..".png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dirt",
	groups = {crumbly=2, falling_node=1, soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

minetest.register_abm({
	nodenames = {"farming:soil"..f..""},
	interval = 15,
	chance = 5,
	action = function(pos, node)
		if minetest.find_node_near(pos, 4, {"default:water_source", "default:water_flowing"}) then
			node.name = "farming:soil_wet"..f..""
			minetest.set_node(pos, node)
		end
	end,
})

minetest.register_abm({
	nodenames = {"farming:soil", "farming:soil_wet", "farming:soil_footsteps", "farming:soil_wet_footsteps"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})

end
