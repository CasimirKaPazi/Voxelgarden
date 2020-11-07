-- Load support for MT game translation.
local S = minetest.get_translator("compostbin")

--
-- Formspecs
--

local function active_formspec(item_percent)
	local formspec = 
		"size[8,8.5]"..
		"list[current_name;src;2.5,2;1,1;]"..
		"image[3.5,2;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
		"list[current_name;dst;4.5,2;1,1;]"..
		"list[current_player;main;0,4.75;8,4;]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		"listring[current_player;main]"
	return formspec
end

local inactive_formspec =
	"size[8,8.5]"..
	"list[current_name;src;2.5,2;1,1;]"..
	"image[3.5,2;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
	"list[current_name;dst;4.5,2;1,1;]"..
	"list[current_player;main;0,4.75;8,4;]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"listring[current_player;main]"

--
-- Compostable Items
--

compostbin = {}
compostbin.compostable_groups = {'flora', 'leaves', 'flower', 'fungi'}
compostbin.compostable_nodes = {
	'default:cactus',
	'default:papyrus',
	'default:dry_shrub',
	'default:junglegrass',
	'default:grass_1',
	'default:dry_grass_1',
	'farming:wheat',
	'farming:straw',
	'farming:cotton',
}

local function is_compostable(input)
	for _, v in pairs(compostbin.compostable_groups) do
		if minetest.get_item_group(input, v) > 0 then
			return true
		end
	end
	for _, v in pairs(compostbin.compostable_nodes) do
		if input == v then
			return true
		end
	end
	return false
end

--
-- Node callback functions that are the same for active and inactive compost bin
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

local function compost_node_timer(pos, elapsed)
	-- Inizialize metadata
	local meta = minetest.get_meta(pos)
	local src_time = meta:get_float("src_time") or 0
	local inv = meta:get_inventory()
	local srclist
	local cookable
	local update = true
	local cooktime = 30
	while elapsed > 0 and update do
		update = false
		srclist = inv:get_list("src")
		-- Cooking
		-- Check if we have cookable content
		cookable = is_compostable(srclist[1]:get_name())
		local el = elapsed
		if cookable then -- fuel lasts long enough, adjust el to cooking duration
			el = math.min(el, cooktime - src_time)
		end
		-- If there is a cookable item then check if it is ready yet
		if cookable then
			src_time = src_time + el
			if src_time >= cooktime then
				-- Place result in dst list if possible
				if inv:room_for_item("dst", "compostbin:compost") then
					inv:add_item("dst", "compostbin:compost")
					local stk = inv:get_stack("src", 1)
					stk:set_count(1)
					inv:remove_item("src", stk)
					src_time = src_time - cooktime
					update = true
				end
			else
				-- Item could not be cooked: probably missing fuel
				update = true
			end
		end
		elapsed = elapsed - el
	end
	if srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec = inactive_formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooktime * 100)
		if item_percent > 100 then
			item_state = S("100% (output full)")
		else
			item_state = S("@1%", item_percent)
		end
	else
		if srclist[1]:is_empty() then
			item_state = S("Empty")
		else
			item_state = S("Not cookable")
		end
	end

	local active = false
	local result = false

	-- Update node. Have a filled bin as long as there is input or output.
	if not srclist[1]:is_empty() or not inv:get_list("dst")[1]:is_empty() then
		active = true
		formspec = active_formspec(item_percent)
		swap_node(pos, "compostbin:wood_bin_full")
		-- make sure timer restarts automatically
		result = true
	else
		swap_node(pos, "compostbin:wood_bin")
		-- stop timer on the inactive compost bin
		minetest.get_node_timer(pos):stop()
	end
	local infotext
	if active then
		infotext = S("Compost bin active (Item: @1)", item_state)
	else
		infotext = S("Compost bin inactive (Item: @1)", item_state)
	end
	-- Set meta values
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

--
-- Node definitions
--

minetest.register_node("compostbin:wood_bin", {
	description = S("Compost Bin"),
	tiles = {
		"default_wood.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2}},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 3},
	sounds =  default.node_sound_wood_defaults(),

	can_dig = can_dig,
	on_timer = compost_node_timer,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", inactive_formspec)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('dst', 1)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether compost bin can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_node("compostbin:wood_bin_full", {
	description = S("Compost Bin"),
	tiles = {
		"default_wood.png^compostbin_compost_top.png",
		"default_wood.png^compostbin_compost_top.png",
		"default_wood.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {{-1/2, -1/2, -1/2, 1/2, -3/8, 1/2},
			{-1/2, -1/2, -1/2, -3/8, 1/2, 1/2},
			{3/8, -1/2, -1/2, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 1/2, -3/8},
			{-1/2, -1/2, 3/8, 1/2, 1/2, 1/2},
			{-3/8, -1/2, -3/8, 3/8, 3/8, 3/8}},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	paramtype = "light",
	is_ground_content = false,
	groups = {choppy = 3, not_in_creative_inventory = 1},
	sounds =  default.node_sound_wood_defaults(),

	on_timer = compost_node_timer,
	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_craft({
	output = "compostbin:wood_bin 3",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"group:wood", "", "group:wood"},
		{"group:wood", "group:stick", "group:wood"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "compostbin:wood_bin",
	burntime = 30,
})

minetest.register_craftitem("compostbin:compost", {
	description = S("Compost"),
	inventory_image = "compostbin_compost.png",
})

minetest.register_craft({
	output = "default:dirt",
	recipe = {
		{"compostbin:compost", "compostbin:compost", "compostbin:compost"},
		{"compostbin:compost", "compostbin:compost", "compostbin:compost"},
		{"compostbin:compost", "compostbin:compost", "compostbin:compost"},
	}
})

minetest.register_alias("kompost:compost", "compostbin:compost")
minetest.register_alias("kompost:wood_bin", "compostbin:wood_bin")
minetest.register_alias("kompost:wood_bin_full", "compostbin:wood_bin_full")
