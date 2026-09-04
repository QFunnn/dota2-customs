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
local CAST_POINT = 0.75
local CAST_DURATION = 1
local LOCK_RANGE = 1200
local CAST_RANGE = 1200
local FIREBALL_WAVE_COUNT = 4
local MIN_FIREBALL_COUNT = 2
local MAX_FIREBALL_COUNT = 4
local FIRE_INTERVAL = 0.35
local FAN_ANGLE = 36
local PROJECTILE_DISTANCE = 1500
local PROJECTILE_RADIUS = 50
local PROJECTILE_SPEED = 1050
local START_OFFSET = 80
local START_HEIGHT = 96
local DAMAGE_RATE = 10
local BURN_DURATION = 5
local FIREBALL_PARTICLE = "particles/dragon_knight_elder_dragon_fire.vpcf"
local CAST_SOUND = "Hero_DragonKnight.BreathFire"
local HIT_SOUND = "Hero_OgreMagi.Fireblast.Target"
____exports.elite_100 = __TS__Class()
local elite_100 = ____exports.elite_100
elite_100.name = "elite_100"
__TS__ClassExtends(elite_100, MonsterAbility_CS)
function elite_100.prototype.Precache(self, context)
	PrecacheResource("particle", FIREBALL_PARTICLE, context)
end
function elite_100.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = 0.75,
		canCast = function()
			local target = self:GetCaster():GetMinDistanceUnit(LOCK_RANGE)
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
				return true
			end
			local target = caster:GetMinDistanceUnit(LOCK_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, 1)
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(400))
			self:WarningEffect(origin, endPos, CAST_POINT + 0.15, {
				startWidth = 100,
				endWidth = 400,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			do
				local waveIndex = 0
				while waveIndex < FIREBALL_WAVE_COUNT do
					self:ScheduleFireballWave(FIRE_INTERVAL * waveIndex, waveIndex)
					waveIndex = waveIndex + 1
				end
			end
		end,
	}
end
function elite_100.prototype.ScheduleFireballWave(self, delay, waveIndex)
	if delay ~= 0 then
		self:Timer(delay - 0.3, function()
			self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 1.2)
		end)
	end
	self:Timer(delay, function()
		return self:FireballWave(waveIndex)
	end)
end
function elite_100.prototype.FireballWave(self, waveIndex)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn(CAST_SOUND, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local startPoint = origin:__add(Vector(0, 0, START_HEIGHT)):__add(forward:__mul(START_OFFSET))
	local num = 0
	if waveIndex < 1 then
		num = -1
	elseif waveIndex < 3 then
		num = 0
	else
		num = 1
	end
	local fireballCount = RandomInt(MIN_FIREBALL_COUNT, MAX_FIREBALL_COUNT) + num
	for ____, direction in ipairs(self:GetFireballDirections(forward, fireballCount)) do
		local endPoint = startPoint:__add(direction:__mul(PROJECTILE_DISTANCE))
		self:LaunchFireball(startPoint, endPoint)
	end
end
function elite_100.prototype.GetFireballDirections(self, forward, fireballCount)
	if fireballCount <= 1 then
		return { forward:Normalized() }
	end
	local interval = FAN_ANGLE / (fireballCount - 1)
	local directions = {}
	do
		local i = 0
		while i < fireballCount do
			local angle = -(FAN_ANGLE / 2) + interval * i
			directions[#directions + 1] = RotateVector2D(nil, forward, angle):Normalized()
			i = i + 1
		end
	end
	return directions
end
function elite_100.prototype.LaunchFireball(self, startPoint, endPoint)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = FIREBALL_PARTICLE,
		target = endPoint,
		start_point = startPoint:__add(Vector(0, 0, 30)),
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not IsValidAlive(nil, caster) then
				return true
			end
			EmitSoundOn(HIT_SOUND, hitTarget)
			caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.BURN, { duration = BURN_DURATION })
			hitTarget:KnockBack(caster, self, {
				duration = 0.1,
				distance = 60,
				height = 0,
				direction = hitTarget:GetAbsOrigin():__sub(caster:GetAbsOrigin()):Normalized(),
				heightType = "parabola",
				destroyTreesType = "onDestroy",
				particleName = "",
			})
			return true
		end,
		on_think = function(____, location)
			return not GridNav:IsTraversable(location)
		end,
	})
end
elite_100 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_100)
____exports.elite_100 = elite_100
return ____exports