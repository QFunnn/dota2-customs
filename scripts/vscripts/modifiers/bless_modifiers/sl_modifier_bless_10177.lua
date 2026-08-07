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
--- 10177
____exports.sl_modifier_bless_10177 = __TS__Class()
local sl_modifier_bless_10177 = ____exports.sl_modifier_bless_10177
sl_modifier_bless_10177.name = "sl_modifier_bless_10177"
__TS__ClassExtends(sl_modifier_bless_10177, SLModifierBase)
function sl_modifier_bless_10177.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._is_triggered = false
end
function sl_modifier_bless_10177.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10177.prototype.GetTexture(self)
	return "buff/bless/10177"
end
function sl_modifier_bless_10177.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10177.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_REINCARNATION, MODIFIER_EVENT_ON_RESPAWN }
end
function sl_modifier_bless_10177.prototype.ReincarnateTime(self)
	if not IsServer() then
		return
	end
	self._is_triggered = true
	local ____table__params_delay_0 = self._params
	if ____table__params_delay_0 ~= nil then
		____table__params_delay_0 = ____table__params_delay_0.delay
	end
	return ____table__params_delay_0
end
function sl_modifier_bless_10177.prototype.OnRespawn(self, event)
	if not IsServer() then
		return
	end
	local ____event_2 = event
	local unit = ____event_2.unit
	if unit ~= self:GetParent() then
		return
	end
	if not self._is_triggered then
		return
	end
	self:Destroy()
end
function sl_modifier_bless_10177.prototype.GetPriority(self)
	return MODIFIER_PRIORITY_HIGH
end
function sl_modifier_bless_10177.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._params = params
end
sl_modifier_bless_10177 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10177") },
	sl_modifier_bless_10177
)
____exports.sl_modifier_bless_10177 = sl_modifier_bless_10177
____exports.sl_modifier_bless_10177_cd = __TS__Class()
local sl_modifier_bless_10177_cd = ____exports.sl_modifier_bless_10177_cd
sl_modifier_bless_10177_cd.name = "sl_modifier_bless_10177_cd"
__TS__ClassExtends(sl_modifier_bless_10177_cd, SLModifierBase)
function sl_modifier_bless_10177_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10177_cd.prototype.GetTexture(self)
	return "buff/bless/10177"
end
sl_modifier_bless_10177_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10177") },
	sl_modifier_bless_10177_cd
)
____exports.sl_modifier_bless_10177_cd = sl_modifier_bless_10177_cd
return ____exports