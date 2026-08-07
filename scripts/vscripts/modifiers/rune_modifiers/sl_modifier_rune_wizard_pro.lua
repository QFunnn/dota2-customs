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
--- 每点智力提升{amp_per_int}%技能增强，冷却时间减少+{pct}%，生命值-{smI}%
____exports.sl_modifier_rune_wizard_pro = __TS__Class()
local sl_modifier_rune_wizard_pro = ____exports.sl_modifier_rune_wizard_pro
sl_modifier_rune_wizard_pro.name = "sl_modifier_rune_wizard_pro"
__TS__ClassExtends(sl_modifier_rune_wizard_pro, sl_modifier_rune_base)
function sl_modifier_rune_wizard_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end
function sl_modifier_rune_wizard_pro.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_wizard_pro.prototype.GetModifierPercentageCooldown(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_wizard_pro.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetRuneSpecialValue("smI")
end
sl_modifier_rune_wizard_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_wizard_pro") },
	sl_modifier_rune_wizard_pro
)
____exports.sl_modifier_rune_wizard_pro = sl_modifier_rune_wizard_pro
return ____exports