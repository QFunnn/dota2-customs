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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10179") },
	sl_modifier_bless_10179
)
____exports.sl_modifier_bless_10179 = sl_modifier_bless_10179
return ____exports