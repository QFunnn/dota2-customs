--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点敏捷提升{batk_per_agi}基础攻击力，每点敏捷或力量提升{hp_per_agi_str}生命值，生命值和总攻击力+{pct}%，承受伤害+{csshI}%
____exports.sl_modifier_rune_ranger_pro = __TS__Class()
local sl_modifier_rune_ranger_pro = ____exports.sl_modifier_rune_ranger_pro
sl_modifier_rune_ranger_pro.name = "sl_modifier_rune_ranger_pro"
__TS__ClassExtends(sl_modifier_rune_ranger_pro, sl_modifier_rune_base)
function sl_modifier_rune_ranger_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function sl_modifier_rune_ranger_pro.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_ranger_pro.prototype.GetModifierHealthBonus(self)
	local agi_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_agi_str")
		end
	)
	local str_hp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_hp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("hp_per_agi_str")
		end
	)
	return agi_hp + str_hp
end
function sl_modifier_rune_ranger_pro.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_ranger_pro.prototype.GetModifierDamageOutgoing_Percentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_ranger_pro.prototype.GetModifierIncomingDamage_Percentage(self)
	return self:_GetRuneSpecialValue("csshI")
end
sl_modifier_rune_ranger_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_ranger_pro") },
	sl_modifier_rune_ranger_pro
)
____exports.sl_modifier_rune_ranger_pro = sl_modifier_rune_ranger_pro
return ____exports