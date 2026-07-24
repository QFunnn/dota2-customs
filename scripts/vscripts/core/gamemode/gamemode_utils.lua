--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--- @return integer playersPerTeam
--- @return integer teamCount
function GameMode:GetAllTeamInfo()
    local playersPerTeam = 8
    local teamCount = 1
    local mapName = GetMapName()

    if string.find(mapName, "1x8") then
        playersPerTeam = 8
        teamCount = 1
    elseif mapName == "2x6" then
        playersPerTeam = 6
        teamCount = 2
    end

    return playersPerTeam, teamCount
end


--- @param playerID integer
function GameMode:UpdatePlayerGold(playerID)
    local player = PlayerResource:GetPlayer(playerID)
    if not player or not GameRulesCustom.gameStartTime then
        return
    end

    -- Обновляем таблицу player_info с текущим количеством золота
    CustomNetTables:SetTableValue("player_info", tostring(playerID), {
        gold = _G.PlayersGold[playerID]
    })
end

--- @param playerID integer
function GameMode:MarkPlayerGoldDirty(playerID)
    self.dirtyGold = self.dirtyGold or {}
    self.dirtyGold[playerID] = true

    if self.goldFlushScheduled then
        return
    end
    self.goldFlushScheduled = true
    Timers:CreateTimer(0.5, function()
        self.goldFlushScheduled = false
        local dirty = self.dirtyGold
        self.dirtyGold = {}
        for pid in pairs(dirty) do
            self:UpdatePlayerGold(pid)
        end
    end)
end

---@return integer|Uint64
function GameMode:GetMatchID()
    return self.MatchID
end

function GameMode:MonitorConnections()
    Timers:CreateTimer(1.5, function()
        for teamID, isAlive in pairs(self.aliveTeamMap) do
            local allAbandoned = true
            for _, playerID in ipairs(self.teamPlayerMap[teamID]) do
                if PlayerResource:GetConnectionState(playerID) ~= DOTA_CONNECTION_STATE_ABANDONED then
                    allAbandoned = false
                end
            end
            if allAbandoned and not self.loggedAllAbandoned then
                self.loggedAllAbandoned = true
                logger:Log(string.format("MonitorConnections: allAbandoned=true for teamID=%d", teamID))
            end
            if allAbandoned then
                self.teamAbandonMap[teamID] = true
            end
        end

        local allDisconnected = true
        for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
            if PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_CONNECTED then
                allDisconnected = false
                break
            end
        end

        if allDisconnected and not self.loggedAllDisconnected then
            self.loggedAllDisconnected = true
            logger:Log("MonitorConnections: allDisconnected=true (no CONNECTED players)")
        end

        return 1
    end)
end
