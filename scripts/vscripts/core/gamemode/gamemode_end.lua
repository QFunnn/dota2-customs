--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Помечает команду как проигрвашую
---@param teamNumber integer
function GameMode:TeamLose(teamNumber)
    logger:Log(string.format("TeamLose: teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber or -1, self.place or -1))
    self.aliveTeamMap[teamNumber] = false;
    local payLoadFireBullet = {
        type = "team_lose",
        nTeamNumber = teamNumber
    }
    Barrage:FireBullet(payLoadFireBullet)
    for _, playerId in ipairs(self.teamPlayerMap[teamNumber]) do
        local hero = PlayerResource:GetSelectedHeroEntity(playerId)
        if hero then
            hero:SetGold(0, true)
        end
    end

    if self.currentRound and self.currentRound.spawners and self.currentRound.spawners[teamNumber] then
        self.currentRound.spawners[teamNumber].isForceStop = true;
        local units = GetCreepsByTeamNumber(teamNumber)
        for _, creep in ipairs(units) do
            if creep and not creep:IsNull() and creep:IsAlive() then
                creep:ForceKill(false)
            end
        end
    end

    Util:CleanPvpPair(teamNumber)

    if self.validTeamNumber == 1 and self.place == 1 then
        logger:Log(string.format("TeamLose: branch=EndPve teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber, self.place))
        self:EndPve(teamNumber)
    else
        if self.validTeamNumber >= 2 and self.place == 2 then
            logger:Log(string.format("TeamLose: branch=EndPvp teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber, self.place))
            self:EndPvp(teamNumber)
        else
            logger:Log(string.format("TeamLose: branch=EndPvpAndContinue teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber, self.place))
            self:EndPvpAndContinue(teamNumber)
        end
    end
end

---@param teamNumber integer
function GameMode:EndPve(teamNumber)
    logger:Log(string.format("EndPve: teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber or -1, self.place or -1))
    if self:GetMatchType() == MATCH_TYPE_SOLO then
        local playerId = self.teamPlayerMap[teamNumber][1]
        if not DevUtils:Check() then
            _G.winnerTeam = teamNumber;
            Service:EndPve(playerId)
        else
            Notifications:BottomToAll({
                text = "#cheat_no_record",
                duration = 4,
                style = {
                    color = "Red"
                }
            })
            _G.winnerTeam = teamNumber;
            Service:EndPve(playerId)
        end
    end
    if self:GetMatchType() == MATCH_TYPE_DUO then
        _G.winnerTeam = teamNumber
    end
end

---@param teamNumber integer
function GameMode:EndPvpAndContinue(teamNumber)
    logger:Log(string.format("EndPvpAndContinue: teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber or -1, self.place or -1))
    for _, playerId in ipairs(self.teamPlayerMap[teamNumber]) do
        self.playerPlaceMap[playerId] = self.place;
        local place = self.place;
        local steamId = GetSteamID(playerId)
        MatchOutboundApi:UpdateMatchPlayerRating(tostring(self:GetMatchID()), {
            uid = steamId,
            place = place,
            matchTypeCode = self:GetMatchType()
        }, function(res)
            local data = {
                game_rank = place,
                valid_team = self.validTeamNumber
            }
            if res and res.Body then
                local resBody = json.decode(res.Body)
                local playerRankTable = CustomNetTables:GetTableValue("service", "player_rank")
                data.score = resBody.rating;
                data.originScore = playerRankTable[steamId].score;
                playerRankTable[steamId].newScore = resBody.rating;
                CustomNetTables:SetTableValue("service", "player_rank", playerRankTable)
            end
            local player = PlayerResource:GetPlayer(playerId)
            if player then
                CustomGameEventManager:Send_ServerToPlayer(player, "ShowPlayerLose", data)
            end
        end)
    end
    self.placeTeamMap[self.place] = teamNumber;
    CustomNetTables:SetTableValue("team_rank", tostring(teamNumber), {
        rank = self.place,
        defeat_round = self.currentRound and self.currentRound.roundNumber or 1
    })
    self.place = self.place - 1
end

---@param teamNumber integer
function GameMode:EndPvp(teamNumber)
    logger:Log(string.format("EndPvp: teamNumber=%d validTeamNumber=%d place=%d", teamNumber, self.validTeamNumber or -1, self.place or -1))
    _G.winnerTeam = -1;
    for teamId, isAlive in pairs(self.aliveTeamMap) do
        if isAlive then
            _G.winnerTeam = teamId
        end
    end
    self.placeTeamMap[2] = teamNumber;
    CustomNetTables:SetTableValue("team_rank", tostring(teamNumber), {
        rank = 2,
        defeat_round = self.currentRound and self.currentRound.roundNumber or 1
    })
    self.placeTeamMap[1] = _G.winnerTeam;
    CustomNetTables:SetTableValue("team_rank", tostring(_G.winnerTeam), {
        rank = 1,
        defeat_round = self.currentRound and self.currentRound.roundNumber or 1
    })
    if not DevUtils:Check() then
        self:CalculateScore(_G.winnerTeam, 1)
        self:CalculateScore(teamNumber, 2)
        Service:EndRank()
    end
    self.place = self.place - 1;
end

---@param teamNumber integer
---@param place integer
function GameMode:CalculateScore(teamNumber, place)
    for _, playerId in ipairs(self.teamPlayerMap[teamNumber]) do
        self.playerPlaceMap[playerId] = place;
        local steamId = GetSteamID(playerId)
        MatchOutboundApi:UpdateMatchPlayerRating(self:GetMatchID(), {
                uid = steamId,
                place = place,
                matchTypeCode = self:GetMatchType()
            },
            function(res)
                if res and res.Body then
                    local resBody = json.decode(res.Body)
                    local newRating = resBody.rating;
                    local playerRatingTable = CustomNetTables:GetTableValue("service", "player_rank")
                    playerRatingTable[steamId].newScore = newRating
                    CustomNetTables:SetTableValue("service", "player_rank", playerRatingTable)
                end
            end
        )
    end
end