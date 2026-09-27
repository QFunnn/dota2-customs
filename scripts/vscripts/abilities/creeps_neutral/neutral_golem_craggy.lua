--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_golem_craggy", "abilities/creeps_neutral/neutral_golem_craggy", LUA_MODIFIER_MOTION_NONE)

neutral_golem_craggy = class({})

function neutral_golem_craggy:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_centaur/centaur_return.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context)
end

function neutral_golem_craggy:GetIntrinsicModifierName()
	return "modifier_golem_craggy"
end

modifier_golem_craggy = class(mod_hidden)
function modifier_golem_craggy:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.reflect = self.ability:GetSpecialValueFor("reflect") / 100
	self.ability.chance = self.ability:GetSpecialValueFor("chance")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.cd = self.ability:GetSpecialValueFor("cd")

	self.parent:AddDamageEvent_inc(self, true)
end

function modifier_golem_craggy:DamageEvent_inc(params)
	if not IsServer() then
		return
	end
	if self.parent ~= params.unit then
		return
	end
	if not IsValid(params.attacker) or not params.attacker:IsUnit() then
		return
	end
	if params.attacker == self.parent then
		return
	end
	if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
		return
	end

	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_centaur/centaur_return.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		params.attacker,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		params.attacker:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	if params.attacker:IsHero() then
		params.attacker:EmitSound("Hero_Centaur.Retaliate.Target")
	end

	DoDamage({
		victim = params.attacker,
		attacker = self.parent,
		damage = params.original_damage * self.ability.reflect,
		damage_type = params.damage_type,
		damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK
			+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
			+ DOTA_DAMAGE_FLAG_REFLECTION,
		ability = self.ability,
	})

	if not params.attacker:IsAlive() then
		return
	end
	if params.attacker:HasCd("neutral_golem_craggy", self.ability.cd) then
		return
	end
	if not RollPseudoRandomPercentage(self.ability.chance, 1522, self.parent) then
		return
	end

	params.attacker:StartCd("neutral_golem_craggy", self.ability.cd)
	params.attacker:EmitSound("BB.Goo_stun")
	params.attacker:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_bashed",
		{ duration = self.ability.duration * (1 - params.attacker:GetStatusResistance()) }
	)
end