--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_lina_dragon_slave_lua_flame",
	"heroes/hero_lina/lina_dragon_slave_lua/lina_dragon_slave_lua",
	LUA_MODIFIER_MOTION_NONE
)

lina_dragon_slave_lua = class({})

function lina_dragon_slave_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	if target then
		point = target:GetOrigin()
	end

	local projectile_name = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf"
	local projectile_distance = self:GetSpecialValueFor("dragon_slave_distance")
	local projectile_speed = self:GetSpecialValueFor("dragon_slave_speed")
	local projectile_start_radius = self:GetSpecialValueFor("dragon_slave_width_initial")
	local projectile_end_radius = self:GetSpecialValueFor("dragon_slave_width_end")

	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_5")
	if talent and talent:GetLevel() > 0 then
		local left_QAngle = QAngle(0, 30, 0)
		local right_QAngle = QAngle(0, -30, 0)

		local left_spawn_point = RotatePosition(caster:GetAbsOrigin(), left_QAngle, point)
		local left_direction = (left_spawn_point - caster:GetAbsOrigin()):Normalized()
		local right_spawn_point = RotatePosition(caster:GetAbsOrigin(), right_QAngle, point)
		local right_direction = (right_spawn_point - caster:GetAbsOrigin()):Normalized()

		local projectile_direction = right_direction

		local projectile_direction = right_direction

		local info = {
			Source = caster,
			Ability = self,
			vSpawnOrigin = caster:GetAbsOrigin(),

			bDeleteOnHit = false,

			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

			EffectName = projectile_name,
			fDistance = projectile_distance,
			fStartRadius = projectile_start_radius,
			fEndRadius = projectile_end_radius,
			vVelocity = projectile_direction * projectile_speed,
			bProvidesVision = false,
		}
		ProjectileManager:CreateLinearProjectile(info)

		-----------------------------------------------------------------------------------------
		local projectile_direction = left_direction
		local info = {
			Source = caster,
			Ability = self,
			vSpawnOrigin = caster:GetAbsOrigin(),

			bDeleteOnHit = false,

			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

			EffectName = projectile_name,
			fDistance = projectile_distance,
			fStartRadius = projectile_start_radius,
			fEndRadius = projectile_end_radius,
			vVelocity = projectile_direction * projectile_speed,
			bProvidesVision = false,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end

	local direction = point - caster:GetOrigin()
	direction.z = 0
	local projectile_direction = direction:Normalized()
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		bDeleteOnHit = false,

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = projectile_name,
		fDistance = projectile_distance,
		fStartRadius = projectile_start_radius,
		fEndRadius = projectile_end_radius,
		vVelocity = projectile_direction * projectile_speed,

		bProvidesVision = false,
	}
	ProjectileManager:CreateLinearProjectile(info)

	local sound_cast = "Hero_Lina.DragonSlave.Cast"
	local sound_projectile = "Hero_Lina.DragonSlave"
	EmitSoundOn(sound_cast, self:GetCaster())
	EmitSoundOn(sound_projectile, self:GetCaster())
end

function lina_dragon_slave_lua:OnProjectileHitHandle(target, location, projectile)
	if not IsServer() then
		return
	end
	if not target then
		return
	end
	local damage_slave = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_1")
	if talent and talent:GetLevel() > 0 then
		damage_slave = damage_slave + 80
	end

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage_slave,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}
	ApplyDamage(damageTable)

	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_3")
	if talent and talent:GetLevel() > 0 then
		target:AddNewModifier(self:GetCaster(), self, "modifier_lina_dragon_slave_lua_flame", { duration = 3 })
	end

	local direction = ProjectileManager:GetLinearProjectileVelocity(projectile)
	direction.z = 0
	direction = direction:Normalized()

	self:PlayEffects(target, direction)
end

function lina_dragon_slave_lua:PlayEffects(target, direction)
	local particle_cast = "particles/units/heroes/hero_lina/lina_spell_dragon_slave_impact.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlForward(effect_cast, 1, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

-------------------------------------------------

modifier_lina_dragon_slave_lua_flame = class({})

function modifier_lina_dragon_slave_lua_flame:IsHidden()
	return false
end

function modifier_lina_dragon_slave_lua_flame:IsDebuff()
	return true
end

function modifier_lina_dragon_slave_lua_flame:IsStunDebuff()
	return false
end

function modifier_lina_dragon_slave_lua_flame:IsPurgable()
	return true
end

function modifier_lina_dragon_slave_lua_flame:OnCreated(kv)
	local damage = self:GetAbility():GetSpecialValueFor("damage") / 2

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(), --Optional.
	}
	self:StartIntervalThink(1)
end

function modifier_lina_dragon_slave_lua_flame:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_lina_dragon_slave_lua_flame:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf"
end

function modifier_lina_dragon_slave_lua_flame:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end