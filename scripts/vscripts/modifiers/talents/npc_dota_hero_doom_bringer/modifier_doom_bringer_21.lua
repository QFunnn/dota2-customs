--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_doom_bringer_21=class({})

function modifier_doom_bringer_21:IsHidden() return true end
function modifier_doom_bringer_21:IsPurgable() return false end
function modifier_doom_bringer_21:IsPurgeException() return false end
function modifier_doom_bringer_21:RemoveOnDeath() return false end

function modifier_doom_bringer_21:OnCreated()
    self.bonus = 2
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local doom_bringer_devour_custom = self:GetParent():FindAbilityByName("doom_bringer_devour_custom")
        if doom_bringer_devour_custom then
            doom_bringer_devour_custom:RefreshCharges()
        end
    end)
end

function modifier_doom_bringer_21:OnRefresh()
    self.bonus = 2
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local doom_bringer_devour_custom = self:GetParent():FindAbilityByName("doom_bringer_devour_custom")
        if doom_bringer_devour_custom then
            doom_bringer_devour_custom:RefreshCharges()
        end
    end)
end

function modifier_doom_bringer_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_doom_bringer_21:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "doom_bringer_devour_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_doom_bringer_21:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "doom_bringer_devour_custom" and data.ability_special_value == "AbilityCharges" then
        return self.bonus
    end
end