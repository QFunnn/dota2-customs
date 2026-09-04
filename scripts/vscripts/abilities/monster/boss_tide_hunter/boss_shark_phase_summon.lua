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
local ____tide_hunter_ab4 = require("abilities.monster.boss_tide_hunter.tide_hunter_ab4")
local tide_hunter_ab4 = ____tide_hunter_ab4.tide_hunter_ab4
--- 鲨鱼恶霸每轮地面召唤数量减半，父类仍保持每轮 2 只。
local SHARK_POST_VOMIT_SUMMONS_PER_GESTURE = 1
--- 鲨鱼恶霸和潮汐猎人同模型，复用潮汐吐出小怪的转阶段演出。
____exports.boss_shark_phase_summon = __TS__Class()
local boss_shark_phase_summon = ____exports.boss_shark_phase_summon
boss_shark_phase_summon.name = "boss_shark_phase_summon"
__TS__ClassExtends(boss_shark_phase_summon, tide_hunter_ab4)
function boss_shark_phase_summon.prototype.GetVomitSummonUnitName(self)
	return "monster_10111"
end
function boss_shark_phase_summon.prototype.GetVomitSummonTag(self, caster)
	return "boss_shark_phase_summon_" .. caster:GetUnitName()
end
function boss_shark_phase_summon.prototype.GetPostVomitSummonsPerGesture(self)
	return SHARK_POST_VOMIT_SUMMONS_PER_GESTURE
end
boss_shark_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_shark_phase_summon)
____exports.boss_shark_phase_summon = boss_shark_phase_summon
return ____exports