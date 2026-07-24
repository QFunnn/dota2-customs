--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


crystal_maiden_mana_blade = class({})

function crystal_maiden_mana_blade:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf', context )
end

function crystal_maiden_mana_blade:GetManaCost(iLevel)
	local mana = self:GetCaster():GetMana() / 100 * self:GetSpecialValueFor("manacost")
	return mana
end

function crystal_maiden_mana_blade:OnAbilityPhaseStart()
	self.damage_mana = self:GetEffectiveManaCost(self:GetLevel())
	return true
end

function crystal_maiden_mana_blade:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local damage = self.damage_mana
	if target:TriggerSpellAbsorb( self ) then return end
	local units = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), target:GetAbsOrigin(), self:GetCaster(), 125, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0)
	for _,target_ob in pairs(units) do
		if target_ob ~= target then
			ApplyDamage( { victim = target_ob, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
		end
	end
	ApplyDamage( { victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
	self:PlayEffects( target )
end

function crystal_maiden_mana_blade:PlayEffects( target )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", PATTACH_CUSTOMORIGIN, nil )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	self:GetCaster():EmitSound("Ability.LagunaBladeImpact")
end