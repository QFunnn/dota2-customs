--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


EndGameStats = EndGameStats or {}

-- single damage instance above 150000 is probably a bug and should be discarded
UNREASONABLE_DAMAGE_THRESHOLD = 150000
-- MMR calcs
RATING_CHANGE_CAP = 15
RATING_MULTIPLIER = 0.025
BASE_CHANGE = { 30, -30 }

END_GAME_PLAYER_COUNT_CHECK_ENABLED = true

function EndGameStats:Init()
	---@type table<number, table>
	EndGameStats.stats = EndGameStats.stats or {}
	---@type table<number, table> @ used to debounce stack event, which we track from stack modifier applied to every creep of the camp
	EndGameStats._camp_stack_frames = {}

	EndGameStats.calculated_bp_changes = {}

	for player_id = -1, 24 do
		if not EndGameStats.stats[player_id] then
			-- CUSTOM_GAME_STATS
			EndGameStats.stats[player_id] = {
				perk_info = {
					base_perk = "",
					perk_name = "",
				},
				networth = 0,
				experience = 0,
				hero_damage = 0,
				damage_taken = 0,
				summon_damage = 0,
				wards = {
					npc_dota_observer_wards = 0,
					npc_dota_sentry_wards = 0,
				},
				wards_killed = {
					npc_dota_observer_wards = 0,
					npc_dota_sentry_wards = 0,
				},
				killed_heroes = {},
				total_healing = 0,
				stun_time = 0,
				gpm = 0,
				xpm = 0,
				building_damage = 0,
				neutral_camps_stacked = 0,

				current_rating = 1500,
				rating_change = 0,

				battle_pass = {
					-- level change
					-- xp change
					-- rewards (per level)
				},

				player_mvp_categories = {}, -- MVPController:GetPlayerMVPCategories(player_id), -- categories that desired player is MVP in
				player_mvp_rewards = {}, -- MVPController:GetMVPReward(MVPController:GetMVPType(player_id)),
			}
		end
	end

	EventDriver:Listen("EventProxy:OnModifierAdded", EndGameStats.OnModifierAdded, EndGameStats)
	EventDriver:Listen("Events:entity_killed", EndGameStats.OnEntityKilled, EndGameStats)
end

function EndGameStats:OnEntityKilled(event)
	local killed = event.killed
	if not IsValidEntity(killed) or not killed.GetUnitName then
		return
	end

	local killer = event.killer
	if not IsValidEntity(killer) or not killer.GetPlayerOwnerID then
		return
	end

	-- Don't count stats for denies
	if killer:GetTeamNumber() == killed:GetTeamNumber() then
		return
	end

	local killer_player_id = killer:GetPlayerOwnerID()
	local killed_name = killed:GetUnitName()

	if killer_player_id > -1 then
		if killed_name == "npc_dota_sentry_wards" or killed_name == "npc_dota_observer_wards" then
			EndGameStats:Add_KilledWards(killer_player_id, killed_name)
			return
		end

		EndGameStats:Add_KilledHero(killer_player_id, killed)
	end
end

--- Returns average rating for a given team
---@param team number
function EndGameStats:GetTeamAverageRating(team)
	local total = 0
	local count = 0

	for player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if PlayerResource:GetTeam(player_id) == team then
			total = total + WebPlayer:GetRating(player_id)
			count = count + 1
		end
	end

	if count > 0 then
		return total / count
	end

	return 1500
end

