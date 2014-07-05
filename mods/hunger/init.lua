hunger = {}
player_is_active = {}
player_hunger = {}
player_step = {}
player_bar = {}
local base_interval = 0.5

-- no_hunger privilege
minetest.register_privilege("no_hunger", {
	description = "Player will feel no hunger",
	give_to_singleplayer = false
})

-- hunger bar
function hunger.update_bar(player)
	local name = player:get_player_name()
	if minetest.get_player_privs(name)["no_hunger"] then
		player:hud_remove(player_bar[name])
		return
	end
	if player_bar[name] then
		player:hud_change(player_bar[name], "number", player_hunger[name])
	else
		player_bar[name] = player:hud_add({
			hud_elem_type = "statbar",
			position = {x=0.5,y=1.0},
			text = "hunger.png",
			number = player_hunger[name],
			dir = 0,
			offset = {x=25,y=-(48+24+10)},
			size = { x=24, y=24 },
		})
	end
	hunger.save_hunger(name, player_hunger[name])
end

if minetest.setting_getbool("enable_damage") == true then

-- prevent players from starving while afk (<--joke)
minetest.register_on_dignode(function(pos, oldnode, player)
	if not player then return end
	local name = player:get_player_name()
	player_is_active[name] = true
end)

minetest.register_on_placenode(function(pos, node, player)
	if not player then return end
	local name = player:get_player_name()
	player_is_active[name] = true
end)

-- save and load hunger
local function get_filename(player_name)
	return minetest.get_worldpath() .. "/hunger_" .. player_name .. ".txt"
end

function hunger.save_hunger(name, value)
	local filename  = get_filename(name)
	local output    = io.open(filename, "w")

	if not output then
		minetest.debug("[hunger]: Cannot write drown value "..value.." to file " ..
			filename .. "; the file cannot be opened for writing!")
	else
		output:write(value)
		io.close(output)
	end
end

local function load_hunger(name)
	local filename  = get_filename(name)
	local input     = io.open(filename, "r")

	if not input then return 20 end

	local load_hunger = input:read("*n")
	io.close(input)
	return load_hunger
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	player_hunger[name] = load_hunger(name)
	hunger.update_bar(player)
end)

minetest.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	player_hunger[name] = 20
	hunger.update_bar(player)
end)

minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
	if not player then return end
	if not hp_change then return end
	local name = player:get_player_name()
	if player_hunger[name] + 2 * hp_change > 20 then
		player_hunger[name] = 20
	else
		player_hunger[name] = player_hunger[name] + 2 * hp_change
	end

	local headpos  = player:getpos()
	headpos.y = headpos.y + 1
	minetest.sound_play("hunger_eating", {pos = headpos, gain = 1.0, max_hear_distance = 32})

	hunger.update_bar(player)
end)

-- main function
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer < base_interval then return end
	timer = 0
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local hp = player:get_hp()
		if minetest.get_player_privs(name)["no_hunger"] then
			if player_bar[name] then
				player:hud_remove(player_bar[name])
			end
			return
		end
		if not player_is_active[name] then return end
		-- the hunger interval for each player depends on the health
		if not player_step[name] or player_step[name] >= 20 then
			player_step[name] = 0
		end
		player_step[name] = player_step[name] + 1
		if player_step[name] < hp then return end
		player_step[name] = 0
		if not player_hunger[name] then
			player_hunger[name] = 20
		end
		player_hunger[name] = player_hunger[name] - 1
		if player_hunger[name] <= 0 then
			player:set_hp(hp - 1)
			player_hunger[name] = 20
			local pos_sound  = player:getpos()
			minetest.chat_send_player(name, "You are hungry.")
		end
		player_is_active[name] = false
		hunger.update_bar(player)
	end
end)

end
