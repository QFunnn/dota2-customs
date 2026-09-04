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
local modifier_elite_308_ground_leash
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_RANGE = 1100
local THROW_ACTION_DURATION = 0.83
local THROW_KEY_POINT = 0.37
local PROJECTILE_TRAVEL_TIME = 0.5
local DAGGER_COUNT = 3
local THROW_COUNT = 4
local FIRST_THROW_INDEX = 0
local THROW_PLAYBACK_RATES = { 1, 1, 2, 2 }
local RANDOM_DAGGER_RADIUS = 500
local IMPACT_RADIUS = 260
local LEASH_DURATION = 15
local LEASH_SOFT_RADIUS = 260
local LEASH_MAX_RADIUS = 420
local LEASH_MIN_SLOW_PCT = 50
local LEASH_MAX_SLOW_PCT = 95
local DAMAGE_RATE = 8
local SCREEN_SHAKE_AMPLITUDE = 12
local SCREEN_SHAKE_FREQUENCY = 12
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 1800
local PROJECTILE_PARTICLE = "particles/units/heroes/hero_bounty_hunter/bounty_hunter_suriken_toss.vpcf"
local IMPACT_PARTICLE = "particles/cc/assass_hit_corea_2.vpcf"
local LEASH_PARTICLE = "particles/units/heroes/hero_slark/slark_pounce_leash.vpcf"
local LANDING_BIND_PARTICLE = "particles/monster/elite_156.vpcf"
--- 仅供束缚飞镖使用的锚点/拉回落点校验。
local function ResolveSafeLeashPoint(self, unit, origin, intendedPoint)
	local startPoint = GetGroundPosition(origin, unit)
	local targetPoint = GetGroundPosition(intendedPoint, unit)
	if not IsGridNavDisplacementWalkable(nil, startPoint) or not IsGridNavDisplacementWalkable(nil, targetPoint) then
		return nil
	end
	if not GridNav:CanFindPath(startPoint, targetPoint) then
		return nil
	end
	local ____temp_0
	if GridNav:FindPathLength(startPoint, targetPoint) ~= -1 then
		____temp_0 = targetPoint
	else
		____temp_0 = nil
	end
	return ____temp_0
end
____exports.elite_308 = __TS__Class()
local elite_308 = ____exports.elite_308
elite_308.name = "elite_308"
__TS__ClassExtends(elite_308, MonsterAbility_CS)
function elite_308.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.preparedPointGroups = {}
end
function elite_308.prototype.Precache(self, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
	PrecacheResource("particle", LEASH_PARTICLE, context)
	PrecacheResource("particle", LANDING_BIND_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
end
function elite_308.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = self:GetFirstThrowCastPoint(),
		castDuration = self:GetPostStartDuration(),
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = THROW_PLAYBACK_RATES[FIRST_THROW_INDEX + 1],
		cooldown = 12,
		OnPhaseStart = function()
			return self:PrepareThrow(FIRST_THROW_INDEX)
		end,
		OnStart = function()
			return self:StartThrowSequence()
		end,
		OnInterrupt = function()
			return self:ClearPreparedPoints()
		end,
		OnFinish = function()
			return self:ClearPreparedPoints()
		end,
	}
end
function elite_308.prototype.PrepareThrow(self, index)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		self.preparedPointGroups[index + 1] = nil
		return
	end
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	local targetPoint = self:ResolveTargetPoint(caster, target)
	local windupDuration = self:GetThrowKeyPointDelay(index)
	local targetPoints = self:ResolveVolleyTargetPoints(caster, targetPoint)
	self.preparedPointGroups[index + 1] = targetPoints
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, windupDuration, 8)
	end
	local direction = GetDirection(nil, targetPoint, caster:GetAbsOrigin())
	if direction:Length2D() > 0.01 then
		caster:SetForwardVectorWithoutInterrupt(direction)
	end
	do
		local pointIndex = 0
		while pointIndex < #targetPoints do
			local currentPoint = targetPoints[pointIndex + 1]
			self:WarningRingEffect(currentPoint, IMPACT_RADIUS, windupDuration + PROJECTILE_TRAVEL_TIME)
			pointIndex = pointIndex + 1
		end
	end
