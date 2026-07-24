--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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
	if not unit or unit:IsNull() then return end

	local owner = unit:GetOwner()
	local owner_player_id = unit:GetPlayerOwnerID()

	if owner and not owner:IsNull() then
		local source = GameLoop.hero_by_player_id[unit:GetPlayerOwnerID()]

		local is_tempest_double = unit.IsTempestDouble and unit:IsTempestDouble()
		local is_meepo_clone = unit.IsClone and unit:IsClone()

		if unit:IsIllusion() or is_tempest_double or is_meepo_clone then
			Upgrades:ProcessClone(unit, GetIllusionSource(unit) or source)
		else
			Upgrades:ApplySummonUpgrades(unit, unit_name, owner)
			-- not adding into ApplySummonUpgrades directly because it's also used for retroactive upgrades and will invalidate stats
			if IsValidPlayerID(owner_player_id) and unit_name and (SUMMON_TO_ABILITY_MAP[unit_name] or unit:IsSummoned()) then
				-- print("[Upgrades] AddUnitSummonedScore", owner_player_id, unit_name)
				MVPController:AddUnitSummonedScore(owner_player_id, 1)
			end
		end
	end

	if unit.IsMainHero and unit:IsMainHero() and not unit.initialized then
		GameLoop:InitHero(unit)
	end

	if unit_name == "npc_dota_courier" then
		unit:AddNewModifier(unit, nil, "modifier_invulnerable_custom", {duration = -1})
	end

	if owner and owner.GetPlayerID and (unit_name == "npc_dota_sentry_wards" or unit_name == "npc_dota_observer_wards") then
		local player_id = owner:GetPlayerID()
		EndGameStats:Add_PlacedWard(player_id, unit_name)
	end

	if unit:IsRealHero() and unit:GetName() == "npc_dota_hero_nevermore" and not unit.auto_necromastery then
		unit:AddNewModifier(unit, nil, "modifier_nevermore_necromastery_auto", {})
		unit.auto_necromastery = true
	end

	if unit:IsRealHero() and unit:GetName() == "npc_dota_hero_skeleton_king" and not unit.auto_vampiric_spirit then
		unit:AddNewModifier(unit, nil, "modifier_skeleton_king_vampiric_aura_auto", {})
		unit.auto_vampiric_spirit = true
	end

	if unit:IsRealHero() and unit:GetName() == "npc_dota_hero_night_stalker" and not unit.check_night_reign then
		local ability = unit:FindAbilityByName("night_stalker_hunter_in_the_night_custom")
		if IsValidEntity(ability) then
			ability:CheckNightReign()
		end
		unit.check_night_reign = true
	end

	if unit:IsRealHero() and unit:GetName() == "npc_dota_hero_vengefulspirit" then
		local ability = unit:FindAbilityByName("vengefulspirit_command_aura")
		if IsValidEntity(ability) and ability:IsTrained() and unit:HasScepter() then
			local duration = ability:GetSpecialValueFor("scepter_debuff_duration") or 0
			unit:AddNewModifier(unit, ability, "modifier_vengefulspirit_command_aura_scepter_debuff_lua", {duration = duration})
		end
	end

	if unit:IsCourier() then
		unit:AddNewModifier(unit, nil, "modifier_courier_speed_controller", {})
	end

	EventDriver:Dispatch("Events:npc_spawned", {
		unit = unit,
		unit_name = unit_name,
		owner_player_id = owner_player_id,
	})
end