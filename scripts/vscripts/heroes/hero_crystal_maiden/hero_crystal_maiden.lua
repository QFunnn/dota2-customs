--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_crystal_maiden_crystal_nova_lua",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)

crystal_maiden_crystal_nova_lua = class({})

function crystal_maiden_crystal_nova_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function crystal_maiden_crystal_nova_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local damage = self:GetSpecialValueFor("nova_damage")
		+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage")
	local radius = self:GetSpecialValueFor("radius")
	local debuffDuration = self:GetSpecialValueFor("duration")
	local vision_radius = 500
	local vision_duration = 2

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		0,
		0,
		false
	)

	if not IsServer() then
		return
	end

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)

		enemy:AddNewModifier(caster, self, "modifier_crystal_maiden_crystal_nova_lua", { duration = debuffDuration })
	end

	AddFOWViewer(self:GetCaster():GetTeamNumber(), point, vision_radius, vision_duration, true)
	self:PlayEffects(point, radius, debuffDuration)
end

function crystal_maiden_crystal_nova_lua:PlayEffects(point, radius, duration)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_crystalmaiden/maiden_crystal_nova.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, duration, radius))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local sound_cast = "Hero_Crystal.CrystalNova"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

------------------------------------------------------------------------------

modifier_crystal_maiden_crystal_nova_lua = class({})

function modifier_crystal_maiden_crystal_nova_lua:IsHidden()
	return false
end

function modifier_crystal_maiden_crystal_nova_lua:IsDebuff()
	return true
end

function modifier_crystal_maiden_crystal_nova_lua:IsPurgable()
	return true
end

function modifier_crystal_maiden_crystal_nova_lua:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attackspeed_slow") -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow") -- special value
end

function modifier_crystal_maiden_crystal_nova_lua:OnRefresh(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attackspeed_slow") -- special value
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow") -- special value
end

function modifier_crystal_maiden_crystal_nova_lua:OnDestroy(kv) end

function modifier_crystal_maiden_crystal_nova_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_crystal_maiden_crystal_nova_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_crystal_nova_lua:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_crystal_maiden_crystal_nova_lua:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_crystal_nova_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_crystal_maiden_frostbite_lua",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)

crystal_maiden_frostbite_lua = class({})

function crystal_maiden_frostbite_lua:GetAOERadius()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_7")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return 250
	end
	return 0
end

function crystal_maiden_frostbite_lua:GetBehavior()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_7")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end
	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
		+ DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
		+ DOTA_ABILITY_BEHAVIOR_DONT_RESUME_ATTACK
end

function crystal_maiden_frostbite_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_7")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		local target_point = self:GetCursorPosition()
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			nil,
			300,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)

		for _, unit in pairs(units) do
			unit:AddNewModifier(
				caster,
				self,
				"modifier_crystal_maiden_frostbite_lua",
				{ duration = unit_debuff_duration(self, unit) * (1 - unit:GetStatusResistance()) }
			)
			unit:AddNewModifier(caster, self, "modifier_stunned", { duration = 0.1 })
			self:PlayEffects(caster, unit)
		end
	else
		target:AddNewModifier(
			caster,
			self,
			"modifier_crystal_maiden_frostbite_lua",
			{ duration = unit_debuff_duration(self, target) * (1 - target:GetStatusResistance()) }
		)
		target:AddNewModifier(caster, self, "modifier_stunned", { duration = 0.1 })
		self:PlayEffects(caster, target)
	end
end

function unit_debuff_duration(ability, unit)
	if unit:IsAncient() then
		return ability:GetSpecialValueFor("duration") / 2
	end
	return ability:GetSpecialValueFor("duration")
end

function crystal_maiden_frostbite_lua:PlayEffects(caster, target)
	local projectile_name = "particles/units/heroes/hero_crystalmaiden/maiden_frostbite.vpcf"
	local projectile_speed = 1000
	local info = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		vSourceLoc = caster:GetAbsOrigin(),
		bDodgeable = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

--------------------------------------------------------------------------------

modifier_crystal_maiden_frostbite_lua = class({})

function modifier_crystal_maiden_frostbite_lua:IsHidden()
	return false
end

function modifier_crystal_maiden_frostbite_lua:IsDebuff()
	return true
end

function modifier_crystal_maiden_frostbite_lua:IsStunDebuff()
	return false
end

function modifier_crystal_maiden_frostbite_lua:IsPurgable()
	return true
end

function modifier_crystal_maiden_frostbite_lua:OnCreated(kv)
	local tick_damage = self:GetAbility():GetSpecialValueFor("damage")

	if not IsServer() then
		return
	end
	tick_damage = (
		tick_damage
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")
	) / 2
	self.interval = 0.5

	if IsServer() then
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = tick_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}

		self:StartIntervalThink(0.5)
		self:OnIntervalThink()

		EmitSoundOn("hero_Crystal.frostbite", self:GetParent())
	end
