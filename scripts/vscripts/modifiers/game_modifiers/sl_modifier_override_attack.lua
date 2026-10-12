--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/game_modifiers/sl_modifier_override_attack.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/game_modifiers/sl_modifier_override_attack.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["14"] = "4:1",
		["15"] = "5:14",
		["16"] = "4:1",
		["17"] = "5:42",
		["18"] = "6:5",
		["19"] = "7:9",
		["20"] = "6:5",
		["21"] = "12:5",
		["22"] = "13:14",
		["25"] = "14:9",
		["26"] = "12:5",
		["27"] = "17:5",
		["28"] = "18:14",
		["31"] = "19:9",
		["32"] = "17:5",
		["33"] = "5:14",
		["34"] = "4:2",
		["35"] = "4:2",
		["36"] = "4:19",
		["37"] = "4:2",
		["39"] = "4:2",
		["40"] = "5:14",
		["42"] = "5:14",
	}
)
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
	{ registerModifier(nil, "modifiers/game_modifiers/sl_modifier_override_attack", nil, getfenv()) },
	sl_modifier_override_attack
)
____exports.sl_modifier_override_attack = sl_modifier_override_attack
return ____exports