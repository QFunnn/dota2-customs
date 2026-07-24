--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_hero_level_upgrade_damage = class({})
function modifier_hero_level_upgrade_damage:IsPurgable() return false end
function modifier_hero_level_upgrade_damage:IsHidden() return true end
function modifier_hero_level_upgrade_damage:IsPurgeException() return false end
function modifier_hero_level_upgrade_damage:RemoveOnDeath() return false end

function modifier_hero_level_upgrade_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_hero_level_upgrade_damage:GetModifierTotalDamageOutgoing_Percentage()
    if not IsServer() then return end
    if self:GetStackCount() >= 2 then
        return 10
    end
end

function modifier_hero_level_upgrade_damage:GetModifierIncomingDamage_Percentage()
    if not IsServer() then return end
    if self:GetStackCount() >= 1 then
        return -10
    end
end