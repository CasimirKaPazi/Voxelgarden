function farming.hoe_on_use(itemstack, placer, pos, uses)
	if pos == nil then return end
	local under = minetest.get_node(pos)
	local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
	local above = minetest.get_node(pos_above)
	-- check for rightclick
	local reg_node = minetest.registered_nodes[under.name]
	if reg_node.on_rightclick then
		reg_node.on_rightclick(pos, under, placer)
		return
	end
	-- place node
	if above.name ~= "air" then return end
	if minetest.get_item_group(under.name, "soil") ~= 1 then return end
	minetest.set_node(pos, {name = "farming:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pos,
		gain = 0.5,
	})
	itemstack:add_wear(65535/(uses))
	return itemstack
end

function farming.place_seed(itemstack, placer, pointed_thing, plantname)
	local under = minetest.get_node(pointed_thing.under)
	local above = minetest.get_node(pointed_thing.above)
	-- check for rightclick
	local reg_node = minetest.registered_nodes[under.name]
	if reg_node.on_rightclick then
		reg_node.on_rightclick(pointed_thing.under, under, placer)
		return
	end
	-- place plant
	if above.name ~= "air" then return end
	if under.name ~= "farming:soil" and under.name ~= "farming:soil_wet" then
		return
	end
	above.name = plantname
	minetest.place_node(pointed_thing.above, above, placer)
	minetest.sound_play("default_place_node", {pos = pointed_thing.above, gain = 0.5})
	if minetest.setting_getbool("creative_mode") then
		return
	end
	itemstack:take_item()
	return itemstack
end

function farming.register_stages(max_stage, name, description)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]
	local tiles_name = mname.."_"..pname
	local stages = {}
	for i = 1,max_stage do
		local hight = 0.5 - 0.25 * (max_stage - i)
		minetest.register_node(name.."_"..i, {
			description = "Plant",
			tiles = {tiles_name.."_"..i..".png"},
			inventory_image = tiles_name.."_"..i..".png",
			paramtype = "light",
			waving = 1,
			walkable = false,
			drawtype = "plantlike",
			drop = "",
			selection_box = {
				type = "fixed",
				fixed = {-0.375, -0.5, -0.375, 0.375, hight, 0.375},
			},
			groups = {snappy=3, flammable=2, not_in_creative_inventory=1, attached_node=1},
			sounds = default.node_sound_leaves_defaults(),
		})

		table.insert(stages, name.."_"..i)
	end
	return stages
end

function farming.register_growing(max_stage, stages, interval, chance, lightlevel)
	minetest.register_abm({
		nodenames = stages,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet"
			and minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			if minetest.get_node_light(pos) < lightlevel then
				return
			end
			for i = 1,(max_stage-1) do
				if node.name == stages[i] then
					node.name = stages[i+1]
					minetest.set_node(pos, node)
					return
				end
			end
		end
	})
end
