--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_windrunner_8=class({})

function modifier_windrunner_8:IsHidden() return true end
function modifier_windrunner_8:IsPurgable() return false end
function modifier_windrunner_8:IsPurgeException() return false end
function modifier_windrunner_8:RemoveOnDeath() return false end

function modifier_windrunner_8:OnCreated()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_windrunner_8:OnRefresh()
    self.bonus = {5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_windrunner_8:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_windrunner_8:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "windrunner_focusfire" and data.ability_special_value == "focusfire_damage_reduction" then
        return 1
    end
    if data.ability:GetAbilityName() == "windrunner_focusfire_whirlwind" and data.ability_special_value == "focusfire_damage_reduction" then
        return 1
    end
end

function modifier_windrunner_8:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "windrunner_focusfire" and data.ability_special_value == "focusfire_damage_reduction" then
        local flBaseValue = data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level )
		return flBaseValue + self.bonus[self:GetStackCount()]
    end
    if data.ability:GetAbilityName() == "windrunner_focusfire_whirlwind" and data.ability_special_value == "focusfire_damage_reduction" then
        local flBaseValue = data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level )
		return flBaseValue + self.bonus[self:GetStackCount()]
    end
end