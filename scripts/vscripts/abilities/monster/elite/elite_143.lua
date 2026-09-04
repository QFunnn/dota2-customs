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
local modifier_monster_11075_remnant_state, modifier_monster_11075_remnant_slow
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local ____moving_remnant_thunderized = require("abilities.monster.moving_remnant_thunderized")
local FindNearestThunderizedEnemyForMovingRemnant =
	____moving_remnant_thunderized.FindNearestThunderizedEnemyForMovingRemnant
local ShouldIgnoreMovingRemnantImpact = ____moving_remnant_thunderized.ShouldIgnoreMovingRemnantImpact
local CAST_POINT = 1
local CAST_DURATION = 1.5
local SUMMON_RADIUS = 2000
local SUMMON_COUNT = 8
local SUMMON_POINT_ATTEMPTS = 160
local SUMMON_MIN_SEPARATION = 180
local SUMMON_RHYTHM_INTERVAL = 0.16
local SUMMON_RHYTHM_INTERVAL_JITTER = 0.05
local SUMMON_RHYTHM_GROUP_SIZE = 4
local SUMMON_RHYTHM_GROUP_PAUSE = 0.24
local REMNANT_UNIT_NAME = "monster_11075_remnant"
local REMNANT_DURATION = 5
local REMNANT_THINK_INTERVAL = 0.03
local REMNANT_HIT_RADIUS = 120
local REMNANT_EXPLOSION_RADIUS = 220
local REMNANT_DAMAGE_RATE = 12
local REMNANT_SLOW_DURATION = 1
local REMNANT_SLOW_MOVESPEED_PCT = -50
local REMNANT_ARM_DELAY = 0.35
local REMNANT_PATROL_SPEED_MIN = 260
local REMNANT_PATROL_SPEED_MAX = 420
local REMNANT_PATROL_DISTANCE_MIN = 360
local REMNANT_PATROL_DISTANCE_MAX = 620
local REMNANT_PATROL_END_REACH_DISTANCE = 70
local REMNANT_PATROL_RESTART_DOT = 0.99
local REMNANT_THUNDERIZED_MOVE_SPEED = 520
local REMNANT_THUNDERIZED_TURN_SPEED_DEGREES = 360
local REMNANT_AVOIDANCE_TURN_DEGREES = 105
local REMNANT_AVOIDANCE_DURATION = 0.35
local REMNANT_THUNDERIZED_SEARCH_RANGE = 2000
local REMNANT_THUNDERIZED_RETARGET_INTERVAL = 0.15
local PARTICLE_REMNANT = "particles/boss/boss_zeus/ak_zeus_moving_remnant.vpcf"
local PARTICLE_REMNANT_EXPLOSION = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local SOUND_REMNANT_CAST = "Hero_StormSpirit.StaticRemnantPlant"
local SOUND_REMNANT_EXPLODE = "Hero_StormSpirit.StaticRemnantExplode"
--- 雷霆信徒：延迟召唤一批会游荡并被雷化单位吸引的风暴残影。
____exports.elite_143 = __TS__Class()
local elite_143 = ____exports.elite_143
elite_143.name = "elite_143"
__TS__ClassExtends(elite_143, MonsterAbility_CS)
function elite_143.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_REMNANT, context)
	PrecacheResource("particle", PARTICLE_REMNANT_EXPLOSION, context)
end
function elite_143.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = SUMMON_RADIUS,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 1.1,
		castProgressBarColor = "blue",
		castColor = Vector(200, 240, 255),
		thunderizedDamageImmune = true,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:GetCaster()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(SUMMON_RADIUS)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT, 4)
			end
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function elite_143.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.2)
	local summonPositions = self:createSummonPositions(caster)
	local roomId = caster:GetRoomId()
	do
		local index = 0
		while index < #summonPositions do
			local currentIndex = index
			local currentSummonPos = summonPositions[currentIndex + 1]
			local currentDelay = self:getSummonDelay(currentIndex)
			local currentRoomId = roomId
			self:Timer(currentDelay, function()
				self:summonRemnant(caster, currentSummonPos, currentIndex, currentRoomId)
			end)
			index = index + 1
		end
	end
