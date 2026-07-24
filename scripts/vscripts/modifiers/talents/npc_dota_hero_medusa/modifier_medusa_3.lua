--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_3=class({})

function modifier_medusa_3:IsHidden() return true end
function modifier_medusa_3:IsPurgable() return false end
function modifier_medusa_3:IsPurgeException() return false end
function modifier_medusa_3:RemoveOnDeath() return false end

function modifier_medusa_3:OnCreated()
	self.bonus= 2
    self.bonus2= 2
    self.bonus3={150}
	if not IsServer() then return end
    self.Strength = 0
    self.Agility = 0
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
	self:StartIntervalThink(0.1)
end

function modifier_medusa_3:OnRefresh()
	self.bonus= 2
    self.bonus2= 2
    self.bonus3={150}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_medusa_3:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_medusa_3:OnIntervalThink()
	if not IsServer() then return end
	self.Strength = 0
    self.Agility = 0
	self.Strength = self:GetParent():GetLevel() * self.bonus
    self.Agility = self:GetParent():GetLevel() * self.bonus2
	self:GetParent():CalculateStatBonus(true)
end

function modifier_medusa_3:GetModifierBonusStats_Strength()
	return self.Strength 
end

function modifier_medusa_3:GetModifierBonusStats_Intellect()
	return self.Agility * (-1)
end

function modifier_medusa_3:GetModifierHealthBonus()
	return self.bonus3[self:GetStackCount()]
end