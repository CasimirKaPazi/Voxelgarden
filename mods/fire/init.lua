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

local fire_node = {
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
}


-- Basic flame node
local flame_fire_node = table.copy(fire_node)
flame_fire_node.description = S("Fire")
flame_fire_node.groups.not_in_creative_inventory = 1
flame_fire_node.on_timer = function(pos)
	minetest.remove_node(pos)
end
flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(1, 10))
end

minetest.register_node("fire:basic_flame", flame_fire_node)

-- Permanent flame node
local permanent_fire_node = table.copy(fire_node)
permanent_fire_node.description = S("Permanent Fire")

minetest.register_node("fire:permanent_flame", permanent_fire_node)

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
			-- First remove node properly then create fire
			local node = minetest.get_node(pos)
			if minetest.get_item_group(node.name, leafdecay) > 0 then
				default.leafdecay(pos)
			else
				minetest.dig_node(pos)
			end
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
