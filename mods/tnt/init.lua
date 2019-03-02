tnt = {}

-- Default to enabled when in singleplayer
local enable_tnt = minetest.settings:get_bool("enable_tnt")
if enable_tnt == nil then
	enable_tnt = minetest.is_singleplayer()
end

local tnt_radius = tonumber(minetest.settings:get("tnt_radius") or 3)

dofile(minetest.get_modpath("tnt").."/functions.lua")

minetest.register_node("tnt:gunpowder", {
	description = "Gun Powder",
	drawtype = "raillike",
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	tiles = {
		"tnt_gunpowder_straight.png",
		"tnt_gunpowder_curved.png",
		"tnt_gunpowder_t_junction.png",
		"tnt_gunpowder_crossing.png"
	},
	inventory_image = "tnt_gunpowder_inventory.png",
	wield_image = "tnt_gunpowder_inventory.png",
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {dig_immediate = 2, attached_node = 1, flammable = 5,
		connect_to_raillike = minetest.raillike_group("gunpowder")},
	sounds = default.node_sound_leaves_defaults(),

	on_punch = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
			minetest.log("action", puncher:get_player_name() ..
				" ignites tnt:gunpowder at " ..
				minetest.pos_to_string(pos))
		end
	end,
	on_blast = function(pos, intensity)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
	on_burn = function(pos)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
	on_ignite = function(pos, igniter)
		minetest.set_node(pos, {name = "tnt:gunpowder_burning"})
	end,
})

minetest.register_node("tnt:gunpowder_burning", {
	drawtype = "raillike",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	light_source = 5,
	tiles = {{
		name = "tnt_gunpowder_burning_straight_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_curved_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_t_junction_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	},
	{
		name = "tnt_gunpowder_burning_crossing_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1,
		}
	}},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	drop = "",
	groups = {
		dig_immediate = 2,
		attached_node = 1,
		connect_to_raillike = minetest.raillike_group("gunpowder")
	},
	sounds = default.node_sound_leaves_defaults(),
	on_timer = function(pos, elapsed)
		for dx = -1, 1 do
		for dz = -1, 1 do
			if math.abs(dx) + math.abs(dz) == 1 then
				for dy = -1, 1 do
					tnt.burn({
						x = pos.x + dx,
						y = pos.y + dy,
						z = pos.z + dz,
					})
				end
			end
		end
		end
		minetest.remove_node(pos)
	end,
	-- unaffected by explosions
	on_blast = function() end,
	on_construct = function(pos)
		minetest.sound_play("tnt_gunpowder_burning", {pos = pos, gain = 2})
		minetest.get_node_timer(pos):start(1)
	end,
})

minetest.register_craft({
	output = "tnt:gunpowder 2",
	type = "shapeless",
	recipe = {"default:coal_lump", "default:gravel"}
})

minetest.register_craftitem("tnt:tnt_stick", {
	description = "TNT Stick",
	inventory_image = "tnt_tnt_stick.png",
	groups = {flammable = 5},
})

if enable_tnt then
	minetest.register_craft({
		output = "tnt:tnt_stick 3",
		recipe = {
			{"tnt:gunpowder", "", "tnt:gunpowder"},
			{"tnt:gunpowder", "default:paper", "tnt:gunpowder"},
			{"tnt:gunpowder", "", "tnt:gunpowder"},
		}
	})

	minetest.register_craft({
		output = "tnt:tnt",
		recipe = {
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"},
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"},
			{"tnt:tnt_stick", "tnt:tnt_stick", "tnt:tnt_stick"}
		}
	})

	minetest.register_abm({
		label = "TNT ignition",
		nodenames = {"group:tnt", "tnt:gunpowder"},
		neighbors = {"fire:basic_flame", "default:lava_source", "default:lava_flowing"},
		interval = 4,
		chance = 1,
		action = function(pos, node)
			tnt.burn(pos, node.name)
		end,
	})
end

function tnt.register_tnt(def)
	local name
	if not def.name:find(':') then
		name = "tnt:" .. def.name
	else
		name = def.name
		def.name = def.name:match(":([%w_]+)")
	end
	if not def.tiles then def.tiles = {} end
	local tnt_top = def.tiles.top or def.name .. "_top.png"
	local tnt_bottom = def.tiles.bottom or def.name .. "_bottom.png"
	local tnt_side = def.tiles.side or def.name .. "_side.png"
	local tnt_burning = def.tiles.burning or def.name .. "_top_burning_animated.png"
	if not def.damage_radius then def.damage_radius = def.radius * 2 end

	if enable_tnt then
		minetest.register_node(":" .. name, {
			description = def.description,
			tiles = {tnt_top, tnt_bottom, tnt_side},
			is_ground_content = false,
			groups = {dig_immediate = 2, mesecon = 2, tnt = 1, flammable = 5},
			sounds = default.node_sound_wood_defaults(),
			after_place_node = function(pos, placer)
				if placer:is_player() then
					local meta = minetest.get_meta(pos)
					meta:set_string("owner", placer:get_player_name())
				end
			end,
			on_punch = function(pos, node, puncher)
				if puncher:get_wielded_item():get_name() == "default:torch" then
					minetest.swap_node(pos, {name = name .. "_burning"})
					minetest.registered_nodes[name .. "_burning"].on_construct(pos)
					minetest.log("action", puncher:get_player_name() ..
						" ignites " .. node.name .. " at " ..
						minetest.pos_to_string(pos))
				end
			end,
			on_blast = function(pos, intensity)
				minetest.after(0.1, function()
					tnt.boom(pos, def)
				end)
			end,
			mesecons = {effector =
				{action_on =
					function(pos)
						tnt.boom(pos, def)
					end
				}
			},
			on_burn = function(pos)
				minetest.swap_node(pos, {name = name .. "_burning"})
				minetest.registered_nodes[name .. "_burning"].on_construct(pos)
			end,
			on_ignite = function(pos, igniter)
				minetest.swap_node(pos, {name = name .. "_burning"})
				minetest.registered_nodes[name .. "_burning"].on_construct(pos)
			end,
		})
	end

	minetest.register_node(":" .. name .. "_burning", {
		tiles = {
			{
				name = tnt_burning,
				animation = {
					type = "vertical_frames",
					aspect_w = 16,
					aspect_h = 16,
					length = 1,
				}
			},
			tnt_bottom, tnt_side
			},
		light_source = 5,
		drop = "",
		sounds = default.node_sound_wood_defaults(),
		groups = {falling_node = 1},
		on_timer = function(pos, elapsed)
			tnt.boom(pos, def)
		end,
		-- unaffected by explosions
		on_blast = function() end,
		on_construct = function(pos)
			minetest.sound_play("tnt_ignite", {pos = pos})
			minetest.get_node_timer(pos):start(4)
			minetest.check_for_falling(pos)
		end,
	})
end

tnt.register_tnt({
	name = "tnt:tnt",
	description = "TNT",
	radius = tnt_radius,
	disable_drops = true,
})
