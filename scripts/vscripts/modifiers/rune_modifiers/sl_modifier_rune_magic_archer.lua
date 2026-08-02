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
--- 每点智力提升{amp_per_int}%技能增强，每点智力或敏捷提升{batk_per_int_agi}基础攻击力
____exports.sl_modifier_rune_magic_archer = __TS__Class()
local sl_modifier_rune_magic_archer = ____exports.sl_modifier_rune_magic_archer
sl_modifier_rune_magic_archer.name = "sl_modifier_rune_magic_archer"
__TS__ClassExtends(sl_modifier_rune_magic_archer, sl_modifier_rune_base)
function sl_modifier_rune_magic_archer.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE }
end
function sl_modifier_rune_magic_archer.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_magic_archer.prototype.GetModifierBaseAttack_BonusDamage(self)
	local int_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	local agi_atk = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_atk",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("batk_per_int_agi")
		end
	)
	return int_atk + agi_atk
end
sl_modifier_rune_magic_archer = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_magic_archer") },
	sl_modifier_rune_magic_archer
)
____exports.sl_modifier_rune_magic_archer = sl_modifier_rune_magic_archer
return ____exports