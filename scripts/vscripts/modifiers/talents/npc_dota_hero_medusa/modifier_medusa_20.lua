--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_20=class({})

function modifier_medusa_20:IsHidden() return true end
function modifier_medusa_20:IsPurgable() return false end
function modifier_medusa_20:IsPurgeException() return false end
function modifier_medusa_20:RemoveOnDeath() return false end

function modifier_medusa_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_medusa_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_20:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_medusa_20:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "medusa_gorgon_grasp" and data.ability_special_value == "damage" then
        return 1
    end
end

function modifier_medusa_20:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "medusa_gorgon_grasp" and data.ability_special_value == "damage" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + 80
    end
end