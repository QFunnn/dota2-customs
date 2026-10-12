--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_super_creep_amplify.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_super_creep_amplify.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:46",
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
--- 超级兵强化
____exports.sl_modifier_super_creep_amplify = __TS__Class()
local sl_modifier_super_creep_amplify = ____exports.sl_modifier_super_creep_amplify
sl_modifier_super_creep_amplify.name = "sl_modifier_super_creep_amplify"
__TS__ClassExtends(sl_modifier_super_creep_amplify, sl_modifier_transmitter_data)
function sl_modifier_super_creep_amplify.prototype.IsHidden(self)
	return false
end
function sl_modifier_super_creep_amplify.prototype.GetTexture(self)
	return "buff/super_creep_amplify"
end
function sl_modifier_super_creep_amplify.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end
function sl_modifier_super_creep_amplify.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_magic_resist_0 = self._params
	if ____table__params_magic_resist_0 ~= nil then
		____table__params_magic_resist_0 = ____table__params_magic_resist_0.magic_resist
	end
	return ____table__params_magic_resist_0
end
function sl_modifier_super_creep_amplify.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_move_speed_pct_2 = self._params
	if ____table__params_move_speed_pct_2 ~= nil then
		____table__params_move_speed_pct_2 = ____table__params_move_speed_pct_2.move_speed_pct
	end
	return ____table__params_move_speed_pct_2
end
function sl_modifier_super_creep_amplify.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_armor_4 = self._params
	if ____table__params_armor_4 ~= nil then
		____table__params_armor_4 = ____table__params_armor_4.armor
	end
	return ____table__params_armor_4
end
sl_modifier_super_creep_amplify = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_super_creep_amplify", nil, getfenv()) },
	sl_modifier_super_creep_amplify
)
____exports.sl_modifier_super_creep_amplify = sl_modifier_super_creep_amplify
return ____exports