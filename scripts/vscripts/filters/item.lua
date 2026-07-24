--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Filters.__has_locked_boots = {}

function Filters:ItemAddedToInventoryFilter(event)
	if not event.item_entindex_const then return true end
	if not event.inventory_parent_entindex_const then return true end

	local inventory_parent = EntIndexToHScript(event.inventory_parent_entindex_const)
	local item = EntIndexToHScript(event.item_entindex_const)

	if IsValidEntity(item) and IsValidEntity(inventory_parent) then
		local purchaser = item:GetPurchaser()

		if purchaser then
			-- disallow purchasing of orbs on incorrect maps
			-- order filter logic is no longer sufficient as quickbuy is not filtered anymore
			local item_name = item:GetName()
			if string.match(item_name, "_ffa") and not string.match(GetMapName(), "_ffa") then return end
			if string.match(item_name, "_duo") and not string.match(GetMapName(), "_duo") then return end
			if string.match(item_name, "_quintet") and not string.match(GetMapName(), "_quintet") then return end
			if string.match(item_name, "_octet") and not string.match(GetMapName(), "_octet") then return end
			if self:OrbAddedToInventoryFilter(item, inventory_parent) then return true end

			-- local purchaser_id = purchaser:GetPlayerID()
			-- local correct_inventory = inventory_parent:IsMainHero() or inventory_parent:GetClassname() == "npc_dota_lone_druid_bear" or inventory_parent:IsCourier()

			-- if (event.item_parent_entindex_const > 0) and item and correct_inventory then
			-- 	if not purchaser:CheckPersonalCooldown(item) then
			-- 		purchaser:RefundItem(item)
			-- 		return false
			-- 	end

			-- 	if not purchaser:IsMaxItemsForPlayer(item) then
			-- 		purchaser:RefundItem(item)
			-- 		return false
			-- 	end

				-- if item:GetAbilityName() == "item_boots" and WebSettings:GetSettingValue(purchaser_id, "lock_first_boots") and not Filters.__has_locked_boots[purchaser_id] then
				-- 	Filters.__has_locked_boots[purchaser_id] = true
				-- 	item:SetCombineLocked(true)
				-- end

				-- if not inventory_parent:IsInRangeOfShop(DOTA_SHOP_HOME, true) and item:ItemIsFastBuying(purchaser_id) then
				-- 	return item:TransferToBuyer(inventory_parent)
				-- end
			-- end
		end
	end

	if item.suggested_slot then
		event.suggested_slot = item.suggested_slot
		item.suggested_slot = nil
	end

	return true
end

local ORB_NAMES = {
	item_common_orb_ = "common",
	item_rare_orb_ = "rare",
	item_epic_orb_ = "epic",
}

function Filters:OrbAddedToInventoryFilter(item, hInventoryParent)
	local item_name = item:GetName()
	local purchaser = item:GetPurchaser()
	local owner_team = purchaser:GetTeam()
	local cost = tonumber(item:GetAbilityKeyValues().ItemCost)

	local orb_rarity
	for prefix, rarity in pairs(ORB_NAMES) do
		if string.find(item_name, prefix) then
			orb_rarity = rarity
			break
		end
	end

	if orb_rarity then
		local rarity_value = RARITY_TEXT_TO_ENUM[orb_rarity]
		local player_id = purchaser:GetPlayerOwnerID()
		local hero = PlayerResource:GetSelectedHeroEntity(player_id)
		if hero then
			hero.consumed_orbs_cost = (hero.consumed_orbs_cost or 0) + cost

			if hInventoryParent:IsCourier() then
				hero:SpendGold(cost, DOTA_ModifyGold_PurchaseConsumable)
			end
		end

		UTIL_Remove(item)
		EmitAnnouncerSoundForTeam("custom." .. orb_rarity .. "_orb", owner_team)
		Upgrades:QueueSelectionForTeam(owner_team, rarity_value)
		EndGameStats:AddCapturedOrb(owner_team, ORB_CAPTURE_TYPE.SHOP, rarity_value)

		CustomChat:MessageToTeam(player_id, PlayerResource:GetTeam(player_id), "orb_purchased_chat_message_" .. orb_rarity)

		local assumed_capture_time = TEAMS_LAYOUTS[GetMapName()]["capture_point_time"]
		MVPController:AddOrbCaptureScore(player_id, rarity_value * assumed_capture_time)

		return true
	end
end