end
function elite_308.prototype.StartThrowSequence(self)
	self:ThrowGroundLeash(FIRST_THROW_INDEX)
	do
		local index = 1
		while index < THROW_COUNT do
			local currentIndex = index
			local currentPlaybackRate = THROW_PLAYBACK_RATES[currentIndex + 1]
			local currentActionStartDelay = self:GetThrowActionStartDelayFromSpellStart(currentIndex)
			local currentLaunchDelay = self:GetThrowLaunchDelayFromSpellStart(currentIndex)
			self:Timer(currentActionStartDelay, function()
				local caster = self:GetCaster()
				if not IsValidAlive(nil, caster) then
					return
				end
				self:PrepareThrow(currentIndex)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, currentPlaybackRate)
			end)
			self:Timer(currentLaunchDelay, function()
				self:ThrowGroundLeash(currentIndex)
			end)
			index = index + 1
		end
	end
end
function elite_308.prototype.ThrowGroundLeash(self, index)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local ____temp_1
	if self.preparedPointGroups[index + 1] and #self.preparedPointGroups[index + 1] > 0 then
		____temp_1 = self.preparedPointGroups[index + 1]
	else
		____temp_1 = self:ResolveVolleyTargetPoints(
			caster,
			self:ResolveTargetPoint(caster, caster:GetMinDistanceUnit(CAST_RANGE))
		)
	end
	local targetPoints = ____temp_1
	local primaryPoint = targetPoints[1] or self:ResolveTargetPoint(caster, caster:GetMinDistanceUnit(CAST_RANGE))
	local startPoint = caster:GetAbsOrigin():__add(Vector(0, 0, 160))
	caster:SetForwardVectorWithoutInterrupt(GetDirection(nil, primaryPoint, caster:GetAbsOrigin()))
	EmitSoundOn("Hero_BountyHunter.Shuriken", caster)
	self:PlayScreenShake(caster:GetAbsOrigin())
	do
		local index = 0
		while index < #targetPoints do
			local currentTargetPoint = targetPoints[index + 1]
			self:ThrowGroundLeashProjectile(caster, startPoint, currentTargetPoint)
			index = index + 1
		end
	end
end
function elite_308.prototype.ThrowGroundLeashProjectile(self, caster, startPoint, targetPoint)
	local projectileSpeed = math.max(1, GetDistance(nil, startPoint, targetPoint) / PROJECTILE_TRAVEL_TIME)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "collideground",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = projectileSpeed,
		on_hit = function(____, _hitTarget, location)
			self:ImpactAt(caster, location)
			return true
		end,
	})
