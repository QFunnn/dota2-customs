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
local ____elite_showcase_utils = require("abilities.monster.elite.elite_showcase_utils")
local EliteCreateLimitedWarningTargetTracker = ____elite_showcase_utils.EliteCreateLimitedWarningTargetTracker
local CAST_RANGE = 1300
local COOLDOWN = 5
local CAST_POINT = 1.2
local WARNING_TRACK_DURATION = 0.7
local FIRE_DELAY = 0.55
local PROJECTILE_ROUND_INTERVAL = 0.6
local CAST_DURATION = FIRE_DELAY + PROJECTILE_ROUND_INTERVAL + 0.6
local WARNING_RADIUS = 350
local WARNING_FOLLOW_SPEED = 350
local LANDING_DAMAGE_RATE = 18
local LANDING_STUN_DURATION = 0.18
local LANDING_SHAKE_RADIUS = 900
local PROJECTILE_COUNT = 10
local SECOND_ROUND_PROJECTILE_BONUS = 5
local PROJECTILE_DISTANCE = 2600
local PROJECTILE_WIDTH = 95
local PROJECTILE_SPEED = 775 * 0.7
local PROJECTILE_DAMAGE_RATE = 18
local PROJECTILE_START_HEIGHT = 125
local PROJECTILE_HIT_STUN_DURATION = 0.12
local CAST_GESTURE = ACT_DOTA_CAST_ABILITY_3
local FIRE_GESTURE = ACT_DOTA_ATTACK
local FIRE_GESTURE_PLAYBACK_RATE = 1.4
local PROJECTILE_PARTICLE = "particles/boss/boss_001_2.vpcf"
local LANDING_PARTICLE = "particles/stormspirit_overload_discharge.vpcf"
local BLINK_START_PARTICLE =
	"particles/econ/events/seasonal_reward_line_spring_2026/blink_dagger_springrewardline_2026_start.vpcf"
local BLINK_END_PARTICLE =
	"particles/econ/events/seasonal_reward_line_spring_2026/blink_dagger_springrewardline_2026_end.vpcf"
local DARK_SEER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts"
local START_SOUND = "Hero_Dark_Seer.Ion_Shield_Start"
local PROJECTILE_SOUND = "Hero_Dark_Seer.Surge"
local BLINK_SOUND = "DOTA_Item.BlinkDagger.Activate"
____exports.elite_301 = __TS__Class()
local elite_301 = ____exports.elite_301
elite_301.name = "elite_301"
__TS__ClassExtends(elite_301, MonsterAbility_CS)
function elite_301.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_301.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", LANDING_PARTICLE, context)
	PrecacheResource("particle", BLINK_START_PARTICLE, context)
	PrecacheResource("particle", BLINK_END_PARTICLE, context)
	PrecacheResource("soundfile", DARK_SEER_SOUND_EVENTS, context)
end
function elite_301.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = CAST_GESTURE,
		cooldown = COOLDOWN,
		isNotMove = true,
		canCast = function()
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, self:FindTarget()) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnPhaseStart = function()
			return self:StartWarning()
		end,
		OnStart = function()
			return self:StartSequence()
		end,
		OnInterrupt = function()
			return self:StopSequence()
		end,
		OnFinish = function()
			return self:StopSequence()
		end,
	}
