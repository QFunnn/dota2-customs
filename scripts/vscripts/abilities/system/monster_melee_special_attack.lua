--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local BaseAbility = ____dota_ts_adapter.BaseAbility
local registerAbility = ____dota_ts_adapter.registerAbility
____exports.monster_melee_special_attack = __TS__Class()
local monster_melee_special_attack = ____exports.monster_melee_special_attack
monster_melee_special_attack.name = "monster_melee_special_attack"
__TS__ClassExtends(monster_melee_special_attack, BaseAbility)
function monster_melee_special_attack.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN }
end
monster_melee_special_attack = __TS__DecorateLegacy({ registerAbility(nil) }, monster_melee_special_attack)
____exports.monster_melee_special_attack = monster_melee_special_attack
return ____exports