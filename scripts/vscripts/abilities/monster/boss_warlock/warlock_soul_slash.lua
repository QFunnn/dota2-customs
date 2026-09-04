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
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____monster_warning_effects = require("modifiers.monster.monster_warning_effects")
local warningEffectLinear = ____monster_warning_effects.warningEffectLinear
local ____secondary_hero_context = require("my_game_axe.secondary_hero.secondary_hero_context")
local IsPlayerCombatTarget = ____secondary_hero_context.IsPlayerCombatTarget
--- Boss 返回出生点的位移时间，同时作为技能施法前摇，单位：秒。
local RETURN_TO_SPAWN_DURATION = 0.6
--- 前摇结束后技能保持施法状态的总时长，单位：秒。
local CAST_DURATION = 6.5
--- 技能冷却时间，单位：秒。
local COOLDOWN = 8
--- 参与连斩演出的小魂灯数量。
local ACTOR_COUNT = 8
--- 小魂灯部署点与出生点中心的距离。
local ACTOR_DISTANCE = 1200
--- 小魂灯模型缩放比例。
local ACTOR_MODEL_SCALE = 1
--- 小魂灯演员单位的最长存活时间，单位：秒。
local ACTOR_MAX_DURATION = 8
--- 小魂灯从 Boss 身上散开至部署点的时间，单位：秒。
local ACTOR_DEPLOY_DURATION = 0.4
--- 小魂灯搜索最近玩家的最大范围。
local TARGET_SEARCH_RANGE = 3000
--- 单盏小魂灯从开始预警到发动冲刺的总瞄准时间，单位：秒。
local WARNING_DURATION = 0.8
--- 瞄准阶段中持续跟踪玩家方向的时间，结束后锁定方向，单位：秒。
local TARGET_TRACK_DURATION = 0.3
--- 直线预警与冲刺命中判定的基础宽度。
local WARNING_WIDTH = 160
--- 小魂灯完成单次冲刺的时间，单位：秒。
local DASH_DURATION = 0.15
--- 小魂灯每次冲刺的固定距离。
local DASH_DISTANCE = 2000
--- 冲刺线段伤害与轨迹特效同步结算的命中宽度。
local DASH_HIT_RADIUS = 160
--- 单盏小魂灯冲刺命中时使用的怪物伤害倍率。
local DASH_DAMAGE_RATE = 10
--- 相邻小魂灯的启动间隔，为总瞄准时间的三分之一。
local ACTOR_START_INTERVAL = WARNING_DURATION / 3
--- 风暴伤害区域的外圈半径。
local AURA_OUTER_RADIUS = 2300
--- 风暴中心不受持续伤害的安全区半径。
local AURA_INNER_SAFE_RADIUS = 1300
--- 外圈风暴每次结算使用的怪物伤害倍率。
local AURA_DAMAGE_RATE = 10
--- 外圈风暴的伤害结算间隔，单位：秒。
local AURA_DAMAGE_INTERVAL = 0.2
--- 蓄力结束时连接起点与终点的单段空间斩轨迹。
local SLASH_PATH_PARTICLE = "particles/monster/boss_warlock/warlock_astral_step.vpcf"
--- 冲刺路径命中玩家时附着在目标身上的斩击冲击特效。
local SLASH_IMPACT_PARTICLE = "particles/monster/boss_warlock/warlock_astral_step_impact.vpcf"
--- 冲刺期间覆盖在小魂灯模型上的黑色虚空材质。
local SLASH_STATUS_PARTICLE = "particles/monster/boss_warlock/status_effect_warlock_pulse_buff.vpcf"
--- 冲刺期间跟随小魂灯移动的虚空残影特效。
local SLASH_TRAIL_PARTICLE = "particles/monster/boss_warlock/warlock_astral_step_debuff.vpcf"
--- 技能期间显示内圈安全区与外圈伤害区域的静态风暴特效。
local AURA_EFFECT = "particles/monster/boss_warlock/warlock_static_storm.vpcf"
--- Boss 返回出生点并开始召唤时播放的蓄力音效。
local CAST_SOUND = "Hero_Warlock.RainOfChaos_buildup"
--- 小魂灯蓄力结束并发动空间斩时播放的音效。
local SLASH_START_SOUND = "Hero_VoidSpirit.AstralStep.Start"
--- 魂灯连斩：回到出生点召唤八个小魂灯，并依次锁定玩家冲刺斩击。
____exports.warlock_soul_slash = __TS__Class()
local warlock_soul_slash = ____exports.warlock_soul_slash
warlock_soul_slash.name = "warlock_soul_slash"
__TS__ClassExtends(warlock_soul_slash, MonsterAbility_CS)
function warlock_soul_slash.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequenceId = 0
	self.actorIndices = {}
	self.actorQueue = {}
	self.remainingActors = 0
	self.sequenceEnding = false
