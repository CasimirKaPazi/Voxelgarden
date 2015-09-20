--
-- Drowning
--
-- Copyright (c) 2012 by randomproof, Casimir, cheesecake.
--
-- A Minetest mod that simulates suffocating/drowning whenever the players
-- stay in liquid fluids longer than a certain period of time.
--
-- Basically, the mod works as follows:
--
--  * The player's breath is tracked by the holding_breath variable, which
--    contains the number of seconds the player is currently holding his/her
--    breath.  The time begins at zero whenever the user begins to poke his/her
--    head into a liquid.  It is reset whenever the player dies or gets out of
--    the liquid.
--
--  * If the player cannot hold his/her breath any longer, damage is being dealt
--    in discrete steps, until either the player gets out of the liquid or dies.
--    In other words, this simulates the player drowning.  The discrete steps are
--    remembered by the variable next_scheduled_damage, which effectively is the
--    number of seconds the player is holding his/her breath.  So, once
--    holding_breath reaches the value of next_scheduled_damage, damage is dealt,
--    and next_scheduled_damage is being set to the next point in time where damage
--    will be dealt again.
--
--    The time where the player cannot hold his/her breath any longer is determined
--    by the constant START_DROWNING_SECONDS.
--
--  * The discrete time offsets for dealing damage due to drowning are shortened
--    every time.  So, if T is the period that has been used for calculating the
--    last value of next_scheduled_damage, the new period is some T1, where T1 < T.
--    Actually, T1 is a function of T:   T1(T) = T * FACTOR_DROWNING_SECONDS.
--
--    This shortening is however restricted by MIN_DROWNING_SECONDS, so time offsets
--    won't be shortened any more if they would be less than that amount.
--    (So, we actually have T1(T) = max(MIN_DROWNING_SECONDS, T * FACTOR_DROWNING_SECONDS).)
--
--

drowning = {}	-- Exported functions

local holding_breath			= {}	-- How long have players been holding their breath?
local scheduling_interval		= {}	-- Offset used for calculating the next schedule damage.
local next_scheduled_damage		= {}	-- Next time when drowning is accounted for.
local player_bubbles			= {}	-- Number of half bubbles shown in hud.
local file = minetest.get_worldpath() .. "/drowning"

local START_DROWNING_SECONDS	= 40	-- Time that you can hold your breath unaffected.
local FACTOR_DROWNING_SECONDS	= 0.5	-- Each scheduled damage offset is shortened by this.
local MIN_DROWNING_SECONDS	= 1	-- Scheduled damage offsets won't be shorter than this.
local DROWNING_DAMAGE		= 1	-- The drowning damage dealt per scheduled offset.
local MIN_TIME_SLICE		= 0.5	-- Minimum number of seconds that must pass before
					-- the system actually does some expensive calculations.


local timer = 0
if minetest.setting_getbool("enable_damage") == true then

-- no_drown privilege
minetest.register_privilege("no_drown", {
	description = "Player is not drowning",
	give_to_singleplayer = false
})

local function init_drown_state(name)
	if holding_breath[name] == nil then
		holding_breath[name] = 0
	end
	if scheduling_interval[name] == nil then
		scheduling_interval[name] = START_DROWNING_SECONDS
	end
	if next_scheduled_damage[name] == nil then
		next_scheduled_damage[name] = START_DROWNING_SECONDS
	end
end

local function reset_drown_state(name)
	holding_breath[name]        = 0
	scheduling_interval[name]   = START_DROWNING_SECONDS
	next_scheduled_damage[name] = START_DROWNING_SECONDS
	-- Don't display breath in hud.
	local player = minetest.get_player_by_name(name)
	player:hud_remove(player_bubbles[name])
	player_bubbles[name] = nil
end

local function is_player_in_liquid(player)
	local pos = player:getpos()
	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+2.0)
	pos.z = math.floor(pos.z+0.5)
	local n_head = minetest.get_node(pos).name
	if  n_head == "ignore" then return end -- No change on startup.
	-- Check if node is liquid (0=not 2=lava 3=water).
	if minetest.get_item_group(n_head, "liquid") ~= 0 then
		return "yes"
	else
		return "no"
	end
