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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local CAST_POINT = 0.85
local CAST_DURATION = 1.2
local ANIMATION_SPEED = 0.4
local HIT_DISTANCE = 150
local AOE_RADIUS = 180
local DAMAGE_RATE = 15
local HAMMER_CHARGE_SOUND = "Hero_EarthShaker.Totem"
local HAMMER_IMPACT_SOUND = "Hero_Centaur.HoofStomp"
--- 精英技能5 - 近距离蓄力锤击地面，ability1 动作 0.2 速度，1.5s 命中造成范围伤害
____exports.elite_005 = __TS__Class()
local elite_005 = ____exports.elite_005
elite_005.name = "elite_005"
__TS__ClassExtends(elite_005, MonsterAbility_CS)
function elite_005.prototype.GetMosnterAbilityConfig(self)
	return {
		castRange = 380,
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		castAnimation = ACT_DOTA_ATTACK,
		animationPlaybackRate = ANIMATION_SPEED,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(150)), 0.35)
			self:Timer(0.35, function()
				EmitSoundOn(HAMMER_CHARGE_SOUND, caster)
				caster:StartGestureWithPlaybackRate(ACT_DOTA_ATTACK, 0.5)
				local hitPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(HIT_DISTANCE))
				self:WarningRingEffect(hitPos, AOE_RADIUS, CAST_POINT)
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			local targetPos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(HIT_DISTANCE))
			EmitSoundOnLocationWithCaster(targetPos, HAMMER_IMPACT_SOUND, caster)
			self:CreateEffect(targetPos)
			self:DamageArea(targetPos, AOE_RADIUS, DAMAGE_RATE)
		end,
	}
end
function elite_005.prototype.CreateEffect(self, origin)
	local effect = ParticleManager:CreateParticle(
		"particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect, 0, origin)
	ParticleManager:SetParticleControl(effect, 1, Vector(AOE_RADIUS, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect)
end
function elite_005.prototype.DamageArea(self, origin, radius, damageRate)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		origin,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
	__TS__ArrayForEach(enemies, function(____, enemy)
		caster:MonsterDamage({ victim = enemy, damage_rate = damageRate, ability = self })
	end)
end
elite_005 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_005)
____exports.elite_005 = elite_005
return ____exports