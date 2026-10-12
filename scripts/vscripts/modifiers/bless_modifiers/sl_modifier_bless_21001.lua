--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_21001.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_21001.lua",
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
		["20"] = "6:5",
		["21"] = "10:5",
		["22"] = "11:9",
		["23"] = "10:5",
		["24"] = "14:5",
		["25"] = "15:9",
		["26"] = "14:5",
		["27"] = "18:5",
		["28"] = "19:16",
		["29"] = "19:16",
		["30"] = "19:16",
		["32"] = "19:9",
		["33"] = "18:5",
		["34"] = "22:5",
		["35"] = "23:16",
		["36"] = "23:16",
		["37"] = "23:16",
		["39"] = "23:9",
		["40"] = "22:5",
		["41"] = "5:14",
		["42"] = "4:2",
		["43"] = "4:2",
		["44"] = "4:19",
		["45"] = "4:2",
		["47"] = "4:2",
		["48"] = "5:14",
		["50"] = "5:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_21001 = __TS__Class()
local sl_modifier_bless_21001 = ____exports.sl_modifier_bless_21001
sl_modifier_bless_21001.name = "sl_modifier_bless_21001"
__TS__ClassExtends(sl_modifier_bless_21001, sl_modifier_transmitter_data)
function sl_modifier_bless_21001.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21001.prototype.GetTexture(self)
	return "buff/bless/21001"
end
function sl_modifier_bless_21001.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACK_RANGE_BONUS, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_21001.prototype.GetModifierAttackRangeBonus(self)
	local ____table__params_atk_range_0 = self._params
	if ____table__params_atk_range_0 ~= nil then
		____table__params_atk_range_0 = ____table__params_atk_range_0.atk_range
	end
	return ____table__params_atk_range_0
end
function sl_modifier_bless_21001.prototype.OnTooltip(self)
	local ____table__params_total_damage_2 = self._params
	if ____table__params_total_damage_2 ~= nil then
		____table__params_total_damage_2 = ____table__params_total_damage_2.total_damage
	end
	return ____table__params_total_damage_2
end
sl_modifier_bless_21001 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21001", nil, getfenv()) },
	sl_modifier_bless_21001
)
____exports.sl_modifier_bless_21001 = sl_modifier_bless_21001
return ____exports