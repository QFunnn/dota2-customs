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
local modifier_boss_storm_spirit_2_slow
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
local CAST_POINT = 0.3
local CIRCLE_SMALL_RADIUS = 320
local CIRCLE_LARGE_RADIUS = 600
local CIRCLE_LARGE_DURATION = 0.9
local CIRCLE_SMALL_DURATION = CIRCLE_LARGE_DURATION * (CIRCLE_SMALL_RADIUS / CIRCLE_LARGE_RADIUS)
local CIRCLE_GAP_DURATION = 0.3
local TOTAL_TRAVEL_DURATION = CIRCLE_SMALL_DURATION + CIRCLE_GAP_DURATION + CIRCLE_LARGE_DURATION
local CENTER_TARGET_SEARCH_RANGE = CIRCLE_LARGE_RADIUS + 800
local BALL_THINK_INTERVAL = 0.03
local BALL_HIT_RADIUS = 200
local BALL_DAMAGE_RATE = 10
local BALL_SLOW_DURATION = 1
local BALL_SLOW_MOVESPEED_PCT = -30
local FINAL_LANDING_SEARCH_STEP = 80
local REMNANT_SPAWN_DISTANCE = 420
local REMNANT_SECOND_CIRCLE_SPAWN_DISTANCE = REMNANT_SPAWN_DISTANCE / 1.2
local REMNANT_MIN_SEPARATION = 120
local REMNANT_SEAM_SKIP_RADIUS = 100
local REMNANT_HIT_RADIUS = 140
local REMNANT_EXPLOSION_RADIUS = 240
local REMNANT_DAMAGE_RATE = 12
local REMNANT_STUN_DURATION = 0.5
local REMNANT_MOVE_SPEED = 400
local REMNANT_CENTER_HIT_RADIUS = 50
local REMNANT_THINK_INTERVAL = 0.03
local REMNANT_ARM_DELAY = 0.7
local REMNANT_RECALL_GRACE_DURATION = 0.1
local REMNANT_RECALL_MAX_DURATION = CIRCLE_LARGE_RADIUS / REMNANT_MOVE_SPEED + 0.6
local REMNANT_THINKER_DURATION = TOTAL_TRAVEL_DURATION + REMNANT_RECALL_MAX_DURATION + 0.5
local REMNANT_THUNDERIZED_TARGET_SEARCH_RANGE = CIRCLE_LARGE_RADIUS + CENTER_TARGET_SEARCH_RANGE
local REMNANT_THUNDERIZED_RETARGET_INTERVAL = 0.15
local PARTICLE_BALL_LIGHTNING = "particles/stormspirit_orchid_ball_lightning.vpcf"
local PARTICLE_STATIC_REMNANT = "particles/boss/boss_storm_spirit/ak_stormspirit_static_remnant_image.vpcf"
local PARTICLE_MOVING_REMNANT = "particles/boss/boss_storm_spirit/ak_stormspirit_moving_remnant.vpcf"
local PARTICLE_REMNANT_EXPLOSION = "particles/units/heroes/hero_stormspirit/stormspirit_overload_discharge.vpcf"
local SOUND_BALL_START = "Hero_StormSpirit.BallLightning"
local SOUND_BALL_LOOP = "Hero_StormSpirit.BallLightning.Loop"
local SOUND_REMNANT_CAST = "Hero_StormSpirit.StaticRemnantPlant"
local SOUND_REMNANT_EXPLODE = "Hero_StormSpirit.StaticRemnantExplode"
--- 球状闪电：绕自身飞行两圈，并沿路径留下会爆炸的静态残影。
____exports.boss_storm_spirit_2 = __TS__Class()
local boss_storm_spirit_2 = ____exports.boss_storm_spirit_2
boss_storm_spirit_2.name = "boss_storm_spirit_2"
__TS__ClassExtends(boss_storm_spirit_2, MonsterAbility_CS)
function boss_storm_spirit_2.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE_BALL_LIGHTNING, context)
	PrecacheResource("particle", PARTICLE_STATIC_REMNANT, context)
	PrecacheResource("particle", PARTICLE_MOVING_REMNANT, context)
	PrecacheResource("particle", PARTICLE_REMNANT_EXPLOSION, context)
