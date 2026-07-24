--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Очищает данные таблицы
---@generic K, V
---@param tempTable table<K, V>
---@param id integer
function CleanTempData(tempTable, id)
    for teamNumber, isAlive in pairs(GameMode.aliveTeamMap) do
        if isAlive and tempTable[teamNumber] then
            table.remove_item(tempTable[teamNumber], id)
        end
    end
end

---@param teamId DOTATeam_t
---@return boolean
function PvpModule:IsTeamAllDead(teamId)
    local result = true;

    for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
        local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
        local hero = PlayerResource:GetSelectedHeroEntity(playerId)
        if hero and (hero:IsAlive() or hero:IsReincarnating()) then
            result = false
        end
    end
    return result
end

---Обработчик события мьюта игроков
---@param keys {PlayerID: PlayerID, toPlayerId: PlayerID, disable: boolean}
function PvpModule:ToggleMute(keys)
    if PvpModule.MuteMap and PvpModule.MuteMap[keys.PlayerID] and PvpModule.MuteMap[keys.PlayerID][keys.toPlayerId] then
        PvpModule.MuteMap[keys.PlayerID][keys.toPlayerId] = ((keys.disable or 0) == 1)
    end
end

---Возвращает интервал дуелей между раундами
---@return integer
function PvpModule:GetPvpInterval()
    local pvpValidTeamMap = {} ---@type table<integer, boolean>
    local validTeamNumber = 0
    local pvpValidTeamList = {} ---@type table<integer, integer>

    for teamNumber, isAlive in pairs(GameMode.aliveTeamMap) do
        if not isAlive then
            goto continue
        end

        for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
            if PlayerResource:IsValidPlayer(playerId) and (IsInToolsMode() or PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED) then
                if PlayerResource:GetTeam(playerId) == teamNumber then
                    if pvpValidTeamMap[teamNumber] == nil then
                        validTeamNumber = validTeamNumber + 1
                        pvpValidTeamMap[teamNumber] = true
                        table.insert(pvpValidTeamList, teamNumber)
                    end
                end
            end
        end

        ::continue::
    end

    if validTeamNumber == 3 or validTeamNumber == 4 or validTeamNumber == 5 then
        return 2
    end

    if validTeamNumber == 2 or validTeamNumber == 1 then
        return 3
    end
    return 0
end