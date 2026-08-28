--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10164") },
	sl_modifier_bless_10164
)
____exports.sl_modifier_bless_10164 = sl_modifier_bless_10164
return ____exports