end
function boss_storm_spirit_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = TOTAL_TRAVEL_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 1.2,
		isNotMove = true,
		OnPhaseStart = function()
			return self:onPhaseStart()
		end,
		OnInterrupt = function()
			return self:clearCastPreview()
		end,
		OnFinish = function()
			return self:clearCastPreview()
		end,
		OnStart = function()
			return self:onStart()
		end,
	}
end
function boss_storm_spirit_2.prototype.onPhaseStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = caster:GetMinDistanceUnit(CENTER_TARGET_SEARCH_RANGE)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 4)
	end
	local center = self:getCircleCenter(caster)
	local startDirection = self:getCircleStartDirection(caster, center)
	self.previewCenter = center
	self.previewStartDirection = startDirection
	self:playCastPreview(caster, center, startDirection)
end
function boss_storm_spirit_2.prototype.onStart(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local center = self.previewCenter or self:getCircleCenter(caster)
	local previewDirection = self.previewStartDirection or self:getCircleStartDirection(caster, center)
	local startDirection = self:blinkToCircleStart(caster, center, previewDirection)
	self:clearCastPreview()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 1.5)
	caster:AddNewModifier(caster, self, "modifier_boss_storm_spirit_2_ball", {
		duration = TOTAL_TRAVEL_DURATION,
		center_x = center.x,
		center_y = center.y,
		center_z = center.z,
		forward_x = startDirection.x,
		forward_y = startDirection.y,
		forward_z = startDirection.z,
	})
end
function boss_storm_spirit_2.prototype.clearCastPreview(self)
	self.previewCenter = nil
	self.previewStartDirection = nil
end
function boss_storm_spirit_2.prototype.playCastPreview(self, caster, center, startDirection) end
function boss_storm_spirit_2.prototype.getCircleCenter(self, caster)
	local target = caster:GetMinDistanceUnit(CENTER_TARGET_SEARCH_RANGE)
	local ____IsValidAlive_result_0
	if IsValidAlive(nil, target) then
		____IsValidAlive_result_0 = target:GetAbsOrigin()
	else
		____IsValidAlive_result_0 = caster:GetAbsOrigin()
	end
	local center = ____IsValidAlive_result_0
	return GetGroundPosition(center, caster)
end
function boss_storm_spirit_2.prototype.getCircleStartDirection(self, caster, center)
	local fromCenterToCaster = caster:GetAbsOrigin():__sub(center)
	return self:normalizeDirection(fromCenterToCaster, caster:GetForwardVector())
end
function boss_storm_spirit_2.prototype.blinkToCircleStart(self, caster, center, direction)
	local startPosition = GetGroundPosition(center:__add(direction:__mul(CIRCLE_SMALL_RADIUS)), caster)
	caster:AddNoDrawWithWearables()
	ProjectileManager:ProjectileDodge(caster)
	caster:EmitSound(SOUND_BALL_START)
	FindClearSpaceForUnit(caster, startPosition, true)
	local actualDirection = self:normalizeDirection(caster:GetAbsOrigin():__sub(center), direction)
	caster:SetForwardVector(Vector(-actualDirection.y, actualDirection.x, 0))
	return actualDirection
end
function boss_storm_spirit_2.prototype.normalizeDirection(self, direction, fallback)
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
boss_storm_spirit_2 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_storm_spirit_2)
____exports.boss_storm_spirit_2 = boss_storm_spirit_2
local modifier_boss_storm_spirit_2_ball = __TS__Class()
modifier_boss_storm_spirit_2_ball.name = "modifier_boss_storm_spirit_2_ball"
__TS__ClassExtends(modifier_boss_storm_spirit_2_ball, MonsterModifier_CS)
function modifier_boss_storm_spirit_2_ball.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.center = Vector(0, 0, 0)
	self.baseAngle = 0
	self.remnantDistance = 0
	self.hitRecords = {}
	self.remnantIndexes = {}
	self.recalledRemnants = false
	self.warnedSecondCircle = false
end
function modifier_boss_storm_spirit_2_ball.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_2_ball.prototype.IsPurgable(self)
	return false
