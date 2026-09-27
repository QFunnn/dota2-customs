--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


neutral_harpy_strike_active = class({})

function neutral_harpy_strike_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/harpy_chain_lightning.vpcf", context)
end

function neutral_harpy_strike_active:OnSpellStart()
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb(self) then
		return
	end

	self.caster:EmitSound("n_creep_HarpyStorm.ChainLighting")

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/harpy_chain_lightning.vpcf",
		PATTACH_POINT_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	local damage = self:GetSpecialValueFor("damage")
		+ target:GetMaxHealth() * self:GetSpecialValueFor("damage_health") / 100

	DoDamage({
		victim = target,
		attacker = self.caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})
	target:SendNumber(4, damage)
end