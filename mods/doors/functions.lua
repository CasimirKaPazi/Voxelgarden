local S = minetest.get_translator("doors")

doors = {}

local floor_dir = {
	[0] = 15,
	[1] = 8,
	[2] = 17,
	[3] = 6,
}

local ceil_dir = {
	[0] = 19,
	[1] = 4,
	[2] = 13,
	[3] = 10,
}

local wall_dir = {
	[0] = 20,
	[1] = 23,
	[2] = 22,
	[3] = 21,
}

function doors:register_door(name, def)	
	local tiles = def.tiles

	-- Change door status
	local function use(pos, replace_dir)
		local node = minetest.get_node(pos)
		local param2 = node.param2
		minetest.sound_play("default_dig_choppy", {pos, gain = 0.5, max_hear_distance = 32})
		minetest.swap_node(pos, {name=replace_dir, param2=param2})
	end

	-- Check for other doors
	local function update(pos, dir)
		local node = minetest.get_node(pos)
		local status = minetest.registered_nodes[node.name].status

		local pos_next = {x=pos.x, y=pos.y+dir, z=pos.z}
		local node_next = minetest.get_node(pos_next)
		local status_next = minetest.registered_nodes[node_next.name].status
		if status_next == nil then return end
		if status_next == status then
			update(pos_next, dir)
			local name = minetest.registered_nodes[node_next.name].base_name
			if status == 1 then
				use(pos_next, name.."_2")
			elseif status == 2 then
				use(pos_next, name.."_1")
			end
		end
	end

	local function check_player_priv(pos, player)
		if not def.only_placer_can_open then
			return true
		end
		local meta = minetest.get_meta(pos)
		local playername = player:get_player_name()
		return meta:get_string("doors_owner") == playername
	end

	-- Closed door
	minetest.register_node(":"..name.."_1", {
		description = def.description,
		inventory_image = def.inventory_image,
		tiles = {tiles[1].."^[transformR180", tiles[1].."^[transformR180", tiles[1], tiles[1], tiles[1], tiles[1].."^[transformfx"},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name.."_1",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5,   0.5, 0.5, -0.5+1/16}
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5,   0.5, 0.5, -0.5+1/16}
		},
		groups = def.groups,
		status = 1,
		base_name = name,
		on_rightclick = function(pos, node, user)
			if user:get_player_control().sneak then return end
			if not check_player_priv(pos, user) then return	end
			update(pos, 1)
			update(pos, -1)
			use(pos, name.."_2")
		end,
		on_place = function(itemstack, placer, pointed_thing)
			if not pointed_thing.type == "node" then
				return itemstack
			end
			local ptu = pointed_thing.under
			local pta = pointed_thing.above
			local param2 = minetest.dir_to_facedir(placer:get_look_dir())
			local nodeunder = minetest.get_node(ptu)
			local nodeunder_def = minetest.registered_nodes[nodeunder.name]
			if nodeunder_def and nodeunder_def.on_rightclick then
				return nodeunder_def.on_rightclick(ptu, nodeunder, placer, itemstack)
			end

			-- Place joint on the surface the placer is pointing to
			local face = param2
			if ptu.y < pta.y then
				face = floor_dir[param2]
			elseif ptu.y > pta.y then
				face = ceil_dir[param2]
			elseif (param2 == 0 and ptu.x > pta.x) or
					(param2 == 1 and ptu.z < pta.z) or
					(param2 == 2 and ptu.x < pta.x) or
					(param2 == 3 and ptu.z > pta.z) then
				face = wall_dir[param2]
			end
			-- In every other case place normal
			minetest.set_node(pta, {name=name.."_1", param2=face})

			if def.only_placer_can_open then
				local playername = placer:get_player_name()
				local meta = minetest.get_meta(pta)
				meta:set_string("doors_owner", playername)
				meta:set_string("infotext", S("Owned by @1", playername))
			end

			if not minetest.settings:get_bool("creative_mode") then
				itemstack:take_item()
			end
			minetest.sound_play("default_place_node", {ptu, gain = 0.5, max_hear_distance = 32})
			return itemstack
		end,
	})

	-- Open door
	minetest.register_node(":"..name.."_2", {
		tiles = {tiles[1].."^[transformfy^[transformR270", tiles[1].."^[transformfy^[transformR90", tiles[1].."^[transformfx", tiles[1], tiles[1].."^[transformfx", tiles[1].."^[transformfx"},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name.."_1",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, -0.5+1/16, 0.5, 0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, -0.5+1/16, 0.5, 0.5}
		},
		groups = def.groups,
		status = 2,
		base_name = name,
		on_rightclick = function(pos, node, user)
			if user:get_player_control().sneak then return end
			if not check_player_priv(pos, user) then return	end
			update(pos, 1)
			update(pos, -1)
			use(pos, name.."_1")
		end,
	})	
