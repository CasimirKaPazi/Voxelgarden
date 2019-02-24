-- Function for spawn ABM
-- For the node in question find an air node nearby and spawn there
-- Based on the mobs_redo spawner

local max_per_block = tonumber(minetest.settings:get("max_objects_per_block") or 99)

function = mobs_flat.spawn(pos, node, active_object_count, active_object_count_wider, mob, mlig, xlig, num, yof)
		-- return if too many entities already
		if active_object_count_wider >= max_per_block then
			return
		end
--[[
		-- get settings from command
		local mob = comm[1]
		local mlig = tonumber(comm[2]) -- min light
		local xlig = tonumber(comm[3]) -- max light
		local num = tonumber(comm[4]) -- total mobs in area
		local yof = tonumber(comm[6]) or 0 -- Y offset to spawn mob
--]]
		-- if amount is 0 then do nothing
		if num == 0 then
			return
		end

		-- are we spawning a registered mob?
		if not mobs.spawning_mobs[mob] then
			--print ("--- mob doesn't exist", mob)
			return
		end

		-- check objects inside 9x9 area around spawner
		local objs = minetest.get_objects_inside_radius(pos, 9)
		local count = 0
		local ent = nil

		-- count mob objects of same type in area
		for k, obj in ipairs(objs) do

			ent = obj:get_luaentity()

			if ent and ent.name and ent.name == mob then
				count = count + 1
			end
		end

		-- is there too many of same type?
		if count >= num then
			return
		end

		-- find air blocks within 5 nodes of spawner
		local air = minetest.find_nodes_in_area(
			{x = pos.x - 5, y = pos.y + yof, z = pos.z - 5},
			{x = pos.x + 5, y = pos.y + yof, z = pos.z + 5},
			{"air"})

		-- spawn in random air block
		if air and #air > 0 then

			local pos2 = air[math.random(#air)]
			local lig = minetest.get_node_light(pos2) or 0

			pos2.y = pos2.y + 0.5

			-- only if light levels are within range
			if lig >= mlig and lig <= xlig
			and minetest.registered_entities[mob] then
				minetest.add_entity(pos2, mob)
			end
		end
end

--[[ Example
-- spawner abm
minetest.register_abm({
	label = "Mob spawner node",
	nodenames = {"mobs:spawner"},
	interval = 10,
	chance = 4,
	catch_up = false,

	action = function(pos, node, active_object_count, active_object_count_wider)
		mobs_flat.spawn(pos, node, active_object_count, active_object_count_wider, 
			mob,
			mlig,
			xlig,
			num,
			yof
		)
	end
})
--]]
