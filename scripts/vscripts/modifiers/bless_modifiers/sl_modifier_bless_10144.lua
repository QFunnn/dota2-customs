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
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10144 = __TS__Class()
local sl_modifier_bless_10144 = ____exports.sl_modifier_bless_10144
sl_modifier_bless_10144.name = "sl_modifier_bless_10144"
__TS__ClassExtends(sl_modifier_bless_10144, sl_modifier_transmitter_data)
function sl_modifier_bless_10144.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10144.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE }
end
function sl_modifier_bless_10144.prototype.GetTexture(self)
	return "buff/bless/10144"
end
function sl_modifier_bless_10144.prototype.GetModifierAttackSpeedPercentage(self)
	if not self._params then
		return
	end
	local ____self__params_0 = self._params
	local pct = ____self__params_0.pct
	local stack = ____self__params_0.stack
	local times = math.floor(self:GetStackCount() / stack)
	return pct * times
end
sl_modifier_bless_10144 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10144") },
	sl_modifier_bless_10144
)
____exports.sl_modifier_bless_10144 = sl_modifier_bless_10144
return ____exports