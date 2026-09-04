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
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local Set = ____lualib.Set
local __TS__New = ____lualib.__TS__New
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____boss_simple_phase_summon = require("abilities.monster.boss.boss_simple_phase_summon")
local boss_simple_phase_summon = ____boss_simple_phase_summon.boss_simple_phase_summon
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local warningEffectLinear = ____monster_warning_effects.warningEffectLinear
local ____secondary_hero_context = require("my_game_axe.secondary_hero.secondary_hero_context")
local IsPlayerCombatTarget = ____secondary_hero_context.IsPlayerCombatTarget
local ____elite_144 = require("abilities.monster.elite.elite_144")
local modifier_elite_144 = ____elite_144.modifier_elite_144
local ____warlock_soul_slash = require("abilities.monster.boss_warlock.warlock_soul_slash")
local modifier_warlock_soul_slash_actor = ____warlock_soul_slash.modifier_warlock_soul_slash_actor
local modifier_warlock_soul_slash_aura = ____warlock_soul_slash.modifier_warlock_soul_slash_aura
--- 魂灯转阶段连斩窗口总时长，覆盖六名剑客依次冲刺及收尾，单位：秒。
local WARLOCK_PHASE_DURATION = 8.5
--- 参与连斩演出的地狱剑士数量。
local ACTOR_COUNT = 5
--- 地狱剑士部署点与出生点中心的距离。
local ACTOR_DISTANCE = 900
--- 地狱剑士从 Boss 身上散开至部署点的时间，单位：秒。
local ACTOR_DEPLOY_DURATION = 0.4
--- 地狱剑士搜索最近玩家的最大范围。
local TARGET_SEARCH_RANGE = 3000
--- 单个地狱剑士从开始预警到发动冲刺的总瞄准时间，单位：秒。
local WARNING_DURATION = 0.7
--- 瞄准阶段中持续跟踪玩家方向的时间，结束后锁定方向，单位：秒。
local TARGET_TRACK_DURATION = 0.35
--- 直线预警与冲刺命中判定的基础宽度。
local WARNING_WIDTH = 160
--- 地狱剑士蓄力时向后撤步的距离。
local BACKSTEP_DISTANCE = 150
--- 地狱剑士蓄力时向后撤步的时间，单位：秒。
local BACKSTEP_DURATION = 0.25
--- 地狱剑士完成单次冲刺的时间，单位：秒。
local DASH_DURATION = 0.2
--- 地狱剑士每次冲刺的固定距离。
local DASH_DISTANCE = 1000
--- 冲刺线段伤害与轨迹特效同步结算的命中宽度。
local DASH_HIT_RADIUS = 160
--- 单个地狱剑士冲刺命中时使用的怪物伤害倍率。
local DASH_DAMAGE_RATE = 10
--- 相邻地狱剑士开始预警的间隔，独立于预警时长；同样决定冲刺伤害触发间隔。
local ACTOR_START_INTERVAL = 1
--- 复用 elite_144 的冲刺蓄力特效。
local SLASH_CHARGE_PARTICLE = "particles/bb/ss_primal_beast_2022_prestige_onslaught_charge_active_test2.vpcf"
--- 复用 elite_144 的斩击刀光特效。
local SLASH_ATTACK_PARTICLE = "particles/dd/attack_01.vpcf"
--- 技能期间显示内圈安全区与外圈伤害区域的静态风暴特效。
local AURA_EFFECT = "particles/monster/boss_warlock/warlock_static_storm.vpcf"
--- 召唤物出场时播放的混沌之雨落地表现。
local WARLOCK_PHASE_SUMMON_SPAWN_PARTICLE = "particles/units/heroes/hero_warlock/warlock_rain_of_chaos.vpcf"
--- 召唤物出场粒子保留时长，单位：秒。
local WARLOCK_PHASE_SUMMON_SPAWN_PARTICLE_LIFETIME = 2
--- 地狱剑士开始蓄力时播放的音效。
local SLASH_CHARGE_SOUND = "Hero_Weaver.Swarm.Cast"
--- 地狱剑士发动冲刺斩击时播放的音效。
local SLASH_START_SOUND = "Hero_Windrunner.ShackleshotCast"
--- Boss 转阶段召唤音效。
local WARLOCK_PHASE_SUMMON_SOUND = "Hero_Warlock.RainOfChaos_buildup"
____exports.boss_warlock_phase_summon = __TS__Class()
local boss_warlock_phase_summon = ____exports.boss_warlock_phase_summon
boss_warlock_phase_summon.name = "boss_warlock_phase_summon"
__TS__ClassExtends(boss_warlock_phase_summon, boss_simple_phase_summon)
function boss_warlock_phase_summon.prototype.____constructor(self, ...)
	boss_simple_phase_summon.prototype.____constructor(self, ...)
	self.sequenceId = 0
	self.actorIndices = {}
	self.actorQueue = {}
	self.remainingActors = 0
	self.sequenceEnding = false
