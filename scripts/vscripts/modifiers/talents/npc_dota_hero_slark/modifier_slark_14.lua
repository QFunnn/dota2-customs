--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_slark_14=class({})

function modifier_slark_14:IsHidden() return true end
function modifier_slark_14:IsPurgable() return false end
function modifier_slark_14:IsPurgeException() return false end
function modifier_slark_14:RemoveOnDeath() return false end

function modifier_slark_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local slark_pounce_custom = self:GetParent():FindAbilityByName("slark_pounce_custom")
        if slark_pounce_custom then
            slark_pounce_custom:RefreshCharges()
        end
    end)
end

function modifier_slark_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local slark_pounce_custom = self:GetParent():FindAbilityByName("slark_pounce_custom")
        if slark_pounce_custom then
            slark_pounce_custom:RefreshCharges()
        end
    end)
end

function modifier_slark_14:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_slark_14:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "slark_pounce_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_slark_14:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "slark_pounce_custom" and data.ability_special_value == "AbilityCharges" then
        return 2
    end
end