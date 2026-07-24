--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_19 = class({})
function modifier_void_spirit_19:IsHidden() return true end
function modifier_void_spirit_19:IsPurgable() return false end
function modifier_void_spirit_19:IsPurgeException() return false end
function modifier_void_spirit_19:RemoveOnDeath() return false end

function modifier_void_spirit_19:OnCreated()
    self.bonus = {2}
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local void_spirit_resonant_pulse_custom = self:GetParent():FindAbilityByName("void_spirit_resonant_pulse_custom")
        if void_spirit_resonant_pulse_custom then
            void_spirit_resonant_pulse_custom:RefreshCharges()
        end
    end)
end

function modifier_void_spirit_19:OnRefresh()
    self.bonus = {2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local void_spirit_resonant_pulse_custom = self:GetParent():FindAbilityByName("void_spirit_resonant_pulse_custom")
        if void_spirit_resonant_pulse_custom then
            void_spirit_resonant_pulse_custom:RefreshCharges()
        end
    end)
end

function modifier_void_spirit_19:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_void_spirit_19:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "void_spirit_resonant_pulse_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_void_spirit_19:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "void_spirit_resonant_pulse_custom" and data.ability_special_value == "AbilityCharges" then
        return self.bonus[self:GetStackCount()]
    end
end