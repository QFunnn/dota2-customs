--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function Round:RoundTimeExceeded()
    if PvpModule.IsPvpEnd == false and PvpModule.currentPvpPair[1] and PvpModule.currentPvpPair[2] then
        self:EndTeamPvpInternal()
    end
end

function Round:EndTeamPvpInternal()
    local teamId1 = PvpModule.currentPvpPair[1]
    local teamId2 = PvpModule.currentPvpPair[2]
    local totalHeath1, percentage1 = self:_GetSumTeamHealth(teamId1)
    local totalHeath2, percentage2 = self:_GetSumTeamHealth(teamId2)
    if percentage1 == percentage2 then
        if totalHeath1 > totalHeath2 then
            PvpModule:EndPvp(teamId1, teamId2)
        else
            PvpModule:EndPvp(teamId2, teamId1)
        end
    else
        if percentage1 > percentage2 then
            PvpModule:EndPvp(teamId1, teamId2)
        else
            PvpModule:EndPvp(teamId2, teamId1)
        end
    end
end

---@param teamID integer
---@return integer totalHealth
---@return float totalPercent
function Round:_GetSumTeamHealth(teamID)
    local pct, total = 0, 0
    for i = 1, PlayerResource:GetPlayerCountForTeam(teamID) do
        local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamID, i)
        local hero = PlayerResource:GetSelectedHeroEntity(playerId)
        if hero then
            pct = pct + hero:GetHealthPercent()
            total = total + hero:GetHealth()
        end
    end
    return total, pct
end

---@summary Показывает PvP-частицы и звук в указанной позиции.
---@param hero CDOTA_BaseNPC_Hero
---@param position Vector
function Round:ShowPvpParticle(hero, position)
    local nPvpParticle = ParticleManager:CreateParticle(
    "particles/econ/items/legion/legion_weapon_voth_domosh/legion_duel_start_ring_arcana.vpcf", PATTACH_CUSTOMORIGIN, nil)
    ParticleManager:SetParticleControl(nPvpParticle, 0, position)
    ParticleManager:SetParticleControl(nPvpParticle, 7, position)
    Timers:CreateTimer({
        endTime = 1,
        callback = function()
            ParticleManager:DestroyParticle(nPvpParticle, false)
            ParticleManager:ReleaseParticleIndex(nPvpParticle)
            return nil
        end
    })
    EmitSoundOn("Hero_LegionCommander.Duel", hero)
    Timers:CreateTimer({
        endTime = 1.5,
        callback = function()
            StopSoundOn("Hero_LegionCommander.Duel", hero)
            return nil
        end
    })
end