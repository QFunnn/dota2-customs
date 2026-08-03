--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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
--- 10173
____exports.sl_modifier_bless_10173 = __TS__Class()
local sl_modifier_bless_10173 = ____exports.sl_modifier_bless_10173
sl_modifier_bless_10173.name = "sl_modifier_bless_10173"
__TS__ClassExtends(sl_modifier_bless_10173, sl_modifier_transmitter_data)
function sl_modifier_bless_10173.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10173.prototype.GetTexture(self)
	return "buff/bless/10173"
end
function sl_modifier_bless_10173.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10173.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____temp_3 = self:GetStackCount()
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____temp_3 * ____table__params_pct_0_2
end
sl_modifier_bless_10173 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10173") },
	sl_modifier_bless_10173
)
____exports.sl_modifier_bless_10173 = sl_modifier_bless_10173
____exports.sl_modifier_bless_10173_ally = __TS__Class()
local sl_modifier_bless_10173_ally = ____exports.sl_modifier_bless_10173_ally
sl_modifier_bless_10173_ally.name = "sl_modifier_bless_10173_ally"
__TS__ClassExtends(sl_modifier_bless_10173_ally, sl_modifier_transmitter_data)
function sl_modifier_bless_10173_ally.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10173_ally.prototype.GetTexture(self)
	return self:GetCaster():GetUnitName()
end
function sl_modifier_bless_10173_ally.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10173_ally.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10173_ally.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_4 = self._params
	if ____table__params_pct_4 ~= nil then
		____table__params_pct_4 = ____table__params_pct_4.pct
	end
	local ____table__params_pct_4_6 = ____table__params_pct_4
	if ____table__params_pct_4_6 == nil then
		____table__params_pct_4_6 = 0
	end
	return ____table__params_pct_4_6
end
sl_modifier_bless_10173_ally = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10173") },
	sl_modifier_bless_10173_ally
)
____exports.sl_modifier_bless_10173_ally = sl_modifier_bless_10173_ally
return ____exports