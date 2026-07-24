--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_oracle_3=class({})

function modifier_oracle_3:IsHidden() return true end
function modifier_oracle_3:IsPurgable() return false end
function modifier_oracle_3:IsPurgeException() return false end
function modifier_oracle_3:RemoveOnDeath() return false end

function modifier_oracle_3:OnCreated()
	if not IsServer() then return end
	self.bonus={-3,-6,-9}
	self.bonus2={4,8,12}
	self:SetStackCount(1)
	self.Strength = 0
	self:GetParent():CalculateStatBonus(true)
	self:StartIntervalThink(0.1)
end

function modifier_oracle_3:OnRefresh()
	if not IsServer() then return end
	self.bonus={-3,-6,-9}
	self.bonus2={4,8,12}
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_oracle_3:OnIntervalThink()
	if not IsServer() then return end
	self.Strength = 0
	self.Strength = self:GetParent():GetStrength() / 100 * self.bonus2[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
end

function modifier_oracle_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS
	}
end

function modifier_oracle_3:GetModifierExtraHealthPercentage()
	return self.bonus[self:GetStackCount()]
end

function modifier_oracle_3:GetModifierBonusStats_Strength()
	return self.Strength
end