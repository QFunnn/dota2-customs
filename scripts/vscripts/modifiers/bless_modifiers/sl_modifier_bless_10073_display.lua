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
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
--- 10073 灼烧debuff显示层数
____exports.sl_modifier_bless_10073_display = __TS__Class()
local sl_modifier_bless_10073_display = ____exports.sl_modifier_bless_10073_display
sl_modifier_bless_10073_display.name = "sl_modifier_bless_10073_display"
__TS__ClassExtends(sl_modifier_bless_10073_display, SLModifierBase_Debuff)
function sl_modifier_bless_10073_display.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10073_display.prototype.GetTexture(self)
	return "buff/bless/10073"
end
function sl_modifier_bless_10073_display.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10073_display.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10073_display.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10073_display.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._dmg_pct = params.dmg_pct
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10073_display.prototype.HandleCustomTransmitterData(self, data)
	self._dmg_pct = data.dmg_pct
end
function sl_modifier_bless_10073_display.prototype.AddCustomTransmitterData(self)
	return { dmg_pct = self._dmg_pct }
end
function sl_modifier_bless_10073_display.prototype.OnTooltip(self)
	return self._dmg_pct
end
sl_modifier_bless_10073_display = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10073_display") },
	sl_modifier_bless_10073_display
)
____exports.sl_modifier_bless_10073_display = sl_modifier_bless_10073_display
return ____exports