function EndGameStats:GetRatingChange(player_id, winning_team)
	-- MMR is calculated as +-30 + (opponent team avg mmr - player team avg mmr) * 0.025
	-- with change clamped between -15 : 15

	-- Chinese New Year event shouldn't change rating
	-- if SeasonalEvents:IsChineseNewYear() then
	-- 	return 0
	-- end

	local team_id = PlayerResource:GetTeam(player_id)
	local opposing_team = team_id == DOTA_TEAM_GOODGUYS and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS

	local base_change = team_id == winning_team and 30 or -30
	local other_team_average_rating = EndGameStats:GetTeamAverageRating(opposing_team)
	local current_rating = EndGameStats:GetTeamAverageRating(team_id)

	local score_delta = math.floor((other_team_average_rating - current_rating) * RATING_MULTIPLIER + 0.5)
	print("calculating rating change for", player_id, team_id, score_delta, other_team_average_rating, current_rating)
	print("result:", base_change + math.clamp(score_delta, -RATING_CHANGE_CAP, RATING_CHANGE_CAP))

	local rating_change = base_change + math.clamp(score_delta, -RATING_CHANGE_CAP, RATING_CHANGE_CAP)

	DebugMessage(
		"[EndGameStats] rating change for",
		player_id,
		rating_change,
		current_rating,
		other_team_average_rating
	)

	if EarlyConsumables:HavePlayerUsedDoubleMMRToken(player_id) then
		rating_change = rating_change * 2
	end

	return rating_change
end

function EndGameStats:FinalizeStats(winning_team)
	DebugMessage("EndGameStats:FinalizeStats starting")

	MVPController:FinalizeStats(winning_team)
	CustomNetTables:SetTableValue("custom_stats", "mvp", MVPController._results)
	CustomNetTables:SetTableValue("custom_stats", "errors", EndGameStats:GetSubmissionErrors())

	for player_id = 0, 23 do
		if PlayerResource:IsValidPlayer(player_id) then
			EndGameStats:Update_Perk(player_id)

			EndGameStats:Update_Networth(player_id)
			EndGameStats:Update_Heal(player_id)
			EndGameStats:Update_Stuns(player_id)
			EndGameStats:Update_XPM(player_id)
			EndGameStats:Update_GPM(player_id)
			EndGameStats:UpdateDamageTaken(player_id)
			EndGameStats:UpdateMMRChange(player_id, winning_team)
			EndGameStats:CalculateBPChangesForPlayer(player_id, winning_team)

			EndGameStats:Update_MVP(player_id)

			CustomNetTables:SetTableValue("custom_stats", tostring(player_id), EndGameStats:GetStats(player_id))
		end
	end

	DebugMessage("EndGameStats:FinalizeStats done!")
end

function EndGameStats:Add_DamageTaken(player_id, damage)
	if not damage then
		return
	end
	EndGameStats.stats[player_id].damage_taken = EndGameStats.stats[player_id].damage_taken + damage
end

function EndGameStats:Add_HeroDamage(player_id, damage, is_summon_damage)
	if not damage then
		return
	end
	EndGameStats.stats[player_id].hero_damage = EndGameStats.stats[player_id].hero_damage + damage

	if is_summon_damage then
		EndGameStats.stats[player_id].summon_damage = (EndGameStats.stats[player_id].summon_damage or 0) + damage
	end
end

function EndGameStats:Add_KilledHero(player_id, hero)
	if not hero:IsHero() then
		return
	end

	local team = hero:GetTeam()
	EndGameStats.stats[player_id].killed_heroes[team] = EndGameStats.stats[player_id].killed_heroes[team] or {}

	local hero_name = hero:GetUnitName()
	EndGameStats.stats[player_id].killed_heroes[team][hero_name] = (
		EndGameStats.stats[player_id].killed_heroes[team][hero_name] or 0
	) + 1
end

function EndGameStats:Add_PlacedWard(player_id, ward_name)
	EndGameStats.stats[player_id].wards[ward_name] = EndGameStats.stats[player_id].wards[ward_name] + 1
end

function EndGameStats:Add_KilledWards(player_id, ward_name)
	EndGameStats.stats[player_id].wards_killed[ward_name] = EndGameStats.stats[player_id].wards_killed[ward_name] + 1
end

-- unused
function EndGameStats:Add_Heal(player_id, value)
	EndGameStats.stats[player_id].total_healing = (EndGameStats.stats[player_id].total_healing or 0) + value
end

function EndGameStats:Add_BuildingDamage(player_id, damage_value)
	EndGameStats.stats[player_id].building_damage = (EndGameStats.stats[player_id].building_damage or 0) + damage_value
end

function EndGameStats:Update_Networth(player_id)
	if not PlayerResource:IsValidPlayerID(player_id) then
		return
	end
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if not hero then
		return
	end

	EndGameStats.stats[player_id].networth = PlayerResource:GetNetWorth(player_id)
