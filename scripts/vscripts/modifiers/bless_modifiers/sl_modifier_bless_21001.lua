--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21001") },
	sl_modifier_bless_21001
)
____exports.sl_modifier_bless_21001 = sl_modifier_bless_21001
return ____exports