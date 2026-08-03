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
--- 10189
____exports.sl_modifier_bless_10189 = __TS__Class()
local sl_modifier_bless_10189 = ____exports.sl_modifier_bless_10189
sl_modifier_bless_10189.name = "sl_modifier_bless_10189"
__TS__ClassExtends(sl_modifier_bless_10189, SLModifierBase)
function sl_modifier_bless_10189.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT }
end
function sl_modifier_bless_10189.prototype.GetModifierAttackSpeed_Limit(self)
	return 1
end
sl_modifier_bless_10189 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10189") },
	sl_modifier_bless_10189
)
____exports.sl_modifier_bless_10189 = sl_modifier_bless_10189
return ____exports