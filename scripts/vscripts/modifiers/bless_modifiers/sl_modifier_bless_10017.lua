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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_pre_attack_damage = ____sl_modifier_simple.sl_modifier_pre_attack_damage
--- 10017 攻击力
____exports.sl_modifier_bless_10017 = __TS__Class()
local sl_modifier_bless_10017 = ____exports.sl_modifier_bless_10017
sl_modifier_bless_10017.name = "sl_modifier_bless_10017"
__TS__ClassExtends(sl_modifier_bless_10017, sl_modifier_pre_attack_damage)
function sl_modifier_bless_10017.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10017.prototype.GetTexture(self)
	return "buff/bless/10017"
end
sl_modifier_bless_10017 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10017") },
	sl_modifier_bless_10017
)
____exports.sl_modifier_bless_10017 = sl_modifier_bless_10017
return ____exports