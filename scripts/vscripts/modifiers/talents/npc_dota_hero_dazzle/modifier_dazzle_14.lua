--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dazzle_14=class({})

function modifier_dazzle_14:IsHidden() return true end
function modifier_dazzle_14:IsPurgable() return false end
function modifier_dazzle_14:IsPurgeException() return false end
function modifier_dazzle_14:RemoveOnDeath() return false end

function modifier_dazzle_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dazzle_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dazzle_14:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_dazzle_14:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "dazzle_nothl_projection" and data.ability_special_value == "castable_while_disabled" then
        return 1
    end
    if data.ability:GetAbilityName() == "dazzle_nothl_projection" and data.ability_special_value == "max_duration" then
        return 1
    end
end

function modifier_dazzle_14:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "dazzle_nothl_projection" and data.ability_special_value == "castable_while_disabled" then
        return 1
    end
    if data.ability:GetAbilityName() == "dazzle_nothl_projection" and data.ability_special_value == "max_duration" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + 3
    end
end