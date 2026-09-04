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
local CAST_RANGE = 600
local CAST_POINT = 0.9
local CAST_DURATION = 0.5
local COOLDOWN = 8
local PROJECTILE_SPEED = 1000
local PROJECTILE_DISTANCE = 1080
local PROJECTILE_RADIUS_START = 150
local PROJECTILE_RADIUS_END = 250
local PROJECTILE_START_FORWARD = 90
local PROJECTILE_START_HEIGHT = 64
local DAMAGE_RATE = 20
local SHOCKWAVE_PARTICLE = "particles/neutral_fx/satyr_hellcaller.vpcf"
local SHOCKWAVE_CAST_PARTICLE = "particles/neutral_fx/satyr_hellcaller_cast.vpcf"
local SHOCKWAVE_CAST_SOUND = "n_creep_SatyrHellcaller.Shockwave"
local SHOCKWAVE_HIT_SOUND = "n_creep_SatyrHellcaller.Shockwave.Damage"
--- 精英技能125 - 冲击波：产生一道直线穿过地面的冲击波，对击中的敌人造成伤害。
____exports.elite_125 = __TS__Class()
local elite_125 = ____exports.elite_125
elite_125.name = "elite_125"
__TS__ClassExtends(elite_125, MonsterAbility_CS)
function elite_125.prototype.Precache(self, context)
	PrecacheResource("particle", SHOCKWAVE_PARTICLE, context)
	PrecacheResource("particle", SHOCKWAVE_CAST_PARTICLE, context)
end
function elite_125.prototype.GetMosnterAbilityConfig(self)
	return {
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castRange = CAST_RANGE,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		cooldown = COOLDOWN,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		animationPlaybackRate = 0.7,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local target = self:FindCastTarget(caster)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT * 0.8, 2)
			end
			local direction = caster:GetForwardVector()
			local startPoint = self:GetShockwaveStartPoint(caster, direction, 0)
			local endPoint = startPoint:__add(direction:__mul(1000))
			self:WarningEffect(startPoint, endPoint, CAST_POINT, {
				startWidth = PROJECTILE_RADIUS_START * 0.7,
				endWidth = PROJECTILE_RADIUS_END * 0.7,
				getDirection = function(self)
					return caster:GetForwardVector()
				end,
				follow = true,
			})
			self:PlayCastEffect(caster)
		end,
		OnStart = function()
			self:FireShockwave()
		end,
	}
end
function elite_125.prototype.FireShockwave(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	local direction = caster:GetForwardVector()
	local startPoint = self:GetShockwaveStartPoint(caster, direction, PROJECTILE_START_HEIGHT)
	local targetPoint = startPoint:__add(direction:__mul(PROJECTILE_DISTANCE))
	self:EmitSoundParams(SHOCKWAVE_CAST_SOUND, 1, 5, 0)
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = SHOCKWAVE_PARTICLE,
		projectile_type = "linear",
		start_point = startPoint,
		target = targetPoint,
		projectile_speed = PROJECTILE_SPEED,
		projectile_distance = PROJECTILE_DISTANCE,
		projectile_range = PROJECTILE_RADIUS_START,
		projectile_end_range = PROJECTILE_RADIUS_END,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_NONE,
		on_hit = function(____, hitTarget)
			if hitTarget and IsValidAlive(nil, hitTarget) then
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOn(SHOCKWAVE_HIT_SOUND, hitTarget)
				caster:MonsterDamage({ victim = hitTarget, damage_rate = DAMAGE_RATE, ability = self })
				hitTarget:KnockBack(caster, self, {
					origin_pos = caster:GetAbsOrigin(),
					duration = 0.3,
					stun = true,
					stunDuration = 0.5,
					distance = 80,
					height = 60,
				})
				return false
			end
			return true
		end,
	})
end
function elite_125.prototype.FindCastTarget(self, caster)
	return caster:GetMinDistanceUnit(CAST_RANGE)
end
function elite_125.prototype.GetShockwaveStartPoint(self, caster, direction, height)
	local startPoint = caster:GetAbsOrigin():__add(direction:__mul(PROJECTILE_START_FORWARD))
	startPoint.z = GetGroundHeight(startPoint, caster) + height
	return startPoint
end
function elite_125.prototype.PlayCastEffect(self, caster)
	local pfx = ParticleManager:CreateParticle(SHOCKWAVE_CAST_PARTICLE, PATTACH_POINT_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end
elite_125 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_125)
____exports.elite_125 = elite_125
return ____exports