end
function warlock_soul_slash.prototype.Precache(self, context)
	PrecacheResource("particle", SLASH_PATH_PARTICLE, context)
	PrecacheResource("particle", SLASH_IMPACT_PARTICLE, context)
	PrecacheResource("particle", SLASH_STATUS_PARTICLE, context)
	PrecacheResource("particle", SLASH_TRAIL_PARTICLE, context)
	PrecacheResource("particle", AURA_EFFECT, context)
end
function warlock_soul_slash.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = TARGET_SEARCH_RANGE,
		castPoint = RETURN_TO_SPAWN_DURATION,
		castDuration = CAST_DURATION,
		cooldown = COOLDOWN,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.9,
		isNotMove = true,
		OnPhaseStart = function()
			return self:BeginReturnToSpawn()
		end,
		OnStart = function()
			return self:StartSoulSlashSequence()
		end,
		OnInterrupt = function()
			return self:CancelSequence()
		end,
		OnFinish = function()
			return self:CancelSequence()
		end,
	}
end
function warlock_soul_slash.prototype.OnOwnerDied(self)
	if not IsServer() then
		return
	end
	self:CancelSequence()
end
function warlock_soul_slash.prototype.BeginReturnToSpawn(self)
	self.sequenceId = self.sequenceId + 1
	self:CleanupActors()
	self.remainingActors = 0
	self.sequenceEnding = false
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:EmitSound(CAST_SOUND)
	local ____opt_0 = caster.GetSpawnPoint
	local spawnPoint = ____opt_0 and ____opt_0(caster)
	if spawnPoint then
		caster:Mover(GetGroundPosition(spawnPoint, caster), RETURN_TO_SPAWN_DURATION, nil, true, true)
	end
