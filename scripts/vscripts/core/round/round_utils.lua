--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@summary Вычисляет бонус за раунд с кривой роста и "потолком" на 65-м раунде.
---@param round integer
---@return float
function ComputeRoundBonus(round)
    local cap = math.min(tonumber(round) - 1, 65)
    return ROUND_BASE_BONUS * math.pow(1.031, cap)
end

---@summary Подсчёт общего числа крипов в данных раунда.
---@param roundData table
---@return integer
function CountCreatures(roundData)
    local total = 0
    for _, vData in pairs(roundData) do
        total = total + tonumber(vData.UnitNumber)
    end
    return total
end

---@summary Формирует строку способностей юнитов для UI.
---@param roundData table
---@return string
function BuildAbilityListForUI(roundData)
    local list, seen = {}, {}
    for _, vData in pairs(roundData) do
        local tData = GameRulesCustom.unitsPoolList[vData.UnitName]
        if tData then
            for i = 1, 10 do
                local ability = tData["Ability" .. i]
                if ability and ability ~= "neutral_upgrade_lua" and not seen[ability] then
                    table.insert(list, ability)
                    seen[ability] = true
                end
            end
        end
    end
    return table.concat(list, ",")
end

---Возвращает список игроков двух команд для показа брифинга PvP.
---@param teamA integer
---@param teamB integer
---@return table<integer, {playerID: integer, teamID: integer}>
function CollectPvpPlayersForTeams(teamA, teamB)
    local dataList = {} ---@type table<integer, {playerID: integer, teamID: integer}>
    if not (teamA and teamB) then return dataList end
    for nTempPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidPlayer(nTempPlayerID) then
            local team = PlayerResource:GetTeam(nTempPlayerID)
            if team == teamA or team == teamB then
                table.insert(dataList, { playerID = nTempPlayerID, teamID = team })
            end
        end
    end
    return dataList
end

---@param teamNumber integer
---@return CDOTA_BaseNPC[]
function GetCreepsByTeamNumber(teamNumber)
    return FindUnitsInRadius(
        DOTA_TEAM_NEUTRALS,
        GameMode.teamLocationMap[teamNumber],
        nil,
        2000,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_CREEP,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )
end