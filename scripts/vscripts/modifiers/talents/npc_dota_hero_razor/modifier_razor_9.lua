--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_9=class({})

function modifier_razor_9:IsHidden() return true end
function modifier_razor_9:IsPurgable() return false end
function modifier_razor_9:IsPurgeException() return false end
function modifier_razor_9:RemoveOnDeath() return false end

function modifier_razor_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local razor_magic_link_custom = self:GetParent():FindAbilityByName("razor_magic_link_custom")
    if razor_magic_link_custom then
        razor_magic_link_custom:SetLevel(self:GetStackCount())
    end
    local razor_storm_surge_custom = self:GetParent():FindAbilityByName("razor_storm_surge_custom")
    if razor_storm_surge_custom then
        razor_storm_surge_custom:SetActivated(false)
        razor_storm_surge_custom:SetHidden(true)
    end
    self:GetCaster():SwapAbilities("razor_storm_surge_custom", "razor_magic_link_custom", false, true)
end

function modifier_razor_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local razor_magic_link_custom = self:GetParent():FindAbilityByName("razor_magic_link_custom")
    if razor_magic_link_custom then
        razor_magic_link_custom:SetLevel(self:GetStackCount())
    end
end