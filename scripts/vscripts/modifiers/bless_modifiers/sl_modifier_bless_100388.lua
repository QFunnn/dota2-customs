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
____exports.sl_modifier_bless_100388 = __TS__Class()
local sl_modifier_bless_100388 = ____exports.sl_modifier_bless_100388
sl_modifier_bless_100388.name = "sl_modifier_bless_100388"
__TS__ClassExtends(sl_modifier_bless_100388, sl_modifier_transmitter_data)
function sl_modifier_bless_100388.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100388.prototype.GetTexture(self)
	return "buff/bless/100388"
end
function sl_modifier_bless_100388.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_HEALTH_BONUS }
end
function sl_modifier_bless_100388.prototype.GetModifierPreAttack_BonusDamage(self)
	local ____table__params_atk_0 = self._params
	if ____table__params_atk_0 ~= nil then
		____table__params_atk_0 = ____table__params_atk_0.atk
	end
	local ____table__params_atk_0_2 = ____table__params_atk_0
	if ____table__params_atk_0_2 == nil then
		____table__params_atk_0_2 = 0
	end
	return ____table__params_atk_0_2
end
function sl_modifier_bless_100388.prototype.GetModifierHealthBonus(self)
	local ____table__params_hp_3 = self._params
	if ____table__params_hp_3 ~= nil then
		____table__params_hp_3 = ____table__params_hp_3.hp
	end
	local ____table__params_hp_3_5 = ____table__params_hp_3
	if ____table__params_hp_3_5 == nil then
		____table__params_hp_3_5 = 0
	end
	return ____table__params_hp_3_5
end
function sl_modifier_bless_100388.prototype.GetBonusStats(self)
	local ____table__params_atk_6 = self._params
	if ____table__params_atk_6 ~= nil then
		____table__params_atk_6 = ____table__params_atk_6.atk
	end
	local ____table__params_atk_6_8 = ____table__params_atk_6
	if ____table__params_atk_6_8 == nil then
		____table__params_atk_6_8 = 0
	end
	local ____table__params_hp_9 = self._params
	if ____table__params_hp_9 ~= nil then
		____table__params_hp_9 = ____table__params_hp_9.hp
	end
	local ____table__params_hp_9_11 = ____table__params_hp_9
	if ____table__params_hp_9_11 == nil then
		____table__params_hp_9_11 = 0
	end
	return { atk = ____table__params_atk_6_8, hp = ____table__params_hp_9_11 }
end
function sl_modifier_bless_100388.prototype.AddBonusStats(self, atk, hp)
	local ____self__params_13 = self._params
	local ____self__params_atk_12 = self._params.atk
	if ____self__params_atk_12 == nil then
		____self__params_atk_12 = 0
	end
	____self__params_13.atk = ____self__params_atk_12 + atk
	local ____self__params_15 = self._params
	local ____self__params_hp_14 = self._params.hp
	if ____self__params_hp_14 == nil then
		____self__params_hp_14 = 0
	end
	____self__params_15.hp = ____self__params_hp_14 + hp
	self:IncrementStackCount()
	self:_ApplyParams(self._params)
	self:GetParent():CalculateStatBonus(true)
end
sl_modifier_bless_100388 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100388") },
	sl_modifier_bless_100388
)
____exports.sl_modifier_bless_100388 = sl_modifier_bless_100388
return ____exports