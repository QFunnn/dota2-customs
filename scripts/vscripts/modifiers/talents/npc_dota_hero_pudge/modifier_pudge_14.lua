--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_pudge_14 = class({})

function modifier_pudge_14:IsHidden()
	return true
end
function modifier_pudge_14:IsPurgable()
	return false
end
function modifier_pudge_14:IsPurgeException()
	return false
end
function modifier_pudge_14:RemoveOnDeath()
	return false
end

function modifier_pudge_14:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_pudge_14:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end