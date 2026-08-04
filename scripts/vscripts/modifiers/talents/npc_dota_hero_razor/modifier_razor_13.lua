--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_13 = class({})

function modifier_razor_13:IsHidden()
	return true
end
function modifier_razor_13:IsPurgable()
	return false
end
function modifier_razor_13:IsPurgeException()
	return false
end
function modifier_razor_13:RemoveOnDeath()
	return false
end

function modifier_razor_13:OnCreated()
	if not IsServer() then
		return
	end
	self.bonus = { 400 }
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_razor_13:OnRefresh()
	if not IsServer() then
		return
	end
	self.bonus = { 400 }
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_razor_13:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
end

function modifier_razor_13:GetModifierHealthBonus()
	return self.bonus[self:GetStackCount()]
end