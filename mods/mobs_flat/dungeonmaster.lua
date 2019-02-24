-- Dungeon Master by PilzAdam

mobs:register_mob("mobs_flat:dungeon_master", {
	type = "monster",
	passive = false,
	damage = 4,
	attack_type = "shoot",
--	dogshoot_switch = 1,
--	dogshoot_count_max = 12, -- shoot for 10 seconds
--	dogshoot_count2_max = 3, -- dogfight for 3 seconds
--	reach = 3,
	shoot_interval = 2,
	arrow = "mobs_flat:fireball",
	shoot_offset = 1,
	hp_min = 36,
	hp_max = 48,
	armor = 50,
	knock_back = false,
	collisionbox = {-0.7, -1, -0.7, 0.7, 1.6, 0.7},
	visual = "upright_sprite",
	textures = {
		"mobs_flat_dm_front.png",
		"mobs_flat_dm_back.png",
	},
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dungeonmaster",
		shoot_attack = "mobs_fireball",
	},
	walk_velocity = 1,
	run_velocity = 1,
	jump = true,
	view_range = 15,
	drops = {},
	water_damage = 1,
	lava_damage = 0,
	light_damage = 0,
	fear_height = 3,
})


mobs:spawn({
	name = "mobs_flat:dungeon_master",
	nodes = {"default:cobble", "default:mossycobble"},
	neighbors = {"default:mese", "default:stone_with_mese", "default:lava_source", "default:mossycobble"},
	chance = 70,
	active_object_count = 2,
})


mobs:register_egg("mobs_flat:dungeon_master", "Dungeon Master", "default_lava.png", 1)


-- fireball (weapon)
mobs:register_arrow("mobs_flat:fireball", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"mobs_flat_fireball.png"},
	velocity = 6,
	tail = 1,
	tail_texture = "mobs_flat_fireball.png",
	tail_size = 10,
	glow = 8,
	expire = 0.1,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 8},
		}, nil)
	end,

	-- node hit
	hit_node = function(self, pos, node)
		mobs:boom(self, pos, 3)
	end
})
