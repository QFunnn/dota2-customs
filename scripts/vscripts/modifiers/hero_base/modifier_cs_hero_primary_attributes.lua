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
local __TS__ArrayPush = ____lualib.__TS__ArrayPush
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____base_hero_ability = require("abilities.hero._base_hero_ability")
local BaseHeroModifier = _____base_hero_ability.BaseHeroModifier
local ____const = require("shared.const")
local ATTR_PRIMARY_BONUS = ____const.ATTR_PRIMARY_BONUS
local CalculateAgilityAttackSpeed = ____const.CalculateAgilityAttackSpeed
local CalculateIntelligenceMagicResistance = ____const.CalculateIntelligenceMagicResistance
--- 英雄主属性加成：将力量/敏捷/智力转化为攻击力、生命、护甲、魔抗等自定义属性加成。
-- 所有引擎原生加成已由 modifier_cs_hero_attribute_bonus 抵消，这里负责补上自定义规则。
____exports.modifier_cs_hero_primary_attributes = __TS__Class()
local modifier_cs_hero_primary_attributes = ____exports.modifier_cs_hero_primary_attributes
modifier_cs_hero_primary_attributes.name = "modifier_cs_hero_primary_attributes"
__TS__ClassExtends(modifier_cs_hero_primary_attributes, BaseHeroModifier)
function modifier_cs_hero_primary_attributes.prototype.____constructor(self, ...)
	BaseHeroModifier.prototype.____constructor(self, ...)
	self._unregisterFns = {}
end
function modifier_cs_hero_primary_attributes.prototype.IsHidden(self)
	return true
end
function modifier_cs_hero_primary_attributes.prototype.IsPurgable(self)
	return false
end
function modifier_cs_hero_primary_attributes.prototype.IsPermanent(self)
	return true
end
function modifier_cs_hero_primary_attributes.prototype.RemoveOnDeath(self)
	return false
end
function modifier_cs_hero_primary_attributes.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	__TS__ArrayPush(
		self._unregisterFns,
		MyGameAttribute:RegisterAttributeChangeHandler("total_strength", function(____, unit)
			if unit == self:GetParent() then
				self:StartIntervalThink(0.5)
			end
		end),
		MyGameAttribute:RegisterAttributeChangeHandler("total_agility", function(____, unit)
			if unit == self:GetParent() then
				self:StartIntervalThink(0.5)
			end
		end),
		MyGameAttribute:RegisterAttributeChangeHandler("total_intelligence", function(____, unit)
			if unit == self:GetParent() then
				self:StartIntervalThink(0.5)
			end
		end)
	)
end
function modifier_cs_hero_primary_attributes.prototype.OnIntervalThink(self)
	self:RefreshAttributes()
	self:StartIntervalThink(-1)
end
function modifier_cs_hero_primary_attributes.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	for ____, fn in ipairs(self._unregisterFns) do
		fn(nil)
	end
	self._unregisterFns = {}
end
function modifier_cs_hero_primary_attributes.prototype.GetAttributeBonus(self)
	local parent = self:GetParent()
	if not IsServer() or not IsValid(nil, parent) or not parent:IsHero() then
		return {}
	end
	local hero = parent
	local totalStr = MyGameAttribute:GetAttribute(hero, "total_strength") or 0
	local totalAgi = MyGameAttribute:GetAttribute(hero, "total_agility") or 0
	local totalInt = MyGameAttribute:GetAttribute(hero, "total_intelligence") or 0
	local primary = hero:GetPrimaryAttribute()
	local ____temp_2
	if primary == 0 then
		____temp_2 = totalStr
	else
		local ____temp_1
		if primary == 1 then
			____temp_1 = totalAgi
		else
			local ____temp_0
			if primary == 2 then
				____temp_0 = totalInt
			else
				____temp_0 = totalStr + totalAgi + totalInt
			end
			____temp_1 = ____temp_0
		end
		____temp_2 = ____temp_1
	end
	local primaryTotal = ____temp_2
	local ____temp_3
	if primary == 3 then
		____temp_3 = primaryTotal * ATTR_PRIMARY_BONUS.universal_attr_attack_damage
	else
		____temp_3 = primaryTotal * ATTR_PRIMARY_BONUS.primary_attr_attack_damage
	end
	local primaryAttackBonus = ____temp_3
	local strengthHealthBonus = totalStr * ATTR_PRIMARY_BONUS.strength_health
	local strengthRegenBonus = totalStr * ATTR_PRIMARY_BONUS.strength_health_regen
	local agilityAttackSpeedBonus = CalculateAgilityAttackSpeed(nil, totalAgi)
	local agilityArmorBonus = totalAgi * ATTR_PRIMARY_BONUS.agility_armor
	local intelligenceManaBonus = totalInt * ATTR_PRIMARY_BONUS.intelligence_mana
	local intelligenceManaRegenBonus = totalInt * ATTR_PRIMARY_BONUS.intelligence_mana_regen
	local intelligenceMagicResBonus = CalculateIntelligenceMagicResistance(nil, totalInt)
	local bonus = {
		base_attack_damage = primaryAttackBonus,
		base_health = strengthHealthBonus,
		health_regen = strengthRegenBonus,
		attack_speed = agilityAttackSpeedBonus,
		base_armor = agilityArmorBonus,
		base_mana = intelligenceManaBonus,
		mana_regen = intelligenceManaRegenBonus,
		base_magic_resistance = intelligenceMagicResBonus,
	}
	return bonus
end
modifier_cs_hero_primary_attributes = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_cs_hero_primary_attributes") },
	modifier_cs_hero_primary_attributes
)
____exports.modifier_cs_hero_primary_attributes = modifier_cs_hero_primary_attributes
return ____exports