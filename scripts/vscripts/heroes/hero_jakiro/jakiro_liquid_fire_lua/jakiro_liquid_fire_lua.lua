--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


jakiro_liquid_fire_lua = class({})
LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_jakiro_liquid_fire_lua",
	"heroes/hero_jakiro/jakiro_liquid_fire_lua/modifier_jakiro_liquid_fire_lua",
	LUA_MODIFIER_MOTION_NONE
)

function jakiro_liquid_fire_lua:GetIntrinsicModifierName()
	return "modifier_generic_orb_effect_lua"
end

function jakiro_liquid_fire_lua:OnSpellStart() end

function jakiro_liquid_fire_lua:GetCooldown(level)
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_jakiro_int3")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 5
	end
	return self.BaseClass.GetCooldown(self, level)
end

function jakiro_liquid_fire_lua:GetProjectileName()
	return "particles/units/heroes/hero_jakiro/jakiro_base_attack_fire.vpcf"
end

function jakiro_liquid_fire_lua:OnOrbFire(params)
	-- play effects
	local sound_cast = "Hero_Jakiro.LiquidFire"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function jakiro_liquid_fire_lua:OnOrbImpact(params)
	local caster = self:GetCaster()

	-- get data
	local duration = self:GetDuration()
	local radius = self:GetSpecialValueFor("radius")

	-- find enemy in radius
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(), -- int, your team number
		params.target:GetOrigin(), -- point, center point
		params.target, -- handle, cacheUnit. (not known)
		radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		-- add modifier
		enemy:AddNewModifier(
			caster, -- player source
			self, -- ability source
			"modifier_jakiro_liquid_fire_lua", -- modifier name
			{ duration = duration } -- kv
		)
	end

	-- play effects
	self:PlayEffects(params.target, radius)
end

function jakiro_liquid_fire_lua:PlayEffects(target, radius)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_explosion.vpcf"
	local sound_cast = "Hero_Jakiro.LiquidFire"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	EmitSoundOn(sound_cast, self:GetCaster())
end