--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_spellblade.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_spellblade.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:42",
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
		["30"] = "22:15",
		["31"] = "22:25",
		["32"] = "24:13",
		["33"] = "25:13",
		["34"] = "22:25",
		["35"] = "27:15",
		["36"] = "27:25",
		["37"] = "29:13",
		["38"] = "30:13",
		["39"] = "27:25",
		["40"] = "32:9",
		["41"] = "21:5",
		["42"] = "8:14",
		["43"] = "7:2",
		["44"] = "7:2",
		["45"] = "7:19",
		["46"] = "7:2",
		["48"] = "7:2",
		["49"] = "8:14",
		["51"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_spellblade", nil, getfenv()) },
	sl_modifier_rune_spellblade
)
____exports.sl_modifier_rune_spellblade = sl_modifier_rune_spellblade
return ____exports