-- minetest/fire/init.lua
fire = {}

minetest.register_alias("fire", "fire:basic_flame")

minetest.register_node("fire:basic_flame", {
	description = "Fire",
	drawtype = "firelike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	paramtype = "light",
	light_source = 13,
	waving = 1,
	groups = {igniter=2, dig_immediate=3},
	drop = "",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	damage_per_second = 4,
})

-- Only ignite if there are at least two fire nods around
-- This enables infinite fire pits
function fire.node_should_burn(pos)
	local p0 = {x=pos.x-1, y=pos.y-1, z=pos.z-1}
	local p1 = {x=pos.x+1, y=pos.y+1, z=pos.z+1}
	local ps = minetest.find_nodes_in_area(p0, p1, {"group:igniter"})
	return (#ps >= 2)
end

if not minetest.setting_getbool("disable_fire") then

-- Ignite neighboring nodes
minetest.register_abm({
	nodenames = {"group:flammable"},
	neighbors = {"group:igniter"},
	interval = 1,
	chance = 5,
	catch_up = false,
	action = function(p0, node, _, _)
		if fire.node_should_burn(p0) then
			minetest.set_node(p0, {name="fire:basic_flame"})
		end
	end,
})

-- Remove flammable nodes and flame
minetest.register_abm({
	nodenames = {"fire:basic_flame"},
	interval = 1,
	chance = 8,
	catch_up = false,
	action = function(p0, node, _, _)
		-- If there are no flammable nodes around flame, remove flame
		local p = minetest.find_node_near(p0, 1, {"group:flammable"})
		if not p then
			minetest.remove_node(p0)
			return
		end
		local p_air = minetest.find_node_near(p0, 1, {"air"})
		if p_air then
			minetest.set_node(p_air, {name="fire:basic_flame"})
		end
	end,
})

end
