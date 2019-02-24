mobs:register_mob("mobs_flat:omsk", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 1,
	damage = 3,
	hp_min = 16,
	hp_max = 32,
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
	drops = {},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	floats = 1,
})


mobs:spawn({
	name = "mobs_flat:omsk",
	nodes = {"default:stone", "default:cobble", "default:mossycobble"},
	neighbors = {"default:stone_with_iron"},
	chance = 7,
	active_object_count = 1
})

mobs:register_egg("mobs_flat:omsk", "Omsk", "wool_red.png", 1)
