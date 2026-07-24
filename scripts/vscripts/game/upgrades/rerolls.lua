--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


UpgradeRerolls = UpgradeRerolls or class({})


function UpgradeRerolls:Init()
	UpgradeRerolls.current_free_rerolls = {}
	UpgradeRerolls.free_rerolls = IsInToolsMode() or GetMapName() == "ot3_demo"

	UpgradeRerolls.used_rerolls = {}

	EventDriver:Listen("WebInventory:update", UpgradeRerolls._UpdateRerollCount, UpgradeRerolls)
end


function UpgradeRerolls:PreparePlayer(player_id)
	UpgradeRerolls.current_free_rerolls[player_id] = WebPlayer:GetSubscriptionTier(player_id) * 4
	local current_consumable_rerolls = WebInventory:GetItemCount(player_id, "bp_reroll")

	if UpgradeRerolls.free_rerolls then
		UpgradeRerolls.current_free_rerolls[player_id] = 99999
		current_consumable_rerolls = 0
	end

	local complete_rerolls = UpgradeRerolls.current_free_rerolls[player_id] + current_consumable_rerolls

	-- disabled consumable rerolls in tournament mode, force set of free rerolls
	if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) then
		UpgradeRerolls.current_free_rerolls[player_id] = TOURNAMENT_REROLLS
		complete_rerolls = TOURNAMENT_REROLLS
	end

	CustomNetTables:SetTableValue("rerolls", tostring(player_id), {
		count = complete_rerolls
	})
end


function UpgradeRerolls:_ConsumeRerolls(player_id, rarity)
	-- check if we have enough of free rerolls to spend
	local current_free_rerolls = UpgradeRerolls.current_free_rerolls[player_id] or 0
	local current_consumable_rerolls = WebInventory:GetItemCount(player_id, "bp_reroll")

	-- disabled consumable rerolls in tournament mode
	if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) then current_consumable_rerolls = 0 end
	if UpgradeRerolls.free_rerolls then
		current_free_rerolls = 99999
		current_consumable_rerolls = 0
		rarity = 0
	end

	if current_free_rerolls >= rarity then
		UpgradeRerolls.current_free_rerolls[player_id] = current_free_rerolls - rarity
		print("[UpgradeRerolls] reroll funded by free rerolls: " .. current_free_rerolls .. " => " .. UpgradeRerolls.current_free_rerolls[player_id])
		return true
	end

	-- otherwise check if we have at least some free rerolls to reduce passed rarity for consumable rerolls
	if current_free_rerolls > 0 and (current_free_rerolls + current_consumable_rerolls) >= rarity then
		rarity = rarity - current_free_rerolls
		UpgradeRerolls.current_free_rerolls[player_id] = 0
		print("[UpgradeRerolls] reroll partially compensated by free rerolls: " .. rarity + current_free_rerolls .. " => " .. rarity)
	end

	if current_consumable_rerolls >= rarity then
		print("[UpgradeRerolls] reroll funded by consumable rerolls: ", rarity)
		UpgradeRerolls.used_rerolls[player_id] = (UpgradeRerolls.used_rerolls[player_id] or 0) + rarity
		WebInventory:ModifyBackendItemCount(player_id, "bp_reroll", -rarity)
		return true
	end

	print("[UpgradeRerolls] not enough rerolls to reroll")

	return false
end


function UpgradeRerolls:ConsumeRerolls(player_id, rarity)
	local reroll_allowed = UpgradeRerolls:_ConsumeRerolls(player_id, rarity)

	if reroll_allowed then
		UpgradeRerolls:UpdateRerollCount(player_id)
	end

	return reroll_allowed
end


function UpgradeRerolls:UpdateRerollCount(player_id)
	local current_free_rerolls = UpgradeRerolls.current_free_rerolls[player_id] or 0
	local current_consumable_rerolls = WebInventory:GetItemCount(player_id, "bp_reroll")

	if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) or UpgradeRerolls.free_rerolls then
		current_consumable_rerolls = 0
	end

	CustomNetTables:SetTableValue("rerolls", tostring(player_id), {
		count = current_free_rerolls + current_consumable_rerolls
	})
end


function UpgradeRerolls:_UpdateRerollCount(event)
	if not IsValidPlayerID(event.player_id) then return end
	UpgradeRerolls:UpdateRerollCount(event.player_id)
end



UpgradeRerolls:Init()