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
local Map = ____lualib.Map
local __TS__New = ____lualib.__TS__New
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local modifier_boss_pangolier_4_performance
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local MonsterModifier_CS = ____monster_base.MonsterModifier_CS
local CAST_POINT = 0.9
local PERFORMANCE_DURATION = 5
local SPAWN_LOADOUT_ANIMATION = "spawn_loadout"
local INITIAL_LAND_TIME = 0.54
local INITIAL_LEAP_HEIGHT = 260
local INITIAL_LAND_SEARCH_RANGE = 1600
local LAND_WARNING_RADIUS = 340
local LAND_DAMAGE_RATE = 25
local SPIN_START_TIME = 3.14
local SPIN_LAND_TIME = 4
local SPIN_AIR_HEIGHT = 220
local PROJECTILE_WARNING_TIME = 0.45
local PROJECTILE_WAVE_COUNT = 2
local PROJECTILE_WAVE_INTERVAL = PROJECTILE_WARNING_TIME
local PROJECTILE_COUNT_PER_WAVE = 12
local PROJECTILE_DISTANCE = 1450
local PROJECTILE_SPEED = 1250
local PROJECTILE_RADIUS = 75
local PROJECTILE_DAMAGE_RATE = 12
local PROJECTILE_START_HEIGHT = 165
local LAND_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local LAND_DUST_PARTICLE = "particles/units/heroes/hero_dawnbreaker/dawnbreaker_elated_fury_landing_dust.vpcf"
local PROJECTILE_PARTICLE = "particles/bb/es_magnataur_shockanvil.vpcf"
local CAST_SOUND = "Hero_Pangolier.Swashbuckle.Cast"
local LAND_SOUND = "Hero_Centaur.HoofStomp"
local PROJECTILE_SOUND = "Hero_Magnataur.ShockWave.Particle"
local PROJECTILE_HIT_SOUND = "Hero_Pangolier.Swashbuckle.Damage"
local function getGroundPosition(self, pos, context)
	return GetGroundPosition(pos, context)
end
local function getFlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local length = flat:Length2D()
	if length <= 0.001 then
		return Vector(1, 0, 0)
	end
	return flat:__mul(1 / length)
end
--- 谢幕回旋：跃起落地后鞠躬演出，在旋转段向四周释放剑气。
____exports.boss_pangolier_4 = __TS__Class()
local boss_pangolier_4 = ____exports.boss_pangolier_4
boss_pangolier_4.name = "boss_pangolier_4"
__TS__ClassExtends(boss_pangolier_4, MonsterAbility_CS)
function boss_pangolier_4.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.sequenceToken = 0
end
function boss_pangolier_4.prototype.Precache(self, context)
	PrecacheResource("particle", LAND_PARTICLE, context)
	PrecacheResource("particle", LAND_DUST_PARTICLE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pangolier.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
end
function boss_pangolier_4.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		castPoint = CAST_POINT,
		castDuration = PERFORMANCE_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		cooldown = 10,
		OnPhaseStart = function()
			return self:PreparePerformance()
		end,
		OnStart = function()
			return self:StartPerformance()
		end,
		OnInterrupt = function()
			return self:StopPerformance()
		end,
		OnFinish = function()
			return self:StopPerformance()
		end,
	}
end
function boss_pangolier_4.prototype.PreparePerformance(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.sequenceToken = self.sequenceToken + 1
	local token = self.sequenceToken
	local target = caster:GetMinDistanceUnit(1600)
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 10)
	end
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.85)
	self:Timer(CAST_POINT * 0.45, function()
		if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
			return
		end
		caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1.05)
	end)
