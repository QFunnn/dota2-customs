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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10175_atk = __TS__Class()
local sl_modifier_bless_10175_atk = ____exports.sl_modifier_bless_10175_atk
sl_modifier_bless_10175_atk.name = "sl_modifier_bless_10175_atk"
__TS__ClassExtends(sl_modifier_bless_10175_atk, sl_modifier_transmitter_data)
function sl_modifier_bless_10175_atk.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10175_atk.prototype.GetTexture(self)
	return "buff/bless/10175_atk"
end
function sl_modifier_bless_10175_atk.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10175_atk.prototype.GetModifierBaseDamageOutgoing_Percentage(self, event)
	local ____table__params_pct_0 = self._params
	if ____table__params_pct_0 ~= nil then
		____table__params_pct_0 = ____table__params_pct_0.pct
	end
	return ____table__params_pct_0
end
sl_modifier_bless_10175_atk = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175") },
	sl_modifier_bless_10175_atk
)
____exports.sl_modifier_bless_10175_atk = sl_modifier_bless_10175_atk
____exports.sl_modifier_bless_10175_amp_show = __TS__Class()
local sl_modifier_bless_10175_amp_show = ____exports.sl_modifier_bless_10175_amp_show
sl_modifier_bless_10175_amp_show.name = "sl_modifier_bless_10175_amp_show"
__TS__ClassExtends(sl_modifier_bless_10175_amp_show, sl_modifier_transmitter_data)
function sl_modifier_bless_10175_amp_show.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10175_amp_show.prototype.GetTexture(self)
	return "buff/bless/10175_amp"
end
function sl_modifier_bless_10175_amp_show.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOOLTIP }
end
function sl_modifier_bless_10175_amp_show.prototype.OnTooltip(self)
	local ____table__params_pct_2 = self._params
	if ____table__params_pct_2 ~= nil then
		____table__params_pct_2 = ____table__params_pct_2.pct
	end
	return ____table__params_pct_2 * self:GetStackCount()
end
sl_modifier_bless_10175_amp_show = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175") },
	sl_modifier_bless_10175_amp_show
)
____exports.sl_modifier_bless_10175_amp_show = sl_modifier_bless_10175_amp_show
____exports.sl_modifier_bless_10175_amp = __TS__Class()
local sl_modifier_bless_10175_amp = ____exports.sl_modifier_bless_10175_amp
sl_modifier_bless_10175_amp.name = "sl_modifier_bless_10175_amp"
__TS__ClassExtends(sl_modifier_bless_10175_amp, SLModifierBase)
function sl_modifier_bless_10175_amp.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._ability_extra_amp_value_map = {}
end
function sl_modifier_bless_10175_amp.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10175_amp.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_4 = event
	local attacker = ____event_4.attacker
	local inflictor = ____event_4.inflictor
	if not IsValid(inflictor) then
		return
	end
	local parent = self:GetParent()
	if parent ~= attacker then
		return
	end
	local ability_name = inflictor:GetAbilityName()
	local ____self__ability_extra_amp_value_map_ability_name_5 = self._ability_extra_amp_value_map[ability_name]
	if ____self__ability_extra_amp_value_map_ability_name_5 == nil then
		____self__ability_extra_amp_value_map_ability_name_5 = 0
	end
	return ____self__ability_extra_amp_value_map_ability_name_5
end
function sl_modifier_bless_10175_amp.prototype.SetAbilityExtraAmpValue(self, ability, value)
	self._ability_extra_amp_value_map[ability] = value
end
sl_modifier_bless_10175_amp = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10175") },
	sl_modifier_bless_10175_amp
)
____exports.sl_modifier_bless_10175_amp = sl_modifier_bless_10175_amp
return ____exports