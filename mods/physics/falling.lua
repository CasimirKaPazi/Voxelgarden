-- 
-- Use place node instead of add node, for torches and the like.
-- Stack up leveled nodes and turn into full nodes if defined.

core.register_entity(":__builtin:falling_node", {
	initial_properties = {
		visual = "wielditem",
		visual_size = {x = 0.667, y = 0.667},
		textures = {},
		physical = true,
		is_visible = false,
		collide_with_objects = true,
		collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},

	node = {},
	meta = {},

	set_node = function(self, node, meta)
		self.node = node
		self.meta = meta or {}
		self.object:set_properties({
			is_visible = true,
			textures = {node.name},
		})
	end,

	get_staticdata = function(self)
		local ds = {
			node = self.node,
			meta = self.meta,
		}
		return core.serialize(ds)
	end,

	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal = 1})
		
		local ds = core.deserialize(staticdata)
		if ds and ds.node then
			self:set_node(ds.node, ds.meta)
		elseif ds then
			self:set_node(ds)
		elseif staticdata ~= "" then
			self:set_node({name = staticdata})
		end
	end,

	on_step = function(self, dtime)
		-- Set gravity
		local acceleration = self.object:getacceleration()
		if not vector.equals(acceleration, {x = 0, y = -10, z = 0}) then
			self.object:setacceleration({x = 0, y = -10, z = 0})
		end
		-- Turn to actual node when colliding with ground, or continue to move
		local pos = self.object:getpos()
		-- Position of bottom center point
		local bcp = {x = pos.x, y = pos.y - 0.7, z = pos.z}
		-- 'bcn' is nil for unloaded nodes
 		local bcn = core.get_node_or_nil(bcp)
		-- Delete on contact with ignore at world edges
		if bcn and bcn.name == "ignore" then
			self.object:remove()
			return
		end
		local bcd = bcn and core.registered_nodes[bcn.name]
		if bcn and
				(not bcd or bcd.walkable or
				(core.get_item_group(self.node.name, "float") ~= 0 and
				bcd.liquidtype ~= "none")) then
			if bcd and bcd.leveled and
					bcn.name == self.node.name then
				local addlevel = self.node.level
				if not addlevel or addlevel <= 0 then
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
			elseif bcd and bcd.buildable_to and
					(core.get_item_group(self.node.name, "float") == 0 or
					bcd.liquidtype == "none") then
				core.remove_node(bcp)
				return
			end
			local np = {x = bcp.x, y = bcp.y + 1, z = bcp.z}
			-- Check what's here
			local n2 = core.get_node(np)
			local nd = core.registered_nodes[n2.name]
			-- If it's not air or liquid, remove node and replace it with
			-- it's drops
			if n2.name ~= "air" and (not nd or nd.liquidtype == "none") then
				core.remove_node(np)
				if nd and nd.buildable_to == false then
					-- Add dropped items
					local drops = core.get_node_drops(n2.name, "")
					for _, dropped_item in pairs(drops) do
						core.add_item(np, dropped_item)
					end
				end
				-- Run script hook
				for _, callback in pairs(core.registered_on_dignodes) do
					callback(np, n2)
				end
			end
			-- Create node and remove entity
			local def = core.registered_nodes[self.node.name]
			if def then
				-- Have wallmounted properly placed.
				if core.registered_items[self.node.name].paramtype2 == "wallmounted" then
					core.place_node(np, self.node)
				else
					core.add_node(np, self.node)
				end
				if self.meta then
					local meta = core.get_meta(np)
					meta:from_table(self.meta)
				end
				if def.sounds and def.sounds.place and def.sounds.place.name then
					core.sound_play(def.sounds.place, {pos = np})
				end
			end
			self.object:remove()
			core.check_for_falling(np)
			return
		end
		local vel = self.object:getvelocity()
		if vector.equals(vel, {x = 0, y = 0, z = 0}) then
			local npos = self.object:getpos()
			self.object:setpos(vector.round(npos))
		end
	end
})

