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
local CAST_POINT = 1.25
local LOCK_RANGE = 1000
local CAST_RANGE = 900
local PROJECTILE_DISTANCE = 1000
local PROJECTILE_WIDTH = 120
local PROJECTILE_SPEED = 1200
local DAMAGE_RATE = 15
local KNOCKBACK_DURATION = 0.35
local KNOCKBACK_DISTANCE = 180
local TORNADO_PARTICLE = "particles/units/heroes/hero_invoker/invoker_tornado.vpcf"
--- 精英技能18 - 预警 1s 后发射飓风投射物，命中造成伤害并短暂击退
____exports.elite_018 = __TS__Class()
local elite_018 = ____exports.elite_018
elite_018.name = "elite_018"
__TS__ClassExtends(elite_018, MonsterAbility_CS)
function elite_018.prototype.Precache(self, context)
	PrecacheResource("particle", TORNADO_PARTICLE, context)
end
function elite_018.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 0.4,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.8,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, 0.7)
			end
			local forward = caster:GetForwardVector()
			local warnEnd = origin:__add(forward:__mul(PROJECTILE_DISTANCE))
			self:WarningEffect(origin, warnEnd, CAST_POINT, {
				startWidth = PROJECTILE_WIDTH,
				endWidth = PROJECTILE_WIDTH + 25,
				getDirection = function()
					return caster:GetForwardVector()
				end,
			})
			self:Timer(0.7, function()
				local forward = caster:GetForwardVector()
				local origin = caster:GetAbsOrigin()
				caster:Mover(origin:__add(forward:__mul(-100)), 0.2)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
			local startPoint = origin:__add(Vector(0, 0, 96)):__add(forward:__mul(80))
			local endPoint = startPoint:__add(forward:__mul(PROJECTILE_DISTANCE))
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = TORNADO_PARTICLE,
				projectile_type = "linear",
				start_point = startPoint,
				target = endPoint,
				projectile_speed = PROJECTILE_SPEED,
				projectile_distance = PROJECTILE_DISTANCE,
				projectile_range = PROJECTILE_WIDTH + 35,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				on_hit = function(____, hitTarget)
					if not hitTarget or not IsValidAlive(nil, hitTarget) then
						return true
					end
					if not IsValidAlive(nil, caster) then
						return true
					end
					caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
					hitTarget:KnockBack(
						caster,
						self,
						{
							duration = KNOCKBACK_DURATION,
							distance = KNOCKBACK_DISTANCE,
							destroyTreesType = "onDestroy",
							stun = true,
						}
					)
					return true
				end,
			})
		end,
	}
end
elite_018 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_018)
____exports.elite_018 = elite_018
return ____exports