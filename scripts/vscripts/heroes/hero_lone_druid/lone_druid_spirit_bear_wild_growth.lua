--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lone_druid_spirit_bear_wild_growth", "heroes/hero_lone_druid/lone_druid_spirit_bear_wild_growth.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if lone_druid_spirit_bear_wild_growth == nil then
	lone_druid_spirit_bear_wild_growth = class({})
end
function lone_druid_spirit_bear_wild_growth:GetIntrinsicModifierName()
	return "modifier_lone_druid_spirit_bear_wild_growth"
end
function lone_druid_spirit_bear_wild_growth:Spawn()
	if IsServer() then
		self:SetLevel(1)
	end
end
---------------------------------------------------------------------
--Modifiers
if modifier_lone_druid_spirit_bear_wild_growth == nil then
	modifier_lone_druid_spirit_bear_wild_growth = class({})
end
function modifier_lone_druid_spirit_bear_wild_growth:IsDebuff()
	return false
end
function modifier_lone_druid_spirit_bear_wild_growth:IsHidden()
	return true
end
function modifier_lone_druid_spirit_bear_wild_growth:IsPurgable()
	return false
end
function modifier_lone_druid_spirit_bear_wild_growth:IsPurgeException()
	return false
end
function modifier_lone_druid_spirit_bear_wild_growth:RemoveOnDeath()
	return false
end
function modifier_lone_druid_spirit_bear_wild_growth:OnCreated(params)
	self.bonus_attr = self:GetAbilitySpecialValueFor("bonus_attr")
	if IsServer() then
	end
end
function modifier_lone_druid_spirit_bear_wild_growth:OnRefresh(params)
	self.bonus_attr = self:GetAbilitySpecialValueFor("bonus_attr")
	if IsServer() then
	end
end
function modifier_lone_druid_spirit_bear_wild_growth:OnDestroy()
	if IsServer() then
	end
end
function modifier_lone_druid_spirit_bear_wild_growth:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}
end
function modifier_lone_druid_spirit_bear_wild_growth:GetModifierBonusStats_Agility()
	local hParent = self:GetParent()
	return (hParent:GetLevel() - 1) * self.bonus_attr
end
function modifier_lone_druid_spirit_bear_wild_growth:GetModifierBonusStats_Intellect()
	local hParent = self:GetParent()
	return (hParent:GetLevel() - 1) * self.bonus_attr
end
function modifier_lone_druid_spirit_bear_wild_growth:GetModifierBonusStats_Strength()
	local hParent = self:GetParent()
	return (hParent:GetLevel() - 1) * self.bonus_attr
end