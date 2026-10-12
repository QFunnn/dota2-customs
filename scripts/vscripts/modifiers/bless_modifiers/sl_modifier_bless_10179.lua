--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10179.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10179.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "3:1",
		["13"] = "3:10",
		["14"] = "5:1",
		["15"] = "6:14",
		["16"] = "5:1",
		["17"] = "6:38",
		["18"] = "7:5",
		["19"] = "8:9",
		["20"] = "7:5",
		["21"] = "11:5",
		["22"] = "12:9",
		["23"] = "11:5",
		["24"] = "15:5",
		["25"] = "16:9",
		["26"] = "15:5",
		["27"] = "24:5",
		["28"] = "25:16",
		["29"] = "25:16",
		["30"] = "25:16",
		["32"] = "25:9",
		["33"] = "24:5",
		["34"] = "28:5",
		["35"] = "29:16",
		["36"] = "29:16",
		["37"] = "29:16",
		["39"] = "29:9",
		["40"] = "28:5",
		["41"] = "32:5",
		["42"] = "33:16",
		["43"] = "33:16",
		["44"] = "33:16",
		["46"] = "33:9",
		["47"] = "32:5",
		["48"] = "36:5",
		["49"] = "37:16",
		["50"] = "37:16",
		["51"] = "37:16",
		["53"] = "37:9",
		["54"] = "36:5",
		["55"] = "6:14",
		["56"] = "5:2",
		["57"] = "5:2",
		["58"] = "5:19",
		["59"] = "5:2",
		["61"] = "5:2",
		["62"] = "6:14",
		["64"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10179 = __TS__Class()
local sl_modifier_bless_10179 = ____exports.sl_modifier_bless_10179
sl_modifier_bless_10179.name = "sl_modifier_bless_10179"
__TS__ClassExtends(sl_modifier_bless_10179, sl_modifier_transmitter_data)
function sl_modifier_bless_10179.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10179.prototype.GetTexture(self)
	return "buff/bless/10179"
end
function sl_modifier_bless_10179.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_CAST_RANGE_BONUS,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
	}
end
function sl_modifier_bless_10179.prototype.GetModifierCastRangeBonus(self, event)
	local ____table__params_range_0 = self._params
	if ____table__params_range_0 ~= nil then
		____table__params_range_0 = ____table__params_range_0.range
	end
	return ____table__params_range_0
end
function sl_modifier_bless_10179.prototype.GetModifierAttackRangeBonus(self)
	local ____table__params_range_2 = self._params
	if ____table__params_range_2 ~= nil then
		____table__params_range_2 = ____table__params_range_2.range
	end
	return ____table__params_range_2
end
function sl_modifier_bless_10179.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_cs_pct_4 = self._params
	if ____table__params_cs_pct_4 ~= nil then
		____table__params_cs_pct_4 = ____table__params_cs_pct_4.cs_pct
	end
	return ____table__params_cs_pct_4
end
function sl_modifier_bless_10179.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_6 = self._params
	if ____table__params_pct_6 ~= nil then
		____table__params_pct_6 = ____table__params_pct_6.pct
	end
	return ____table__params_pct_6
end
sl_modifier_bless_10179 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10179", nil, getfenv()) },
	sl_modifier_bless_10179
)
____exports.sl_modifier_bless_10179 = sl_modifier_bless_10179
return ____exports