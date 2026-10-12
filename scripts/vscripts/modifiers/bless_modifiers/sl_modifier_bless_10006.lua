--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10006.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10006.lua",
	{
		["11"] = "1:1",
		["12"] = "1:10",
		["13"] = "2:1",
		["14"] = "2:10",
		["16"] = "7:1",
		["17"] = "8:14",
		["18"] = "7:1",
		["19"] = "8:38",
		["20"] = "9:5",
		["21"] = "10:9",
		["22"] = "9:5",
		["23"] = "13:5",
		["24"] = "14:9",
		["25"] = "13:5",
		["26"] = "17:5",
		["27"] = "18:9",
		["28"] = "17:5",
		["29"] = "25:5",
		["30"] = "26:14",
		["33"] = "27:9",
		["34"] = "28:9",
		["35"] = "29:9",
		["36"] = "25:5",
		["37"] = "32:5",
		["38"] = "33:14",
		["41"] = "34:9",
		["42"] = "35:9",
		["43"] = "32:5",
		["44"] = "38:5",
		["45"] = "39:42",
		["46"] = "39:17",
		["47"] = "40:15",
		["48"] = "41:9",
		["49"] = "42:9",
		["50"] = "38:5",
		["51"] = "45:5",
		["52"] = "47:31",
		["53"] = "48:31",
		["54"] = "48:31",
		["55"] = "48:31",
		["57"] = "49:35",
		["58"] = "49:35",
		["59"] = "49:35",
		["61"] = "46:9",
		["62"] = "45:5",
		["63"] = "53:5",
		["64"] = "54:9",
		["65"] = "55:24",
		["67"] = "56:31",
		["68"] = "56:31",
		["69"] = "56:31",
		["71"] = "57:35",
		["72"] = "57:35",
		["73"] = "57:35",
		["75"] = "55:24",
		["77"] = "55:9",
		["78"] = "53:5",
		["79"] = "61:5",
		["80"] = "62:9",
		["81"] = "61:5",
		["82"] = "65:5",
		["83"] = "66:9",
		["84"] = "65:5",
		["85"] = "69:5",
		["86"] = "70:15",
		["87"] = "71:15",
		["88"] = "71:56",
		["89"] = "71:83",
		["90"] = "71:28",
		["91"] = "72:27",
		["92"] = "72:27",
		["93"] = "72:27",
		["95"] = "72:15",
		["96"] = "73:13",
		["97"] = "74:13",
		["99"] = "76:9",
		["100"] = "69:5",
		["101"] = "8:14",
		["102"] = "7:2",
		["103"] = "7:2",
		["104"] = "7:19",
		["105"] = "7:2",
		["107"] = "7:2",
		["108"] = "8:14",
		["110"] = "8:14",
	}
)
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
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10006", nil, getfenv()) },
	sl_modifier_bless_10006
)
____exports.sl_modifier_bless_10006 = sl_modifier_bless_10006
return ____exports