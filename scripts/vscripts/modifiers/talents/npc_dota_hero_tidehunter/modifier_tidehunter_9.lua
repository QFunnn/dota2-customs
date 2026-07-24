--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tidehunter_9=class({})

function modifier_tidehunter_9:IsHidden() return true end
function modifier_tidehunter_9:IsPurgable() return false end
function modifier_tidehunter_9:IsPurgeException() return false end
function modifier_tidehunter_9:RemoveOnDeath() return false end

function modifier_tidehunter_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local tidehunter_dead_in_the_water = self:GetCaster():FindAbilityByName("tidehunter_dead_in_the_water")
    if tidehunter_dead_in_the_water then
        tidehunter_dead_in_the_water:SetHidden(false)
        tidehunter_dead_in_the_water:SetLevel(1)
    end
end

function modifier_tidehunter_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end