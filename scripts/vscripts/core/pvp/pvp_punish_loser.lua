--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Выкидывает проигрывшего в дуели. Удаляет аеги или навешивает 1 стак курсы
---@param loserTeamId integer
function PvpModule:PunishLoser(loserTeamId)
    for i = 1, PlayerResource:GetPlayerCountForTeam(loserTeamId) do
        local loserPlayerId = PlayerResource:GetNthPlayerIDOnTeam(loserTeamId, i)
        local loserHero = PlayerResource:GetSelectedHeroEntity(loserPlayerId)

        if not IsValid(loserHero) then ---@cast loserHero CDOTA_BaseNPC_Hero
            goto continue
        end

        if IsValid(GoodFrog) then
            local nParticle = ParticleManager:CreateParticle(
                "particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_start.vpcf",
                PATTACH_WORLDORIGIN,
                loserHero
            )
            ParticleManager:SetParticleControl(nParticle, 0, loserHero:GetAbsOrigin())
            ParticleManager:SetParticleControl(nParticle, 1, loserHero:GetAbsOrigin())
            ParticleManager:SetParticleControlForward(
                nParticle,
                0,
                (loserHero:GetAbsOrigin() - GoodFrog:GetAbsOrigin()):Normalized()
            )
            ParticleManager:ReleaseParticleIndex(nParticle)
        end

        local aegis = loserHero:FindModifierByName("modifier_aegis")

        if aegis and aegis:GetStackCount() >= 1 then
            local data = {
                type = "pvp_lose_aegis",
                playerId = loserPlayerId
            }
            Barrage:FireBullet(data)
            local nCount = aegis:GetStackCount()
            aegis:SetStackCount(nCount - 1)
        else
            local data = {
                type = "pvp_stack_curse",
                playerId = loserPlayerId,
            }
            Barrage:FireBullet(data)
            local reaperAbility = nil
            if GoodFrog then
                reaperAbility = GoodFrog:FindAbilityByName("frog_reaper")
            end
            loserHero:AddNewModifier(loserHero, reaperAbility, "modifier_loser_curse", {})
        end

        ::continue::
    end
end