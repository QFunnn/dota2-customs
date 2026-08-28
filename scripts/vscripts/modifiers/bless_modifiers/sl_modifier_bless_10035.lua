--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
____exports.sl_modifier_bless_10035 = __TS__Class()
local sl_modifier_bless_10035 = ____exports.sl_modifier_bless_10035
sl_modifier_bless_10035.name = "sl_modifier_bless_10035"
__TS__ClassExtends(sl_modifier_bless_10035, SLModifierBase)
function sl_modifier_bless_10035.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10035.prototype.GetTexture(self)
	return "buff/bless/10035"
end
function sl_modifier_bless_10035.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:_ApplyParam(params)
end
function sl_modifier_bless_10035.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self:_ApplyParam(params)
end
function sl_modifier_bless_10035.prototype._ApplyParam(self, params)
	if not IsServer() then
		return
	end
	local ____params_value_0 = params
	if ____params_value_0 ~= nil then
		____params_value_0 = ____params_value_0.value
	end
	if not ____params_value_0 then
		return
	end
	self._params = params
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10035.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE, MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10035.prototype.HandleCustomTransmitterData(self, data)
	self._params = data
end
function sl_modifier_bless_10035.prototype.AddCustomTransmitterData(self)
	return self._params
end
function sl_modifier_bless_10035.prototype.GetModifierSpellAmplify_Percentage(self, event)
	return self._params.value
end
function sl_modifier_bless_10035.prototype.OnTooltip(self)
	return self._params.max
end
sl_modifier_bless_10035 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10035") },
	sl_modifier_bless_10035
)
____exports.sl_modifier_bless_10035 = sl_modifier_bless_10035
return ____exports