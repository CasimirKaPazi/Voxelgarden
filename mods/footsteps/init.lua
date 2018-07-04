local player_pos = {}
local player_pos_previous = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	player_pos_previous[player_name] = { x=0, y=0, z=0 }
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	player_pos_previous[player_name] = nil
end)

minetest.override_item("default:dirt_with_grass_footsteps", {
	on_timer = function(pos)
		local node = minetest.get_node(pos)
		node.name = "default:dirt_with_grass"
		minetest.add_node(pos, node)
	end,
})

-- Chance to change is odd of 100
local odd = 30
local timer = 0

minetest.register_globalstep(function(dtime)
	-- Don't check all the time.
	timer = timer + dtime
	if timer < 5 then return end
	timer = 0
	
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:get_pos()
		local player_name = player:get_player_name()
		player_pos[player_name] = { x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5) }
		local p_ground = { x=math.floor(pos.x+0.5), y=math.floor(pos.y), z=math.floor(pos.z+0.5) }
		local n_ground  = minetest.get_node(p_ground)
		
		-- Check if position is the previous position
		if player_pos_previous[player_name] == nil then
			return
		end

		if player:get_player_control().sneak then
			return
		end
		
		if	player_pos[player_name].x == player_pos_previous[player_name].x and 
			player_pos[player_name].y == player_pos_previous[player_name].y and 
			player_pos[player_name].z == player_pos_previous[player_name].z 
		then
			return
		end

		
			
		-- Make footsteps
		if math.random(1, 100) <= odd then
			if n_ground.name == "default:dirt_with_grass" then
				minetest.add_node(p_ground,{type="node",name="default:dirt_with_grass_footsteps"})
				minetest.get_node_timer(pos):start(math.random(3, 48))
			end
			
			if n_ground.name == "farming:soil" or n_ground.name == "farming:soil_wet" then
				minetest.add_node(p_ground,{type="node",name="default:dirt"})
			end
		end
	
		-- Make position to previous position
		player_pos_previous[player_name] =  player_pos[player_name]
	end
end)

minetest.register_lbm({
	name = "footsteps:convert_footsteps_to_node_timer",
	nodenames = {"default:dirt_with_grass_footsteps"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(3, 48))
	end
})
