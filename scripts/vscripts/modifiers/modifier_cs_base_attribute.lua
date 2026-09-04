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
--- 所有使用应用的基础modifier 勿用
____exports.modifier_cs_base_attribute = __TS__Class()
local modifier_cs_base_attribute = ____exports.modifier_cs_base_attribute
modifier_cs_base_attribute.name = "modifier_cs_base_attribute"
__TS__ClassExtends(modifier_cs_base_attribute, BaseModifier)
function modifier_cs_base_attribute.prototype.IsDebuff(self)
	return false
end
function modifier_cs_base_attribute.prototype.IsHidden(self)
	return true
end
function modifier_cs_base_attribute.prototype.IsPurgable(self)
	return false
end
function modifier_cs_base_attribute.prototype.IsPurgeException(self)
	return false
end
function modifier_cs_base_attribute.prototype.IsPermanent(self)
	return true
end
function modifier_cs_base_attribute.prototype.RemoveOnDeath(self)
	return false
end
function modifier_cs_base_attribute.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MISS_PERCENTAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
		MODIFIER_PROPERTY_MOVESPEED_MIN_OVERRIDE,
		MODIFIER_PROPERTY_MOVESPEED_MAX_OVERRIDE,
	}
end
function modifier_cs_base_attribute.prototype.GetModifierMoveSpeed_MaxOverride(self)
	return 700
end
function modifier_cs_base_attribute.prototype.GetModifierMoveSpeed_MinOverride(self)
	return 5
end
function modifier_cs_base_attribute.prototype.GetModifierMiss_Percentage(self)
	return 500
end
function modifier_cs_base_attribute.prototype.GetModifierHealthBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_HEALTH_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._base_attribute = params
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_cs_base_attribute.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._base_attribute = params
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function modifier_cs_base_attribute.prototype.AddCustomTransmitterData(self)
	return self._base_attribute
end
function modifier_cs_base_attribute.prototype.HandleCustomTransmitterData(self, data)
	self._base_attribute = data
end
function modifier_cs_base_attribute.prototype.GetModifierConstantHealthRegen(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierAttackSpeedBonus_Constant(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierPreAttack_BonusDamage(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierAttackRangeBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_ATTACK_RANGE_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierCastRangeBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_CAST_RANGE_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierBonusStats_Strength(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_STATS_STRENGTH_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierBonusStats_Agility(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_STATS_AGILITY_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierBonusStats_Intellect(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_STATS_INTELLECT_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierSpellAmplify_Percentage(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierConstantManaRegen(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_MANA_REGEN_CONSTANT)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierPhysicalArmorBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierMagicalResistanceBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierManaBonus(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_MANA_BONUS)] or 0
end
function modifier_cs_base_attribute.prototype.GetModifierPercentageManacostStacking(self)
	return self._base_attribute[tostring(MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING)] or 0
end
modifier_cs_base_attribute = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_cs_base_attribute)
____exports.modifier_cs_base_attribute = modifier_cs_base_attribute
return ____exports