end
function boss_warlock_phase_summon.prototype.Precache(self, context)
	boss_simple_phase_summon.prototype.Precache(self, context)
	PrecacheResource("particle", SLASH_CHARGE_PARTICLE, context)
	PrecacheResource("particle", SLASH_ATTACK_PARTICLE, context)
	PrecacheResource("particle", AURA_EFFECT, context)
	PrecacheResource("particle", WARLOCK_PHASE_SUMMON_SPAWN_PARTICLE, context)
end
function boss_warlock_phase_summon.prototype.GetBossPhaseTransitionWindowDuration(self)
	return WARLOCK_PHASE_DURATION
end
function boss_warlock_phase_summon.prototype.GetBossPhaseTransitionGesture(self)
	return ACT_DOTA_CAST_ABILITY_4
end
function boss_warlock_phase_summon.prototype.GetBossPhaseTransitionGesturePlaybackRate(self)
	return 0.9
end
function boss_warlock_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	local cfg = boss_simple_phase_summon.prototype.GetBossPhaseTransitionConfig(self)
	return __TS__ObjectAssign({}, cfg, {
		OnStart = function()
			self:BeginSoulSlashPhase()
			local ____opt_0 = cfg.OnStart
			if ____opt_0 ~= nil then
				____opt_0(cfg)
			end
		end,
		OnInterrupt = function()
			return self:CancelSequence()
		end,
		OnFinish = function()
			return self:CancelSequence()
		end,
	})
end
function boss_warlock_phase_summon.prototype.GetSimplePhaseSummonConfig(self)
	return {
		summonUnitName = "monster_13017",
		summonCount = ACTOR_COUNT,
		onSummonSpawn = function(____, unit)
			return self:PlayWarlockSummonSpawnEffect(unit)
		end,
		note = "魂灯：转阶段召唤地狱剑士，先完成魂灯连斩演出，随后保留为正常召唤单位参战。",
	}
end
function boss_warlock_phase_summon.prototype.BeginSoulSlashPhase(self)
	self.sequenceId = self.sequenceId + 1
	self:CleanupActors()
	self.remainingActors = 0
	self.sequenceEnding = false
