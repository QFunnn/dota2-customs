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
local ____sl_modifier_custom_knockback = require("modifiers.game_modifiers.sl_modifier_custom_knockback")
local sl_modifier_custom_knockback = ____sl_modifier_custom_knockback.sl_modifier_custom_knockback
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_21002_ready = __TS__Class()
local sl_modifier_bless_21002_ready = ____exports.sl_modifier_bless_21002_ready
sl_modifier_bless_21002_ready.name = "sl_modifier_bless_21002_ready"
__TS__ClassExtends(sl_modifier_bless_21002_ready, SLModifierBase)
function sl_modifier_bless_21002_ready.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_ready.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_ready = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002") },
	sl_modifier_bless_21002_ready
)
____exports.sl_modifier_bless_21002_ready = sl_modifier_bless_21002_ready
____exports.sl_modifier_bless_21002_cd = __TS__Class()
local sl_modifier_bless_21002_cd = ____exports.sl_modifier_bless_21002_cd
sl_modifier_bless_21002_cd.name = "sl_modifier_bless_21002_cd"
__TS__ClassExtends(sl_modifier_bless_21002_cd, SLModifierBase)
function sl_modifier_bless_21002_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_cd.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002") },
	sl_modifier_bless_21002_cd
)
____exports.sl_modifier_bless_21002_cd = sl_modifier_bless_21002_cd
____exports.sl_modifier_bless_21002_buff = __TS__Class()
local sl_modifier_bless_21002_buff = ____exports.sl_modifier_bless_21002_buff
sl_modifier_bless_21002_buff.name = "sl_modifier_bless_21002_buff"
__TS__ClassExtends(sl_modifier_bless_21002_buff, SLModifierBase)
function sl_modifier_bless_21002_buff.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_21002_buff.prototype.GetTexture(self)
	return "buff/bless/21002"
end
sl_modifier_bless_21002_buff = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002") },
	sl_modifier_bless_21002_buff
)
____exports.sl_modifier_bless_21002_buff = sl_modifier_bless_21002_buff
____exports.sl_modifier_bless_21002_knockback = __TS__Class()
local sl_modifier_bless_21002_knockback = ____exports.sl_modifier_bless_21002_knockback
sl_modifier_bless_21002_knockback.name = "sl_modifier_bless_21002_knockback"
__TS__ClassExtends(sl_modifier_bless_21002_knockback, sl_modifier_custom_knockback)
sl_modifier_bless_21002_knockback = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_21002") },
	sl_modifier_bless_21002_knockback
)
____exports.sl_modifier_bless_21002_knockback = sl_modifier_bless_21002_knockback
return ____exports