--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


require("anti_feed/anti_feed_declarations")

AntiFeed = AntiFeed or class({})

function AntiFeed:Init()
	AntiFeed.points = {}
	AntiFeed.time_factor = {}
	AntiFeed.time_after_respawn = {}
	AntiFeed.feeders = {}
	AntiFeed.cached_stats = {}
	AntiFeed.cached_units = {}

	for player_id = 0, 23 do
		AntiFeed.points[player_id] = AF_POINTS_INIT
		AntiFeed.time_factor[player_id] = AF_TIME_FACTOR_INIT
		AntiFeed.time_after_respawn[player_id] = AF_TIME_FACTOR_DELAY
		AntiFeed.feeders[player_id] = false
		AntiFeed.cached_stats[player_id] = {
			kills = 0,
			assists = 0,
			building_damage = 0,
		}
		AntiFeed.cached_units[player_id] = {}
	end

	AntiFeed:StartTimer()

	ListenToGameEvent("npc_spawned", Dynamic_Wrap(AntiFeed, "OnNPCSpawned"), AntiFeed)
	EventDriver:Listen("Events:entity_killed", AntiFeed.OnEntityKilled, AntiFeed)
end

function AntiFeed:OnNPCSpawned(event)
	local unit = EntIndexToHScript(event.entindex)
	if not IsValidEntity(unit) then
		return
	end

	local player_id = unit:GetPlayerOwnerID()

	AntiFeed:UpdateModifierOnSpawn(player_id, unit)

	local selected_hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if unit ~= selected_hero then
		return
	end

	AntiFeed.time_after_respawn[player_id] = 0
end

function AntiFeed:UpdateModifierOnSpawn(player_id, unit)
	if not AntiFeed:IsFeeder(player_id) then
		unit:RemoveModifierByName("modifier_anti_feed_detected")
		return
	end

	unit:AddNewModifier(unit, nil, "modifier_anti_feed_detected", {
		duration = -1,
		respawn_time_inc = (AntiFeed.points[player_id] or 0) * AF_FEEDER_RESPAWN_TIME_MULTIPLIER_BY_POINTS,
	})

	table.insert(AntiFeed.cached_units[player_id], unit)
end

function AntiFeed:OnEntityKilled(event)
	local killer = event.killer
	local killed = event.killed

	if not IsValidEntity(killer) then
		return
	end
	if not IsValidEntity(killed) or not killed:IsRealHero() or killed:IsReincarnating() then
		return
	end
	if killed:GetClassname() == "npc_dota_lone_druid_bear" then
		return
	end
	if killer:GetTeamNumber() == DOTA_TEAM_NEUTRALS then
		return
	end
	if killer == killed then
		return
	end

	AntiFeed:ProcessKillerTeam(killer:GetTeam())

	if AntiFeed:IsSafeZone(killed, killed:GetOrigin()) then
		return
	end

	AntiFeed:ProcessKilled(killed:GetPlayerOwnerID())
end

function AntiFeed:ProcessKilled(player_id)
	AntiFeed:IncreasePointsOnDeath(player_id)

	AntiFeed.time_factor[player_id] = AF_TIME_FACTOR_INIT
	AntiFeed.time_after_respawn[player_id] = 0
end

function AntiFeed:ProcessKillerTeam(team)
	for player_id, stats in pairs(AntiFeed.cached_stats) do
		local player_team = PlayerResource:GetTeam(player_id)
		if player_team == team then
			local new_kills = PlayerResource:GetKills(player_id)
			local new_assists = PlayerResource:GetAssists(player_id)

			if stats.kills ~= new_kills then
				-- DebugMessage("[AntiFeed] REDUCE ON KILL for [" .. player_id .. "]")
				AntiFeed:DecreasePoints(player_id, AF_POINTS_ON_KILL)
				AntiFeed.cached_stats[player_id].kills = new_kills
			end
			if stats.assists ~= new_assists then
				-- DebugMessage("[AntiFeed] REDUCE ON ASSIST for [" .. player_id .. "]")
				AntiFeed:DecreasePoints(player_id, AF_POINTS_ON_ASSIST)
				AntiFeed.cached_stats[player_id].assists = new_assists
			end
		end
	end
end

function AntiFeed:IsFeeder(player_id)
	return AntiFeed.feeders[player_id]
end

