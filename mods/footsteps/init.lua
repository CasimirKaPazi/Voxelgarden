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

-- chance to change is odd of 100
local odd = 20

minetest.register_globalstep(function(dtime)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		local player_name = player:get_player_name()
		player_pos[player_name] = { x=math.floor(pos.x+0.5), y=math.floor(pos.y+0.5), z=math.floor(pos.z+0.5) }
		local p_ground = { x=math.floor(pos.x+0.5), y=math.floor(pos.y), z=math.floor(pos.z+0.5) }
		local n_ground  = minetest.get_node(p_ground)
		
		-- checking if position is the previous position
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
			
		-- make footsteps
		if n_ground.name == "default:dirt_with_grass" then
			if math.random(1, 100) <= odd then
				minetest.add_node(p_ground,{type="node",name="default:dirt_with_grass_footsteps"})
			end
		end
		
		if ( minetest.get_modpath("farming") ) ~= nil then
		if n_ground.name == "farming:soil" then
			if math.random(1, 100) <= odd then
				minetest.add_node(p_ground,{type="node",name="default:dirt"})
			end
		elseif n_ground.name == "farming:soil_wet" then
			if math.random(1, 100) <= odd then
				minetest.add_node(p_ground,{type="node",name="default:dirt"})
			end
		end
		end
		
		if ( minetest.get_modpath("garden") ) ~= nil then
		if n_ground.name == "garden:soil" then
			if math.random(1, 100) <= odd then
				minetest.add_node(p_ground,{type="node",name="default:dirt"})
			end
		elseif n_ground.name == "garden:soil_wet" then
			if math.random(1, 100) <= odd then
				minetest.add_node(p_ground,{type="node",name="default:dirt"})
			end
		end
		end
	
		-- making position to previous position
		player_pos_previous[player_name] =  player_pos[player_name]
	end
end)
--[[
minetest.register_abm({
	nodenames = {"default:dirt_with_grass_footsteps"},
	interval = 20,
	chance = 20,
	action = function(pos, node)		
		node.name = "default:dirt_with_grass"
		minetest.add_node(pos, node)
	end
})
--]]
-- [[
minetest.register_abm({
	nodenames = {"default:dirt_with_grass_footsteps"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		local decay = meta:get_int("decay")
		if not decay then
			meta:set_int("decay", 1)
			return
		end
		if decay >= math.random(36, 44) then
			node.name = "default:dirt_with_grass"
			minetest.add_node(pos, node)
			meta:set_int("decay", nil)
			return
		end
		decay = decay + 1
		meta:set_int("decay", decay)
	end
})
--]]
