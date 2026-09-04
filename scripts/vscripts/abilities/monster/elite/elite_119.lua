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
local LOCK_RANGE = 1200
local CAST_RANGE = 800
local PROJECTILE_DELAY = 0.2
local PROJECTILE_DISTANCE = 800
local PROJECTILE_WIDTH = 150
local END_WIDTH = 300
local PROJECTILE_SPEED = 1200
local DAMAGE_RATE = 25
local FIRE_PARTICLE = "particles/units/heroes/hero_dragon_knight/dragon_knight_breathe_fire.vpcf"
--- 精英技能119 - 喷火：前摇锁定最近玩家，延迟发射线性火焰投射物
____exports.elite_119 = __TS__Class()
local elite_119 = ____exports.elite_119
elite_119.name = "elite_119"
__TS__ClassExtends(elite_119, MonsterAbility_CS)
function elite_119.prototype.Precache(self, context)
	PrecacheResource("particle", FIRE_PARTICLE, context)
	PrecacheResource("soundfile", "sounds/weapons/hero/dragon_knight/dragonknight_fire.vsnd", context)
end
function elite_119.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.5,
		castDuration = PROJECTILE_DELAY + 0.3,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local target = self:GetMinDistanceUnit(LOCK_RANGE, origin)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT * 0.7)
			end
			local forward = caster:GetForwardVector()
			local warnEnd = origin:__add(forward:__mul(PROJECTILE_DISTANCE))
			self:WarningEffect(origin, warnEnd, CAST_POINT, {
				startWidth = PROJECTILE_WIDTH,
				endWidth = END_WIDTH,
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
			caster:EmitSound("Hero_DragonKnight.BreathFire")
			local origin = caster:GetAbsOrigin()
			local forward = caster:GetForwardVector()
			local startPoint = origin:__add(Vector(0, 0, 96)):__add(forward:__mul(80))
			local endPoint = startPoint:__add(forward:__mul(PROJECTILE_DISTANCE))
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = FIRE_PARTICLE,
				projectile_type = "linear",
				start_point = startPoint,
				target = endPoint,
				projectile_speed = PROJECTILE_SPEED,
				projectile_distance = PROJECTILE_DISTANCE,
				projectile_range = PROJECTILE_WIDTH,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_end_range = END_WIDTH * 0.8,
				on_hit = function(____, hitTarget)
					if hitTarget and IsValidAlive(nil, hitTarget) then
						if not IsValidAlive(nil, caster) then
							return true
						end
						caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
						hitTarget:KnockBack(caster, self, { distance = 100, duration = 0.2 })
						AddDeBuffStatus(nil, hitTarget, caster, self, DebuffStatusType.STUN, { duration = 0.4 })
						return false
					end
					return true
				end,
			})
		end,
	}
end
elite_119 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_119)
____exports.elite_119 = elite_119
return ____exports