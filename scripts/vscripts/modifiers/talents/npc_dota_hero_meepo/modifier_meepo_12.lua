--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_meepo_12=class({})

function modifier_meepo_12:IsHidden() return true end
function modifier_meepo_12:IsPurgable() return false end
function modifier_meepo_12:IsPurgeException() return false end
function modifier_meepo_12:RemoveOnDeath() return false end

function modifier_meepo_12:OnCreated()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_meepo_12:OnRefresh()
	self.bonus={10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_meepo_12:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_meepo_12:GetModifierBonusStats_Strength()
	return self.bonus[self:GetStackCount()]
end