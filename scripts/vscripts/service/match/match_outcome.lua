--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class MatchLifecycleService
MatchLifecycleService = MatchLifecycleService or {}

---@param match Match
---@param teamNumber integer
---@param place integer
local function PushPlayerPlaceRating(match, teamNumber, place)
	for _, playerId in ipairs(match:GetTeam(teamNumber):GetPlayers()) do
		match:AssignPlayerPlace(playerId, place)
		local steamId = GetSteamID(playerId)
		MatchOutboundApi:UpdateMatchPlayerRating(GameMode:GetMatchID(), {
			uid = steamId,
			place = place,
			matchTypeCode = GameMode:GetMatchType(),
		}, function(res)
			if res and res.Body then
				local resBody = json.decode(res.Body)
				local newRating = resBody.rating
				local playerRatingTable = CustomNetTables:GetTableValue("service", "player_rank")
				playerRatingTable[steamId].newScore = newRating
				CustomNetTables:SetTableValue("service", "player_rank", playerRatingTable)
			end
		end)
	end
end

---@param match Match
---@param teamNumber integer
local function FinishSoloPveWin(match, teamNumber)
	logger:Log(
		string.format(
			"EndPve: teamNumber=%d validTeamNumber=%d place=%d",
			teamNumber,
			match:GetValidTeamNumber() or -1,
			match:GetPlace() or -1
		)
	)
	if GameMode:GetMatchType() == MATCH_TYPE_SOLO then
		local playerId = match:GetTeam(teamNumber):GetPlayers()[1]
		if not DevUtils:Check() then
			MatchLifecycleService:EndPve(playerId)
		else
			Notifications:BottomToAll({
				text = "#cheat_no_record",
				duration = 4,
				style = {
					color = "Red",
				},
			})
			MatchLifecycleService:EndPve(playerId)
		end
	end
end

---@param match Match
---@param teamNumber integer
local function EliminateTeamAndContinue(match, teamNumber)
	local place = match:GetPlace()
	logger:Log(
		string.format(
			"EndPvpAndContinue: teamNumber=%d validTeamNumber=%d place=%d",
			teamNumber,
			match:GetValidTeamNumber() or -1,
			place or -1
		)
	)
	for _, playerId in ipairs(match:GetTeam(teamNumber):GetPlayers()) do
		match:AssignPlayerPlace(playerId, place)
		local steamId = GetSteamID(playerId)
		MatchOutboundApi:UpdateMatchPlayerRating(tostring(GameMode:GetMatchID()), {
			uid = steamId,
			place = place,
			matchTypeCode = GameMode:GetMatchType(),
		}, function(res)
			local data = {
				game_rank = place,
				valid_team = match:GetValidTeamNumber(),
			}
			if res and res.Body then
				local resBody = json.decode(res.Body)
				local playerRankTable = CustomNetTables:GetTableValue("service", "player_rank")
				data.score = resBody.rating
				data.originScore = playerRankTable[steamId].score
				playerRankTable[steamId].newScore = resBody.rating
				CustomNetTables:SetTableValue("service", "player_rank", playerRankTable)
			end
			local player = PlayerResource:GetPlayer(playerId)
			if player then
				CustomGameEventManager:Send_ServerToPlayer(player, "ShowPlayerLose", data)
			end
		end)
	end
	match:AssignTeamPlace(place, teamNumber)
	CustomNetTables:SetTableValue("team_rank", tostring(teamNumber), {
		rank = place,
		defeat_round = match:GetCurrentRound() and match:GetCurrentRound().roundNumber or 1,
	})
	match:SetPlace(place - 1)
end

---@param match Match
---@param teamNumber integer
local function FinalizePvp(match, teamNumber)
	logger:Log(
		string.format(
			"EndPvp: teamNumber=%d validTeamNumber=%d place=%d",
			teamNumber,
			match:GetValidTeamNumber() or -1,
			match:GetPlace() or -1
		)
	)
	local winnerTeam = -1
	for teamId, team in pairs(match:GetTeams()) do
		if team:IsAlive() then
			winnerTeam = teamId
		end
	end
	match:AssignTeamPlace(2, teamNumber)
	CustomNetTables:SetTableValue("team_rank", tostring(teamNumber), {
		rank = 2,
		defeat_round = match:GetCurrentRound() and match:GetCurrentRound().roundNumber or 1,
	})
	match:AssignTeamPlace(1, winnerTeam)
	CustomNetTables:SetTableValue("team_rank", tostring(winnerTeam), {
		rank = 1,
		defeat_round = match:GetCurrentRound() and match:GetCurrentRound().roundNumber or 1,
	})
	if not DevUtils:Check() then
		PushPlayerPlaceRating(match, winnerTeam, 1)
		PushPlayerPlaceRating(match, teamNumber, 2)
		MatchLifecycleService:EndRank()
	end
	match:SetPlace(match:GetPlace() - 1)
end

---Помечает команду как проигравшую
---@param teamNumber integer
function MatchLifecycleService:TeamLose(teamNumber)
	local match = GameMode:GetMatch()
	logger:Log(
		string.format(
			"TeamLose: teamNumber=%d validTeamNumber=%d place=%d",
			teamNumber,
			match:GetValidTeamNumber() or -1,
			match:GetPlace() or -1
		)
	)
	match:GetTeam(teamNumber):SetAlive(false)
	local payLoadFireBullet = {
		type = "team_lose",
		nTeamNumber = teamNumber,
	}
	Barrage:FireBullet(payLoadFireBullet)
	for _, playerId in ipairs(match:GetTeam(teamNumber):GetPlayers()) do
		local hero = PlayerResource:GetSelectedHeroEntity(playerId)
		if hero then
			hero:SetGold(0, true)
		end
	end

	local currentRound = match:GetCurrentRound()
	if currentRound and currentRound.spawners and currentRound.spawners[teamNumber] then
		currentRound.spawners[teamNumber].isForceStop = true
		local units = GetCreepsByTeamNumber(teamNumber)
		for _, creep in ipairs(units) do
			if creep and not creep:IsNull() and creep:IsAlive() then
				creep:ForceKill(false)
			end
		end
	end

	PvpMatchmaker:RemovePairsForTeam(teamNumber)

	if match:GetValidTeamNumber() == 1 and match:GetPlace() == 1 then
		logger:Log(
			string.format(
				"TeamLose: branch=EndPve teamNumber=%d validTeamNumber=%d place=%d",
				teamNumber,
				match:GetValidTeamNumber(),
				match:GetPlace()
			)
		)
		FinishSoloPveWin(match, teamNumber)
	else
		if match:GetValidTeamNumber() >= 2 and match:GetPlace() == 2 then
			logger:Log(
				string.format(
					"TeamLose: branch=EndPvp teamNumber=%d validTeamNumber=%d place=%d",
					teamNumber,
					match:GetValidTeamNumber(),
					match:GetPlace()
				)
			)
			FinalizePvp(match, teamNumber)
		else
			logger:Log(
				string.format(
					"TeamLose: branch=EndPvpAndContinue teamNumber=%d validTeamNumber=%d place=%d",
					teamNumber,
					match:GetValidTeamNumber(),
					match:GetPlace()
				)
			)
			EliminateTeamAndContinue(match, teamNumber)
		end
	end
end