end

local function play_drown_sound(player, filename, hear_distance)
	local headpos  = player:getpos()
	headpos.y = headpos.y + 1
	minetest.sound_play(filename,
		{pos = headpos, gain = 1.0, max_hear_distance = hear_distance})
end

local function schedule_next_damage(name)
	scheduling_interval[name] = math.floor(scheduling_interval[name]*FACTOR_DROWNING_SECONDS)
	if scheduling_interval[name] < MIN_DROWNING_SECONDS then
		scheduling_interval[name] = MIN_DROWNING_SECONDS
	end
	next_scheduled_damage[name] = next_scheduled_damage[name] + scheduling_interval[name]
end

local function on_drown(player)
	local name = player:get_player_name()
	if holding_breath[name] >= next_scheduled_damage[name] then
		if player:get_hp() > 0 then
			-- Player is still alive, so:
			-- deal damage, play sound and schedule next damage
			local new_hp = math.max(0, (player:get_hp() - DROWNING_DAMAGE))

			player:set_hp(new_hp)
			minetest.chat_send_player(name, "You are drowning.")
			schedule_next_damage(name)
		else
			-- Player has died; reset drowning state.
			reset_drown_state(name)
		end
	end
end

local function on_gasp(player)
	local name = player:get_player_name()
	reset_drown_state(name)
	play_drown_sound(player, "drowning_gasp", 32)
end

-- Display the remaining breath in hud.
function drowning.update_bar(player)
	local name = player:get_player_name()
	local bubbles = 0
	if scheduling_interval[name] > 1 then
		bubbles = math.ceil(20*((next_scheduled_damage[name] - holding_breath[name])/scheduling_interval[name]))
	end
	if player_bubbles[name] then
		player:hud_change(player_bubbles[name], "number", bubbles)
	else
		player_bubbles[name] = player:hud_add({
			hud_elem_type = "statbar",
			position = {x=0.5,y=1.0},
			text = "bubble.png",
			number = 20,
			dir = 1,
			offset = {x=(9*24)-6,y=-(4*24+8)},
			size = {x=16, y=16},
		})
	end
end

function drowning.save_drowning()
		local output = io.open(file, "w")
		for name, v in pairs(holding_breath) do
			output:write(holding_breath[name].." "..name.."\n")
		end
		io.close(output)
end

local function load_drowning()
	local input = io.open(file, "r")
	if input then
		repeat
			local breath = input:read("*n")
			local name = input:read("*l")
			if not name then break end
			name = name:sub(2)
			if not breath then breath = 0 end
			holding_breath[name] = breath
			init_drown_state(name)
			while holding_breath[name] >= next_scheduled_damage[name] do
				schedule_next_damage(name)
			end
			
		until input:read(0) == nil
		io.close(input)
	else
		drowning.save_drowning()
	end
end

load_drowning()

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not holding_breath[name] then holding_breath[name] = 0 end
end)

-- Main function
minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer >= MIN_TIME_SLICE then
		timer = timer - MIN_TIME_SLICE
	else return end
	local change = false
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		if minetest.get_player_privs(name)["no_drown"] then
			if player_bubbles[name] then
				reset_drown_state(name)
			end
			change = true
			return
		end
		init_drown_state(name)
		if is_player_in_liquid(player) == "yes" then
			holding_breath[name] = holding_breath[name] + MIN_TIME_SLICE
			drowning.update_bar(player)
			on_drown(player)
			change = true
		elseif is_player_in_liquid(player) == "no" and holding_breath[name] > 0 then
			on_gasp(player)
			change = true
		end
	end
	if change then drowning.save_drowning() end
end)

minetest.register_on_respawnplayer(function(player)
		local name = player:get_player_name()
		reset_drown_state(name)
	end)
end

