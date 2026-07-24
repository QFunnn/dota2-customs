--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_2=class({})

function modifier_medusa_2:IsHidden() return true end
function modifier_medusa_2:IsPurgable() return false end
function modifier_medusa_2:IsPurgeException() return false end
function modifier_medusa_2:RemoveOnDeath() return false end

function modifier_medusa_2:OnCreated()
	self.bonus={1,2,3}
    self.bonus2={1,2,3}
    self.bonus3={4,8,12}
	if not IsServer() then return end
    self.Strength = 0
    self.Agility = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
end

function modifier_medusa_2:OnRefresh()
	self.bonus={1,2,3}
    self.bonus2={1,2,3}
    self.bonus3={4,8,12}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE
    }
end

function modifier_medusa_2:OnIntervalThink()
	if not IsServer() then return end
	self.Strength = 0
    self.Agility = 0
	self.Strength = self:GetParent():GetLevel() * self.bonus[self:GetStackCount()]
    self.Agility = self:GetParent():GetLevel() * self.bonus2[self:GetStackCount()]
	self:GetParent():CalculateStatBonus(true)
end

function modifier_medusa_2:GetModifierBonusStats_Strength()
	return self.Strength 
end

function modifier_medusa_2:GetModifierBonusStats_Agility()
	return self.Agility * (-1)
end

function modifier_medusa_2:GetModifierAttackSpeedPercentage()
	return self.bonus3[self:GetStackCount()]
end