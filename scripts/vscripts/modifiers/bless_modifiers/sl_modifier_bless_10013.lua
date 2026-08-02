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
--- 10013 血法师
____exports.sl_modifier_bless_10013 = __TS__Class()
local sl_modifier_bless_10013 = ____exports.sl_modifier_bless_10013
sl_modifier_bless_10013.name = "sl_modifier_bless_10013"
__TS__ClassExtends(sl_modifier_bless_10013, sl_modifier_transmitter_data)
function sl_modifier_bless_10013.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10013.prototype.GetTexture(self)
	return "buff/bless/10013"
end
function sl_modifier_bless_10013.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_MAGICAL_LIFESTEAL,
	}
end
function sl_modifier_bless_10013.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_move_speed_pct_0 = self._params
	if ____table__params_move_speed_pct_0 ~= nil then
		____table__params_move_speed_pct_0 = ____table__params_move_speed_pct_0.move_speed_pct
	end
	return ____table__params_move_speed_pct_0
end
function sl_modifier_bless_10013.prototype.GetModifierSpellAmplify_Percentage(self)
	local ____table__params_spell_amp_pct_2 = self._params
	if ____table__params_spell_amp_pct_2 ~= nil then
		____table__params_spell_amp_pct_2 = ____table__params_spell_amp_pct_2.spell_amp_pct
	end
	return ____table__params_spell_amp_pct_2
end
function sl_modifier_bless_10013.prototype.GetModifierProperty_MagicalLifesteal(self)
	local ____table__params_spell_life_steal_pct_4 = self._params
	if ____table__params_spell_life_steal_pct_4 ~= nil then
		____table__params_spell_life_steal_pct_4 = ____table__params_spell_life_steal_pct_4.spell_life_steal_pct
	end
	return ____table__params_spell_life_steal_pct_4
end
sl_modifier_bless_10013 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10013") },
	sl_modifier_bless_10013
)
____exports.sl_modifier_bless_10013 = sl_modifier_bless_10013
return ____exports