end
function elite_143.prototype.getSummonDelay(self, index)
	local groupPause = math.floor(index / SUMMON_RHYTHM_GROUP_SIZE) * SUMMON_RHYTHM_GROUP_PAUSE
	local rhythmDelay = index * SUMMON_RHYTHM_INTERVAL
	local jitterDelay = index == 0 and 0 or RandomFloat(0, SUMMON_RHYTHM_INTERVAL_JITTER)
	return rhythmDelay + groupPause + jitterDelay
end
function elite_143.prototype.createSummonPositions(self, caster)
	local origin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local positions = {}
	self:fillSummonPositions(caster, origin, positions, true)
	if #positions < SUMMON_COUNT then
		self:fillSummonPositions(caster, origin, positions, false)
	end
	while #positions < SUMMON_COUNT do
		positions[#positions + 1] = origin
	end
	return positions
end
function elite_143.prototype.fillSummonPositions(self, caster, origin, positions, checkSeparation)
	do
		local attempt = 0
		while attempt < SUMMON_POINT_ATTEMPTS and #positions < SUMMON_COUNT do
			do
				local distance = RandomFloat(0, SUMMON_RADIUS)
				local candidate = origin:__add(RandomVector(distance))
				local point = GetGroundPosition(candidate, caster)
				if not self:isValidSummonPoint(origin, point) then
					goto __continue19
				end
				if checkSeparation and not self:hasEnoughSeparation(point, positions) then
					goto __continue19
				end
				positions[#positions + 1] = point
			end
			::__continue19::
			attempt = attempt + 1
		end
	end
end
function elite_143.prototype.isValidSummonPoint(self, origin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not GridNav:CanFindPath(origin, point) then
		return false
	end
	return GridNav:FindPathLength(origin, point) ~= -1
end
function elite_143.prototype.hasEnoughSeparation(self, point, positions)
	for ____, position in ipairs(positions) do
		if GetDistance(nil, point, position) < SUMMON_MIN_SEPARATION then
			return false
		end
	end
	return true
end
function elite_143.prototype.summonRemnant(self, caster, position, index, roomId)
	local summonPos = GetGroundPosition(position, caster)
	EmitSoundOnLocationWithCaster(summonPos, SOUND_REMNANT_CAST, caster)
	MyGameUnit:CreateSummonedUnitAsync({
		unitName = REMNANT_UNIT_NAME,
		summonTag = "monster_11075_remnant_" .. tostring(caster:entindex()),
		maxSummons = SUMMON_COUNT,
		position = summonPos,
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
			unit:SetForwardVectorWithoutInterrupt(GetDirection(nil, caster:GetAbsOrigin(), summonPos))
			unit:StartGestureWithPlaybackRate(ACT_DOTA_SPAWN, 0.8)
			modifier_monster_11075_remnant_state:applys(unit, caster, self, {
				duration = REMNANT_DURATION,
				spawn_x = summonPos.x,
				spawn_y = summonPos.y,
				spawn_z = summonPos.z,
				room_id = roomId,
				remnant_index = index,
				parent_model = caster:GetModelName(),
			})
		end,
	})
end
elite_143 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_143)
____exports.elite_143 = elite_143
modifier_monster_11075_remnant_state = __TS__Class()
modifier_monster_11075_remnant_state.name = "modifier_monster_11075_remnant_state"
__TS__ClassExtends(modifier_monster_11075_remnant_state, MonsterModifier_CS)
function modifier_monster_11075_remnant_state.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.exploded = false
	self.spawnOrigin = Vector(0, 0, 0)
	self.nextThunderizedTargetSearchTime = 0
	self.moveDirection = Vector(1, 0, 0)
	self.patrolDirection = Vector(1, 0, 0)
	self.patrolForward = true
	self.patrolDistance = REMNANT_PATROL_DISTANCE_MIN
	self.patrolSpeed = REMNANT_PATROL_SPEED_MIN
	self.avoidanceUntilTime = 0
	self.turnSign = 1
	self.remnantIndex = 0
end
function modifier_monster_11075_remnant_state.prototype.IsHidden(self)
	return true
end
function modifier_monster_11075_remnant_state.prototype.IsPurgable(self)
	return false
end
function modifier_monster_11075_remnant_state.prototype.RemoveOnDeath(self)
	return true
end
function modifier_monster_11075_remnant_state.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.spawnOrigin = GetGroundPosition(
		Vector(
			params.spawn_x or parent:GetAbsOrigin().x,
			params.spawn_y or parent:GetAbsOrigin().y,
			params.spawn_z or parent:GetAbsOrigin().z
		),
		parent
	)
	self.roomId = params.room_id
	if self.roomId ~= nil then
		parent.__room_id__ = self.roomId
	end
	self.remnantIndex = params.remnant_index or 0
	self.turnSign = self.remnantIndex % 2 == 0 and 1 or -1
	self.patrolDirection = self:createInitialDirection(self.remnantIndex)
	self.patrolForward = true
	self.patrolDistance = RandomFloat(REMNANT_PATROL_DISTANCE_MIN, REMNANT_PATROL_DISTANCE_MAX)
	self.patrolSpeed = RandomFloat(REMNANT_PATROL_SPEED_MIN, REMNANT_PATROL_SPEED_MAX)
	self.moveDirection = self:getCurrentPatrolDirection()
	parent:SetForwardVector(self.moveDirection)
	self:createRemnantParticle(parent)
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
end
function modifier_monster_11075_remnant_state.prototype.OnIntervalThink(self)
	if not IsServer() or self.exploded then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local origin = parent:GetAbsOrigin()
	if self:isArmed() and self:findHitTarget(origin) then
		self:explode(origin)
		return
	end
	local thunderizedTarget = self:getThunderizedMoveTarget(origin)
	local ____IsValidAlive_result_1
	if IsValidAlive(nil, thunderizedTarget) then
		____IsValidAlive_result_1 = self:moveTowards(
			parent,
			origin,
			thunderizedTarget:GetAbsOrigin(),
			REMNANT_THUNDERIZED_MOVE_SPEED,
			REMNANT_THUNDERIZED_TURN_SPEED_DEGREES
		)
	else
		____IsValidAlive_result_1 = self:patrolAlongLine(parent, origin)
	end
	local nextPosition = ____IsValidAlive_result_1
	if self:isArmed() and self:findHitTarget(nextPosition) then
		self:explode(nextPosition)
	end
end
function modifier_monster_11075_remnant_state.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	local ____temp_2
	if IsValid(nil, parent) and not parent:IsNull() then
		____temp_2 = parent:GetAbsOrigin()
	else
		____temp_2 = self.spawnOrigin
	end
	local origin = ____temp_2
	if not self.exploded and self:isArmed() then
		self:explodeAt(origin)
		self.exploded = true
	end
	self:destroyRemnantParticle()
	if IsValid(nil, parent) and not parent:IsNull() then
		if not parent.__remove then
			MyGameUnit:DestroyUnit(parent)
		end
	end
end
function modifier_monster_11075_remnant_state.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_DISARMED] = true,
	}