end

function modifier_crystal_maiden_frostbite_lua:OnDestroy()
	StopSoundOn("hero_Crystal.frostbite", self:GetParent())
end

function modifier_crystal_maiden_frostbite_lua:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}
	return state
end

function modifier_crystal_maiden_frostbite_lua:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_DISABLE_HEALING,
	}
	return decFuncs
end

function modifier_crystal_maiden_frostbite_lua:GetDisableHealing()
	return 1
end

function modifier_crystal_maiden_frostbite_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_crystal_maiden_frostbite_lua:GetEffectName()
	return "particles/units/heroes/hero_crystalmaiden/maiden_frostbite_buff.vpcf"
end

function modifier_crystal_maiden_frostbite_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------

crystal_maiden_arcane_aura_lua = class({})
LinkLuaModifier(
	"modifier_crystal_maiden_arcane_aura_lua",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_arcane_aura_lua_effect",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)

function crystal_maiden_arcane_aura_lua:GetIntrinsicModifierName()
	return "modifier_crystal_maiden_arcane_aura_lua"
end

function crystal_maiden_arcane_aura_lua:GetCastRange(location, target)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_6")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCastRange(self, location, target) + 99999
	end
	return self.BaseClass.GetCastRange(self, location, target)
end

---------------------------

modifier_crystal_maiden_arcane_aura_lua = class({})

function modifier_crystal_maiden_arcane_aura_lua:IsHidden()
	return true
end

function modifier_crystal_maiden_arcane_aura_lua:IsDebuff()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua:IsPurgable()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_crystal_maiden_arcane_aura_lua:GetModifierAura()
	return "modifier_crystal_maiden_arcane_aura_lua_effect"
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraRadius()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_6")
	if talent and talent:GetLevel() > 0 then
		return FIND_UNITS_EVERYWHERE
	end
	return 600
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_crystal_maiden_arcane_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

---------------------------

modifier_crystal_maiden_arcane_aura_lua_effect = class({})

function modifier_crystal_maiden_arcane_aura_lua_effect:IsHidden()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua_effect:IsDebuff()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua_effect:IsPurgable()
	return false
end

function modifier_crystal_maiden_arcane_aura_lua_effect:OnCreated(kv)
	self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_crystal_maiden_arcane_aura_lua_effect:OnRefresh(kv)
	self.mana_regen = self:GetAbility():GetSpecialValueFor("mana_regen")
end

function modifier_crystal_maiden_arcane_aura_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
	return funcs
end

function modifier_crystal_maiden_arcane_aura_lua_effect:GetModifierConstantManaRegen()
	if self:GetParent() == self:GetCaster() then
		return self.mana_regen
	end
	return self.mana_regen / 2
end

function modifier_crystal_maiden_arcane_aura_lua_effect:GetModifierSpellAmplify_Percentage()
	self.ampl = self:GetAbility():GetSpecialValueFor("ampl")
	if self:GetParent() == self:GetCaster() then
		return self:GetCaster():GetLevel() * self.ampl
	end
	return self:GetCaster():GetLevel() * self.ampl / 2
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

crystal_maiden_freezing_field_lua = class({})
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_lua",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_crystal_maiden_freezing_field_lua_effect",
	"heroes/hero_crystal_maiden/hero_crystal_maiden",
	LUA_MODIFIER_MOTION_NONE
)

function crystal_maiden_freezing_field_lua:OnSpellStart()
	local caster = self:GetCaster()
	self.modifier = caster:AddNewModifier(
		caster,
		self,
		"modifier_crystal_maiden_freezing_field_lua",
		{ duration = self:GetChannelTime() }
	)
end

function crystal_maiden_freezing_field_lua:OnChannelFinish(bInterrupted)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_crystal_8")
	if talent and talent:GetLevel() > 0 then
		return
	else
		if self.modifier then
			self.modifier:Destroy()
			self.modifier = nil
		end
	end
end

-----------------------------------------------------

modifier_crystal_maiden_freezing_field_lua = class({})

function modifier_crystal_maiden_freezing_field_lua:IsHidden()
	return true
end

function modifier_crystal_maiden_freezing_field_lua:IsDebuff()
	return false
end

function modifier_crystal_maiden_freezing_field_lua:IsPurgable()
	return false
end

function modifier_crystal_maiden_freezing_field_lua:IsAura()
	return true
end

function modifier_crystal_maiden_freezing_field_lua:GetModifierAura()
	return "modifier_crystal_maiden_freezing_field_lua_effect"
end

function modifier_crystal_maiden_freezing_field_lua:GetAuraRadius()
	return self.slow_radius
end

function modifier_crystal_maiden_freezing_field_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_crystal_maiden_freezing_field_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP
end

function modifier_crystal_maiden_freezing_field_lua:GetAuraDuration()
	return self.slow_duration
end

