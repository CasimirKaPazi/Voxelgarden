-- minetest/fire/init.lua
-- Load support for MT game translation.
local S = minetest.get_translator("fire")

fire = {}

minetest.register_privilege("fire", {
	description = S("Player can set fire."),
	give_to_singleplayer = true
})

minetest.register_alias("flint:tinder", "fire:tinder")
minetest.register_alias("flint:firestriker", "fire:flint_and_steel")
minetest.register_alias("nodetest:rock", "default:gravel")
minetest.register_alias("flint:silex_ore", "default:gravel")
minetest.register_alias("flint:silex", "default:cobble")
minetest.register_alias("fire", "fire:basic_flame")

function fire.node_should_burn(pos)
	local p0 = {x=pos.x-1, y=pos.y-1, z=pos.z-1}
	local p1 = {x=pos.x+1, y=pos.y+1, z=pos.z+1}
	local ps = minetest.find_nodes_in_area(p0, p1, {"group:igniter"})
	return (#ps >= 2)
end

dofile(minetest.get_modpath("fire").."/flintandsteel.lua")

minetest.register_node("fire:basic_flame", {
	description = S("Fire"),
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
	floodable = true,
	sunlight_propagates = true,
	damage_per_second = 4,
	on_timer = function(pos)
		-- If there are no flammable nodes around flame, remove flame
		local p = minetest.find_node_near(pos, 1, {"group:flammable"})
		if not p then
			minetest.remove_node(pos)
			return false
		end
		return true
	end,
	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(5, 10))
	end,
})

if not minetest.settings:get_bool("disable_fire") then

-- Ignite neighboring nodes
minetest.register_abm({
	nodenames = {"group:flammable"},
	neighbors = {"group:igniter"},
	interval = 1,
	chance = 8,
	catch_up = false,
	action = function(pos, node, _, _)
		if minetest.find_node_near(pos, 1, {"air"}) or
				fire.node_should_burn(pos) then
			minetest.set_node(pos, {name="fire:basic_flame"})
		end
	end,
})

minetest.register_lbm({
	name = "fire:convert_fire_to_node_timer",
	nodenames = {"fire:basic_flame"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(5, 10))
	end
})

end
