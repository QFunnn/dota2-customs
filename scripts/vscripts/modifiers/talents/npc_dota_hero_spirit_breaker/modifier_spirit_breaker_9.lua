--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_spirit_breaker_9 = class({})

function modifier_spirit_breaker_9:IsHidden()
	return true
end
function modifier_spirit_breaker_9:IsPurgable()
	return false
end
function modifier_spirit_breaker_9:IsPurgeException()
	return false
end
function modifier_spirit_breaker_9:RemoveOnDeath()
	return false
end

function modifier_spirit_breaker_9:OnCreated()
	self.bonus = { 1.8, 1.75, 1.7 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_spirit_breaker_9:OnRefresh()
	self.bonus = { 1.8, 1.75, 1.7 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_spirit_breaker_9:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
	}
end

function modifier_spirit_breaker_9:GetModifierBaseAttackTimeConstant()
	return self.bonus[self:GetStackCount()]
end