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
local sl_modifier_transmitter_data_debuff = ____sl_modifier_simple.sl_modifier_transmitter_data_debuff
____exports.sl_modifier_bless_10141 = __TS__Class()
local sl_modifier_bless_10141 = ____exports.sl_modifier_bless_10141
sl_modifier_bless_10141.name = "sl_modifier_bless_10141"
__TS__ClassExtends(sl_modifier_bless_10141, sl_modifier_transmitter_data)
function sl_modifier_bless_10141.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10141.prototype.GetTexture(self)
	return "buff/bless/10141"
end
function sl_modifier_bless_10141.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10141.prototype.GetModifierDamageOutgoing_Percentage(self, event)
	local ____table__params_atk_pct_0 = self._params
	if ____table__params_atk_pct_0 ~= nil then
		____table__params_atk_pct_0 = ____table__params_atk_pct_0.atk_pct
	end
	return ____table__params_atk_pct_0 * self:GetStackCount()
end
function sl_modifier_bless_10141.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_spd_2 = self._params
	if ____table__params_spd_2 ~= nil then
		____table__params_spd_2 = ____table__params_spd_2.spd
	end
	return ____table__params_spd_2 * self:GetStackCount()
end
sl_modifier_bless_10141 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10141") },
	sl_modifier_bless_10141
)
____exports.sl_modifier_bless_10141 = sl_modifier_bless_10141
____exports.sl_modifier_bless_10141_debuff = __TS__Class()
local sl_modifier_bless_10141_debuff = ____exports.sl_modifier_bless_10141_debuff
sl_modifier_bless_10141_debuff.name = "sl_modifier_bless_10141_debuff"
__TS__ClassExtends(sl_modifier_bless_10141_debuff, sl_modifier_transmitter_data_debuff)
function sl_modifier_bless_10141_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10141_debuff.prototype.GetTexture(self)
	return "buff/bless/10141"
end
function sl_modifier_bless_10141_debuff.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS }
end
function sl_modifier_bless_10141_debuff.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_4 = self._params
	if ____table__params_armor_4 ~= nil then
		____table__params_armor_4 = ____table__params_armor_4.armor
	end
	return ____table__params_armor_4 * self:GetStackCount()
end
sl_modifier_bless_10141_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10141") },
	sl_modifier_bless_10141_debuff
)
____exports.sl_modifier_bless_10141_debuff = sl_modifier_bless_10141_debuff
return ____exports