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
--- 混沌-2连斩 (boss_chaos_3)
local px1 = "particles/units/monster/monster12009/monster_12009_hit.vpcf"
local PORTAL_PFX = "particles/econ/items/underlord/underlord_2021_immortal/underlord_2021_immortal_portal_buildup.vpcf"
local AbilityDuration = 4.2
local AbilityFirstRange = 400
local AbilitySecondRange = 550
local AbilityFirstDamageRate = 20
local AbilitySecondDamageRate = 30
local AbilityJumpHeight = 400
local AbilityJumpDistance = 550
____exports.boss_chaos_3 = __TS__Class()
local boss_chaos_3 = ____exports.boss_chaos_3
boss_chaos_3.name = "boss_chaos_3"
__TS__ClassExtends(boss_chaos_3, MonsterAbility_CS)
function boss_chaos_3.prototype.____constructor(self, ...)
	MonsterAbility_CS.prototype.____constructor(self, ...)
	self.dis1 = 1260
	self.dis2 = 500
	self.speed = 1.3
	self.damage = 1.2
end
function boss_chaos_3.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 0.3,
		castDuration = AbilityDuration,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_2,
		animationPlaybackRate = 0.95,
		OnStart = function()
			local caster = self:GetCaster()
			caster:StartGesture(ACT_DOTA_CAST_ABILITY_2)
			self:playPortalBuildup(caster, 1)
			self:Timer(0.8 / self.speed, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:Mover(caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(100)), 0.7 / self.speed)
			end)
			caster:LockTargetForSpeed(caster:GetMinDistanceUnit(2500), 0.8)
			self:Timer(1.3, function()
				self:smallExplosion(caster)
				self:Timer(0.15, function()
					caster:LockTargetForSpeed(caster:GetMinDistanceUnit(2500), 0.6, 6)
				end)
			end)
			self:Timer(1.9, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				local cos = caster:GetAbsOrigin()
				local distance = caster:AiDistance(caster:GetMinDistanceUnit(2500), 650, 650, -50, 50)
				local height = cos:__add(caster:GetForwardVector():__mul(distance))
					:__add(Vector(0, 0, AbilityJumpHeight))
				local pos = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(distance - 50))
				caster:Bezier2Mover({ cos, height, pos }, 0.8, nil, true, true)
			end)
			self:Timer(2.8, function()
				self:smallExplosion(caster)
				self:Timer(0.3, function()
					self:bigExplosion(caster)
				end)
			end)
		end,
	}
end
function boss_chaos_3.prototype.smallExplosion(self, caster)
	if not IsValidAlive(nil, caster) then
		return
	end
	local particlePoint = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(250))
	EmitSoundOnLocationWithCaster(particlePoint, "Hero_PrimalBeast.RockThrow.Impact", caster)
	local pfx_portal = ParticleManager:CreateParticle(px1, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(pfx_portal, 0, particlePoint)
	ParticleManager:SetParticleControl(pfx_portal, 1, Vector(AbilityFirstRange, AbilityFirstRange, 0))
	ParticleManager:ReleaseParticleIndex(pfx_portal)
	__TS__ArrayForEach(self:findEnemies(particlePoint, AbilityFirstRange), function(____, enemy)
		if not IsValidAlive(nil, enemy) then
			return
		end
		caster:MonsterDamage({ victim = enemy, damage_rate = AbilityFirstDamageRate, ability = self })
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 0.15 })
	end)
end
function boss_chaos_3.prototype.bigExplosion(self, caster)
	local particlePoint = caster:GetAbsOrigin():__add(caster:GetForwardVector():__mul(250))
	EmitSoundOnLocationWithCaster(particlePoint, "Hero_PrimalBeast.RockThrow.Impact", caster)
	EmitSoundOnLocationWithCaster(particlePoint, "Hero_PrimalBeast.Pulverize.ImpactLayer", caster)
	local pfx_portal = ParticleManager:CreateParticle(px1, PATTACH_POINT, caster)
	ParticleManager:SetParticleControl(pfx_portal, 0, particlePoint)
	ParticleManager:SetParticleControl(pfx_portal, 1, Vector(AbilitySecondRange, AbilitySecondRange, 0))
	ParticleManager:ReleaseParticleIndex(pfx_portal)
	__TS__ArrayForEach(self:findEnemies(particlePoint, AbilitySecondRange), function(____, enemy)
		if not IsValidAlive(nil, enemy) then
			return
		end
		caster:MonsterDamage({ victim = enemy, damage_rate = AbilitySecondDamageRate, ability = self })
		AddDeBuffStatus(nil, enemy, caster, self, DebuffStatusType.STUN, { duration = 1.5 })
	end)
end
function boss_chaos_3.prototype.playPortalBuildup(self, caster, duration)
	local pfx = ParticleManager:CreateParticle(PORTAL_PFX, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(
		pfx,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	Timers:CreateTimer(duration, function()
		ParticleManager:DestroyParticle(pfx, false)
		ParticleManager:ReleaseParticleIndex(pfx)
	end)
end
function boss_chaos_3.prototype.findEnemies(self, center, radius)
	return FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		center,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		0,
		false
	)
end
boss_chaos_3 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_chaos_3)
____exports.boss_chaos_3 = boss_chaos_3
return ____exports