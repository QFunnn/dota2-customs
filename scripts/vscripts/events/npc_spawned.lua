--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function Events:OnNPCSpawned(event)
	local unit = EntIndexToHScript(event.entindex)

	local unit_name = unit:GetUnitName()

	-- unit creation is not instant
	-- when this filter fires, it's not finished yet and for the most part at least 1 frame is required for all fields
	-- like `owner` to be filled
	Timers:CreateTimer(0, function()
		Events:_OnNpcInitFinished(event, unit, unit_name)
	end)
end

function Events:_OnNpcInitFinished(event, unit, unit_name)
	if not unit or unit:IsNull() then
		return
	end

	local owner = unit:GetOwner()
	local owner_player_id = unit:GetPlayerOwnerID()

	if unit.IsMainHero and unit:IsMainHero() and not unit.initialized then
		GameLoop:InitHero(unit)
	end

	if
		owner
		and owner.GetPlayerID
		and (unit_name == "npc_dota_sentry_wards" or unit_name == "npc_dota_observer_wards")
	then
		local player_id = owner:GetPlayerID()
		EndGameStats:Add_PlacedWard(player_id, unit_name)
		GameLoop:ValidatePlacedWardForCamps(unit, owner:GetTeam())
	end

	if unit:IsCourier() then
		unit:AddNewModifier(unit, nil, "modifier_invulnerable_custom", { duration = -1 })
		unit:AddNewModifier(unit, nil, "modifier_courier_speed_controller", {})
	end

	if GameLoop.winrates and unit:IsRealHero() and GameLoop.winrates[unit_name] then
		local player_stats = CustomNetTables:GetTableValue("game_state", "player_stats")
		local b_no_bonus
		if
			player_stats
			and player_stats[tostring(owner_player_id)]
			and player_stats[tostring(owner_player_id)].lastWinnerHeroes
		then
			b_no_bonus = table.contains(player_stats[tostring(owner_player_id)].lastWinnerHeroes, unit_name)
		end
		if not GameLoop.low_winrate_gold_applied[owner_player_id] and not b_no_bonus then
			local winrate = math.min(GameLoop.winrates[unit_name] * 100, 49.99)
			-- if you change formula here, change it in hero_selection_overlay.js too
			local gold = math.floor((-100 * winrate + 5100) / 5) * 5

			unit:AddNewModifier(unit, nil, "modifier_gold_bonus", { gold = gold })

			GameLoop.low_winrate_gold_applied[owner_player_id] = true
		end
	end

	EventDriver:Dispatch("Events:npc_spawned", {
		unit = unit,
		unit_name = unit_name,
		owner_player_id = owner_player_id,
	})
end