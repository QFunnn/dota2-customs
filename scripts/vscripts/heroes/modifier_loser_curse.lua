--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_loser_curse = class({})

function modifier_loser_curse:GetTexture()
	return "doom_bringer_doom"
end

function modifier_loser_curse:IsHidden()
	return false
end

function modifier_loser_curse:IsDebuff()
	return true
end

function modifier_loser_curse:IsPurgable()
	return false
end

function modifier_loser_curse:IsPermanent()
	return true
end

function modifier_loser_curse:OnCreated()
    self.parent = self:GetParent()
end

function modifier_loser_curse:DeclareFunctions()
    local funcs = 
    {
       MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
       MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
       MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
       MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_loser_curse:GetModifierIncomingDamage_Percentage(params)
    if self.parent == nil or self.parent:IsNull() then return end
	if self.parent:IsUnitInPVP() then
		return 0
    end
	return 20 * self:GetStackCount()
end

function modifier_loser_curse:GetModifierBonusStats_Strength(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
	if self.parent:IsUnitInPVP() then
		return 0
    end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseStrength()
end

function modifier_loser_curse:GetModifierBonusStats_Agility(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
	if self.parent:IsUnitInPVP() then
		return 0
    end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseAgility()
end

function modifier_loser_curse:GetModifierBonusStats_Intellect(params)
    if not IsServer() or self.parent == nil or self.parent:IsNull() then return end
	if self.parent:IsUnitInPVP() then
		return 0
    end
    return -0.1 * self:GetStackCount() * self.parent:GetBaseIntellect()
end