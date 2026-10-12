--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10169.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10169.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:38",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "8:13",
		["21"] = "9:13",
		["22"] = "10:13",
		["23"] = "11:13",
		["24"] = "12:13",
		["25"] = "13:13",
		["26"] = "14:13",
		["27"] = "15:13",
		["28"] = "7:16",
		["29"] = "6:5",
		["30"] = "19:5",
		["31"] = "20:9",
		["32"] = "19:5",
		["33"] = "23:5",
		["34"] = "24:13",
		["35"] = "24:13",
		["36"] = "24:13",
		["38"] = "24:13",
		["39"] = "25:13",
		["41"] = "27:9",
		["42"] = "23:5",
		["43"] = "30:5",
		["44"] = "31:16",
		["45"] = "31:16",
		["46"] = "31:16",
		["48"] = "31:9",
		["49"] = "30:5",
		["50"] = "5:14",
		["51"] = "4:2",
		["52"] = "4:2",
		["53"] = "4:19",
		["54"] = "4:2",
		["56"] = "4:2",
		["57"] = "5:14",
		["59"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10169 = __TS__Class()
local sl_modifier_bless_10169 = ____exports.sl_modifier_bless_10169
sl_modifier_bless_10169.name = "sl_modifier_bless_10169"
__TS__ClassExtends(sl_modifier_bless_10169, sl_modifier_transmitter_data)
function sl_modifier_bless_10169.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_DEBUFF_IMMUNE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP_FOR_ENEMIES] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
		[MODIFIER_STATE_UNTARGETABLE_ENEMY] = true,
	}
end
function sl_modifier_bless_10169.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE, MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL }
end
function sl_modifier_bless_10169.prototype.GetModifierOverrideAbilitySpecial(self, event)
	local ____table__params_event_ability_special_value_0 = self._params
	if ____table__params_event_ability_special_value_0 ~= nil then
		____table__params_event_ability_special_value_0 =
			____table__params_event_ability_special_value_0[event.ability_special_value]
	end
	if ____table__params_event_ability_special_value_0 then
		return 1
	end
	return 0
end
function sl_modifier_bless_10169.prototype.GetModifierOverrideAbilitySpecialValue(self, event)
	local ____table__params_event_ability_special_value_2 = self._params
	if ____table__params_event_ability_special_value_2 ~= nil then
		____table__params_event_ability_special_value_2 =
			____table__params_event_ability_special_value_2[event.ability_special_value]
	end
	return ____table__params_event_ability_special_value_2
end
sl_modifier_bless_10169 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10169", nil, getfenv()) },
	sl_modifier_bless_10169
)
____exports.sl_modifier_bless_10169 = sl_modifier_bless_10169
return ____exports