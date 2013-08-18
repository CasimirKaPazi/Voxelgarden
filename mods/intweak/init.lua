local auto_refill = true  -- set to false if you dont want get refilled your stack automatic

function refill(player, stck_name, index)
	local inv = player:get_inventory()
	for i,stack in ipairs(inv:get_list("main")) do
		if stack:get_name() == stck_name then
			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)
			minetest.log("action", "intweak-mod: refilled stack of"  .. player:get_player_name()  )
			return
		end
	end
end

if auto_refill == true then
	minetest.register_on_placenode(function(pos, newnode, placer, oldnode)
		if not placer then return end
		local index = placer:get_wield_index()
		local cnt = placer:get_wielded_item():get_count()-1
		if minetest.setting_getbool("creative_mode") then
			return true
		else
			if cnt == 0 then
				minetest.after(0.01, refill, placer, newnode.name, index)
			end
		end
	end)
end

--[[
local ttyp = {}
local tools = {}

minetest.register_on_punchnode(function(pos, node, puncher)
	if not puncher then return end
	if minetest.setting_getbool("creative_mode") then return end
	tools[puncher:get_player_name()] = puncher:get_wielded_item():get_name()
	ttyp[puncher:get_player_name()] = minetest.registered_items[tools[puncher:get_player_name()] ].type
	local left = puncher:get_wielded_item():get_wear() + 65535/65--)
	local tab = minetest.registered_tools[tools[puncher:get_player_name()] ]
	if tab == nil then return end
	local left = tonumber(dump(tab["uses"]))
	if left == nil then return end
	left = puncher:get_wielded_item():get_wear() + 65535/left
	if ttyp[puncher:get_player_name()] == "tool" and left >= 65535 then
		minetest.sound_play("intweak_tool_break", {pos = puncher:getpos(), gain = 1.5, max_hear_distance = 5})
		if auto_refill == true then minetest.after(0.01, refill, puncher, tools[puncher:get_player_name()], puncher:get_wield_index()) end
	end
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
		if not digger then return end
		if minetest.setting_getbool("creative_mode") then return end
		local num = digger:get_wielded_item():get_wear()
		local index = digger:get_wield_index()
		if num == 0 and ttyp[digger:get_player_name()] == "tool" then
			minetest.sound_play("intweak_tool_break", {pos = digger:getpos(),gain = 1.5, max_hear_distance = 5})
			if auto_refill == true then minetest.after(0.01, refill, digger, tools[digger:get_player_name()], index) end
		end
end)
--]]
--print("[Mod] Inventory Tweak _loaded")
