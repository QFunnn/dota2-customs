--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


chen_creep_blink = class({})

function chen_creep_blink:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "particle", 'particles/creep_particles/creep_blink_start.vpcf', context )
	PrecacheResource( "particle", 'particles/creep_particles/creep_blink_end.vpcf', context )
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_chen.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_chen.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_chen.vpcf", context)
end

function chen_creep_blink:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetOrigin()
	local blink_range = self:GetSpecialValueFor("blink_range") + self:GetCaster():GetCastRangeBonus()

	local direction = (point - origin)

	direction.z = 0

	if direction:Length2D() > blink_range then
		direction = direction:Normalized() * blink_range
	end

	local particle_start = ParticleManager:CreateParticle( "particles/creep_particles/creep_blink_start.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( particle_start, 0, origin )
	ParticleManager:SetParticleControlForward( particle_start, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_start )

	EmitSoundOnLocationWithCaster( origin, "Hero_Antimage.Blink_out", self:GetCaster() )

	ProjectileManager:ProjectileDodge(self:GetCaster())

	FindClearSpaceForUnit( caster, origin + direction, true )

	ProjectileManager:ProjectileDodge(self:GetCaster())

	local particle_end = ParticleManager:CreateParticle( "particles/creep_particles/creep_blink_end.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( particle_end, 0, self:GetCaster():GetOrigin() )
	ParticleManager:SetParticleControlForward( particle_end, 0, direction:Normalized() )
	ParticleManager:ReleaseParticleIndex( particle_end )

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Antimage.Blink_in", self:GetCaster() )
end