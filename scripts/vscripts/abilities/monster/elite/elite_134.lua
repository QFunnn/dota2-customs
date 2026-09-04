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
local LAND_EFFECT = "particles/viper_nethertoxin.vpcf"
local SPLASH_PROJECTILE_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_noxious_plague_projectile.vpcf"
local BUFF_EFFECT = "particles/units/heroes/hero_venomancer/venomancer_noxious_contagion_buff.vpcf"
local VENOMANCER_SOUND_EVENTS = "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts"
local CAST_SOUND = "Hero_Venomancer.PoisonNova"
local LAND_SOUND = "Hero_Venomancer.Plague_Ward"
local SPLASH_SOUND = "Hero_Venomancer.NoxiousPlague.Target"
local CAST_RANGE = 1200
local CAST_POINT = 0.2
local LEAP_ANIMATION = "forcestaff_anim"
local LAND_ANIMATION = "forcestaff_end_anim"
local LEAP_DISTANCE = 500
local LEAP_DURATION = 0.5
local LEAP_HEIGHT = 420
local DAMAGE_RADIUS = 400
local DAMAGE_RATE = 25
local SPLASH_DAMAGE_RATE = 12
local SPLASH_COUNT = 6
local SPLASH_ANGLE_STEP = 60
local SPLASH_ANGLE_OFFSET = 18
local SPLASH_START_MIN_DISTANCE = 80
local SPLASH_START_MAX_DISTANCE = DAMAGE_RADIUS
local SPLASH_PROJECTILE_MIN_DISTANCE = 360
local SPLASH_PROJECTILE_MAX_DISTANCE = 540
local SPLASH_PROJECTILE_SPEED = 900
local SPLASH_PROJECTILE_DURATION = SPLASH_PROJECTILE_MAX_DISTANCE / SPLASH_PROJECTILE_SPEED
local SPLASH_LAND_RADIUS = 200
local SPLASH_PROJECTILE_START_HEIGHT = 72
local LAND_EFFECT_DURATION = 2
local CAST_DURATION = LEAP_DURATION + SPLASH_PROJECTILE_DURATION
local MAIN_POISON_STACK = 5
local SPLASH_POISON_STACK = 3
local HIT_KNOCKBACK_DISTANCE = 0
local HIT_KNOCKBACK_DURATION = 0.18
local HIT_KNOCKBACK_HEIGHT = 0
____exports.elite_134 = __TS__Class()
local elite_134 = ____exports.elite_134
elite_134.name = "elite_134"
__TS__ClassExtends(elite_134, MonsterAbility_CS)
function elite_134.prototype.Precache(self, context)
	PrecacheResource("particle", LAND_EFFECT, context)
	PrecacheResource("particle", SPLASH_PROJECTILE_EFFECT, context)
	PrecacheResource("particle", BUFF_EFFECT, context)
	PrecacheResource("soundfile", VENOMANCER_SOUND_EVENTS, context)
end
function elite_134.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local target = self:FindTarget()
			if not IsValidAlive(nil, caster) then
				self.landPos = nil
				return
			end
			self.landPos = self:GetLandPosition(caster, target)
			self:StartBuffEffect(caster)
			EmitSoundOn(CAST_SOUND, caster)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self:WarningRingEffect(self.landPos, DAMAGE_RADIUS, CAST_POINT + LEAP_DURATION)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local landPos = self.landPos
			self.landPos = nil
			if not IsValidAlive(nil, caster) or not landPos then
				return
			end
			ScreenShake(caster:GetAbsOrigin(), 8, 8, 0.3, 3000, 0, true)
			caster:SetAnimation(LEAP_ANIMATION)
			local leapStart = caster:GetAbsOrigin()
			local leapForward = GetDirection(nil, landPos, leapStart)
			local leapPeak = leapStart:__add(landPos:__sub(leapStart):__mul(0.5)):__add(Vector(0, 0, LEAP_HEIGHT))
			caster:SetForwardVector(leapForward)
			caster:Bezier2Mover({ leapStart, leapPeak, landPos }, LEAP_DURATION, nil, true, true)
			self:Timer(LEAP_DURATION + 0.05, function()
				self:LandAt(landPos)
			end)
		end,
		OnInterrupt = function()
			self.landPos = nil
			self:StopBuffEffect()
		end,
		OnFinish = function()
			self.landPos = nil
			self:StopBuffEffect()
		end,
	}
end
function elite_134.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_134.prototype.GetLandPosition(self, caster, target)
	if IsValidAlive(nil, target) then
		return GetGroundPosition(target:GetAbsOrigin(), target)
	end
	local fallbackPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(LEAP_DISTANCE))
	return GetGroundPosition(fallbackPos, caster)
end
function elite_134.prototype.LandAt(self, landPos)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	FindClearSpaceForUnit(caster, landPos, false)
	caster:SetAnimation(LAND_ANIMATION)
	local impactPos = GetGroundPosition(landPos, caster)
	ScreenShake(impactPos, 15, 15, 0.5, 3000, 0, true)
	EmitSoundOnLocationWithCaster(impactPos, LAND_SOUND, caster)
	caster:StartGesture(ACT_DOTA_SPAWN)
	local pfx = ParticleManager:CreateParticle(LAND_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, impactPos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(DAMAGE_RADIUS, 1, DAMAGE_RADIUS * 3))
	self:ReleaseParticleAfter(pfx, LAND_EFFECT_DURATION)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		impactPos,
		nil,
		DAMAGE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue18
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(
				nil,
				enemy,
				caster,
				self,
				DebuffStatusType.POISON,
				{ stack = MAIN_POISON_STACK, duration = 5 }
			)
			self:ApplyHitKnockback(caster, enemy, impactPos)
		end
		::__continue18::
	end
	self:Timer(0.15, function()
		self:LaunchSplashProjectiles(caster, impactPos)
	end)
