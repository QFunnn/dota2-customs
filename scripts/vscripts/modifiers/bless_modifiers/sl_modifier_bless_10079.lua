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
--- 福佑10079 问号buff
-- 移速、攻速、冷却时间减少 +effect_pct%，持续 duration 秒
____exports.sl_modifier_bless_10079 = __TS__Class()
local sl_modifier_bless_10079 = ____exports.sl_modifier_bless_10079
sl_modifier_bless_10079.name = "sl_modifier_bless_10079"
__TS__ClassExtends(sl_modifier_bless_10079, SLModifierBase)
function sl_modifier_bless_10079.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10079.prototype.GetTexture(self)
	return "buff/bless/10079"
end
function sl_modifier_bless_10079.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10079.prototype.OnTooltip(self)
	return self._effect_pct
end
function sl_modifier_bless_10079.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self._effect_pct = params.effect_pct
	self:_ApplyAttrs()
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10079.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self._effect_pct = params.effect_pct
	self:_ApplyAttrs()
	self:SendBuffRefreshToClients()
end
function sl_modifier_bless_10079.prototype._ApplyAttrs(self)
	self:_SetParentAttr("ysI", self._effect_pct)
	self:_SetParentAttr("gsI", self._effect_pct)
	self:_SetParentAttr("lq", self._effect_pct)
end
function sl_modifier_bless_10079.prototype.AddCustomTransmitterData(self)
	return { effect_pct = self._effect_pct }
end
function sl_modifier_bless_10079.prototype.HandleCustomTransmitterData(self, data)
	self._effect_pct = data.effect_pct
end
sl_modifier_bless_10079 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10079") },
	sl_modifier_bless_10079
)
____exports.sl_modifier_bless_10079 = sl_modifier_bless_10079
return ____exports