end
function modifier_monster_11075_remnant_state.prototype.isArmed(self)
	return self:GetElapsedTime() >= REMNANT_ARM_DELAY
end
function modifier_monster_11075_remnant_state.prototype.patrolAlongLine(self, parent, origin)
	if not IsValidAlive(nil, parent) then
		return origin
	end
	if self:shouldReversePatrol(origin) then
		self:reversePatrol(parent)
	end
	local direction = self:getCurrentPatrolDirection()
	self:ensurePatrolFacing(parent, direction)
	local nextPosition = self:getForwardMovePosition(parent, origin, direction, self.patrolSpeed)
	if not self:isValidStepPosition(parent, origin, nextPosition) then
		self:reversePatrol(parent)
		direction = self:getCurrentPatrolDirection()
		nextPosition = self:getForwardMovePosition(parent, origin, direction, self.patrolSpeed)
		if not self:isValidStepPosition(parent, origin, nextPosition) then
			return origin
		end
	end
	parent:SetAbsOrigin(nextPosition)
	self:updateRemnantParticleOrigin(nextPosition)
	return nextPosition
end
function modifier_monster_11075_remnant_state.prototype.shouldReversePatrol(self, origin)
	return GetDistance(nil, origin, self:getCurrentPatrolEnd()) <= REMNANT_PATROL_END_REACH_DISTANCE
end
function modifier_monster_11075_remnant_state.prototype.getCurrentPatrolEnd(self)
	local direction = self:getCurrentPatrolDirection()
	return self.spawnOrigin:__add(direction:__mul(self.patrolDistance))
