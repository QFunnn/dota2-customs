--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_illusion_fix.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_illusion_fix.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "7:1",
		["16"] = "8:14",
		["17"] = "7:1",
		["18"] = "8:39",
		["19"] = "9:5",
		["20"] = "10:9",
		["21"] = "10:16",
		["22"] = "10:16",
		["23"] = "10:16",
		["24"] = "10:16",
		["25"] = "10:16",
		["26"] = "10:16",
		["27"] = "10:16",
		["29"] = "10:16",
		["30"] = "9:5",
		["31"] = "22:5",
		["32"] = "23:16",
		["33"] = "23:16",
		["34"] = "23:16",
		["36"] = "23:16",
		["38"] = "23:16",
		["40"] = "23:9",
		["41"] = "22:5",
		["42"] = "26:5",
		["43"] = "27:16",
		["44"] = "27:16",
		["45"] = "27:16",
		["47"] = "27:16",
		["49"] = "27:16",
		["51"] = "27:9",
		["52"] = "26:5",
		["53"] = "30:5",
		["54"] = "31:16",
		["55"] = "31:16",
		["56"] = "31:16",
		["58"] = "31:16",
		["60"] = "31:16",
		["62"] = "31:9",
		["63"] = "30:5",
		["64"] = "34:5",
		["65"] = "35:16",
		["66"] = "35:16",
		["67"] = "35:16",
		["69"] = "35:16",
		["71"] = "35:16",
		["73"] = "35:9",
		["74"] = "34:5",
		["75"] = "38:5",
		["76"] = "39:16",
		["77"] = "39:16",
		["78"] = "39:16",
		["80"] = "39:16",
		["82"] = "39:16",
		["84"] = "39:9",
		["85"] = "38:5",
		["86"] = "42:5",
		["87"] = "43:16",
		["88"] = "43:16",
		["89"] = "43:16",
		["91"] = "43:16",
		["93"] = "43:16",
		["95"] = "43:9",
		["96"] = "42:5",
		["97"] = "46:5",
		["98"] = "47:16",
		["99"] = "47:16",
		["100"] = "47:16",
		["102"] = "47:16",
		["104"] = "47:16",
		["106"] = "47:9",
		["107"] = "46:5",
		["108"] = "50:5",
		["109"] = "51:16",
		["110"] = "51:16",
		["111"] = "51:16",
		["113"] = "51:16",
		["115"] = "51:16",
		["117"] = "51:9",
		["118"] = "50:5",
		["119"] = "8:14",
		["120"] = "7:2",
		["121"] = "7:2",
		["122"] = "7:19",
		["123"] = "7:2",
		["125"] = "7:2",
		["126"] = "8:14",
		["128"] = "8:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
--- 幻象属性修正
____exports.sl_modifier_illusion_fix = __TS__Class()
local sl_modifier_illusion_fix = ____exports.sl_modifier_illusion_fix
sl_modifier_illusion_fix.name = "sl_modifier_illusion_fix"
__TS__ClassExtends(sl_modifier_illusion_fix, sl_modifier_transmitter_data)
function sl_modifier_illusion_fix.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
	}
end
function sl_modifier_illusion_fix.prototype.GetModifierHealthBonus(self)
	local ____table__params_diff_hp_0 = self._params
	if ____table__params_diff_hp_0 ~= nil then
		____table__params_diff_hp_0 = ____table__params_diff_hp_0.diff_hp
	end
	local ____table__params_diff_hp_0_2 = ____table__params_diff_hp_0
	if ____table__params_diff_hp_0_2 == nil then
		____table__params_diff_hp_0_2 = 0
	end
	return ____table__params_diff_hp_0_2
