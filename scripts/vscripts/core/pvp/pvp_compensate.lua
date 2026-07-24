--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Компенсировать опыт для определенной команды
---@param teamId integer
function PvpModule:CompensateTeamExp(teamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
        local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
        self:CompensatePlayerExp(playerId)
    end
end

---Компенсировать опыта для определенного игрока
---@param playerId integer
function PvpModule:CompensatePlayerExp(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hHero then
        local roundNumber = PvpModule.LastPvpRoundNumber
        if roundNumber and GameRulesCustom.xpTable[roundNumber + 1] and GameRulesCustom.xpTable[roundNumber] then
            local nExp = math.floor((GameRulesCustom.xpTable[roundNumber + 1] - GameRulesCustom.xpTable[roundNumber]) * 0.7)
            hHero:AddExperience(nExp, 0, false, false)
        end
    end
end