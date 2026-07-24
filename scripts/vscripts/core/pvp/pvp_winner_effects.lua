--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Проиграть звук победы для команды победителей
---@param winnerTeamId integer
function PvpModule:PlayWinnerTeamEffect(winnerTeamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(winnerTeamId) do
        local winnerPlayerID = PlayerResource:GetNthPlayerIDOnTeam(winnerTeamId, i)
        self:PlayWinnerHeroEffect(winnerPlayerID)
    end
end

---Проиграть звук победы для героя победителя
---@param winnerPlayerId integer
function PvpModule:PlayWinnerHeroEffect(winnerPlayerId)
    local winnerHero = PlayerResource:GetSelectedHeroEntity(winnerPlayerId)
    if not winnerHero then
        return
    end

    local winnerPfx = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf",
        PATTACH_OVERHEAD_FOLLOW,
        winnerHero
    )
    ParticleManager:ReleaseParticleIndex(winnerPfx)

    EmitSoundOn("Hero_LegionCommander.Duel.Victory", winnerHero)

    Timers:CreateTimer({
        endTime = 2,
        callback = function()
            if self.winnerSoundMap[winnerHero:GetUnitName()] ~= nil then
                EmitGlobalSound(self.winnerSoundMap[winnerHero:GetUnitName()])
            end
            return nil
        end
    })
end