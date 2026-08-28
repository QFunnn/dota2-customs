--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


-- status: complete

WebApi.before_match_delayed_retries = 50
WebApi.before_match_retry_delay = 1

WebApi.after_match_retries = 5
WebApi.after_match_retry_delay = 0.2

BEFORE_MATCH_STATE = {
	LOADING = 0,
	LOADED = 1,
	FAILED = 2,
}
WebApi.before_match_state = BEFORE_MATCH_STATE.LOADING

function WebApi:GetPlayersSteamIDs()
	local players = {}

	for player_id = 0, 23 do
		if PlayerResource:IsValidPlayerID(player_id) then
			table.insert(players, tostring(PlayerResource:GetSteamID(player_id)))
		end
	end

	return players
end

function WebApi:RequestBeforeMatch()
	local players = WebApi:GetPlayersSteamIDs()

	WebApi:Send("api/lua/match/before", {
		players = players,
		matchId = WebApi:GetMatchID(),
		region_required = true,
	}, function(data)
		print("BEFORE MATCH")
		DeepPrintTable(data)
		WebApi:_HandleBeforeMatchResponse(data)
		WebApi.before_match_state = BEFORE_MATCH_STATE.LOADED
	end, function(err)
		DebugMessage("[WebApi] before-match finished with errors: ", err.status_code or -1)
		local error_detail = type(err.detail) == "string" and err.detail or "Unknown Error"
		-- all retries have been exhausted (this is very bad!)
		-- or we're not on dedis and should not retry (as we won't reach regardless)
		if not IsDedicatedServer() or WebApi.before_match_delayed_retries <= 0 then
			DebugMessage("[WebApi] before-match retries exhausted")
			Timers:CreateTimer(30, function()
				DebugMessage(error_detail)
				DebugMessage("Match ID:", tostring(GameRules:Script_GetMatchID()))
			end)

			WebApi.before_match_state = BEFORE_MATCH_STATE.FAILED
			return
		end

		WebApi.before_match_delayed_retries = WebApi.before_match_delayed_retries - 1
		DebugMessage("[WebApi] retrying before-match, remaining tries: ", WebApi.before_match_delayed_retries)

		Timers:CreateTimer(WebApi.before_match_retry_delay, function()
			WebApi:RequestBeforeMatch()
		end)
	end)
end

function WebApi:_HandleBeforeMatchResponse(data)
	BattlePass:SetExtraData(data.battle_pass or {})

	for _, raw_player_data in pairs(data.players or {}) do
		local player_id = WebApi:GetPlayerIdBySteamId(raw_player_data.steamId)

		local player_data = WebApi:AdaptPlayerData(raw_player_data)
		DebugMessage("processed player data:", player_id, raw_player_data.steamId)
		DeepPrintTable(player_data)

		WebPlayer:SetPlayerData(player_id, player_data)
		BattlePass:SetPlayerData(player_id, player_data.battle_pass)
		WebMail:SetPlayerMails(player_id, player_data.mails)
		WebInventory:SetPlayerItems(player_id, player_data.items)
		Equipment:AssignEquippedItems(player_id, player_data.equipped_items)
		Tips:SetTipsData(player_id, player_data.tips_used)
		SmartRandom:SetPlayerInfo(player_id, player_data.smartRandomHeroes)
		WebPromoEvents:SetClaimsData(player_id, player_data.promo_event_claims or {})

		GiftCodes:SetPrefetched(player_id, player_data.gift_codes)

		SeasonReset:SetResetRewards(player_id, player_data.reset_data)

		WebPlayer:UpdateClient(player_id)
		GamePerks:ResetPerk(player_id)
	end

	SeasonReset:SetSeasonDetails(data.current_season, data.next_season_timestamp)
	WebPlayer:UpdatePlayersStats()

	if data.poorWinrates then
		CustomNetTables:SetTableValue("heroes_winrate", "heroes", data.poorWinrates)
		GameLoop.winrates = data.poorWinrates
	end

	if data.region then
		WebApi.current_server_region = data.region
	end

	-- SeasonalEvents:SetFirstWeekends(data.epic_weekend_dates or {})

	-- HostOptions:SetOptionAvailable(HOST_OPTION.TOURNAMENT, data.tournament_mode_state)

	DebugMessage("[WebAPI] before-match loaded successfully")
	WebApi.__before_match_loaded = true
end

function WebApi:AdaptPlayerData(raw_player_data)
	local t = {
		currency = raw_player_data.progress.glory or 0,
		subscription = {
			tier = raw_player_data.supporterState.level,
			end_date = raw_player_data.supporterState.endDate,
			metadata = raw_player_data.supporterState.metadata,
		},
		stats = raw_player_data.stats,
		battle_pass = raw_player_data.progress,
		settings = raw_player_data.settings,
		punishment_level = raw_player_data.punishment_level,
		mails = raw_player_data.mails,
		reset_data = raw_player_data.reset_data,
	}

	t.stats.streak_current = raw_player_data.streak.current
	t.stats.streak_max = raw_player_data.streak.best
	t.stats.streak_hidden = false

	t.items = {}

	for _, data in pairs(raw_player_data.inventory) do
		t.items[data.itemName] = {
			name = data.itemName,
			count = data.count,
		}
	end

	t.gift_codes = {}

	for _, data in pairs(raw_player_data.gift_codes) do
		t.gift_codes[data.code] = {
			code = data.code,
			product = data.paymentKind,
			is_redeemed = true,
			redeemer = data.redeemerSteamId,
		}
		if data.redeemerSteamId == "None" then
			t.gift_codes[data.code].redeemer = nil
			t.gift_codes[data.code].is_redeemed = false
		end
	end

	t.equipped_items = {}

	-- equipped_items
	for slot_name, content in pairs(raw_player_data.equipped_items or {}) do
		local slot_id = table.findkey(OLD_SLOT_NAMES, slot_name)
		print("Restoring equipped items:", slot_name, slot_id)
		if slot_id then
			t.equipped_items[slot_id] = content[1]
		end
	end

	return t
