--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class MatchLifecycleService
MatchLifecycleService = MatchLifecycleService or {}

---@param playerUids string[]
function MatchLifecycleService:Start(playerUids)
	MatchOutboundApi:StartMatch(GameMode:GetMatchID(), {
		playerUids = playerUids,
		matchTypeCode = GameMode:GetMatchType(),
	}, function()
		HeartbeatService:Start()
		MatchCommandService:Init()
	end)
end

function MatchLifecycleService:EndRank()
	logger:Log("MatchLifecycleService:EndRank call.")
	local game_type = ""
	local nRoundNumber = 1
	local playerRanks = {}

	local currentRound = GameMode:GetMatch():GetCurrentRound()
	if currentRound and currentRound.roundNumber then
		nRoundNumber = currentRound.roundNumber
	end

	for iPlayerID, rank in pairs(GameMode:GetMatch():GetPlayerPlaces()) do
		local steamid = GetSteamID(iPlayerID)
		playerRanks[steamid] = rank
	end
	if DevUtils:Check() then
		self:EndGameCallback(true)
	else
		Timers:CreateTimer(3.0, function()
			MatchOutboundApi:EndMatch(tostring(GameMode:GetMatchID()), nil)
			self:EndGameCallback(true)
			return nil
		end)
	end
end

---@param iPlayerID integer
function MatchLifecycleService:EndPve(iPlayerID)
	local nRoundNumber = 1
	local nTimeCost = GameRulesCustom:GetGameTime() - GameRulesCustom.gameStartTime or 0
	local currentRound = GameMode:GetMatch():GetCurrentRound()
	if currentRound and currentRound.roundNumber then
		nRoundNumber = currentRound.roundNumber
	end

	if DevUtils:Check() then
		-- self:EndGameCallback({
		-- 	Body = json.encode({
		-- 		data = {
		-- 			type = Game_type,
		-- 			round_num = nRoundNumber,
		-- 			reward = 0,
		-- 		}
		-- 	})
		-- }, false)
		self:EndGameCallback(false)
	else
		-- self:CallAction("end_pve", iPlayerID, { todo логика для пве
		-- 	time_cost = math.floor(nTimeCost),
		-- 	round_num = nRoundNumber,
		-- }, function(_, iPlayerID, response)
		-- 	self:EndGameCallback(false)
		-- end)
	end
end

---@param isPvp boolean
function MatchLifecycleService:EndGameCallback(isPvp)
	logger:Log("EndGameCallback call..")
	local end_game_data = {}
	local data_name = "pvp"

	Timers:CreateTimer(2, function()
		local units = FindUnitsInRadius(
			DOTA_TEAM_NEUTRALS,
			Vector(0, 0, 0),
			nil,
			FIND_UNITS_EVERYWHERE,
			DOTA_UNIT_TARGET_TEAM_FRIENDLY,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			if IsValid(unit) then
				unit:Kill(nil, unit)
			end
		end
		local currentRound = GameMode:GetMatch():GetCurrentRound()
		if currentRound then
			currentRound:End()
		end
		CustomGameEventManager:Send_ServerToAllClients("EndQuest", {})
		for playerId = 0, MAX_PLAYER_COUNT do
			AbilitySelectionService:Reset(playerId)
		end
		return 2
	end)

	if isPvp then
		for _, nTeamNumber in pairs(GameMode:GetMatch():GetTeamPlaces()) do
			local team_info = {}
			for iPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				local hHero = PlayerResource:GetSelectedHeroEntity(iPlayerID)
				if
					PlayerResource:IsValidPlayer(iPlayerID)
					and hHero
					and PlayerResource:GetSelectedHeroEntity(iPlayerID):GetTeamNumber() == nTeamNumber
				then
					team_info[iPlayerID] = {}
					if not PlayerResource:IsFakeClient(iPlayerID) then
						local steamId = GetSteamID(iPlayerID)
						logger:Log("Preparing final score for " .. steamId)
						DeepPrintTable(CustomNetTables:GetTableValue("service", "player_rank"))
						team_info[iPlayerID].score =
							CustomNetTables:GetTableValue("service", "player_rank")[steamId].newScore
						team_info[iPlayerID].origin =
							CustomNetTables:GetTableValue("service", "player_rank")[steamId].score
						hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
					end
				end
			end
			table.insert(end_game_data, team_info)
		end
	end

	if not isPvp then
		data_name = "pve"
	end
	logger:Log("End game data test")
	DeepPrintTable(end_game_data)
	logger:Log("End game data test end")
	CustomNetTables:SetTableValue("end_game", data_name, end_game_data)
end