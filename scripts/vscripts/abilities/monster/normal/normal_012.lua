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
local CAST_POINT = 0.3
local CAST_DURATION = 0.35
local CAST_RANGE = 300
local HIT_DISTANCE = 200
local AOE_RADIUS = 140
local DAMAGE_RATE = 10
local IMPACT_PARTICLE = "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf"
local IMPACT_SOUND = "Hero_Ursa.Earthshock"
--- 普通技能12 - 地狱熊怪单手砸地，对前方小范围敌人造成伤害
____exports.normal_012 = __TS__Class()
local normal_012 = ____exports.normal_012
normal_012.name = "normal_012"
__TS__ClassExtends(normal_012, MonsterAbility_CS)
function normal_012.prototype.Precache(self, context)
	PrecacheResource("particle", IMPACT_PARTICLE, context)
end
function normal_012.prototype.GetMosnterAbilityConfig(self)
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
			local target = caster:GetMinDistanceUnit(CAST_RANGE)
			caster:LockTargetForSpeed(target, CAST_POINT)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			if not IsValidAlive(nil, caster) then
				return
			end
			local impactPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(HIT_DISTANCE))
			self:PlayImpact(impactPos)
			self:DamageArea(impactPos)
		end,
	}
end
function normal_012.prototype.PlayImpact(self, position)
	local caster = self:GetCaster()
	local effect = ParticleManager:CreateParticle(IMPACT_PARTICLE, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect, 0, position)
	ParticleManager:SetParticleControl(effect, 1, Vector(AOE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOnLocationWithCaster(position, IMPACT_SOUND, caster)
end
function normal_012.prototype.DamageArea(self, center)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		center,
		nil,
		AOE_RADIUS,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for ____, enemy in ipairs(enemies) do
		do
			if not IsValidAlive(nil, enemy) then
				goto __continue10
			end
			caster:MonsterDamage({
				victim = enemy,
				damage_rate = DAMAGE_RATE,
				ability = self,
				effectName = IMPACT_PARTICLE,
			})
		end
		::__continue10::
	end
end
normal_012 = __TS__DecorateLegacy({ registerAbility(nil) }, normal_012)
____exports.normal_012 = normal_012
return ____exports