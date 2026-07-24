--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_16=class({})

function modifier_ogre_magi_16:IsHidden() return true end
function modifier_ogre_magi_16:IsPurgable() return false end
function modifier_ogre_magi_16:IsPurgeException() return false end
function modifier_ogre_magi_16:RemoveOnDeath() return false end

function modifier_ogre_magi_16:OnCreated()
	self.strength_per_level = 2
	self.intellect_per_level = 2
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_ogre_magi_16:OnRefresh()
	self.strength_per_level = 2
	self.intellect_per_level = 2
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_ogre_magi_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_ogre_magi_16:GetModifierBonusStats_Strength()
	return -self.strength_per_level * self:GetParent():GetLevel()
end

function modifier_ogre_magi_16:GetModifierBonusStats_Intellect()
	return self.intellect_per_level * self:GetParent():GetLevel()
end