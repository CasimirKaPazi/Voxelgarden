-- Hud alignment
local health_bar_definition =
{
	hud_elem_type = "statbar",
	position = { x=0.5, y=1 },
	text = "heart.png",
	number = 20,
	direction = 0,
	size = {x=16, y=16},
	offset = {x=(-9*24)-12, y=-(48+24+8)},
}

local breath = 20
minetest.register_on_joinplayer(function(player)
	player:set_properties({breath_max = breath})
	player:set_breath(breath)
end)

local breath_bar_definition = {
	hud_elem_type = "statbar",
	position = {x = 0.5, y = 1},
	text = "bubble.png",
	number = breath,
	item = breath,
	direction = 1,
	size = {x = 16, y = 16},
	offset = {x = (9*24)-6, y= -(3*24+8+16)},
}

core.hud_replace_builtin("health", health_bar_definition)
core.hud_replace_builtin("breath", breath_bar_definition)


-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

default.gui_survival_form = "size[8,7.5]"..
--			default.gui_bg..
--			default.gui_bg_img..
--			default.gui_slots..
			"list[current_player;main;  0,3.5; 8,1;]"..
			"list[current_player;main;  0,4.75; 8,3; 8]"..
			"list[current_player;craft; 3,0; 3,3;]"..
			"list[current_player;craftpreview; 7,1; 1,1;]"..
--			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

minetest.register_on_joinplayer(function(player)
	-- set GUI
	if not minetest.settings:get_bool("creative_mode") then
		player:set_inventory_formspec(default.gui_survival_form)
	end
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)
