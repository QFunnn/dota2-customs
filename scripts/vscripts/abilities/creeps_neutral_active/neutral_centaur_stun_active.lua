--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


neutral_centaur_stun_active = class({})

function neutral_centaur_stun_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", context)
end

function neutral_centaur_stun_active:OnAbilityPhaseStart()
	self.caster:EmitSound("n_creep_Centaur.Stomp")
	return true
end

function neutral_centaur_stun_active:OnSpellStart()
	local damage = self:GetSpecialValueFor("damage")
	local damage_health = self:GetSpecialValueFor("damage_health")
	local stun = self:GetSpecialValueFor("stun")
	local radius = self:GetSpecialValueFor("aoe")

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.caster:FindTargets(radius)) do
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = damage + target:GetMaxHealth() * damage_health / 100,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_stunned",
			{ duration = stun * (1 - target:GetStatusResistance()) }
		)
	end
end