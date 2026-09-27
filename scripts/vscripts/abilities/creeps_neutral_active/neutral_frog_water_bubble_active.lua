--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


neutral_frog_water_bubble_active = class({})

function neutral_frog_water_bubble_active:Precache(context)
	PrecacheResource("particle", "particles/generic/neutral_water_shield.vpcf", context)
	PrecacheResource("particle", "particles/generic/neutral_water_shieldc.vpcf", context)
	PrecacheResource("particle", "particles/items3_fx/octarine_core_lifesteal.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_naga_riptide.vpcf", context)
end

function neutral_frog_water_bubble_active:OnSpellStart()
	local target = self:GetCursorTarget()

	self.shield = self:GetSpecialValueFor("shield")
	self.duration = self:GetSpecialValueFor("duration")
	self.heal = self:GetSpecialValueFor("heal") / 100
	self.heal_radius = self:GetSpecialValueFor("heal_radius")
	self.radius = self:GetSpecialValueFor("radius")

	if IsValid(target.water_bubble) then
		target.water_bubble:Destroy()
	end

	target.water_bubble = target:AddNewModifier(self.caster, self, "modifier_generic_shield_multiple", {
		duration = self.duration,
		max_shield = self.shield,
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
		for _, ally in pairs(target:FindFriends(self.heal_radius)) do
			ally:GenericHeal(damage * self.heal, self, false, "particles/items3_fx/octarine_core_lifesteal.vpcf")
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

		for _, enemy in pairs(target:FindTargets(self.radius)) do
			DoDamage({
				victim = enemy,
				attacker = target,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			})
		end
	end)
end

neutral_frog_water_bubble_2_active = class(neutral_frog_water_bubble_active)
neutral_frog_water_bubble_3_active = class(neutral_frog_water_bubble_active)