end
function elite_308.prototype.ResolveVolleyTargetPoints(self, caster, primaryPoint)
	local origin = caster:GetAbsOrigin()
	local safePrimaryPoint = ResolveSafeLeashPoint(nil, caster, origin, primaryPoint)
		or GetGroundPosition(origin, caster)
	local points = { safePrimaryPoint }
	do
		local index = 1
		while index < DAGGER_COUNT do
			local offset = RandomVector(RandomFloat(0, RANDOM_DAGGER_RADIUS))
			local randomPoint = GetGroundPosition(primaryPoint:__add(offset), caster)
			local safeRandomPoint = ResolveSafeLeashPoint(nil, caster, origin, randomPoint)
			if safeRandomPoint then
				points[#points + 1] = safeRandomPoint
			end
			index = index + 1
		end
	end
	return points
end
function elite_308.prototype.ImpactAt(self, caster, rawLocation)
	if not IsValidAlive(nil, caster) then
		return
	end
	local impactPoint = ResolveSafeLeashPoint(nil, caster, caster:GetAbsOrigin(), rawLocation)
	if not impactPoint then
		return
	end
	self:PlayImpactEffect(caster, impactPoint)
	self:PlayScreenShake(impactPoint)
	EmitSoundOnLocationWithCaster(impactPoint, "Hero_BountyHunter.Shuriken.Impact", caster)
	self:ApplyLeashDamageAt(caster, impactPoint)
end
function elite_308.prototype.ApplyLeashDamageAt(self, caster, impactPoint)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPoint,
		nil,
		IMPACT_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue34
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			modifier_elite_308_ground_leash:applys(
				enemy,
				caster,
				self,
				{
					duration = LEASH_DURATION,
					anchor_x = impactPoint.x,
					anchor_y = impactPoint.y,
					anchor_z = impactPoint.z,
				}
			)
		end
		::__continue34::
	end
end
function elite_308.prototype.PlayImpactEffect(self, caster, impactPoint)
	local particle = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, impactPoint)
	ParticleManager:SetParticleControl(particle, 1, Vector(IMPACT_RADIUS, IMPACT_RADIUS, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_308.prototype.PlayScreenShake(self, point)
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
function elite_308.prototype.ResolveTargetPoint(self, caster, target)
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), caster)
	end
	local rawPoint = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(math.min(CAST_RANGE, 650)))
	return GetGroundPosition(rawPoint, caster)
end
function elite_308.prototype.GetThrowActionStartDelayFromSpellStart(self, index)
	return math.max(self:GetThrowActionStartDelayFromPhaseStart(index) - self:GetFirstThrowCastPoint(), 0)
end
function elite_308.prototype.GetThrowLaunchDelayFromSpellStart(self, index)
	return self:GetThrowActionStartDelayFromSpellStart(index) + self:GetThrowKeyPointDelay(index)
end
function elite_308.prototype.GetThrowActionStartDelayFromPhaseStart(self, index)
	local delay = 0
	do
		local round = 0
		while round < index do
			delay = delay + self:GetThrowActionDuration(round)
			round = round + 1
		end
	end
	return delay
end
function elite_308.prototype.GetThrowKeyPointDelay(self, index)
	return THROW_KEY_POINT / THROW_PLAYBACK_RATES[index + 1]
end
function elite_308.prototype.GetThrowActionDuration(self, index)
	return THROW_ACTION_DURATION / THROW_PLAYBACK_RATES[index + 1]
end
function elite_308.prototype.GetFirstThrowCastPoint(self)
	return self:GetThrowKeyPointDelay(FIRST_THROW_INDEX)
end
function elite_308.prototype.GetPostStartDuration(self)
	local lastThrowIndex = THROW_COUNT - 1
	return self:GetThrowLaunchDelayFromSpellStart(lastThrowIndex) + PROJECTILE_TRAVEL_TIME + 0.2
end
function elite_308.prototype.ClearPreparedPoints(self)
	self.preparedPointGroups = {}
end
elite_308 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_308)
____exports.elite_308 = elite_308
modifier_elite_308_ground_leash = __TS__Class()
modifier_elite_308_ground_leash.name = "modifier_elite_308_ground_leash"
__TS__ClassExtends(modifier_elite_308_ground_leash, MonsterModifier_CS)
function modifier_elite_308_ground_leash.prototype.____constructor(self, ...)
	MonsterModifier_CS.prototype.____constructor(self, ...)
	self.anchorPoint = Vector(0, 0, 0)
	self.currentSlowPct = 0
end
function modifier_elite_308_ground_leash.prototype.OnCreated(self, params)
	if not IsServer() then
		return
	end
	self.anchorPoint =
		Vector(params and params.anchor_x or 0, params and params.anchor_y or 0, params and params.anchor_z or 0)
	self.currentSlowPct = LEASH_MIN_SLOW_PCT
	self:StartLeashEffect()
	self:StartIntervalThink(FrameTime())
end
function modifier_elite_308_ground_leash.prototype.OnRefresh(self, params)
	if not IsServer() then
		return
	end
	self.anchorPoint = Vector(
		params and params.anchor_x or self.anchorPoint.x,
		params and params.anchor_y or self.anchorPoint.y,
		params and params.anchor_z or self.anchorPoint.z
	)
	self.currentSlowPct = LEASH_MIN_SLOW_PCT
	self:StartLeashEffect()
