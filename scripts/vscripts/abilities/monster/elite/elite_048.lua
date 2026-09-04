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
local CAST_POINT = 0.65
local CAST_DURATION = 1.6
local CAST_RANGE = 700
local PROJECTILE_COUNT = 5
local PROJECTILE_LAND_DISTANCE = 500
local PROJECTILE_DISTANCE_RANDOM = 230
local PROJECTILE_ANGLE_RANDOM = 23
local PROJECTILE_SPEED = 800
local PROJECTILE_START_HEIGHT = 160
local EXPLOSION_DELAY = 1.8
local EXPLOSION_RADIUS = 220
local DAMAGE_RATE = 25
local EXPLOSION_PARTICLE = "particles/econ/items/leshrac/leshrac_tormented_staff/leshrac_split_tormented.vpcf"
local PROJECTILE_PARTICLE =
	"particles/econ/items/leshrac/leshrac_tormented_staff_retro/leshrac_base_attack_retro_tormented.vpcf"
local CAST_SOUND = "Hero_Leshrac.Split_Earth"
local IMPACT_SOUND = "Hero_Invoker.SunStrike.Ignite"
--- 精英技能 48 - 蓄力后以自身为中心向四周抛出多枚投射物，落地预警后爆炸
____exports.elite_048 = __TS__Class()
local elite_048 = ____exports.elite_048
elite_048.name = "elite_048"
__TS__ClassExtends(elite_048, MonsterAbility_CS)
function elite_048.prototype.Precache(self, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
	PrecacheResource("particle", PROJECTILE_PARTICLE, context)
end
function elite_048.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.6,
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(CAST_RANGE)
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
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			self:LaunchProjectilesAroundCaster(caster)
		end,
	}
end
function elite_048.prototype.LaunchProjectilesAroundCaster(self, caster)
	local center = GetGroundPosition(caster:GetAbsOrigin(), caster)
	local startPoint = center:__add(Vector(0, 0, PROJECTILE_START_HEIGHT))
	EmitSoundOnLocationWithCaster(center, CAST_SOUND, caster)
	do
		local index = 0
		while index < PROJECTILE_COUNT do
			local currentIndex = index
			local baseAngle = 360 / PROJECTILE_COUNT * currentIndex
			local currentAngle = baseAngle + RandomFloat(-PROJECTILE_ANGLE_RANDOM, PROJECTILE_ANGLE_RANDOM)
			local currentDistance = PROJECTILE_LAND_DISTANCE
				+ RandomFloat(-PROJECTILE_DISTANCE_RANDOM, PROJECTILE_DISTANCE_RANDOM)
			local currentDirection = RotateVector2D(nil, Vector(1, 0, 0), currentAngle):Normalized()
			local currentLandPoint = GetGroundPosition(center:__add(currentDirection:__mul(currentDistance)), caster)
			self:LaunchProjectileToPoint(caster, startPoint, currentLandPoint)
			index = index + 1
		end
	end
end
function elite_048.prototype.LaunchProjectileToPoint(self, caster, startPoint, landPoint)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PROJECTILE_PARTICLE,
		projectile_type = "collideground",
		projectile_speed = PROJECTILE_SPEED,
		start_point = startPoint,
		target = landPoint,
		on_hit = function(____, _target, location)
			if not IsServer() or not IsValidAlive(nil, caster) then
				return true
			end
			local groundZ = GetGroundHeight(location, caster) or location.z
			local explosionPoint = Vector(location.x, location.y, groundZ)
			self:ArmExplosion(explosionPoint)
			return true
		end,
	})
end
function elite_048.prototype.ArmExplosion(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:WarningRingEffect(origin, EXPLOSION_RADIUS, EXPLOSION_DELAY)
	self:Timer(EXPLOSION_DELAY, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		self:Explode(origin)
	end)
end
function elite_048.prototype.Explode(self, origin)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local pfx = ParticleManager:CreateParticle(EXPLOSION_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(pfx, 0, origin)
	ParticleManager:SetParticleControl(pfx, 1, Vector(EXPLOSION_RADIUS, EXPLOSION_RADIUS, EXPLOSION_RADIUS))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOnLocationWithCaster(origin, IMPACT_SOUND, caster)
	ScreenShake(origin, 10, 10, 0.25, 1200, 0, true)
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		EXPLOSION_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue21
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.1 })
		end
		::__continue21::
	end
end
elite_048 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_048)
____exports.elite_048 = elite_048
return ____exports