--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local ____exports = {}
local ____boss_encounter_scaling = require("utils.boss_encounter_scaling")
local GetNearbyEnemyPlayerShareMultiplier = ____boss_encounter_scaling.GetNearbyEnemyPlayerShareMultiplier
--- 姿态条数值规则，集中维护涨条、衰减、硬直和多人缩放公式。
____exports.PostureBarRules = __TS__Class()
local PostureBarRules = ____exports.PostureBarRules
PostureBarRules.name = "PostureBarRules"
function PostureBarRules.prototype.____constructor(self) end
function PostureBarRules.GetNearbyPlayerMultiplier(self, unit)
	return GetNearbyEnemyPlayerShareMultiplier(nil, unit)
end
function PostureBarRules.GetDamagePostureGain(self, hpLost, maxHp, nearbyPlayerMultiplier)
	if maxHp <= 0 or hpLost <= 0 then
		return 0
	end
	local damagePct = hpLost / maxHp * 100
	return math.floor(damagePct * ____exports.PostureBarRules.POSTURE_PER_HP_PCT * nearbyPlayerMultiplier)
end
function PostureBarRules.AddStack(self, current, add, threshold)
	return math.min(threshold, current + math.max(0, add))
end
function PostureBarRules.GetCounterHitBonus(self, threshold)
	return math.floor(threshold * (____exports.PostureBarRules.COUNTER_HIT_BONUS_PCT / 100))
end
function PostureBarRules.GetSkillCastDecay(self, threshold)
	return math.floor(threshold * (____exports.PostureBarRules.SKILL_CAST_POSTURE_DECAY_PCT / 100))
end
function PostureBarRules.GetDamageTakenPct(self, hpLost, maxHp)
	if maxHp <= 0 or hpLost <= 0 then
		return 0
	end
	return hpLost / maxHp * 100
end
function PostureBarRules.GetStaggerReduceSeconds(self, damageTakenDuringStaggerPct)
	return math.min(
		____exports.PostureBarRules.STAGGER_DURATION,
		math.floor(damageTakenDuringStaggerPct / ____exports.PostureBarRules.DAMAGE_PCT_TO_REDUCE_STAGGER_SEC)
	)
end
function PostureBarRules.GetStaggerEndTime(self, staggerStartTime, damageTakenDuringStaggerPct)
	return staggerStartTime
		+ ____exports.PostureBarRules.STAGGER_DURATION
		- ____exports.PostureBarRules:GetStaggerReduceSeconds(damageTakenDuringStaggerPct)
end
function PostureBarRules.GetDecaySteps(self, elapsedSeconds)
	return math.floor(elapsedSeconds)
end
function PostureBarRules.ApplyNaturalDecay(self, current, steps)
	return math.max(0, current - steps * ____exports.PostureBarRules.DECAY_PER_SECOND)
end
function PostureBarRules.GetStaggerStackDisplay(self, remainingSeconds, initialStaggerDuration, threshold)
	if initialStaggerDuration <= 0 or threshold <= 0 then
		return 0
	end
	local ratio = math.max(0, remainingSeconds) / initialStaggerDuration
	return math.ceil(ratio * threshold)
end
PostureBarRules.DEFAULT_THRESHOLD = 100
PostureBarRules.DECAY_PER_SECOND = 0
PostureBarRules.STAGGER_DURATION = 8
PostureBarRules.POSTURE_PER_HP_PCT = 1
PostureBarRules.SKILL_CAST_POSTURE_DECAY_PCT = 3
PostureBarRules.NATIVE_STUN_MODIFIER = "modifier_generic_stunned"
PostureBarRules.NATIVE_STUN_GENERIC = "modifier_generic_stunned"
PostureBarRules.DAMAGE_PCT_TO_REDUCE_STAGGER_SEC = 5
PostureBarRules.STUN_ACCUMULATE_INTERVAL = 0.03
PostureBarRules.STUN_POSTURE_ADD_PER_INTERVAL = 2
PostureBarRules.COUNTER_HIT_BONUS_PCT = 15
return ____exports