--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SimulatedEndGame = SimulatedEndGame or {}


function SimulatedEndGame:Init()
	EventStream:Listen("EndScreen:check_state", SimulatedEndGame.SendStateEvent, SimulatedEndGame)
end


function SimulatedEndGame:SendStateEvent(event)
	if not GameLoop.game_over then return end

	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	SimulatedEndGame:SendState(player_id)
end


function SimulatedEndGame:CountConnectedPlayers()
	local connected_count = 0

	for player_id = 0, DOTA_MAX_PLAYERS do
		if IsValidPlayerID(player_id) and PlayerResource:IsBotOrPlayerConnected(player_id) then
			connected_count = connected_count + 1
		end
	end

	return connected_count
end


--- Get a list of errors that could influence match submission etc
--- generally something that should be displayed to players as a warning in endgame screen
function SimulatedEndGame:GetErrors()
	local errors = {}

	if not WebApi.__before_match_loaded then
		-- DebugMessage("[WebAPI] discarding game submission - before-match failed to load, cannot verify match validity")
		table.insert(errors, "#end_game_error_before_match_not_loaded")
	end

	if HostOptions:GetOption(HOST_OPTION.TOURNAMENT) then
		-- DebugMessage("[WebApi] discarding game submission - tournament mode")
		table.insert(errors, "#end_game_error_tournament_mode_active")
	end

	if END_GAME_PLAYER_COUNT_CHECK_ENABLED then
		local connected_players = SimulatedEndGame:CountConnectedPlayers()
		local required_players = GameLoop.current_layout.min_connected_players or 4

		if connected_players < required_players then
			table.insert(errors, "#end_game_error_not_enough_connected_players")
		end
	end

	if table.reduce(GameLoop.current_kills_count, function (acc, kill_count) return acc + kill_count end, 0) <= 0 then
		table.insert(errors, "#end_game_error_insufficient_kills")
	end

	return errors
end


function SimulatedEndGame:IsSubmissionAllowed()
	return #SimulatedEndGame:GetErrors() <= 0
end


function SimulatedEndGame:SendState(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local submission_errros = SimulatedEndGame:GetErrors()

	DeepPrintTable(submission_errros or {})

	CustomGameEventManager:Send_ServerToPlayer(player, "EndScreen:start", {
		players_stats = EndGameStats.stats,
		mvp = MVPController:GetMVPData(),
		sorted_teams = SimulatedEndGame.sorted_teams,
		orbs_collected = EndGameStats.orbs_collected,

		-- data local to player who requested them
		battle_pass = {}, -- for future BP season
		winner_team = self.winner_team,
		player_mvp_categories = MVPController:GetPlayerMVPCategories(player_id), -- categories that desired player is MVP in
		player_mvp_rewards = MVPController:GetMVPReward(MVPController:GetMVPType(player_id)),

		-- for hero challenges
		active_challenge = HeroChallenges.active_challenges[player_id] or {},
		challenges = HeroChallenges.challenges[player_id] or {},

		errors = submission_errros,
	})
end


function SimulatedEndGame:EndWithWinner(team_id)
	ErrorTracking.TryImmediate(SimulatedEndGame._EndWithWinner, SimulatedEndGame, team_id)
end


function SimulatedEndGame:_EndWithWinner(team_id)
	DebugMessage("[Simulated End Game] setting winner to team", team_id)

	self.winner_team = team_id
	local is_not_demo = GetMapName() ~= "ot3_demo"

	HeroChallenges:Update() -- since update usually runs on timer, ensure we aren't skipping progress when endgame happens
	SimulatedEndGame:PreparePlaces()
	EndGameStats:FinalizeStats()
	MVPController:FinalizeStats(self.winner_team)

	if is_not_demo then
		-- TODO: battlepass calculations when it's implemented
		WebApi:RequestAfterMatch(team_id, SimulatedEndGame.teams_places)
	end

	local entities = FindUnitsInRadius(
		team_id,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_ANY_ORDER,
		false
	)

	for _, entity in pairs(entities or {}) do
		if IsValidEntity(entity) and entity.AddNewModifier and entity.GetUnitName and entity:GetUnitName() ~= "npc_dota_thinker" then

			entity:AddNewModifier(entity, nil, "modifier_simulated_end_game", {duration = -1})
			entity:Stop()
			entity:InterruptMotionControllers(true)
			entity:InterruptChannel()
			entity:Interrupt()
			entity:Purge(true, true, false, true, true)

			ProjectileManager:ProjectileDodge(entity)
		end
	end

	DebugMessage("[Simulated End Game] accounted entities: ", #entities)

	for player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if IsValidEntity(hero) and IsValidPlayerID(player_id) then
			hero:StartGesture(team_id == PlayerResource:GetTeam(player_id) and ACT_DOTA_VICTORY or ACT_DOTA_DEFEAT)

			for _, team in pairs(GameLoop.current_layout.teamlist or {}) do
				hero:MakeVisibleToTeam(team, SIMULATED_END_GAME_DELAY)
			end

			SimulatedEndGame:SendState(player_id)
		end
	end

	local time = 0

	-- actually end the game after 10 minutes (safe guard) or if no players are connected
	self._final_timer = Timers:CreateTimer(1, function()
		time = time + 1

		local any_connected = false
		for player_id, _ in pairs(GameLoop.hero_by_player_id or {}) do
			if PlayerResource:GetConnectionState(player_id) == DOTA_CONNECTION_STATE_CONNECTED then any_connected = true end
		end

		if time >= SIMULATED_END_GAME_DELAY or not any_connected then
			DebugMessage("[Simulated End Game] ending the game", time, tonumber(any_connected))
			GameRules:SetGameWinner(team_id)
			return
		end

		return 1
	end)
end


function SimulatedEndGame:PreparePlaces()
	local sorted_teams = GameLoop:GetSortedTeams()

	SimulatedEndGame.sorted_teams = sorted_teams

	-- CustomNetTables:SetTableValue("game_state", "team_places", sorted_teams);

	local places = {}
	local place = 1

	for i, team_data in ipairs(sorted_teams or {}) do
		places[team_data.team] = place

		if place == 1 then
			place = place + 1
		else
			if i < #sorted_teams and sorted_teams[i + 1].score ~= team_data.score then
				place = place + 1
			end
		end
	end

	SimulatedEndGame.teams_places = places
end


function SimulatedEndGame:GetPlace(team_id)
	return SimulatedEndGame.teams_places[team_id] or -1
end



SimulatedEndGame:Init()