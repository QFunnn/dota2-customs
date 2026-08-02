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
____exports.sl_modifier_bless_10143 = __TS__Class()
local sl_modifier_bless_10143 = ____exports.sl_modifier_bless_10143
sl_modifier_bless_10143.name = "sl_modifier_bless_10143"
__TS__ClassExtends(sl_modifier_bless_10143, sl_modifier_transmitter_data)
function sl_modifier_bless_10143.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10143.prototype.GetTexture(self)
	return "buff/bless/10143"
end
function sl_modifier_bless_10143.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Strength(self)
	local ____table__params_str_0 = self._params
	if ____table__params_str_0 ~= nil then
		____table__params_str_0 = ____table__params_str_0.str
	end
	local ____table__params_str_0_2 = ____table__params_str_0
	if ____table__params_str_0_2 == nil then
		____table__params_str_0_2 = 0
	end
	return ____table__params_str_0_2
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Agility(self)
	local ____table__params_agi_3 = self._params
	if ____table__params_agi_3 ~= nil then
		____table__params_agi_3 = ____table__params_agi_3.agi
	end
	local ____table__params_agi_3_5 = ____table__params_agi_3
	if ____table__params_agi_3_5 == nil then
		____table__params_agi_3_5 = 0
	end
	return ____table__params_agi_3_5
end
function sl_modifier_bless_10143.prototype.GetModifierBonusStats_Intellect(self)
	local ____table__params_int_6 = self._params
	if ____table__params_int_6 ~= nil then
		____table__params_int_6 = ____table__params_int_6.int
	end
	local ____table__params_int_6_8 = ____table__params_int_6
	if ____table__params_int_6_8 == nil then
		____table__params_int_6_8 = 0
	end
	return ____table__params_int_6_8
end
function sl_modifier_bless_10143.prototype.Get10143BonusStats(self, key)
	local ____table__params_key_9 = self._params
	if ____table__params_key_9 ~= nil then
		____table__params_key_9 = ____table__params_key_9[key]
	end
	return ____table__params_key_9
end
function sl_modifier_bless_10143.prototype.Modify10143BonusStats(self, key, value)
	if not self._params then
		self._params = { update_data = 1 }
	end
	local ____self__params_16 = self._params
	local ____key_17 = key
	local ____tonumber_12 = tonumber
	local ____self__params_key_11 = self._params[key]
	if ____self__params_key_11 == nil then
		____self__params_key_11 = 0
	end
	local ____tonumber_12_result_15 = ____tonumber_12(____self__params_key_11)
	local ____tonumber_14 = tonumber
	local ____value_13 = value
	if ____value_13 == nil then
		____value_13 = 0
	end
	____self__params_16[____key_17] = ____tonumber_12_result_15 + ____tonumber_14(____value_13)
	self:_ApplyParams(self._params)
end
sl_modifier_bless_10143 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143") },
	sl_modifier_bless_10143
)
____exports.sl_modifier_bless_10143 = sl_modifier_bless_10143
____exports.sl_modifier_bless_10143a = __TS__Class()
local sl_modifier_bless_10143a = ____exports.sl_modifier_bless_10143a
sl_modifier_bless_10143a.name = "sl_modifier_bless_10143a"
__TS__ClassExtends(sl_modifier_bless_10143a, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143a = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143") },
	sl_modifier_bless_10143a
)
____exports.sl_modifier_bless_10143a = sl_modifier_bless_10143a
____exports.sl_modifier_bless_10143b = __TS__Class()
local sl_modifier_bless_10143b = ____exports.sl_modifier_bless_10143b
sl_modifier_bless_10143b.name = "sl_modifier_bless_10143b"
__TS__ClassExtends(sl_modifier_bless_10143b, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143b = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143") },
	sl_modifier_bless_10143b
)
____exports.sl_modifier_bless_10143b = sl_modifier_bless_10143b
____exports.sl_modifier_bless_10143c = __TS__Class()
local sl_modifier_bless_10143c = ____exports.sl_modifier_bless_10143c
sl_modifier_bless_10143c.name = "sl_modifier_bless_10143c"
__TS__ClassExtends(sl_modifier_bless_10143c, ____exports.sl_modifier_bless_10143)
sl_modifier_bless_10143c = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10143") },
	sl_modifier_bless_10143c
)
____exports.sl_modifier_bless_10143c = sl_modifier_bless_10143c
return ____exports