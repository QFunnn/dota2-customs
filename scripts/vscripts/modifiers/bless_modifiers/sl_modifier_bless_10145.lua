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
local ____sl_modifier_simple = require("modifiers.game_modifiers.sl_modifier_simple")
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10145 = __TS__Class()
local sl_modifier_bless_10145 = ____exports.sl_modifier_bless_10145
sl_modifier_bless_10145.name = "sl_modifier_bless_10145"
__TS__ClassExtends(sl_modifier_bless_10145, sl_modifier_transmitter_data)
function sl_modifier_bless_10145.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10145.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE }
end
function sl_modifier_bless_10145.prototype.GetTexture(self)
	return "buff/bless/10145"
end
function sl_modifier_bless_10145.prototype.GetModifierPercentageCooldown(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
function sl_modifier_bless_10145.prototype.ModifyAttr(self, value)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	local ____table__params_pct_2_4 = ____table__params_pct_2
	if ____table__params_pct_2_4 == nil then
		____table__params_pct_2_4 = 0
	end
	local current_pct = ____table__params_pct_2_4
	self._params = { pct = current_pct + value, update_data = 1 }
	self:_ApplyParams(self._params)
end
sl_modifier_bless_10145 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10145") },
	sl_modifier_bless_10145
)
____exports.sl_modifier_bless_10145 = sl_modifier_bless_10145
return ____exports