--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_necrolyte_10=class({})

function modifier_necrolyte_10:IsHidden() return true end
function modifier_necrolyte_10:IsPurgable() return false end
function modifier_necrolyte_10:IsPurgeException() return false end
function modifier_necrolyte_10:RemoveOnDeath() return false end

function modifier_necrolyte_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local necrolyte_death_seeker_custom = self:GetCaster():FindAbilityByName("necrolyte_death_seeker_custom")
    if necrolyte_death_seeker_custom then
        necrolyte_death_seeker_custom:SetHidden(false)
        necrolyte_death_seeker_custom:SetLevel(1)
    end
end

function modifier_necrolyte_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local necrolyte_death_seeker_custom = self:GetCaster():FindAbilityByName("necrolyte_death_seeker_custom")
    if necrolyte_death_seeker_custom then
        necrolyte_death_seeker_custom:SetHidden(false)
        necrolyte_death_seeker_custom:SetLevel(1)
    end
end