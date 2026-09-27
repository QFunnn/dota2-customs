--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_harpy_strike", "abilities/creeps_neutral/neutral_harpy_strike", LUA_MODIFIER_MOTION_NONE)

neutral_harpy_strike = class({})

function neutral_harpy_strike:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/harpy_chain_lightning.vpcf", context)
end

function neutral_harpy_strike:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_harpy_strike"
end

modifier_harpy_strike = class(mod_hidden)
function modifier_harpy_strike:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
end

function modifier_harpy_strike:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = target

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.3,
			anim = ACT_DOTA_CAST_ABILITY_1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_harpy_strike:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end
	if self.target:TriggerSpellAbsorb(self.ability) then
		return
	end

	self.parent:EmitSound("n_creep_HarpyStorm.ChainLighting")

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/harpy_chain_lightning.vpcf",
		PATTACH_POINT_FOLLOW,
		self.parent
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.target:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		self.parent:GetAbsOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(particle)

	local damage = self.ability.damage + self.target:GetMaxHealth() * self.ability.damage_health / 100

	DoDamage({
		victim = self.target,
		attacker = self.parent,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self.ability,
	})
	self.target:SendNumber(4, damage)
end