end


----fence gate----

local box_open = {
	type = "fixed",
	fixed = {
	-- railings
	{-14/16, 3/16, -1/16, -10/16, 5/16, 1/16},
	{-14/16, -5/16, -1/16, -10/16, -3/16, 1/16},
	{10/16, 3/16, -1/16, 14/16, 5/16, 1/16},
	{10/16, -5/16, -1/16, 14/16, -3/16, 1/16},
	-- door
	{-9/16, -7/16, -10/16, -7/16, 7/16, 1/16},
	{7/16, -7/16, -10/16, 9/16, 7/16, 1/16},
	-- posts
	{-10/16, -1/2, -1/8, -6/16, 1/2, 1/8},
	{6/16, -1/2, -1/8, 10/16, 1/2, 1/8},
	}
}

local box_closed = {
	type = "fixed",
	fixed = {
	-- railings
	{-14/16, 3/16, -1/16, -10/16, 5/16, 1/16},
	{-14/16, -5/16, -1/16, -10/16, -3/16, 1/16},
	{10/16, 3/16, -1/16, 14/16, 5/16, 1/16},
	{10/16, -5/16, -1/16, 14/16, -3/16, 1/16},
	-- door
	{-6/16, -7/16, -1/16, -1/16, 7/16, 1/16},
	{6/16, -7/16, -1/16, 1/16, 7/16, 1/16},
	-- posts
	{-10/16, -1/2, -1/8, -6/16, 1/2, 1/8},
	{6/16, -1/2, -1/8, 10/16, 1/2, 1/8},
	}
}

function doors.register_fencegate(name, def)
	local fence = {
		description = def.description,
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = box_open
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -1/8, 0.5, 0.5, 1/8}
		},
		tiles = {def.texture.."^[transformR90"},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		drop = name .. "_closed",
		connect_sides = {"left", "right"},
		groups = def.groups,
		sounds = def.sounds,
		on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local node_def = minetest.registered_nodes[node.name]
			minetest.swap_node(pos, {name = node_def._gate, param2 = node.param2})
			minetest.sound_play(node_def._gate_sound, {pos = pos, gain = 0.15,
				max_hear_distance = 8}, true)
			return itemstack
		end,
	}

	if not fence.sounds then
		fence.sounds = default.node_sound_wood_defaults()
	end

	fence.groups.fence = 1

	local fence_closed = table.copy(fence)
	fence_closed._gate = name .. "_open"
	fence_closed._gate_sound = "doors_fencegate_open"
	fence_closed.node_box = box_closed
	fence_closed.collision_box = box_closed

	local fence_open = table.copy(fence)
	fence_open._gate = name .. "_closed"
	fence_open._gate_sound = "doors_fencegate_close"
	fence_open.groups.not_in_creative_inventory = 1
	fence_open.node_box = box_open
	fence_open.collision_box = box_open

	minetest.register_node(":" .. name .. "_closed", fence_closed)
	minetest.register_node(":" .. name .. "_open", fence_open)

	if def.material then -- allow custom recipes
		minetest.register_craft({
			output = name .. "_closed",
			recipe = {
				{def.material, "group:stick", def.material},
				{def.material, "group:stick", def.material}
			}
		})
	end
end
