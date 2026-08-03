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
sl_modifier_summon_amp =
	__TS__Decorate({ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_summon_amp") }, sl_modifier_summon_amp)
____exports.sl_modifier_summon_amp = sl_modifier_summon_amp
return ____exports