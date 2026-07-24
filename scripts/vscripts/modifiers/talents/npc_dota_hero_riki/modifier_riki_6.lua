--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_riki_6=class({})

function modifier_riki_6:IsHidden() return true end
function modifier_riki_6:IsPurgable() return false end
function modifier_riki_6:IsPurgeException() return false end
function modifier_riki_6:RemoveOnDeath() return false end

function modifier_riki_6:OnCreated()
    self.bonus = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local riki_blink_strike_custom = self:GetParent():FindAbilityByName("riki_blink_strike_custom")
        if riki_blink_strike_custom then
            riki_blink_strike_custom:RefreshCharges()
        end
    end)
end

function modifier_riki_6:OnRefresh()
    self.bonus = {1,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local riki_blink_strike_custom = self:GetParent():FindAbilityByName("riki_blink_strike_custom")
        if riki_blink_strike_custom then
            riki_blink_strike_custom:RefreshCharges()
        end
    end)
end

function modifier_riki_6:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_riki_6:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "riki_blink_strike_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_riki_6:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "riki_blink_strike_custom" and data.ability_special_value == "AbilityCharges" then
        return data.ability:GetLevelSpecialValueNoOverride( data.ability_special_value, data.ability_special_level ) + self.bonus[self:GetStackCount()]
    end
end