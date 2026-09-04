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
local THROW_ROUNDS = {
	{
		targetRange = 1200,
		fallbackDistance = 760,
		impactRadius = 220,
		damageRate = 25,
		windupDelay = 0.67,
		launchDelay = 0,
		projectileTravelTime = 0.45,
	},
	{
		targetRange = 1200,
		fallbackDistance = 760,
		impactRadius = 260,
		damageRate = 25,
		windupDelay = 0.45,
		launchDelay = 0.9,
		projectileTravelTime = 0.45,
	},
	{
		targetRange = 1200,
		fallbackDistance = 760,
		impactRadius = 280,
		damageRate = 25,
		windupDelay = 0.4,
		launchDelay = 1.49,
		projectileTravelTime = 0.45,
	},
	{
		targetRange = 1200,
		fallbackDistance = 760,
		impactRadius = 300,
		damageRate = 25,
		windupDelay = 0.35,
		launchDelay = 1.95,
		projectileTravelTime = 0.45,
	},
}
local ANIMATION_KEY_POINT = 0.4
local FIRST_ROUND_INDEX = 0
local PROJECTILE_START_FORWARD_OFFSET = 80
local PROJECTILE_START_HEIGHT = 130
local MIN_PROJECTILE_TRAVEL_TIME = 0.03
local POST_FINISH_BUFFER = 0.1
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
local PROJECTILE_PARTICLE = "particles/units/heroes/hero_abaddon/abaddon_death_coil.vpcf"
local IMPACT_PARTICLE = "particles/econ/items/death_prophet/death_prophet_ti9/death_prophet_silence_ti9.vpcf"
____exports.elite_304 = __TS__Class()
local elite_304 = ____exports.elite_304
elite_304.name = "elite_304"
__TS__ClassExtends(elite_304, MonsterAbility_CS)
function elite_304.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.preparedPoints = {}
end
function elite_304.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
end
function elite_304.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = self:GetMaxTargetRange(),
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = self:GetFirstRoundCastPoint(),
		castDuration = self:GetPostStartDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = self:GetRoundAnimationPlaybackRate(FIRST_ROUND_INDEX),
		cooldown = 5,
		OnPhaseStart = function()
			return self:PrepareRound(FIRST_ROUND_INDEX)
		end,
		OnStart = function()
			return self:StartBarrage()
		end,
		OnInterrupt = function()
			return self:ClearPreparedPoints()
		end,
		OnFinish = function()
			return self:ClearPreparedPoints()
		end,
	}
end
function elite_304.prototype.PrepareRound(self, index)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self:ClearPreparedPoints()
		return
	end
	local target = caster:GetMinDistanceUnit(self:GetRoundTargetRange(index))
	local targetPoint = self:ResolveTargetPoint(caster, target, index)
	local windupDuration = self:GetRoundWindupDelay(index)
	self.preparedPoints[index + 1] = targetPoint
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, windupDuration, 8)
	end
	local direction = GetDirection(nil, targetPoint, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
	self:WarningRingEffect(
		targetPoint,
		self:GetRoundImpactRadius(index),
		windupDuration + self:GetRoundProjectileTravelTime(index)
	)
end
function elite_304.prototype.StartBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:FirePreparedRound(caster, FIRST_ROUND_INDEX)
	do
		local index = 1
		while index < #THROW_ROUNDS do
			local currentIndex = index
			local currentPlaybackRate = self:GetRoundAnimationPlaybackRate(currentIndex)
			local currentActionStartDelay = self:GetRoundActionStartDelayFromSpellStart(currentIndex)
			local currentLaunchDelay = self:GetRoundLaunchDelayFromSpellStart(currentIndex)
			self:Timer(currentActionStartDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:PrepareRound(currentIndex)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, currentPlaybackRate)
			end)
			self:Timer(currentLaunchDelay, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:FirePreparedRound(caster, currentIndex)
			end)
			index = index + 1
		end
	end
