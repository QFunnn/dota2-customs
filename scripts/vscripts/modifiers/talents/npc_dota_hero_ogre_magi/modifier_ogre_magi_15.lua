--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_15=class({})

function modifier_ogre_magi_15:IsHidden() return true end
function modifier_ogre_magi_15:IsPurgable() return false end
function modifier_ogre_magi_15:IsPurgeException() return false end
function modifier_ogre_magi_15:RemoveOnDeath() return false end

function modifier_ogre_magi_15:OnCreated()
	self.bonus_intellect = {10,20}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
	local ogre_magi_dumb_luck_custom = self:GetCaster():FindAbilityByName("ogre_magi_dumb_luck_custom")
	if ogre_magi_dumb_luck_custom then
		ogre_magi_dumb_luck_custom:SetHidden(true)
		ogre_magi_dumb_luck_custom:SetActivated(false)
	end
end

function modifier_ogre_magi_15:OnRefresh()
	self.bonus_intellect = {10,20}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_ogre_magi_15:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
end

function modifier_ogre_magi_15:GetModifierBonusStats_Intellect()
	return self.bonus_intellect[self:GetStackCount()]
end