end
function modifier_boss_storm_spirit_2_ball.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_2_ball.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		self:Destroy()
		return
	end
	self.center = Vector(
		params.center_x or parent:GetAbsOrigin().x,
		params.center_y or parent:GetAbsOrigin().y,
		params.center_z or parent:GetAbsOrigin().z
	)
	local forward = self:normalizeDirection(
		Vector(params.forward_x or 1, params.forward_y or 0, params.forward_z or 0),
		parent:GetForwardVector()
	)
	self.baseAngle = math.atan2(forward.y, forward.x)
	self:hideCasterModel(parent)
	self:createBallParticle(parent:GetAbsOrigin())
	self:recordWalkablePosition(parent:GetAbsOrigin())
	self:playRecallCenterWarning()
	parent:EmitSound(SOUND_BALL_LOOP)
	ProjectileManager:ProjectileDodge(parent)
	self:StartIntervalThink(BALL_THINK_INTERVAL)
	self:OnIntervalThink()
end
function modifier_boss_storm_spirit_2_ball.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		self:Destroy()
		return
	end
	local elapsed = math.min(self:GetElapsedTime(), TOTAL_TRAVEL_DURATION)
	local travelState = self:getTravelState(parent, elapsed)
	local travelPosition = travelState.position
	self:moveCaster(parent, travelPosition)
	if not travelState.isGap then
		local isNewCircle = self:switchCircleIfNeeded(travelState.circleIndex, travelPosition)
		self:damageEnemiesOnPath(caster, ability, travelPosition)
		if isNewCircle then
			self:spawnStaticRemnant(caster, ability, travelPosition, travelState.circleIndex, true)
		else
			self:spawnRemnantsByDistance(caster, ability, travelPosition, travelState.circleIndex)
		end
	else
		self:playSecondCircleWarningOnce()
		self:resetRemnantDistance(travelPosition)
	end
	if elapsed >= TOTAL_TRAVEL_DURATION then
		self:landCasterOnWalkablePosition(parent, travelPosition)
		self:recallAllRemnants(self.center)
		self:Destroy()
	end
end
function modifier_boss_storm_spirit_2_ball.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	if self:GetElapsedTime() >= TOTAL_TRAVEL_DURATION - BALL_THINK_INTERVAL then
		self:recallAllRemnants(self.center)
	end
	self:destroyBallParticle()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:StopSound(SOUND_BALL_LOOP)
		parent:RemoveNoDrawWithWearables()
		local landingPosition = self:findWalkableLandingPosition(parent, parent:GetAbsOrigin())
		FindClearSpaceForUnit(parent, landingPosition, true)
	end
end
function modifier_boss_storm_spirit_2_ball.prototype.hideCasterModel(self, parent)
	parent:AddNoDrawWithWearables()
end
function modifier_boss_storm_spirit_2_ball.prototype.getTravelState(self, parent, elapsed)
	local firstCircleEnd = CIRCLE_SMALL_DURATION
	local secondCircleStart = CIRCLE_SMALL_DURATION + CIRCLE_GAP_DURATION
	if elapsed < firstCircleEnd then
		return {
			position = self:getCirclePosition(parent, 0, elapsed / CIRCLE_SMALL_DURATION),
			circleIndex = 0,
			isGap = false,
		}
	end
	if elapsed < secondCircleStart then
		local gapProgress = (elapsed - firstCircleEnd) / CIRCLE_GAP_DURATION
		return {
			position = self:getRadialTransitionPosition(parent, gapProgress),
			circleIndex = 0,
			isGap = true,
		}
	end
	return {
		position = self:getCirclePosition(parent, 1, (elapsed - secondCircleStart) / CIRCLE_LARGE_DURATION),
		circleIndex = 1,
		isGap = false,
	}
end
function modifier_boss_storm_spirit_2_ball.prototype.getCirclePosition(self, parent, circleIndex, rawProgress)
	local progress = math.min(math.max(rawProgress, 0), 1)
	local radius = self:getCircleRadius(circleIndex)
	local angle = self.baseAngle + progress * math.pi * 2
	local rawPosition = self.center:__add(Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0))
	return GetGroundPosition(rawPosition, parent)
end
function modifier_boss_storm_spirit_2_ball.prototype.getRadialTransitionPosition(self, parent, rawProgress)
	local progress = math.min(math.max(rawProgress, 0), 1)
	local radius = CIRCLE_SMALL_RADIUS + (CIRCLE_LARGE_RADIUS - CIRCLE_SMALL_RADIUS) * progress
	local rawPosition =
		self.center:__add(Vector(math.cos(self.baseAngle) * radius, math.sin(self.baseAngle) * radius, 0))
	return GetGroundPosition(rawPosition, parent)