end
function elite_301.prototype.StartWarning(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	self.warningTracker = nil
	EmitSoundOn(START_SOUND, caster)
	caster:SetForwardVectorWithoutInterrupt(self:ResolveDirection(caster))
	self:CreateWarning(caster, CAST_POINT)
end
function elite_301.prototype.StartSequence(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local token = self.castToken
	self:BlinkAndFire(caster, token)
end
function elite_301.prototype.StopSequence(self)
	self.castToken = self.castToken + 1
	local caster = self:GetCaster()
	if IsValid(nil, caster) and not caster:IsNull() then
		caster:FadeGesture(CAST_GESTURE)
		caster:FadeGesture(FIRE_GESTURE)
	end
	self.warningTracker = nil
end
function elite_301.prototype.CreateWarning(self, caster, duration)
	local tracker = EliteCreateLimitedWarningTargetTracker(nil, {
		caster = caster,
		initialTarget = self:FindTarget(),
		followDuration = WARNING_TRACK_DURATION,
		followSpeed = WARNING_FOLLOW_SPEED,
		resolveTarget = function()
			return self:FindTarget()
		end,
		resolveTargetPoint = function(____, target)
			return GetGroundPosition(target:GetAbsOrigin(), caster)
		end,
		resolveFallbackPoint = function()
			return GetGroundPosition(caster:GetAbsOrigin(), caster)
		end,
	})
	self.warningTracker = tracker
	self:FacePoint(caster, tracker:getCenter())
	self:WarningRingEffect(tracker:getCenter(), WARNING_RADIUS, duration, {
		getCenter = function()
			local center = tracker:update()
			self:FacePoint(caster, center)
			return center
		end,
	})
end
function elite_301.prototype.BlinkAndFire(self, caster, token)
	local ____opt_1 = self.warningTracker
	local rawPoint = ____opt_1 and ____opt_1:getCenter() or GetGroundPosition(caster:GetAbsOrigin(), caster)
	local point = self:ResolveSafeBlinkPoint(caster, rawPoint)
	local direction = self:ResolveDirection(caster, point)
	if not self:BlinkToPoint(caster, point, direction) then
		return
	end
	if not self:IsActive(caster, token) then
		return
	end
	local landingPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:DoLandingBlast(caster, landingPoint)
	self:PlayFireGesture(caster)
	self:ScheduleProjectileRing(caster, token, direction, FIRE_DELAY, PROJECTILE_COUNT)
	self:Timer(PROJECTILE_ROUND_INTERVAL, function()
		if not self:IsActive(caster, token) then
			return
		end
		self:PlayFireGesture(caster)
	end)
	self:ScheduleProjectileRing(
		caster,
		token,
		direction,
		FIRE_DELAY + PROJECTILE_ROUND_INTERVAL,
		PROJECTILE_COUNT + SECOND_ROUND_PROJECTILE_BONUS
	)
end
function elite_301.prototype.DoLandingBlast(self, caster, point)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayPointParticle(LANDING_PARTICLE, point, caster, Vector(WARNING_RADIUS, 0, 0))
	ScreenShake(point, 9, 12, LANDING_STUN_DURATION, LANDING_SHAKE_RADIUS, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue27
			end
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = LANDING_STUN_DURATION })
			caster:MonsterDamage({ victim = enemy, damage_rate = LANDING_DAMAGE_RATE, ability = self })
		end
		::__continue27::
	end
end
function elite_301.prototype.ScheduleProjectileRing(self, caster, token, baseDirection, delay, projectileCount)
	self:Timer(delay, function()
		if not self:IsActive(caster, token) then
			return
		end
		self:FireProjectileRing(caster, baseDirection, projectileCount)
	end)
end
function elite_301.prototype.FireProjectileRing(self, caster, baseDirection, projectileCount)
	EmitSoundOn(PROJECTILE_SOUND, caster)
	local angleStep = 360 / projectileCount
	ScreenShake(caster:GetAbsOrigin(), 5, 10, PROJECTILE_HIT_STUN_DURATION, 700, 0, true)
	do
		local i = 0
		while i < projectileCount do
			local currentIndex = i
			local direction = self:RotateDirection(baseDirection, currentIndex * angleStep)
			self:FireProjectile(caster, direction)
			i = i + 1
		end
	end
end
function elite_301.prototype.FireProjectile(self, caster, direction)
	if not IsValidAlive(nil, caster) then
		return
	end
	local start = caster:GetAbsOrigin():__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
	local ____end = start:__add(direction:__mul(PROJECTILE_DISTANCE))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if not IsValidAlive(nil, caster) then
				return true
			end
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			caster:MonsterDamage({ victim = hitTarget, damage_rate = PROJECTILE_DAMAGE_RATE, ability = self })
			if not IsValidAlive(nil, caster) or not IsValidAlive(nil, hitTarget) then
				return true
			end
			AddDeBuffStatus(
				nil,
				hitTarget,
				caster,
				self,
				DebuffStatusType.STUN,
				{ duration = PROJECTILE_HIT_STUN_DURATION }
			)
			ScreenShake(hitTarget:GetAbsOrigin(), 5, 10, PROJECTILE_HIT_STUN_DURATION, 700, 0, true)
			return true
		end,
	})