end
function boss_warlock_phase_summon.prototype.SummonPhaseMonsters(self, caster, config, center)
	local currentSequenceId = self.sequenceId
	local roomId = caster:GetRoomId()
	local summonCount = math.max(1, config.summonCount or ACTOR_COUNT)
	local summonOrigin = caster:GetAbsOrigin()
	local pendingActors = summonCount
	EmitSoundOnLocationWithCaster(center, WARLOCK_PHASE_SUMMON_SOUND, caster)
	modifier_warlock_soul_slash_aura:applys(caster, caster, self, {
		duration = self:GetBossPhaseTransitionWindowDuration(),
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
	})
	do
		local index = 0
		while index < summonCount do
			local currentIndex = index
			local angle = math.pi * 2 * currentIndex / summonCount
			local offset = Vector(math.cos(angle) * ACTOR_DISTANCE, math.sin(angle) * ACTOR_DISTANCE, 0)
			local currentTargetPosition = GetGroundPosition(center:__add(offset), caster)
			self:PlaySummonEffect(currentTargetPosition, caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = config.summonUnitName,
				summonTag = "phase_summon_" .. caster:GetUnitName(),
				maxSummons = summonCount,
				position = summonOrigin,
				roomId = roomId,
				team = caster:GetTeamNumber(),
				owner = caster,
				summoner = caster,
				destroyWithSummoner = true,
				findClearSpace = true,
				onSpawn = function(____, unit)
					if not unit or not IsValid(nil, unit) or unit:IsNull() then
						pendingActors = pendingActors - 1
						self:TryStartActors(currentSequenceId, pendingActors)
						return
					end
					if not self:IsSequenceActive(currentSequenceId) then
						MyGameUnit:DestroyUnit(unit)
						return
					end
					unit:SetSequence("golem_attack")
					self:PrepareActor(unit, currentTargetPosition)
					local ____self_actorIndices_2 = self.actorIndices
					____self_actorIndices_2[#____self_actorIndices_2 + 1] = unit:entindex()
					unit:SetAcquisitionRange(2500)
					local ____this_4
					____this_4 = config
					local ____opt_3 = ____this_4.onSummonSpawn
					if ____opt_3 ~= nil then
						____opt_3(____this_4, unit, caster, currentTargetPosition, center, currentIndex)
					end
					unit:Mover(currentTargetPosition, ACTOR_DEPLOY_DURATION, nil, true, false, true)
					self:Timer(ACTOR_DEPLOY_DURATION, function()
						pendingActors = pendingActors - 1
						if not self:IsSequenceActive(currentSequenceId) then
							return
						end
						if not IsValidAlive(nil, unit) then
							self:TryStartActors(currentSequenceId, pendingActors)
							return
						end
						unit:SetAbsOrigin(currentTargetPosition)
						unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, center, currentTargetPosition))
						self:TryStartActors(currentSequenceId, pendingActors)
					end)
				end,
			})
			index = index + 1
		end
	end
end
function boss_warlock_phase_summon.prototype.PrepareActor(self, actor, targetPosition)
	actor:SetForwardVectorWithoutInterrupt(GetDirection(nil, targetPosition, actor:GetAbsOrigin()))
	modifier_warlock_soul_slash_actor:applys(
		actor,
		self:GetCaster(),
		self,
		{ duration = self:GetBossPhaseTransitionWindowDuration() + 1 }
	)
end
function boss_warlock_phase_summon.prototype.TryStartActors(self, sequenceId, pendingSpawns)
	if pendingSpawns > 0 or not self:IsSequenceActive(sequenceId) then
		return
	end
	self.actorQueue = { unpack(self.actorIndices) }
	do
		local index = #self.actorQueue - 1
		while index > 0 do
			local currentIndex = index
			local swapIndex = RandomInt(0, currentIndex)
			local currentActorIndex = self.actorQueue[currentIndex + 1]
			self.actorQueue[currentIndex + 1] = self.actorQueue[swapIndex + 1]
			self.actorQueue[swapIndex + 1] = currentActorIndex
			index = index - 1
		end
	end
	self.remainingActors = #self.actorQueue
	if self.remainingActors <= 0 then
		self:FinishSequence(sequenceId)
		return
	end
	do
		local index = 0
		while index < #self.actorQueue do
			local currentIndex = index
			local currentActorIndex = self.actorQueue[currentIndex + 1]
			local currentDelay = currentIndex * ACTOR_START_INTERVAL
			self:Timer(currentDelay, function()
				return self:StartActor(sequenceId, currentActorIndex)
			end)
			index = index + 1
		end
	end
