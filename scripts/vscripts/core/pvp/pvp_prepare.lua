--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Подготовка PVP Раунда
---@param roundNumber integer
function PvpModule:RoundPrepare(roundNumber)
    local aliveTeamCount = 0
    for _, bAlive in pairs(GameMode.aliveTeamMap) do
        if bAlive then aliveTeamCount = aliveTeamCount + 1 end
    end

    local nBaseBonus = 152
    local nBonusRatio = 1

    if GetMapName() == "2x6" then
        nBaseBonus = 152 + 142 * 2
        nBonusRatio = 1.4
    end

    PvpModule.BaseBetBonus = (nBaseBonus + 142 * aliveTeamCount * nBonusRatio) *
        math.pow(1.024, (roundNumber - 1))


    PvpModule.LastPvpRoundNumber = roundNumber

    self.PvpRoundInterval = self:GetPvpInterval()
    PvpModule:PrepareTeamPvp()
end

---Подготовка командного PVP
function PvpModule:PrepareTeamPvp()
    if not self.IsPvpEnd then
        logger:Log("[PvpModule:PrepareTeamPvp] Skip: previous PVP is still active (IsPvpEnd == false)")
        return
    end

    logger:Log("[PvpModule:PrepareTeamPvp] Start")

    PvpModule.betMap = {} ---@type table<integer, table<any, any>>

    if #PvpModule.PvpPairs == 0 then ---Если все PVP-пары уже использованы, пересчитать (сделать новый подбор)
        PvpModule:PairPvp()
        table.insert(PvpModule.AllPvpPairLog, "Pair Pvp")
    end

    if #PvpModule.PvpPairs > 0 then
        local pair = PvpModule:GetOnePair()
        if pair and pair.nFirstTeamId ~= nil and pair.nSecondeTeamId ~= nil then
            PvpModule.IsPvpEnd = false
            PvpModule.IsPvpBetClose = false

            -- Создаём две очереди ставок. Для одной команды и для другой
            PvpModule.betMap[pair.nFirstTeamId] = {}
            PvpModule.betMap[pair.nSecondeTeamId] = {}

            PvpModule.currentPvpPair = {}
            table.insert(PvpModule.currentPvpPair, pair.nFirstTeamId)
            table.insert(PvpModule.currentPvpPair, pair.nSecondeTeamId)

            if PvpModule.lastPair then
                PvpModule.secondLastPair = PvpModule.lastPair
            end

            -- Зафиксировать последние команды, которые были в PVP
            PvpModule.lastPair = {}
            PvpModule.lastPair.nFirstTeamId = pair.nFirstTeamId
            PvpModule.lastPair.nSecondeTeamId = pair.nSecondeTeamId

            table.insert(PvpModule.AllPvpPairLog, PvpModule.currentPvpPair)
            logger:Log("-------------------------------")

            ---Случайным образом определяем на чьей арене будет происходить PVP
            local nRandomIndex = RandomInt(1, 2)
            if nRandomIndex == 1 then
                PvpModule.homeTeamId = pair.nFirstTeamId
            end
            if nRandomIndex == 2 then
                PvpModule.homeTeamId = pair.nSecondeTeamId
            end
            self.homeCenterVector = GameMode.teamLocationMap[PvpModule.homeTeamId]

            self:KillSummonedCreatureAsyn(PvpModule.homeCenterVector)

            local dataList = {}
            local tRankData = CustomNetTables:GetTableValue("service", "player_rank")
            for iPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
                if PlayerResource:GetTeam(iPlayerID) == pair.nFirstTeamId or PlayerResource:GetTeam(iPlayerID) == pair.nSecondeTeamId then
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
                        tRankData = tPlayerRankData
                    })
                end
            end

            -- Показать игроку окно ставок PVP
            for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
                if PlayerResource:IsValidPlayer(nPlayerID) and (IsInToolsMode() or PlayerResource:GetConnectionState(nPlayerID) == DOTA_CONNECTION_STATE_CONNECTED) then
                    local hPlayer = PlayerResource:GetPlayer(nPlayerID)
                    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
                    if hPlayer then
                        local canBet = false
                        if hHero then
                            canBet = GameMode.aliveTeamMap[PlayerResource:GetTeam(nPlayerID)] == true
                            hHero.sBetUISecret = CreateSecretKey()
                        end
                        CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBet", {
                            dataList = dataList,
                            can_bet = canBet and 1 or 0
                        })
                    end
                end
                -- Автоматическая ставка бота
                if PlayerResource:IsValidPlayer(nPlayerID) then
                    if PlayerResource:GetConnectionState(nPlayerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
                        if GameMode.aliveTeamMap[PlayerResource:GetTeam(nPlayerID)] then
                            local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
                            if hHero and hHero.bTakenOverByBot then
                                if PlayerResource:GetTeam(nPlayerID) ~= pair.nFirstTeamId and PlayerResource:GetTeam(nPlayerID) ~= pair.nSecondeTeamId then
                                    PvpModule:BotAutoBet(nPlayerID)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

---Подготовить пары к командному PVP
function PvpModule:PairPvp()
    PvpModule.PvpPairs = {}
    local pvpValidTeamMap = {}
    local validTeamCount = 0
    local pvpValidTeamList = {}

    for teamNumber, isAlive in pairs(GameMode.aliveTeamMap) do
        if not isAlive then
            goto continue
        end
        for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
            if PlayerResource:IsValidPlayer(playerId) and (IsInToolsMode() or PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED) then
                if PlayerResource:GetTeam(playerId) == teamNumber then
                    if pvpValidTeamMap[teamNumber] == nil then
                        validTeamCount = validTeamCount + 1
                        pvpValidTeamMap[teamNumber] = true
                        table.insert(pvpValidTeamList, teamNumber)
                    end
                end
            end
        end

        ::continue::
    end

    if validTeamCount == 1 then
        logger:Log("[PvpModule:PairPvp] Only One PVP team, return...")
        return
    end

    for _, nTeamNumber in ipairs(pvpValidTeamList) do
        for _, nEnemyTeamNumber in ipairs(pvpValidTeamList) do
            if nEnemyTeamNumber < nTeamNumber then
                local pair = {
                    nFirstTeamId = nTeamNumber,
                    nSecondeTeamId = nEnemyTeamNumber,
                    nTeamJoinTimes = 0
                } ---@type PvpPair
                table.insert(PvpModule.PvpPairs, pair)
            end
        end
    end
end