--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


antimage_mana_void_custom = class({})

antimage_mana_void_custom.modifier_antimage_19_cooldown = {-15,-30}

function antimage_mana_void_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", 'particles/units/heroes/hero_antimage/antimage_manavoid.vpcf', context )
end

function antimage_mana_void_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_antimage_19") then
		bonus = self.modifier_antimage_19_cooldown[self:GetCaster():GetTalentLevel("modifier_antimage_19")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function antimage_mana_void_custom:GetAOERadius()
	return self:GetSpecialValueFor( "mana_void_aoe_radius" )
end

function antimage_mana_void_custom:OnAbilityPhaseStart( kv )
	self.target = self:GetCursorTarget()
	self.target:EmitSound("Hero_Antimage.ManaVoidCast")
	return true
end

function antimage_mana_void_custom:OnAbilityPhaseInterrupted()
	self.target:StopSound("Hero_Antimage.ManaVoidCast")
end

function antimage_mana_void_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end

	local mana_void_damage_per_mana = self:GetSpecialValueFor("mana_void_damage_per_mana")
	local mana_void_ministun = self:GetSpecialValueFor("mana_void_ministun")
	local radius = self:GetSpecialValueFor( "mana_void_aoe_radius" )

	target:AddNewModifier( caster, self, "modifier_stunned", { duration = mana_void_ministun * (1-target:GetStatusResistance()) } )
	self:DealDamage(target, mana_void_damage_per_mana, radius)
end

function antimage_mana_void_custom:DealDamage(target, damage, radius)
	if not IsServer() then return end

	local mana_damage = (target:GetMaxMana() - target:GetMana()) * damage

	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

	target:EmitSound("Hero_Antimage.ManaVoid")

	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_antimage/antimage_manavoid.vpcf", PATTACH_POINT_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( particle, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true )
	ParticleManager:SetParticleControl( particle, 1, Vector( radius, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( particle )

	for _,enemy in pairs(enemies) do
		ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = mana_damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
	end
end