--[[

Inventory Plus+ for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Copyright (c) 2013 Zeg9 <dazeg9@gmail.com>
Source Code: https://github.com/Zeg9/minetest-inventory_plus
License: GPLv3

]]--

--[[
TODO:
 * Include a few button textures, especially for "abandoned" mods
   -> Done: bags
   -> Todo: home GUI, mobf settings (if it still exists),...
 * Limit the number of buttons displayed, and then:
 * Multiple button pages (inventory can only display 9 buttons, and creative 6)
 * Fallback to text if no image is present ?
]]--


-- expose api
inventory_plus = {}

-- tell that we are inventory++, not inventory_plus
-- ...so mods know if they can use our functions like remove_button
inventory_plus.plusplus = true

-- define buttons
inventory_plus.buttons = {}

-- default inventory page
inventory_plus.default = minetest.setting_get("inventory_default") or "main"

-- original inventory formspec, per player
inventory_plus.inventory = {}

-- register_button
inventory_plus.register_button = function(player,name,...)
	local player_name = player:get_player_name()
	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {}
	end
	for _, i in ipairs(inventory_plus.buttons[player_name]) do
		if i == name then return end -- only register buttons once
	end
	table.insert(inventory_plus.buttons[player_name], name)
end

inventory_plus.remove_button = function(player,name)
	local player_name = player:get_player_name()
	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {}
	end
	local index = nil
	for i, n in ipairs(inventory_plus.buttons[player_name]) do
		if n == name then
			index = i
		end
	end
	table.remove(inventory_plus.buttons[player_name], index)
end

-- set_inventory_formspec
inventory_plus.set_inventory_formspec = function(player,formspec)
	if minetest.setting_getbool("creative_mode") then
		-- if creative mode is on then wait a bit
		minetest.after(0.01,function()
			player:set_inventory_formspec(formspec)
		end)
	else
		player:set_inventory_formspec(formspec)
	end
end

-- get_formspec
inventory_plus.get_formspec = function(player,page)
	local get_buttons = function(ox,oy,mx) -- origin x, origin y, max x
		if not inventory_plus.buttons[player:get_player_name()] then
			return ""
		end
		local formspec = ""
		local x,y=ox,oy
		for _, i in ipairs(inventory_plus.buttons[player:get_player_name()]) do
			formspec = formspec .. "image_button["..x..","..y..";1,1;inventory_plus_"..i..".png;"..i..";]"
			x=x+1
			if x >= ox+mx then
				y = y+1
				x = ox
			end
		end
		return formspec
	end
	-- craft page
	if page=="main" then
		if minetest.setting_getbool("creative_mode") then
			return player:get_inventory_formspec()
				.. get_buttons(6,0,2)
		else
			return inventory_plus.inventory[player:get_player_name()]
				.. get_buttons(0,0,3)
		end
	end
end

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)
	if inventory_plus.inventory[player:get_player_name()] == nil then
		inventory_plus.inventory[player:get_player_name()] = player:get_inventory_formspec()
	end
	minetest.after(1,function()
		inventory_plus.set_inventory_formspec(player,inventory_plus.get_formspec(player, inventory_plus.default))
	end)
end)

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- main
	if fields.main then
		if minetest.setting_getbool("creative_mode") then
			minetest.after(0.01,function()
				inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"main"))
			end)
		else
			inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"main"))
		end
		return
	end
	if fields.creative_prev or fields.creative_next then
		minetest.after(0.01,function()
			inventory_plus.set_inventory_formspec(player, inventory_plus.get_formspec(player,"main"))
		end)
		return
	end
end)

-- log that we started
minetest.log("action", "[MOD]"..minetest.get_current_modname().." -- loaded from "..minetest.get_modpath(minetest.get_current_modname()))
