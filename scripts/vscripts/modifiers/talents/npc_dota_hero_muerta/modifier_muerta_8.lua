--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_muerta_8=class({})

function modifier_muerta_8:IsHidden() return true end
function modifier_muerta_8:IsPurgable() return false end
function modifier_muerta_8:IsPurgeException() return false end
function modifier_muerta_8:RemoveOnDeath() return false end

function modifier_muerta_8:OnCreated()
    self.bonus = {4,8}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_muerta_8:OnRefresh()
    self.bonus = {4,8}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_muerta_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_muerta_8:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "muerta_gunslinger" and data.ability_special_value == "double_shot_chance" then
        return 1
    end
end

function modifier_muerta_8:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "muerta_gunslinger" and data.ability_special_value == "double_shot_chance" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + self.bonus[self:GetStackCount()]
    end
end