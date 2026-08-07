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
--- 10075 复活后输出提升显示buff
____exports.sl_modifier_bless_10075_display = __TS__Class()
local sl_modifier_bless_10075_display = ____exports.sl_modifier_bless_10075_display
sl_modifier_bless_10075_display.name = "sl_modifier_bless_10075_display"
__TS__ClassExtends(sl_modifier_bless_10075_display, SLModifierBase)
function sl_modifier_bless_10075_display.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10075_display.prototype.GetTexture(self)
	return "buff/bless/10075"
end
function sl_modifier_bless_10075_display.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10075_display.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._output_pct = params.output_pct
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10075_display.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._output_pct = params.output_pct
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10075_display.prototype.HandleCustomTransmitterData(self, data)
	self._output_pct = data.output_pct
end
function sl_modifier_bless_10075_display.prototype.AddCustomTransmitterData(self)
	return { output_pct = self._output_pct }
end
function sl_modifier_bless_10075_display.prototype.OnTooltip(self)
	return self._output_pct
end
sl_modifier_bless_10075_display = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10075_display") },
	sl_modifier_bless_10075_display
)
____exports.sl_modifier_bless_10075_display = sl_modifier_bless_10075_display
return ____exports