end
function modifier_elite_308_ground_leash.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local caster = self:GetCaster()
	if not IsValidAlive(nil, parent) or not IsValidAlive(nil, caster) then
		self:Destroy()
		return
	end
	local parentPos = parent:GetAbsOrigin()
	local distance = GetDistance(nil, parentPos, self.anchorPoint)
	local distancePct =
		math.min(math.max((distance - LEASH_SOFT_RADIUS) / math.max(1, LEASH_MAX_RADIUS - LEASH_SOFT_RADIUS), 0), 1)
	self.currentSlowPct = LEASH_MIN_SLOW_PCT + (LEASH_MAX_SLOW_PCT - LEASH_MIN_SLOW_PCT) * distancePct
	self:RefreshAttributes()
	if distance > LEASH_MAX_RADIUS then
		local direction = GetDirection(nil, parentPos, self.anchorPoint)
		local clampPoint = self.anchorPoint:__add(direction:__mul(LEASH_MAX_RADIUS))
		local groundPoint = GetGroundPosition(clampPoint, parent)
		local safeClampPoint = ResolveSafeLeashPoint(nil, parent, parentPos, groundPoint)
		if safeClampPoint then
			parent:SetAbsOrigin(safeClampPoint)
		end
	end
end
function modifier_elite_308_ground_leash.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	self:StopLeashEffect()
	self:StopLandingBindEffect()
end
function modifier_elite_308_ground_leash.prototype.GetAttributeBonus(self)
	return { bonus_movespeed_pct = -self.currentSlowPct }
end
function modifier_elite_308_ground_leash.prototype.IsHidden(self)
	return false
end
function modifier_elite_308_ground_leash.prototype.IsDebuff(self)
	return true
end
function modifier_elite_308_ground_leash.prototype.IsPurgable(self)
	return true
end
function modifier_elite_308_ground_leash.prototype.GetTexture(self)
	return "slark_pounce"
end
function modifier_elite_308_ground_leash.GetLocalizationCN(self)
	return {
		name = "猎网束缚",
		description = "被束缚在飞镖落点附近，远离锚点时移动速度逐渐降低，超过范围后无法继续远离。",
	}
end
function modifier_elite_308_ground_leash.prototype.StartLeashEffect(self)
	local parent = self:GetParent()
	self:StopLeashEffect()
	self:StopLandingBindEffect()
	self.leashParticle = ParticleManager:CreateParticle(LEASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		self.leashParticle,
		1,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.leashParticle,
		2,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(self.leashParticle, 3, self.anchorPoint:__add(Vector(0, 0, 50)))
	self:StartLandingBindEffect(self.anchorPoint)
end
function modifier_elite_308_ground_leash.prototype.StopLeashEffect(self)
	if self.leashParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.leashParticle, false)
	ParticleManager:ReleaseParticleIndex(self.leashParticle)
	self.leashParticle = nil
end
function modifier_elite_308_ground_leash.prototype.StartLandingBindEffect(self, pos)
	self.landingBindParticle = ParticleManager:CreateParticle(LANDING_BIND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.landingBindParticle, 3, pos)
	ParticleManager:SetParticleControl(self.landingBindParticle, 4, Vector(LEASH_MAX_RADIUS, 0, 0))
end
function modifier_elite_308_ground_leash.prototype.StopLandingBindEffect(self)
	if self.landingBindParticle == nil then
		return
	end
	ParticleManager:DestroyParticle(self.landingBindParticle, false)
	ParticleManager:ReleaseParticleIndex(self.landingBindParticle)
	self.landingBindParticle = nil
end
modifier_elite_308_ground_leash =
	__TS__DecorateLegacy({ registerModifier(nil, "modifier_elite_308_ground_leash") }, modifier_elite_308_ground_leash)
return ____exports