end
function modifier_boss_storm_spirit_2_ball.prototype.getCircleRadius(self, circleIndex)
	return circleIndex == 0 and CIRCLE_SMALL_RADIUS or CIRCLE_LARGE_RADIUS
end
function modifier_boss_storm_spirit_2_ball.prototype.playRecallCenterWarning(self) end
function modifier_boss_storm_spirit_2_ball.prototype.playSecondCircleWarningOnce(self)
	if self.warnedSecondCircle then
		return
	end
	self.warnedSecondCircle = true
	self:WarningRingEffect(self.center, CIRCLE_LARGE_RADIUS, CIRCLE_GAP_DURATION, { speed = 0 })
end
function modifier_boss_storm_spirit_2_ball.prototype.moveCaster(self, parent, position)
	if not IsValidAlive(nil, parent) then
		return
	end
	local tangent = self:getTangentDirection(position)
	GridNav:DestroyTreesAroundPoint(position, BALL_HIT_RADIUS, false)
	parent:SetAbsOrigin(position)
	parent:SetForwardVector(tangent)
	self:updateBallParticle(position)
	self:recordWalkablePosition(position)
end
function modifier_boss_storm_spirit_2_ball.prototype.landCasterOnWalkablePosition(self, parent, desiredPosition)
	if not IsValidAlive(nil, parent) then
		return
	end
	local landingPosition = self:findWalkableLandingPosition(parent, desiredPosition)
	parent:SetAbsOrigin(landingPosition)
	FindClearSpaceForUnit(parent, landingPosition, true)
	parent:SetForwardVector(self:getTangentDirection(parent:GetAbsOrigin()))
	self:updateBallParticle(parent:GetAbsOrigin())
	self:recordWalkablePosition(parent:GetAbsOrigin())
end
function modifier_boss_storm_spirit_2_ball.prototype.findWalkableLandingPosition(self, parent, desiredPosition)
	if not IsValidAlive(nil, parent) then
		return desiredPosition
	end
	local desiredLanding = GetGroundPosition(desiredPosition, parent)
	if self:isWalkableLandingPosition(desiredLanding) then
		return desiredLanding
	end
	local centerPosition = GetGroundPosition(self.center, parent)
	local toCenter = centerPosition:__sub(desiredLanding)
	local distanceToCenter = toCenter:Length2D()
	if distanceToCenter > 0.01 then
		local directionToCenter = toCenter:Normalized()
		do
			local distance = FINAL_LANDING_SEARCH_STEP
			while distance <= distanceToCenter do
				local candidate = GetGroundPosition(desiredLanding:__add(directionToCenter:__mul(distance)), parent)
				if self:isWalkableLandingPosition(candidate) then
					return candidate
				end
				distance = distance + FINAL_LANDING_SEARCH_STEP
			end
		end
	end
	if self.lastWalkablePosition and self:isWalkableLandingPosition(self.lastWalkablePosition) then
		return GetGroundPosition(self.lastWalkablePosition, parent)
	end
	if self:isWalkableLandingPosition(centerPosition) then
		return centerPosition
	end
	return GetGroundPosition(parent:GetAbsOrigin(), parent)
end
function modifier_boss_storm_spirit_2_ball.prototype.recordWalkablePosition(self, position)
	if not self:isWalkableLandingPosition(position) then
		return
	end
	self.lastWalkablePosition = Vector(position.x, position.y, position.z)
end
function modifier_boss_storm_spirit_2_ball.prototype.isWalkableLandingPosition(self, position)
	if not IsGridNavDisplacementWalkable(nil, position) then
		return false
	end
	if not GridNav:CanFindPath(self.center, position) then
		return false
	end
	return GridNav:FindPathLength(self.center, position) ~= -1
end
function modifier_boss_storm_spirit_2_ball.prototype.createBallParticle(self, position)
	self.pfxBall = ParticleManager:CreateParticle(PARTICLE_BALL_LIGHTNING, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxBall, false)
	self:updateBallParticle(position)
end
function modifier_boss_storm_spirit_2_ball.prototype.updateBallParticle(self, position)
	if self.pfxBall == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxBall, 0, position)
