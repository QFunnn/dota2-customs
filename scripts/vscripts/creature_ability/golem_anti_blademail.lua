--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_anti_blademail", "creature_ability/golem_anti_blademail.lua", LUA_MODIFIER_MOTION_NONE)

golem_anti_blademail = class({}) ---@class golem_anti_blademail : CDOTA_Ability_Lua

function golem_anti_blademail:GetIntrinsicModifierName()
    return "modifier_golem_anti_blademail"
end

modifier_golem_anti_blademail = class({}) ---@class CDOTA_Modifier_Lua

function modifier_golem_anti_blademail:IsHidden()
    return false
end

function modifier_golem_anti_blademail:IsPurgable()
    return false
end

function modifier_golem_anti_blademail:RemoveOnDeath()
    return false
end

function modifier_golem_anti_blademail:OnCreated()
    self:UpdateValues()
end

function modifier_golem_anti_blademail:OnRefresh()
    self:UpdateValues()
end

function modifier_golem_anti_blademail:UpdateValues()
    local ability = self:GetAbility()
    if ability then
        self.reduction_pct = ability:GetSpecialValueFor("damage_reduction")
    end
end

function modifier_golem_anti_blademail:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_TOOLTIP
    }
end

function modifier_golem_anti_blademail:OnTooltip()
    return self.reduction_pct
end

---@param event ModifierAttackEvent
function modifier_golem_anti_blademail:GetModifierIncomingDamage_Percentage(event)
    if not self.reduction_pct then
        return
    end

    if event.inflictor and event.inflictor:GetAbilityName() == "item_blade_mail" then
        return -self.reduction_pct
    end

    return 0
end