if not minetest.setting_getbool("creative_mode") then

local default_dig = minetest.node_dig

function minetest.node_dig(pos, node, digger)
	if not digger:is_player() then
		return
	end
	local inv = digger:get_inventory()
	local wielded = digger:get_wielded_item()
	local drops = minetest.get_node_drops(node.name, wielded:get_name())
	for i,v in ipairs(drops) do
		if not inv:room_for_item("main", v) then
			player = digger:get_player_name()
			minetest.chat_send_player(player, "Your inventory is full.")
			return
		end
	end
		default_dig(pos, node, digger)
end

local __builtin_item = minetest.registered_entities["__builtin:item"]
local default_itempunch = __builtin_item.on_punch

function __builtin_item.on_punch(self, hitter)
	local inv = hitter:get_inventory()
	if inv:room_for_item("main", self.itemstring) then
		default_itempunch(self, hitter)
	else
		player = hitter:get_player_name()
		minetest.chat_send_player(player, "Your inventory is full.")
	end
end

end
