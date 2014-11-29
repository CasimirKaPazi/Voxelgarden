hunger = {}
local player_is_active = {}
local player_hunger = {}
local player_step = {}
local player_bar = {}
local base_interval = 0.5
local file = minetest.get_worldpath() .. "/hunger"

function hunger.save_hunger()
		local output = io.open(file, "w")
		for name, v in pairs(player_hunger) do
			output:write(player_hunger[name].." "..name.."\n")
		end
		io.close(output)
end

local function load_hunger()
	local input = io.open(file, "r")
	if input then
		repeat
			local hunger = input:read("*n")
			local name = input:read("*l")
			name = name:sub(2)
			if name == nil then break end
			if not hunger then hunger = 20 end
			player_hunger[name] = hunger
		until input:read(0) == nil
		io.close(input)
	else
		hunger.save_hunger()
	end
end

load_hunger()

-- no_hunger privilege
minetest.register_privilege("no_hunger", {
	description = "Player will feel no hunger.",
	give_to_singleplayer = false
})

-- Hunger bar
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
	hunger.save_hunger()
end

if minetest.setting_getbool("enable_damage") == true then

-- Prevent players from starving while afk (<--joke)
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

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not player_hunger[name] then player_hunger[name] = 20 end
	hunger.update_bar(player)
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_bar[name] = nil
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

-- Main function
local timer = 0
minetest.register_globalstep(function(dtime)
	timer = timer + dtime;
	if timer < base_interval then return end
	timer = 0
	local change = false
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
		-- The hunger interval for each player depends on the health
		if not player_step[name] or player_step[name] >= 20 then
			player_step[name] = 0
		end
		player_step[name] = player_step[name] + 1
		if player_step[name] < hp then return end
		player_step[name] = 0
		if not player_hunger[name] then player_hunger[name] = 20 end
		player_hunger[name] = player_hunger[name] - 1
		if player_hunger[name] <= 0 then
			player:set_hp(hp - 1)
			player_hunger[name] = 20
			local pos_sound  = player:getpos()
			minetest.chat_send_player(name, "You are hungry.")
		end
		player_is_active[name] = false
		change = true
	end
	if change then hunger.update_bar(player) end
end)

end
