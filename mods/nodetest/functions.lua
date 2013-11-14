--
-- Papyrus and cactus growing
--

minetest.register_abm({
	nodenames = {"default:papyrus_roots"},
	neighbors = {"group:water"},
	interval = 50,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y+1
		if minetest.get_node(pos).name == "air" then
			minetest.set_node(pos, {name="default:papyrus"})
		end
	end,
})
