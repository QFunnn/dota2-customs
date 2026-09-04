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
local AIM_CAST_POINT = 0.5
local CAST_RANGE = 1600
local EXPLOSION_DELAY = 1
local CAST_POINT = AIM_CAST_POINT + EXPLOSION_DELAY
local CAST_DURATION = 0.1
local EXPLOSION_RADIUS = 260
local DAMAGE_RATE = 25
local EXPLOSION_PARTICLE = "particles/units/heroes/hero_leshrac/leshrac_split_earth.vpcf"
local CAST_SOUND = "Hero_Leshrac.Split_Earth"
local IMPACT_SOUND = "Hero_Invoker.SunStrike.Ignite"
--- 精英技能38 - 蓄力后在最近敌人脚下生成延迟爆炸预警
____exports.elite_038 = __TS__Class()
local elite_038 = ____exports.elite_038
elite_038.name = "elite_038"
__TS__ClassExtends(elite_038, MonsterAbility_CS)
function elite_038.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.castToken = 0
end
function elite_038.prototype.Precache(self, context)
	PrecacheResource("particle", EXPLOSION_PARTICLE, context)
end
function elite_038.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = CAST_RANGE,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
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
			self.castToken = self.castToken + 1
			local token = self.castToken
			self.explosionOrigin = nil
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			if IsValidAlive(nil, target) then
				caster:LockTargetForSpeed(target, CAST_POINT)
			end
			self:Timer(AIM_CAST_POINT, function()
				if token ~= self.castToken or not IsValidAlive(nil, caster) then
					return
				end
				local warningTarget = caster:GetMinDistanceUnit(CAST_RANGE)
				if not IsValidAlive(nil, warningTarget) then
					return
				end
				local origin = GetGroundPosition(warningTarget:GetAbsOrigin(), caster)
				self.explosionOrigin = origin
				self:WarningRingEffect(origin, EXPLOSION_RADIUS, EXPLOSION_DELAY)
				EmitSoundOnLocationWithCaster(origin, CAST_SOUND, caster)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local origin = self.explosionOrigin or self:GetFallbackExplosionOrigin(caster)
			if origin == nil then
				return
			end
			self:Explode(origin)
		end,
		OnInterrupt = function()
			return self:ClearPendingExplosion()
		end,
		OnFinish = function()
			return self:ClearPendingExplosion()
		end,
	}
end
function elite_038.prototype.GetFallbackExplosionOrigin(self, caster)
	local target = caster:GetMinDistanceUnit(CAST_RANGE)
	if not IsValidAlive(nil, target) then
		return nil
	end
	return GetGroundPosition(target:GetAbsOrigin(), caster)
end
function elite_038.prototype.ClearPendingExplosion(self)
	self.castToken = self.castToken + 1
	self.explosionOrigin = nil
end
function elite_038.prototype.Explode(self, origin)
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
elite_038 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_038)
____exports.elite_038 = elite_038
return ____exports