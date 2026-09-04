--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseModifier = ____dota_ts_adapter.BaseModifier
local registerModifier = ____dota_ts_adapter.registerModifier
--- 英雄属性抵消 modifier：仅抵消无法通过设置移除的三项引擎原生加成。
-- 生命、魔法、护甲、攻速等已可通过设置正常移除。
-- 同时移除黄点技能和 modifier_special_bonus_attributes。
--
-- 需抵消的原生加成：
-- - 力量：0.1 生命恢复/点
-- - 智力：0.05 魔法恢复/点，0.1% 魔法抗性/点
____exports.modifier_cs_hero_attribute_bonus = __TS__Class()
local modifier_cs_hero_attribute_bonus = ____exports.modifier_cs_hero_attribute_bonus
modifier_cs_hero_attribute_bonus.name = "modifier_cs_hero_attribute_bonus"
__TS__ClassExtends(modifier_cs_hero_attribute_bonus, BaseModifier)
function modifier_cs_hero_attribute_bonus.prototype.IsDebuff(self)
	return false
end
function modifier_cs_hero_attribute_bonus.prototype.IsHidden(self)
	return true
end
function modifier_cs_hero_attribute_bonus.prototype.IsPurgable(self)
	return false
end
function modifier_cs_hero_attribute_bonus.prototype.IsPermanent(self)
	return true
end
function modifier_cs_hero_attribute_bonus.prototype.RemoveOnDeath(self)
	return false
end
function modifier_cs_hero_attribute_bonus.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end
function modifier_cs_hero_attribute_bonus.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	self:RemoveNativeStats()
end
function modifier_cs_hero_attribute_bonus.prototype.RemoveNativeStats(self)
	local hero = self:GetParent()
	if not hero:IsHero() then
		return
	end
	local ability = hero:FindAbilityByName(____exports.modifier_cs_hero_attribute_bonus.STATS_ABILITY)
	if ability and IsValid(nil, ability) then
		if MyGameNetTableContentManager ~= nil then
			MyGameNetTableContentManager:RemoveAbility(hero, ability)
		end
		hero:RemoveAbility(____exports.modifier_cs_hero_attribute_bonus.STATS_ABILITY)
	end
	hero:RemoveModifierByName(____exports.modifier_cs_hero_attribute_bonus.STATS_MODIFIER)
end
function modifier_cs_hero_attribute_bonus.prototype.GetHero(self)
	local parent = self:GetParent()
	local ____parent_IsHero_result_2
	if parent:IsHero() then
		____parent_IsHero_result_2 = parent
	else
		____parent_IsHero_result_2 = nil
	end
	return ____parent_IsHero_result_2
end
function modifier_cs_hero_attribute_bonus.prototype.GetModifierConstantHealthRegen(self)
	local hero = self:GetHero()
	if not hero then
		return 0
	end
	local str = hero:GetStrength()
	return -(str * ____exports.modifier_cs_hero_attribute_bonus.HP_REGEN_PER_STR)
end
function modifier_cs_hero_attribute_bonus.prototype.GetModifierConstantManaRegen(self)
	local hero = self:GetHero()
	if not hero then
		return 0
	end
	local int = hero:GetIntellect(false)
	return -(int * ____exports.modifier_cs_hero_attribute_bonus.MANA_REGEN_PER_INT)
end
function modifier_cs_hero_attribute_bonus.prototype.GetModifierMagicalResistanceBonus(self)
	local hero = self:GetHero()
	if not hero then
		return 0
	end
	local int = hero:GetIntellect(false)
	return -(int * ____exports.modifier_cs_hero_attribute_bonus.MAGIC_RESIST_PER_INT)
end
modifier_cs_hero_attribute_bonus.HP_REGEN_PER_STR = 0.1
modifier_cs_hero_attribute_bonus.MANA_REGEN_PER_INT = 0.05
modifier_cs_hero_attribute_bonus.MAGIC_RESIST_PER_INT = 0.1
modifier_cs_hero_attribute_bonus.STATS_ABILITY = "special_bonus_attributes"
modifier_cs_hero_attribute_bonus.STATS_MODIFIER = "modifier_special_bonus_attributes"
modifier_cs_hero_attribute_bonus = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_cs_hero_attribute_bonus") },
	modifier_cs_hero_attribute_bonus
)
____exports.modifier_cs_hero_attribute_bonus = modifier_cs_hero_attribute_bonus
return ____exports