function AntiFeed:IncreasePointsOnDeath(player_id)
	local new_value = AntiFeed.points[player_id] + AF_POINTS_ON_DEATH_CONST + AntiFeed.time_factor[player_id]

	local ally_team = PlayerResource:GetTeam(player_id)
	local enemy_team = ally_team == DOTA_TEAM_GOODGUYS and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS

	if ally_team and enemy_team then
		local team_score_impact = 0

		local ally_deaths = PlayerResource:GetTeamKills(enemy_team) or 0
		local enemy_deaths = PlayerResource:GetTeamKills(ally_team) or 0

		if ally_deaths <= AF_ALLY_DEATH_IMPACT_MIN_DEATHS_THRESHOLD then
			ally_deaths = 0
		end

		team_score_impact = (ally_deaths + AF_ALLY_DEATH_IMPACT_CONST) / math.max(enemy_deaths, 1)
		team_score_impact = math.floor(team_score_impact)

		new_value = new_value - team_score_impact
	end

	AntiFeed.points[player_id] = math.min(new_value, AF_POINTS_MAX)

	AntiFeed:ProcessPoints(player_id)
end

function AntiFeed:DecreasePoints(player_id, value)
	local new_value = AntiFeed.points[player_id] + value
	AntiFeed.points[player_id] = math.max(new_value, AF_POINTS_MIN)

	-- DebugMessage("[AntiFeed] decrease [" .. player_id .. "] > ", AntiFeed.points[player_id])

	AntiFeed:ProcessPoints(player_id)
end

function AntiFeed:CleanModifiers(player_id)
	for _, unit in pairs(AntiFeed.cached_units[player_id]) do
		if IsValidEntity(unit) and unit:IsAlive() and unit:HasModifier("modifier_anti_feed_detected") then
			unit:RemoveModifierByName("modifier_anti_feed_detected")
		end
	end
	AntiFeed.cached_units[player_id] = {}
end

function AntiFeed:ProcessPoints(player_id)
	local points = AntiFeed.points[player_id]

	if points >= AF_POINTS_MAX then
		-- DebugMessage("[AntiFeed] DETECT FEEDER [" .. player_id .. "]")
		AntiFeed.feeders[player_id] = true
		GameRules:SendCustomMessage("#anti_feed_system_add_debuff_message", player_id, 0)
	end

	if AntiFeed.feeders[player_id] and points <= AF_FEEDER_POINT_TO_FREE then
		-- DebugMessage("[AntiFeed] NO FEEDER NOW [" .. player_id .. "]")
		AntiFeed.feeders[player_id] = false
		AntiFeed:CleanModifiers(player_id)
	end
end

function AntiFeed:StartTimer()
	Timers:CreateTimer(0, function()
		if GameRules:State_Get() < DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
			return 1
		end

		for player_id, time in pairs(AntiFeed.time_after_respawn) do
			if time > -1 then
				AntiFeed.time_after_respawn[player_id] = time + 1
			end
			if time > AF_TIME_FACTOR_DELAY then
				AntiFeed.time_factor[player_id] =
					math.max(AntiFeed.time_factor[player_id] + AF_TIME_FACTOR_DRAIN, AF_TIME_FACTOR_MIN)
			end
			if AntiFeed.time_factor[player_id] <= AF_TIME_FACTOR_MIN then
				AntiFeed.time_after_respawn[player_id] = -1
			end

			local hero = GameLoop.hero_by_player_id[player_id]

			if AntiFeed.feeders[player_id] and IsValidEntity(hero) and hero:IsAlive() then
				AntiFeed:DecreasePoints(player_id, AF_FEEDER_ALIVE_DRAIN)
			end
		end
		return 1
	end)
end

function AntiFeed:IsSafeZone(unit, pos)
	if not pos then
		return false
	end

	local team = unit:GetTeamNumber()
	local fountains = Entities:FindAllByClassname("ent_dota_fountain")
	local ally_fountain_position

	for _, fountain in pairs(fountains) do
		if fountain:GetTeamNumber() == team then
			ally_fountain_position = fountain:GetAbsOrigin()
		end
	end

	return ((ally_fountain_position - pos):Length2D()) <= AF_ALLY_FOUNTAIN_SAFE_ZONE
end

function AntiFeed:IsForbiddenItemForFeeder(item_name, player_id)
	return AF_FORBIDDEN_ITEMS_TO_BUY[item_name] and AntiFeed:IsFeeder(player_id)
end

function AntiFeed:ProcessBuildingDamage(player_id, damage)
	local stats = AntiFeed.cached_stats[player_id]
	if not stats then
		return
	end

	stats.building_damage = stats.building_damage + damage

	if stats.building_damage >= AF_BUILDING_DAMAGE_THRESHOLD then
		-- DebugMessage("[AntiFeed] REDUCE ON BULDING DAMAGE for [" .. player_id .. "]")
		stats.building_damage = stats.building_damage - AF_BUILDING_DAMAGE_THRESHOLD
		AntiFeed:DecreasePoints(player_id, AF_POINTS_ON_BUILDING_DAMAGE)
	end
end