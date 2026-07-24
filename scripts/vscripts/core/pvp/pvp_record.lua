--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Обновить запись о победах
---@param winnerTeamId integer
function PvpModule:RecordWinner(winnerTeamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(winnerTeamId) do
        local winnerPlayerId = PlayerResource:GetNthPlayerIDOnTeam(winnerTeamId, i)
        PvpModule.PvpRecord[winnerPlayerId].win = PvpModule.PvpRecord[winnerPlayerId].win + 1
    end
end

---Обновить запись о поражениях
---@param loserTeamId integer
function PvpModule:RecordLoser(loserTeamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(loserTeamId) do
        local loserPlayerId = PlayerResource:GetNthPlayerIDOnTeam(loserTeamId, i)
        self.PvpRecord[loserPlayerId].lose = self.PvpRecord[loserPlayerId].lose + 1
    end
end


---Записать результат PVP в историю ставок
---@param playerId integer
---@param value integer
---@param winnerId integer
---@param loserId integer
---@param bet integer
---@param multiplier number
---@param pool integer
function PvpModule:RecordBetHistory(playerId, value, winnerId, loserId, bet, multiplier, pool)
    if self.BetHistory[playerId] == nil then
        self.BetHistory[playerId] = {}
    end

    if #PvpModule.BetHistory[playerId] > 90 then return end

    local winners = {} ---@type integer[]
    local losers = {} ---@type integer[]

    for winnerPlayerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:GetTeam(winnerPlayerId) == winnerId then
            table.insert(winners, winnerPlayerId)
        end
    end

    for loserPlayerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:GetTeam(loserPlayerId) == loserId then
            table.insert(losers, loserPlayerId)
        end
    end

    local data = {
        winners = winners,
        losers = losers,
        value = value,
        bet = bet,
        multiplier = multiplier,
        pool = pool,
    }
    table.insert(self.PvpRecord[playerId].bet_history, data)
    table.insert(self.BetHistory[playerId], data)
end