end
function sl_modifier_illusion_fix.prototype.GetModifierPhysicalArmorBonus(self, event)
	local ____table__params_diff_armor_3 = self._params
	if ____table__params_diff_armor_3 ~= nil then
		____table__params_diff_armor_3 = ____table__params_diff_armor_3.diff_armor
	end
	local ____table__params_diff_armor_3_5 = ____table__params_diff_armor_3
	if ____table__params_diff_armor_3_5 == nil then
		____table__params_diff_armor_3_5 = 0
	end
	return ____table__params_diff_armor_3_5
end
function sl_modifier_illusion_fix.prototype.GetModifierMagicalResistanceBonus(self, event)
	local ____table__params_diff_magic_resist_6 = self._params
	if ____table__params_diff_magic_resist_6 ~= nil then
		____table__params_diff_magic_resist_6 = ____table__params_diff_magic_resist_6.diff_magic_resist
	end
	local ____table__params_diff_magic_resist_6_8 = ____table__params_diff_magic_resist_6
	if ____table__params_diff_magic_resist_6_8 == nil then
		____table__params_diff_magic_resist_6_8 = 0
	end
	return ____table__params_diff_magic_resist_6_8
end
function sl_modifier_illusion_fix.prototype.GetModifierBaseAttack_BonusDamage(self)
	local ____table__params_diff_base_attack_9 = self._params
	if ____table__params_diff_base_attack_9 ~= nil then
		____table__params_diff_base_attack_9 = ____table__params_diff_base_attack_9.diff_base_attack
	end
	local ____table__params_diff_base_attack_9_11 = ____table__params_diff_base_attack_9
	if ____table__params_diff_base_attack_9_11 == nil then
		____table__params_diff_base_attack_9_11 = 0
	end
	return ____table__params_diff_base_attack_9_11
end
function sl_modifier_illusion_fix.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_diff_attack_12 = self._params
	if ____table__params_diff_attack_12 ~= nil then
		____table__params_diff_attack_12 = ____table__params_diff_attack_12.diff_attack
	end
	local ____table__params_diff_attack_12_14 = ____table__params_diff_attack_12
	if ____table__params_diff_attack_12_14 == nil then
		____table__params_diff_attack_12_14 = 0
	end
	return ____table__params_diff_attack_12_14
end
function sl_modifier_illusion_fix.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local ____table__params_diff_atk_spd_15 = self._params
	if ____table__params_diff_atk_spd_15 ~= nil then
		____table__params_diff_atk_spd_15 = ____table__params_diff_atk_spd_15.diff_atk_spd
	end
	local ____table__params_diff_atk_spd_15_17 = ____table__params_diff_atk_spd_15
	if ____table__params_diff_atk_spd_15_17 == nil then
		____table__params_diff_atk_spd_15_17 = 0
	end
	return ____table__params_diff_atk_spd_15_17
end
function sl_modifier_illusion_fix.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____table__params_diff_amp_18 = self._params
	if ____table__params_diff_amp_18 ~= nil then
		____table__params_diff_amp_18 = ____table__params_diff_amp_18.diff_amp
	end
	local ____table__params_diff_amp_18_20 = ____table__params_diff_amp_18
	if ____table__params_diff_amp_18_20 == nil then
		____table__params_diff_amp_18_20 = 0
	end
	return ____table__params_diff_amp_18_20
end
function sl_modifier_illusion_fix.prototype.GetModifierAttackRangeBonus(self)
	local ____table__params_diff_atk_range_21 = self._params
	if ____table__params_diff_atk_range_21 ~= nil then
		____table__params_diff_atk_range_21 = ____table__params_diff_atk_range_21.diff_atk_range
	end
	local ____table__params_diff_atk_range_21_23 = ____table__params_diff_atk_range_21
	if ____table__params_diff_atk_range_21_23 == nil then
		____table__params_diff_atk_range_21_23 = 0
	end
	return ____table__params_diff_atk_range_21_23
end
sl_modifier_illusion_fix = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_illusion_fix", nil, getfenv()) },
	sl_modifier_illusion_fix
)
____exports.sl_modifier_illusion_fix = sl_modifier_illusion_fix
return ____exports