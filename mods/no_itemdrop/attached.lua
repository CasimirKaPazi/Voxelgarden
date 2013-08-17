function drop_attached_node(p)
	local nn = minetest.get_node(p).name
	minetest.remove_node(p)
	for _,item in ipairs(minetest.get_node_drops(nn, "")) do
		local pos = {
			x = math.floor(p.x + 0.5),
			y = math.floor(p.y + 0.5),
			z = math.floor(p.z + 0.5),
		}
		spawn_falling_node(pos, {name=item})
	end
end
