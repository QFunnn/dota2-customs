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
local SLModifierBase_Debuff = ____sl_modifier_base.SLModifierBase_Debuff
____exports.sl_modifier_bless_10214 = __TS__Class()
local sl_modifier_bless_10214 = ____exports.sl_modifier_bless_10214
sl_modifier_bless_10214.name = "sl_modifier_bless_10214"
__TS__ClassExtends(sl_modifier_bless_10214, sl_modifier_transmitter_data)
function sl_modifier_bless_10214.prototype.IsHidden(self)
	return true
end
function sl_modifier_bless_10214.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE }
end
function sl_modifier_bless_10214.prototype.GetModifierTotalDamageOutgoing_Percentage(self, event)
	local target = event.target
	if not IsValid(target) then
		return 0
	end
	if not target:HasSLModifier(____exports.sl_modifier_bless_10214_break) then
		return 0
	end
	local ____table__params_damage_amp_0 = self._params
	if ____table__params_damage_amp_0 ~= nil then
		____table__params_damage_amp_0 = ____table__params_damage_amp_0.damage_amp
	end
	local ____table__params_damage_amp_0_2 = ____table__params_damage_amp_0
	if ____table__params_damage_amp_0_2 == nil then
		____table__params_damage_amp_0_2 = 0
	end
	return ____table__params_damage_amp_0_2
end
sl_modifier_bless_10214 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10214") },
	sl_modifier_bless_10214
)
____exports.sl_modifier_bless_10214 = sl_modifier_bless_10214
____exports.sl_modifier_bless_10214_break = __TS__Class()
local sl_modifier_bless_10214_break = ____exports.sl_modifier_bless_10214_break
sl_modifier_bless_10214_break.name = "sl_modifier_bless_10214_break"
__TS__ClassExtends(sl_modifier_bless_10214_break, SLModifierBase_Debuff)
function sl_modifier_bless_10214_break.prototype.IsHidden(self)
	return false
end
function sl_modifier_bless_10214_break.prototype.GetTexture(self)
	return "buff/bless/10214"
end
function sl_modifier_bless_10214_break.prototype.IsPermanent(self)
	return false
end
function sl_modifier_bless_10214_break.prototype.RemoveOnDeath(self)
	return true
end
function sl_modifier_bless_10214_break.prototype.CheckState(self)
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end
sl_modifier_bless_10214_break = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10214") },
	sl_modifier_bless_10214_break
)
____exports.sl_modifier_bless_10214_break = sl_modifier_bless_10214_break
return ____exports