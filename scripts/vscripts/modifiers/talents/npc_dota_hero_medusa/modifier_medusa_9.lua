--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_9 = class({})

function modifier_medusa_9:IsHidden()
	return true
end
function modifier_medusa_9:IsPurgable()
	return false
end
function modifier_medusa_9:IsPurgeException()
	return false
end
function modifier_medusa_9:RemoveOnDeath()
	return false
end

function modifier_medusa_9:OnCreated()
	if not IsServer() then
		return
	end
	self.bonus = { 100, 200, 300 }
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_medusa_9:OnRefresh()
	if not IsServer() then
		return
	end
	self.bonus = { 100, 200, 300 }
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_medusa_9:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end

function modifier_medusa_9:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end