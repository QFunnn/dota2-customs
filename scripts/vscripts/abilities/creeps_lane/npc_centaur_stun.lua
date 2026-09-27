--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


npc_centaur_stun = class({})

function npc_centaur_stun:Precache(context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_has_quest.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_warstomp.vpcf", context)
end

function npc_centaur_stun:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
	self.stun = self:GetLevelSpecialValueFor("stun", 1)
end

function npc_centaur_stun:OnAbilityPhaseStart()
	self.sign = ParticleManager:CreateParticle(
		"particles/generic_gameplay/generic_has_quest.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self.caster
	)
	self.caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 0.6)

	self.zone_particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf",
		PATTACH_CUSTOMORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(self.zone_particle, 0, self.caster:GetOrigin())
	ParticleManager:SetParticleControl(self.zone_particle, 1, Vector(self.radius, 0, -self.radius))
	ParticleManager:SetParticleControl(self.zone_particle, 2, Vector(0.8, 0, 0))
	return true
end

function npc_centaur_stun:OnAbilityPhaseInterrupted()
	ParticleManager:Delete(self.sign, 2)
	ParticleManager:Delete(self.zone_particle, 2)
	self.caster:RemoveGesture(ACT_DOTA_CAST_ABILITY_1)
end

function npc_centaur_stun:OnSpellStart()
	ParticleManager:Delete(self.sign, 2)
	ParticleManager:Delete(self.zone_particle, 2)

	self.caster:EmitSound("Hero_Centaur.HoofStomp")

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_warstomp.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 0, self.caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(particle, 2, self.caster:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.caster:FindTargets(self.radius)) do
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_stunned",
			{ duration = self.stun * (1 - target:GetStatusResistance()) }
		)
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end
end