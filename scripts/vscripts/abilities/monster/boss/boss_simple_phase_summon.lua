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
local ____boss_phase_transition_ability = require("abilities.monster.boss.boss_phase_transition_ability")
local BossPhaseTransitionAbility_CS = ____boss_phase_transition_ability.BossPhaseTransitionAbility_CS
____exports.SIMPLE_PHASE_DURATION = 6
____exports.SIMPLE_PHASE_MOVE_DURATION = 0.6
____exports.SIMPLE_PHASE_SUMMON_DELAY = 0.65
____exports.SIMPLE_PHASE_SUMMON_COUNT = 5
____exports.SIMPLE_PHASE_SUMMON_RADIUS = 620
____exports.SIMPLE_PHASE_EFFECT_INTERVAL = 1.5
____exports.SIMPLE_PHASE_EFFECT = "particles/boss/boss_004debuff.vpcf"
____exports.SIMPLE_PHASE_SOUND = "Hero_Tidehunter.Ravage"
--- 通用简单 Boss 转阶段召唤模板：回出生点，召唤单位，播放动作，结束后加二阶段 Buff。
____exports.boss_simple_phase_summon = __TS__Class()
local boss_simple_phase_summon = ____exports.boss_simple_phase_summon
boss_simple_phase_summon.name = "boss_simple_phase_summon"
__TS__ClassExtends(boss_simple_phase_summon, BossPhaseTransitionAbility_CS)
function boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", ____exports.SIMPLE_PHASE_EFFECT, context)
end
function boss_simple_phase_summon.prototype.GetBossPhaseTransitionReturnToSpawnDuration(self)
	return ____exports.SIMPLE_PHASE_MOVE_DURATION
end
function boss_simple_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return ____exports.SIMPLE_PHASE_DURATION
end
function boss_simple_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_CAST_ABILITY_3
end
function boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_HIDDEN,
		castPoint = 0,
		castDuration = self:GetBossPhaseTransitionWindowDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_3,
		animationPlaybackRate = 1,
		isNotMove = true,
		canCast = function()
			local ____table_GetCurrentConfig_result_0
			if self:GetCurrentConfig() then
				____table_GetCurrentConfig_result_0 = UF_SUCCESS
			else
				____table_GetCurrentConfig_result_0 = UF_FAIL_CUSTOM
			end
			return ____table_GetCurrentConfig_result_0
		end,
		castError = function()
			return "当前 Boss 未配置转阶段召唤单位"
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local config = self:GetCurrentConfig()
			if not IsValidAlive(nil, caster) or not config then
				return
			end
			self:Timer(____exports.SIMPLE_PHASE_SUMMON_DELAY, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local center = self:ResolveCenterPoint(caster)
				self:SummonPhaseMonsters(caster, config, center)
				self:StartSummonEffectLoop(caster, center)
			end)
		end,
	}
end
function boss_simple_phase_summon.prototype.GetCurrentConfig(self)
	return self:GetSimplePhaseSummonConfig()
end
function boss_simple_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return nil
end
function boss_simple_phase_summon.prototype.ResolveCenterPoint(self, caster)
	local ____this_2
	____this_2 = caster
	local ____opt_1 = ____this_2.GetSpawnPoint
	local spawnPoint = ____opt_1 and ____opt_1(____this_2)
	return GetGroundPosition(spawnPoint or caster:GetAbsOrigin(), caster)
end
function boss_simple_phase_summon.prototype.SummonPhaseMonsters(self, caster, config, center)
	local roomId = caster:GetRoomId()
	local summonCount = math.max(1, config.summonCount or ____exports.SIMPLE_PHASE_SUMMON_COUNT)
	EmitSoundOnLocationWithCaster(center, ____exports.SIMPLE_PHASE_SOUND, caster)
	do
		local i = 0
		while i < summonCount do
			local currentIndex = i
			local angle = math.pi * 2 * currentIndex / summonCount
			local offset = Vector(
				math.cos(angle) * ____exports.SIMPLE_PHASE_SUMMON_RADIUS,
				math.sin(angle) * ____exports.SIMPLE_PHASE_SUMMON_RADIUS,
				0
			)
			local summonPos = GetGroundPosition(center:__add(offset), caster)
			local currentSummonPos = summonPos
			self:PlaySummonEffect(currentSummonPos, caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = summonCount,
				position = currentSummonPos,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValidAlive(nil, unit) then
						return
					end
					if not IsValidAlive(nil, caster) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
					unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, currentSummonPos, caster:GetAbsOrigin()))
					local ____this_4
					____this_4 = config
					local ____opt_3 = ____this_4.onSummonSpawn
					if ____opt_3 ~= nil then
						____opt_3(____this_4, unit, caster, currentSummonPos, center, currentIndex)
					end
				end,
			})
			i = i + 1
		end
	end
end
function boss_simple_phase_summon.prototype.StartSummonEffectLoop(self, caster, center)
	local elapsed = ____exports.SIMPLE_PHASE_SUMMON_DELAY
	self:Timer(____exports.SIMPLE_PHASE_EFFECT_INTERVAL, function()
		if not IsValidAlive(nil, caster) then
			return nil
		end
		elapsed = elapsed + ____exports.SIMPLE_PHASE_EFFECT_INTERVAL
		if elapsed >= self:GetBossPhaseTransitionWindowDuration() then
			return nil
		end
		self:PlaySummonEffect(center, caster)
		EmitSoundOnLocationWithCaster(center, ____exports.SIMPLE_PHASE_SOUND, caster)
		return ____exports.SIMPLE_PHASE_EFFECT_INTERVAL
	end)
end
function boss_simple_phase_summon.prototype.PlaySummonEffect(self, position, caster)
	local effect = ParticleManager:CreateParticle(____exports.SIMPLE_PHASE_EFFECT, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, position)
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(1, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
boss_simple_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_simple_phase_summon)
____exports.boss_simple_phase_summon = boss_simple_phase_summon
return ____exports