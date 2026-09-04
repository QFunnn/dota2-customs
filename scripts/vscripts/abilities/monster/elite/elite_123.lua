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
local CAST_POINT = 0.85
local CAST_DURATION = 1.1
local LOCK_RANGE = 1400
local CAST_RANGE = 1000
local PROJECTILE_DISTANCE = 1200
local PROJECTILE_SPEED = 1650
local PROJECTILE_RADIUS = 70
local START_FORWARD_OFFSET = 90
local START_HEIGHT = 110
local GROUP_INTERVAL = 0.15
local FIRST_GROUP_SIDE_OFFSET = 90
local SECOND_GROUP_SIDE_OFFSET = 120
local THIRD_GROUP_SIDE_OFFSET = 90
local DAMAGE_RATE = 20
local MAGIC_BALL_PARTICLE = "particles/units/heroes/hero_hoodwink/hoodwink_sharpshooter_projectile_2.vpcf"
local PROJECTILE_HIT_EFFECT = "particles/nightstalker_black_nihility_void_hit.vpcf"
local CAST_SOUND = "Hero_SkywrathMage.ConcussiveShot.Cast"
local HIT_SOUND = "Hero_SkywrathMage.ArcaneBolt.Impact"
____exports.elite_123 = __TS__Class()
local elite_123 = ____exports.elite_123
elite_123.name = "elite_123"
__TS__ClassExtends(elite_123, MonsterAbility_CS)
function elite_123.prototype.Precache(self, context)
	PrecacheResource("particle", MAGIC_BALL_PARTICLE, context)
end
function elite_123.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castRange = 1200,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.8,
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
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = caster:GetMinDistanceUnit(LOCK_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			local origin = caster:GetAbsOrigin()
			local warningEnd = origin:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE * 1.2))
			self:WarningEffect(origin, warningEnd, CAST_POINT, {
				startWidth = THIRD_GROUP_SIDE_OFFSET * 3 + PROJECTILE_RADIUS,
				endWidth = THIRD_GROUP_SIDE_OFFSET * 3 + PROJECTILE_RADIUS,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			self:FireMagicBallGroup({ -FIRST_GROUP_SIDE_OFFSET, FIRST_GROUP_SIDE_OFFSET })
			local caster = self:GetCaster()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 1.2)
			self:Timer(GROUP_INTERVAL, function()
				self:FireMagicBallGroup({ -SECOND_GROUP_SIDE_OFFSET, 0, SECOND_GROUP_SIDE_OFFSET })
			end)
			self:Timer(GROUP_INTERVAL * 2, function()
				local caster = self:GetCaster()
				self:FireMagicBallGroup({
					-THIRD_GROUP_SIDE_OFFSET * 2,
					-THIRD_GROUP_SIDE_OFFSET,
					0,
					THIRD_GROUP_SIDE_OFFSET,
					THIRD_GROUP_SIDE_OFFSET * 2,
				})
			end)
		end,
	}
end
function elite_123.prototype.FireMagicBallGroup(self, sideOffsets)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(CAST_SOUND, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector():Normalized()
	local right = RotateVector2D(nil, forward, 90):Normalized()
	local baseStart = origin:__add(Vector(0, 0, START_HEIGHT)):__add(forward:__mul(START_FORWARD_OFFSET))
	for ____, sideOffset in ipairs(sideOffsets) do
		local startPoint = baseStart:__add(right:__mul(sideOffset))
		self:LaunchMagicBall(startPoint, forward)
	end
end
function elite_123.prototype.LaunchMagicBall(self, startPoint, direction)
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
elite_123 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_123)
____exports.elite_123 = elite_123
return ____exports