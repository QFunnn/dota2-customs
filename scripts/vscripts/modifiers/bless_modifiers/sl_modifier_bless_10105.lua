--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
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
____exports.sl_modifier_bless_10105 = __TS__Class()
local sl_modifier_bless_10105 = ____exports.sl_modifier_bless_10105
sl_modifier_bless_10105.name = "sl_modifier_bless_10105"
__TS__ClassExtends(sl_modifier_bless_10105, SLModifierBase)
function sl_modifier_bless_10105.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10105.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10105.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10105.prototype.GetTexture(self)
	return "buff/bless/10105"
end
function sl_modifier_bless_10105.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_dmg_out_per_stack_0 = params
	if ____params_dmg_out_per_stack_0 ~= nil then
		____params_dmg_out_per_stack_0 = ____params_dmg_out_per_stack_0.dmg_out_per_stack
	end
	local ____temp_4 = not ____params_dmg_out_per_stack_0
	if not ____temp_4 then
		local ____params_dmg_in_per_stack_2 = params
		if ____params_dmg_in_per_stack_2 ~= nil then
			____params_dmg_in_per_stack_2 = ____params_dmg_in_per_stack_2.dmg_in_per_stack
		end
		____temp_4 = not ____params_dmg_in_per_stack_2
	end
	if ____temp_4 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10105.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10105.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10105.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10105.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____temp_8 = self:GetStackCount()
	local ____table__params_dmg_in_per_stack_5 = self._params
	if ____table__params_dmg_in_per_stack_5 ~= nil then
		____table__params_dmg_in_per_stack_5 = ____table__params_dmg_in_per_stack_5.dmg_in_per_stack
	end
	local ____table__params_dmg_in_per_stack_5_7 = ____table__params_dmg_in_per_stack_5
	if ____table__params_dmg_in_per_stack_5_7 == nil then
		____table__params_dmg_in_per_stack_5_7 = 0
	end
	return ____temp_8 * ____table__params_dmg_in_per_stack_5_7
end
function sl_modifier_bless_10105.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____temp_12 = self:GetStackCount()
	local ____table__params_dmg_out_per_stack_9 = self._params
	if ____table__params_dmg_out_per_stack_9 ~= nil then
		____table__params_dmg_out_per_stack_9 = ____table__params_dmg_out_per_stack_9.dmg_out_per_stack
	end
	local ____table__params_dmg_out_per_stack_9_11 = ____table__params_dmg_out_per_stack_9
	if ____table__params_dmg_out_per_stack_9_11 == nil then
		____table__params_dmg_out_per_stack_9_11 = 0
	end
	return ____temp_12 * ____table__params_dmg_out_per_stack_9_11
end
sl_modifier_bless_10105 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10105") },
	sl_modifier_bless_10105
)
____exports.sl_modifier_bless_10105 = sl_modifier_bless_10105
return ____exports