end
function modifier_boss_storm_spirit_2_ball.prototype.destroyBallParticle(self)
	if self.pfxBall == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxBall, false)
	ParticleManager:ReleaseParticleIndex(self.pfxBall)
	self.pfxBall = nil
end
function modifier_boss_storm_spirit_2_ball.prototype.getTangentDirection(self, position)
	local radiusDirection = self:normalizeDirection(position:__sub(self.center), Vector(1, 0, 0))
	return Vector(-radiusDirection.y, radiusDirection.x, 0)
end
function modifier_boss_storm_spirit_2_ball.prototype.damageEnemiesOnPath(self, caster, ability, position)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
		nil,
		BALL_HIT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue76
			end
			local enemyIndex = enemy:entindex()
			if self.hitRecords[enemyIndex] then
				goto __continue76
			end
			self.hitRecords[enemyIndex] = true
			caster:MonsterDamage({ victim = enemy, damage_rate = BALL_DAMAGE_RATE, ability = ability })
			modifier_boss_storm_spirit_2_slow:applys(enemy, caster, ability, { duration = BALL_SLOW_DURATION })
		end
		::__continue76::
	end
end
function modifier_boss_storm_spirit_2_ball.prototype.switchCircleIfNeeded(self, circleIndex, position)
	if self.activeCircleIndex == circleIndex then
		return false
	end
	self.activeCircleIndex = circleIndex
	self:resetRemnantDistance(position)
	return true
end
function modifier_boss_storm_spirit_2_ball.prototype.resetRemnantDistance(self, position)
	self.lastPosition = Vector(position.x, position.y, position.z)
	self.remnantDistance = 0
end
function modifier_boss_storm_spirit_2_ball.prototype.spawnRemnantsByDistance(
	self,
	caster,
	ability,
	position,
	circleIndex
)
	if not self.lastPosition then
		self.lastPosition = Vector(position.x, position.y, position.z)
		return
	end
	local spawnDistance = self:getRemnantSpawnDistance(circleIndex)
	self.remnantDistance = self.remnantDistance + GetDistance(nil, self.lastPosition, position)
	self.lastPosition = Vector(position.x, position.y, position.z)
	while self.remnantDistance >= spawnDistance do
		local spawned = self:spawnStaticRemnant(caster, ability, position, circleIndex)
		if not spawned then
			break
		end
		self.remnantDistance = self.remnantDistance - spawnDistance
	end
end
function modifier_boss_storm_spirit_2_ball.prototype.getRemnantSpawnDistance(self, circleIndex)
	local ____temp_1
	if circleIndex == 1 then
		____temp_1 = REMNANT_SECOND_CIRCLE_SPAWN_DISTANCE
	else
		____temp_1 = REMNANT_SPAWN_DISTANCE
	end
	return ____temp_1
