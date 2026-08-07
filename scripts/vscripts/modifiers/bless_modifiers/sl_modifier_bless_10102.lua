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
____exports.sl_modifier_bless_10102 = __TS__Class()
local sl_modifier_bless_10102 = ____exports.sl_modifier_bless_10102
sl_modifier_bless_10102.name = "sl_modifier_bless_10102"
__TS__ClassExtends(sl_modifier_bless_10102, SLModifierBase)
function sl_modifier_bless_10102.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10102.prototype.OnCreated(self, params)
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10102.prototype.OnRefresh(self, params)
	self:_ApplyParams(params)
end
function sl_modifier_bless_10102.prototype.GetTexture(self)
	return "buff/bless/10102"
end
function sl_modifier_bless_10102.prototype._ApplyParams(self, params)
	if not IsServer() then
		return
	end
	local ____params_pct_0 = params
	if ____params_pct_0 ~= nil then
		____params_pct_0 = ____params_pct_0.pct
	end
	if not ____params_pct_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10102.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10102.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10102.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10102.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not self._params then
		return
	end
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	local ____table__params_pct_2_4 = ____table__params_pct_2
	if ____table__params_pct_2_4 == nil then
		____table__params_pct_2_4 = 0
	end
	return ____table__params_pct_2_4 * self:GetStackCount()
end
function sl_modifier_bless_10102.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	if not self._params then
		return
	end
	local ____table__params_pct_5 = self._params
	if ____table__params_pct_5 ~= nil then
		____table__params_pct_5 = ____table__params_pct_5.pct
	end
	local ____table__params_pct_5_7 = ____table__params_pct_5
	if ____table__params_pct_5_7 == nil then
		____table__params_pct_5_7 = 0
	end
	return ____table__params_pct_5_7 * self:GetStackCount()
end
sl_modifier_bless_10102 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10102") },
	sl_modifier_bless_10102
)
____exports.sl_modifier_bless_10102 = sl_modifier_bless_10102
return ____exports