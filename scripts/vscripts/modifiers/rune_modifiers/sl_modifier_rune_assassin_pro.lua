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
--- 每点敏捷提升{batk_per_agi}基础攻击力，总攻击力+{pct}%，生命值-{smI}%
____exports.sl_modifier_rune_assassin_pro = __TS__Class()
local sl_modifier_rune_assassin_pro = ____exports.sl_modifier_rune_assassin_pro
sl_modifier_rune_assassin_pro.name = "sl_modifier_rune_assassin_pro"
__TS__ClassExtends(sl_modifier_rune_assassin_pro, sl_modifier_rune_base)
function sl_modifier_rune_assassin_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end
function sl_modifier_rune_assassin_pro.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_assassin_pro.prototype.GetModifierDamageOutgoing_Percentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_assassin_pro.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetRuneSpecialValue("smI")
end
sl_modifier_rune_assassin_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_assassin_pro") },
	sl_modifier_rune_assassin_pro
)
____exports.sl_modifier_rune_assassin_pro = sl_modifier_rune_assassin_pro
return ____exports