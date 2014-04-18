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
-- The mod registers a new tool named "drowning:breath_meter" which serves as a simple
-- visual indicator for how long you can stay in a liquid unaffected.  It cannot be
-- crafted; you have to use "/giveme drowning:breath_meter" to get it.  This tool is
-- really only a workaround for a missing GUI supported by the Minetest client.
--
-- You can give yourself more than one such tool, but the code only updates the
-- first tool found in your inventory.  I figured it wasn't worth the additional
-- server time necessary for updating more than one tool.
--
--

drowning = {}	-- Exported functions

local holding_breath			= {}	-- How long have players been holding their breath?
local scheduling_interval		= {}	-- Offset used for calculating the next schedule damage.
local next_scheduled_damage		= {}	-- Next time when drowning is accounted for.
local player_bubbles			= {}	-- Number of half bubbles shown in hud.

local START_DROWNING_SECONDS	= 40	-- Time that you can hold your breath unaffected.
local FACTOR_DROWNING_SECONDS	= 0.5	-- Each scheduled damage offset is shortened by this.
local MIN_DROWNING_SECONDS		= 1		-- Scheduled damage offsets won't be shorter than this.
local DROWNING_DAMAGE			= 1		-- The drowning damage dealt per scheduled offset.
local MIN_TIME_SLICE			= 0.5	-- Minimum number of seconds that must pass before
										-- the system actually does some expensive calculations.


local timer = 0
if minetest.setting_getbool("enable_damage") == true then

------------------------------------------------------------------------
-- no_drown privilege
--
-- Players with this privilege don't drown in liquids.
--
minetest.register_privilege("no_drown", {
	description = "Player is not drowning",
	give_to_singleplayer = false
})



------------------------------------------------------------------------
-- drowning_filename
--
-- Retrieves the filename used for storing the drowning value for the
-- player given as first argument.
--
local function drowning_filename(player_name)
	return minetest.get_worldpath() .. "/drowning_" .. player_name .. ".txt"
end



------------------------------------------------------------------------
-- set_drowning
--
-- Write the drowning value for a given player to a file.
--

local function set_drowning(name, value)
	local filename  = drowning_filename(name)
	local output    = io.open(filename, "w")

	if not output then
		minetest.debug("[drowning]: Cannot write drown value "..value.." to file " ..
			filename .. "; the file cannot be opened for writing!")
	else
		output:write(value)
		io.close(output)
	end
end



------------------------------------------------------------------------
-- get_drowning
--
-- Read the drowning value for a given player from a file.
--
local function get_drowning(name)
	local filename  = drowning_filename(name)
	local input     = io.open(filename, "r")

	if not input then return nil end

	drowning = input:read("*n")
	io.close(input)
	return drowning
end



------------------------------------------------------------------------
-- init_drown_state
--
-- Initialize the player's state variables, if necessary
--
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



------------------------------------------------------------------------
-- reset_drown_state
--
-- Reset the player's state to "not in liquid", so he or she is no
-- longer affected by drowning.
--
local function reset_drown_state(name)
	holding_breath[name]        = 0
	scheduling_interval[name]   = START_DROWNING_SECONDS
	next_scheduled_damage[name] = START_DROWNING_SECONDS
	-- Don't display breath in hud.
	local player = minetest.get_player_by_name(name)
	player:hud_remove(player_bubbles[name])
	player_bubbles[name] = nil
end



------------------------------------------------------------------------
-- is_player_in_liquid
--
-- Checks if the player's head is inside a node considered a liquid.
-- The decision whether the node is a liquid or not is based on the
-- node being a member of the group "liquid".
--
-- Returns true, if the player is in a liquid, otherwise false.
--
local function is_player_in_liquid(player)
	local pos = player:getpos()

	pos.x = math.floor(pos.x+0.5)
	pos.y = math.floor(pos.y+2.0)
	pos.z = math.floor(pos.z+0.5)
	
	-- Get the nodename at the player's head
	n_head = minetest.get_node(pos).name

	-- Check if node is liquid (0=not 2=lava 3=water).
	-- If it is, then the player is considered being in liquid.
	-- This includes flowing water and flowing lava
	if minetest.get_item_group(n_head, "liquid") ~= 0 then
		return true
	end
	return false
