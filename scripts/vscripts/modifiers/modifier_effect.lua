--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_effect = class({})

function modifier_effect:IsHidden()
	return true
end

function modifier_effect:IsPurgable()
	return false
end

function modifier_effect:IsPermanent()
	return true
end

function modifier_effect:RemoveOnDeath()
	return false
end

function modifier_effect:OnCreated(data)
	self.caster = self:GetCaster()
	self.particleLeader = ParticleManager:CreateParticle(data.effect, PATTACH_POINT_FOLLOW, self.caster)
	ParticleManager:SetParticleControlEnt(
		self.particleLeader,
		PATTACH_OVERHEAD_FOLLOW,
		self.caster,
		PATTACH_OVERHEAD_FOLLOW,
		"follow_overhead",
		self.caster:GetAbsOrigin(),
		true
	)
end

function modifier_effect:OnDestroy(kv)
	ParticleManager:DestroyParticle(self.particleLeader, true)
	ParticleManager:ReleaseParticleIndex(self.particleLeader)
end