end
function boss_warlock_phase_summon.prototype.StartActor(self, sequenceId, actorIndex)
	if not self:IsSequenceActive(sequenceId) then
		return
	end
	local actor = EntIndexToHScript(actorIndex)
	if not IsValidAlive(nil, actor) then
		self:CompleteActor(sequenceId)
		return
	end
	local target = self:FindNearestPlayer(actor)
	if not IsValidAlive(nil, target) then
		return
	end
	if not target then
		self:ReleaseActor(actor)
		self:CompleteActor(sequenceId)
		return
	end
	local currentActorIndex = actor:entindex()
	local currentTargetIndex = target:entindex()
	actor:LockTargetForSpeed(target, TARGET_TRACK_DURATION, 15)
	local startPosition = actor:GetAbsOrigin()
	local lockedDirection = GetDirection(nil, target:GetAbsOrigin(), startPosition)
	local trackStartTime = GameRules:GetGameTime()
	local initialEndPosition = startPosition:__add(lockedDirection:__mul(DASH_DISTANCE))
	warningEffectLinear(nil, actor, self, startPosition, initialEndPosition, WARNING_DURATION, {
		startWidth = WARNING_WIDTH,
		endWidth = WARNING_WIDTH,
		follow = true,
		getDirection = function()
			local currentActor = EntIndexToHScript(currentActorIndex)
			local currentTarget = EntIndexToHScript(currentTargetIndex)
			if not IsValidAlive(nil, currentActor) then
				return lockedDirection
			end
			if
				GameRules:GetGameTime() - trackStartTime < TARGET_TRACK_DURATION and IsValidAlive(nil, currentTarget)
			then
				lockedDirection = GetDirection(nil, currentTarget:GetAbsOrigin(), currentActor:GetAbsOrigin())
			end
			return lockedDirection
		end,
	})
	actor:SetAnimation("golem_attack2")
	actor:EmitSound(SLASH_CHARGE_SOUND)
	actor:Mover(
		startPosition:__add(lockedDirection:__mul(-BACKSTEP_DISTANCE)),
		BACKSTEP_DURATION,
		nil,
		true,
		false,
		true
	)
	self:Timer(TARGET_TRACK_DURATION + 0.1, function()
		local currentActor = EntIndexToHScript(currentActorIndex)
		local currentTarget = EntIndexToHScript(currentTargetIndex)
		if not IsValidAlive(nil, currentActor) then
			return
		end
		if IsValidAlive(nil, currentTarget) then
			lockedDirection = GetDirection(nil, currentTarget:GetAbsOrigin(), currentActor:GetAbsOrigin())
		end
		currentActor:SetForwardVectorWithoutInterrupt(lockedDirection)
	end)
	self:Timer(WARNING_DURATION + 0.1, function()
		self:ExecuteActorDash(sequenceId, currentActorIndex, lockedDirection)
	end)
end
function boss_warlock_phase_summon.prototype.ExecuteActorDash(self, sequenceId, actorIndex, dashDirection)
	if not self:IsSequenceActive(sequenceId) then
		return
	end
	local actor = EntIndexToHScript(actorIndex)
	if not IsValidAlive(nil, actor) then
		self:CompleteActor(sequenceId)
		return
	end
	local dashStart = GetGroundPosition(actor:GetAbsOrigin(), actor)
	local dashEnd = GetGroundPosition(dashStart:__add(dashDirection:__mul(DASH_DISTANCE)), actor)
	actor:EmitSound(SLASH_START_SOUND)
	actor:SetForwardVectorWithoutInterrupt(dashDirection)
	actor:SetAnimation("golem_attack")
	modifier_elite_144:applys(actor, actor, self, { duration = DASH_DURATION })
	self:Timer(0.25, function()
		self:PlaySlashEffect(actor)
	end)
	local hitTargets = __TS__New(Set)
	local previousPosition = dashStart
	actor:Mover(dashEnd, DASH_DURATION, function(____, currentPosition)
		self:HitDashPlayersOnPath(previousPosition, currentPosition, hitTargets)
		previousPosition = currentPosition
	end, true, true)
	self:Timer(DASH_DURATION + 0.1, function()
		if not self:IsSequenceActive(sequenceId) then
			return
		end
		if IsValidAlive(nil, actor) then
			self:ReleaseActor(actor)
		end
		self:CompleteActor(sequenceId)
	end)
end
function boss_warlock_phase_summon.prototype.CompleteActor(self, sequenceId)
	if not self:IsSequenceActive(sequenceId) or self.sequenceEnding then
		return
	end
	self.remainingActors = math.max(0, self.remainingActors - 1)
	if self.remainingActors <= 0 then
		self:FinishSequence(sequenceId)
	end
end
function boss_warlock_phase_summon.prototype.FinishSequence(self, sequenceId)
	if not self:IsSequenceActive(sequenceId) or self.sequenceEnding then
		return
	end
	self.sequenceEnding = true
	modifier_warlock_soul_slash_aura:remove(self:GetCaster())
	self:DestroyDuration()
