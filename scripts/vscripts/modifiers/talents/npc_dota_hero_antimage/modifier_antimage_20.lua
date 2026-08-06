--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_antimage_20 = class({})

function modifier_antimage_20:IsHidden()
	return true
end
function modifier_antimage_20:IsPurgable()
	return false
end
function modifier_antimage_20:IsPurgeException()
	return false
end
function modifier_antimage_20:RemoveOnDeath()
	return false
end

function modifier_antimage_20:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_antimage_20:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end