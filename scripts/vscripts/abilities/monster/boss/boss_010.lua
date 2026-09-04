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
--- Boss技能10 - 待实现
____exports.boss_010 = __TS__Class()
local boss_010 = ____exports.boss_010
boss_010.name = "boss_010"
__TS__ClassExtends(boss_010, MonsterAbility_CS)
boss_010 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_010)
____exports.boss_010 = boss_010
return ____exports