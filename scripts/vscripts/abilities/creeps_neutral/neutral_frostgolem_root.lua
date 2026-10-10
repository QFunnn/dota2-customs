--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_frostgolem_root_ability",
	"abilities/creeps_neutral/neutral_frostgolem_root",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_frostbitten_thinker",
	"abilities/creeps_neutral/neutral_frostgolem_root",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frostgolem_root = class({})

function neutral_frostgolem_root:Precache(context)
	PrecacheResource("particle", "particles/creeps/frostbitten_strike.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		context
	)
	PrecacheResource("particle", "particles/items3_fx/octarine_core_lifesteal.vpcf", context)
end

function neutral_frostgolem_root:GetIntrinsicModifierName()
	if not self:GetCaster():IsCreep() then
		return
	end
	return "modifier_frostgolem_root_ability"
end

modifier_frostgolem_root_ability = class(mod_hidden)
function modifier_frostgolem_root_ability:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability.delay = self.ability:GetSpecialValueFor("delay")
	self.ability.damage = self.ability:GetSpecialValueFor("damage")
	self.ability.damage_health = self.ability:GetSpecialValueFor("damage_health")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.cd_inc = self.ability:GetSpecialValueFor("cd_inc")
	self.ability.heal = self.ability:GetSpecialValueFor("heal")
	self.ability.heal_radius = self.ability:GetSpecialValueFor("heal_radius")
end

function modifier_frostgolem_root_ability:StartCast(target)
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
			duration = 0.7,
			effect = 1,
			anim = ACT_DOTA_CAST_ABILITY_3,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_frostgolem_root_ability:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end

	CreateModifierThinker(
		self.parent,
		self.ability,
		"modifier_frostbitten_thinker",
		{ duration = self.ability.delay },
		self.target:GetAbsOrigin(),
		self.parent:GetTeamNumber(),
		false
	)
end

modifier_frostbitten_thinker = class(mod_hidden)
function modifier_frostbitten_thinker:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	self.damage = self.ability.damage
	self.damage_health = self.ability.damage_health
	self.radius = self.ability.radius
	self.cd_inc = self.ability.cd_inc
	self.heal = self.ability.heal
	self.heal_radius = self.ability.heal_radius

	local time = self:GetRemainingTime()

	local particle =
		ParticleManager:CreateParticle("particles/generic/red_zone.vpcf", PATTACH_CUSTOMORIGIN, self.parent)
	ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 0, -self.radius / time))
	ParticleManager:SetParticleControl(particle, 2, Vector(time, 0, 0))
	self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_frostbitten_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	if not IsValid(self.caster) then
		return
	end

	local strike = ParticleManager:CreateParticle(
		"particles/creeps/frostbitten_strike.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.caster
	)
	ParticleManager:SetParticleControlEnt(
		strike,
		0,
		self.caster,
		PATTACH_POINT_FOLLOW,
		"attach_staff",
		self.caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControl(strike, 1, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(strike)

	self.caster:EmitSound("UI.Ability_frost")

	local nova = ParticleManager:CreateParticle(
		"particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(nova, 0, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(nova, 1, self.parent:GetAbsOrigin())
	ParticleManager:SetParticleControl(nova, 2, self.parent:GetAbsOrigin())
	ParticleManager:ReleaseParticleIndex(nova)

	local targets = self.caster:FindTargets(self.radius, self.parent:GetAbsOrigin())

	for _, target in pairs(targets) do
		DoDamage({
			victim = target,
			attacker = self.caster,
			damage = self.damage + target:GetMaxHealth() * self.damage_health / 100,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self.ability,
		})

		for i = 0, target:GetAbilityCount() - 1 do
			local ability = target:GetAbilityByIndex(i)
			if ability and ability:GetEffectiveCooldown(ability:GetLevel()) > 0 then
				ability:StartCooldown(ability:GetCooldownTimeRemaining() + self.cd_inc)
			end
		end
	end

	if #targets == 0 then
		return
	end
	if not self.caster:IsAlive() then
		return
	end

	for _, ally in pairs(self.caster:FindFriends(self.heal_radius)) do
		ally:GenericHeal(
			ally:GetMaxHealth() * self.heal / 100,
			self.ability,
			false,
			"particles/items3_fx/octarine_core_lifesteal.vpcf"
		)
	end
end