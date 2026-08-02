--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local function GetItemList(hero)
	local list = {}

	for i = 0, DOTA_ITEM_TP_SCROLL do
		local item = hero:GetItemInSlot(i)

		if item then
			local behavior = tonumber(tostring(item:GetBehavior()))

			if not TestFlag(behavior, DOTA_ABILITY_BEHAVIOR_UNSWAPPABLE) then
				list[i] = hero:TakeItem(item)
			end
		end
	end

	return list
end

local function SetOwner(hero, player_id, item_list)
	local player = PlayerResource:GetPlayer(player_id)

	if not player then
		return
	end

	player:SetSelectedHero(hero:GetUnitName())
	player:SetAssignedHeroEntity(hero)
	hero:SetOwner(player)
	hero:SetPlayerID(player_id)
	hero:SetControllableByPlayer(player_id, true)

	for slot, item in pairs(item_list) do
		hero:AddItem(item)
		item:SetPurchaser(hero)
		item:SetOwner(hero)

		local new_slot = item:GetItemSlot()

		if new_slot ~= slot then
			hero:SwapItems(slot, new_slot)
		end

		--print(item:GetAbilityName(), item:GetPurchaser():GetName())
	end
end

function Events:OnHeroSwapped(event)
	local hero1 = PlayerResource:GetSelectedHeroEntity(event.playerid1)
	local hero2 = PlayerResource:GetSelectedHeroEntity(event.playerid2)

	local is_perk_chosen = GamePerks.chosen_perks[hero1:GetPlayerID()] or GamePerks.chosen_perks[hero2:GetPlayerID()]

	-- if someone already have perk swap heroes back and show error message
	if is_perk_chosen then
		local items_list1 = GetItemList(hero1)
		local items_list2 = GetItemList(hero2)

		SetOwner(hero1, event.playerid2, items_list2)
		SetOwner(hero2, event.playerid1, items_list1)

		DisplayError(event.playerid1, "#hero_swap_blocked")
		DisplayError(event.playerid2, "#hero_swap_blocked")
	else
		GamePerks:UpdatePlayerInfo(event.playerid1)
		GamePerks:UpdatePlayerInfo(event.playerid2)
	end
end