end
function boss_warlock_phase_summon.prototype.HitDashPlayersOnPath(self, startPosition, endPosition, hitTargets)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInLine(
		caster:GetTeamNumber(),
		startPosition,
		endPosition,
		nil,
		DASH_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or not IsPlayerCombatTarget(nil, enemy) then
				goto __continue55
			end
			local enemyIndex = enemy:entindex()
			if hitTargets:has(enemyIndex) then
				goto __continue55
			end
			hitTargets:add(enemyIndex)
			caster:PerformAttack(enemy, true, true, true, false, true, false, true)
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_DAMAGE_RATE, ability = self })
		end
		::__continue55::
	end
end
function boss_warlock_phase_summon.prototype.FindNearestPlayer(self, actor)
	if not IsValidAlive(nil, actor) then
		return
	end
	local targets = FindUnitsInRadius(
		actor:GetTeamNumber(),
		actor:GetAbsOrigin(),
		nil,
		TARGET_SEARCH_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, target in ipairs(targets) do
		if IsValidAlive(nil, target) and IsPlayerCombatTarget(nil, target) then
			return target
		end
	end
	return nil
end
function boss_warlock_phase_summon.prototype.PlaySlashEffect(self, actor)
	if not IsValidAlive(nil, actor) then
		return
	end
	local effect = ParticleManager:CreateParticle(SLASH_ATTACK_PARTICLE, PATTACH_POINT_FOLLOW, actor)
	ParticleManager:SetParticleControl(effect, 0, actor:GetAbsOrigin())
	ParticleManager:SetParticleControl(effect, 4, actor:GetAbsOrigin())
	self:Timer(0.2, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
	end)
end
function boss_warlock_phase_summon.prototype.ReleaseActor(self, actor)
	if not IsValid(nil, actor) or actor:IsNull() then
		return
	end
	local actorIndex = actor:entindex()
	do
		local index = #self.actorIndices - 1
		while index >= 0 do
			if self.actorIndices[index + 1] == actorIndex then
				__TS__ArraySplice(self.actorIndices, index, 1)
			end
			index = index - 1
		end
	end
	modifier_warlock_soul_slash_actor:remove(actor)
	modifier_elite_144:remove(actor)
	if IsValidAlive(nil, actor) then
		actor:Stop()
	end
end
function boss_warlock_phase_summon.prototype.IsSequenceActive(self, sequenceId)
	return sequenceId == self.sequenceId and IsValidAlive(nil, self:GetCaster())
end
function boss_warlock_phase_summon.prototype.CancelSequence(self)
	self.sequenceId = self.sequenceId + 1
	self:CleanupActors()
	self.remainingActors = 0
	self.sequenceEnding = false
end
function boss_warlock_phase_summon.prototype.CleanupActors(self)
	modifier_warlock_soul_slash_aura:remove(self:GetCaster())
	for ____, actorIndex in ipairs(self.actorIndices) do
		local currentActorIndex = actorIndex
		local actor = EntIndexToHScript(currentActorIndex)
		if IsValid(nil, actor) and not actor:IsNull() then
			modifier_warlock_soul_slash_actor:remove(actor)
			modifier_elite_144:remove(actor)
		end
	end
	self.actorIndices = {}
	self.actorQueue = {}
end
function boss_warlock_phase_summon.prototype.PlayWarlockSummonSpawnEffect(self, unit)
	if not IsValidAlive(nil, unit) then
		return
	end
	local origin = unit:GetAbsOrigin()
	local effect = ParticleManager:CreateParticle(WARLOCK_PHASE_SUMMON_SPAWN_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, Vector(1, 1, 1))
	ParticleManager:SetParticleShouldCheckFoW(effect, false)
	Timers:CreateTimer(WARLOCK_PHASE_SUMMON_SPAWN_PARTICLE_LIFETIME, function()
		ParticleManager:DestroyParticle(effect, false)
		ParticleManager:ReleaseParticleIndex(effect)
		return nil
	end)
end
boss_warlock_phase_summon = __TS__DecorateLegacy({ registerAbility(nil) }, boss_warlock_phase_summon)
____exports.boss_warlock_phase_summon = boss_warlock_phase_summon
return ____exports