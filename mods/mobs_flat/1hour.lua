-- support for MT game translation.
local S = minetest.get_translator("mobs_flat")

mobs:register_mob("mobs_flat:1hour", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 3,
	hp_min = 32,
	hp_max = 64,
	armor = 100,
	collisionbox = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4},
	visual = "upright_sprite",
	textures = {"mobs_flat_1hour_front.png", "mobs_flat_1hour_back.png"},
	spritediv = {x = 1, y = 4},
	visual_size = {x=3, y=3},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_spider",
	},
	walk_velocity = 3,
	run_velocity = 5,
	view_range = 10,
	jump = true,
	drops = {
		{name = "default:stone", chance = 0.5, min = 0, max = 1},
	},
	water_damage = 1,
	lava_damage = 0,
	light_damage = 0,
	fear_height = 1,
	floats = 1,
	on_activate = function(self)
		self.object:set_sprite({x=0, y=0}, 4, 0.2, false)
	end,
})

mobs:spawn({
	name = "mobs_flat:1hour",
	nodes = {"default:stone", "default:cobble", "nether:rack", "nether:rack_deep", "nether:lava_crust"},
	neighbors = {"default:lava_source", "nether:lava_source", "nether:lava_crust"},
	chance = 7,
	active_object_count = 2,
})


mobs:register_egg("mobs_flat:1hour", S("1hour"), "default_moltenrock.png", 1)
