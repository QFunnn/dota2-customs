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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_100051 = __TS__Class()
local sl_modifier_bless_100051 = ____exports.sl_modifier_bless_100051
sl_modifier_bless_100051.name = "sl_modifier_bless_100051"
__TS__ClassExtends(sl_modifier_bless_100051, SLModifierBase_Debuff)
function sl_modifier_bless_100051.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_100051.prototype.GetTexture(self)
	return "buff/bless/100051"
end
function sl_modifier_bless_100051.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_MUTED] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
	}
end
sl_modifier_bless_100051 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_100051") },
	sl_modifier_bless_100051
)
____exports.sl_modifier_bless_100051 = sl_modifier_bless_100051
return ____exports