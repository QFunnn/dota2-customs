--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_crystal_maiden_1 = class({})

function modifier_crystal_maiden_1:IsHidden()
	return true
end
function modifier_crystal_maiden_1:IsPurgable()
	return false
end
function modifier_crystal_maiden_1:IsPurgeException()
	return false
end
function modifier_crystal_maiden_1:RemoveOnDeath()
	return false
end

function modifier_crystal_maiden_1:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_crystal_maiden_1:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end