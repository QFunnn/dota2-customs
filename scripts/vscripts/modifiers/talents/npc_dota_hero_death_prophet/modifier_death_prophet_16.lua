--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_death_prophet_16=class({})

function modifier_death_prophet_16:IsHidden() return true end
function modifier_death_prophet_16:IsPurgable() return false end
function modifier_death_prophet_16:IsPurgeException() return false end
function modifier_death_prophet_16:RemoveOnDeath() return false end

function modifier_death_prophet_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_death_prophet_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end