end
function modifier_boss_storm_spirit_2_ball.prototype.spawnStaticRemnant(
	self,
	caster,
	ability,
	position,
	circleIndex,
	allowSeam
)
	if allowSeam == nil then
		allowSeam = false
	end
	if not IsValidAlive(nil, caster) then
		return false
	end
	local groundPosition = GetGroundPosition(position, caster)
	if not self:canSpawnRemnantAt(groundPosition, circleIndex, allowSeam) then
		return false
	end
	local ____CreateModifierThinker_7 = CreateModifierThinker
	local ____caster_5 = caster
	local ____ability_6 = ability
	local ____temp_4 = caster:GetModelName()
	local ____this_3
	____this_3 = caster
	local ____opt_2 = ____this_3.GetRoomId
	local thinker = ____CreateModifierThinker_7(____caster_5, ____ability_6, "modifier_boss_storm_spirit_2_remnant", {
		duration = REMNANT_THINKER_DURATION,
		parent_model = ____temp_4,
		room_id = ____opt_2 and ____opt_2(____this_3),
	}, groundPosition, caster:GetTeamNumber(), false)
	if not IsValidAlive(nil, thinker) then
		return false
	end
	caster:EmitSound(SOUND_REMNANT_CAST)
	self.lastRemnantPosition = Vector(groundPosition.x, groundPosition.y, groundPosition.z)
	local ____self_remnantIndexes_8 = self.remnantIndexes
	____self_remnantIndexes_8[#____self_remnantIndexes_8 + 1] = thinker:entindex()
	return true
end
function modifier_boss_storm_spirit_2_ball.prototype.canSpawnRemnantAt(self, position, circleIndex, allowSeam)
	if not allowSeam and self:isNearCircleSeam(position, circleIndex) then
		return false
	end
	if not self.lastRemnantPosition then
		return true
	end
	return GetDistance(nil, self.lastRemnantPosition, position) >= REMNANT_MIN_SEPARATION
end
function modifier_boss_storm_spirit_2_ball.prototype.isNearCircleSeam(self, position, circleIndex)
	local radius = self:getCircleRadius(circleIndex)
	local seamPosition =
		self.center:__add(Vector(math.cos(self.baseAngle) * radius, math.sin(self.baseAngle) * radius, 0))
	return GetDistance(nil, position, seamPosition) <= REMNANT_SEAM_SKIP_RADIUS
end
function modifier_boss_storm_spirit_2_ball.prototype.recallAllRemnants(self, recallCenter)
	if recallCenter == nil then
		recallCenter = self.center
	end
	if self.recalledRemnants then
		return
	end
	self.recalledRemnants = true
	for ____, entityIndex in ipairs(self.remnantIndexes) do
		do
			local thinker = EntIndexToHScript(entityIndex)
			if not IsValidAlive(nil, thinker) then
				goto __continue98
			end
			if not thinker or not IsValid(nil, thinker) or thinker:IsNull() then
				goto __continue98
			end
			local remnant = thinker:FindModifierByName("modifier_boss_storm_spirit_2_remnant")
			if remnant ~= nil then
				remnant:startMovingToCenter(recallCenter)
			end
		end
		::__continue98::
	end
end
function modifier_boss_storm_spirit_2_ball.prototype.normalizeDirection(self, direction, fallback)
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
modifier_boss_storm_spirit_2_ball = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_2_ball") },
	modifier_boss_storm_spirit_2_ball
)
local modifier_boss_storm_spirit_2_remnant = __TS__Class()
modifier_boss_storm_spirit_2_remnant.name = "modifier_boss_storm_spirit_2_remnant"
__TS__ClassExtends(modifier_boss_storm_spirit_2_remnant, MonsterModifier_CS)
function modifier_boss_storm_spirit_2_remnant.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.exploded = false
	self.moving = false
	self.center = Vector(0, 0, 0)
	self.nextThunderizedTargetSearchTime = 0
end
function modifier_boss_storm_spirit_2_remnant.prototype.IsHidden(self)
	return true
end
function modifier_boss_storm_spirit_2_remnant.prototype.IsPurgable(self)
	return false
end
function modifier_boss_storm_spirit_2_remnant.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not IsValid(nil, parent) or parent:IsNull() then
		self:Destroy()
		return
	end
	self._parent:SetOriginalModel(params.parent_model or "")
	self._parent:SetModel(params.parent_model or "")
	self._parent:SetModelScale(0.01)
	self.roomId = params.room_id
	if self.roomId ~= nil then
		self._parent.__room_id__ = self.roomId
	end
	self:createStaticParticle(parent)
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
end
function modifier_boss_storm_spirit_2_remnant.prototype.CheckState(self)
	return { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
end
function modifier_boss_storm_spirit_2_remnant.prototype.OnIntervalThink(self)
	if not IsServer() or self.exploded then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	if self.moving then
		self:moveToCurrentTarget(parent)
		return
	end
	if self:isArmed() and self:findHitTarget(parent:GetAbsOrigin()) then
		self:explode(parent:GetAbsOrigin())
	end
end
function modifier_boss_storm_spirit_2_remnant.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	local ____temp_11
	if IsValid(nil, parent) and not parent:IsNull() then
		____temp_11 = parent:GetAbsOrigin()
	else
		____temp_11 = Vector(0, 0, 0)
	end
	local origin = ____temp_11
	if not self.exploded then
		if self:isArmed() then
			self:explodeAt(origin)
		end
		self.exploded = true
	end
	self:destroyParticles()
	if IsValid(nil, parent) and not parent:IsNull() then
		parent:SelfRemoveSelf()
	end
end
function modifier_boss_storm_spirit_2_remnant.prototype.startMovingToCenter(self, center)
	if not IsServer() or self.exploded or self.moving then
		return
	end
	local parent = self:GetParent()
	if not IsValidAlive(nil, parent) then
		return
	end
	if not IsValid(nil, parent) or parent:IsNull() then
		return
	end
	self.moving = true
	self.recallStartTime = GameRules:GetGameTime()
	self.nextThunderizedTargetSearchTime = 0
	self.center = GetGroundPosition(center, parent)
	self:destroyStaticParticle(true)
	self:createMovingParticle(parent:GetAbsOrigin())
	self:StartIntervalThink(REMNANT_THINK_INTERVAL)
end
function modifier_boss_storm_spirit_2_remnant.prototype.createStaticParticle(self, parent)
	local position = parent:GetAbsOrigin()
	self.pfxStatic = ParticleManager:CreateParticle(PARTICLE_STATIC_REMNANT, PATTACH_WORLDORIGIN, parent)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxStatic, false)
	ParticleManager:SetParticleControl(self.pfxStatic, 0, position)
	local random = RandomInt(0, 10)
	ParticleManager:SetParticleControl(self.pfxStatic, 2, Vector(random, 1, 100))
