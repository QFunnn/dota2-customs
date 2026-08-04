--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_arc_warden_12 = class({})

function modifier_arc_warden_12:IsHidden()
	return true
end
function modifier_arc_warden_12:IsPurgable()
	return false
end
function modifier_arc_warden_12:IsPurgeException()
	return false
end
function modifier_arc_warden_12:RemoveOnDeath()
	return false
end

function modifier_arc_warden_12:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_arc_warden_12:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end