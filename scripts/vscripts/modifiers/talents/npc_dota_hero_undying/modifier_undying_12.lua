--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_undying_12 = class({})

function modifier_undying_12:IsHidden()
	return true
end
function modifier_undying_12:IsPurgable()
	return false
end
function modifier_undying_12:IsPurgeException()
	return false
end
function modifier_undying_12:RemoveOnDeath()
	return false
end

function modifier_undying_12:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_undying_12:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end