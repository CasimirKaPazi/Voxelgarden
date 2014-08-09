local auto_refill = false  -- set to "true" if you want get refilled your stack automatic

function refill(player, stck_name, index)
	local inv = player:get_inventory()
	for i,stack in ipairs(inv:get_list("main")) do
		if stack:get_name() == stck_name then
			inv:set_stack("main", index, stack)
			stack:clear()
			inv:set_stack("main", i, stack)
			minetest.log("action", "Intweak-mod: refilled stack("..stck_name..") of "  .. player:get_player_name()  )
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

local wielded = {}
wielded.name = {}
wielded.wear = {}

minetest.register_on_punchnode(function(pos, node, puncher)
	if not puncher or minetest.setting_getbool("creative_mode") then
		return
	end
	local name = puncher:get_player_name()

	local item = puncher:get_wielded_item()
	local tname = item:get_name()
	local def = minetest.registered_tools[tname]

	wielded.name[name] = tname

	if not item or not tname or tname == "" or not def then
		return
	end
	local typ = def.type
	if not typ or typ ~= "tool" then
		return
	end
	wielded.wear[name] = item:get_wear()
	-- TODO: re-add for costum tools like lighter
end)

minetest.register_on_dignode(function(pos, oldnode, digger)
	if not digger then return end

	local name = digger:get_player_name()
	local item = digger:get_wielded_item()
	local index = digger:get_wield_index()
	local tname = item:get_name()
	local def = minetest.registered_tools[tname]

	if not item then
		return
	end
	if tname ~= "" then
		if not def then
			return
		end
	end
	--[[if not typ or typ ~= "tool" then
		return
	end]]

	local old_name = wielded.name[name]
	if tname == old_name and tname == "" then
		return
	end

	local old = wielded.wear[name]
	if not old and tname == "" then
		old = 0
	end
	local new = item:get_wear()

	if old ~= new then
		if old > 0 and new == 0 then
			wielded.wear[name] = new
			minetest.sound_play("intweak_tool_break", {
				pos = digger:getpos(),
				gain = 0.9,
				max_hear_distance = 5
			})
			if auto_refill == true then
				minetest.after(0.01, refill, digger, old_name, index)
			end
		end
	end
end)
