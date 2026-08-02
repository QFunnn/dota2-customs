--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_shield_all = ____sl_modifier_simple.sl_modifier_shield_all
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10053 = __TS__Class()
local sl_modifier_bless_10053 = ____exports.sl_modifier_bless_10053
sl_modifier_bless_10053.name = "sl_modifier_bless_10053"
__TS__ClassExtends(sl_modifier_bless_10053, sl_modifier_shield_all)
function sl_modifier_bless_10053.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
sl_modifier_bless_10053 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10053") },
	sl_modifier_bless_10053
)
____exports.sl_modifier_bless_10053 = sl_modifier_bless_10053
____exports.sl_modifier_bless_10053_cd = __TS__Class()
local sl_modifier_bless_10053_cd = ____exports.sl_modifier_bless_10053_cd
sl_modifier_bless_10053_cd.name = "sl_modifier_bless_10053_cd"
__TS__ClassExtends(sl_modifier_bless_10053_cd, SLModifierBase)
function sl_modifier_bless_10053_cd.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10053_cd.prototype.GetTexture(self)
	return "buff/bless/10053"
end
sl_modifier_bless_10053_cd = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10053") },
	sl_modifier_bless_10053_cd
)
____exports.sl_modifier_bless_10053_cd = sl_modifier_bless_10053_cd
return ____exports