end
function modifier_boss_storm_spirit_2_remnant.prototype.findHitTarget(self, position)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
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
function modifier_boss_storm_spirit_2_remnant.prototype.moveToCurrentTarget(self, parent)
	if not IsValidAlive(nil, parent) then
		return
	end
	local origin = parent:GetAbsOrigin()
	if self:canExplodeNow() and self:findHitTarget(origin) then
		self:explode(origin)
		return
	end
	local targetPosition = self:getMoveTargetPosition(parent, origin)
	local toTarget = targetPosition:__sub(origin)
	local distance = toTarget:Length2D()
	local stepDistance = REMNANT_MOVE_SPEED * REMNANT_THINK_INTERVAL
	if distance <= REMNANT_CENTER_HIT_RADIUS or distance <= stepDistance then
		parent:SetAbsOrigin(targetPosition)
		self:updateMovingParticle(targetPosition)
		if self:canExplodeNow() then
			self:explode(targetPosition)
		end
		return
	end
	local direction = self:normalizeDirection(toTarget, parent:GetForwardVector())
	local nextPosition = GetGroundPosition(origin:__add(direction:__mul(stepDistance)), parent)
	parent:SetAbsOrigin(nextPosition)
	parent:SetForwardVector(direction)
	self:updateMovingParticle(nextPosition)
	if self:canExplodeNow() and self:findHitTarget(nextPosition) then
		self:explode(nextPosition)
	end
end
function modifier_boss_storm_spirit_2_remnant.prototype.getMoveTargetPosition(self, parent, origin)
	local thunderizedTarget = self:getThunderizedMoveTarget(origin)
	if IsValidAlive(nil, thunderizedTarget) then
		return GetGroundPosition(thunderizedTarget:GetAbsOrigin(), parent)
	end
	return self.center
end
function modifier_boss_storm_spirit_2_remnant.prototype.getThunderizedMoveTarget(self, origin)
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
			REMNANT_THUNDERIZED_TARGET_SEARCH_RANGE,
			self.roomId
		)
		self.nextThunderizedTargetSearchTime = now + REMNANT_THUNDERIZED_RETARGET_INTERVAL
	end
	local ____ShouldIgnoreMovingRemnantImpact_result_12
	if ShouldIgnoreMovingRemnantImpact(nil, self.thunderizedTarget, self.roomId) then
		____ShouldIgnoreMovingRemnantImpact_result_12 = self.thunderizedTarget
	else
		____ShouldIgnoreMovingRemnantImpact_result_12 = nil
	end
	return ____ShouldIgnoreMovingRemnantImpact_result_12
end
function modifier_boss_storm_spirit_2_remnant.prototype.isArmed(self)
	return self:GetElapsedTime() >= REMNANT_ARM_DELAY
end
function modifier_boss_storm_spirit_2_remnant.prototype.canExplodeNow(self)
	if not self:isArmed() then
		return false
	end
	if not self.moving or self.recallStartTime == nil then
		return true
	end
	return GameRules:GetGameTime() - self.recallStartTime >= REMNANT_RECALL_GRACE_DURATION
