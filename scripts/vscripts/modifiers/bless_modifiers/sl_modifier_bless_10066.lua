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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10066 = __TS__Class()
local sl_modifier_bless_10066 = ____exports.sl_modifier_bless_10066
sl_modifier_bless_10066.name = "sl_modifier_bless_10066"
__TS__ClassExtends(sl_modifier_bless_10066, SLModifierBase)
function sl_modifier_bless_10066.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10066.prototype.GetTexture(self)
	return "buff/bless/10066"
end
function sl_modifier_bless_10066.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10066.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParams(params)
end
function sl_modifier_bless_10066.prototype._ApplyParams(self, params)
	local ____params_pct_per_stack_0 = params
	if ____params_pct_per_stack_0 ~= nil then
		____params_pct_per_stack_0 = ____params_pct_per_stack_0.pct_per_stack
	end
	if not ____params_pct_per_stack_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10066.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10066.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10066.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE, MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10066.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____temp_5 = self:GetStackCount()
	local ____table__params_pct_per_stack_2 = self._params
	if ____table__params_pct_per_stack_2 ~= nil then
		____table__params_pct_per_stack_2 = ____table__params_pct_per_stack_2.pct_per_stack
	end
	local ____table__params_pct_per_stack_2_4 = ____table__params_pct_per_stack_2
	if ____table__params_pct_per_stack_2_4 == nil then
		____table__params_pct_per_stack_2_4 = 0
	end
	return ____temp_5 * ____table__params_pct_per_stack_2_4
end
function sl_modifier_bless_10066.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____temp_9 = self:GetStackCount()
	local ____table__params_pct_per_stack_6 = self._params
	if ____table__params_pct_per_stack_6 ~= nil then
		____table__params_pct_per_stack_6 = ____table__params_pct_per_stack_6.pct_per_stack
	end
	local ____table__params_pct_per_stack_6_8 = ____table__params_pct_per_stack_6
	if ____table__params_pct_per_stack_6_8 == nil then
		____table__params_pct_per_stack_6_8 = 0
	end
	return ____temp_9 * ____table__params_pct_per_stack_6_8
end
sl_modifier_bless_10066 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10066") },
	sl_modifier_bless_10066
)
____exports.sl_modifier_bless_10066 = sl_modifier_bless_10066
return ____exports