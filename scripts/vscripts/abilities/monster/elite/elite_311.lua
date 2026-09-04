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
local CAST_POINT = 0.6
local ECHO_RADIUS = 620
local MAIN_DAMAGE_RATE = 5
local ECHO_DAMAGE_RATE_PER_HERO = 3
local ECHO_DAMAGE_RATE_PER_UNIT = 1
local SLOW_DURATION = 0.8
local SLOW_STACK = 4
local PULSE_PARTICLE = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
local START_PARTICLE = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
local ECHO_PARTICLE = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
____exports.elite_311 = __TS__Class()
local elite_311 = ____exports.elite_311
elite_311.name = "elite_311"
__TS__ClassExtends(elite_311, MonsterAbility_CS)
function elite_311.prototype.Precache(self, context)
	PrecacheResource("particle", PULSE_PARTICLE, context)
	PrecacheResource("particle", START_PARTICLE, context)
	PrecacheResource("particle", ECHO_PARTICLE, context)
end
function elite_311.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 1000,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castPoint = CAST_POINT,
		castDuration = 2,
		castAnimation = ACT_DOTA_CAST_ABILITY_6,
		cooldown = 14,
		OnPhaseStart = function()
			return self:WarningRingEffect(self:GetCaster():GetAbsOrigin(), ECHO_RADIUS, CAST_POINT + 1.2)
		end,
		OnStart = function()
			return self:EchoSlam()
		end,
	}
end
function elite_311.prototype.EchoSlam(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	EmitSoundOn("Hero_EarthShaker.EchoSlam", caster)
	self:PlayEchoStartEffect(caster)
	local origin = caster:GetAbsOrigin()
	local primaryTargets = self:FindEnemiesInRadius(origin, ECHO_RADIUS)
	self:PlayEchoPulseEffect(caster, origin, ECHO_RADIUS)
	for ____, target in ipairs(primaryTargets) do
		do
			if not IsValidAlive(nil, target) then
				goto __continue8
			end
			caster:MonsterDamage({
				victim = target,
				damage_rate = MAIN_DAMAGE_RATE,
				ability = self,
				effectName = PULSE_PARTICLE,
			})
			self:ApplySlow(target, caster)
		end
		::__continue8::
	end
	for ____, echoSource in ipairs(primaryTargets) do
		do
			if not IsValidAlive(nil, echoSource) then
				goto __continue11
			end
			local isHero = echoSource:IsHero() ~= nil and echoSource:IsHero()
			local echoDamageRate = isHero and ECHO_DAMAGE_RATE_PER_HERO or ECHO_DAMAGE_RATE_PER_UNIT
			local echoOrigin = echoSource:GetAbsOrigin()
			local echoTargets = self:FindEnemiesInRadius(echoOrigin, ECHO_RADIUS)
			for ____, echoTarget in ipairs(echoTargets) do
				do
					if echoTarget == echoSource then
						goto __continue13
					end
					if not IsValidAlive(nil, echoTarget) then
						goto __continue13
					end
					caster:MonsterDamage({
						victim = echoTarget,
						damage_rate = echoDamageRate,
						ability = self,
						effectName = ECHO_PARTICLE,
					})
					self:ApplySlow(echoTarget, caster)
				end
				::__continue13::
			end
		end
		::__continue11::
	end
end
function elite_311.prototype.FindEnemiesInRadius(self, origin, radius)
	return FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
end
function elite_311.prototype.PlayEchoStartEffect(self, caster)
	local particle = ParticleManager:CreateParticle(START_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_311.prototype.PlayEchoPulseEffect(self, caster, origin, radius)
	local particle = ParticleManager:CreateParticle(PULSE_PARTICLE, PATTACH_WORLDORIGIN, caster)
	ParticleManager:SetParticleControl(particle, 0, origin)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, 0))
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_311.prototype.ApplySlow(self, target, caster)
	if SLOW_DURATION <= 0 then
		return
	end
	AddDeBuffStatus(
		nil,
		target,
		caster,
		self,
		DebuffStatusType.ICE_SLOW,
		{ stack = SLOW_STACK, duration = SLOW_DURATION }
	)
end
elite_311 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_311)
____exports.elite_311 = elite_311
return ____exports