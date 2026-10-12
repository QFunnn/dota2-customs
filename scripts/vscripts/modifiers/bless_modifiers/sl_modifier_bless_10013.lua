--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10013.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10013.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:38",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "9:5",
		["22"] = "13:5",
		["23"] = "14:9",
		["24"] = "13:5",
		["25"] = "17:5",
		["26"] = "18:9",
		["27"] = "17:5",
		["28"] = "21:5",
		["29"] = "22:16",
		["30"] = "22:16",
		["31"] = "22:16",
		["33"] = "22:9",
		["34"] = "21:5",
		["35"] = "25:5",
		["36"] = "26:16",
		["37"] = "26:16",
		["38"] = "26:16",
		["40"] = "26:9",
		["41"] = "25:5",
		["42"] = "29:5",
		["43"] = "30:16",
		["44"] = "30:16",
		["45"] = "30:16",
		["47"] = "30:9",
		["48"] = "29:5",
		["49"] = "8:14",
		["50"] = "7:2",
		["51"] = "7:2",
		["52"] = "7:19",
		["53"] = "7:2",
		["55"] = "7:2",
		["56"] = "8:14",
		["58"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10013", nil, getfenv()) },
	sl_modifier_bless_10013
)
____exports.sl_modifier_bless_10013 = sl_modifier_bless_10013
return ____exports