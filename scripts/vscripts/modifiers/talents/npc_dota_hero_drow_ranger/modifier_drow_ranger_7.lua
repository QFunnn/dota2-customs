--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_7 = class({})

function modifier_drow_ranger_7:IsHidden()
	return true
end
function modifier_drow_ranger_7:IsPurgable()
	return false
end
function modifier_drow_ranger_7:IsPurgeException()
	return false
end
function modifier_drow_ranger_7:RemoveOnDeath()
	return false
end

function modifier_drow_ranger_7:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_drow_ranger_7:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end