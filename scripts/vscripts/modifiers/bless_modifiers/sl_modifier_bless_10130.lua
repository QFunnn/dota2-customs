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
local sl_modifier_debuff_immune = ____sl_modifier_simple.sl_modifier_debuff_immune
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10130 = __TS__Class()
local sl_modifier_bless_10130 = ____exports.sl_modifier_bless_10130
sl_modifier_bless_10130.name = "sl_modifier_bless_10130"
__TS__ClassExtends(sl_modifier_bless_10130, sl_modifier_transmitter_data)
function sl_modifier_bless_10130.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10130.prototype.GetTexture(self)
	return "buff/bless/10130"
end
function sl_modifier_bless_10130.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_EXTRA_HEALTH_PERCENTAGE }
end
function sl_modifier_bless_10130.prototype.GetModifierExtraHealthPercentage(self)
	local ____table__params_hp_pct_0 = self._params
	if ____table__params_hp_pct_0 ~= nil then
		____table__params_hp_pct_0 = ____table__params_hp_pct_0.hp_pct
	end
	return ____table__params_hp_pct_0
end
sl_modifier_bless_10130 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10130") },
	sl_modifier_bless_10130
)
____exports.sl_modifier_bless_10130 = sl_modifier_bless_10130
____exports.sl_modifier_bless_10130_immune = __TS__Class()
local sl_modifier_bless_10130_immune = ____exports.sl_modifier_bless_10130_immune
sl_modifier_bless_10130_immune.name = "sl_modifier_bless_10130_immune"
__TS__ClassExtends(sl_modifier_bless_10130_immune, sl_modifier_debuff_immune)
function sl_modifier_bless_10130_immune.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10130_immune.prototype.GetTexture(self)
	return "buff/bless/10130"
end
sl_modifier_bless_10130_immune = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10130") },
	sl_modifier_bless_10130_immune
)
____exports.sl_modifier_bless_10130_immune = sl_modifier_bless_10130_immune
return ____exports