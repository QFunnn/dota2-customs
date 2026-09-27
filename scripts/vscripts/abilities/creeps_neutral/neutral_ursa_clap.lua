--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ursa_clap", "abilities/creeps_neutral/neutral_ursa_clap", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ursa_clap_slow", "abilities/creeps_neutral/neutral_ursa_clap", LUA_MODIFIER_MOTION_NONE)

neutral_ursa_clap = class({})

function neutral_ursa_clap:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/ursa_thunderclap.vpcf", context)
end

function neutral_ursa_clap:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_ursa_clap"
end

modifier_ursa_clap = class(mod_hidden)
function modifier_ursa_clap:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	if IsServer() then
		self.ability:SetLevel(1)
	end

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.aoe = self.ability:GetSpecialValueFor("aoe")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.slow = self.ability:GetSpecialValueFor("slow")
end

function modifier_ursa_clap:StartCast(target)
	if not IsServer() then
		return
	end

	self.parent:EmitSound("n_creep_Ursa.Clap")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.4,
			anim = ACT_DOTA_CAST_ABILITY_1,
			effect = 1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_ursa_clap:EndCast()
	if not IsServer() then
		return
	end

	local particle =
		ParticleManager:CreateParticle("particles/neutral_fx/ursa_thunderclap.vpcf", PATTACH_ABSORIGIN, self.parent)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.aoe, 0, 0))
	ParticleManager:ReleaseParticleIndex(particle)

	for _, target in pairs(self.parent:FindTargets(self.ability.aoe)) do
		local damage = self.ability.damage + target:GetMaxHealth() * self.ability.damage_health / 100

		target:SendNumber(4, damage)
		DoDamage({
			victim = target,
			attacker = self.parent,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})
		target:AddNewModifier(
			self.parent,
			self.ability,
			"modifier_ursa_clap_slow",
			{ duration = self.ability.duration * (1 - target:GetStatusResistance()) }
		)
	end
end

modifier_ursa_clap_slow = class(mod_visible)
function modifier_ursa_clap_slow:IsPurgable()
	return true
end
function modifier_ursa_clap_slow:OnCreated()
	self.ability = self:GetAbility()

	self.slow = self.ability.slow
end

function modifier_ursa_clap_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_ursa_clap_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end