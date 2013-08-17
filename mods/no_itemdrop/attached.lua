function drop_attached_node(p)
	local node = minetest.get_node(p)
	minetest.remove_node(p)
	local pos = {
		x = math.floor(p.x + 0.5),
		y = math.floor(p.y + 0.5),
		z = math.floor(p.z + 0.5),
	}
	spawn_falling_node(pos, node)
end
