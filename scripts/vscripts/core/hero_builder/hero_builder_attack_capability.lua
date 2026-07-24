--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Отслеживать событие внутри фильтра модификаторов
---@param hHero CDOTA_BaseNPC_Hero
function HeroBuilder:RegisterAttackCapabilityChanged(hHero)
    if not hHero or hHero:IsTempestDouble() or hHero:HasModifier("modifier_arc_warden_tempest_double_lua") then
        return
    end
    HeroBuilder.attackCapabilityChanged[hHero:GetEntityIndex()] = hHero
end

function HeroBuilder:HasAttackCapabilityModifiers(hHero)
    for _, hModifier in ipairs(hHero:FindAllModifiers()) do
        if HeroBuilder.attackCapabilityModifiers[hModifier:GetName()] then
            return true
        end
    end
    return false
end

-- Периодическое задание, исправляющее исходный тип атаки героя
function HeroBuilder:FixAttackCapability()
    for _, hHero in pairs(HeroBuilder.attackCapabilityChanged) do
        if hHero and hHero.nOriginalAttackCapability and not HeroBuilder:HasAttackCapabilityModifiers(hHero) then
            hHero:SetAttackCapability(hHero.nOriginalAttackCapability)
        end
    end
end