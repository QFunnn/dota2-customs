--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_night_stalker_6 = class({})

function modifier_night_stalker_6:IsHidden()
	return true
end
function modifier_night_stalker_6:IsPurgable()
	return false
end
function modifier_night_stalker_6:IsPurgeException()
	return false
end
function modifier_night_stalker_6:RemoveOnDeath()
	return false
end

function modifier_night_stalker_6:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_night_stalker_6:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end