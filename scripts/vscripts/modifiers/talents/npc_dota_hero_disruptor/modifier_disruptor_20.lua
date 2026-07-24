--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_disruptor_20=class({})

function modifier_disruptor_20:IsHidden() return true end
function modifier_disruptor_20:IsPurgable() return false end
function modifier_disruptor_20:IsPurgeException() return false end
function modifier_disruptor_20:RemoveOnDeath() return false end

function modifier_disruptor_20:OnCreated()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_disruptor_20:OnRefresh()
	self.bonus={5,10,15}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_disruptor_20:OnIntervalThink()
	if not IsServer() then return end
	self.Intellect = 0
	self.Intellect = self:GetParent():GetIntellect(false) / 100 * self.bonus[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
end

function modifier_disruptor_20:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_disruptor_20:GetModifierBonusStats_Intellect()
	return self.Intellect
end