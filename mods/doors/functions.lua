doors = {}

function doors:register_door(name, def)	
	local box = {{-0.5, -0.5, -0.5,   0.5, 0.5, -0.5+1/16}}
	if not def.node_box then
		def.node_box = box
	end
	if not def.selection_box then
		def.selection_box = box
	end
	local tiles = def.tiles

	-- change door status
	local function use(pos, replace_dir, params)
		local node = minetest.get_node(pos)
		local p2 = node.param2
		p2 = params[p2+1]
		minetest.sound_play("default_dig_choppy", {pos, gain = 1.0})
		minetest.swap_node(pos, {name=replace_dir, param2=p2})
	end

	-- check for other doors
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
				use(pos_next, name.."_2", {1,2,3,0})
			elseif status == 2 then
				use(pos_next, name.."_1", {3,0,1,2})
			end
		end
	end

	local function check_player_priv(pos, player)
		if not def.only_placer_can_open then
			return true
		end
		local meta = minetest.get_meta(pos)
		local pn = player:get_player_name()
		return meta:get_string("doors_owner") == pn
	end

	-- closed door
	minetest.register_node(name.."_1", {
		description = def.description,
		inventory_image = def.inventory_image,
		tiles = {tiles[2], tiles[2], tiles[2], tiles[2], tiles[1], tiles[1].."^[transformfx"},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name.."_1",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box
		},
		groups = def.groups,
		status = 1,
		base_name = name,
		on_rightclick = function(pos, node, clicker)
			if not check_player_priv(pos, clicker) then
				return
			end
			update(pos, 1)
			update(pos, -1)
			use(pos, name.."_2", {1,2,3,0})
		end,
		on_place = function(itemstack, placer, pointed_thing)
			if not pointed_thing.type == "node" then
				return itemstack
			end
			local ptu = pointed_thing.under
			local pta = pointed_thing.above
			local place_dir = {x = 0, z = 0}
			place_dir.x = pta.x - ptu.x
			place_dir.z = pta.z - ptu.z
			local p2 = minetest.dir_to_facedir(placer:get_look_dir())
			local nu = minetest.get_node(ptu)
			if minetest.registered_nodes[nu.name].on_rightclick then
				return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
			end

			-- place joint on the surface the placer is pointing to
			if p2 == 0 and ptu.x > pta.x then
				minetest.set_node(pta, {name=name.."_2", param2=p2})
			elseif p2 == 1 and ptu.z < pta.z then
				minetest.set_node(pta, {name=name.."_2", param2=p2})
			elseif p2 == 2 and ptu.x < pta.x then
				minetest.set_node(pta, {name=name.."_2", param2=p2})
			elseif p2 == 3 and ptu.z > pta.z then
				minetest.set_node(pta, {name=name.."_2", param2=p2})
			else
				-- in every other case place normal
				minetest.set_node(pta, {name=name.."_1", param2=p2})
			end

			if def.only_placer_can_open then
				local pn = placer:get_player_name()
				local meta = minetest.get_meta(pt)
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by "..pn)
				meta = minetest.get_meta(pt2)
				meta:set_string("doors_owner", pn)
				meta:set_string("infotext", "Owned by "..pn)
			end

			if not minetest.setting_getbool("creative_mode") then
				itemstack:take_item()
			end
			minetest.sound_play("default_place_node", {ptu, gain = 0.5})
			return itemstack
		end,
	})

	-- open door
	minetest.register_node(name.."_2", {
		tiles = {tiles[2], tiles[2], tiles[2], tiles[2], tiles[1].."^[transformfx", tiles[1]},
		paramtype = "light",
		paramtype2 = "facedir",
		drop = name.."_1",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = def.node_box
		},
		selection_box = {
			type = "fixed",
			fixed = def.selection_box
		},
		groups = def.groups,
		status = 2,
		base_name = name,
		on_rightclick = function(pos, node, clicker)
			if not check_player_priv(pos, clicker) then
				return
			end
			update(pos, 1)
			update(pos, -1)
			use(pos, name.."_1", {3,0,1,2})
		end,
	})	
end