end
function boss_pangolier_4.prototype.StartPerformance(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local token = self.sequenceToken
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
	caster:SetAnimation(SPAWN_LOADOUT_ANIMATION)
	modifier_boss_pangolier_4_performance:applys(caster, caster, self, { duration = PERFORMANCE_DURATION })
	EmitSoundOn(CAST_SOUND, caster)
	local landingPosition = self:GetInitialLandingPosition(caster)
	self:ShowLandingWarning(landingPosition, INITIAL_LAND_TIME)
	self:StartInitialLeap(caster, landingPosition)
	self:Timer(INITIAL_LAND_TIME, function()
		if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
			return
		end
		self:LandImpact(caster, landingPosition, true, true)
	end)
	do
		local waveIndex = 0
		while waveIndex < PROJECTILE_WAVE_COUNT do
			local currentWaveIndex = waveIndex
			local fireDelay = SPIN_START_TIME + currentWaveIndex * PROJECTILE_WAVE_INTERVAL
			local warningDelay = SPIN_START_TIME - (PROJECTILE_WAVE_COUNT - currentWaveIndex) * PROJECTILE_WARNING_TIME
			self:Timer(warningDelay, function()
				if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
					return
				end
				self:ShowProjectileWarnings(caster, currentWaveIndex, PROJECTILE_WARNING_TIME)
			end)
			self:Timer(fireDelay, function()
				if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
					return
				end
				self:FireProjectileWave(caster, currentWaveIndex)
			end)
			waveIndex = waveIndex + 1
		end
	end
	self:Timer(SPIN_START_TIME, function()
		if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
			return
		end
		self:StartSpinAirMotion(caster)
	end)
	self:Timer(SPIN_LAND_TIME, function()
		if token ~= self.sequenceToken or not IsValidAlive(nil, caster) then
			return
		end
		self:LandImpact(caster, getGroundPosition(nil, caster:GetAbsOrigin(), caster), false, false)
	end)
end
function boss_pangolier_4.prototype.StopPerformance(self)
	self.sequenceToken = self.sequenceToken + 1
	local caster = self:GetCaster()
	if not IsValid(nil, caster) or caster:IsNull() then
		return
	end
	modifier_boss_pangolier_4_performance:remove(caster)
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
	caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_2)
end
function boss_pangolier_4.prototype.GetInitialLandingPosition(self, caster)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local target = caster:GetMinDistanceUnit(INITIAL_LAND_SEARCH_RANGE)
	if not IsValidAlive(nil, target) then
		return origin
	end
	local landingPosition = getGroundPosition(nil, target:GetAbsOrigin(), caster)
	local direction = getFlatDirection(nil, landingPosition:__sub(origin))
	caster:SetForwardVector(direction)
	return landingPosition
end
function boss_pangolier_4.prototype.StartInitialLeap(self, caster, landingPosition)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local midpoint = origin:__add(landingPosition):__mul(0.5)
	local peak = Vector(midpoint.x, midpoint.y, math.max(origin.z, landingPosition.z) + INITIAL_LEAP_HEIGHT)
	caster:Bezier2Mover({ origin, peak, landingPosition }, INITIAL_LAND_TIME, nil, true, true)
end
function boss_pangolier_4.prototype.StartSpinAirMotion(self, caster)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local peak = Vector(origin.x, origin.y, origin.z + SPIN_AIR_HEIGHT)
	caster:Bezier2Mover({ origin, peak, origin }, SPIN_LAND_TIME - SPIN_START_TIME, nil, true, true)
end
function boss_pangolier_4.prototype.ShowLandingWarning(self, position, duration)
	self:WarningRingEffect(position, LAND_WARNING_RADIUS, duration)
end
function boss_pangolier_4.prototype.LandImpact(self, caster, impactPosition, dealDamage, fixCasterPosition)
	local origin = getGroundPosition(nil, impactPosition, caster)
	if fixCasterPosition then
		FindClearSpaceForUnit(caster, origin, true)
	end
	local stompPfx = ParticleManager:CreateParticle(LAND_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(stompPfx, 0, origin)
	ParticleManager:SetParticleControl(
		stompPfx,
		1,
		Vector(LAND_WARNING_RADIUS, LAND_WARNING_RADIUS, LAND_WARNING_RADIUS)
	)
	ParticleManager:ReleaseParticleIndex(stompPfx)
	local dustPfx = ParticleManager:CreateParticle(LAND_DUST_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(dustPfx, 0, origin)
	ParticleManager:ReleaseParticleIndex(dustPfx)
	EmitSoundOnLocationWithCaster(origin, LAND_SOUND, caster)
	ScreenShake(origin, 8, 8, 0.45, 2200, 0, true)
	if not dealDamage then
		return
	end
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		LAND_WARNING_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue39
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = LAND_DAMAGE_RATE, ability = self, damage_type = 1 })
		end
		::__continue39::
	end
