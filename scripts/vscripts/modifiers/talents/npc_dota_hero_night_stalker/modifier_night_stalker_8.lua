--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_night_stalker_8=class({})

function modifier_night_stalker_8:IsHidden() return true end
function modifier_night_stalker_8:IsPurgable() return false end
function modifier_night_stalker_8:IsPurgeException() return false end
function modifier_night_stalker_8:RemoveOnDeath() return false end

function modifier_night_stalker_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local night_stalker_hunter_in_the_day = self:GetCaster():AddAbility("night_stalker_hunter_in_the_day")
    if night_stalker_hunter_in_the_day then
        night_stalker_hunter_in_the_day:SetLevel(self:GetStackCount())
    end
    local night_stalker_hunter_in_the_night_custom = self:GetCaster():FindAbilityByName("night_stalker_hunter_in_the_night_custom")
    if night_stalker_hunter_in_the_night_custom then
        night_stalker_hunter_in_the_night_custom:SetLevel(0)
    end
    self:GetParent():RemoveModifierByName("modifier_night_stalker_hunter_in_the_night_custom")
    self:GetParent():RemoveModifierByName("modifier_night_stalker_hunter_in_the_night_custom_buff")
    self:GetParent():SwapAbilities("night_stalker_hunter_in_the_night_custom", "night_stalker_hunter_in_the_day", false, true)
    local night_stalker_hunter_in_the_night_custom = self:GetCaster():FindAbilityByName("night_stalker_hunter_in_the_night_custom")
    if night_stalker_hunter_in_the_night_custom then
        UTIL_Remove(night_stalker_hunter_in_the_night_custom)
    end
end

function modifier_night_stalker_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local night_stalker_hunter_in_the_day = self:GetCaster():FindAbilityByName("night_stalker_hunter_in_the_day")
    if night_stalker_hunter_in_the_day then
        night_stalker_hunter_in_the_day:SetLevel(self:GetStackCount())
    end
end