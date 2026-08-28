--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


lion_earth_spike_lua = class({})
LinkLuaModifier(
	"modifier_generic_knockback_lua",
	"heroes/generic/modifier_generic_knockback_lua",
	LUA_MODIFIER_MOTION_BOTH
)
LinkLuaModifier(
	"modifier_lion_soul_collector",
	"heroes/hero_lion/lion_soul_collector/lion_soul_collector",
	LUA_MODIFIER_MOTION_NONE
)

function lion_earth_spike_lua:OnSpellStart()
	-- unit identifier
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	-- load data
	if target then
		point = target:GetOrigin()
	end

	local projectile_name = "particles/units/heroes/hero_lion/lion_spell_impale.vpcf"
	local projectile_distance = self:GetCastRange(point, target) + self:GetCaster():GetCastRangeBonus()
	local projectile_radius = self:GetSpecialValueFor("width")
	local projectile_speed = self:GetSpecialValueFor("speed")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_lion_int6")
	if abil ~= nil and abil:GetLevel() > 0 then
		local left_QAngle = QAngle(0, 30, 0)
		local right_QAngle = QAngle(0, -30, 0)

		-- Left arrow variables
		local left_spawn_point = RotatePosition(caster:GetAbsOrigin(), left_QAngle, point)
		local left_direction = (left_spawn_point - caster:GetAbsOrigin()):Normalized()

		-- Right arrow variables
		local right_spawn_point = RotatePosition(caster:GetAbsOrigin(), right_QAngle, point)
		local right_direction = (right_spawn_point - caster:GetAbsOrigin()):Normalized()

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
			fStartRadius = projectile_radius,
			fEndRadius = projectile_radius,
			vVelocity = projectile_direction * projectile_speed,
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
			fStartRadius = projectile_radius,
			fEndRadius = projectile_radius,
			vVelocity = projectile_direction * projectile_speed,
		}
		ProjectileManager:CreateLinearProjectile(info)
	end

	local projectile_direction = (point - caster:GetOrigin()):Normalized()
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
		fStartRadius = projectile_radius,
		fEndRadius = projectile_radius,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	-- play effects
	local sound_cast = "Hero_Lion.Impale"
	EmitSoundOn(sound_cast, caster)
end

--------------------------------------------------------------------------------
-- Projectile
function lion_earth_spike_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end
	local caster = self:GetCaster()
	local stun = self:GetSpecialValueFor("duration")

	local fleshHeapStackModifier = "modifier_lion_soul_collector"
	local currentStacks = caster:GetModifierStackCount(fleshHeapStackModifier, caster)

	if not IsServer() then
		return
	end
	local damage = self:GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")

	local abil = self:GetCaster():FindAbilityByName("special_bonus_lion_1")
	if abil ~= nil and abil:GetLevel() > 0 then
		damage = damage + 120
	end

	local ability = self:GetCaster():FindAbilityByName("lion_soul_collector")
	if ability ~= nil and ability:GetLevel() >= 1 then
		stack_damage = ability:GetSpecialValueFor("stack_bonus_dmg")
		local tal = self:GetCaster():FindAbilityByName("special_bonus_lion_4")
		if tal ~= nil and tal:GetLevel() >= 1 then
			stack_damage = stack_damage + 0.2
		end
		damage = damage + (currentStacks * stack_damage)
	end

	local damageTable = {
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	}

	-- stun
	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_stunned", -- modifier name
		{ duration = stun } -- kv
	)

	-- knockback
	local knockback = target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_generic_knockback_lua", -- modifier name
		{
			duration = 0.5,
			height = 350,
		} -- kv
	)
	local callback = function()
		-- damage on landed
		local damageTable = {
			victim = target,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = self:GetAbilityDamageType(),
			ability = self, --Optional.
		}
		ApplyDamage(damageTable)

		-- play effects
		local sound_cast = "Hero_Lion.ImpaleTargetLand"
		EmitSoundOn(sound_cast, target)
	end
	knockback:SetEndCallback(callback)

	-- play effects
	self:PlayEffects(target)
end

--------------------------------------------------------------------------------
function lion_earth_spike_lua:PlayEffects(target)
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lion/lion_spell_impale_hit_spikes.vpcf"
	local sound_cast = "Hero_Lion.ImpaleHitTarget"

	-- Get Data

	-- -- Create Particle
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- Create Sound
	EmitSoundOn(sound_cast, target)
end