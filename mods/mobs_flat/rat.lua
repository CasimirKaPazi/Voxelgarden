-- support for MT game translation.
local S = minetest.get_translator("mobs_flat")

mobs:register_mob("mobs_flat:rat", {
	type = "animal",
	passive = true,
	attack_type = "dogfight",
	group_attack = true,
	pathfinding = true,
	reach = 1,
	damage = 1,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.4, -0.5, -0.4, 0.4, 0.2, 0.4},
	visual = "upright_sprite",
	drawtype = "side",
	textures = {
		"mobs_flat_rat.png",
		"mobs_flat_rat.png",
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	walk_velocity = 1,
	run_velocity = 2,
	jump = true,
	drops = {
		{name = "mobs_flat:rat_dead", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
	floats = 1,
	on_rightclick = function(self, player)
		local caught = mobs:capture_mob(self, player, 50, 90, 0, true, "mobs_flat:rat_caught")
		if caught == false then 
			if self.state == "attack" then
				return
			end

			self.attack = player
			self.state = "attack"
		end
	end,
})


mobs:spawn({
	name = "mobs_flat:rat",
	nodes = {"default:dirt_with_grass"},
	neighbors = {"default:grass_1", "default:grass_2", "default:grass_3", "default:grass_4", "default:grass_5"},
	chance = 70,
	active_object_count = 2
})

mobs:register_egg("mobs_flat:rat", S("Rat"), "default_gravel.png", 1)

-- Catch and cook delicious rats

minetest.register_craftitem("mobs_flat:rat_caught" ,{
	description = S("Rat"),
	inventory_image = "mobs_flat_rat.png",
	wield_image = "mobs_flat_rat.png^[transformR90",
	stack_max = 1,
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y + 1
		minetest.env:add_entity(pointed_thing.under, "mobs_flat:rat")
		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_craftitem("mobs_flat:rat_dead" ,{
	description = S("Dead Rat"),
	inventory_image = "mobs_flat_rat_dead.png",
	wield_image = "mobs_flat_rat_dead.png",
})

minetest.register_craftitem("mobs_flat:rat_cooked", {
	description = S("Cooked Rat"),
	inventory_image = "mobs_flat_rat_cooked.png",
	on_use = minetest.item_eat(4),
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "mobs_flat:rat_cooked",
	recipe = "mobs_flat:rat_dead",
})