end
function elite_301.prototype.BlinkToPoint(self, caster, point, direction)
	if not IsValidAlive(nil, caster) then
		return false
	end
	local startPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	self:PlayPointParticle(BLINK_START_PARTICLE, startPoint, caster)
	EmitSoundOnLocationWithCaster(startPoint, BLINK_SOUND, caster)
	FindClearSpaceForUnit(caster, point, true)
	if not IsValidAlive(nil, caster) then
		return false
	end
	local actualPoint = GetGroundPosition(caster:GetAbsOrigin(), caster)
	if not self:IsSafeBlinkPoint(startPoint, actualPoint) then
		caster:SetAbsOrigin(startPoint)
		return false
	end
	caster:SetForwardVectorWithoutInterrupt(direction)
	self:PlayPointParticle(BLINK_END_PARTICLE, actualPoint, caster)
	return true
end
function elite_301.prototype.ResolveSafeBlinkPoint(self, caster, point)
	local casterOrigin = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local targetPoint = GetGroundPosition(point, caster)
	if self:IsSafeBlinkPoint(casterOrigin, targetPoint) then
		return targetPoint
	end
	return casterOrigin
end
function elite_301.prototype.IsSafeBlinkPoint(self, casterOrigin, point)
	if not IsGridNavDisplacementWalkable(nil, point) then
		return false
	end
	if not IsGridNavDisplacementWalkable(nil, casterOrigin) then
		return true
	end
	if not GridNav:CanFindPath(casterOrigin, point) then
		return false
	end
	if GridNav:FindPathLength(casterOrigin, point) == -1 then
		return false
	end
	return true
end
function elite_301.prototype.PlayPointParticle(self, effectName, point, caster, cp1)
	local particle = ParticleManager:CreateParticle(effectName, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, point)
	if cp1 then
		ParticleManager:SetParticleControl(particle, 1, cp1)
	end
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_301.prototype.PlayFireGesture(self, caster)
	caster:FadeGesture(FIRE_GESTURE)
	caster:StartGestureWithFadeAndPlaybackRate(FIRE_GESTURE, 0.03, 0.12, FIRE_GESTURE_PLAYBACK_RATE)
end
function elite_301.prototype.ResolveDirection(self, caster, point)
	if point then
		local toPoint = GetDirection(nil, point, caster:GetAbsOrigin())
		if toPoint:Length2D() > 0.01 then
			return toPoint
		end
	end
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		local toTarget = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if toTarget:Length2D() > 0.01 then
			return toTarget
		end
	end
	local forward = caster:GetForwardVector()
	local ____temp_3
	if forward:Length2D() > 0.01 then
		____temp_3 = forward:Normalized()
	else
		____temp_3 = Vector(1, 0, 0)
	end
	return ____temp_3
end
function elite_301.prototype.FacePoint(self, caster, point)
	if not IsValidAlive(nil, caster) or point == nil then
		return
	end
	caster:SetForwardVectorWithoutInterrupt(self:ResolveDirection(caster, point))
end
function elite_301.prototype.RotateDirection(self, direction, angleDegrees)
	local radians = angleDegrees * math.pi / 180
	local cos = math.cos(radians)
	local sin = math.sin(radians)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function elite_301.prototype.IsActive(self, caster, token)
	return token == self.castToken and IsValidAlive(nil, caster)
end
function elite_301.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
elite_301 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_301)
____exports.elite_301 = elite_301
return ____exports