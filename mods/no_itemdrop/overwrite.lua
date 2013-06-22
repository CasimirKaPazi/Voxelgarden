function minetest.item_place_node(itemstack, placer, pointed_thing)
	local item = itemstack:peek_item()
	local def = itemstack:get_definition()
	if def.type ~= "node" or pointed_thing.type ~= "node" then
		return itemstack
	end

	local under = pointed_thing.under
	local oldnode_under = minetest.env:get_node(under)
	local olddef_under = ItemStack({name=oldnode_under.name}):get_definition()
	olddef_under = olddef_under or minetest.nodedef_default
	local above = pointed_thing.above
	local oldnode_above = minetest.env:get_node(above)
	local olddef_above = ItemStack({name=oldnode_above.name}):get_definition()
	olddef_above = olddef_above or minetest.nodedef_default

	if not olddef_above.buildable_to and not olddef_under.buildable_to then
		minetest.log("info", placer:get_player_name() .. " tried to place"
			.. " node in invalid position " .. minetest.pos_to_string(above)
			.. ", replacing " .. oldnode_above.name)
		return itemstack
	end

	-- Place above pointed node
	local place_to = {x = above.x, y = above.y, z = above.z}

	-- If node under is buildable_to, place into it instead (eg. snow)
	if olddef_under.buildable_to then
		minetest.log("info", "node under is buildable to")
		place_to = {x = under.x, y = under.y, z = under.z}
	end

--	if placer:get_player_name() ~= "" then 
	if placer:is_player() then
		minetest.log("action", placer:get_player_name() .. " places node "
			.. def.name .. " at " .. minetest.pos_to_string(place_to))
	end
	
	local oldnode = minetest.env:get_node(place_to)
	local newnode = {name = def.name, param1 = 0, param2 = 0}

	-- Calculate direction for wall mounted stuff like torches and signs
	if def.paramtype2 == 'wallmounted' then
		local dir = {
			x = under.x - above.x,
			y = under.y - above.y,
			z = under.z - above.z
		}
		newnode.param2 = minetest.dir_to_wallmounted(dir)
	-- Calculate the direction for furnaces and chests and stuff
	elseif def.paramtype2 == 'facedir' then
		local placer_pos = placer:getpos()
		if placer_pos then
			local dir = {
				x = above.x - placer_pos.x,
				y = above.y - placer_pos.y,
				z = above.z - placer_pos.z
			}
			newnode.param2 = minetest.dir_to_facedir(dir)
			minetest.log("action", "facedir: " .. newnode.param2)
		end
	end

	-- Check if the node is attached and if it can be placed there
	if minetest.get_item_group(def.name, "attached_node") ~= 0 and
		not check_attached_node(place_to, newnode) then
		minetest.log("action", "attached node " .. def.name ..
			" can not be placed at " .. minetest.pos_to_string(place_to))
		return itemstack
	end

	-- Add node and update
	minetest.env:add_node(place_to, newnode)

	local take_item = true

	-- Run callback
	if def.after_place_node then
		-- Copy place_to because callback can modify it
		local place_to_copy = {x=place_to.x, y=place_to.y, z=place_to.z}
		if def.after_place_node(place_to_copy, placer, itemstack) then
			take_item = false
		end
	end

	-- Run script hook
	local _, callback
	for _, callback in ipairs(minetest.registered_on_placenodes) do
		-- Copy pos and node because callback can modify them
		local place_to_copy = {x=place_to.x, y=place_to.y, z=place_to.z}
		local newnode_copy = {name=newnode.name, param1=newnode.param1, param2=newnode.param2}
		local oldnode_copy = {name=oldnode.name, param1=oldnode.param1, param2=oldnode.param2}
		if callback(place_to_copy, newnode_copy, placer, oldnode_copy, itemstack) then
			take_item = false
		end
	end

	if take_item then
		itemstack:take_item()
	end
	return itemstack
end

minetest.register_entity(":__builtin:falling_node", {
	initial_properties = {
		physical = true,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "wielditem",
		textures = {},
		visual_size = {x=0.667, y=0.667},
	},

	nodename = "",

	set_node = function(self, nodename)
		self.nodename = nodename
		local stack = ItemStack(nodename)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		prop = {
			is_visible = true,
			textures = {nodename},
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		return self.nodename
	end,

	on_activate = function(self, staticdata)
		self.nodename = staticdata
		self.object:set_armor_groups({immortal=1})
		--self.object:setacceleration({x=0, y=-10, z=0})
		self:set_node(self.nodename)
	end,

	on_step = function(self, dtime)
		-- Set gravity
		self.object:setacceleration({x=0, y=-10, z=0})
		-- Turn to actual sand when collides to ground or just move
		local pos = self.object:getpos()
		local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
		local bcn = minetest.env:get_node(bcp)
		-- Note: walkable is in the node definition, not in item groups
		if minetest.registered_nodes[bcn.name] and
				minetest.registered_nodes[bcn.name].walkable then
			local np = {x=bcp.x, y=bcp.y+1, z=bcp.z}
			-- Check what's here
			local n2 = minetest.env:get_node(np)
			-- If it's not air or liquid, remove node and replace it with
			-- it's drops
			if n2.name ~= "air" and (not minetest.registered_nodes[n2.name] or
					minetest.registered_nodes[n2.name].liquidtype == "none") then
				-- Place replaced node above if possible, else remove
				local np3 = {x=np.x, y=np.y+1, z=np.z}
				local n3 = minetest.env:get_node(np)
--				print("[falling] n3.name is ".. n3.name .."")
				minetest.env:remove_node(np)
				if minetest.registered_nodes[n3.name].buildable_to == true or n3.name == "air" then

				else
					-- Add dropped items
					local drops = minetest.get_node_drops(n2.name, "")
					local _, dropped_item
					for _, dropped_item in ipairs(drops) do
						minetest.env:add_item(np3, dropped_item)
					end
				end
				-- Run script hook
					local _, callback
					for _, callback in ipairs(minetest.registered_on_dignodes) do
						callback(np, n2, nil)
					end
			end
			-- Create node and remove entity
			minetest.env:place_node(np, {name=self.nodename})
			self.object:remove()
		else
			-- Do nothing
		end
	end
})
