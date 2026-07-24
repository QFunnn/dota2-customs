--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_17=class({})

function modifier_bristleback_17:IsHidden() return true end
function modifier_bristleback_17:IsPurgable() return false end
function modifier_bristleback_17:IsPurgeException() return false end
function modifier_bristleback_17:RemoveOnDeath() return false end

function modifier_bristleback_17:OnCreated()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_bristleback_17:OnRefresh()
	self.bonus={5,10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_bristleback_17:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_bristleback_17:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end