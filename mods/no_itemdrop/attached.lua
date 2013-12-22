function drop_attached_node(p)
	local node = minetest.get_node(p)
	local nn = node.name
	minetest.remove_node(p)
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
		for _,item in ipairs(minetest.get_node_drops(nn, "")) do
			local pos_drop = {
				x = p.x + math.random()/2 - 0.25,
				y = p.y + math.random()/2 - 0.25,
				z = p.z + math.random()/2 - 0.25,
			}
			minetest.add_item(pos_drop, item)
		end
	end
end
