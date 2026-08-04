--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_5 = class({})

function modifier_tiny_5:IsHidden()
	return true
end
function modifier_tiny_5:IsPurgable()
	return false
end
function modifier_tiny_5:IsPurgeException()
	return false
end
function modifier_tiny_5:RemoveOnDeath()
	return false
end

function modifier_tiny_5:OnCreated()
	self.crit_damage = { 120, 140, 160 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_tiny_5:OnRefresh()
	self.crit_damage = { 120, 140, 160 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tiny_5:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
	}
end

function modifier_tiny_5:GetModifierPreAttack_CriticalStrike(params)
	if not IsServer() then
		return
	end
	if RollPercentage(20) then
		return self.crit_damage[self:GetStackCount()]
	end
end