--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10164.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10164.lua",
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
		["27"] = "19:5",
		["28"] = "20:16",
		["29"] = "20:16",
		["30"] = "20:16",
		["32"] = "20:16",
		["34"] = "20:16",
		["36"] = "20:9",
		["37"] = "19:5",
		["38"] = "23:5",
		["39"] = "24:16",
		["40"] = "24:16",
		["41"] = "24:16",
		["43"] = "24:16",
		["45"] = "24:16",
		["47"] = "24:9",
		["48"] = "23:5",
		["49"] = "6:14",
		["50"] = "5:2",
		["51"] = "5:2",
		["52"] = "5:19",
		["53"] = "5:2",
		["55"] = "5:2",
		["56"] = "6:14",
		["58"] = "6:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10164 = __TS__Class()
local sl_modifier_bless_10164 = ____exports.sl_modifier_bless_10164
sl_modifier_bless_10164.name = "sl_modifier_bless_10164"
__TS__ClassExtends(sl_modifier_bless_10164, sl_modifier_transmitter_data)
function sl_modifier_bless_10164.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10164.prototype.GetTexture(self)
	return "buff/bless/10164"
end
function sl_modifier_bless_10164.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP, MODIFIER_PROPERTY_TOOLTIP2 }
end
function sl_modifier_bless_10164.prototype.OnTooltip(self)
	local ____table__params_overflow_ats_0 = self._params
	if ____table__params_overflow_ats_0 ~= nil then
		____table__params_overflow_ats_0 = ____table__params_overflow_ats_0.overflow_ats
	end
	local ____table__params_overflow_ats_0_2 = ____table__params_overflow_ats_0
	if ____table__params_overflow_ats_0_2 == nil then
		____table__params_overflow_ats_0_2 = 0
	end
	return ____table__params_overflow_ats_0_2
end
function sl_modifier_bless_10164.prototype.OnTooltip2(self)
	local ____table__params_next_time_need_3 = self._params
	if ____table__params_next_time_need_3 ~= nil then
		____table__params_next_time_need_3 = ____table__params_next_time_need_3.next_time_need
	end
	local ____table__params_next_time_need_3_5 = ____table__params_next_time_need_3
	if ____table__params_next_time_need_3_5 == nil then
		____table__params_next_time_need_3_5 = 0
	end
	return ____table__params_next_time_need_3_5
end
sl_modifier_bless_10164 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10164", nil, getfenv()) },
	sl_modifier_bless_10164
)
____exports.sl_modifier_bless_10164 = sl_modifier_bless_10164
return ____exports