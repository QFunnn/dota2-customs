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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_damage_output = ____sl_modifier_simple.sl_modifier_damage_output
____exports.sl_modifier_bless_10120 = __TS__Class()
local sl_modifier_bless_10120 = ____exports.sl_modifier_bless_10120
sl_modifier_bless_10120.name = "sl_modifier_bless_10120"
__TS__ClassExtends(sl_modifier_bless_10120, sl_modifier_damage_output)
function sl_modifier_bless_10120.prototype.GetTexture(self)
	return "buff/bless/10120"
end
function sl_modifier_bless_10120.prototype.GetAttributes(self)
	return MODIFIER_ATTRIBUTE_MULTIPLE
end
function sl_modifier_bless_10120.prototype.IsHidden(self)
	return false
end
sl_modifier_bless_10120 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10120") },
	sl_modifier_bless_10120
)
____exports.sl_modifier_bless_10120 = sl_modifier_bless_10120
return ____exports