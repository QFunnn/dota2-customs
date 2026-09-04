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
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local ABYSSAL_METEOR_FALL_HEIGHT = 1500
local ABYSSAL_METEOR_FALL_DURATION = 0.5
local ABYSSAL_METEOR_SPAWN_DELAY = 0.4
local ABYSSAL_METEOR_INTERVAL = 0.2
local ABYSSAL_METEOR_COUNT = 3
local ABYSSAL_METEOR_WARNING_DURATION = ABYSSAL_METEOR_SPAWN_DELAY + ABYSSAL_METEOR_FALL_DURATION
local ABYSSAL_METEOR_MODIFIER_DURATION = (ABYSSAL_METEOR_COUNT - 1) * ABYSSAL_METEOR_INTERVAL
	+ ABYSSAL_METEOR_WARNING_DURATION
	+ 0.1
local ABYSSAL_METEOR_IMPACT_SOUND = "DOTA_Item.MeteorHammer.Impact"
local ABYSSAL_METEOR_PARTICLE = "particles/items4_fx/meteor_hammer_spell.vpcf"
local ABYSSAL_METEOR_CAST_FLASH_PARTICLE =
	"particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile_blue_impact_flash_core.vpcf"
--- 深渊领主-流星雨 (boss_abyssal_1)
-- 旧版: fly_pfx
____exports.boss_abyssal_1 = __TS__Class()
local boss_abyssal_1 = ____exports.boss_abyssal_1
boss_abyssal_1.name = "boss_abyssal_1"
__TS__ClassExtends(boss_abyssal_1, MonsterAbility_CS)
function boss_abyssal_1.prototype.Precache(self, context)
	PrecacheResource("particle", ABYSSAL_METEOR_PARTICLE, context)
	PrecacheResource("particle", ABYSSAL_METEOR_CAST_FLASH_PARTICLE, context)
end
function boss_abyssal_1.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = 1,
		castDuration = 1.8,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		castAnimation = ACT_DOTA_CAST_ABILITY_4,
		animationPlaybackRate = 0.6,
		castRange = function()
			return 1000
		end,
		OnPhaseStart = function()
			local caster = self:GetCaster()
			local origin = caster:GetAbsOrigin()
			caster:Mover(origin:__add(caster:GetForwardVector():__mul(-200)), 0.3)
			self:Timer(0.3, function()
				local origin = caster:GetAbsOrigin()
				self:WarningEffect(origin, origin:__add(caster:GetForwardVector():__mul(400)), 1.2, {
					startWidth = 238,
					endWidth = 628,
					getDirection = function()
						return caster:GetForwardVector()
					end,
				})
			end)
		end,
		OnStart = function()
			local caster = self:GetCaster()
			ScreenShake(caster:GetAbsOrigin(), 5, 5, 0.1, 2500, 0, true)
			____exports.modifier_boss_abyssal_1_pre:applys(
				caster,
				caster,
				self,
				{ duration = ABYSSAL_METEOR_MODIFIER_DURATION }
			)
		end,
	}
end
boss_abyssal_1 = __TS__DecorateLegacy({ registerAbility(nil) }, boss_abyssal_1)
____exports.boss_abyssal_1 = boss_abyssal_1
____exports.modifier_boss_abyssal_1_pre = __TS__Class()
local modifier_boss_abyssal_1_pre = ____exports.modifier_boss_abyssal_1_pre
modifier_boss_abyssal_1_pre.name = "modifier_boss_abyssal_1_pre"
__TS__ClassExtends(modifier_boss_abyssal_1_pre, BaseModifier_CS)
function modifier_boss_abyssal_1_pre.prototype.____constructor(self, ...)
	BaseModifier_CS.prototype.____constructor(self, ...)
	self.num = 0
end
function modifier_boss_abyssal_1_pre.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local fow = caster:GetForwardVector()
	__TS__ArrayForEach(GetRotateVectors(nil, fow, 3, 35), function(____, dir)
		return self:playMeteorEffect(dir)
	end)
	Timers:CreateTimer(0.2, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local particle =
			ParticleManager:CreateParticle(ABYSSAL_METEOR_CAST_FLASH_PARTICLE, PATTACH_ABSORIGIN_FOLLOW, caster)
		ParticleManager:SetParticleShouldCheckFoW(particle, false)
		ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
		ParticleManager:ReleaseParticleIndex(particle)
	end)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_2, 0.75)
end
function modifier_boss_abyssal_1_pre.prototype.playMeteorEffect(self, fow)
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if not IsValidAlive(nil, caster) or not ability then
		return
	end
	self:Timer(0.45, function()
		return ScreenShake(caster:GetAbsOrigin(), 15, 15, 0.2, 2500, 0, true)
	end)
	local n = 0
	self:Timer(0, function()
		if not IsValidAlive(nil, caster) then
			return
		end
		local hit_p = caster:GetOrigin():__add(fow:__mul(500 * n + 450))
		self:GetAbility():WarningRingEffect(hit_p, 280, ABYSSAL_METEOR_WARNING_DURATION)
		local function damageFunc(____, victim, damageRate, isTrue)
			if isTrue == nil then
				isTrue = true
			end
			caster:MonsterDamage({ victim = victim, damage_rate = damageRate, ability = ability })
			if not isTrue then
				if not IsValidAlive(nil, victim) then
					return
				end
				victim:KnockBack(caster, ability, { duration = 0.1, stun = true, stunDuration = 0.1, distance = 0 })
				return
			end
			victim:KnockBack(caster, ability, {
				duration = 0.2,
				stun = true,
				stunDuration = 1,
				distance = 0,
				height = 100,
			})
		end
		self:Timer(ABYSSAL_METEOR_SPAWN_DELAY, function()
			if not IsValidAlive(nil, caster) then
				return
			end
			local particle = ParticleManager:CreateParticle(ABYSSAL_METEOR_PARTICLE, PATTACH_WORLDORIGIN, nil)
			ParticleManager:SetParticleShouldCheckFoW(particle, false)
			ParticleManager:SetParticleControl(particle, 0, hit_p:__add(Vector(0, 0, ABYSSAL_METEOR_FALL_HEIGHT)))
			ParticleManager:SetParticleControl(particle, 1, hit_p)
			ParticleManager:SetParticleControl(particle, 2, Vector(ABYSSAL_METEOR_FALL_DURATION, 0, 0))
			ParticleManager:ReleaseParticleIndex(particle)
			local enemies = FindUnitsInRadius(
				caster:GetTeamNumber(),
				hit_p,
				nil,
				250,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
				0,
				0,
				false
			)
			__TS__ArrayForEach(enemies, function(____, target)
				return damageFunc(nil, target, 15, false)
			end)
			Timers:CreateTimer(ABYSSAL_METEOR_FALL_DURATION, function()
				if not IsValidAlive(nil, caster) then
					return
				end
				EmitSoundOnLocationWithCaster(hit_p, ABYSSAL_METEOR_IMPACT_SOUND, caster)
				local enemies2 = FindUnitsInRadius(
					caster:GetTeamNumber(),
					hit_p,
					nil,
					280,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					0,
					0,
					false
				)
				__TS__ArrayForEach(enemies2, function(____, target)
					return damageFunc(nil, target, 25)
				end)
			end)
		end)
		n = n + 1
		if n < ABYSSAL_METEOR_COUNT then
			return ABYSSAL_METEOR_INTERVAL
		end
	end)
end
modifier_boss_abyssal_1_pre = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_boss_abyssal_1_pre)
____exports.modifier_boss_abyssal_1_pre = modifier_boss_abyssal_1_pre
return ____exports