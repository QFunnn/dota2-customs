--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Events:OnInventoryItemAdded(event)
	FilterRapierPurchase(event)
end

function FilterRapierPurchase(event)
	local player_id = event.inventory_player_id
	local unit = EntIndexToHScript(event.inventory_parent_entindex)
	local item = EntIndexToHScript(event.item_entindex)
	local item_name = event.itemname

	if item_name and item_name ~= "item_rapier" then
		return
	end
	if not IsValidPlayerID(player_id) then
		return
	end
	if not IsValidEntity(unit) then
		return
	end
	if not IsValidEntity(item) then
		return
	end
	if IsInToolsMode() then
		return
	end

	local player_hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if item:GetPurchaser() ~= player_hero or item.checker_rapier then
		return
	end

	local rapier_error
	local networth = PlayerResource:GetNetWorth(player_id)

	if GameRules:GetDOTATime(false, false) > RAPIER_CHECK_RESTRICTION_TIME then
		-- do nothing, everyone сan buy rapier now, yay
	elseif networth < RAPIER_CHECK_NETWORTH then
		rapier_error = "#rapier_error_networth"
	else
		local kills = PlayerResource:GetKills(player_id)
		local assists = PlayerResource:GetAssists(player_id)
		local deaths = math.max(PlayerResource:GetDeaths(player_id), 1)
		local ally_team = PlayerResource:GetTeam(player_id)
		local enemy_team = ally_team == DOTA_TEAM_GOODGUYS and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS
		local ally_kills = math.max(GetTeamHeroKills(ally_team), 1)
		local enemy_kills = math.max(GetTeamHeroKills(enemy_team), 1)

		if ((kills + assists / 2) / deaths) * (enemy_kills + 5 / ally_kills + 5) < 1 then
			rapier_error = "#rapier_error_kda"
		end
	end

	if rapier_error then
		item:RemoveSelf()
		player_hero:ModifyGold(GetItemCost(event.itemname), false, 0)
		CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player_id), "display_custom_error", {
			message = rapier_error,
		})
	else
		item.checker_rapier = true
	end
end