function modifier_crystal_maiden_freezing_field_lua:OnCreated(kv)
	self.slow_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.slow_duration = self:GetAbility():GetSpecialValueFor("slow_duration")
	self.explosion_radius = self:GetAbility():GetSpecialValueFor("explosion_radius")
	self.explosion_interval = self:GetAbility():GetSpecialValueFor("explosion_interval")
	self.explosion_min_dist = self:GetAbility():GetSpecialValueFor("explosion_min_dist")
	self.explosion_max_dist = self:GetAbility():GetSpecialValueFor("explosion_max_dist")
	self.explosion_damage = self:GetAbility():GetSpecialValueFor("damage")
	self.int_damage = self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	if not IsServer() then
		return
	end
	if self:GetCaster():IsCreep() then
		self.try_damage = self.explosion_damage
	else
		self.try_damage = self.explosion_damage + self:GetCaster():ExtraIntelligenceDamage() * self.int_damage
	end

	self.quartal = -1

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = self.try_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}

		self:StartIntervalThink(self.explosion_interval)
		self:OnIntervalThink()
		self:PlayEffects1()
	end
end

function modifier_crystal_maiden_freezing_field_lua:OnRefresh(kv)
	self.slow_radius = self:GetAbility():GetSpecialValueFor("radius")
	self.explosion_radius = self:GetAbility():GetSpecialValueFor("explosion_radius")
	self.explosion_interval = self:GetAbility():GetSpecialValueFor("explosion_interval")
	self.explosion_min_dist = self:GetAbility():GetSpecialValueFor("explosion_min_dist")
	self.explosion_max_dist = self:GetAbility():GetSpecialValueFor("explosion_max_dist")
	self.explosion_damage = self:GetAbility():GetSpecialValueFor("damage")
	self.int_damage = self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	if self:GetCaster():IsCreep() then
		self.try_damage = self.explosion_damage
	else
		self.try_damage = self.explosion_damage + self:GetCaster():ExtraIntelligenceDamage() * self.int_damage
	end

	self.quartal = -1

	if IsServer() then
		self.damageTable = {
			attacker = self:GetCaster(),
			damage = self.try_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self, --Optional.
		}
		self:StartIntervalThink(self.explosion_interval)
		self:OnIntervalThink()
	end
end

function modifier_crystal_maiden_freezing_field_lua:OnDestroy(kv)
	if IsServer() then
		self:StartIntervalThink(-1)
		self:StopEffects1()
	end
end

function modifier_crystal_maiden_freezing_field_lua:OnIntervalThink()
	self.quartal = self.quartal + 1
	if self.quartal > 3 then
		self.quartal = 0
	end
	local a = RandomInt(0, 90) + self.quartal * 90
	local r = RandomInt(self.explosion_min_dist, self.explosion_max_dist)
	local point = Vector(math.cos(a), math.sin(a), 0):Normalized() * r

	point = self:GetCaster():GetOrigin() + point
	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(), -- int, your team number
		point, -- point, center point
		nil, -- handle, cacheUnit. (not known)
		self.explosion_radius, -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		0, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)
	end
	self:PlayEffects2(point)
end

function modifier_crystal_maiden_freezing_field_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_snow.vpcf"
	self.sound_cast = "hero_Crystal.freezingField.wind"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.slow_radius, self.slow_radius, 1))
	self:AddParticle(self.effect_cast, false, false, -1, false, false)
	EmitSoundOn(self.sound_cast, self:GetCaster())
end

function modifier_crystal_maiden_freezing_field_lua:PlayEffects2(point)
	local particle_cast = "particles/units/heroes/hero_crystalmaiden/maiden_freezing_field_explosion.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	local sound_cast = "hero_Crystal.freezingField.explosion"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function modifier_crystal_maiden_freezing_field_lua:StopEffects1()
	StopSoundOn(self.sound_cast, self:GetCaster())
end

----------------------------------------------------------

modifier_crystal_maiden_freezing_field_lua_effect = class({})

function modifier_crystal_maiden_freezing_field_lua_effect:IsHidden()
	return false
end

function modifier_crystal_maiden_freezing_field_lua_effect:IsDebuff()
	return true
end

function modifier_crystal_maiden_freezing_field_lua_effect:IsPurgable()
	return true
end

function modifier_crystal_maiden_freezing_field_lua_effect:OnCreated(kv)
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_crystal_maiden_freezing_field_lua_effect:OnRefresh(kv)
	self.ms_slow = self:GetAbility():GetSpecialValueFor("movespeed_slow")
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_crystal_maiden_freezing_field_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_crystal_maiden_freezing_field_lua_effect:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end

function modifier_crystal_maiden_freezing_field_lua_effect:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end

function modifier_crystal_maiden_freezing_field_lua_effect:GetEffectName()
	return "particles/generic_gameplay/generic_slowed_cold.vpcf"
end

function modifier_crystal_maiden_freezing_field_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end