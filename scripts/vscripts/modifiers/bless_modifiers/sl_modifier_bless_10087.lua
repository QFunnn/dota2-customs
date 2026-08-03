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
____exports.sl_modifier_bless_10087 = __TS__Class()
local sl_modifier_bless_10087 = ____exports.sl_modifier_bless_10087
sl_modifier_bless_10087.name = "sl_modifier_bless_10087"
__TS__ClassExtends(sl_modifier_bless_10087, SLModifierBase)
function sl_modifier_bless_10087.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10087.prototype.GetTexture(self)
	return "buff/bless/10087"
end
function sl_modifier_bless_10087.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE, MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10087.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10087.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10087.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_bonus_pct_0 = params
	if ____params_bonus_pct_0 ~= nil then
		____params_bonus_pct_0 = ____params_bonus_pct_0.bonus_pct
	end
	if not ____params_bonus_pct_0 then
		return
	end
	self._params = params
end
function sl_modifier_bless_10087.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10087.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10087.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_bonus_pct_2 = self._params
	if ____table__params_bonus_pct_2 ~= nil then
		____table__params_bonus_pct_2 = ____table__params_bonus_pct_2.bonus_pct
	end
	local ____table__params_bonus_pct_2_4 = ____table__params_bonus_pct_2
	if ____table__params_bonus_pct_2_4 == nil then
		____table__params_bonus_pct_2_4 = 0
	end
	return ____table__params_bonus_pct_2_4 * self:GetStackCount()
end
function sl_modifier_bless_10087.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local ____table__params_bonus_pct_5 = self._params
	if ____table__params_bonus_pct_5 ~= nil then
		____table__params_bonus_pct_5 = ____table__params_bonus_pct_5.bonus_pct
	end
	local ____table__params_bonus_pct_5_7 = ____table__params_bonus_pct_5
	if ____table__params_bonus_pct_5_7 == nil then
		____table__params_bonus_pct_5_7 = 0
	end
	return ____table__params_bonus_pct_5_7 * self:GetStackCount()
end
sl_modifier_bless_10087 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10087") },
	sl_modifier_bless_10087
)
____exports.sl_modifier_bless_10087 = sl_modifier_bless_10087
return ____exports