end



------------------------------------------------------------------------
-- play_drown_sound
--
-- Play a sound at the player's head position, using the hearing
-- distance specified in parameter 3.
--
local function play_drown_sound(player, filename, hear_distance)
	local headpos  = player:getpos()

	headpos.y = headpos.y + 1
	minetest.sound_play(filename,
		{pos = headpos, gain = 1.0, max_hear_distance = hear_distance})
end



------------------------------------------------------------------------
-- schedule_next_damage
--
-- Calculate the next time and the next time offset for dealing
-- drowning damage to the player.
--
local function schedule_next_damage(name)
	scheduling_interval[name] = math.floor(scheduling_interval[name]*FACTOR_DROWNING_SECONDS)

	if scheduling_interval[name] < MIN_DROWNING_SECONDS then
		scheduling_interval[name] = MIN_DROWNING_SECONDS
	end
	next_scheduled_damage[name] = next_scheduled_damage[name] + scheduling_interval[name]
end



------------------------------------------------------------------------
-- on_drown
--
-- This is called whenever the mod detects that a player is inside a
-- liquid.  The function recalculates the drowning state for that
-- player.  If the player cannot hold his/her breath any longer,
-- drowning damage is dealt and the next damage time is scheduled.
--
local function on_drown(player)
	local name = player:get_player_name()

	if holding_breath[name] >= next_scheduled_damage[name] then
		if player:get_hp() > 0 then
			-- Player is still alive, so:
			-- deal damage, play sound and schedule next damage
			local new_hp = math.max(0, (player:get_hp() - DROWNING_DAMAGE))

			player:set_hp(new_hp)
			minetest.chat_send_player(name, "You are drowning.")
			play_drown_sound(player, "drowning_gurp", 16)
			schedule_next_damage(name)
		else
			-- Player has died; reset drowning state.
			reset_drown_state(name)
		end
	end
end



------------------------------------------------------------------------
-- on_gasp
--
-- This is called whenever the mod detects that a player has just
-- escaped from a liquid.  The function resets the drowning state
-- an plays a gasping sound.
--
local function on_gasp(player)
	local name = player:get_player_name()

	reset_drown_state(name)
	play_drown_sound(player, "drowning_gasp", 32)
	-- Don't display breath in hud.
	player:hud_remove(player_bubbles[name])
	player_bubbles[name] = nil
end



------------------------------------------------------------------------
-- Main script

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if not get_drowning(name) then
		set_drowning(name, 0)
	end
	holding_breath[name] = get_drowning(name)
end)

-- main function
minetest.register_globalstep(function(dtime)
	timer = timer + dtime

	if timer >= MIN_TIME_SLICE then
		timer = timer - MIN_TIME_SLICE
	else
		-- Not much time has passed since the last time we calculated
		-- the player's drowning states.  To reduce load on the server,
		-- we skip the calculation for now and let more time pass.
		return
	end

	for _,player in ipairs(minetest.get_connected_players()) do

		local name = player:get_player_name()
		
		if minetest.get_player_privs(name)["no_drown"] then
			return
		end
		
		init_drown_state(name)

		if is_player_in_liquid(player) then
			holding_breath[name] = holding_breath[name] + MIN_TIME_SLICE
			on_drown(player)
			-- Display the remaining breath in hud.
			local bubbles = 0
			if scheduling_interval[name] > 1 then
				bubbles = math.ceil(20*((next_scheduled_damage[name] - holding_breath[name])/scheduling_interval[name]))
			end
			if player_bubbles[name] then
				player:hud_change(player_bubbles[name], "number", bubbles)
			else
				player_bubbles[name] = player:hud_add({
					hud_elem_type = "statbar",
					text = "bubble.png",
					number = 20,
					dir = 0,
					position = {x=0.5,y=0.9},
					offset = {x=0, y=2},
				})
			end
		elseif holding_breath[name] > 0 then
			on_gasp(player)
		end

		-- save drowningcounter
		set_drowning(name, holding_breath[name])
	end
end)

minetest.register_on_respawnplayer(function(player)
		local name = player:get_player_name()
		reset_drown_state(name)
	end)
end

