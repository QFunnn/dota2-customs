--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_teleport_event = class({})

function modifier_teleport_event:Precache(context)
	PrecacheResource("particle", "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf", context)
end

function modifier_teleport_event:IsHidden()
	return true
end

function modifier_teleport_event:IsPurgable()
	return false
end

function modifier_teleport_event:CheckState()
	local state = {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_STUNNED] = true,
	}
	return state
end

function modifier_teleport_event:OnCreated()
	self.teleport_particle = ParticleManager:CreateParticle(
		"particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
end

function modifier_teleport_event:OnDestroy()
	ParticleManager:DestroyParticle(self.teleport_particle, false)
	ParticleManager:ReleaseParticleIndex(self.teleport_particle)
end