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
local CAST_RANGE = 1200
local CAST_POINT = 0.5
local DISTANCE = 1100
local WIDTH = 190
local PARTICLE = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_charge.vpcf"
local HIT_PARTICLE = "particles/units/heroes/hero_spirit_breaker/spirit_breaker_greater_bash.vpcf"
____exports.elite_314 = __TS__Class()
local elite_314 = ____exports.elite_314
elite_314.name = "elite_314"
__TS__ClassExtends(elite_314, MonsterAbility_CS)
function elite_314.prototype.Precache(self, context)
	PrecacheResource("particle", PARTICLE, context)
	PrecacheResource("particle", HIT_PARTICLE, context)
end
function elite_314.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 1.4,
		castAnimation = ACT_DOTA_RUN,
		cooldown = 12,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local direction = self:DirectionToTarget(caster)
			self:WarningEffect(
				caster:GetAbsOrigin(),
				self:GroundLineEnd(caster:GetAbsOrigin(), direction, caster),
				CAST_POINT,
				{ startWidth = WIDTH, endWidth = WIDTH }
			)
		end,
		OnStart = function()
			return self:Charge()
		end,
	}
end
function elite_314.prototype.Charge(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = self:DirectionToTarget(caster)
	EmitSoundOn("Hero_Spirit_Breaker.ChargeOfDarkness", caster)
	self:FireChargeLine(caster, caster:GetAbsOrigin(), direction)
end
function elite_314.prototype.FireChargeLine(self, caster, start, direction)
	local ____end = self:GroundLineEnd(start, direction, caster)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = PARTICLE,
		projectile_type = "linear",
		start_point = start,
		target = ____end,
		projectile_speed = 1700,
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
			caster:MonsterDamage({ victim = hitTarget, damage_rate = 13, ability = self, effectName = HIT_PARTICLE })
			AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = 0.45 })
			EmitSoundOn("Hero_Spirit_Breaker.GreaterBash", hitTarget)
			return false
		end,
	})
end
function elite_314.prototype.DirectionToTarget(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if IsValidAlive(nil, target) then
		local direction = GetDirection(nil, target:GetAbsOrigin(), caster:GetAbsOrigin())
		if direction:Length2D() > 0.01 then
			return direction
		end
	end
	return caster:GetForwardVector():Normalized()
end
function elite_314.prototype.GroundLineEnd(self, start, direction, caster)
	return GetGroundPosition(start:__add(direction:__mul(DISTANCE)), caster)
end
elite_314 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_314)
____exports.elite_314 = elite_314
return ____exports