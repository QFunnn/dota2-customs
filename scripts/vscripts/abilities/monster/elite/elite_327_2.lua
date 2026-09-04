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
local CAST_RANGE = 1000
local CAST_POINT = 0.95
local CAST_COOLDOWN = 5
local BARRAGE_ROUND_INTERVAL = 1
local BARRAGE_ROUND_PROJECTILE_COUNTS = { 1, 2, 3 }
local CAST_DURATION = BARRAGE_ROUND_INTERVAL * (#BARRAGE_ROUND_PROJECTILE_COUNTS - 1) + 0.5
local PUNCH_RELEASE_DELAY = 0.5
local PUNCH_PROJECTILE_ANGLE_STEP = 12
local PUNCH_PROJECTILE_DISTANCE = 1700
local PUNCH_PROJECTILE_WIDTH = 120
local PUNCH_PROJECTILE_SPEED = 1200
local PUNCH_DAMAGE_RATE = 25
local PUNCH_START_FORWARD_OFFSET = 120
local PUNCH_ATTACK_PLAYBACK_RATE = 0.9
local PUNCH_SCREEN_SHAKE_AMPLITUDE = 10
local PUNCH_SCREEN_SHAKE_FREQUENCY = 12
local PUNCH_SCREEN_SHAKE_DURATION = 0.15
local PUNCH_SCREEN_SHAKE_RADIUS = 1600
local PUNCH_PROJECTILE_PARTICLE =
	"particles/econ/items/puck/puck_merry_wanderer/puck_illusory_orb_merry_wanderer_linear_projectile.vpcf"
local PUNCH_CAST_EFFECT_PARTICLE = "particles/bb/pun_dark_seer_attack_normal_punch.vpcf"
local PUNCH_HIT_PARTICLE = "particles/units/heroes/hero_dark_seer/dark_seer_wall_of_replica_replicate.vpcf"
local PUNCH_SOUND = "Hero_Dark_Seer.NormalPunch.Lv1"
local PUNCH_HIT_SOUND = "Hero_Dark_Seer.Surge"
____exports.elite_327_2 = __TS__Class()
local elite_327_2 = ____exports.elite_327_2
elite_327_2.name = "elite_327_2"
__TS__ClassExtends(elite_327_2, MonsterAbility_CS)
function elite_327_2.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_327_2.prototype.Precache(self, context)
	PrecacheResource("particle", PUNCH_PROJECTILE_PARTICLE, context)
	PrecacheResource("particle", PUNCH_CAST_EFFECT_PARTICLE, context)
	PrecacheResource("particle", PUNCH_HIT_PARTICLE, context)
end
function elite_327_2.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.6,
		cooldown = CAST_COOLDOWN,
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
			return self:PrepareBarrage()
		end,
		OnStart = function()
			return self:StartBarrage()
		end,
		OnInterrupt = function()
			return self:StopBarrage()
		end,
		OnFinish = function()
			return self:StopBarrage()
		end,
	}
end
function elite_327_2.prototype.PrepareBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, CAST_POINT, 5)
	end
end
function elite_327_2.prototype.StartBarrage(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self.castToken = self.castToken + 1
	local token = self.castToken
	do
		local index = 0
		while index < #BARRAGE_ROUND_PROJECTILE_COUNTS do
			do
				local currentIndex = index
				local currentCount = BARRAGE_ROUND_PROJECTILE_COUNTS[currentIndex + 1]
				local currentFireDelay = currentIndex * BARRAGE_ROUND_INTERVAL
				local currentGestureDelay = math.max(currentFireDelay - PUNCH_RELEASE_DELAY, 0)
				if currentIndex == 0 then
					self:FireBarrageRound(caster, currentCount)
					goto __continue14
				end
				if currentIndex > 0 then
					self:Timer(currentGestureDelay, function()
						if token ~= self.castToken or not IsValidAlive(nil, caster) then
							return
						end
						self:PlayBarrageGesture(caster)
					end)
				end
				self:Timer(currentFireDelay, function()
					if token ~= self.castToken or not IsValidAlive(nil, caster) then
						return
					end
					self:FireBarrageRound(caster, currentCount)
				end)
			end
			::__continue14::
			index = index + 1
		end
	end
end
function elite_327_2.prototype.StopBarrage(self)
	self.castToken = self.castToken + 1
end
function elite_327_2.prototype.PlayBarrageGesture(self, caster)
	local target = self:FindTarget()
	if IsValidAlive(nil, target) then
		caster:LockTargetForSpeed(target, PUNCH_RELEASE_DELAY, 5)
	end
	caster:RemoveGesture(ACT_DOTA_ATTACK)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, PUNCH_ATTACK_PLAYBACK_RATE)
