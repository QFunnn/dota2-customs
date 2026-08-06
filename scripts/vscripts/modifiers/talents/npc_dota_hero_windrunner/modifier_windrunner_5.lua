--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_windrunner_5 = class({})

function modifier_windrunner_5:IsHidden()
	return true
end
function modifier_windrunner_5:IsPurgable()
	return false
end
function modifier_windrunner_5:IsPurgeException()
	return false
end
function modifier_windrunner_5:RemoveOnDeath()
	return false
end

function modifier_windrunner_5:OnCreated()
	self.bonus1 = { 300 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_windrunner_5:OnRefresh()
	self.bonus1 = { 300 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_windrunner_5:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end

function modifier_windrunner_5:GetModifierAttackRangeBonus()
	if self.bonus1 == nil and self:GetStackCount() == 0 then
		return
	end
	return self.bonus1[self:GetStackCount()]
end