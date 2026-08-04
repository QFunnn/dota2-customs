--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_void_spirit_3 = class({})

function modifier_void_spirit_3:IsHidden()
	return true
end
function modifier_void_spirit_3:IsPurgable()
	return false
end
function modifier_void_spirit_3:IsPurgeException()
	return false
end
function modifier_void_spirit_3:RemoveOnDeath()
	return false
end

function modifier_void_spirit_3:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_void_spirit_3:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end