end
function warlock_soul_slash.prototype.StartSoulSlashSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local currentSequenceId = self.sequenceId
	local ____opt_2 = caster.GetSpawnPoint
	local spawnPoint = ____opt_2 and ____opt_2(caster) or caster:GetAbsOrigin()
	local center = GetGroundPosition(spawnPoint, caster)
	local summonOrigin = caster:GetAbsOrigin()
	local roomId = caster:GetRoomId()
	local pendingActors = ACTOR_COUNT
	____exports.modifier_warlock_soul_slash_aura:applys(
		caster,
		caster,
		self,
		{ duration = CAST_DURATION, center_x = center.x, center_y = center.y, center_z = center.z }
	)
	do
		local index = 0
		while index < ACTOR_COUNT do
			local currentIndex = index
			local angle = math.pi * 2 * currentIndex / ACTOR_COUNT
			local offset = Vector(math.cos(angle) * ACTOR_DISTANCE, math.sin(angle) * ACTOR_DISTANCE, 0)
			local currentTargetPosition = GetGroundPosition(center:__add(offset), caster)
			MyGameUnit:CreateSummonedUnitAsync({
				unitName = "monster_13017",
				summonTag = "warlock_soul_slash_" .. tostring(caster:entindex()),
				maxSummons = ACTOR_COUNT,
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
					local ____self_actorIndices_4 = self.actorIndices
					____self_actorIndices_4[#____self_actorIndices_4 + 1] = unit:entindex()
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
function warlock_soul_slash.prototype.PrepareActor(self, actor, targetPosition)
	actor:SetModelScale(ACTOR_MODEL_SCALE)
	actor:SetRenderColor(155, 24, 24)
	actor:SetAcquisitionRange(0)
	actor:SetForwardVectorWithoutInterrupt(GetDirection(nil, targetPosition, actor:GetAbsOrigin()))
	actor:RemoveModifierByName("modifier_boss_ai_test")
	actor:RemoveModifierByName("modifier_monster_ai_wander")
	local abilityCount = actor:GetAbilityCount()
	do
		local index = 0
		while index < abilityCount do
			local currentIndex = index
			local currentAbility = actor:GetAbilityByIndex(currentIndex)
			if currentAbility ~= nil then
				currentAbility:SetActivated(false)
			end
			index = index + 1
		end
	end
	____exports.modifier_warlock_soul_slash_actor:applys(
		actor,
		self:GetCaster(),
		self,
		{ duration = ACTOR_MAX_DURATION }
	)
end
function warlock_soul_slash.prototype.TryStartActors(self, sequenceId, pendingSpawns)
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
function warlock_soul_slash.prototype.StartActor(self, sequenceId, actorIndex)
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
		self:DismissActor(actor)
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
	self:Timer(TARGET_TRACK_DURATION, function()
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
	local attackPlaybackRate = math.max(0.5, actor:GetAttackAnimationPoint() / WARNING_DURATION)
	actor:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, attackPlaybackRate * 1.5)
	self:Timer(WARNING_DURATION, function()
		return self:ExecuteActorDash(sequenceId, currentActorIndex, lockedDirection)
	end)
end
function warlock_soul_slash.prototype.ExecuteActorDash(self, sequenceId, actorIndex, dashDirection)
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
	actor:EmitSound("Hero_Broodmother.SilkenBola.Target")
	actor:SetForwardVectorWithoutInterrupt(dashDirection)
	____exports.modifier_warlock_soul_slash_dash_effect:applys(actor, actor, self, { duration = DASH_DURATION })
	self:PlaySlashPathEffect(dashStart, dashEnd, actor)
	EmitSoundOnLocationWithCaster(dashStart, SLASH_START_SOUND, actor)
	self:HitDashPlayersOnPath(dashStart, dashEnd)
	actor:Mover(dashEnd, DASH_DURATION, nil, true, true)
	self:Timer(DASH_DURATION + 0.1, function()
		if not self:IsSequenceActive(sequenceId) then
			return
		end
		if IsValidAlive(nil, actor) then
			self:DismissActor(actor)
		end
		self:CompleteActor(sequenceId)
	end)
end
function warlock_soul_slash.prototype.CompleteActor(self, sequenceId)
	if not self:IsSequenceActive(sequenceId) or self.sequenceEnding then
		return
	end
	self.remainingActors = math.max(0, self.remainingActors - 1)
	if self.remainingActors <= 0 then
		self:FinishSequence(sequenceId)
	end
end
function warlock_soul_slash.prototype.FinishSequence(self, sequenceId)
	if not self:IsSequenceActive(sequenceId) or self.sequenceEnding then
		return
	end
	self.sequenceEnding = true
	self:DestroyDuration()
end
function warlock_soul_slash.prototype.HitDashPlayersOnPath(self, startPosition, endPosition)
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
			self:PlaySlashImpactEffect(enemy)
			caster:PerformAttack(enemy, true, true, true, false, true, false, true)
			caster:MonsterDamage({ victim = enemy, damage_rate = DASH_DAMAGE_RATE, ability = self })
		end
		::__continue55::
	end
end
function warlock_soul_slash.prototype.FindNearestPlayer(self, actor)
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
function warlock_soul_slash.prototype.PlaySlashPathEffect(self, origin, target, actor)
	local effect = ParticleManager:CreateParticle(SLASH_PATH_PARTICLE, PATTACH_WORLDORIGIN, actor)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, target)
	ParticleManager:ReleaseParticleIndex(effect)
end
function warlock_soul_slash.prototype.PlaySlashImpactEffect(self, target)
	local effect = ParticleManager:CreateParticle(SLASH_IMPACT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect)
end
function warlock_soul_slash.prototype.DismissActor(self, actor)
	if not IsValidAlive(nil, actor) then
		return
	end
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
	actor:AddNoDraw()
	MyGameUnit:DestroyUnit(actor)
end
function warlock_soul_slash.prototype.IsSequenceActive(self, sequenceId)
	return sequenceId == self.sequenceId and IsValidAlive(nil, self:GetCaster())
end
function warlock_soul_slash.prototype.CancelSequence(self)
	self.sequenceId = self.sequenceId + 1
	self:CleanupActors()
	self.remainingActors = 0
	self.sequenceEnding = false
end
function warlock_soul_slash.prototype.CleanupActors(self)
	____exports.modifier_warlock_soul_slash_aura:remove(self:GetCaster())
	for ____, actorIndex in ipairs(self.actorIndices) do
		local currentActorIndex = actorIndex
		local actor = EntIndexToHScript(currentActorIndex)
		if IsValid(nil, actor) and not actor:IsNull() then
			actor:AddNoDraw()
			MyGameUnit:DestroyUnit(actor)
		end
	end
	self.actorIndices = {}
	self.actorQueue = {}
end
warlock_soul_slash = __TS__DecorateLegacy({ registerAbility(nil, "warlock_soul_slash") }, warlock_soul_slash)
____exports.warlock_soul_slash = warlock_soul_slash
--- 技能期间的安全区风暴：内圈安全，外圈持续伤害。
____exports.modifier_warlock_soul_slash_aura = __TS__Class()
local modifier_warlock_soul_slash_aura = ____exports.modifier_warlock_soul_slash_aura
modifier_warlock_soul_slash_aura.name = "modifier_warlock_soul_slash_aura"
__TS__ClassExtends(modifier_warlock_soul_slash_aura, MonsterModifier_CS)
function modifier_warlock_soul_slash_aura.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.center = Vector(0, 0, 0)
end
function modifier_warlock_soul_slash_aura.prototype.IsHidden(self)
	return true
end
function modifier_warlock_soul_slash_aura.prototype.IsPurgable(self)
	return false
end
function modifier_warlock_soul_slash_aura.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.center = Vector(params.center_x or 0, params.center_y or 0, params.center_z or 0)
	self.auraParticle = ParticleManager:CreateParticle(AURA_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.auraParticle, 0, self.center)
	ParticleManager:SetParticleControl(self.auraParticle, 1, Vector(AURA_OUTER_RADIUS, 1, 1))
	ParticleManager:SetParticleShouldCheckFoW(self.auraParticle, false)
	self:StartIntervalThink(AURA_DAMAGE_INTERVAL)
end
function modifier_warlock_soul_slash_aura.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		self.center,
		nil,
		AURA_OUTER_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) or not IsPlayerCombatTarget(nil, enemy) then
				goto __continue83
			end
			if GetDistance(nil, enemy:GetAbsOrigin(), self.center) <= AURA_INNER_SAFE_RADIUS then
				goto __continue83
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = AURA_DAMAGE_RATE, ability = ability })
		end
		::__continue83::
	end
