--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_spectre_14=class({})

function modifier_spectre_14:IsHidden() return true end
function modifier_spectre_14:IsPurgable() return false end
function modifier_spectre_14:IsPurgeException() return false end
function modifier_spectre_14:RemoveOnDeath() return false end

function modifier_spectre_14:OnCreated()
    self.bonus = {2, 3}
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local spectre_shadow_step_custom = self:GetParent():FindAbilityByName("spectre_shadow_step_custom")
        if spectre_shadow_step_custom then
            spectre_shadow_step_custom:RefreshCharges()
        end
    end)
end

function modifier_spectre_14:OnRefresh()
    self.bonus = {2, 3}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local spectre_shadow_step_custom = self:GetParent():FindAbilityByName("spectre_shadow_step_custom")
        if spectre_shadow_step_custom then
            spectre_shadow_step_custom:RefreshCharges()
        end
    end)
end

function modifier_spectre_14:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_spectre_14:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "spectre_shadow_step_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_spectre_14:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "spectre_shadow_step_custom" and data.ability_special_value == "AbilityCharges" then
        return self.bonus[self:GetStackCount()]
    end
end