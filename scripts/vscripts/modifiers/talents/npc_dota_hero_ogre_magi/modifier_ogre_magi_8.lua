--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_8=class({})

function modifier_ogre_magi_8:IsHidden() return true end
function modifier_ogre_magi_8:IsPurgable() return false end
function modifier_ogre_magi_8:IsPurgeException() return false end
function modifier_ogre_magi_8:RemoveOnDeath() return false end

function modifier_ogre_magi_8:OnCreated()
	self.strength_per_level = {1,2}
	self.agility_per_level = {1,2}
	self.attack_speed = {10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_ogre_magi_8:OnRefresh()
	self.strength_per_level = {1,2}
	self.agility_per_level = {1,2}
	self.attack_speed = {10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_ogre_magi_8:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_ogre_magi_8:GetModifierBonusStats_Strength()
	return -self.strength_per_level[self:GetStackCount()] * self:GetParent():GetLevel()
end

function modifier_ogre_magi_8:GetModifierBonusStats_Agility()
	return self.agility_per_level[self:GetStackCount()] * self:GetParent():GetLevel()
end

function modifier_ogre_magi_8:GetModifierAttackSpeedBonus_Constant()
	return self.attack_speed[self:GetStackCount()]
end