end
function modifier_monster_11075_remnant_state.prototype.getCurrentPatrolDirection(self)
	local ____table_patrolForward_3
	if self.patrolForward then
		____table_patrolForward_3 = self.patrolDirection
	else
		____table_patrolForward_3 = self.patrolDirection:__mul(-1)
	end
	local direction = ____table_patrolForward_3
	return self:normalizeDirection(direction, self.patrolDirection)
end
function modifier_monster_11075_remnant_state.prototype.reversePatrol(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	self.patrolForward = not self.patrolForward
	local direction = self:getCurrentPatrolDirection()
	self.moveDirection = direction
	self.avoidanceDirection = nil
	self.avoidanceUntilTime = 0
	parent:SetForwardVector(direction)
	self:restartRemnantParticle(parent)
end
function modifier_monster_11075_remnant_state.prototype.ensurePatrolFacing(self, parent, direction)
	if not IsValidAlive(nil, parent) then
		return
	end
	local desiredDirection = self:normalizeDirection(direction, self.patrolDirection)
	local currentDirection = self:normalizeDirection(self.moveDirection, desiredDirection)
	local dotValue = currentDirection.x * desiredDirection.x + currentDirection.y * desiredDirection.y
	self.moveDirection = desiredDirection
	parent:SetForwardVector(desiredDirection)
	if dotValue < REMNANT_PATROL_RESTART_DOT then
		self:restartRemnantParticle(parent)
	end
end
function modifier_monster_11075_remnant_state.prototype.moveTowards(
	self,
	parent,
	origin,
	targetPosition,
	speed,
	turnSpeedDegrees
)
	local now = GameRules:GetGameTime()
	if not IsValidAlive(nil, parent) then
		return origin
	end
	local target = GetGroundPosition(targetPosition, parent)
	local toTarget = target:__sub(origin)
	local ____temp_4
	if self.avoidanceDirection ~= nil and now < self.avoidanceUntilTime then
		____temp_4 = self.avoidanceDirection
	else
		____temp_4 = self:normalizeDirection(toTarget, self.moveDirection)
	end
	local desiredDirection = ____temp_4
	local forwardDirection =
		self:steerDirection(self.moveDirection, desiredDirection, turnSpeedDegrees * REMNANT_THINK_INTERVAL)
	local nextPosition = self:getForwardMovePosition(parent, origin, forwardDirection, speed)
	if not self:isValidStepPosition(parent, origin, nextPosition) then
		return self:turnAwayFromBlockedForward(parent, origin, forwardDirection, speed)
	end
	self:clearAvoidanceIfExpired(now)
	self:updateRemnantFacing(parent, self:getActualMoveDirection(origin, nextPosition, forwardDirection))
	parent:SetAbsOrigin(nextPosition)
	self:updateRemnantParticleOrigin(nextPosition)
	return nextPosition
end
function modifier_monster_11075_remnant_state.prototype.getForwardMovePosition(self, parent, origin, direction, speed)
	return GetGroundPosition(origin:__add(direction:__mul(speed * REMNANT_THINK_INTERVAL)), parent)
end
function modifier_monster_11075_remnant_state.prototype.turnAwayFromBlockedForward(
	self,
	parent,
	origin,
	blockedDirection,
	speed
)
	local now = GameRules:GetGameTime()
	if self.avoidanceDirection == nil or now >= self.avoidanceUntilTime then
		self.avoidanceDirection = self:rotateDirection(blockedDirection, REMNANT_AVOIDANCE_TURN_DEGREES * self.turnSign)
		self.avoidanceUntilTime = now + REMNANT_AVOIDANCE_DURATION
	end
	local forwardDirection = self:steerDirection(
		self.moveDirection,
		self.avoidanceDirection,
		REMNANT_THUNDERIZED_TURN_SPEED_DEGREES * REMNANT_THINK_INTERVAL
	)
	if not IsValidAlive(nil, parent) then
		return origin
	end
	local nextPosition = self:getForwardMovePosition(parent, origin, forwardDirection, speed)
	if not self:isValidStepPosition(parent, origin, nextPosition) then
		return origin
	end
	self:updateRemnantFacing(parent, self:getActualMoveDirection(origin, nextPosition, forwardDirection))
	parent:SetAbsOrigin(nextPosition)
	self:updateRemnantParticleOrigin(nextPosition)
	return nextPosition
end
function modifier_monster_11075_remnant_state.prototype.isValidStepPosition(self, parent, origin, point)
	return IsGridNavDisplacementWalkable(nil, point)
end
function modifier_monster_11075_remnant_state.prototype.updateRemnantFacing(self, parent, direction)
	if not IsValidAlive(nil, parent) then
		return
	end
	local normalizedDirection = self:normalizeDirection(direction, self.moveDirection)
	self.moveDirection = normalizedDirection
	parent:SetForwardVector(normalizedDirection)
end
function modifier_monster_11075_remnant_state.prototype.getActualMoveDirection(
	self,
	origin,
	nextPosition,
	fallbackDirection
)
	local delta = nextPosition:__sub(origin)
	return self:normalizeDirection(delta, fallbackDirection)
end
function modifier_monster_11075_remnant_state.prototype.steerDirection(
	self,
	currentDirection,
	desiredDirection,
	maxTurnDegrees
)
	local current = self:normalizeDirection(currentDirection, Vector(1, 0, 0))
	local desired = self:normalizeDirection(desiredDirection, current)
	local dotValue = math.max(-1, math.min(1, current.x * desired.x + current.y * desired.y))
	local crossValue = current.x * desired.y - current.y * desired.x
	local angle = math.atan2(crossValue, dotValue)
	if math.abs(math.abs(angle) - math.pi) <= 0.05 then
		angle = math.pi * self.turnSign
	end
	local maxTurnRadians = math.max(maxTurnDegrees, 0) * math.pi / 180
	local clampedAngle = math.max(-maxTurnRadians, math.min(maxTurnRadians, angle))
	if math.abs(clampedAngle) <= 0.001 then
		return desired
	end
	return self:rotateDirection(current, clampedAngle * 180 / math.pi)
end
function modifier_monster_11075_remnant_state.prototype.clearAvoidanceIfExpired(self, now)
	if self.avoidanceDirection == nil then
		return
	end
	if now < self.avoidanceUntilTime then
		return
	end
	self.avoidanceDirection = nil
end
function modifier_monster_11075_remnant_state.prototype.createInitialDirection(self, index)
	local angle = index / SUMMON_COUNT * math.pi * 2 + RandomFloat(-0.65, 0.65)
	return Vector(math.cos(angle), math.sin(angle), 0):Normalized()
end
function modifier_monster_11075_remnant_state.prototype.rotateDirection(self, direction, degrees)
	local normalizedDirection = self:normalizeDirection(direction, Vector(1, 0, 0))
	local radians = degrees * math.pi / 180
	local cosValue = math.cos(radians)
	local sinValue = math.sin(radians)
	return Vector(
		normalizedDirection.x * cosValue - normalizedDirection.y * sinValue,
		normalizedDirection.x * sinValue + normalizedDirection.y * cosValue,
		0
	):Normalized()
end
function modifier_monster_11075_remnant_state.prototype.normalizeDirection(self, direction, fallback)
	local flatDirection = Vector(direction.x, direction.y, 0)
	if flatDirection:Length2D() > 0.01 then
		return flatDirection:Normalized()
	end
	local flatFallback = Vector(fallback.x, fallback.y, 0)
	if flatFallback:Length2D() > 0.01 then
		return flatFallback:Normalized()
	end
	return Vector(1, 0, 0)
end
function modifier_monster_11075_remnant_state.prototype.getThunderizedMoveTarget(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self.thunderizedTarget = nil
		return nil
	end
	local now = GameRules:GetGameTime()
	if not ShouldIgnoreMovingRemnantImpact(nil, self.thunderizedTarget, self.roomId) then
		self.thunderizedTarget = nil
	end
	if now >= self.nextThunderizedTargetSearchTime then
		self.thunderizedTarget = FindNearestThunderizedEnemyForMovingRemnant(
			nil,
			caster,
			origin,
			REMNANT_THUNDERIZED_SEARCH_RANGE,
			self.roomId
		)
		self.nextThunderizedTargetSearchTime = now + REMNANT_THUNDERIZED_RETARGET_INTERVAL
	end
	local ____ShouldIgnoreMovingRemnantImpact_result_5
	if ShouldIgnoreMovingRemnantImpact(nil, self.thunderizedTarget, self.roomId) then
		____ShouldIgnoreMovingRemnantImpact_result_5 = self.thunderizedTarget
	else
		____ShouldIgnoreMovingRemnantImpact_result_5 = nil
	end
	return ____ShouldIgnoreMovingRemnantImpact_result_5
end
function modifier_monster_11075_remnant_state.prototype.findHitTarget(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		REMNANT_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_CLOSEST,
		false
	)
	for ____, enemy in ipairs(enemies) do
		if IsValidAlive(nil, enemy) then
			return enemy
		end
	end
	return nil
end
function modifier_monster_11075_remnant_state.prototype.explode(self, position)
	if self.exploded then
		return
	end
	self.exploded = true
	self:explodeAt(position)
	self:Destroy()
end
function modifier_monster_11075_remnant_state.prototype.explodeAt(self, position)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	local explodePos = GetGroundPosition(position, parent)
	if IsValidAlive(nil, caster) then
		EmitSoundOnLocationWithCaster(explodePos, SOUND_REMNANT_EXPLODE, caster)
	elseif IsValidAlive(nil, parent) then
		parent:EmitSound(SOUND_REMNANT_EXPLODE)
	end
	self:playExplosionParticle(explodePos)
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		explodePos,
		nil,
		REMNANT_EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue103
			end
			if ShouldIgnoreMovingRemnantImpact(nil, enemy, self.roomId) then
				goto __continue103
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = REMNANT_DAMAGE_RATE, ability = ability })
			modifier_monster_11075_remnant_slow:applys(enemy, caster, ability, { duration = REMNANT_SLOW_DURATION })
		end
		::__continue103::
	end