end

--- deprecated
function EndGameStats:Update_Heal(player_id)
	-- print(string.format("[EndGameStats] healing for %d - expected [%d], tracked [%d]", player_id, PlayerResource:GetHealing(player_id), EndGameStats.stats[player_id].total_healing))
	EndGameStats.stats[player_id].total_healing = PlayerResource:GetHealing(player_id)
end

function EndGameStats:Update_Stuns(player_id)
	EndGameStats.stats[player_id].total_stuns = PlayerResource:GetStuns(player_id)
end

function EndGameStats:Update_XPM(player_id)
	EndGameStats.stats[player_id].xpm = PlayerResource:GetXPPerMin(player_id) -- EndGameStats.stats[player_id].experience / GameRules:GetGameTime() * 60
end

function EndGameStats:Update_GPM(player_id)
	EndGameStats.stats[player_id].gpm = PlayerResource:GetGoldPerMin(player_id)
end

function EndGameStats:UpdateDamageTaken(player_id)
	-- in case something goes wrong and damage taken for player is corrupted - use intrinsic valve-collected value
	if not EndGameStats.stats[player_id].damage_taken or EndGameStats.stats[player_id].damage_taken == 0 then
		print("[EndGameStats] WARNING: corrupted damage taken found, falling back to built-in tracking - " .. player_id)
		DeepPrintTable(EndGameStats.stats[player_id] or {})
		EndGameStats.stats[player_id].damage_taken = PlayerResource:GetHeroDamageTaken(player_id, true)
	end
end

function EndGameStats:Update_Perk(player_id)
	local perk_info = GamePerks:CollectDataForClient(player_id)
	if not perk_info then
		return
	end

	EndGameStats.stats[player_id].perk_info = {
		base_perk = perk_info.base_perk,
		perk_name = perk_info.perk_name,
	}
end

function EndGameStats:UpdateMMRChange(player_id, winning_team)
	EndGameStats.stats[player_id].current_rating = WebPlayer:GetRating(player_id)
	EndGameStats.stats[player_id].rating_change = EndGameStats:GetRatingChange(player_id, winning_team)
end

function EndGameStats:CalculateBPChangesForPlayer(player_id, winning_team)
	if EndGameStats.calculated_bp_changes[player_id] then
		return
	end

	if not IsInToolsMode() and not EndGameStats:IsSubmissionAllowed() then
		return
	end

	local stats = EndGameStats.stats[player_id] or {}
	stats.battle_pass = stats.battle_pass or {}

	DebugMessage("BP CALCS FOR PLAYER", player_id)

	local team_id = PlayerResource:GetTeam(player_id)

	local current_level = BattlePass:GetCurrentLevel(player_id)
	local current_exp = BattlePass:GetCurrentExp(player_id)
	local earned_exp_today = BattlePass:GetEarnedExp(player_id)
	local current_required_exp = BattlePass:GetRequiredExp(player_id)
	local daily_limit = BattlePass:GetDailyExpLimit(player_id)

	print(
		"calculating BP changes, current:",
		current_level,
		current_exp,
		earned_exp_today,
		current_required_exp,
		daily_limit
	)

	local added_exp = team_id == winning_team and BP_EXP_WIN or BP_EXP_DEFEAT

	DebugMessage(player_id, "added exp from place", added_exp)

	-- clamp by daily limit
	if (added_exp + earned_exp_today) > daily_limit then
		added_exp = max(daily_limit - earned_exp_today, 0)
	end

	DebugMessage(player_id, "clamped to limit:", added_exp, "; previously earned: ", earned_exp_today, "/", daily_limit)

	-- abandoned / afk players get no BP exp
	-- if GameMode:HasAbandoned(player_id) or GameMode:HasBeenAFK(player_id) then
	if GameMode:HasAbandoned(player_id) then
		print(
			"[EndGameStats] player ",
			player_id,
			"has been punished and won't receive any exp: ",
			GameMode:HasAbandoned(player_id)
		)
		added_exp = 0
	end

	BattlePass:AddEarnedExp(player_id, added_exp)

	local new_exp = current_exp + added_exp

	stats.battle_pass.rewards = BattlePass:SetCurrentExpFromValue(player_id, new_exp)

	stats.battle_pass.bp_level_changes = {
		old = current_level,
		new = BattlePass:GetCurrentLevel(player_id),
	}

	stats.battle_pass.bp_exp_changes = {
		earned = added_exp,
		limits = {
			current = earned_exp_today + added_exp,
			max = daily_limit,
		},
		old = {
			min = current_exp,
			max = current_required_exp,
		},
		new = {
			min = BattlePass:GetCurrentExp(player_id),
			max = BattlePass:GetRequiredExp(player_id),
		},
	}

	print("changes")
	DeepPrintTable(stats.battle_pass)

	EndGameStats.calculated_bp_changes[player_id] = true
