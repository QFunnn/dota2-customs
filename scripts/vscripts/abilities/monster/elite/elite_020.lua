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
local CAST_POINT = 0.7
local CAST_DURATION = 0.8
local HIT_RANGE = 500
local HALF_ANGLE_DEG = 70
local DAMAGE_RATE = 20
local KNOCKBACK_DURATION = 0.3
local KNOCKBACK_DISTANCE = 220
local WARNING_START_WIDTH = 120
local WARNING_END_WIDTH = math.floor(2 * HIT_RANGE * math.sin(math.rad(HALF_ANGLE_DEG)))
local SHIELD_BASH_PARTICLE = "particles/units/heroes/hero_mars/mars_shield_bash.vpcf"
local SHIELD_BASH_HIT_PARTICLE = "particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf"
--- 精英技能20 - 马尔斯盾击形态：前方扇形伤害并击退
____exports.elite_020 = __TS__Class()
local elite_020 = ____exports.elite_020
elite_020.name = "elite_020"
__TS__ClassExtends(elite_020, MonsterAbility_CS)
function elite_020.prototype.Precache(self, context)
	PrecacheResource("particle", SHIELD_BASH_PARTICLE, context)
	PrecacheResource("particle", SHIELD_BASH_HIT_PARTICLE, context)
end
function elite_020.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = HIT_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		animationPlaybackRate = 0.6,
		castAnimation = ACT_DOTA_CAST_ABILITY_1,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = caster:GetAbsOrigin()
			local endPos = origin:__add(caster:GetForwardVector():__mul(200))
			local target = caster:GetMinDistanceUnit(HIT_RANGE)
			if target then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self:WarningEffect(origin, endPos, CAST_POINT + 0.1, {
				startWidth = WARNING_START_WIDTH,
				endWidth = WARNING_END_WIDTH / 1.8,
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
			caster:EmitSound("Hero_Mars.Shield.Cast")
			ScreenShake(caster:GetAbsOrigin(), 10, 10, 0.1, 1000, 0, true)
			self:PlayShieldBashEffect(caster)
			self:HitCone(caster)
		end,
	}
end
function elite_020.prototype.PlayShieldBashEffect(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local effect = ParticleManager:CreateParticle(SHIELD_BASH_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControlTransformForward(effect, 0, origin, forward)
	ParticleManager:SetParticleControl(effect, 1, Vector(HIT_RANGE, HIT_RANGE, HIT_RANGE))
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_020.prototype.HitCone(self, caster)
	local origin = caster:GetAbsOrigin()
	local forward = caster:GetForwardVector()
	local minDot = math.cos(math.rad(HALF_ANGLE_DEG))
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		HIT_RANGE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue12
			end
			local delta = enemy:GetAbsOrigin():__sub(origin)
			local dist2D = delta:Length2D()
			if dist2D <= 0.01 or dist2D > HIT_RANGE then
				goto __continue12
			end
			local dir = Vector(delta.x / dist2D, delta.y / dist2D, 0)
			local dot = forward.x * dir.x + forward.y * dir.y + forward.z * dir.z
			if dot < minDot then
				goto __continue12
			end
			caster:MonsterDamage({ victim = enemy, damage_rate = DAMAGE_RATE, ability = self })
			self:PlayShieldBashHitEffect(enemy, dir)
			enemy:KnockBack(caster, self, {
				duration = KNOCKBACK_DURATION,
				distance = KNOCKBACK_DISTANCE,
				direction = dir,
				destroyTreesType = "onDestroy",
				stun = true,
				stunDuration = 1.5,
			})
		end
		::__continue12::
	end
end
function elite_020.prototype.PlayShieldBashHitEffect(self, target, hitDir)
	local origin = target:GetAbsOrigin()
	local effect = ParticleManager:CreateParticle(SHIELD_BASH_HIT_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControlTransformForward(effect, 1, origin, hitDir)
	ParticleManager:ReleaseParticleIndex(effect)
end
elite_020 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_020)
____exports.elite_020 = elite_020
return ____exports