end

function WebApi:AfterMatch(winning_team)
	if not IsInToolsMode() then
		if GameRules:IsCheatMode() then
			return
		end
	end

	if winning_team < DOTA_TEAM_FIRST or winning_team > DOTA_TEAM_CUSTOM_MAX then
		DebugMessage("[WebApi] after-match discarded - incorrect winner team cond 1")
		return
	end
	if winning_team == DOTA_TEAM_NEUTRALS or winning_team == DOTA_TEAM_NOTEAM then
		DebugMessage("[WebApi] after-match discarded - incorrect winner team cond 2")
		return
	end

	local indexed_teams = {
		DOTA_TEAM_GOODGUYS,
		DOTA_TEAM_BADGUYS,
	}

	local wall_duration = (GetSystemTimeMS() - (GameLoop.game_start_time or 0)) / 1000
	local time_dilation = GameRules:GetDOTATime(false, true) / wall_duration

	DebugMessage("[WebApi] reported time dilation: ", time_dilation, wall_duration, GameRules:GetDOTATime(false, true))

	local request_body = {
		custom_game = WebApi.custom_game,
		match_id = IsInToolsMode() and RandomInt(1, 10000000) or tonumber(tostring(GameRules:Script_GetMatchID())),
		duration = math.floor(GameRules:GetDOTATime(false, true)),
		map_name = GetMapName(),
		winner = winning_team,

		time_dilation = time_dilation,
		region = WebApi.current_server_region or "<none>",

		teams = {},
		banned_heroes = GameRules:GetBannedHeroes() or {},
	}

	for _, team in pairs(indexed_teams) do
		local team_data = {
			players = {},
			team_id = team,
			place = winning_team == team and 1 or 2,
			weak_team = Shuffle.weak_team_id == team,
		}
		for n = 1, PlayerResource:GetPlayerCountForTeam(team) do
			local player_id = PlayerResource:GetNthPlayerIDOnTeam(team, n)
			if PlayerResource:IsValidTeamPlayerID(player_id) and not PlayerResource:IsFakeClient(player_id) then
				-- nullable to boolean
				local has_abandoned = GameMode:HasAbandoned(player_id)
				local endgame_stats = EndGameStats:GetStats(player_id)
				local bp_changes = endgame_stats.battle_pass or {}

				local mvp_type = MVPController:GetAftermatchMVPType(player_id)

				local player_data = {
					steam_id = tostring(PlayerResource:GetSteamID(player_id)),
					team = team,

					hero_name = PlayerResource:GetSelectedHeroName(player_id),
					kills = PlayerResource:GetKills(player_id),
					deaths = PlayerResource:GetDeaths(player_id),
					assists = PlayerResource:GetAssists(player_id),
					perk = GamePerks:GetSelectedPerkNameWithTier(player_id),
					-- todo: later
					kick_abused_count = 0, -- Votekick:GetReports(player_id),
					kick_started_count = 0, -- Votekick:GetInitVotings(player_id),
					kick_failed_count = 0, -- Votekick:GetFailedVotings(player_id),
					has_abandoned = has_abandoned,
					locale = WebLocale:GetPlayerLocale(player_id),

					rating_change = endgame_stats.rating_change,

					bp_level_change = bp_changes.bp_level_changes.new - bp_changes.bp_level_changes.old,
					bp_new_exp = bp_changes.bp_exp_changes.new.min,
					bp_exp_change = bp_changes.bp_exp_changes.earned,

					mvp_type = mvp_type,
					mvp_categories = table.make_key_table(MVPController:GetPlayerMVPCategories(player_id)),

					rewards = bp_changes.rewards or {},
					party_id = PartyColors.parties[player_id] or -1,
				}
				table.insert(team_data.players, player_data)
			end
		end
		table.insert(request_body.teams, team_data)
	end

	-- DebugMessage("[WebApi] built after-match payload:")
	-- DebugSendTableToClients(request_body)

	WebApi:CommitAfterMatch(request_body)
end

function WebApi:ForceEndGame(winner)
	local loser_team = winner == DOTA_TEAM_GOODGUYS and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS

	if GameLoop.ancients[loser_team] and IsValidEntity(GameLoop.ancients[loser_team]) then
		GameLoop.ancients[loser_team]:ForceKill(false)
		DebugMessage("[WebApi] ending the game by killing the ancient")
	else
		GameRules:SetGameWinner(winner)
		DebugMessage("[WebApi] ending the game by forcing game winner")
	end
end

function WebApi:CommitAfterMatch(request_body)
	DebugMessage("[WebApi] CommitAfterMatch starting")

	WebApi:Send("api/lua/match/v2/after", request_body, function(resp)
		DebugMessage("[WebApi] after-match submission succeeded")

		GameRules:SetGameWinner(request_body.winner)
	end, function(e)
		DebugMessage("[WebApi] after-match error", e.body, e.status_code)
		-- DebugSendTableToClients(e)

		if WebApi.after_match_retries <= 0 then
			DebugMessage("[WebApi] after-match error retries exhausted - forcing game end")
			WebApi.__after_match_failed = true
			GameRules:SetGameWinner(request_body.winner)
			return
		end

		WebApi.after_match_retries = WebApi.after_match_retries - 1

		DebugMessage("[WebApi] after-match failed, remaining tries:", WebApi.after_match_retries)

		Timers:CreateTimer(WebApi.after_match_retry_delay, function()
			WebApi:CommitAfterMatch(request_body)
		end)
	end)
end