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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 移动速度和攻击速度
____exports.sl_modifier_bless_10006 = __TS__Class()
local sl_modifier_bless_10006 = ____exports.sl_modifier_bless_10006
sl_modifier_bless_10006.name = "sl_modifier_bless_10006"
__TS__ClassExtends(sl_modifier_bless_10006, SLModifierBase)
function sl_modifier_bless_10006.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10006.prototype.GetTexture(self)
	return "buff/bless/10006"
end
function sl_modifier_bless_10006.prototype.DeclareFunctions(self)
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
	}
end
function sl_modifier_bless_10006.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
	self:SetHasCustomTransmitterData(true)
	self:_CalculateBlessBonus()
end
function sl_modifier_bless_10006.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._params = __TS__ObjectAssign(self._params, params)
	self:_CalculateBlessBonus()
end
function sl_modifier_bless_10006.prototype._CalculateBlessBonus(self)
	local ____self__params_0 = self._params
	local move_speed_per_stack = ____self__params_0.move_speed_per_stack
	local stack = self:GetStackCount()
	self._move_speed_bonus = stack * move_speed_per_stack
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10006.prototype.AddCustomTransmitterData(self)
	local ____self__move_speed_bonus_5 = self._move_speed_bonus
	local ____table__params_attack_speed_pct_1 = self._params
	if ____table__params_attack_speed_pct_1 ~= nil then
		____table__params_attack_speed_pct_1 = ____table__params_attack_speed_pct_1.attack_speed_pct
	end
	local ____table__params_move_speed_per_stack_3 = self._params
	if ____table__params_move_speed_per_stack_3 ~= nil then
		____table__params_move_speed_per_stack_3 = ____table__params_move_speed_per_stack_3.move_speed_per_stack
	end
	return {
		move_speed_bonus = ____self__move_speed_bonus_5,
		attack_speed_pct = ____table__params_attack_speed_pct_1,
		move_speed_per_stack = ____table__params_move_speed_per_stack_3,
	}
end
function sl_modifier_bless_10006.prototype.HandleCustomTransmitterData(self, data)
	self._move_speed_bonus = data.move_speed_bonus
	local ____self__params_10 = self._params
	if ____self__params_10 == nil then
		local ____data_attack_speed_pct_6 = data
		if ____data_attack_speed_pct_6 ~= nil then
			____data_attack_speed_pct_6 = ____data_attack_speed_pct_6.attack_speed_pct
		end
		local ____data_move_speed_per_stack_8 = data
		if ____data_move_speed_per_stack_8 ~= nil then
			____data_move_speed_per_stack_8 = ____data_move_speed_per_stack_8.move_speed_per_stack
		end
		____self__params_10 =
			{ attack_speed_pct = ____data_attack_speed_pct_6, move_speed_per_stack = ____data_move_speed_per_stack_8 }
	end
	self._params = ____self__params_10
end
function sl_modifier_bless_10006.prototype.GetModifierIgnoreMovespeedLimit(self)
	return 1
end
function sl_modifier_bless_10006.prototype.GetModifierMoveSpeedBonus_Constant(self)
	return self._move_speed_bonus
end
function sl_modifier_bless_10006.prototype.GetModifierAttackSpeedBonus_Constant(self)
	local parent = self:GetParent()
	local move_speed = parent:GetMoveSpeedModifier(parent:GetBaseMoveSpeed(), true)
	local ____table__params_attack_speed_pct_11 = self._params
	if ____table__params_attack_speed_pct_11 ~= nil then
		____table__params_attack_speed_pct_11 = ____table__params_attack_speed_pct_11.attack_speed_pct
	end
	local trans_pct = ____table__params_attack_speed_pct_11
	if trans_pct then
		return move_speed * trans_pct * 0.01
	end
	return 0
end
sl_modifier_bless_10006 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10006") },
	sl_modifier_bless_10006
)
____exports.sl_modifier_bless_10006 = sl_modifier_bless_10006
return ____exports