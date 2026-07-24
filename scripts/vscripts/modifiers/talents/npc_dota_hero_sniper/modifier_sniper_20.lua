--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_20 = class({})

function modifier_sniper_20:IsHidden() return true end
function modifier_sniper_20:IsPurgable() return false end
function modifier_sniper_20:IsPurgeException() return false end
function modifier_sniper_20:RemoveOnDeath() return false end

function modifier_sniper_20:OnCreated()
    self.bonus = {1, 2}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local sniper_shrapnel_custom = self:GetParent():FindAbilityByName("sniper_shrapnel_custom")
        if sniper_shrapnel_custom then
            sniper_shrapnel_custom:RefreshCharges()
        end
    end)
end

function modifier_sniper_20:OnRefresh()
    self.bonus = {1, 2}
    self.bonus2 = {25,50}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local sniper_shrapnel_custom = self:GetParent():FindAbilityByName("sniper_shrapnel_custom")
        if sniper_shrapnel_custom then
            sniper_shrapnel_custom:RefreshCharges()
        end
    end)
end

function modifier_sniper_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE
    }
end

function modifier_sniper_20:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "sniper_shrapnel_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_sniper_20:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "sniper_shrapnel_custom" and data.ability_special_value == "AbilityCharges" then
        local flBaseValue = data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level )
        return flBaseValue + self.bonus[self:GetStackCount()]
    end
end

function modifier_sniper_20:GetModifierPercentageCasttime()
    return self.bonus2[self:GetStackCount()]
end