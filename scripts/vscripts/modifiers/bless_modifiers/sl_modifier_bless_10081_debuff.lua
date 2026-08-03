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
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_damage_output_debuff = ____sl_modifier_simple.sl_modifier_damage_output_debuff
--- 福佑10081 对其他玩家的减伤debuff
-- 伤害输出 -dmg_reduce_pct%（负值）
____exports.sl_modifier_bless_10081_debuff = __TS__Class()
local sl_modifier_bless_10081_debuff = ____exports.sl_modifier_bless_10081_debuff
sl_modifier_bless_10081_debuff.name = "sl_modifier_bless_10081_debuff"
__TS__ClassExtends(sl_modifier_bless_10081_debuff, sl_modifier_damage_output_debuff)
function sl_modifier_bless_10081_debuff.prototype.IsPurgable(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsPermanent(self)
	return true
end
function sl_modifier_bless_10081_debuff.prototype.RemoveOnDeath(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsPurgeException(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10081_debuff.prototype.GetTexture(self)
	return "buff/bless/10081"
end
function sl_modifier_bless_10081_debuff.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10081_debuff.prototype.DeclareFunctions(self)
	local ____array_0 = __TS__SparseArrayNew(unpack(sl_modifier_damage_output_debuff.prototype.DeclareFunctions(self)))
	__TS__SparseArrayPush(____array_0, MODIFIER_PROPERTY_TOOLTIP)
	return { __TS__SparseArraySpread(____array_0) }
end
function sl_modifier_bless_10081_debuff.prototype.OnTooltip(self)
	return self._reduce_pct
end
function sl_modifier_bless_10081_debuff.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	local ____math_abs_4 = math.abs
	local ____params_value_1 = params
	if ____params_value_1 ~= nil then
		____params_value_1 = ____params_value_1.value
	end
	local ____params_value_1_3 = ____params_value_1
	if ____params_value_1_3 == nil then
		____params_value_1_3 = 0
	end
	self._reduce_pct = ____math_abs_4(____params_value_1_3)
	sl_modifier_damage_output_debuff.prototype.OnCreated(self, params)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10081_debuff.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	local ____math_abs_8 = math.abs
	local ____params_value_5 = params
	if ____params_value_5 ~= nil then
		____params_value_5 = ____params_value_5.value
	end
	local ____params_value_5_7 = ____params_value_5
	if ____params_value_5_7 == nil then
		____params_value_5_7 = 0
	end
	self._reduce_pct = ____math_abs_8(____params_value_5_7)
	sl_modifier_damage_output_debuff.prototype.OnRefresh(self, params)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10081_debuff.prototype.HandleCustomTransmitterData(self, data)
	self._reduce_pct = data.value
end
function sl_modifier_bless_10081_debuff.prototype.AddCustomTransmitterData(self)
	return { value = self._reduce_pct }
end
sl_modifier_bless_10081_debuff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10081_debuff") },
	sl_modifier_bless_10081_debuff
)
____exports.sl_modifier_bless_10081_debuff = sl_modifier_bless_10081_debuff
return ____exports