end
function modifier_monster_11075_remnant_state.prototype.createRemnantParticle(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	self.pfxRemnant = ParticleManager:CreateParticle(PARTICLE_REMNANT, PATTACH_CUSTOMORIGIN, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxRemnant, false)
	self:updateRemnantParticleOrigin(parent:GetAbsOrigin())
	ParticleManager:SetParticleControlEnt(
		self.pfxRemnant,
		1,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
end
function modifier_monster_11075_remnant_state.prototype.updateRemnantParticleOrigin(self, position)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxRemnant, 0, position)
end
function modifier_monster_11075_remnant_state.prototype.destroyRemnantParticle(self)
	if self.pfxRemnant == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxRemnant, false)
	ParticleManager:ReleaseParticleIndex(self.pfxRemnant)
	self.pfxRemnant = nil
end
function modifier_monster_11075_remnant_state.prototype.restartRemnantParticle(self, parent)
	if self.pfxRemnant ~= nil then
		ParticleManager:DestroyParticle(self.pfxRemnant, true)
		ParticleManager:ReleaseParticleIndex(self.pfxRemnant)
		self.pfxRemnant = nil
	end
	self:createRemnantParticle(parent)
end
function modifier_monster_11075_remnant_state.prototype.playExplosionParticle(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_REMNANT_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
modifier_monster_11075_remnant_state = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_11075_remnant_state") },
	modifier_monster_11075_remnant_state
)
modifier_monster_11075_remnant_slow = __TS__Class()
modifier_monster_11075_remnant_slow.name = "modifier_monster_11075_remnant_slow"
__TS__ClassExtends(modifier_monster_11075_remnant_slow, MonsterModifier_CS)
function modifier_monster_11075_remnant_slow.prototype.IsHidden(self)
	return false
end
function modifier_monster_11075_remnant_slow.prototype.IsDebuff(self)
	return true
end
function modifier_monster_11075_remnant_slow.prototype.IsPurgable(self)
	return true
end
function modifier_monster_11075_remnant_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = REMNANT_SLOW_MOVESPEED_PCT }
end
function modifier_monster_11075_remnant_slow.prototype.GetEffectName(self)
	return "particles/void_spirit_astral_step_debuff_ember_blue.vpcf"
end
function modifier_monster_11075_remnant_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_monster_11075_remnant_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_monster_11075_remnant_slow") },
	modifier_monster_11075_remnant_slow
)
return ____exports