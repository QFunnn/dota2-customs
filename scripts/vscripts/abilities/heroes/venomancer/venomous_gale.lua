--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


venomancer_venomous_gale = class({})

function venomancer_venomous_gale:OnSpellStart()
	local caster = self:GetCaster()
	local target_loc = self:GetCursorPosition()
	local caster_loc = caster:GetAbsOrigin()

	-- Parameters
	local duration = self:GetSpecialValueFor("duration")
	local strike_damage = self:GetSpecialValueFor("strike_damage")
	local projectile_speed = self:GetSpecialValueFor("speed")
	local radius = self:GetSpecialValueFor("radius")
	local travel_distance = self:GetEffectiveCastRange(target_loc, nil) + 50

	local direction
	if target_loc == caster_loc then
		direction = caster:GetForwardVector()
	else
		direction = (target_loc - caster_loc):Normalized()
	end

	local particle_mount = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_venomancer/venomancer_venomous_gale_mouth.vpcf", caster)
	local particle_projectile = ParticleManager:GetParticleReplacement("particles/units/heroes/hero_venomancer/venomancer_venomous_gale.vpcf", caster)

	local mouth_pfx = ParticleManager:CreateParticle(particle_mount, PATTACH_ABSORIGIN_FOLLOW, caster)
	ParticleManager:SetParticleControlEnt(mouth_pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_mouth", caster:GetAbsOrigin(), true)
	ParticleManager:ReleaseParticleIndex(mouth_pfx)

	caster:EmitSound("Hero_Venomancer.VenomousGale")

	local projectile = {
		Ability				= self,
		EffectName			= particle_projectile,
		vSpawnOrigin		= caster:GetAttachmentOrigin(caster:ScriptLookupAttachment("attach_mouth")),
		fDistance			= travel_distance,
		fStartRadius		= radius,
		fEndRadius			= radius,
		Source				= caster,
		bHasFrontalCone		= true,
		bReplaceExisting	= false,
		iUnitTargetTeam		= DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags	= DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType		= DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		fExpireTime 		= GameRules:GetGameTime() + 10.0,
		bDeleteOnHit		= false,
		vVelocity			= Vector(direction.x, direction.y, 0) * projectile_speed,
		bProvidesVision		= true,
		iVisionRadius 		= 280,
		iVisionTeamNumber 	= self:GetCaster():GetTeamNumber(),
		ExtraData			= {strike_damage = strike_damage, duration = duration}
	}

	ProjectileManager:CreateLinearProjectile(projectile)

end

---@param target CDOTA_BaseNPC
function venomancer_venomous_gale:OnProjectileHit_ExtraData(target, location, ExtraData)
	local caster = self:GetCaster()
	if target then
		target:AddNewModifier(caster, self, "modifier_venomancer_venomous_gale", {duration = ExtraData.duration})
		target:EmitSound("Hero_Venomancer.VenomousGaleImpact")

		local ward_count = self:GetSpecialValueFor("create_wards")

		if ward_count > 0 and target:IsRealHero() and not target:IsIllusion() then
			for i = 1, ward_count do
				self:SpawnPlagueWard(target)
			end
		end
	end
end

function venomancer_venomous_gale:SpawnPlagueWard(target)
	local caster = self:GetCaster()
	local pos = target:GetAbsOrigin()

	caster.venomous_gale_shard_flag = true
	local ward_ability = caster:FindAbilityByName("venomancer_plague_ward_custom")
	if ward_ability and ward_ability:IsTrained() then
		caster:SetCursorPosition(pos)
		ward_ability:OnSpellStart()
	end
	caster.venomous_gale_shard_flag = false
end