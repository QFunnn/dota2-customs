--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


spider_nethertoxin_lua = class({}) ---@class spider_nethertoxin_lua : CDOTA_Ability_Lua
LinkLuaModifier("modifier_spider_nethertoxin_lua", "creature_ability/modifier/modifier_spider_nethertoxin_lua",
	LUA_MODIFIER_MOTION_NONE)

function spider_nethertoxin_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function spider_nethertoxin_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector = point - caster:GetOrigin()

	local projectile_name = ""
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = vector:Length2D()
	local projectile_direction = vector
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,

		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = 0,
		fEndRadius = 0,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	self:PlayEffects(point)
end

function spider_nethertoxin_lua:OnProjectileHit(target, location)
	if target then return false end

	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		self:GetCaster(),            -- player source
		self,                        -- ability source
		"modifier_spider_nethertoxin_lua", -- modifier name
		{ duration = duration },     -- kv
		location,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

------------------------------------------------------------------------------
function spider_nethertoxin_lua:PlayEffects(point)
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_proj.vpcf"
	local sound_cast = "Hero_Viper.Nethertoxin.Cast"

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0), -- unknown
		true     -- unknown, true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(projectile_speed, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 5, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end