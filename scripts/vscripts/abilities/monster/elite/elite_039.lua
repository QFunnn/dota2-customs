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
local CAST_POINT = 0.5
local CAST_DURATION = 0.5
local LOCK_RANGE = 1200
local CAST_RANGE = 1100
local FIREBALL_COUNT = 3
local FAN_ANGLE = 36
local PROJECTILE_DISTANCE = 1500
local PROJECTILE_RADIUS = 120
local PROJECTILE_SPEED = 950
local START_OFFSET = 80
local START_HEIGHT = 96
local DAMAGE_RATE = 14
local BURN_DURATION = 5
local FIREBALL_PARTICLE = "particles/units/monster/dragon_knight_elder_dragon_fire.vpcf"
local CAST_SOUND = "Hero_DragonKnight.BreathFire"
local HIT_SOUND = "Hero_OgreMagi.Fireblast.Target"
--- 精英技能39 - 蓄力后向前方扇形发射三枚火球
____exports.elite_039 = __TS__Class()
local elite_039 = ____exports.elite_039
elite_039.name = "elite_039"
__TS__ClassExtends(elite_039, MonsterAbility_CS)
function elite_039.prototype.Precache(self, context)
	PrecacheResource("particle", FIREBALL_PARTICLE, context)
end
function elite_039.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_ATTACK,
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
				caster:LockTargetForSpeed(target, CAST_POINT)
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
			EmitSoundOn(CAST_SOUND, caster)
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local startPoint = origin:__add(Vector(0, 0, START_HEIGHT)):__add(forward:__mul(START_OFFSET))
			for ____, direction in ipairs(self:GetFireballDirections(forward)) do
				local endPoint = startPoint:__add(direction:__mul(PROJECTILE_DISTANCE))
				self:LaunchFireball(startPoint, endPoint)
			end
		end,
	}
end
function elite_039.prototype.GetFireballDirections(self, forward)
	if FIREBALL_COUNT <= 1 then
		return { forward:Normalized() }
	end
	local interval = FAN_ANGLE / (FIREBALL_COUNT - 1)
	local directions = {}
	do
		local i = 0
		while i < FIREBALL_COUNT do
			local angle = -(FAN_ANGLE / 2) + interval * i
			directions[#directions + 1] = RotateVector2D(nil, forward, angle):Normalized()
			i = i + 1
		end
	end
	return directions
end
function elite_039.prototype.GetDirectionAngle(self, baseForward, direction)
	local base = Vector(baseForward.x, baseForward.y, 0):Normalized()
	local dir = Vector(direction.x, direction.y, 0):Normalized()
	local crossZ = base.x * dir.y - base.y * dir.x
	local dot = math.max(-1, math.min(1, base.x * dir.x + base.y * dir.y))
	return math.atan2(crossZ, dot) * 180 / math.pi
end
function elite_039.prototype.LaunchFireball(self, startPoint, endPoint)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = "particles/dragon_knight_elder_dragon_fire.vpcf",
		target = endPoint,
		start_point = startPoint:__add(Vector(0, 0, 50)),
		projectile_type = "linear",
		projectile_speed = PROJECTILE_SPEED,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = 60,
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
			return false
		end,
	})
end
elite_039 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_039)
____exports.elite_039 = elite_039
return ____exports