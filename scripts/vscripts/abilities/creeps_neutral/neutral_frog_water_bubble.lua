--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_neutral_frog_water_bubble",
	"abilities/creeps_neutral/neutral_frog_water_bubble",
	LUA_MODIFIER_MOTION_NONE
)

neutral_frog_water_bubble = class({})

function neutral_frog_water_bubble:Precache(context)
	PrecacheResource("particle", "particles/generic/neutral_water_shield.vpcf", context)
	PrecacheResource("particle", "particles/generic/neutral_water_shieldc.vpcf", context)
	PrecacheResource("particle", "particles/neutral_fx/frogmen_water_bubble_hit.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/octarine_core_lifesteal.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_naga_riptide.vpcf", context)
end

function neutral_frog_water_bubble:GetIntrinsicModifierName()
	return "modifier_neutral_frog_water_bubble"
end

neutral_frog_water_bubble_2 = class(neutral_frog_water_bubble)
neutral_frog_water_bubble_3 = class(neutral_frog_water_bubble)

modifier_neutral_frog_water_bubble = class(mod_hidden)
function modifier_neutral_frog_water_bubble:OnCreated()
	if not IsServer() then
		return
	end
	self.parent = self:GetParent()
	self.ability = self:GetAbility()

	self.ability:SetLevel(1)

	self.ability.health = self.ability:GetSpecialValueFor("health")
	self.ability.duration = self.ability:GetSpecialValueFor("duration")
	self.ability.heal_radius = self.ability:GetSpecialValueFor("heal_radius")
	self.ability.radius = self.ability:GetSpecialValueFor("radius")
	self.ability.range = self.ability:GetCastRange(self.parent:GetAbsOrigin(), nil)
	self.ability.shield = self.ability:GetSpecialValueFor("shield")
	self.ability.heal = self.ability:GetSpecialValueFor("heal") / 100
end

function modifier_neutral_frog_water_bubble:StartCast(target)
	if not IsServer() then
		return
	end
	self.target = nil

	for _, ally in pairs(self.parent:FindFriends(self.ability.range)) do
		if ally:GetHealthPercent() < self.ability.health and not IsValid(ally.water_bubble) then
			self.target = ally
			break
		end
	end

	if not self.target then
		return
	end

	self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_neutral_cast",
		{
			target = target and target:entindex() or nil,
			duration = 0.3,
			anim = ACT_DOTA_CAST_ABILITY_2,
			parent_mod = self:GetName(),
		}
	)
end

function modifier_neutral_frog_water_bubble:EndCast()
	if not IsServer() then
		return
	end
	if not IsValid(self.target) or not self.target:IsAlive() then
		return
	end

	local target = self.target

	target.water_bubble = target:AddNewModifier(self.parent, self.ability, "modifier_generic_shield_multiple", {
		duration = self.ability.duration,
		max_shield = self.ability.shield,
		start_full = 1,
		status_effect = "particles/status_fx/status_effect_naga_riptide.vpcf",
	})

	local bubble = target.water_bubble
	if not bubble then
		return
	end

	target:EmitSound("n_frogs.WaterBubble.Target")

	local radius = target:GetHullRadius() * 3

	local particle = ParticleManager:CreateParticle(
		"particles/generic/neutral_water_shield.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		target
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
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	bubble:AddParticle(particle, false, false, -1, false, false)

	bubble:SetHitFunction(function(damage)
		local hit = ParticleManager:CreateParticle(
			"particles/neutral_fx/frogmen_water_bubble_hit.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			target
		)
		ParticleManager:SetParticleControlEnt(
			hit,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:SetParticleControl(hit, 1, Vector(radius, radius, radius))
		ParticleManager:ReleaseParticleIndex(hit)

		for _, ally in pairs(target:FindFriends(self.ability.heal_radius)) do
			ally:GenericHeal(
				damage * self.ability.heal,
				self.ability,
				false,
				"particles/items3_fx/octarine_core_lifesteal.vpcf"
			)
		end
	end)

	bubble:SetEndFunction(function()
		local damage = bubble.max_shield - bubble.shield
		if damage <= 1 then
			return
		end

		local explosion = ParticleManager:CreateParticle(
			"particles/generic/neutral_water_shieldc.vpcf",
			PATTACH_CUSTOMORIGIN_FOLLOW,
			target
		)
		ParticleManager:SetParticleControlEnt(
			explosion,
			0,
			target,
			PATTACH_POINT_FOLLOW,
			"attach_hitloc",
			target:GetAbsOrigin(),
			true
		)
		ParticleManager:ReleaseParticleIndex(explosion)

		target:EmitSound("n_frogs.WaterBubble.Destroy")

		for _, enemy in pairs(target:FindTargets(self.ability.radius)) do
			DoDamage({
				victim = enemy,
				attacker = target,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self.ability,
			})
		end
	end)
end