-- support for MT game translation.
local S = minetest.get_translator("mobs_flat")

mobs:register_mob("mobs_flat:omsk", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 5,
	hp_min = 32,
	hp_max = 64,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "upright_sprite",
	visual_size = {x=2, y=2},
	textures = {
		"mobs_flat_omsk_front.png",
		"mobs_flat_omsk_back.png",
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_omsk",
	},
	walk_velocity = 1,
	run_velocity = 3,
	view_range = 10,
	jump = true,
	drops = {
		{name = "flowers:mushroom_red", chance = 0.5, min = 0, max = 5},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	floats = 1,
})


mobs:spawn({
	name = "mobs_flat:omsk",
	nodes = {"default:stone", "default:cobble", "default:mossycobble"},
	neighbors = {"default:stone_with_iron", "default:mossycobble"},
	chance = 7,
	active_object_count = 1
})

mobs:register_egg("mobs_flat:omsk", S("Omsk"), "wool_red.png", 1)
