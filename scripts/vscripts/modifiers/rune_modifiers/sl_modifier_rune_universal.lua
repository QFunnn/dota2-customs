--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_universal.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_universal.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:41",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "9:5",
		["22"] = "13:5",
		["23"] = "14:9",
		["24"] = "14:16",
		["25"] = "16:13",
		["26"] = "17:13",
		["27"] = "14:16",
		["28"] = "13:5",
		["29"] = "21:5",
		["30"] = "22:9",
		["31"] = "22:16",
		["32"] = "24:13",
		["33"] = "25:13",
		["34"] = "22:16",
		["35"] = "21:5",
		["36"] = "29:5",
		["37"] = "30:9",
		["38"] = "30:16",
		["39"] = "32:13",
		["40"] = "33:13",
		["41"] = "30:16",
		["42"] = "29:5",
		["43"] = "8:14",
		["44"] = "7:2",
		["45"] = "7:2",
		["46"] = "7:19",
		["47"] = "7:2",
		["49"] = "7:2",
		["50"] = "8:14",
		["52"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强
____exports.sl_modifier_rune_universal = __TS__Class()
local sl_modifier_rune_universal = ____exports.sl_modifier_rune_universal
sl_modifier_rune_universal.name = "sl_modifier_rune_universal"
__TS__ClassExtends(sl_modifier_rune_universal, sl_modifier_rune_base)
function sl_modifier_rune_universal.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end
function sl_modifier_rune_universal.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_universal.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_universal.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
sl_modifier_rune_universal = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_universal", nil, getfenv()) },
	sl_modifier_rune_universal
)
____exports.sl_modifier_rune_universal = sl_modifier_rune_universal
return ____exports