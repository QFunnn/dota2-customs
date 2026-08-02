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
--- 每点敏捷提升{batk_per_agi}基础攻击力，每点敏捷或力量提升{hp_per_agi_str}生命值
____exports.sl_modifier_rune_ranger = __TS__Class()
local sl_modifier_rune_ranger = ____exports.sl_modifier_rune_ranger
sl_modifier_rune_ranger.name = "sl_modifier_rune_ranger"
__TS__ClassExtends(sl_modifier_rune_ranger, sl_modifier_rune_base)
function sl_modifier_rune_ranger.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_rune_ranger.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_ranger.prototype.GetModifierHealthBonus(self)
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
sl_modifier_rune_ranger = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_ranger") },
	sl_modifier_rune_ranger
)
____exports.sl_modifier_rune_ranger = sl_modifier_rune_ranger
return ____exports