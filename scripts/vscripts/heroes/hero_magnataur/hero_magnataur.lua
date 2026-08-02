--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_magnus_shockwave_lua", "heroes/hero_magnataur/hero_magnataur", LUA_MODIFIER_MOTION_NONE)

magnus_shockwave_lua = class({})

function magnus_shockwave_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf", context)
end

function magnus_shockwave_lua:OnAbilityPhaseStart()
	if not IsServer() then
		return
	end
	self:PlayEffects1()
	return true
end

function magnus_shockwave_lua:OnAbilityPhaseInterrupted()
	if not IsServer() then
		return
	end
	self:StopEffects1(true)
end

function magnus_shockwave_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local origin = caster:GetAbsOrigin()

	self:StopEffects1(false)
	local speed = self:GetSpecialValueFor("shock_speed")

	local distance = self:GetCastRange(point, nil)

	local direction = point - caster:GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

	local talent = caster:FindAbilityByName("special_bonus_unique_magnus_3")
	if talent and talent:GetLevel() > 0 then
		local angle = 5
		local dir_left = RotatePosition(Vector(0, 0, 0), QAngle(0, angle, 0), direction)
		local dir_right = RotatePosition(Vector(0, 0, 0), QAngle(0, -angle, 0), direction)
		self:Fire(dir_left * speed, distance)
		self:Fire(dir_right * speed, distance)
	else
		self:Fire(direction * speed, distance)
	end

	EmitSoundOn("Hero_Magnataur.ShockWave.Particle", caster)
end

function magnus_shockwave_lua:Fire(vVelocity, fDistance)
	local caster = self:GetCaster()
	local width = self:GetSpecialValueFor("shock_width")
	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),
		bDeleteOnHit = false,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		EffectName = "particles/units/heroes/hero_magnataur/magnataur_shockwave.vpcf",
		fDistance = fDistance,
		fStartRadius = width,
		fEndRadius = width,
		vVelocity = vVelocity,
	}
	ProjectileManager:CreateLinearProjectile(info)
end

function magnus_shockwave_lua:OnProjectileHit(target, location)
	if not target then
		return
	end

	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("basic_slow_duration")

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	target:AddNewModifier(caster, self, "modifier_magnus_shockwave_lua", { duration = duration })
	self:PlayEffects2(target)
	return false
end

function magnus_shockwave_lua:PlayEffects1()
	local caster = self:GetCaster()
	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_shockwave_cast.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		1,
		caster,
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	EmitSoundOn("Hero_Magnataur.ShockWave.Cast", caster)
end

function magnus_shockwave_lua:StopEffects1(interrupted)
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, interrupted)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
		self.effect_cast = nil
	end
	StopSoundOn("Hero_Magnataur.ShockWave.Cast", self:GetCaster())
end

function magnus_shockwave_lua:PlayEffects2(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_shockwave_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Magnataur.ShockWave.Target", target)
end

--------------------------------------------------------------------------------

modifier_magnus_shockwave_lua = class({})

function modifier_magnus_shockwave_lua:IsHidden()
	return false
end
function modifier_magnus_shockwave_lua:IsDebuff()
	return true
end
function modifier_magnus_shockwave_lua:IsPurgable()
	return true
end

function modifier_magnus_shockwave_lua:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_magnus_shockwave_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE }
end

function modifier_magnus_shockwave_lua:GetModifierMoveSpeedBonus_Percentage()
	return -self.slow
end

function modifier_magnus_shockwave_lua:GetEffectName()
	return "particles/units/heroes/hero_magnataur/magnataur_skewer_debuff.vpcf"
end

function modifier_magnus_shockwave_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_magnus_empower_lua", "heroes/hero_magnataur/hero_magnataur", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_magnus_empower_lua_aura", "heroes/hero_magnataur/hero_magnataur", LUA_MODIFIER_MOTION_NONE)

magnus_empower_lua = class({})

function magnus_empower_lua:GetBehavior()
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_magnus_7")
	if talent and talent:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_PASSIVE
	end
	return self.BaseClass.GetBehavior(self)
end

function magnus_empower_lua:GetIntrinsicModifierName()
	return "modifier_magnus_empower_lua_aura"
end

function magnus_empower_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("empower_duration")

	target:AddNewModifier(caster, self, "modifier_magnus_empower_lua", { duration = duration })

	EmitSoundOn("Hero_Magnataur.Empower.Cast", caster)
	EmitSoundOn("Hero_Magnataur.Empower.Target", target)
end

--------------------------------------------------------------------------------

modifier_magnus_empower_lua_aura = class({})

function modifier_magnus_empower_lua_aura:IsHidden()
	return true
end

function modifier_magnus_empower_lua_aura:IsPurgable()
	return false
end

function modifier_magnus_empower_lua_aura:IsAura()
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_magnus_7")
	if talent and talent:GetLevel() > 0 then
		return true
	end
	return false
end

function modifier_magnus_empower_lua_aura:GetModifierAura()
	return "modifier_magnus_empower_lua"
end

function modifier_magnus_empower_lua_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_magnus_empower_lua_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_magnus_empower_lua_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end
function modifier_magnus_empower_lua_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NONE
end
function modifier_magnus_empower_lua_aura:GetAuraEntityReject(target)
	return false
end

--------------------------------------------------------------------------------

modifier_magnus_empower_lua = class({})

function modifier_magnus_empower_lua:IsHidden()
	return false
end

function modifier_magnus_empower_lua:IsPurgable()
	return true
end

