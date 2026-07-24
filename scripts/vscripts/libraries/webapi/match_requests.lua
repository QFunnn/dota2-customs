--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- status: complete

WebApi.before_match_delayed_retries = 50
WebApi.before_match_retry_delay = 1

local function retry_times(times)
	return function()
		times = times - 1
		return times > 0
	end
end


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

	WebApi:Send(
		"api/lua/match/before",
		{
			players = players,
			match_id = WebApi:GetMatchID(),
		},
		function(data)
			-- print("BEFORE MATCH")
			-- DeepPrintTable(data)
			WebApi:_HandleBeforeMatchResponse(data)
		end,
		function(err)
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
				return
			end

			WebApi.before_match_delayed_retries = WebApi.before_match_delayed_retries - 1
			DebugMessage("[WebApi] retrying before-match, remaining tries: ", WebApi.before_match_delayed_retries)

			Timers:CreateTimer(WebApi.before_match_retry_delay, function()
				WebApi:RequestBeforeMatch()
			end)
		end
	)
end


function WebApi:_HandleBeforeMatchResponse(data)
	HeroChallenges:PreparePoolFromWinrates(data.winrates or HeroChallenges.preset_winrates)

	BattlePass:SetExtraData(data.battle_pass or {})

	for steam_id, player_data in pairs(data.players or {}) do
		local player_id = WebApi:GetPlayerIdBySteamId(steam_id)

		WebPlayer:SetPlayerData(player_id, player_data)
		BattlePass:SetPlayerData(player_id, player_data.battle_pass)
		WebMail:SetPlayerMails(player_id, player_data.mails)
		WebInventory:SetPlayerItems(player_id, player_data.items)
		Equipment:AssignEquippedItems(player_id, player_data.equipped_items)
		Tips:SetTipsData(player_id, player_data.tips_used)
		SmartRandom:SetPlayerInfo(player_id, player_data.stats.last_winner_heroes)
		WebPromoEvents:SetClaimsData(player_id, player_data.promo_event_claims or {})

		HeroChallenges:ProcessPlayerChallenges(player_id, player_data.hero_challenges or {})

		SeasonReset:SetResetRewards(player_id, player_data.reset_data)

		WebPlayer:UpdateClient(player_id)
	end

	SeasonReset:SetSeasonDetails(data.rating_season, data.next_season_timestamp)
	WebPlayer:UpdatePlayersStats()

	SeasonalEvents:SetFirstWeekends(data.epic_weekend_dates or {})

	if GetMapName() ~= "ot3_demo" then
		HeroChallenges:SubmitChallengesToBackend()
	end

	HostOptions:SetOptionAvailable(HOST_OPTION.TOURNAMENT, data.tournament_mode_state)

	DebugMessage("[WebAPI] before-match loaded successfully")
	WebApi.__before_match_loaded = true
end


function WebApi:_GetPlayerPlaceOverride(player_id, original_place)
	-- abandoned players are always last place
	if PlayerResource:HasPlayerAbandoned(player_id) or PlayerDC.has_abandoned[player_id] then
		return table.count(GameLoop.current_layout.teamlist or {})
	end

	return original_place
end


