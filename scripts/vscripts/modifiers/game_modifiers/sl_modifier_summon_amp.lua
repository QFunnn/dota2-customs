--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_summon_amp.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_summon_amp.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:37",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "10:16",
		["22"] = "10:16",
		["23"] = "10:16",
		["24"] = "10:16",
		["26"] = "10:16",
		["27"] = "9:5",
		["28"] = "21:5",
		["29"] = "22:16",
		["30"] = "22:16",
		["31"] = "22:16",
		["33"] = "22:16",
		["35"] = "22:16",
		["37"] = "22:9",
		["38"] = "21:5",
		["39"] = "25:5",
		["40"] = "26:16",
		["41"] = "26:16",
		["42"] = "26:16",
		["44"] = "26:16",
		["46"] = "26:16",
		["48"] = "26:9",
		["49"] = "25:5",
		["50"] = "29:5",
		["51"] = "30:16",
		["52"] = "30:16",
		["53"] = "30:16",
		["55"] = "30:16",
		["57"] = "30:16",
		["59"] = "30:9",
		["60"] = "29:5",
		["61"] = "33:5",
		["62"] = "34:16",
		["63"] = "34:16",
		["64"] = "34:16",
		["66"] = "34:16",
		["68"] = "34:16",
		["70"] = "34:9",
		["71"] = "33:5",
		["72"] = "37:5",
		["73"] = "38:16",
		["74"] = "38:16",
		["75"] = "38:16",
		["77"] = "38:16",
		["79"] = "38:16",
		["81"] = "38:9",
		["82"] = "37:5",
		["83"] = "8:14",
		["84"] = "7:2",
		["85"] = "7:2",
		["86"] = "7:19",
		["87"] = "7:2",
		["89"] = "7:2",
		["90"] = "8:14",
		["92"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 召唤物强化
____exports.sl_modifier_summon_amp = __TS__Class()
local sl_modifier_summon_amp = ____exports.sl_modifier_summon_amp
sl_modifier_summon_amp.name = "sl_modifier_summon_amp"
__TS__ClassExtends(sl_modifier_summon_amp, sl_modifier_transmitter_data)
function sl_modifier_summon_amp.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE,
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end
function sl_modifier_summon_amp.prototype.GetModifierExtraHealthBonus(self)
	local ____table__params_hp_bonus_0 = self._params
	if ____table__params_hp_bonus_0 ~= nil then
		____table__params_hp_bonus_0 = ____table__params_hp_bonus_0.hp_bonus
	end
	local ____table__params_hp_bonus_0_2 = ____table__params_hp_bonus_0
	if ____table__params_hp_bonus_0_2 == nil then
		____table__params_hp_bonus_0_2 = 0
	end
	return ____table__params_hp_bonus_0_2
end
function sl_modifier_summon_amp.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_hp_bonus_pct_3 = self._params
	if ____table__params_hp_bonus_pct_3 ~= nil then
		____table__params_hp_bonus_pct_3 = ____table__params_hp_bonus_pct_3.hp_bonus_pct
	end
	local ____table__params_hp_bonus_pct_3_5 = ____table__params_hp_bonus_pct_3
	if ____table__params_hp_bonus_pct_3_5 == nil then
		____table__params_hp_bonus_pct_3_5 = 0
	end
	return ____table__params_hp_bonus_pct_3_5
end
function sl_modifier_summon_amp.prototype.GetModifierBaseDamageOutgoing_Percentage(self)
	local ____table__params_atk_bonus_pct_6 = self._params
	if ____table__params_atk_bonus_pct_6 ~= nil then
		____table__params_atk_bonus_pct_6 = ____table__params_atk_bonus_pct_6.atk_bonus_pct
	end
	local ____table__params_atk_bonus_pct_6_8 = ____table__params_atk_bonus_pct_6
	if ____table__params_atk_bonus_pct_6_8 == nil then
		____table__params_atk_bonus_pct_6_8 = 0
	end
	return ____table__params_atk_bonus_pct_6_8
end
function sl_modifier_summon_amp.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_atk_bonus_9 = self._params
	if ____table__params_atk_bonus_9 ~= nil then
		____table__params_atk_bonus_9 = ____table__params_atk_bonus_9.atk_bonus
	end
	local ____table__params_atk_bonus_9_11 = ____table__params_atk_bonus_9
	if ____table__params_atk_bonus_9_11 == nil then
		____table__params_atk_bonus_9_11 = 0
	end
	return ____table__params_atk_bonus_9_11
end
function sl_modifier_summon_amp.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local ____table__params_as_bonus_12 = self._params
	if ____table__params_as_bonus_12 ~= nil then
		____table__params_as_bonus_12 = ____table__params_as_bonus_12.as_bonus
	end
	local ____table__params_as_bonus_12_14 = ____table__params_as_bonus_12
	if ____table__params_as_bonus_12_14 == nil then
		____table__params_as_bonus_12_14 = 0
	end
	return ____table__params_as_bonus_12_14
end
sl_modifier_summon_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_summon_amp", nil, getfenv()) },
	sl_modifier_summon_amp
)
____exports.sl_modifier_summon_amp = sl_modifier_summon_amp
return ____exports