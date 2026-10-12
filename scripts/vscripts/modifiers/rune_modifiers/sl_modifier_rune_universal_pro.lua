--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/rune_modifiers/sl_modifier_rune_universal_pro.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/rune_modifiers/sl_modifier_rune_universal_pro.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:45",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "10:16",
		["22"] = "10:16",
		["23"] = "10:16",
		["24"] = "10:16",
		["26"] = "10:16",
		["27"] = "9:5",
		["28"] = "19:5",
		["29"] = "20:9",
		["30"] = "20:16",
		["31"] = "22:13",
		["32"] = "23:13",
		["33"] = "20:16",
		["34"] = "19:5",
		["35"] = "27:5",
		["36"] = "28:9",
		["37"] = "28:16",
		["38"] = "30:13",
		["39"] = "31:13",
		["40"] = "28:16",
		["41"] = "27:5",
		["42"] = "35:5",
		["43"] = "36:9",
		["44"] = "36:16",
		["45"] = "38:13",
		["46"] = "39:13",
		["47"] = "36:16",
		["48"] = "35:5",
		["49"] = "43:5",
		["50"] = "44:9",
		["51"] = "43:5",
		["52"] = "47:5",
		["53"] = "48:9",
		["54"] = "47:5",
		["55"] = "8:14",
		["56"] = "7:2",
		["57"] = "7:2",
		["58"] = "7:19",
		["59"] = "7:2",
		["61"] = "7:2",
		["62"] = "8:14",
		["64"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local _____sl_modifier_rune_base = require("modifiers.rune_modifiers._sl_modifier_rune_base")
local sl_modifier_rune_base = _____sl_modifier_rune_base.sl_modifier_rune_base
--- 每点力量提升{hp_per_str}生命值，每点敏捷提升{batk_per_agi}基础攻击力，每点智力提升{amp_per_int}%技能增强，伤害输出+{pct}%，承受伤害+{csshI}%
____exports.sl_modifier_rune_universal_pro = __TS__Class()
local sl_modifier_rune_universal_pro = ____exports.sl_modifier_rune_universal_pro
sl_modifier_rune_universal_pro.name = "sl_modifier_rune_universal_pro"
__TS__ClassExtends(sl_modifier_rune_universal_pro, sl_modifier_rune_base)
function sl_modifier_rune_universal_pro.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end
function sl_modifier_rune_universal_pro.prototype.GetModifierHealthBonus(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_STRENGTH, "hp_per_str", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("hp_per_str")
	end)
end
function sl_modifier_rune_universal_pro.prototype.GetModifierBaseAttack_BonusDamage(self)
	return self:_CheckAndGetCachedAttrReleatedValue(DOTA_ATTRIBUTE_AGILITY, "batk_per_agi", function(____, current_attr)
		return current_attr * self:_GetRuneSpecialValue("batk_per_agi")
	end)
end
function sl_modifier_rune_universal_pro.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self:_CheckAndGetCachedAttrReleatedValue(
		DOTA_ATTRIBUTE_INTELLECT,
		"amp_per_int",
		function(____, current_attr)
			return current_attr * self:_GetRuneSpecialValue("amp_per_int")
		end
	)
end
function sl_modifier_rune_universal_pro.prototype.GetModifierTotalDamageOutgoing_Percentage(self)
	return self:_GetRuneSpecialValue("pct")
end
function sl_modifier_rune_universal_pro.prototype.GetModifierIncomingDamage_Percentage(self)
	return self:_GetRuneSpecialValue("csshI")
end
sl_modifier_rune_universal_pro = __TS__Decorate(
	{ registerModifier(nil, "modifiers/rune_modifiers/sl_modifier_rune_universal_pro", nil, getfenv()) },
	sl_modifier_rune_universal_pro
)
____exports.sl_modifier_rune_universal_pro = sl_modifier_rune_universal_pro
return ____exports