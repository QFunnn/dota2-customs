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
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
____exports.boss_old_phantom_phase_summon = __TS__Class()
local boss_old_phantom_phase_summon = ____exports.boss_old_phantom_phase_summon
boss_old_phantom_phase_summon.name = "boss_old_phantom_phase_summon"
__TS__ClassExtends(boss_old_phantom_phase_summon, boss_simple_phase_summon)
function boss_old_phantom_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_10043",
		note = "旧版绝影：无 Appear，按 6 级普通怪综合线兜底，豺狼人刺客",
	}
end
boss_old_phantom_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_old_phantom_phase_summon)
____exports.boss_old_phantom_phase_summon = boss_old_phantom_phase_summon
return ____exports