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
--- 天穹守望者占位技能2。
____exports.boss_arc_warden_2 = __TS__Class()
local boss_arc_warden_2 = ____exports.boss_arc_warden_2
boss_arc_warden_2.name = "boss_arc_warden_2"
__TS__ClassExtends(boss_arc_warden_2, MonsterAbility_CS)
boss_arc_warden_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_arc_warden_2)
____exports.boss_arc_warden_2 = boss_arc_warden_2
return ____exports