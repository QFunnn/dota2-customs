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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 10192
____exports.sl_modifier_bless_10192 = __TS__Class()
local sl_modifier_bless_10192 = ____exports.sl_modifier_bless_10192
sl_modifier_bless_10192.name = "sl_modifier_bless_10192"
__TS__ClassExtends(sl_modifier_bless_10192, sl_modifier_transmitter_data)
function sl_modifier_bless_10192.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10192.prototype.GetTexture(self)
	return "buff/bless/10192"
end
function sl_modifier_bless_10192.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING }
end
function sl_modifier_bless_10192.prototype.GetModifierTotalDamageOutgoing_Percentage(self)
	local ____table__params_shI_0 = self._params
	if ____table__params_shI_0 ~= nil then
		____table__params_shI_0 = ____table__params_shI_0.shI
	end
	return ____table__params_shI_0
end
function sl_modifier_bless_10192.prototype.GetModifierStatusResistanceStacking(self)
	local ____table__params_ztkx_2 = self._params
	if ____table__params_ztkx_2 ~= nil then
		____table__params_ztkx_2 = ____table__params_ztkx_2.ztkx
	end
	return ____table__params_ztkx_2
end
sl_modifier_bless_10192 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10192") },
	sl_modifier_bless_10192
)
____exports.sl_modifier_bless_10192 = sl_modifier_bless_10192
return ____exports