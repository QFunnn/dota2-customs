--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_10=class({})

function modifier_razor_10:IsHidden() return true end
function modifier_razor_10:IsPurgable() return false end
function modifier_razor_10:IsPurgeException() return false end
function modifier_razor_10:RemoveOnDeath() return false end

function modifier_razor_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local razor_armor_link_custom = self:GetParent():FindAbilityByName("razor_armor_link_custom")
    if razor_armor_link_custom then
        razor_armor_link_custom:SetLevel(self:GetStackCount())
    end
    local razor_eye_of_the_storm_custom = self:GetParent():FindAbilityByName("razor_eye_of_the_storm_custom")
    if razor_eye_of_the_storm_custom then
        razor_eye_of_the_storm_custom:SetActivated(false)
        razor_eye_of_the_storm_custom:SetHidden(true)
    end
    self:GetCaster():SwapAbilities("razor_eye_of_the_storm_custom", "razor_armor_link_custom", false, true)
end

function modifier_razor_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local razor_armor_link_custom = self:GetParent():FindAbilityByName("razor_armor_link_custom")
    if razor_armor_link_custom then
        razor_armor_link_custom:SetLevel(self:GetStackCount())
    end
end