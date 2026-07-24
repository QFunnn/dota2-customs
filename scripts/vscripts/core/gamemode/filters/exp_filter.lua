--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--- @param event ModifyExperienceFilterEvent
--- @return boolean  
function GameMode:ModifyExpFilter(event)
    local hero = EntIndexToHScript(event.hero_entindex_const)
    local experience = event.experience
    local reason = event.reason_const

    if hero and hero:IsTempestDouble() then
        local originalHero = PlayerResource:GetSelectedHeroEntity(hero:GetPlayerOwnerID())
        if IsValid(originalHero) then ---@cast originalHero CDOTA_BaseNPC_Hero
            originalHero:AddExperience(experience, reason, false, false)
        end
        return false
    end

    return true
end