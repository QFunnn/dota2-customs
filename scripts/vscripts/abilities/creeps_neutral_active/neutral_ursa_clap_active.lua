--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ursa_clap_active_slow",
	"abilities/creeps_neutral_active/neutral_ursa_clap_active",
	LUA_MODIFIER_MOTION_NONE
)

neutral_ursa_clap_active = class({})

function neutral_ursa_clap_active:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/ursa_thunderclap.vpcf", context)
end

function neutral_ursa_clap_active:OnAbilityPhaseStart()
	self.caster:EmitSound("n_creep_Ursa.Clap")
	return true
end

function neutral_ursa_clap_active:OnSpellStart()
	local damage = self:GetSpecialValueFor("damage")
	local damage_health = self:GetSpecialValueFor("damage_health")
	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("aoe")

	local particle =
		ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self.caster)
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
			"modifier_ursa_clap_active_slow",
			{ duration = duration * (1 - target:GetStatusResistance()) }
		)
	end
end

modifier_ursa_clap_active_slow = class(mod_hidden)
function modifier_ursa_clap_active_slow:IsPurgable()
	return true
end
function modifier_ursa_clap_active_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_ursa_clap_active_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_ursa_clap_active_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end