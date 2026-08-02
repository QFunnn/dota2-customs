--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_kez_14 = class({})

function modifier_kez_14:IsHidden()
	return true
end
function modifier_kez_14:IsPurgable()
	return false
end
function modifier_kez_14:IsPurgeException()
	return false
end
function modifier_kez_14:RemoveOnDeath()
	return false
end

function modifier_kez_14:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_kez_14:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end