function modifier_magnus_empower_lua:OnCreated()
	local ability = self:GetAbility()
	self.bonus_damage = ability:GetSpecialValueFor("bonus_damage_pct")
	self.cleave_damage = ability:GetSpecialValueFor("cleave_damage_pct") / 100
	self.cleave_start = ability:GetSpecialValueFor("cleave_starting_width")
	self.cleave_end = ability:GetSpecialValueFor("cleave_ending_width")
	self.cleave_dist = ability:GetSpecialValueFor("cleave_distance")
end

function modifier_magnus_empower_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_magnus_empower_lua:GetModifierBaseDamageOutgoing_Percentage()
	return self.bonus_damage
end

function modifier_magnus_empower_lua:OnAttackLanded(params)
	if not IsServer() or params.attacker ~= self:GetParent() or self:GetParent():IsRangedAttacker() then
		return
	end
	if params.target:IsBuilding() or params.target:IsOther() then
		return
	end

	DoCleaveAttack(
		params.attacker,
		params.target,
		self:GetAbility(),
		params.damage * (self:GetAbility():GetSpecialValueFor("cleave_damage_pct") / 100),
		self:GetAbility():GetSpecialValueFor("cleave_starting_width"),
		self:GetAbility():GetSpecialValueFor("cleave_ending_width"),
		self:GetAbility():GetSpecialValueFor("cleave_distance"),
		"particles/units/heroes/hero_magnataur/magnataur_empower_cleave_effect.vpcf"
	)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_magnataur_skin", "heroes/hero_magnataur/hero_magnataur", LUA_MODIFIER_MOTION_NONE)

magnataur_skin = class({})

function magnataur_skin:GetIntrinsicModifierName()
	return "modifier_magnataur_skin"
end

--------------------------------------------------------------------------------

modifier_magnataur_skin = class({})

function modifier_magnataur_skin:IsHidden()
	return self:GetParent():PassivesDisabled()
end

function modifier_magnataur_skin:IsPurgable()
	return false
end
function modifier_magnataur_skin:IsDebuff()
	return false
end

function modifier_magnataur_skin:OnCreated()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
	self:UpdateValues()
end

function modifier_magnataur_skin:OnRefresh()
	self:UpdateValues()
end

function modifier_magnataur_skin:UpdateValues()
	if not self.ability or self.ability:IsNull() then
		return
	end

	self.armor = self.ability:GetSpecialValueFor("bonus_armor")
	self.resist = self.ability:GetSpecialValueFor("bonus_resist")
	self.radius = self.ability:GetSpecialValueFor("radius")
end

function modifier_magnataur_skin:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_magnataur_skin:GetModifierPhysicalArmorBonus()
	if self.parent:PassivesDisabled() then
		return 0
	end
	return self.armor
end

function modifier_magnataur_skin:GetModifierMagicalResistanceBonus()
	if self.parent:PassivesDisabled() then
		return 0
	end
	return self.resist
end

function modifier_magnataur_skin:IsAura()
	return self.parent == self:GetCaster() and not self.parent:PassivesDisabled()
end

function modifier_magnataur_skin:GetModifierAura()
	return "modifier_magnataur_skin"
end

function modifier_magnataur_skin:GetAuraRadius()
	return self.radius
end

function modifier_magnataur_skin:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_magnataur_skin:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

magnus_reverse_polarity_lua = class({})

function magnus_reverse_polarity_lua:Precache(context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_reverse_polarity.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_magnataur/magnataur_reverse_polarity_pull.vpcf", context)
end

function magnus_reverse_polarity_lua:OnAbilityPhaseStart()
	if IsServer() then
		self:PlayEffects1()
	end
	return true
end

function magnus_reverse_polarity_lua:OnAbilityPhaseInterrupted()
	if IsServer() then
		self:StopEffects(true)
	end
end

function magnus_reverse_polarity_lua:GetCooldown(level)
	local caster = self:GetCaster()
	local talent = caster:FindAbilityByName("special_bonus_unique_magnus_4")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 20
	end
	return self.BaseClass.GetCooldown(self, level)
end

function magnus_reverse_polarity_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	self:StopEffects(false)

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
	local duration = self:GetSpecialValueFor("duration")

	local damageTable = {
		attacker = caster,
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	}

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })

		damageTable.victim = enemy
		ApplyDamage(damageTable)
		self:PlayEffects2(enemy, enemy:GetOrigin())
	end

	EmitSoundOn("Hero_Magnataur.ReversePolarity.Cast", caster)
end

function magnus_reverse_polarity_lua:PlayEffects1()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local castpoint = self:GetCastPoint()
	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_reverse_polarity.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		caster
	)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(radius, radius, radius))
	ParticleManager:SetParticleControl(self.effect_cast, 2, Vector(castpoint, 0, 0))
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		3,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControlForward(self.effect_cast, 3, caster:GetForwardVector())
	EmitSoundOn("Hero_Magnataur.ReversePolarity.Anim", caster)
end

function magnus_reverse_polarity_lua:StopEffects(interrupted)
	if self.effect_cast then
		ParticleManager:DestroyParticle(self.effect_cast, interrupted)
		ParticleManager:ReleaseParticleIndex(self.effect_cast)
		self.effect_cast = nil
	end
	StopSoundOn("Hero_Magnataur.ReversePolarity.Anim", self:GetCaster())
end

function magnus_reverse_polarity_lua:PlayEffects2(target, origin)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_magnataur/magnataur_reverse_polarity_pull.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(effect_cast, 1, origin)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_Magnataur.ReversePolarity.Stun", target)
end