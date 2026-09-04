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
local modifier_elite_163_hit_guard
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerAbility = ____dota_ts_adapter.registerAbility
local registerModifier = ____dota_ts_adapter.registerModifier
local ____monster_base = require("abilities.monster.monster_base")
local MonsterAbility_CS = ____monster_base.MonsterAbility_CS
local ____modifier_base = require("modifiers.class.modifier_base")
local BaseModifier_CS = ____modifier_base.BaseModifier_CS
local CAST_POINT = 1.2
local CAST_DURATION = 0.5
local WAVE_COUNT = 6
local WAVE_DISTANCE = 1200
local WAVE_WIDTH = 80
local WAVE_SPEED = 1200
local WAVE_DAMAGE_RATE = 12
local HIT_GUARD_DURATION = 0.5
local WAVE_PARTICLE = "particles/magnataur_shockwave_red.vpcf"
--- 鸣喉震兽的教学版咤：只释放一轮六向声波。
____exports.elite_163 = __TS__Class()
local elite_163 = ____exports.elite_163
elite_163.name = "elite_163"
__TS__ClassExtends(elite_163, MonsterAbility_CS)
function elite_163.prototype.Precache(self, context)
	PrecacheResource("particle", WAVE_PARTICLE, context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf", context)
end
function elite_163.prototype.GetMosnterAbilityConfig(self)
	return {
		castPoint = CAST_POINT,
		castDuration = CAST_DURATION,
		behavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET,
		isNotMove = true,
		OnPhaseStart = function()
			return self:PlayPrepareEffects()
		end,
		OnStart = function()
			return self:ReleaseShockwaves()
		end,
		OnInterrupt = function()
			return self:ResetPrepareAnimation()
		end,
	}
end
function elite_163.prototype.PlayPrepareEffects(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:Timer(FrameTime(), function()
		if IsValidAlive(nil, caster) and caster:HasModifier("modifier_monster_cast_pre_progress") then
			caster:SetAnimation("dragonspawn_a_stun")
		end
	end)
	caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 1)
	caster:EmitSound("Hero_PrimalBeast.Uproar.Cast")
	local particle = ParticleManager:CreateParticle(
		"particles/world_outpost_dire_ambient_shockwave.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 1, caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)
end
function elite_163.prototype.ReleaseShockwaves(self)
	local caster = self:GetCaster()
	if not IsValidAlive(nil, caster) then
		return
	end
	self:ResetPrepareAnimation()
	caster:StartGestureWithPlaybackRate(ACT_DOTA_OVERRIDE_ABILITY_3, 1.2)
	caster:EmitSound("Hero_PrimalBeast.Uproar.Cast")
	local directions = GetRotateVectors(nil, caster:GetForwardVector(), WAVE_COUNT, 360 / WAVE_COUNT)
	do
		local index = 0
		while index < #directions do
			local currentDirection = directions[index + 1]
			self:CreateShockwave(caster, currentDirection)
			index = index + 1
		end
	end
	self:PlayReleaseEffects(caster)
end
function elite_163.prototype.ResetPrepareAnimation(self)
	local caster = self:GetCaster()
	if IsValidAlive(nil, caster) then
		caster:SetAnimation("dragonspawn_a_idle")
	end
end
function elite_163.prototype.CreateShockwave(self, caster, direction)
	local origin = caster:GetAbsOrigin()
	local target = origin:__add(direction:__mul(WAVE_DISTANCE))
	CreateProjectile(nil, {
		ability = self,
		caster = caster,
		effect_name = WAVE_PARTICLE,
		projectile_type = "linear",
		start_point = origin,
		target = target,
		projectile_speed = WAVE_SPEED,
		projectile_distance = WAVE_DISTANCE,
		projectile_range = WAVE_WIDTH,
		projectile_target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		projectile_target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		projectile_target_flags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		on_hit = function(____, hitTarget)
			if not hitTarget or not IsValidAlive(nil, hitTarget) then
				return true
			end
			if not modifier_elite_163_hit_guard:find_on(hitTarget) then
				if not IsValidAlive(nil, caster) then
					return
				end
				caster:MonsterDamage({ victim = hitTarget, damage_rate = WAVE_DAMAGE_RATE, ability = self })
				modifier_elite_163_hit_guard:applys(hitTarget, caster, self, { duration = HIT_GUARD_DURATION })
			end
			return false
		end,
	})
end
function elite_163.prototype.PlayReleaseEffects(self, caster)
	local areaParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_roar_aoe.vpcf",
		PATTACH_WORLDORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(areaParticle, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(areaParticle, 1, Vector(300, 300, 300))
	ParticleManager:ReleaseParticleIndex(areaParticle)
	local roarParticle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_primal_beast/primal_beast_roar.vpcf",
		PATTACH_CUSTOMORIGIN,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		roarParticle,
		0,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_loadout_roar",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(roarParticle)
end
elite_163 = __TS__DecorateLegacy({ registerAbility(nil) }, elite_163)
____exports.elite_163 = elite_163
--- 单轮声波的命中保护，避免贴身目标被多道投射物重复命中。
modifier_elite_163_hit_guard = __TS__Class()
modifier_elite_163_hit_guard.name = "modifier_elite_163_hit_guard"
__TS__ClassExtends(modifier_elite_163_hit_guard, BaseModifier_CS)
function modifier_elite_163_hit_guard.prototype.GetModifierConfig(self)
	return { isHidden = true, isDebuff = true, isPurgable = false }
end
modifier_elite_163_hit_guard = __TS__DecorateLegacy({ registerModifier(nil) }, modifier_elite_163_hit_guard)
return ____exports