end
function modifier_warlock_soul_slash_aura.prototype.OnDestroy(self)
	if not IsServer() or self.auraParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.auraParticle, false)
	ParticleManager:ReleaseParticleIndex(self.auraParticle)
	self.auraParticle = nil
end
modifier_warlock_soul_slash_aura = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_warlock_soul_slash_aura") },
	modifier_warlock_soul_slash_aura
)
____exports.modifier_warlock_soul_slash_aura = modifier_warlock_soul_slash_aura
--- 冲刺期间复用太虚空间斩的黑色材质与残影。
____exports.modifier_warlock_soul_slash_dash_effect = __TS__Class()
local modifier_warlock_soul_slash_dash_effect = ____exports.modifier_warlock_soul_slash_dash_effect
modifier_warlock_soul_slash_dash_effect.name = "modifier_warlock_soul_slash_dash_effect"
__TS__ClassExtends(modifier_warlock_soul_slash_dash_effect, MonsterModifier_CS)
function modifier_warlock_soul_slash_dash_effect.prototype.IsHidden(self)
	return true
end
function modifier_warlock_soul_slash_dash_effect.prototype.IsPurgable(self)
	return false
end
function modifier_warlock_soul_slash_dash_effect.prototype.GetStatusEffectName(self)
	return SLASH_STATUS_PARTICLE
end
function modifier_warlock_soul_slash_dash_effect.prototype.GetEffectName(self)
	return SLASH_TRAIL_PARTICLE
end
function modifier_warlock_soul_slash_dash_effect.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
function modifier_warlock_soul_slash_dash_effect.prototype.StatusEffectPriority(self)
	return MODIFIER_PRIORITY_NORMAL
end
modifier_warlock_soul_slash_dash_effect = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_warlock_soul_slash_dash_effect") },
	modifier_warlock_soul_slash_dash_effect
)
____exports.modifier_warlock_soul_slash_dash_effect = modifier_warlock_soul_slash_dash_effect
--- 小魂灯演员状态：不参与战斗，仅接受本技能的动作与位移驱动。
____exports.modifier_warlock_soul_slash_actor = __TS__Class()
local modifier_warlock_soul_slash_actor = ____exports.modifier_warlock_soul_slash_actor
modifier_warlock_soul_slash_actor.name = "modifier_warlock_soul_slash_actor"
__TS__ClassExtends(modifier_warlock_soul_slash_actor, MonsterModifier_CS)
function modifier_warlock_soul_slash_actor.prototype.IsHidden(self)
	return true
end
function modifier_warlock_soul_slash_actor.prototype.IsPurgable(self)
	return false
end
function modifier_warlock_soul_slash_actor.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_SILENCED] = true,
		[MODIFIER_STATE_MUTED] = true,
	}
end
modifier_warlock_soul_slash_actor = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_warlock_soul_slash_actor") },
	modifier_warlock_soul_slash_actor
)
____exports.modifier_warlock_soul_slash_actor = modifier_warlock_soul_slash_actor
return ____exports