--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_faceless_void_2 = class({})

function modifier_faceless_void_2:IsHidden()
	return true
end
function modifier_faceless_void_2:IsPurgable()
	return false
end
function modifier_faceless_void_2:IsPurgeException()
	return false
end
function modifier_faceless_void_2:RemoveOnDeath()
	return false
end

function modifier_faceless_void_2:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_faceless_void_2:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end