-- Same as builtin
-- Function has been made local, so we need a copy here.
function spawn_falling_node(p, node)
	local obj = core.add_entity(p, "__builtin:falling_node")
	obj:get_luaentity():set_node(node)
end

-- Node falls instead of dropping.
local function drop_attached_node(p)
	local node = core.get_node(p)
	local nn = node.name
	core.remove_node(p)
	local pos = {
		x = math.floor(p.x + 0.5),
		y = math.floor(p.y + 0.5),
		z = math.floor(p.z + 0.5),
	}
	local drops = minetest.registered_nodes[nn].drop
	if drops == nil or minetest.registered_nodes[drops] ~= nil then
		-- when there are no drops defined let the node fall down
		spawn_falling_node(pos, node)
	else
		-- when there are, drop them
		for _,item in ipairs(core.get_node_drops(nn, "")) do
			local pos_drop = {
				x = p.x + math.random()/2 - 0.25,
				y = p.y + math.random()/2 - 0.25,
				z = p.z + math.random()/2 - 0.25,
			}
			core.add_item(pos_drop, item)
		end
	end
end

-- Same as builtin
-- function has been made local, so we need a copy here.
local function check_attached_node(p, n)
	local def = core.registered_nodes[n.name]
	local d = {x = 0, y = 0, z = 0}
	if def.paramtype2 == "wallmounted" or
			def.paramtype2 == "colorwallmounted" then
		-- The fallback vector here is in case 'wallmounted to dir' is nil due
		-- to voxelmanip placing a wallmounted node without resetting a
		-- pre-existing param2 value that is out-of-range for wallmounted.
		-- The fallback vector corresponds to param2 = 0.
		d = core.wallmounted_to_dir(n.param2) or {x = 0, y = 1, z = 0}
	else
		d.y = -1
	end
	local p2 = vector.add(p, d)
	local nn = core.get_node(p2).name
	local def2 = core.registered_nodes[nn]
	if def2 and not def2.walkable then
		return false
	end
	return true
end

-- Have a delay on falling. Handle each node independent.
function core.check_single_for_falling(p)
	local n = core.get_node(p)
	if core.get_item_group(n.name, "falling_node") ~= 0 then
		local p_bottom = {x = p.x, y = p.y - 1, z = p.z}
		-- Only spawn falling node if node below is loaded
		local n_bottom = core.get_node_or_nil(p_bottom)
		local d_bottom = n_bottom and core.registered_nodes[n_bottom.name]
		if d_bottom and

				(core.get_item_group(n.name, "float") == 0 or
				d_bottom.liquidtype == "none") and

				(n.name ~= n_bottom.name or (d_bottom.leveled and
				core.get_node_level(p_bottom) <
				core.get_node_max_level(p_bottom))) and

				(not d_bottom.walkable or d_bottom.buildable_to) then
			n.level = core.get_node_level(p)
			local meta = core.get_meta(p)
			local metatable = {}
			if meta ~= nil then
				metatable = meta:to_table()
			end
			core.remove_node(p)
			spawn_falling_node(p, n, metatable)
			minetest.after(0.1, core.check_for_falling, p)
			return true
		end
	end

	if core.get_item_group(n.name, "attached_node") ~= 0 then
		if not check_attached_node(p, n) then
			drop_attached_node(p)
			return true
		end
	end

	return false
end

local check_for_falling_neighbors = {
	{x = -1, y = -1, z = 0},
	{x = 1, y = -1, z = 0},
	{x = 0, y = -1, z = -1},
	{x = 0, y = -1, z = 1},
	{x = 0, y = -1, z = 0},
	{x = -1, y = 0, z = 0},
	{x = 1, y = 0, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z = -1},
	{x = 0, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
}

function core.check_for_falling(p)
	for _, v in ipairs(check_for_falling_neighbors) do
		core.check_single_for_falling({x = p.x+v.x, y = p.y+v.y, z = p.z+v.z})
	end
end
