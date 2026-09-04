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
local CAST_POINT = 1.1
local CAST_DURATION = 1.3
local CAST_RANGE = 700
local PROJECTILE_SPEED = 900
local PROJECTILE_DISTANCE = 700
local PROJECTILE_RADIUS = 110
local PROJECTILE_SPAWN_FORWARD = 80
local DAMAGE_RATE = 10
local SHOCKWAVE_PARTICLE = "particles/magnataur_shockwave.vpcf"
local SHOCKWAVE_HIT_PARTICLE = "particles/magnataur_shockwave_hit2.vpcf"
local SHOCKWAVE_CAST_SOUND = "Hero_Magnataur.ShockWave.Cast"
local SHOCKWAVE_FLY_SOUND = "Hero_Magnataur.ShockWave.Particle"
--- 普通技能14 - 蓄力后向前释放震荡冲击波
____exports.normal_014 = __TS__Class()
local normal_014 = ____exports.normal_014
normal_014.name = "normal_014"
__TS__ClassExtends(normal_014, MonsterAbility_CS)
function normal_014.prototype.Precache(self, context)
	PrecacheResource("particle", SHOCKWAVE_PARTICLE, context)
	PrecacheResource("particle", SHOCKWAVE_HIT_PARTICLE, context)
end
function normal_014.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local faceTarget = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, faceTarget) then
				caster:LockTargetForSpeed(faceTarget, CAST_POINT)
			end
			local forward = caster:GetForwardVector()
			local warnStart = caster:GetAbsOrigin():__add(forward:__mul(PROJECTILE_SPAWN_FORWARD))
			local warnEnd = warnStart:__add(forward:__mul(PROJECTILE_DISTANCE))
			self:WarningEffect(warnStart, warnEnd, CAST_POINT, {
				startWidth = PROJECTILE_RADIUS,
				endWidth = PROJECTILE_RADIUS,
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
			local startPoint = caster
				:GetAbsOrigin()
				:__add(caster:GetForwardVector():__mul(PROJECTILE_SPAWN_FORWARD))
				:__add(Vector(0, 0, 90))
			local targetPoint = startPoint:__add(caster:GetForwardVector():__mul(PROJECTILE_DISTANCE))
			EmitSoundOn(SHOCKWAVE_CAST_SOUND, caster)
			EmitSoundOn(SHOCKWAVE_FLY_SOUND, caster)
			CreateProjectile(nil, {
				ability = self,
				caster = caster,
				effect_name = SHOCKWAVE_PARTICLE,
				target = targetPoint,
				start_point = startPoint,
				projectile_type = "linear",
				projectile_speed = PROJECTILE_SPEED,
				projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
				projectile_target_type = bit.bor(DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_BASIC),
				projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
				projectile_distance = PROJECTILE_DISTANCE,
				projectile_range = PROJECTILE_RADIUS,
				on_hit = function(____, hitTarget)
					if hitTarget and IsValidAlive(nil, hitTarget) then
						if not IsValidAlive(nil, caster) then
							return
						end
						local hitPfx =
							ParticleManager:CreateParticle(SHOCKWAVE_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, hitTarget)
						ParticleManager:ReleaseParticleIndex(hitPfx)
						caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
						return false
					end
					return true
				end,
			})
		end,
	}
end
normal_014 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_014)
____exports.normal_014 = normal_014
return ____exports