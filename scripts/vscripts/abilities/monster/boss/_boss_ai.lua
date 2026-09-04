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
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
____exports.boss_ai = __TS__Class()
local boss_ai = ____exports.boss_ai
boss_ai.name = "boss_ai"
__TS__ClassExtends(boss_ai, MonsterAbility_CS)
function boss_ai.prototype.GetAbilityConfig(self)
	return { behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE }
end
function boss_ai.prototype.GetIntrinsicModifierName(self)
	return "modifier_boss_ai_test"
end
boss_ai = __TS__DecorateLegacy({ registerAbility(nil) }, boss_ai)
____exports.boss_ai = boss_ai
return ____exports