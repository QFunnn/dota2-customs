--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_centaur_stun", "abilities/creeps_neutral/neutral_centaur_stun", LUA_MODIFIER_MOTION_NONE)

neutral_centaur_stun = class({})

function neutral_centaur_stun:Precache(context)
	PrecacheResource("particle", "particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf", context)
end

function neutral_centaur_stun:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_centaur_stun"
end

modifier_centaur_stun = class(mod_hidden)
function modifier_centaur_stun:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability:SetLevel(1)

	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.stun = self.ability:GetSpecialValueFor("stun")
	self.ability.aoe = self.ability:GetSpecialValueFor("aoe")
	self.ability.shared_cd = self.ability:GetSpecialValueFor("shared_cd")
end

function modifier_centaur_stun:StartCast(target)
	if not IsServer() then
		return
	end
	if target and target:IsStunned() then
		return
	end

	for _, ally in pairs(self.parent:FindFriends(1000)) do
		if ally ~= self.parent then
			local ability = ally:FindAbilityByName(self.ability:GetAbilityName())
			if ability then
				local cd = ally:FindModifierByName("modifier_neutral_cast_cd")
				if not cd or cd:GetRemainingTime() < self.ability.shared_cd then
					ally:AddNewModifier(
						ally,
						ability,
						"modifier_neutral_cast_cd",
						{ duration = self.ability.shared_cd }
					)
				end
			end
		end
	end

	self.parent:EmitSound("n_creep_Centaur.Stomp")
	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.5,
			anim = ACT_DOTA_CAST_ABILITY_1,
			effect = 1,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_centaur_stun:EndCast()
	if not IsServer() then
		return
	end

	local particle = ParticleManager:CreateParticle(
		"particles/neutral_fx/neutral_centaur_khan_war_stomp.vpcf",
		PATTACH_ABSORIGIN,
		self.parent
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(self.ability.aoe, self.ability.aoe, self.ability.aoe))
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
			"modifier_stunned",
			{ duration = self.ability.stun * (1 - target:GetStatusResistance()) }
		)
	end
end