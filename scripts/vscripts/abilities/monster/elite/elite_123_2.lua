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
local CAST_POINT = 1
local CAST_DURATION = 2.2
local LOCK_RANGE = 1500
local CAST_RANGE = 1000
local PROJECTILE_DISTANCE = 1600
local PROJECTILE_SPEED = 1000
local PROJECTILE_RADIUS = 64
local START_FORWARD_OFFSET = 90
local START_HEIGHT = 110
local ROUND_INTERVAL = 0.6
local RING_GROUP_COUNT = 2
local FIRST_ROUND_PROJECTILE_COUNT = 6
local SECOND_ROUND_PROJECTILE_COUNT = 8
local THIRD_ROUND_PROJECTILE_COUNT = 12
local FOURTH_ROUND_PROJECTILE_COUNT = THIRD_ROUND_PROJECTILE_COUNT + 3
local FOURTH_ROUND_EXTRA_DELAY = 0.3
local SCREEN_SHAKE_AMPLITUDE = 8
local SCREEN_SHAKE_FREQUENCY = 8
local SCREEN_SHAKE_DURATION = 0.2
local SCREEN_SHAKE_RADIUS = 2000
local DAMAGE_RATE = 20
local MAGIC_BALL_PARTICLE = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile_2.vpcf"
local PROJECTILE_HIT_EFFECT = "particles/nightstalker_black_nihility_void_hit.vpcf"
local CAST_SOUND = "Hero_SkywrathMage.ConcussiveShot.Cast"
local HIT_SOUND = "Hero_SkywrathMage.ArcaneBolt.Impact"
____exports.elite_123_2 = __TS__Class()
local elite_123_2 = ____exports.elite_123_2
elite_123_2.name = "elite_123_2"
__TS__ClassExtends(elite_123_2, MonsterAbility_CS)
function elite_123_2.prototype.Precache(self, context)
	PrecacheResource("particle", MAGIC_BALL_PARTICLE, context)
end
function elite_123_2.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castRange = CAST_RANGE,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.7,
		canCast = function()
			local caster = self:GetCaster()
			local target = caster:GetMinDistanceUnit(LOCK_RANGE)
			local ____IsValidAlive_result_0
			if IsValidAlive(nil, target) then
				____IsValidAlive_result_0 = UF_SUCCESS
			else
				____IsValidAlive_result_0 = UF_FAIL_CUSTOM
			end
			return ____IsValidAlive_result_0
		end,
		OnStart = function()
			self:FireMagicBallRound(FIRST_ROUND_PROJECTILE_COUNT)
			self:Timer(ROUND_INTERVAL, function()
				self:FireMagicBallRound(SECOND_ROUND_PROJECTILE_COUNT)
			end)
			self:Timer(ROUND_INTERVAL * 2, function()
				self:FireMagicBallRound(THIRD_ROUND_PROJECTILE_COUNT)
			end)
			self:Timer(ROUND_INTERVAL * 3 + FOURTH_ROUND_EXTRA_DELAY, function()
				self:FireMagicBallRound(FOURTH_ROUND_PROJECTILE_COUNT)
			end)
		end,
	}
end
function elite_123_2.prototype.FireMagicBallRound(self, projectileCount)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	EmitSoundOn(CAST_SOUND, caster)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.2)
	ScreenShake(
		origin,
		SCREEN_SHAKE_AMPLITUDE,
		SCREEN_SHAKE_FREQUENCY,
		SCREEN_SHAKE_DURATION,
		SCREEN_SHAKE_RADIUS,
		0,
		true
	)
	local startOrigin = origin:__add(Vector(0, 0, START_HEIGHT))
	local angleStep = 360 / projectileCount
	do
		local groupIndex = 0
		while groupIndex < RING_GROUP_COUNT do
			local currentGroupIndex = groupIndex
			local groupAngleOffset = angleStep / RING_GROUP_COUNT * currentGroupIndex
			do
				local projectileIndex = 0
				while projectileIndex < projectileCount do
					local currentProjectileIndex = projectileIndex
					local currentAngle = angleStep * currentProjectileIndex + groupAngleOffset
					local currentDirection = RotateVector2D(nil, Vector(1, 0, 0), currentAngle):Normalized()
					local startPoint = startOrigin:__add(currentDirection:__mul(START_FORWARD_OFFSET))
					self:LaunchMagicBall(startPoint, currentDirection)
					projectileIndex = projectileIndex + 1
				end
			end
			groupIndex = groupIndex + 1
		end
	end
end
function elite_123_2.prototype.LaunchMagicBall(self, startPoint, direction)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = MAGIC_BALL_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		direction = direction,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return true
				end
				EmitSoundOn(HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				local pfx = ParticleManager:CreateParticle(PROJECTILE_HIT_EFFECT, PATTACH_ABSORIGIN_FOLLOW, hitTarget)
				ParticleManager:ReleaseParticleIndex(pfx)
				return true
			end
			return true
		end,
		on_think = function(____, location)
			return not GridNav:IsTraversable(location)
		end,
	})
end
elite_123_2 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_123_2)
____exports.elite_123_2 = elite_123_2
return ____exports