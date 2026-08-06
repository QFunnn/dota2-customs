--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_windrunner_22 = class({})

function modifier_windrunner_22:IsHidden()
	return true
end
function modifier_windrunner_22:IsPurgable()
	return false
end
function modifier_windrunner_22:IsPurgeException()
	return false
end
function modifier_windrunner_22:RemoveOnDeath()
	return false
end

function modifier_windrunner_22:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_windrunner_22:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end