end
function elite_304.prototype.FirePreparedRound(self, caster, index)
	local targetPoint = self.preparedPoints[index + 1]
		or self:ResolveTargetPoint(caster, caster:GetMinDistanceUnit(self:GetRoundTargetRange(index)), index)
	local startPoint = self:GetProjectileStartPoint(caster)
	local distance = math.max(1, GetDistance(nil, startPoint, targetPoint))
	local projectileSpeed = distance / math.max(self:GetRoundProjectileTravelTime(index), MIN_PROJECTILE_TRAVEL_TIME)
	local radius = self:GetRoundImpactRadius(index)
	local damageRate = self:GetRoundDamageRate(index)
	caster:SetForwardVectorWithoutInterrupt(GetDirection(nil, targetPoint, caster:GetAbsOrigin()))
	EmitSoundOn("Hero_Abaddon.DeathCoil.Cast", caster)
	self:PlayScreenShake(caster:GetAbsOrigin())
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "collideground",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = projectileSpeed,
		on_hit = function(____, _hitTarget, location)
			if not IsValidAlive(nil, caster) then
				return true
			end
			local impactPoint = GetGroundPosition(location, caster)
			self:ImpactAt(caster, impactPoint, radius, damageRate)
			return true
		end,
	})
end
function elite_304.prototype.ImpactAt(self, caster, impactPoint, radius, damageRate)
	if not IsValidAlive(nil, caster) then
		return
	end
	self:PlayImpactEffect(caster, impactPoint, radius)
	self:PlayScreenShake(impactPoint)
	EmitSoundOnLocationWithCaster(impactPoint, "Hero_Abaddon.DeathCoil.Target", caster)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPoint,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue24
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
		end
		::__continue24::
	end
end
function elite_304.prototype.PlayImpactEffect(self, caster, impactPoint, radius)
	local particle = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, impactPoint)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_304.prototype.PlayScreenShake(self, point)
	ScreenShake(
		point,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
function elite_304.prototype.ResolveTargetPoint(self, caster, target, index)
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), caster)
	end
	local rawPoint = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(self:GetRoundFallbackDistance(index)))
	return GetGroundPosition(rawPoint, caster)
end
function elite_304.prototype.GetProjectileStartPoint(self, caster)
	local attach = caster:ScriptLookupAttachment("attach_attack1")
	local ____temp_0
	if attach > 0 then
		____temp_0 = caster:GetAttachmentOrigin(attach)
	else
		____temp_0 = caster:GetAbsOrigin()
	end
	local basePoint = ____temp_0
	return basePoint
		:__add(caster:GetForwardVector():__mul(PROJECTILE_START_FORWARD_OFFSET))
		:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
end
function elite_304.prototype.GetRoundActionStartDelayFromSpellStart(self, index)
	return math.max(self:GetRoundLaunchDelayFromSpellStart(index) - self:GetRoundWindupDelay(index), 0)
end
function elite_304.prototype.GetRoundLaunchDelayFromSpellStart(self, index)
	return self:GetRoundConfig(index).launchDelay
end
function elite_304.prototype.GetRoundWindupDelay(self, index)
	return self:GetRoundConfig(index).windupDelay
end
function elite_304.prototype.GetRoundAnimationPlaybackRate(self, index)
	return ANIMATION_KEY_POINT / math.max(self:GetRoundWindupDelay(index), 0.01)
end
function elite_304.prototype.GetFirstRoundCastPoint(self)
	return self:GetRoundWindupDelay(FIRST_ROUND_INDEX)
end
function elite_304.prototype.GetPostStartDuration(self)
	local duration = 0
	do
		local index = 0
		while index < #THROW_ROUNDS do
			duration = math.max(
				duration,
				self:GetRoundLaunchDelayFromSpellStart(index) + self:GetRoundProjectileTravelTime(index)
			)
			index = index + 1
		end
	end
	return duration + POST_FINISH_BUFFER
end
function elite_304.prototype.GetMaxTargetRange(self)
	local range = 0
	for ____, round in ipairs(THROW_ROUNDS) do
		range = math.max(range, round.targetRange)
	end
	return range
end
function elite_304.prototype.GetRoundTargetRange(self, index)
	return self:GetRoundConfig(index).targetRange
end
function elite_304.prototype.GetRoundFallbackDistance(self, index)
	return self:GetRoundConfig(index).fallbackDistance
end
function elite_304.prototype.GetRoundImpactRadius(self, index)
	return self:GetRoundConfig(index).impactRadius
end
function elite_304.prototype.GetRoundDamageRate(self, index)
	return self:GetRoundConfig(index).damageRate
end
function elite_304.prototype.GetRoundProjectileTravelTime(self, index)
	return self:GetRoundConfig(index).projectileTravelTime
end
function elite_304.prototype.GetRoundConfig(self, index)
	return THROW_ROUNDS[index + 1] or THROW_ROUNDS[FIRST_ROUND_INDEX + 1]
end
function elite_304.prototype.ClearPreparedPoints(self)
	self.preparedPoints = {}
end
elite_304 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_304)
____exports.elite_304 = elite_304
return ____exports