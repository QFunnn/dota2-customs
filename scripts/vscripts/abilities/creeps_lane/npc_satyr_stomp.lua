--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_stomp_break", "abilities/creeps_lane/npc_satyr_stomp", LUA_MODIFIER_MOTION_NONE)

npc_satyr_stomp = class({})

function npc_satyr_stomp:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf", context)
	PrecacheResource("particle", "particles/generic_gameplay/generic_break.vpcf", context)
end

function npc_satyr_stomp:Init()
	if not self:GetCaster() then
		return
	end
	self.caster = self:GetCaster()

	self.damage = self:GetLevelSpecialValueFor("damage", 1)
	self.duration = self:GetLevelSpecialValueFor("duration", 1)
	self.radius = self:GetLevelSpecialValueFor("radius", 1)
end

function npc_satyr_stomp:OnAbilityPhaseStart()
	if not IsServer() then
		return
	end
	self.caster:EmitSound("n_creep_Spawnlord.Stomp")
	return true
end

function npc_satyr_stomp:OnSpellStart()
	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/neutral_prowler_shaman_stomp.vpcf",
		PATTACH_ABSORIGIN,
		self.caster
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.caster:FindTargets(self.radius)) do
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
		target:AddNewModifier(
			self.caster,
			self,
			"modifier_stomp_break",
			{ duration = self.duration * (1 - target:GetStatusResistance()) }
		)
	end
end

modifier_stomp_break = class(mod_visible)
function modifier_stomp_break:GetEffectName()
	return "particles/generic_gameplay/generic_break.vpcf"
end
function modifier_stomp_break:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
function modifier_stomp_break:CheckState()
	return { [MODIFIER_STATE_PASSIVES_DISABLED] = true }
end