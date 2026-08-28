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
local sl_modifier_transmitter_data = ____sl_modifier_simple.sl_modifier_transmitter_data
____exports.sl_modifier_bless_10201 = __TS__Class()
local sl_modifier_bless_10201 = ____exports.sl_modifier_bless_10201
sl_modifier_bless_10201.name = "sl_modifier_bless_10201"
__TS__ClassExtends(sl_modifier_bless_10201, sl_modifier_transmitter_data)
function sl_modifier_bless_10201.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10201.prototype.GetTexture(self)
	return "buff/bless/10201"
end
function sl_modifier_bless_10201.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE }
end
function sl_modifier_bless_10201.prototype.GetModifierIncomingDamage_Percentage(self, event)
	local ____table__params_cs_pct_0 = self._params
	if ____table__params_cs_pct_0 ~= nil then
		____table__params_cs_pct_0 = ____table__params_cs_pct_0.cs_pct
	end
	local ____table__params_cs_pct_0_2 = ____table__params_cs_pct_0
	if ____table__params_cs_pct_0_2 == nil then
		____table__params_cs_pct_0_2 = 0
	end
	return ____table__params_cs_pct_0_2 * self:GetStackCount()
end
sl_modifier_bless_10201 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10201") },
	sl_modifier_bless_10201
)
____exports.sl_modifier_bless_10201 = sl_modifier_bless_10201
____exports.sl_modifier_bless_10201_amp = __TS__Class()
local sl_modifier_bless_10201_amp = ____exports.sl_modifier_bless_10201_amp
sl_modifier_bless_10201_amp.name = "sl_modifier_bless_10201_amp"
__TS__ClassExtends(sl_modifier_bless_10201_amp, sl_modifier_transmitter_data)
function sl_modifier_bless_10201_amp.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10201_amp.prototype.GetTexture(self)
	return "buff/bless/10201"
end
function sl_modifier_bless_10201_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10201_amp.prototype.GetModifierSpellAmplify_Percentage(self, event)
	local ____table__params_amp_3 = self._params
	if ____table__params_amp_3 ~= nil then
		____table__params_amp_3 = ____table__params_amp_3.amp
	end
	return ____table__params_amp_3
end
sl_modifier_bless_10201_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10201") },
	sl_modifier_bless_10201_amp
)
____exports.sl_modifier_bless_10201_amp = sl_modifier_bless_10201_amp
return ____exports