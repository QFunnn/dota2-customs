--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_meepo_15=class({})

function modifier_meepo_15:IsHidden() return true end
function modifier_meepo_15:IsPurgable() return false end
function modifier_meepo_15:IsPurgeException() return false end
function modifier_meepo_15:RemoveOnDeath() return false end

function modifier_meepo_15:OnCreated()
	self.bonus={3,6}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_meepo_15:OnRefresh()
	self.bonus={3,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_meepo_15:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_meepo_15:GetModifierBonusStats_Intellect()
	return self.bonus[self:GetStackCount()]
end