end
function boss_pangolier_4.prototype.ShowProjectileWarnings(self, caster, waveIndex, duration)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local angleOffset = self:GetWaveAngleOffset(waveIndex)
	do
		local i = 0
		while i < PROJECTILE_COUNT_PER_WAVE do
			local currentIndex = i
			local direction = self:GetProjectileDirection(currentIndex, angleOffset)
			local ____end = getGroundPosition(nil, origin:__add(direction:__mul(PROJECTILE_DISTANCE)), caster)
			self:WarningEffect(
				origin,
				____end,
				duration,
				{ startWidth = PROJECTILE_RADIUS, endWidth = PROJECTILE_RADIUS }
			)
			i = i + 1
		end
	end
end
function boss_pangolier_4.prototype.FireProjectileWave(self, caster, waveIndex)
	local origin = getGroundPosition(nil, caster:GetAbsOrigin(), caster)
	local startPoint = Vector(origin.x, origin.y, origin.z + PROJECTILE_START_HEIGHT)
	local angleOffset = self:GetWaveAngleOffset(waveIndex)
	local damagedTargets = __TS__New(Map)
	EmitSoundOn(PROJECTILE_SOUND, caster)
	do
		local i = 0
		while i < PROJECTILE_COUNT_PER_WAVE do
			local currentIndex = i
			local direction = self:GetProjectileDirection(currentIndex, angleOffset)
			local targetPoint = getGroundPosition(nil, origin:__add(direction:__mul(PROJECTILE_DISTANCE)), caster)
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = PROJECTILE_PARTICLE,
				target = targetPoint,
				start_point = startPoint,
				projectile_type = "linear",
				projectile_speed = PROJECTILE_SPEED,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = PROJECTILE_DISTANCE,
				projectile_range = PROJECTILE_RADIUS,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					local entityIndex = hitTarget:GetEntityIndex()
					if damagedTargets:get(entityIndex) then
						return false
					end
					if not IsValidAlive(nil, caster) then
						return true
					end
					damagedTargets:set(entityIndex, true)
					caster:MonsterDamage({
						victim = hitTarget,
						damage_rate = PROJECTILE_DAMAGE_RATE,
						ability = self,
						damage_type = 1,
					})
					EmitSoundOn(PROJECTILE_HIT_SOUND, hitTarget)
					return false
				end,
			})
			i = i + 1
		end
	end
end
function boss_pangolier_4.prototype.GetWaveAngleOffset(self, waveIndex)
	local angleInterval = 360 / PROJECTILE_COUNT_PER_WAVE
	return waveIndex % 2 == 0 and 0 or angleInterval * 0.5
end
function boss_pangolier_4.prototype.GetProjectileDirection(self, index, angleOffset)
	local angle = angleOffset + 360 / PROJECTILE_COUNT_PER_WAVE * index
	return getFlatDirection(nil, RotateVector2D(nil, Vector(1, 0, 0), angle))
end
boss_pangolier_4 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_pangolier_4)
____exports.boss_pangolier_4 = boss_pangolier_4
modifier_boss_pangolier_4_performance = __TS__Class()
modifier_boss_pangolier_4_performance.name = "modifier_boss_pangolier_4_performance"
__TS__ClassExtends(modifier_boss_pangolier_4_performance, MonsterModifier_CS)
function modifier_boss_pangolier_4_performance.prototype.CheckState(self)
	return {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
function modifier_boss_pangolier_4_performance.prototype.IsHidden(self)
	return true
end
modifier_boss_pangolier_4_performance =
	__TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_pangolier_4_performance)
return ____exports