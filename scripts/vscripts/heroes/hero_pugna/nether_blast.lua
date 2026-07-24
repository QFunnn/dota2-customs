--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ability_pugna_nether_blast_thinker", "heroes/hero_pugna/nether_blast.lua", LUA_MODIFIER_MOTION_NONE )

if ability_pugna_nether_blast == nil then
	ability_pugna_nether_blast = class({})
end

function ability_pugna_nether_blast:OnSpellStart()
	local CastPosition = self:GetCursorPosition()

	self:CreateBlast(CastPosition, 1)
end

function ability_pugna_nether_blast:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function ability_pugna_nether_blast:CreateBlast(Position, is_first)
	local caster = self:GetCaster()
	local Delay = self:GetSpecialValueFor("delay")

	CreateModifierThinker(
		caster, 
		self, 
		"modifier_ability_pugna_nether_blast_thinker", 
		{
			duration = Delay,
			is_first = is_first
		}, 
		Position, 
		caster:GetTeamNumber(), 
		false
	)
end

modifier_ability_pugna_nether_blast_thinker = class({
    IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,
	GetAttributes			= function(self) return MODIFIER_ATTRIBUTE_MULTIPLE end,

	OnCreated				= function(self, table)
		local ability = self:GetAbility()
		if ability then
			self.Damage = ability:GetSpecialValueFor("blast_damage")
			self.Radius = ability:GetSpecialValueFor("radius")
		end

		if not IsServer() then return end

		self.bIsFirst = table.is_first == 1

		local parent = self:GetParent()
		local caster = self:GetCaster()
		if not parent or parent:IsNull() or not parent:IsAlive() or not caster or caster:IsNull() then return end

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_netherblast_pre.vpcf", PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(fx, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(fx, 1, Vector(self.Radius, self:GetDuration(), 1))
		ParticleManager:ReleaseParticleIndex(fx)

		caster:EmitSound("Hero_Pugna.NetherBlastPreCast")
	end,

	OnDestroy				= function(self)
		if not IsServer() then return end

		local parent = self:GetParent()
		local caster = self:GetCaster()
		local ability = self:GetAbility()
		if not parent or parent:IsNull() or not parent:IsAlive() or not caster or not ability or caster:IsNull() or ability:IsNull() then return end

		local All = FindUnitsInRadius(
			caster:GetTeamNumber(), 
			parent:GetAbsOrigin(), 
			nil, 
			self.Radius, 
			DOTA_UNIT_TARGET_TEAM_ENEMY, 
			DOTA_UNIT_TARGET_HEROES_AND_CREEPS, 
			DOTA_UNIT_TARGET_FLAG_NONE, 
			FIND_ANY_ORDER, 
			false
		)

		for _, unit in ipairs(All) do
			ApplyDamage({
				victim = unit, 
				attacker = caster, 
				damage = self.Damage, 
				damage_type = DAMAGE_TYPE_MAGICAL, 
				ability = ability
			})
		end

		if self.bIsFirst and ability.CreateBlast then
			ability:CreateBlast(parent:GetAbsOrigin())
		end

		local fx = ParticleManager:CreateParticle("particles/units/heroes/hero_pugna/pugna_netherblast.vpcf", PATTACH_WORLDORIGIN, caster)
		ParticleManager:SetParticleControl(fx, 0, parent:GetAbsOrigin())
		ParticleManager:SetParticleControl(fx, 1, Vector(self.Radius, 0, 0))
		ParticleManager:ReleaseParticleIndex(fx)

		caster:EmitSound("Hero_Pugna.NetherBlast")
	end,
})