--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


modifier_axe_18 = class({})

function modifier_axe_18:IsHidden()
	return true
end
function modifier_axe_18:IsPurgable()
	return false
end
function modifier_axe_18:IsPurgeException()
	return false
end
function modifier_axe_18:RemoveOnDeath()
	return false
end

function modifier_axe_18:OnCreated()
	self.bonus = { 10 }
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_axe_18:OnRefresh()
	self.bonus = { 10 }
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_axe_18:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_axe_18:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end