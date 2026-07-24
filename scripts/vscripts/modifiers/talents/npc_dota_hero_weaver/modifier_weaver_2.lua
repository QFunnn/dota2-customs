--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_weaver_2=class({})

function modifier_weaver_2:IsHidden() return true end
function modifier_weaver_2:IsPurgable() return false end
function modifier_weaver_2:IsPurgeException() return false end
function modifier_weaver_2:RemoveOnDeath() return false end

function modifier_weaver_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local weaver_the_swarm_custom = self:GetCaster():FindAbilityByName("weaver_the_swarm_custom")
    if weaver_the_swarm_custom then
        weaver_the_swarm_custom:SetActivated(false)
        weaver_the_swarm_custom:SetHidden(true)
    end
    local weaver_auto_swarm = self:GetCaster():FindAbilityByName("weaver_auto_swarm")
    if weaver_auto_swarm then
        weaver_auto_swarm:SetHidden(true)
    end
end

function modifier_weaver_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local weaver_the_swarm_custom = self:GetCaster():FindAbilityByName("weaver_the_swarm_custom")
    if weaver_the_swarm_custom then
        weaver_the_swarm_custom:SetActivated(false)
        weaver_the_swarm_custom:SetHidden(true)
    end
    local weaver_auto_swarm = self:GetCaster():FindAbilityByName("weaver_auto_swarm")
    if weaver_auto_swarm then
        weaver_auto_swarm:SetHidden(true)
    end
end