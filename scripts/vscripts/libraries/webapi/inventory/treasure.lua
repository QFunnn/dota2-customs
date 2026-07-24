--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebTreasure = WebTreasure or class({})


function WebTreasure:RollTreasureItem(player_id, pool)
	local weight_pool = {}
	local total_weight = 0

	for _, item_name in pairs(pool or {}) do
		local rarity = WebInventory:GetItemRarity(item_name)
		local weight = TREASURE_CHANCE_FROM_RARITY[rarity]

		if rarity < TREASURE_DUPLICATE_THRESHOLD then
			-- items with rarity below threshold cannot be duplicated
			if not WebInventory:HasItem(player_id, item_name) then
				weight_pool[item_name] = weight
				total_weight = total_weight + weight
			end
		else
			weight_pool[item_name] = weight
			total_weight = total_weight + weight
		end
	end

	local rolled_value = RandomInt(0, total_weight)

	for item_name, weight in pairs(weight_pool) do
		rolled_value = rolled_value - weight
		if rolled_value <= 0 then
			return item_name
		end
	end
end


function WebTreasure:OnTreasureUsed(player_id, item_name, item_data, definition)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local treasure_pool = WebInventory.treasure_pools[item_name]
	if not treasure_pool then
		print("[WebTreasure] no pool for treasure", item_name)
		return
	end

	local rolled_item = WebTreasure:RollTreasureItem(player_id, treasure_pool)

	if not rolled_item then
		error("[WebTreasure] Failed to roll item from treasure " .. item_name)
		return
	end

	print("[WebTreasure] rolled", rolled_item)

	local rolled_duplicate = false
	local currency = 0
	if WebInventory:HasItem(player_id, rolled_item) then
		-- add glory instead
		rolled_duplicate = true
		-- get currency value from item rarity
		print("[WebInvetory] rolled duplicate, giving currency", rolled_item)
		currency = TREASURE_CURRENCY_FOR_DUPLICATE[WebInventory:GetItemRarity(rolled_item)]

		WebPlayer:AddBackendCurrency(player_id, currency)
	else
		print("[WebInvetory] adding new item", rolled_item)
		currency = nil
		WebInventory:AddBackendItem(player_id, rolled_item, 1)
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebTreasure:roll_result", {
		rolled_duplicate = rolled_duplicate,
		item_name = rolled_item,
		currency = currency
	})
end