--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tiny_8=class({})

function modifier_tiny_8:IsHidden() return true end
function modifier_tiny_8:IsPurgable() return false end
function modifier_tiny_8:IsPurgeException() return false end
function modifier_tiny_8:RemoveOnDeath() return false end

function modifier_tiny_8:OnCreated()
	self.bonus={1.5,3}
    self.bonus2={1.5,3}
	if not IsServer() then return end
    self.Strength = 0
    self.Agility = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_tiny_8:OnRefresh()
	self.bonus={1.5,3}
    self.bonus2={1.5,3}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_tiny_8:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
    }
end

function modifier_tiny_8:OnIntervalThink()
	if not IsServer() then return end
	self.Strength = 0
    self.Agility = 0
	self.Strength = self:GetParent():GetLevel() * self.bonus[self:GetStackCount()]
    self.Agility = self:GetParent():GetLevel() * self.bonus2[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
end

function modifier_tiny_8:GetModifierBonusStats_Strength()
	return self.Strength * (-1)
end

function modifier_tiny_8:GetModifierBonusStats_Agility()
	return self.Agility
end