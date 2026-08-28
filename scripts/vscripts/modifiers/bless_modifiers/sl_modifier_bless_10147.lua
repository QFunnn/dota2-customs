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
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10147 = __TS__Class()
local sl_modifier_bless_10147 = ____exports.sl_modifier_bless_10147
sl_modifier_bless_10147.name = "sl_modifier_bless_10147"
__TS__ClassExtends(sl_modifier_bless_10147, sl_modifier_transmitter_data)
function sl_modifier_bless_10147.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10147.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	local ____table__params_pct_0_2 = ____table__params_pct_0
	if ____table__params_pct_0_2 == nil then
		____table__params_pct_0_2 = 0
	end
	return ____table__params_pct_0_2
end
function sl_modifier_bless_10147.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_pct_3 = self._params
	if ____table__params_pct_3 ~= nil then
		____table__params_pct_3 = ____table__params_pct_3.pct
	end
	local ____table__params_pct_3_5 = ____table__params_pct_3
	if ____table__params_pct_3_5 == nil then
		____table__params_pct_3_5 = 0
	end
	return ____table__params_pct_3_5
end
function sl_modifier_bless_10147.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147") },
	sl_modifier_bless_10147
)
____exports.sl_modifier_bless_10147 = sl_modifier_bless_10147
____exports.sl_modifier_bless_10147_debuff_immune = __TS__Class()
local sl_modifier_bless_10147_debuff_immune = ____exports.sl_modifier_bless_10147_debuff_immune
sl_modifier_bless_10147_debuff_immune.name = "sl_modifier_bless_10147_debuff_immune"
__TS__ClassExtends(sl_modifier_bless_10147_debuff_immune, sl_modifier_debuff_immune)
function sl_modifier_bless_10147_debuff_immune.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147_debuff_immune.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147_debuff_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147") },
	sl_modifier_bless_10147_debuff_immune
)
____exports.sl_modifier_bless_10147_debuff_immune = sl_modifier_bless_10147_debuff_immune
____exports.sl_modifier_bless_10147_cd = __TS__Class()
local sl_modifier_bless_10147_cd = ____exports.sl_modifier_bless_10147_cd
sl_modifier_bless_10147_cd.name = "sl_modifier_bless_10147_cd"
__TS__ClassExtends(sl_modifier_bless_10147_cd, SLModifierBase)
function sl_modifier_bless_10147_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10147_cd.prototype.GetTexture(self)
	return "buff/bless/10147"
end
sl_modifier_bless_10147_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10147") },
	sl_modifier_bless_10147_cd
)
____exports.sl_modifier_bless_10147_cd = sl_modifier_bless_10147_cd
return ____exports