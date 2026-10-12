--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_spellblade_pro.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_spellblade_pro.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:46",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "9:5",
		["22"] = "18:5",
		["23"] = "19:9",
		["24"] = "19:16",
		["25"] = "21:13",
		["26"] = "22:13",
		["27"] = "19:16",
		["28"] = "18:5",
		["29"] = "26:5",
		["30"] = "27:15",
		["31"] = "27:25",
		["32"] = "29:13",
		["33"] = "30:13",
		["34"] = "27:25",
		["35"] = "32:15",
		["36"] = "32:25",
		["37"] = "34:13",
		["38"] = "35:13",
		["39"] = "32:25",
		["40"] = "37:9",
		["41"] = "26:5",
		["42"] = "40:5",
		["43"] = "41:9",
		["44"] = "40:5",
		["45"] = "44:5",
		["46"] = "45:9",
		["47"] = "44:5",
		["48"] = "8:14",
		["49"] = "7:2",
		["50"] = "7:2",
		["51"] = "7:19",
		["52"] = "7:2",
		["54"] = "7:2",
		["55"] = "8:14",
		["57"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点敏捷提升{batk_per_agi}基础攻击力，每点敏捷或智力提升{amp_per_agi_int}%技能增强，伤害输出+{pct}%，生命值-{smI}%
____exports.sl_modifier_rune_spellblade_pro = __TS__Class()
local sl_modifier_rune_spellblade_pro = ____exports.sl_modifier_rune_spellblade_pro
sl_modifier_rune_spellblade_pro.name = "sl_modifier_rune_spellblade_pro"
__TS__ClassExtends(sl_modifier_rune_spellblade_pro, sl_modifier_rune_base)
function sl_modifier_rune_spellblade_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
	}
end
function sl_modifier_rune_spellblade_pro.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_spellblade_pro.prototype.GetModifierSpellAmplify_Percentage(self, event)
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
function sl_modifier_rune_spellblade_pro.prototype.GetModifierTotalDamageOutgoing_Percentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_spellblade_pro.prototype.GetModifierExtraHealthPercentage(self)
	return self:_GetRuneSpecialValue("smI")
end
sl_modifier_rune_spellblade_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_spellblade_pro", nil, getfenv()) },
	sl_modifier_rune_spellblade_pro
)
____exports.sl_modifier_rune_spellblade_pro = sl_modifier_rune_spellblade_pro
return ____exports