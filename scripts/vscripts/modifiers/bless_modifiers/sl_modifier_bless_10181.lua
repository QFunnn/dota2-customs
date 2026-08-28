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
local sl_modifier_invisible = ____sl_modifier_simple.sl_modifier_invisible
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10181 = __TS__Class()
local sl_modifier_bless_10181 = ____exports.sl_modifier_bless_10181
sl_modifier_bless_10181.name = "sl_modifier_bless_10181"
__TS__ClassExtends(sl_modifier_bless_10181, sl_modifier_transmitter_data)
function sl_modifier_bless_10181.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10181.prototype.GetTexture(self)
	return "buff/bless/10181"
end
function sl_modifier_bless_10181.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end
function sl_modifier_bless_10181.prototype.GetModifierMoveSpeedBonus_Percentage(self)
	local ____table__params_ms_pct_0 = self._params
	if ____table__params_ms_pct_0 ~= nil then
		____table__params_ms_pct_0 = ____table__params_ms_pct_0.ms_pct
	end
	return ____table__params_ms_pct_0
end
sl_modifier_bless_10181 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10181") },
	sl_modifier_bless_10181
)
____exports.sl_modifier_bless_10181 = sl_modifier_bless_10181
____exports.sl_modifier_bless_10181_invis = __TS__Class()
local sl_modifier_bless_10181_invis = ____exports.sl_modifier_bless_10181_invis
sl_modifier_bless_10181_invis.name = "sl_modifier_bless_10181_invis"
__TS__ClassExtends(sl_modifier_bless_10181_invis, sl_modifier_invisible)
function sl_modifier_bless_10181_invis.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10181_invis.prototype.GetTexture(self)
	return "buff/bless/10181"
end
sl_modifier_bless_10181_invis = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10181") },
	sl_modifier_bless_10181_invis
)
____exports.sl_modifier_bless_10181_invis = sl_modifier_bless_10181_invis
return ____exports