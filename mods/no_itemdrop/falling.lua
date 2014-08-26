-- use place node instead of add node and do not drop buildable_to nodes
core.register_entity(":__builtin:falling_node", {
	physical = true,
	collide_with_objects = false,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "wielditem",
	textures = {},
	visual_size = {x=0.667, y=0.667},

	node = {},

	set_node = function(self, node)
		self.node = node
		self.object:set_properties({
			is_visible = true,
			textures = {node.name},
		})
	end,

	get_staticdata = function(self)
		return self.node.name
	end,

	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self:set_node({name=staticdata})
	end,

	on_step = function(self, dtime)
		if dtime > 0.2 then remove_fast = 1 end
		-- Set gravity
		self.object:setacceleration({x=0, y=-10, z=0})
		-- Turn to actual node when it collides to ground or just move
		local pos = self.object:getpos()
		local bcp = {x=pos.x, y=pos.y-0.7, z=pos.z}  -- Position of bottom center point
		local bcn = core.get_node(bcp)
		local bcd = core.registered_nodes[bcn.name]
		-- Note: walkable is in the node definition, not in item groups
		if not bcd or
				(bcd.walkable or
				(core.get_node_group(self.node.name, "float") ~= 0 and
				core.registered_nodes[bcn.name].liquidtype ~= "none")) then
			if bcd and bcd.leveled and bcn.name == self.node.name then
				local addlevel = self.node.level
				if addlevel == nil or addlevel <= 0 then
					addlevel = bcd.leveled
				end
				local new_level = core.add_node_level(bcp, addlevel)
				if new_level == 0 then
					self.object:remove()
					return
				end
				-- Turn into a full block if defined
				if new_level >= bcd.leveled and bcd.leveled_full then
					core.add_node(bcp, {name=bcd.leveled_full})
				end
			elseif bcd.buildable_to and
					(core.get_item_group(self.node.name, "float") == 0 or
					bcd.liquidtype == "none") then
				core.remove_node(bcp, remove_fast)
				return
			end
			local np = {x=bcp.x, y=bcp.y+1, z=bcp.z}
			-- Check what's here
			local n2 = core.get_node(np)
			-- If it's not air or liquid, remove node and replace it with
			-- it's drops
			if n2.name ~= "air" and (not core.registered_nodes[n2.name] or
					core.registered_nodes[n2.name].liquidtype == "none") then
				core.remove_node(np, remove_fast)
				if core.registered_nodes[n2.name].buildable_to == false then
					-- Add dropped items
					local drops = core.get_node_drops(n2.name, "")
					local _, dropped_item
					for _, dropped_item in ipairs(drops) do
						core.add_item(np, dropped_item)
					end
				end
				-- Run script hook
				local _, callback
				for _, callback in ipairs(core.registered_on_dignodes) do
					callback(np, n2, nil)
				end
			end
			-- Create node and remove entity
			if core.registered_items[self.node.name].paramtype2 == "wallmounted" then
				core.place_node(np, self.node)
			else
				core.add_node(np, self.node)
			end
			self.object:remove()
			nodeupdate(np)
		end
	end
})
