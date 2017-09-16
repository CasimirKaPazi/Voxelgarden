-- Minetest 0.4 mod: bucket
-- See README.txt for licensing and other information.

minetest.register_alias("bucket", "bucket:bucket_empty")
minetest.register_alias("bucket_water", "bucket:bucket_water")
minetest.register_alias("bucket_lava", "bucket:bucket_lava")

minetest.register_craft({
	output = 'bucket:bucket_empty 1',
	recipe = {
		{'group:metal_ingot', '', 'group:metal_ingot'},
		{'', 'group:metal_ingot', ''},
	}
})

bucket = {}
bucket.liquids = {}

local function check_protection(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

-- Register a new liquid
--   source = name of the source node
--   flowing = name of the flowing node
--   itemname = name of the new bucket item (or nil if liquid is not takeable)
--   inventory_image = texture of the new bucket item (ignored if itemname == nil)
-- This function can be called from any mod (that depends on bucket).
function bucket.register_liquid(source, flowing, itemname, inventory_image, name)
	bucket.liquids[source] = {
		source = source,
		flowing = flowing,
		itemname = itemname,
	}
	bucket.liquids[flowing] = bucket.liquids[source]
	if not itemname then return end

	minetest.register_craftitem(itemname, {
		description = name,
		inventory_image = inventory_image,
		stack_max = 1,
		liquids_pointable = true,
		on_place = function(itemstack, user, pointed_thing)
			-- Must be pointing to node
			if pointed_thing.type ~= "node" then
				return
			end
			
			local node = minetest.get_node_or_nil(pointed_thing.under)
			local ndef
			if node then
				ndef = minetest.registered_nodes[node.name]
			end
			-- Call on_rightclick if the pointed node defines it
			if ndef and ndef.on_rightclick and
			   user and not user:get_player_control().sneak then
				return ndef.on_rightclick(
					pointed_thing.under,
					node, user,
					itemstack) or itemstack
			end

			local place_liquid = function(pos, node, source, flowing)
				if check_protection(pos,
						user and user:get_player_name() or "",
						"place "..source) then
					return
				end
				minetest.add_node(pos, {name=source})
			end

			-- Check if pointing to a buildable node
			if ndef and ndef.buildable_to then
				-- Buildable; replace the node
				place_liquid(pointed_thing.under, node, source, flowing)
			else
				-- Not buildable to; place the liquid above
				-- Check if the node above can be replaced
				local node = minetest.get_node_or_nil(pointed_thing.above)
				if node and minetest.registered_nodes[node.name].buildable_to then
					place_liquid(pointed_thing.above, node, source, flowing)
				else
					-- Do not remove the bucket with the liquid
					return
				end
			end
			return {name="bucket:bucket_empty"}
		end
	})
end

minetest.register_craftitem("bucket:bucket_empty", {
	description = "Empty Bucket",
	inventory_image = "bucket.png",
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		-- Check if pointing to a liquid source
		local node = minetest.get_node(pointed_thing.under)
		local liquiddef = bucket.liquids[node.name]
		if liquiddef ~= nil and liquiddef.itemname ~= nil and
			node.name == liquiddef.source then
			if check_protection(pointed_thing.under,
					user:get_player_name(),
					"take ".. node.name) then
				return
			end
			
			-- Only one bucket: replace
			local count = itemstack:get_count()
			if count == 1 then
				minetest.add_node(pointed_thing.under, {name="air"})
				return ItemStack({name = liquiddef.itemname,
					metadata = tostring(node.param2)})
			end

			-- Staked buckets: add a filled bucket, replace stack
			local inv = user:get_inventory()
			if inv:room_for_item("main", liquiddef.itemname) then
				minetest.add_node(pointed_thing.under, {name="air"})
				count = count - 1
				itemstack:set_count(count)
				bucket_liquid = ItemStack(liquiddef.itemname)
				inv:add_item("main", bucket_liquid)
				return itemstack
			else
				minetest.chat_send_player(user:get_player_name(), "Your inventory is full.")
			end

		end
	end,
})

bucket.register_liquid(
	"default:water_source",
	"default:water_flowing",
	"bucket:bucket_water",
	"bucket_water.png",
	"Water Bucket"
)

bucket.register_liquid(
	"default:lava_source",
	"default:lava_flowing",
	"bucket:bucket_lava",
	"bucket_lava.png",
	"Lava Bucket"
)

minetest.register_craft({
	type = "fuel",
	recipe = "bucket:bucket_lava",
	burntime = 60,
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}},
})
