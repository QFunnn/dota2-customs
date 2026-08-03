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
--- 10080 剑心犹在显示buff
____exports.sl_modifier_bless_10080_display = __TS__Class()
local sl_modifier_bless_10080_display = ____exports.sl_modifier_bless_10080_display
sl_modifier_bless_10080_display.name = "sl_modifier_bless_10080_display"
__TS__ClassExtends(sl_modifier_bless_10080_display, SLModifierBase)
function sl_modifier_bless_10080_display.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10080_display.prototype.GetTexture(self)
	return "buff/bless/10080"
end
function sl_modifier_bless_10080_display.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10080_display.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self._main_stats = params.main_stats
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10080_display.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._main_stats = params.main_stats
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10080_display.prototype.HandleCustomTransmitterData(self, data)
	self._main_stats = data.main_stats
end
function sl_modifier_bless_10080_display.prototype.AddCustomTransmitterData(self)
	return { main_stats = self._main_stats }
end
function sl_modifier_bless_10080_display.prototype.OnTooltip(self)
	return self._main_stats
end
sl_modifier_bless_10080_display = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10080_display") },
	sl_modifier_bless_10080_display
)
____exports.sl_modifier_bless_10080_display = sl_modifier_bless_10080_display
return ____exports