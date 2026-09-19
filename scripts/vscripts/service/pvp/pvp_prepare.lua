--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Подготовка PVP Раунда
---@param roundNumber integer
function PvpService:RoundPrepare(roundNumber)
	local aliveTeamCount = 0
	for _, team in pairs(GameMode:GetMatch():GetTeams()) do
		if team:IsAlive() then
			aliveTeamCount = aliveTeamCount + 1
		end
	end

	local nBaseBonus = 152
	local nBonusRatio = 1

	if GetMapName() == "2x6" then
		nBaseBonus = 152 + 142 * 2
		nBonusRatio = 1.4
	end

	BetService:SetBaseBonus((nBaseBonus + 142 * aliveTeamCount * nBonusRatio) * math.pow(1.024, (roundNumber - 1)))

	PvpMatchmaker:MarkRound(roundNumber)
	PvpMatchmaker:RefreshInterval()
	PvpService:PrepareTeamPvp()
end

---Подготовка командного PVP
function PvpService:PrepareTeamPvp()
	local duel = self:GetDuel()
	if not duel:IsEnded() then
		logger:Log("[PvpService:PrepareTeamPvp] Skip: previous PVP is still active (IsPvpEnd == false)")
		return
	end

	logger:Log("[PvpService:PrepareTeamPvp] Start")

	BetService:ClearBets()

	if not PvpMatchmaker:HasPairs() then ---Если все PVP-пары уже использованы, пересчитать (сделать новый подбор)
		PvpMatchmaker:BuildPairs()
		table.insert(PvpService.AllPvpPairLog, "Pair Pvp")
	end

	if PvpMatchmaker:HasPairs() then
		local pair = PvpMatchmaker:TakePair()
		if pair and pair.nFirstTeamId ~= nil and pair.nSecondeTeamId ~= nil then
			-- Открываем очереди ставок для обеих команд
			BetService:OpenForTeams(pair.nFirstTeamId, pair.nSecondeTeamId)

			duel:Start(pair.nFirstTeamId, pair.nSecondeTeamId)

			PvpMatchmaker:RememberPair(pair)

			table.insert(PvpService.AllPvpPairLog, duel:GetPair())
			logger:Log("-------------------------------")

			---Случайным образом определяем на чьей арене будет происходить PVP
			local homeTeamId = (RandomInt(1, 2) == 1) and pair.nFirstTeamId or pair.nSecondeTeamId
			local homeCenter = GameMode:GetMatch():GetTeamLocation(homeTeamId)
			duel:SetHome(homeTeamId, homeCenter)

			self:KillSummonedCreatureAsyn(homeCenter)

			local dataList = {}
			local tRankData = CustomNetTables:GetTableValue("service", "player_rank")
			for iPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if
					PlayerResource:GetTeam(iPlayerID) == pair.nFirstTeamId
					or PlayerResource:GetTeam(iPlayerID) == pair.nSecondeTeamId
				then
					local teamId = PlayerResource:GetTeam(iPlayerID)
					if dataList[teamId] == nil then
						dataList[teamId] = {}
					end
					local tPlayerRankData = {} ---@type {play_time: float, score: integer}
					if tRankData then
						local steamId = GetSteamID(iPlayerID)
						local playerRankData = tRankData[steamId]
						if playerRankData then
							tPlayerRankData.play_time = playerRankData.play_time
							tPlayerRankData.score = playerRankData.score
						end
					end

					table.insert(dataList[teamId], {
						iPlayerID = iPlayerID,
						tRankData = tPlayerRankData,
					})
				end
			end

			-- Показать игроку окно ставок PVP
			for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if
					PlayerResource:IsValidPlayer(nPlayerID)
					and (
						IsInToolsMode()
						or PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_CONNECTED
					)
				then
					local hPlayer = PlayerResource:GetPlayer(nPlayerID)
					local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
					if hPlayer then
						local canBet = false
						if hHero then
							canBet = GameMode:GetMatch():IsTeamAlive(PlayerResource:GetTeam(nPlayerID))
							hHero.sBetUISecret = CreateSecretKey()
						end
						CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBet", {
							dataList = dataList,
							can_bet = canBet and 1 or 0,
						})
					end
				end
			end
		end
	end
end