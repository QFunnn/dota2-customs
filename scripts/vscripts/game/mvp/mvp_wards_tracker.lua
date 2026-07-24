--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WARD_RANGE_SENTRY = 1000
WARD_RANGE_OBSERVER = 1600

MVPWardsTracker = MVPWardsTracker or class({})

function MVPWardsTracker:Init()
	EventDriver:Listen("Events:state_changed", MVPWardsTracker.OnGameStateChanged, MVPWardsTracker)
end


function MVPWardsTracker:OnGameStateChanged(event)
	if event.state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		MVPWardsTracker:TrackHeroes()
	end
end


function MVPWardsTracker:TrackHeroes()
	Timers:CreateTimer(0.5, function()
		local heroes_count = table.count(GameLoop.hero_by_player_id)
		local timer_delay = heroes_count / 30.0

		for delay, hero in pairs(GameLoop.hero_by_player_id) do
			local team = hero:GetTeamNumber()

			local wards = MVPWardsTracker:FindWardsInRange(hero, team)
			local is_in_central_ring = hero:HasModifier("modifier_central_ring")
			local is_alive = hero:IsAlive()

			if not is_in_central_ring and is_alive then
				for _, observer in pairs(wards.observers) do
					if observer:CanEntityBeSeenByMyTeam(hero) then
						MVPController:AddWardsRevealTimeScore(observer:GetPlayerOwnerID(), timer_delay)
					end
				end
			end

			if hero:IsInvisible()
			and not (
				is_in_central_ring
				or not is_alive
				or hero:HasModifier("modifier_slark_depth_shroud")
				or hero:HasModifier("modifier_slark_shadow_dance")
				or hero:HasModifier("modifier_smoke_of_deceit")
				-- or hero:HasModifier("modifier_phantom_assassin_blur_active")
			)
			then
				for _, sentry in pairs(wards.sentries) do
					MVPController:AddWardsRevealTimeScore(sentry:GetPlayerOwnerID(), MVP_SENTRY_WARD_MULTIPLIER * timer_delay)
				end
			end
		end

		return timer_delay
	end)
end


function MVPWardsTracker:FindWardsInRange(hero, team)
	local units = FindUnitsInRadius(
		team,
		hero:GetAbsOrigin(),
		nil,
		math.max(WARD_RANGE_OBSERVER, WARD_RANGE_SENTRY),
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_OTHER, -- Wards
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	local wards = {
		observers = {},
		sentries = {},
	}

	-- Only find the closest ward from each team of each type
	for _, unit in pairs(units) do
		if unit and not unit:IsNull() then
			local team = unit:GetTeamNumber()

			if unit:GetUnitName() == "npc_dota_observer_wards" then
				wards.observers[team] = wards.observers[team] or unit
			end

			if unit:GetUnitName() == "npc_dota_sentry_wards" then
				if (unit:GetAbsOrigin() - hero:GetAbsOrigin()):Length2D() < WARD_RANGE_SENTRY then
					wards.sentries[team] = wards.sentries[team] or unit
				end
			end
		end
	end

	return wards
end