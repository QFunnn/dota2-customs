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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_bless_10174 = __TS__Class()
local sl_modifier_bless_10174 = ____exports.sl_modifier_bless_10174
sl_modifier_bless_10174.name = "sl_modifier_bless_10174"
__TS__ClassExtends(sl_modifier_bless_10174, SLModifierBase)
function sl_modifier_bless_10174.prototype.____constructor(self, ...)
	SLModifierBase.prototype.____constructor(self, ...)
	self._ability_extra_amp_value_map = {}
end
function sl_modifier_bless_10174.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE }
end
function sl_modifier_bless_10174.prototype.GetModifierSpellAmplify_Percentage(self, event)
	if not IsServer() then
		return
	end
	local ____event_0 = event
	local attacker = ____event_0.attacker
	local inflictor = ____event_0.inflictor
	if not IsValid(inflictor) then
		return
	end
	local parent = self:GetParent()
	if parent ~= attacker then
		return
	end
	local ability_name = inflictor:GetAbilityName()
	local ____self__ability_extra_amp_value_map_ability_name_1 = self._ability_extra_amp_value_map[ability_name]
	if ____self__ability_extra_amp_value_map_ability_name_1 == nil then
		____self__ability_extra_amp_value_map_ability_name_1 = 0
	end
	return ____self__ability_extra_amp_value_map_ability_name_1
end
function sl_modifier_bless_10174.prototype.SetAbilityExtraAmpValue(self, ability, value)
	self._ability_extra_amp_value_map[ability] = value
end
sl_modifier_bless_10174 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10174") },
	sl_modifier_bless_10174
)
____exports.sl_modifier_bless_10174 = sl_modifier_bless_10174
return ____exports