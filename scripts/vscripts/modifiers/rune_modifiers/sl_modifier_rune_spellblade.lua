--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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
--- 每点敏捷提升{batk_per_agi}基础攻击力，每点敏捷或智力提升{amp_per_agi_int}%技能增强
____exports.sl_modifier_rune_spellblade = __TS__Class()
local sl_modifier_rune_spellblade = ____exports.sl_modifier_rune_spellblade
sl_modifier_rune_spellblade.name = "sl_modifier_rune_spellblade"
__TS__ClassExtends(sl_modifier_rune_spellblade, sl_modifier_rune_base)
function sl_modifier_rune_spellblade.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_rune_spellblade.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_spellblade.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local agi_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_AGILITY,
		"agi_amp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_agi_int")
		end
	)
	local int_amp = self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"int_amp",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_agi_int")
		end
	)
	return agi_amp + int_amp
end
sl_modifier_rune_spellblade = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_spellblade") },
	sl_modifier_rune_spellblade
)
____exports.sl_modifier_rune_spellblade = sl_modifier_rune_spellblade
return ____exports