end
function elite_134.prototype.LaunchSplashProjectiles(self, caster, center)
	local baseAngle = RandomFloat(0, 360)
	do
		local index = 0
		while index < SPLASH_COUNT do
			local currentIndex = index
			local currentAngle = baseAngle
				+ SPLASH_ANGLE_STEP * currentIndex
				+ RandomFloat(-SPLASH_ANGLE_OFFSET, SPLASH_ANGLE_OFFSET)
			local currentStartDistance = RandomFloat(SPLASH_START_MIN_DISTANCE, SPLASH_START_MAX_DISTANCE)
			local currentProjectileDistance =
				RandomFloat(SPLASH_PROJECTILE_MIN_DISTANCE, SPLASH_PROJECTILE_MAX_DISTANCE)
			local currentProjectileDuration = currentProjectileDistance / SPLASH_PROJECTILE_SPEED
			local currentDirection = self:GetDirectionByAngle(currentAngle)
			local currentStartPos =
				self:GetGroundPoint(center:__add(currentDirection:__mul(currentStartDistance)), caster)
			local currentTargetPos =
				self:GetGroundPoint(currentStartPos:__add(currentDirection:__mul(currentProjectileDistance)), caster)
			self:LaunchSplashProjectile(caster, currentStartPos, currentTargetPos, currentProjectileDuration)
			index = index + 1
		end
	end
end
function elite_134.prototype.LaunchSplashProjectile(self, caster, startPos, targetPos, projectileDuration)
	EmitSoundOnLocationWithCaster(startPos, SPLASH_SOUND, caster)
	self:WarningRingEffect(targetPos, SPLASH_LAND_RADIUS, projectileDuration)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = SPLASH_PROJECTILE_EFFECT,
		projectile_type = "collideground",
		projectile_speed = SPLASH_PROJECTILE_SPEED,
		start_point = startPos:__add(Vector(0, 0, SPLASH_PROJECTILE_START_HEIGHT)),
		target = targetPos,
		on_hit = function(____, _hitTarget, location)
			if not IsServer() or not IsValidAlive(nil, caster) then
				return true
			end
			local impactPos = self:GetGroundPoint(location, caster)
			EmitSoundOnLocationWithCaster(impactPos, LAND_SOUND, caster)
			self:PlayLandEffect(impactPos, SPLASH_LAND_RADIUS)
			self:ApplySplashPoison(caster, impactPos)
			return true
		end,
	})
end
function elite_134.prototype.ApplySplashPoison(self, caster, origin)
	if not IsValidAlive(nil, caster) then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		SPLASH_LAND_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue29
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = SPLASH_DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.POISON, { stack = SPLASH_POISON_STACK })
			self:ApplyHitKnockback(caster, enemy, origin)
		end
		::__continue29::
	end
end
function elite_134.prototype.ApplyHitKnockback(self, caster, enemy, origin)
	if not IsValidAlive(nil, enemy) then
		return
	end
	local offset = enemy:GetAbsOrigin():__sub(origin)
	local direction = Vector(offset.x, offset.y, 0)
	if direction:Length2D() <= 0.1 then
		local fallback = caster:GetForwardVector()
		direction = Vector(fallback.x, fallback.y, 0)
	end
	if direction:Length2D() <= 0.1 then
		return
	end
	enemy:KnockBack(caster, self, {
		direction = direction:Normalized(),
		distance = HIT_KNOCKBACK_DISTANCE,
		duration = HIT_KNOCKBACK_DURATION,
		height = HIT_KNOCKBACK_HEIGHT,
		stunDuration = 0.5,
		stun = true,
		block = false,
	})
end
function elite_134.prototype.PlayLandEffect(self, impactPos, radius)
	local pfx = ParticleManager:CreateParticle(LAND_EFFECT, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, impactPos)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 1, radius * 3))
	self:ReleaseParticleAfter(pfx, LAND_EFFECT_DURATION)
end
function elite_134.prototype.ReleaseParticleAfter(self, pfx, duration)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
		return nil
	end)
end
function elite_134.prototype.GetDirectionByAngle(self, angle)
	local radians = angle * math.pi / 180
	return Vector(math.cos(radians), math.sin(radians), 0)
end
function elite_134.prototype.GetGroundPoint(self, pos, context)
	local groundZ = GetGroundHeight(pos, context) or pos.z
	return Vector(pos.x, pos.y, groundZ)
end
function elite_134.prototype.StartBuffEffect(self, caster)
	self:StopBuffEffect()
	self.buffPfx = ParticleManager:CreateParticle(BUFF_EFFECT, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		self.buffPfx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
end
function elite_134.prototype.StopBuffEffect(self)
	if self.buffPfx == nil then
		return
	end
	ParticleManager:DestroyParticle(self.buffPfx, false)
	ParticleManager:ReleaseParticleIndex(self.buffPfx)
	self.buffPfx = nil
end
elite_134 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_134)
____exports.elite_134 = elite_134
return ____exports