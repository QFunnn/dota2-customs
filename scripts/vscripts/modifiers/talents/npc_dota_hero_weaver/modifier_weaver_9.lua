--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_weaver_9=class({})

function modifier_weaver_9:IsHidden() return true end
function modifier_weaver_9:IsPurgable() return false end
function modifier_weaver_9:IsPurgeException() return false end
function modifier_weaver_9:RemoveOnDeath() return false end

function modifier_weaver_9:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetCaster():HasModifier("modifier_weaver_2") then return end
    local weaver_auto_swarm = self:GetCaster():FindAbilityByName("weaver_auto_swarm")
    if weaver_auto_swarm then
        weaver_auto_swarm:SetLevel(self:GetStackCount())
        weaver_auto_swarm:SetHidden(false)
    end
end

function modifier_weaver_9:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    if self:GetCaster():HasModifier("modifier_weaver_2") then return end
    local weaver_auto_swarm = self:GetCaster():FindAbilityByName("weaver_auto_swarm")
    if weaver_auto_swarm then
        weaver_auto_swarm:SetLevel(self:GetStackCount())
        weaver_auto_swarm:SetHidden(false)
    end
end