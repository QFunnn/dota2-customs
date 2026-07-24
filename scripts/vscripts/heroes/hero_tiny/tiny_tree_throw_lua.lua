--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tiny_tree_throw_lua = class({})
LinkLuaModifier("modifier_tiny_tree_throw_lua_slow", "heroes/hero_tiny/tiny_tree_throw_lua", LUA_MODIFIER_MOTION_NONE)


function tiny_tree_throw_lua:GetAOERadius()
	return self:GetSpecialValueFor("splash_radius")
end


function tiny_tree_throw_lua:OnSpellStart( ... )
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local position = self:GetCursorPosition()

	caster:RemoveModifierByName("modifier_tiny_grab_lua")

	local speed = self:GetSpecialValueFor("speed")

	if target then
		local projectile_info = {
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_tiny/tiny_tree_proj.vpcf",
			bDodgeable = true,
			bProvidesVision = true,
			iMoveSpeed = speed,
		    iVisionRadius = 200,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
		ProjectileManager:CreateTrackingProjectile( projectile_info )
	else
		local range = self:GetSpecialValueFor("range")
		local splash_radius = self:GetSpecialValueFor("splash_radius")
		local direction = (position - caster:GetAbsOrigin()):Normalized()
		direction.z = 0

		local projectile_info = {
			EffectName = "particles/units/heroes/hero_tiny/tiny_tree_linear_proj.vpcf",
			Ability = self,
			vSpawnOrigin = caster:GetOrigin(),
			vVelocity = direction * speed,
			fDistance = range,
			fStartRadius = splash_radius,
			fEndRadius = splash_radius,
			Source = caster,
			bHasFrontalCone = false,
			bReplaceExisting = true,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			iVisionRadius = splash_radius,
			iVisionTeamNumber = caster:GetTeamNumber(),
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1
		}
		ProjectileManager:CreateLinearProjectile( projectile_info )
	end

	caster:EmitSound("Hero_Tiny.Tree.Throw")
end


function tiny_tree_throw_lua:OnProjectileHit(target, location)
	if not IsServer() then return end
	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local damage = caster:GetAverageTrueAttackDamage(target)
	local splash_pct = self:GetSpecialValueFor("splash_pct") / 100.0
	local bonus_damage = (1 + self:GetSpecialValueFor("bonus_damage") / 100.0)

	local dealt_damage = damage * splash_pct * bonus_damage

	local damage_table = {
		attacker = caster,
		victim = nil,
		damage = dealt_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		ability = self
	}

	local splash_radius = self:GetSpecialValueFor("splash_radius")

	local search_location
	if target then
		search_location = target:GetAbsOrigin()
	else
		search_location = location
	end

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		search_location,
		nil,
		splash_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		FIND_CLOSEST,
		false
	)

	if target then
		caster:PerformAttack(target, true, true, true, true, false, false, true)
		target:EmitSound("Hero_Tiny.Tree.Target")
	elseif #enemies > 0 then
		caster:PerformAttack(enemies[1], true, true, true, true, false, false, true)
		enemies[1]:EmitSound("Hero_Tiny.Tree.Target")
		target = enemies[1]
	end

	if not enemies or not target then return end

	if target:IsNull() then return end

	if not target.AddNewModifier then return end

	target:AddNewModifier(caster, self, "modifier_tiny_tree_throw_lua_slow", { duration = self:GetSpecialValueFor("slow_duration") })

	local direction = (target:GetAbsOrigin() - caster:GetAbsOrigin()):Normalized()

	local cleave_p = ParticleManager:CreateParticle("particles/units/heroes/hero_tiny/tiny_craggy_cleave.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(cleave_p, 0, target:GetAbsOrigin())
	ParticleManager:SetParticleControl(cleave_p, 1, target:GetAbsOrigin())
	ParticleManager:SetParticleControlForward(cleave_p, 2, direction)

	ParticleManager:ReleaseParticleIndex(cleave_p)

	for i, unit in pairs(enemies) do
		if unit and unit ~= target and not unit:IsNull() then
			damage_table.victim = unit
			ApplyDamage(damage_table)
		end
	end

	return true
end



modifier_tiny_tree_throw_lua_slow = class({})

function modifier_tiny_tree_throw_lua_slow:OnCreated()

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then return end

	local ability = self:GetAbility()
	if not ability or ability:IsNull() then return end

	self.slow = ability:GetSpecialValueFor("movement_slow")

end

function modifier_tiny_tree_throw_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_tiny_tree_throw_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -1 * self.slow
end