end
function elite_327_2.prototype.FireBarrageRound(self, caster, projectileCount)
	local baseForward = self:FlatDirection(caster:GetForwardVector())
	caster:SetForwardVectorWithoutInterrupt(baseForward)
	EmitSoundOn(PUNCH_SOUND, caster)
	self:PlayPunchScreenShake(caster:GetAbsOrigin())
	local halfCount = (projectileCount - 1) / 2
	do
		local index = 0
		while index < projectileCount do
			local currentIndex = index
			local currentAngle = (currentIndex - halfCount) * PUNCH_PROJECTILE_ANGLE_STEP
			local currentDirection = self:FlatDirection(RotateVector2D(nil, baseForward, currentAngle))
			local currentStart = GetGroundPosition(
				caster:GetAbsOrigin():__add(currentDirection:__mul(PUNCH_START_FORWARD_OFFSET)),
				caster
			)
			local currentEnd =
				GetGroundPosition(currentStart:__add(currentDirection:__mul(PUNCH_PROJECTILE_DISTANCE)), caster)
			self:PlayPunchCastEffect(currentStart, currentDirection, caster)
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = PUNCH_PROJECTILE_PARTICLE,
				projectile_type = "linear",
				start_point = currentStart,
				target = currentEnd,
				projectile_speed = PUNCH_PROJECTILE_SPEED,
				projectile_distance = PUNCH_PROJECTILE_DISTANCE,
				projectile_range = PUNCH_PROJECTILE_WIDTH,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					if not IsValidAlive(nil, caster) then
						return
					end
					caster:MonsterDamage({
						victim = hitTarget,
						damage_rate = PUNCH_DAMAGE_RATE,
						ability = self,
						effectName = PUNCH_HIT_PARTICLE,
					})
					EmitSoundOn(PUNCH_HIT_SOUND, hitTarget)
					return false
				end,
			})
			index = index + 1
		end
	end
end
function elite_327_2.prototype.FindTarget(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return nil
	end
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_327_2.prototype.PlayPunchCastEffect(self, origin, forward, caster)
	local particle = ParticleManager:CreateParticle(PUNCH_CAST_EFFECT_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControlForward(particle, 0, forward)
	ParticleManager:SetParticleControlTransformForward(particle, 0, origin, forward)
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_327_2.prototype.PlayPunchScreenShake(self, point)
	ScreenShake(
		point,
		PUNCH_SCREEN_SHAKE_AMPLITUDE,
		PUNCH_SCREEN_SHAKE_FREQUENCY,
		PUNCH_SCREEN_SHAKE_DURATION,
		PUNCH_SCREEN_SHAKE_RADIUS,
		0,
		true
	)
end
function elite_327_2.prototype.FlatDirection(self, direction)
	local flat = Vector(direction.x, direction.y, 0)
	local ____temp_1
	if flat:Length2D() > 0.01 then
		____temp_1 = flat:Normalized()
	else
		____temp_1 = Vector(1, 0, 0)
	end
	return ____temp_1
end
elite_327_2 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_327_2)
____exports.elite_327_2 = elite_327_2
return ____exports