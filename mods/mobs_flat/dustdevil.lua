-- support for MT game translation.
local S = minetest.get_translator("mobs_flat")

mobs:register_mob("mobs_flat:dustdevil", {
	type = "monster",
	passive = false,
--	attack_type = "dogshoot",
	attack_type = "dogfight",
	dogshoot_switch = 1,
	dogshoot_count_max = 10, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	reach = 3,
	shoot_interval = 2,
	arrow = "mobs_flat:spear",
	shoot_offset = 1,
	pathfinding = true,
	reach = 2,
	damage = 1,
	hp_min = 8,
	hp_max = 16,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.9, 0.4},
	visual = "upright_sprite",
	visual_size = {x=2, y=2},
	textures = {
		"mobs_flat_dustdevil_front.png",
		"mobs_flat_dustdevil_back.png",
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_dustdevil",
	},
	walk_velocity = 1,
	run_velocity = 3,
	view_range = 10,
	jump = true,
	drops = {
		{name = "nodetest:spearwood", chance = 0.5, min = 0, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 4,
	floats = 1,
})

-- spear (weapon)
mobs:register_arrow("mobs_flat:spear", {
	visual = "upright_sprite",
	drawtype = "side",
	visual_size = {x = 1, y = 1},
	textures = {"nodetest_spearwood.png"},
	velocity = 8,
	expire = 0.1,
	on_step = function(self)
		-- fall down
		local acceleration = self.object:get_acceleration()
		if not vector.equals(acceleration, {x = 0, y = -1, z = 0}) then
			self.object:set_acceleration({x = 0, y = -1, z = 0})
		end
	end,

	-- direct hit, no fire... just plenty of pain
	hit_player = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,

	hit_mob = function(self, player)
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = 1},
		}, nil)
	end,
})


mobs:spawn({
	name = "mobs_flat:dustdevil",
	nodes = {"default:desert_stone"},
	chance = 7,
})


mobs:register_egg("mobs_flat:dustdevil", S("Dust Devil"), "default_desert_sand.png", 1)
