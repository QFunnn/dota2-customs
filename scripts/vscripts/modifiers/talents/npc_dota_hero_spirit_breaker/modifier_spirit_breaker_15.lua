--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_15 = class({})

function modifier_spirit_breaker_15:IsHidden()
	return true
end
function modifier_spirit_breaker_15:IsPurgable()
	return false
end
function modifier_spirit_breaker_15:IsPurgeException()
	return false
end
function modifier_spirit_breaker_15:RemoveOnDeath()
	return false
end

function modifier_spirit_breaker_15:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_spirit_breaker_15:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end