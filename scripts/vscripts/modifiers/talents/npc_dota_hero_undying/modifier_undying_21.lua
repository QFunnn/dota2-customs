--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_21 = class({})

function modifier_undying_21:IsHidden() return true end
function modifier_undying_21:IsPurgable() return false end
function modifier_undying_21:IsPurgeException() return false end
function modifier_undying_21:RemoveOnDeath() return false end

function modifier_undying_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    Timers:CreateTimer(0.1, function()
        local undying_tombstone_custom = self:GetParent():FindAbilityByName("undying_tombstone_custom")
        if undying_tombstone_custom then
            undying_tombstone_custom:RefreshCharges()
        end
    end)
end

function modifier_undying_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    Timers:CreateTimer(0.1, function()
        local undying_tombstone_custom = self:GetParent():FindAbilityByName("undying_tombstone_custom")
        if undying_tombstone_custom then
            undying_tombstone_custom:RefreshCharges()
        end
    end)
end

function modifier_undying_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end

function modifier_undying_21:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "undying_tombstone_custom" and data.ability_special_value == "AbilityCharges" then
        return 1
    end
end

function modifier_undying_21:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "undying_tombstone_custom" and data.ability_special_value == "AbilityCharges" then
        return 2
    end
end