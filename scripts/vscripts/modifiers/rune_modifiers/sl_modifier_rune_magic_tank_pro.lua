--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
--- 每点力量提升{hp_per_str}生命值，每点力量或智力提升{amp_per_str_int}%技能增强，生命值和伤害输出+{pct}%，承受伤害+{csshI}%
____exports.sl_modifier_rune_magic_tank_pro = __TS__Class()
local sl_modifier_rune_magic_tank_pro = ____exports.sl_modifier_rune_magic_tank_pro
sl_modifier_rune_magic_tank_pro.name = "sl_modifier_rune_magic_tank_pro"
__TS__ClassExtends(sl_modifier_rune_magic_tank_pro, sl_modifier_rune_base)
function sl_modifier_rune_magic_tank_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function sl_modifier_rune_magic_tank_pro.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_magic_tank_pro.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local str_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_STRENGTH,
		"str_amp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_str_int")
		end
	)
	local int_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_amp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_str_int")
		end
	)
	return str_amp + int_amp
end
function sl_modifier_rune_magic_tank_pro.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_magic_tank_pro.prototype.GetModifierTotalDamageOutgoing_Percentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_magic_tank_pro.prototype.GetModifierIncomingDamage_Percentage(self)
	return self:_GetRuneSpecialValue("csshI")
end
sl_modifier_rune_magic_tank_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_magic_tank_pro") },
	sl_modifier_rune_magic_tank_pro
)
____exports.sl_modifier_rune_magic_tank_pro = sl_modifier_rune_magic_tank_pro
return ____exports