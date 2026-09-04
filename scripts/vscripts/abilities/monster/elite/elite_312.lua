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
local CAST_POINT = 0.5
local DISTANCE = 850
local WIDTH = 120
local ANGLES = {
	-24,
	-12,
	0,
	12,
	24,
}
local PARTICLE = "particles/units/heroes/hero_bristleback/bristleback_viscous_nasal_goo.vpcf"
____exports.elite_312 = __TS__Class()
local elite_312 = ____exports.elite_312
elite_312.name = "elite_312"
__TS__ClassExtends(elite_312, MonsterAbility_CS)
function elite_312.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
end
function elite_312.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 1.2,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		cooldown = 12,
		OnPhaseStart = function()
			return self:Warn()
		end,
		OnStart = function()
			return self:Spit()
		end,
	}
end
function elite_312.prototype.Warn(self)
	local caster = self:GetCaster()
	local origin = caster:GetAbsOrigin()
	local baseDirection = self:DirectionToTarget(caster)
	for ____, angle in ipairs(ANGLES) do
		local direction = self:RotateDirection(baseDirection, angle)
		self:WarningEffect(
			origin,
			self:GroundLineEnd(origin, direction, caster),
			CAST_POINT,
			{ startWidth = WIDTH, endWidth = WIDTH }
		)
	end
end
function elite_312.prototype.Spit(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local origin = caster:GetAbsOrigin()
	local baseDirection = self:DirectionToTarget(caster)
	EmitSoundOn("Hero_Bristleback.ViscousGoo.Cast", caster)
	do
		local index = 0
		while index < #ANGLES do
			local currentIndex = index
			self:Timer(currentIndex * 0.1, function()
				local direction = self:RotateDirection(baseDirection, ANGLES[currentIndex + 1])
				self:FireGooLine(caster, origin, direction)
			end)
			index = index + 1
		end
	end
end
function elite_312.prototype.FireGooLine(self, caster, start, direction)
	local ____end = self:GroundLineEnd(start, direction, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = 1300,
		projectile_distance = DISTANCE,
		projectile_range = WIDTH,
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
			caster:MonsterDamage({ victim = hitTarget, damage_rate = 6, ability = self })
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.ICE_SLOW, { stack = 4, duration = 1.5 })
			return false
		end,
	})
end
function elite_312.prototype.DirectionToTarget(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector():Normalized()
end
function elite_312.prototype.RotateDirection(self, direction, angleDegrees)
	local radians = angleDegrees * math.pi / 180
	local cos = math.cos(radians)
	local sin = math.sin(radians)
	return Vector(direction.x * cos - direction.y * sin, direction.x * sin + direction.y * cos, 0):Normalized()
end
function elite_312.prototype.GroundLineEnd(self, start, direction, caster)
	return GetGroundPosition(start:__add(direction:__mul(DISTANCE)), caster)
end
elite_312 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_312)
____exports.elite_312 = elite_312
return ____exports