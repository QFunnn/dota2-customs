--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_night_stalker_9=class({})

function modifier_night_stalker_9:IsHidden() return true end
function modifier_night_stalker_9:IsPurgable() return false end
function modifier_night_stalker_9:IsPurgeException() return false end
function modifier_night_stalker_9:RemoveOnDeath() return false end

function modifier_night_stalker_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local night_stalker_revelation = self:GetCaster():FindAbilityByName("night_stalker_revelation")
    if night_stalker_revelation then
        night_stalker_revelation:SetLevel(self:GetStackCount())
    end
    local night_stalker_void_custom = self:GetCaster():FindAbilityByName("night_stalker_void_custom")
    if night_stalker_void_custom then
        night_stalker_void_custom:SetLevel(0)
    end
    self:GetParent():SwapAbilities("night_stalker_void_custom", "night_stalker_revelation", false, true)
end

function modifier_night_stalker_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local night_stalker_revelation = self:GetCaster():FindAbilityByName("night_stalker_revelation")
    if night_stalker_revelation then
        night_stalker_revelation:SetLevel(self:GetStackCount())
    end
end