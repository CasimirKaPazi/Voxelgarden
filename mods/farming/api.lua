function farming.hoe_on_use(itemstack, placer, pos, uses)
	if minetest.is_protected(pos, placer:get_player_name()) then
		return
	end
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
	if above.walkable == "true" then return end
	if minetest.get_item_group(under.name, "soil") ~= 1 then return end
	minetest.set_node(pos, {name = "farming:soil"})
	minetest.sound_play("default_dig_crumbly", {
		pos = pos,
		gain = 0.5,
	})
	itemstack:add_wear(65535/(uses))
	return itemstack
end

function farming.place_plant(itemstack, placer, pointed, plantname)
	if minetest.is_protected(pointed.above, placer:get_player_name()) then
		return
	end
	local under = minetest.get_node(pointed.under)
	local above = minetest.get_node(pointed.above)
	local p_below = {x=pointed.above.x, y=pointed.above.y-1, z=pointed.above.z}
	local below = minetest.get_node(p_below)
	-- check for rightclick
	local reg_node = minetest.registered_nodes[under.name]
	if reg_node.on_rightclick then
		reg_node.on_rightclick(pointed.under, under, placer, itemstack)
		return
	end
	-- place plant
	if above.name ~= "air" then return end
	if below.name ~= "farming:soil" and below.name ~= "farming:soil_wet" then
		return
	end
	above.name = plantname
	minetest.add_node(pointed.above, above)
	minetest.sound_play("default_place_node", {pos = pointed.above, gain = 0.5})
	if minetest.settings:get_bool("creative_mode") then
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
			tiles = {tiles_name.."_"..i..".png"},
			paramtype = "light",
			sunlight_propagates = true,
			waving = 1,
			walkable = false,
			drawtype = "plantlike",
			drop = "",
			selection_box = {
				type = "fixed",
				fixed = {-0.375, -0.5, -0.375, 0.375, hight, 0.375},
			},
			groups = {snappy=3, flammable=2, falling_node=1},
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

-- Functions to compatible with MTG. Not used in this mod.
farming.registered_plants = {}

-- how often node timers for plants will tick, +/- some random value
local function tick(pos)
	minetest.get_node_timer(pos):start(math.random(166, 286))
end
-- how often a growth failure tick is retried (e.g. too dark)
local function tick_again(pos)
	minetest.get_node_timer(pos):start(math.random(40, 80))
end

-- Register plants
farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if not def.description then
		def.description = S("Seed")
	end
	if not def.harvest_description then
		def.harvest_description = pname:gsub("^%l", string.upper)
	end
	if not def.inventory_image then
		def.inventory_image = "unknown_item.png"
	end
	if not def.steps then
		return nil
	end
	if not def.minlight then
		def.minlight = 1
	end
	if not def.maxlight then
		def.maxlight = 14
	end
	if not def.fertility then
		def.fertility = {}
	end

	farming.registered_plants[pname] = def

	-- Register seed
	local lbm_nodes = {mname .. ":seed_" .. pname}
	local g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	for k, v in pairs(def.fertility) do
		g[v] = 1
	end
	minetest.register_node(":" .. mname .. ":seed_" .. pname, {
		description = def.description,
		tiles = {def.inventory_image},
		inventory_image = def.inventory_image,
		wield_image = def.inventory_image,
		drawtype = "signlike",
		groups = g,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		fertility = def.fertility,
		sounds = default.node_sound_dirt_defaults({
			dig = {name = "", gain = 0},
			dug = {name = "default_grass_footstep", gain = 0.2},
			place = {name = "default_place_node", gain = 0.25},
		}),

		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
		end,
		next_plant = mname .. ":" .. pname .. "_1",
		on_timer = farming.grow_plant,
		minlight = def.minlight,
		maxlight = def.maxlight,
	})

	-- Register harvest
	minetest.register_craftitem(":" .. mname .. ":" .. pname, {
		description = def.harvest_description,
		inventory_image = mname .. "_" .. pname .. ".png",
		groups = def.groups or {flammable = 2},
	})

	-- Register growing steps
	for i = 1, def.steps do
		local base_rarity = 1
		if def.steps ~= 1 then
			base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
		end
		local drop = {
			items = {
				{items = {mname .. ":" .. pname}, rarity = base_rarity},
				{items = {mname .. ":" .. pname}, rarity = base_rarity * 2},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity},
				{items = {mname .. ":seed_" .. pname}, rarity = base_rarity * 2},
			}
		}
		local nodegroups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
		nodegroups[pname] = i

		local next_plant = nil

		if i < def.steps then
			next_plant = mname .. ":" .. pname .. "_" .. (i + 1)
			lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
		end

		minetest.register_node(":" .. mname .. ":" .. pname .. "_" .. i, {
			drawtype = "plantlike",
			waving = 1,
			tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
			paramtype = "light",
			paramtype2 = def.paramtype2 or nil,
			place_param2 = def.place_param2 or nil,
			walkable = false,
			buildable_to = true,
			drop = drop,
			selection_box = {
				type = "fixed",
				fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
			},
			groups = nodegroups,
			sounds = default.node_sound_leaves_defaults(),
			next_plant = next_plant,
			on_timer = farming.grow_plant,
			minlight = def.minlight,
			maxlight = def.maxlight,
		})
	end

	-- replacement LBM for pre-nodetimer plants
	minetest.register_lbm({
		name = ":" .. mname .. ":start_nodetimer_" .. pname,
		nodenames = lbm_nodes,
		action = function(pos, node)
			tick_again(pos)
		end,
	})

	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
end

-- Seed placement
farming.place_seed = function(itemstack, placer, pointed_thing, plantname)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	-- check if pointing at soil
	if minetest.get_item_group(under.name, "soil") < 2 then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.log("action", player_name .. " places node " .. plantname .. " at " ..
		minetest.pos_to_string(pt.above))
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	tick(pt.above)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end
	return itemstack
end
