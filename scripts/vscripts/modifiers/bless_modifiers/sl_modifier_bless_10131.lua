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
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
____exports.sl_modifier_bless_10131 = __TS__Class()
local sl_modifier_bless_10131 = ____exports.sl_modifier_bless_10131
sl_modifier_bless_10131.name = "sl_modifier_bless_10131"
__TS__ClassExtends(sl_modifier_bless_10131, sl_modifier_transmitter_data)
function sl_modifier_bless_10131.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10131.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10131.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_atk_0 = self._params
	if ____table__params_atk_0 ~= nil then
		____table__params_atk_0 = ____table__params_atk_0.atk
	end
	return ____table__params_atk_0
end
function sl_modifier_bless_10131.prototype.GetTexture(self)
	return "buff/bless/10131"
end
sl_modifier_bless_10131 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10131") },
	sl_modifier_bless_10131
)
____exports.sl_modifier_bless_10131 = sl_modifier_bless_10131
____exports.sl_modifier_bless_10131_debuff = __TS__Class()
local sl_modifier_bless_10131_debuff = ____exports.sl_modifier_bless_10131_debuff
sl_modifier_bless_10131_debuff.name = "sl_modifier_bless_10131_debuff"
__TS__ClassExtends(sl_modifier_bless_10131_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10131_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10131_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10131_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10131_debuff.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_spd_pct_2 = self._params
	if ____table__params_spd_pct_2 ~= nil then
		____table__params_spd_pct_2 = ____table__params_spd_pct_2.spd_pct
	end
	return ____table__params_spd_pct_2
end
function sl_modifier_bless_10131_debuff.prototype.GetTexture(self)
	return "buff/bless/10131"
end
sl_modifier_bless_10131_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10131") },
	sl_modifier_bless_10131_debuff
)
____exports.sl_modifier_bless_10131_debuff = sl_modifier_bless_10131_debuff
return ____exports