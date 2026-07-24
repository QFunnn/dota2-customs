--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chen_creep_innate", "heroes/npc_dota_hero_chen_custom/chen_creep_innate", LUA_MODIFIER_MOTION_NONE)

chen_creep_innate = class({})

function chen_creep_innate:GetIntrinsicModifierName()
    return "modifier_chen_creep_innate"
end

modifier_chen_creep_innate = class({})
function modifier_chen_creep_innate:IsHidden() return true end
function modifier_chen_creep_innate:IsPurgable() return false end
function modifier_chen_creep_innate:RemoveOnDeath() return false end

function modifier_chen_creep_innate:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end

function modifier_chen_creep_innate:IsCreepTarget(unit)
    if not unit then return false end
    if unit:IsBuilding() then return false end
    return unit:IsIllusion() or not unit:IsRealHero()
end

function modifier_chen_creep_innate:GetModifierIncomingDamage_Percentage(params)
    local attacker = params.attacker
    if not attacker then return end
    if attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not self:IsCreepTarget(attacker) then return end
    return self:GetAbility():GetSpecialValueFor("damage_incoming")
end

function modifier_chen_creep_innate:GetModifierTotalDamageOutgoing_Percentage(params)
    local target = params.target
    if not target then return end
    if target:GetTeamNumber() == self:GetParent():GetTeamNumber() then return end
    if not self:IsCreepTarget(target) then return end
    return self:GetAbility():GetSpecialValueFor("damage_outgoing")
end