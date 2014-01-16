-- use place node instead of add node and do not drop buildable_to nodes
minetest.register_entity(":__builtin:falling_node", {
	initial_properties = {
		physical = true,
		collide_with_objects = false,
		collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
		visual = "wielditem",
		textures = {},
		visual_size = {x=0.667, y=0.667},
	},

	node = {},

	set_node = function(self, node)
		self.node = node
		local stack = ItemStack(node.name)
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
			textures = {node.name},
		}
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		return self.node.name
	end,

	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		--self.object:setacceleration({x=0, y=-10, z=0})
		self:set_node({name=staticdata})
	end,

	on_step = function(self, dtime)
		-- Set gravity
		self.object:setacceleration({x=0, y=-10, z=0})
		-- Turn to actual sand when collides to ground or just move
		local pos = self.object:getpos()
		local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z} -- Position of bottom center point
		local bcn = minetest.get_node(bcp)
		-- Note: walkable is in the node definition, not in item groups
		if minetest.registered_nodes[bcn.name] and
				minetest.registered_nodes[bcn.name].walkable or
				(minetest.get_node_group(self.node.name, "float") ~= 0 and minetest.registered_nodes[bcn.name].liquidtype ~= "none")
			then
			if minetest.registered_nodes[bcn.name].leveled and bcn.name == self.node.name then
				local addlevel = self.node.level
				if addlevel == nil or addlevel <= 0 then addlevel = minetest.registered_nodes[bcn.name].leveled end
				if minetest.env:add_node_level(bcp, addlevel) == 0 then
					self.object:remove()
					return
				end
			elseif minetest.registered_nodes[bcn.name].buildable_to
			and (minetest.get_node_group(self.node.name, "float") == 0
			or minetest.registered_nodes[bcn.name].liquidtype == "none")
			then
				minetest.remove_node(bcp)
				return
			end
			local np = {x=bcp.x, y=bcp.y+1, z=bcp.z}
			-- Check what's here
			local n2 = minetest.get_node(np)
			-- If it's not air or liquid, remove node and replace it with
			-- it's drops
			if n2.name ~= "air" and (not minetest.registered_nodes[n2.name] or
					minetest.registered_nodes[n2.name].liquidtype == "none") then
				minetest.remove_node(np)
				if minetest.registered_nodes[n2.name].buildable_to == false then
					-- Add dropped items
					local drops = minetest.get_node_drops(n2.name, "")
					local _, dropped_item
					for _, dropped_item in ipairs(drops) do
						minetest.add_item(np, dropped_item)
					end
				end
				-- Run script hook
				local _, callback
				for _, callback in ipairs(minetest.registered_on_dignodes) do
					callback(np, n2, nil)
				end
			end
			-- Create node and remove entity
			if minetest.registered_items[self.node.name].paramtype2 == "wallmounted" then
				minetest.place_node(np, self.node)
			else
				minetest.add_node(np, self.node)
			end
			self.object:remove()
			nodeupdate(np)
		else
			-- Do nothing
		end
	end
})
