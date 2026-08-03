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
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
____exports.sl_modifier_override_attack = __TS__Class()
local sl_modifier_override_attack = ____exports.sl_modifier_override_attack
sl_modifier_override_attack.name = "sl_modifier_override_attack"
__TS__ClassExtends(sl_modifier_override_attack, SLModifierBase)
function sl_modifier_override_attack.prototype.DeclareFunctions(self)
	return { MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE }
end
function sl_modifier_override_attack.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self._attack = params.attack
end
function sl_modifier_override_attack.prototype.GetModifierOverrideAttackDamage(self)
	if not IsServer() then
		return
	end
	return self._attack
end
sl_modifier_override_attack = __TS__Decorate(
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_override_attack") },
	sl_modifier_override_attack
)
____exports.sl_modifier_override_attack = sl_modifier_override_attack
return ____exports