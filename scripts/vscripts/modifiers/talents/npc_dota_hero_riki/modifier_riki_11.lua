--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_riki_11=class({})

function modifier_riki_11:IsHidden() return true end
function modifier_riki_11:IsPurgable() return false end
function modifier_riki_11:IsPurgeException() return false end
function modifier_riki_11:RemoveOnDeath() return false end

function modifier_riki_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_riki_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end