end
function modifier_boss_storm_spirit_2_remnant.prototype.normalizeDirection(self, direction, fallback)
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
function modifier_boss_storm_spirit_2_remnant.prototype.explode(self, position)
	if self.exploded then
		return
	end
	self.exploded = true
	self:explodeAt(position)
	self:Destroy()
end
function modifier_boss_storm_spirit_2_remnant.prototype.explodeAt(self, position)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	local parent = self:GetParent()
	if IsValidAlive(nil, caster) then
		EmitSoundOnLocationWithCaster(position, SOUND_REMNANT_EXPLODE, caster)
	elseif IsValidAlive(nil, parent) then
		parent:EmitSound(SOUND_REMNANT_EXPLODE)
	end
	self:playExplosionParticle(position)
	if not IsValidAlive(nil, caster) or not ability or ability:IsNull() then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		position,
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
				goto __continue158
			end
			if ShouldIgnoreMovingRemnantImpact(nil, enemy) then
				goto __continue158
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = REMNANT_DAMAGE_RATE, ability = ability })
			AddDeBuffStatus(nil, enemy, caster, ability, DebuffStatusType.STUN, { duration = REMNANT_STUN_DURATION })
		end
		::__continue158::
	end
end
function modifier_boss_storm_spirit_2_remnant.prototype.playExplosionParticle(self, position)
	local pfx = ParticleManager:CreateParticle(PARTICLE_REMNANT_EXPLOSION, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(pfx, false)
	ParticleManager:SetParticleControl(pfx, 0, position)
	ParticleManager:ReleaseParticleIndex(pfx)
end
function modifier_boss_storm_spirit_2_remnant.prototype.createMovingParticle(self, position)
	self.pfxMoving = ParticleManager:CreateParticle(PARTICLE_MOVING_REMNANT, PATTACH_CUSTOMORIGIN, nil)
	ParticleManager:SetParticleShouldCheckFoW(self.pfxMoving, false)
	self:updateMovingParticle(position)
end
function modifier_boss_storm_spirit_2_remnant.prototype.updateMovingParticle(self, position)
	if self.pfxMoving == nil then
		return
	end
	ParticleManager:SetParticleControl(self.pfxMoving, 0, position)
end
function modifier_boss_storm_spirit_2_remnant.prototype.destroyParticles(self)
	self:destroyStaticParticle()
	self:destroyMovingParticle()
end
function modifier_boss_storm_spirit_2_remnant.prototype.destroyStaticParticle(self, immediate)
	if immediate == nil then
		immediate = false
	end
	if self.pfxStatic == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxStatic, immediate)
	ParticleManager:ReleaseParticleIndex(self.pfxStatic)
	self.pfxStatic = nil
end
function modifier_boss_storm_spirit_2_remnant.prototype.destroyMovingParticle(self)
	if self.pfxMoving == nil then
		return
	end
	ParticleManager:DestroyParticle(self.pfxMoving, false)
	ParticleManager:ReleaseParticleIndex(self.pfxMoving)
	self.pfxMoving = nil
end
modifier_boss_storm_spirit_2_remnant = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_2_remnant") },
	modifier_boss_storm_spirit_2_remnant
)
modifier_boss_storm_spirit_2_slow = __TS__Class()
modifier_boss_storm_spirit_2_slow.name = "modifier_boss_storm_spirit_2_slow"
__TS__ClassExtends(modifier_boss_storm_spirit_2_slow, MonsterModifier_CS)
function modifier_boss_storm_spirit_2_slow.prototype.IsHidden(self)
	return false
end
function modifier_boss_storm_spirit_2_slow.prototype.IsDebuff(self)
	return true
end
function modifier_boss_storm_spirit_2_slow.prototype.IsPurgable(self)
	return true
end
function modifier_boss_storm_spirit_2_slow.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = BALL_SLOW_MOVESPEED_PCT }
end
function modifier_boss_storm_spirit_2_slow.prototype.GetEffectName(self)
	return "particles/void_spirit_astral_step_debuff_ember_blue.vpcf"
end
function modifier_boss_storm_spirit_2_slow.prototype.GetEffectAttachType(self)
	return PATTACH_ABSORIGIN_FOLLOW
end
modifier_boss_storm_spirit_2_slow = __TS__DecorateLegacy(
	{ registerModifier(nil, "modifier_boss_storm_spirit_2_slow") },
	modifier_boss_storm_spirit_2_slow
)
return ____exports