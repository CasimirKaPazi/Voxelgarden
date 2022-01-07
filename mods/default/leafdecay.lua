-- minetest/default/leafdecay.lua

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
	local finds_per_second = 5000
	default.leafdecay_trunk_find_allow_accumulator =
			math.floor(dtime * finds_per_second)
end)

local function leafupdate(p0)
	for xi = -1, 1 do
	for yi = -1, 1 do
	for zi = -1, 1 do
		if not (xi == 0 and yi == 0 and zi == 0) then
			local p1 = {x=p0.x + xi, y=p0.y + yi, z=p0.z + zi}
			local node = minetest.get_node(p1)
			local n_def = minetest.registered_nodes[node.name]
			if not n_def then return end
			local range = minetest.registered_nodes[node.name].groups.leafdecay
			if range then
				minetest.after(math.random(1,8), default.leafdecay, p1)
			end
		end
	end
	end
	end
end

default.leafdecay = function(p0)
	--print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
	local n0 = minetest.get_node(p0)
	local do_preserve = false
	local def = minetest.registered_nodes[n0.name]
	local range = def.groups.leafdecay
	if not range or range == 0 then return end
	local trunk = def.trunk or "group:tree"
	if n0.param2 ~= 0 then
		--print("param2 ~= 0")
		return
	end
	local p0_hash = nil
	if default.leafdecay_enable_cache then
		p0_hash = minetest.hash_node_position(p0)
		local trunkp = default.leafdecay_trunk_cache[p0_hash]
		if trunkp then
			local n = minetest.get_node(trunkp)
			local reg = minetest.registered_nodes[n.name]
			-- Assume ignore is a trunk, to make the thing work at the border of the active area
			if n.name == "ignore" then return end
			if n.name == trunk then return end
			if trunk == "group:tree" and (reg and reg.groups.tree and reg.groups.tree ~= 0) then return end
			--print("cached trunk is invalid")
			-- Cache is invalid
			table.remove(default.leafdecay_trunk_cache, p0_hash)
		end
	end
	if default.leafdecay_trunk_find_allow_accumulator <= 0 then
		return
	end
	default.leafdecay_trunk_find_allow_accumulator =
			default.leafdecay_trunk_find_allow_accumulator - 1
	-- Assume ignore is a trunk, to make the thing work at the border of the active area
	local p1 = minetest.find_node_near(p0, range, {"ignore", trunk})
	if p1 then
		do_preserve = true
		if default.leafdecay_enable_cache then
			--print("caching trunk")
			-- Cache the trunk
			default.leafdecay_trunk_cache[p0_hash] = {p1, trunk}
		end
	end
	if not do_preserve then
		-- Drop stuff other than the node itself
		local itemstacks = minetest.get_node_drops(n0.name)
		for _, itemname in ipairs(itemstacks) do
			local do_drop = def.groups.leafdecay_drop
			if itemname ~= n0.name then
				local p_drop = {
					x = math.floor(p0.x + 0.5),
					y = math.floor(p0.y + 0.5),
					z = math.floor(p0.z + 0.5),
				}
				minetest.set_node(p_drop, {name=itemname})
				core.spawn_falling_node(p_drop)
			elseif do_drop and do_drop ~= 0 then
				minetest.add_item({
					x = p0.x - 0.5 + math.random(),
					y = p0.y - 0.5 + math.random(),
					z = p0.z - 0.5 + math.random(),
				}, itemname)
			end
		end
		-- Remove node
		minetest.remove_node(p0)
		minetest.check_for_falling(p0)
		leafupdate(p0)
	end
end

minetest.register_abm({
	label = "leafdecay",
	nodenames = {"group:leafdecay"},
	neighbors = {"air", "group:liquid"},
	-- A low interval and a high inverse chance spreads the load
	interval = 5,
	chance = 90,

	action = function(p0, node, _, _)
		default.leafdecay(p0)
	end
})

minetest.register_on_dignode(function(pos, oldnode, digger)
	if minetest.get_item_group(oldnode.name, "tree") then
		leafupdate(pos)
	end
end)

--
-- Functions to be compatible with MTG. Not used in this mod.
--

function default.register_leafdecay(def)
	assert(def.leaves)
	assert(def.trunks)
	assert(def.radius)
	for _, v in pairs(def.trunks) do
		minetest.override_item(v, {
			after_destruct = function(pos, oldnode)
				leafdecay_after_destruct(pos, oldnode, def)
			end,
		})
	end
	for _, v in pairs(def.leaves) do
	for _, w in pairs(def.trunks) do
		minetest.override_item(v, {
			trunk = w,
		})
	end
	end
end

-- Prevent decay of placed leaves

default.after_place_leaves = function(pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local node = minetest.get_node(pos)
		node.param2 = 1
		minetest.set_node(pos, node)
	end
end