end

function EndGameStats:Update_MVP(player_id)
	EndGameStats.stats[player_id].player_mvp_categories = MVPController:GetPlayerMVPCategories(player_id)
	EndGameStats.stats[player_id].player_mvp_rewards = MVPController:GetMVPReward(MVPController:GetMVPType(player_id))
end

function EndGameStats:OnModifierAdded(event)
	local modifier = event.added_buff
	if modifier:GetName() ~= "modifier_stacked_neutral" then
		return
	end

	local applied_by = modifier:GetCaster()
	if not IsValidEntity(applied_by) then
		print("stack modifier applied by invalid entity")
		return
	end

	local owner_player_id = applied_by:GetPlayerOwnerID()
	if not IsValidPlayerID(owner_player_id) then
		return
	end

	local spawner_name = event.unit:GetNeutralSpawnerName()
	local frames = GetFrameCount()

	if EndGameStats._camp_stack_frames[spawner_name] == frames then
		return
	end
	EndGameStats._camp_stack_frames[spawner_name] = frames

	print("[EndGameStats] registered stacked neutral camp:", owner_player_id, spawner_name, frames)
	EndGameStats.stats[owner_player_id].neutral_camps_stacked = (
		EndGameStats.stats[owner_player_id].neutral_camps_stacked or 0
	) + 1
end

function EndGameStats:GetStats(player_id)
	return EndGameStats.stats[player_id] or {}
end

function EndGameStats:CountConnectedPlayers()
	local connected_count = 0

	for player_id = 0, DOTA_MAX_PLAYERS do
		if
			IsValidPlayerID(player_id)
			and PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED
		then
			connected_count = connected_count + 1
		end
	end

	return connected_count
end

function EndGameStats:GetSubmissionErrors()
	local errors = {}

	if not WebApi.__before_match_loaded then
		DebugMessage("[WebAPI] discarding game submission - before-match failed to load, cannot verify match validity")
		table.insert(errors, "#end_game_error_before_match_not_loaded")
	end

	if GameMode:IsTournamentMode() then
		DebugMessage("[WebApi] discarding game submission - tournament mode")
		table.insert(errors, "#end_game_error_tournament_mode_active")
	end

	if GameRules:GetDOTATime(false, true) < 15 * 60 then
		DebugMessage("[WebApi] discarding game submission - shorter than 15m")
		table.insert(errors, "#end_game_error_duration_too_short")
	end

	if END_GAME_PLAYER_COUNT_CHECK_ENABLED then
		local connected_players = EndGameStats:CountConnectedPlayers()
		DebugMessage("[WebApi] connected players count:", connected_players)

		if connected_players < 5 then
			table.insert(errors, "#end_game_error_not_enough_connected_players")
		end
	end

	if WebApi.__after_match_failed then
		DebugMessage("[WebAPI] discarding game submission - after-match failed")
		table.insert(errors, "#end_game_error_after_match_failed")
	end

	if IsInToolsMode() then
		table.insert(errors, "#end_game_error_tools_checks_skipped")
	end

	return errors
end

function EndGameStats:IsSubmissionAllowed()
	if IsInToolsMode() then
		return true
	end

	return #EndGameStats:GetSubmissionErrors() <= 0
end

EndGameStats:Init()