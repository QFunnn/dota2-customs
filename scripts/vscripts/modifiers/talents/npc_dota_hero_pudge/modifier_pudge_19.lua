--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_19 = class({})

function modifier_pudge_19:IsHidden()
	return true
end
function modifier_pudge_19:IsPurgable()
	return false
end
function modifier_pudge_19:IsPurgeException()
	return false
end
function modifier_pudge_19:RemoveOnDeath()
	return false
end

function modifier_pudge_19:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_pudge_19:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end