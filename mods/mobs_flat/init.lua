local path = minetest.get_modpath("mobs_flat")

mobs_flat = {}

dofile(path .. "/oerkki.lua")
dofile(path .. "/omsk.lua")
dofile(path .. "/dustdevil.lua")
dofile(path .. "/rat.lua")
dofile(path .. "/dungeonmaster.lua")

minetest.register_craftitem("mobs_flat:rat_caught" ,{
	description = "Rat",
	inventory_image = "mobs_flat_rat_caught.png",
	wield_image = "mobs_flat_rat_caught.png^[transformR90",
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

minetest.register_craftitem("mobs_flat:rat_cooked", {
	description = "Cooked Rat",
	inventory_image = "mobs_flat_rat_cooked.png",
	on_use = minetest.item_eat(4),
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "mobs_flat:rat_cooked",
	recipe = "mobs_flat:rat_caught",
})
