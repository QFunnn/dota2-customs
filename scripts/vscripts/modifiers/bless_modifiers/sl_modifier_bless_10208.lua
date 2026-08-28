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
--- 空城状态：敌方无法指向（自身/友方可指向），附带移速；不显示图标
____exports.sl_modifier_bless_10208 = __TS__Class()
local sl_modifier_bless_10208 = ____exports.sl_modifier_bless_10208
sl_modifier_bless_10208.name = "sl_modifier_bless_10208"
__TS__ClassExtends(sl_modifier_bless_10208, sl_modifier_transmitter_data)
function sl_modifier_bless_10208.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10208.prototype.CheckState(self)
	return { [MODIFIER_STATE_UNTARGETABLE_ENEMY] = true }
end
function sl_modifier_bless_10208.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT }
end
function sl_modifier_bless_10208.prototype.GetModifierMoveSpeedBonus_Constant(self)
	local ____table__params_ys_0 = self._params
	if ____table__params_ys_0 ~= nil then
		____table__params_ys_0 = ____table__params_ys_0.ys
	end
	local ____table__params_ys_0_2 = ____table__params_ys_0
	if ____table__params_ys_0_2 == nil then
		____table__params_ys_0_2 = 0
	end
	return ____table__params_ys_0_2
end
function sl_modifier_bless_10208.prototype.GetStatusEffectName(self)
	return BLESS_PARTICLES.bless_10208_shadow_realm
end
sl_modifier_bless_10208 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10208") },
	sl_modifier_bless_10208
)
____exports.sl_modifier_bless_10208 = sl_modifier_bless_10208
return ____exports