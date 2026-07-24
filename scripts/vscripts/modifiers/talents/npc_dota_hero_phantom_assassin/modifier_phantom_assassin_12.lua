--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_12=class({})

function modifier_phantom_assassin_12:IsHidden() return true end
function modifier_phantom_assassin_12:IsPurgable() return false end
function modifier_phantom_assassin_12:IsPurgeException() return false end
function modifier_phantom_assassin_12:RemoveOnDeath() return false end

function modifier_phantom_assassin_12:OnCreated()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local modifier_phantom_assassin_immaterial = self:GetParent():FindModifierByName("modifier_phantom_assassin_immaterial")
        if modifier_phantom_assassin_immaterial then
            modifier_phantom_assassin_immaterial:ForceRefresh()
        end
    end)
end

function modifier_phantom_assassin_12:OnRefresh()
    self.bonus = {10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local modifier_phantom_assassin_immaterial = self:GetParent():FindModifierByName("modifier_phantom_assassin_immaterial")
        if modifier_phantom_assassin_immaterial then
            modifier_phantom_assassin_immaterial:ForceRefresh()
        end
    end)
end

function modifier_phantom_assassin_12:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_phantom_assassin_12:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "phantom_assassin_immaterial" and data.ability_special_value == "evasion" then
        return 1
    end
end

function modifier_phantom_assassin_12:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "phantom_assassin_immaterial" and data.ability_special_value == "evasion" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + self.bonus[self:GetStackCount()]
    end
end