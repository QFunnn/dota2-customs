--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_sniper_4 = class({})

function modifier_sniper_4:IsHidden()
	return true
end
function modifier_sniper_4:IsPurgable()
	return false
end
function modifier_sniper_4:IsPurgeException()
	return false
end
function modifier_sniper_4:RemoveOnDeath()
	return false
end

function modifier_sniper_4:OnCreated()
	self.bonus = { 10, 20 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_sniper_4:OnRefresh()
	self.bonus = { 10, 20 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_sniper_4:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
	}
end

function modifier_sniper_4:GetModifierStatusResistanceStacking()
	return self.bonus[self:GetStackCount()]
end