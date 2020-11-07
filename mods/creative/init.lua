-- minetest/creative/init.lua

creative_inventory = {}
creative_inventory.creative_inventory_size = 0

if minetest.settings:get_bool("creative_mode") then

	-- Create detached creative inventory after loading all mods
	minetest.after(0, function()
		local inv = minetest.create_detached_inventory("creative", {
			allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
					return count
			end,
			allow_put = function(inv, listname, index, stack, player)
				return 0
			end,
			allow_take = function(inv, listname, index, stack, player)
				return -1
			end,
			on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			end,
			on_put = function(inv, listname, index, stack, player)
			end,
			on_take = function(inv, listname, index, stack, player)
				print(player:get_player_name().." takes item from creative inventory; listname="..dump(listname)..", index="..dump(index)..", stack="..dump(stack))
				if stack then
					print("stack:get_name()="..dump(stack:get_name())..", stack:get_count()="..dump(stack:get_count()))
				end
			end,
		})
		local creative_list = {}
		for name,def in pairs(minetest.registered_items) do
			if (not def.groups.not_in_creative_inventory or def.groups.not_in_creative_inventory == 0)
					and def.description and def.description ~= "" then
				creative_list[#creative_list+1] = name
			end
		end
		table.sort(creative_list)
		inv:set_size("main", #creative_list)
		inv:set_list("main", creative_list)
		creative_inventory.creative_inventory_size = #creative_list
		print("creative inventory size: "..dump(creative_inventory.creative_inventory_size))
	end)

	-- Create the trash field
	local trash = minetest.create_detached_inventory("creative_trash", {
		-- Allow the stack to be placed and remove it in on_put()
		-- This allows the creative inventory to restore the stack
		allow_put = function(inv, listname, index, stack, player)
			return stack:get_count()
		end,
		on_put = function(inv, listname, index, stack, player)
			inv:set_stack(listname, index, "")
		end,
	})
	trash:set_size("main", 1)

	creative_inventory.set_creative_formspec = function(player, start_i, pagenum)
		pagenum = math.floor(pagenum)
		local pagemax = math.floor((creative_inventory.creative_inventory_size-1) / (6*4) + 1)
		player:set_inventory_formspec("size[13,7.5]"..
				--"image[6,0.6;1,2;player.png]"..
				"list[current_player;main;5,3.5;8,4;]"..
				"list[current_player;craft;8,0;3,3;]"..
				"list[current_player;craftpreview;12,1;1,1;]"..
				"list[detached:creative;main;0.3,0.5;4,6;"..tostring(start_i).."]"..
				"label[2.0,6.55;"..tostring(pagenum).."/"..tostring(pagemax).."]"..
				"button[0.3,6.5;1.6,1;creative_prev;<<]"..
				"button[2.7,6.5;1.6,1;creative_next;>>]"..
				"listring[current_player;main]"..
				"listring[current_player;craft]"..
				"listring[current_player;main]"..
				"listring[detached:creative;main]"..
				"label[5,1.5;Trash:]"..
				"list[detached:creative_trash;main;5,2;1,1;]")
	end

	minetest.register_on_joinplayer(function(player)
		creative_inventory.set_creative_formspec(player, 0, 1)
	end)

	minetest.register_on_player_receive_fields(function(player, formname, fields)
		-- Figure out current page from formspec
		local current_page = 0
		local formspec = player:get_inventory_formspec()
		local start_i = string.match(formspec, "list%[detached:creative;main;[%d.]+,[%d.]+;[%d.]+,[%d.]+;(%d+)%]")
		start_i = tonumber(start_i) or 0

		if fields.creative_prev then
			start_i = start_i - 4*6
		end
		if fields.creative_next then
			start_i = start_i + 4*6
		end

		if start_i < 0 then
			start_i = start_i + 4*6
		end
		if start_i >= creative_inventory.creative_inventory_size then
			start_i = start_i - 4*6
		end
		
		if start_i < 0 or start_i >= creative_inventory.creative_inventory_size then
			start_i = 0
		end

		creative_inventory.set_creative_formspec(player, start_i, start_i / (6*4) + 1)
	end)
	
	local digtime = 0.15*3
	local caps = {times = {digtime, digtime, digtime}, uses = 0, maxlevel = 3}
	minetest.register_item(":", {
		type = "none",
		wield_image = "wieldhand.png",
		wield_scale = {x=1,y=1,z=1.5},
		range = 10,
		tool_capabilities = {
			full_punch_interval = 0.5,
			groupcaps = {
				crumbly = caps,
				cracky = caps,
				snappy = caps,
				choppy = caps,
				oddly_breakable_by_hand = caps,
			},
			damage_groups = {fleshy=1},
		},
	})
	
	minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack)
		return true
	end)
	
	function minetest.handle_node_drops(pos, drops, digger)
		if not digger or not digger:is_player() then
			return
		end
		local inv = digger:get_inventory()
		if inv then
			for _,item in ipairs(drops) do
				item = ItemStack(item):get_name()
				if not inv:contains_item("main", item) then
					inv:add_item("main", item)
				end
			end
		end
	end

	minetest.register_on_item_eat(function(hp_change, replace_with_item, itemstack, player, pointed_thing)
		local hp = player:get_hp()
		player:set_hp(hp + hp_change)
		return itemstack
	end)

	--
	-- Allow crative players to remove liquids the fast way
	--

	local water_source_groups = minetest.registered_nodes["default:water_source"].groups
	water_source_groups.dig_immediate = 3
	minetest.override_item("default:water_source", {
		diggable = true,
		groups = water_source_groups,
		drop = "default:water_source"
	})

	local water_flowing_groups = minetest.registered_nodes["default:water_flowing"].groups
	water_flowing_groups.dig_immediate = 3
	minetest.override_item("default:water_flowing", {
		diggable = true,
		groups = water_flowing_groups,
	})

	local lava_source_groups = minetest.registered_nodes["default:lava_source"].groups
	lava_source_groups.dig_immediate = 3
	minetest.override_item("default:lava_source", {
		diggable = true,
		groups = lava_source_groups,
		drop = "default:lava_source"
	})

	local lava_flowing_groups = minetest.registered_nodes["default:lava_flowing"].groups
	lava_flowing_groups.dig_immediate = 3
	minetest.override_item("default:lava_flowing", {
		diggable = true,
		groups = lava_flowing_groups,
	})

end