function WebApi:RequestAfterMatch(winner_team, teams_places)
	if not IsInToolsMode() and (GameRules:IsCheatMode() or GameRules:GetDOTATime(false, true) < 60) then return end

	if winner_team < DOTA_TEAM_FIRST or winner_team > DOTA_TEAM_CUSTOM_MAX then return end
	if winner_team == DOTA_TEAM_NEUTRALS or winner_team == DOTA_TEAM_NOTEAM then return end

	if not SimulatedEndGame:IsSubmissionAllowed() then
		DebugMessage("[WebApi] discarded after-match - errors prevent submission", SimulatedEndGame:GetErrors())
		return
	end

	local players = {}

	for player_id = 0, DOTA_MAX_PLAYERS do
		if PlayerResource:IsValidPlayerID(player_id) and not PlayerResource:IsFakeClient(player_id) then
			local is_connected = PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED

			local endgame_stats = EndGameStats:GetStats(player_id)

			local team_id = PlayerResource:GetTeam(player_id)

			local base_place = teams_places[team_id] or -1
			local place = WebApi:_GetPlayerPlaceOverride(player_id, base_place)
			-- place was overriden - recalculate mmr
			print("[WebApi] base rating change for", player_id, endgame_stats.rating_change)
			if base_place ~= place then
				endgame_stats.rating_change = EndGameStats:GetRatingChange(player_id, place)
				DebugMessage("[WebApi] place override active for ", player_id, "recalculated mmr: ", endgame_stats.rating_change)
			end

			local bp_exp_new = BattlePass:GetNewExp(player_id)
			local bp_level_new = BattlePass:GetNewLevel(player_id)

			local steam_id = tostring(PlayerResource:GetSteamID(player_id))

			local raw_damage_taken = endgame_stats.damage_taken or PlayerResource:GetHeroDamageTaken(player_id, true)
			local processed_damage_taken = PlayerResource:GetHeroDamageTaken(player_id, true)

			local damage_reduced = 100.0 * (processed_damage_taken / math.max(raw_damage_taken, 1))

			local mvp_type = MVPController:GetAftermatchMVPType(player_id)

			local active_challenge = HeroChallenges.active_challenges[player_id]
			local completed_challenge_id

			local rewards = MVPController:GetMVPReward(mvp_type)

			DebugMessage(player_id, "mvp rewards", rewards)

			if active_challenge and active_challenge.completed and active_challenge.id > -1 and is_connected then
				completed_challenge_id = active_challenge.id

				rewards = table.combine(rewards or {}, active_challenge.rewards or {})
				DebugMessage(player_id, "with challenge rewards:", rewards)
			end

			local hero = GameLoop.hero_by_player_id[player_id]

			table.insert(players, {
				steam_id = steam_id,
				team_id = team_id,

				hero_name = PlayerResource:GetSelectedHeroName(player_id),

				kills = PlayerResource:GetKills(player_id),
				deaths = PlayerResource:GetDeaths(player_id),
				assists = PlayerResource:GetAssists(player_id),

				networth = endgame_stats.networth or 0,
				damage_dealt = math.floor(endgame_stats.hero_damage or 0),
				damage_taken = math.floor(raw_damage_taken),
				damage_reduced = damage_reduced,
				healing = math.floor(PlayerResource:GetHealing(player_id)),
				stun_duration_total = math.floor(PlayerResource:GetStuns(player_id)),

				rating_change = endgame_stats.rating_change,
				bp_exp_new = bp_exp_new,
				bp_level_new = bp_level_new,
				place = place,

				mvp_type = mvp_type,
				mvp_categories = table.make_key_table(MVPController:GetPlayerMVPCategories(player_id)),

				completed_challenge_id = completed_challenge_id or nil,

				-- rewards represent combined goods given to a player as a result of the match
				-- currently MVP and hero challenges contribute to this, with some more possibly later
				rewards = rewards,

				locale = WebLocale:GetPlayerLocale(player_id),

				upgrades = Upgrades:GetPlayerUpgrades(player_id),

				facet_id = 0,
				party_id = PartyColors.parties[player_id] or -1,
				used_rerolls_count = UpgradeRerolls.used_rerolls[player_id] or 0,
				capture_time_total = endgame_stats.capture_orbs_time or 0,
			})

			-- add supposed rewards locally
			WebApi:ProcessMetadata(player_id, WebApi:BuildMetadataFromReward(player_id, rewards))
		end
	end

	if not IsInToolsMode() and #players < 5 then return end

	local wall_duration = (GetSystemTimeMS() - (GameLoop.game_start_time or 0)) / 1000
	local time_dilation = GameRules:GetDOTATime(false, true) / wall_duration
	DebugMessage("[After-match] time dilation:", time_dilation)

	WebApi:Send(
		"api/lua/match/after",
		{
			-- map_name \
			-- match_id | - included in webapi Send automatically
			duration = math.floor(GameRules:GetGameTime()),
			winner_team_id = winner_team,
			banned_heroes = GameRules:GetBannedHeroes(),
			players = players,
			time_dilation = time_dilation,
		},
		function(data)
			WebApi:_HandleAfterMatchResponse(data)
		end,
		function(error)
			DebugMessage("[WebApi] error in after-match: ", error)
			DeepPrintTable(error)
		end
	)
end


function WebApi:_HandleAfterMatchResponse(data)
	print("[WebApi] after-match succeeded")
end