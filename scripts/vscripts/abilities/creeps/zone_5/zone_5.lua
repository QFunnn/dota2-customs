--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_nethertoxin_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)

creep_nethertoxin_lua = class({})

function creep_nethertoxin_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_nethertoxin_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function creep_nethertoxin_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local vector = point - caster:GetOrigin()

	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local projectile_distance = vector:Length2D()
	local projectile_direction = vector
	projectile_direction.z = 0
	projectile_direction = projectile_direction:Normalized()

	local info = {
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin(),

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_NONE,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_NONE,

		EffectName = "",
		fDistance = projectile_distance,
		fStartRadius = 0,
		fEndRadius = 0,
		vVelocity = projectile_direction * projectile_speed,
	}
	ProjectileManager:CreateLinearProjectile(info)

	self:PlayEffects(point)
end

function creep_nethertoxin_lua:OnProjectileHit(target, location)
	if target then
		return false
	end
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		self:GetCaster(),
		self,
		"modifier_creep_nethertoxin_lua",
		{ duration = duration },
		location,
		self:GetCaster():GetTeamNumber(),
		false
	)
end

function creep_nethertoxin_lua:PlayEffects(point)
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin_proj.vpcf"
	local sound_cast = "Hero_Viper.Nethertoxin.Cast"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack1",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(projectile_speed, 0, 0))
	ParticleManager:SetParticleControl(effect_cast, 5, point)
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn(sound_cast, self:GetCaster())
end

-----------------------------------------------------------------------------------------

modifier_creep_nethertoxin_lua = class({})

function modifier_creep_nethertoxin_lua:IsHidden()
	return false
end

function modifier_creep_nethertoxin_lua:IsDebuff()
	return true
end

function modifier_creep_nethertoxin_lua:IsStunDebuff()
	return false
end

function modifier_creep_nethertoxin_lua:IsPurgable()
	return false
end

function modifier_creep_nethertoxin_lua:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.attack_slow = self:GetAbility():GetSpecialValueFor("attack_slow")

	self.owner = kv.isProvidedByAura ~= 1

	if not IsServer() then
		return
	end

	if not self.owner then
		self.damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.damage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility(),
		}
		self:StartIntervalThink(1)
	else
		self:PlayEffects()
	end
end

function modifier_creep_nethertoxin_lua:OnRefresh(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.attack_slow = self:GetAbility():GetSpecialValueFor("attack_slow")
end

function modifier_creep_nethertoxin_lua:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.owner then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_creep_nethertoxin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_creep_nethertoxin_lua:GetModifierAttackSpeedBonus_Constant()
	return -self.attack_slow
end

function modifier_creep_nethertoxin_lua:CheckState()
	local state = {
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
	}
	return state
end

function modifier_creep_nethertoxin_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
	local sound_cast = "Hero_Viper.NetherToxin.Damage"
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_creep_nethertoxin_lua:IsAura()
	return self.owner
end

function modifier_creep_nethertoxin_lua:GetModifierAura()
	return "modifier_creep_nethertoxin_lua"
end

function modifier_creep_nethertoxin_lua:GetAuraRadius()
	return self.radius
end

function modifier_creep_nethertoxin_lua:GetAuraDuration()
	return 0.5
end

function modifier_creep_nethertoxin_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_creep_nethertoxin_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_creep_nethertoxin_lua:GetEffectName()
	if not self.owner then
		return "particles/units/heroes/hero_viper/viper_nethertoxin_debuff.vpcf"
	end
end

function modifier_creep_nethertoxin_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_creep_nethertoxin_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_viper/viper_nethertoxin.vpcf"
	local sound_cast = "Hero_Viper.NetherToxin"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, self:GetParent():GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))

	self:AddParticle(effect_cast, false, false, -1, false, false)

	EmitSoundOn(sound_cast, self:GetParent())
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_corrosive_skin_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_corrosive_skin_lua_debuff", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)

creep_corrosive_skin_lua = class({})

function creep_corrosive_skin_lua:GetIntrinsicModifierName()
	return "modifier_creep_corrosive_skin_lua"
end

-----------------------------------------------------------------------------------------

modifier_creep_corrosive_skin_lua = class({})

function modifier_creep_corrosive_skin_lua:IsHidden()
	return true
end

function modifier_creep_corrosive_skin_lua:IsPurgable()
	return false
end

function modifier_creep_corrosive_skin_lua:OnCreated(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.max_range = self:GetAbility():GetSpecialValueFor("max_range")
	self.magic_resist = self:GetAbility():GetSpecialValueFor("bonus_magic_resistance")
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_corrosive_skin_lua:OnRefresh(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.max_range = self:GetAbility():GetSpecialValueFor("max_range")
	self.magic_resist = self:GetAbility():GetSpecialValueFor("bonus_magic_resistance")
end

function modifier_creep_corrosive_skin_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_creep_corrosive_skin_lua:GetModifierMagicalResistanceBonus()
	if not self:GetParent():PassivesDisabled() then
		return self.magic_resist
	end
end

function modifier_creep_corrosive_skin_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if params.attacker:GetTeamNumber() == self:GetParent():GetTeamNumber() then
		return
	end
	local distance = (params.attacker:GetOrigin() - params.unit:GetOrigin()):Length2D()
	if distance > self.max_range then
		return
	end
	params.attacker:AddNewModifier(
		self:GetParent(),
		self:GetAbility(),
		"modifier_creep_corrosive_skin_lua_debuff",
		{ duration = self.duration }
	)

	local sound_cast = "hero_viper.CorrosiveSkin"
	EmitSoundOn(sound_cast, params.attacker)
end

-----------------------------------------------------------------------------------------

modifier_creep_corrosive_skin_lua_debuff = class({})

function modifier_creep_corrosive_skin_lua_debuff:IsHidden()
	return false
end

function modifier_creep_corrosive_skin_lua_debuff:IsDebuff()
	return true
end

function modifier_creep_corrosive_skin_lua_debuff:IsStunDebuff()
	return false
end

function modifier_creep_corrosive_skin_lua_debuff:IsPurgable()
	return true
end

function modifier_creep_corrosive_skin_lua_debuff:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")

	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_REFLECTION,
	}

	self:StartIntervalThink(1)
end

function modifier_creep_corrosive_skin_lua_debuff:OnRemoved() end

function modifier_creep_corrosive_skin_lua_debuff:OnDestroy() end

function modifier_creep_corrosive_skin_lua_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_creep_corrosive_skin_lua_debuff:GetModifierAttackSpeedBonus_Constant()
	return -self.slow
end

function modifier_creep_corrosive_skin_lua_debuff:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_creep_corrosive_skin_lua_debuff:GetEffectName()
	return "particles/units/heroes/hero_viper/viper_corrosive_debuff.vpcf"
end

function modifier_creep_corrosive_skin_lua_debuff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_stone_form_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_stone_form_lua_active", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)

creep_stone_form_lua = class({})

function creep_stone_form_lua:GetIntrinsicModifierName()
	return "modifier_creep_stone_form_lua"
end

--------------------------------------------------------------------------------

modifier_creep_stone_form_lua = class({})

function modifier_creep_stone_form_lua:IsHidden()
	return true
end

function modifier_creep_stone_form_lua:IsPurgable()
	return false
end

function modifier_creep_stone_form_lua:OnCreated(kv)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
end

function modifier_creep_stone_form_lua:DeclareFunctions()
	return { MODIFIER_EVENT_ON_TAKEDAMAGE }
end

function modifier_creep_stone_form_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if not self:GetAbility():IsCooldownReady() then
		return
	end
	if self:GetParent():HasModifier("modifier_creep_stone_form_lua_active") then
		return
	end

	local health_pct = self:GetParent():GetHealthPercent()
	if health_pct < self:GetAbility():GetSpecialValueFor("threshold_pct") then
		local duration = self:GetAbility():GetSpecialValueFor("duration")
		self:GetParent():AddNewModifier(
			self:GetParent(),
			self:GetAbility(),
			"modifier_creep_stone_form_lua_active",
			{ duration = duration }
		)
		self:GetAbility():UseResources(false, false, false, true)
	end
end

--------------------------------------------------------------------------------

modifier_creep_stone_form_lua_active = class({})

function modifier_creep_stone_form_lua_active:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():EmitSound("Hero_Medusa.StoneGaze.Stun")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("hp_regen_pct")
		+ self:GetAbility():GetSpecialValueFor("diff_boost_damage")
	self:StartIntervalThink(1)
end

function modifier_creep_stone_form_lua_active:OnIntervalThink()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local heal_amount = parent:GetMaxHealth() * (self.hp_regen / 100)
	parent:Heal(heal_amount, self:GetAbility())
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, heal_amount, nil)
end

function modifier_creep_stone_form_lua_active:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_FROZEN] = true,
	}
end

function modifier_creep_stone_form_lua_active:DeclareFunctions()
	return { MODIFIER_PROPERTY_MODEL_SCALE }
end

function modifier_creep_stone_form_lua_active:GetModifierModelScale()
	return 20
end

function modifier_creep_stone_form_lua_active:GetStatusEffectName()
	return "particles/status_fx/status_effect_medusa_stone_gaze.vpcf"
end

function modifier_creep_stone_form_lua_active:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_death_pulse_lua = class({})

function creep_death_pulse_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_death_pulse_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local caster_loc = caster:GetAbsOrigin()
	local radius = self:GetSpecialValueFor("radius")
	local boost = self:GetSpecialValueFor("diff_boost_damage") or 0
	local damage_total = self:GetSpecialValueFor("damage") + boost
	local heal_total = self:GetSpecialValueFor("base_heal") + boost
	local enemy_speed = self:GetSpecialValueFor("enemy_speed")
	local ally_speed = self:GetSpecialValueFor("ally_speed")

	caster:EmitSound("Hero_Necrolyte.DeathPulse")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_loc,
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in pairs(enemies) do
		ProjectileManager:CreateTrackingProjectile({
			Target = enemy,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_necrolyte/necrolyte_pulse_enemy.vpcf",
			bDodgeable = false,
			iMoveSpeed = enemy_speed,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			ExtraData = {
				damage_to_apply = damage_total,
				is_heal = 0,
			},
		})
	end

	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster_loc,
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, ally in pairs(allies) do
		ProjectileManager:CreateTrackingProjectile({
			Target = ally,
			Source = caster,
			Ability = self,
			EffectName = "particles/units/heroes/hero_necrolyte/necrolyte_pulse_friend.vpcf",
			bDodgeable = false,
			iMoveSpeed = ally_speed,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
			ExtraData = {
				heal_to_apply = heal_total,
				is_heal = 1,
			},
		})
	end
end

function creep_death_pulse_lua:OnProjectileHit_ExtraData(target, vLocation, extraData)
	if not target or target:IsNull() then
		return
	end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end

	if extraData.is_heal == 0 then
		ApplyDamage({
			victim = target,
			attacker = caster,
			damage = extraData.damage_to_apply,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	else
		target:Heal(extraData.heal_to_apply, self)
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, target, extraData.heal_to_apply, nil)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_heartstopper_aura_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier(
	"modifier_creep_heartstopper_aura_lua_damage",
	"abilities/creeps/zone_5/zone_5",
	LUA_MODIFIER_MOTION_NONE
)

creep_heartstopper_aura_lua = class({})

function creep_heartstopper_aura_lua:GetIntrinsicModifierName()
	return "modifier_creep_heartstopper_aura_lua"
end

--------------------------------------------------------------------

modifier_creep_heartstopper_aura_lua = class({})

function modifier_creep_heartstopper_aura_lua:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_creep_heartstopper_aura_lua:GetAuraEntityReject(target)
	return false
end

function modifier_creep_heartstopper_aura_lua:GetAuraRadius()
	return self.radius
end

function modifier_creep_heartstopper_aura_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS
end

function modifier_creep_heartstopper_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_creep_heartstopper_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_creep_heartstopper_aura_lua:GetModifierAura()
	return "modifier_creep_heartstopper_aura_lua_damage"
end

function modifier_creep_heartstopper_aura_lua:IsAura()
	if self:GetCaster():PassivesDisabled() then
		return false
	end
	return true
end

function modifier_creep_heartstopper_aura_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_creep_heartstopper_aura_lua:IsHidden()
	return true
end

function modifier_creep_heartstopper_aura_lua:GetEffectName()
	return "particles/auras/aura_heartstopper.vpcf"
end

function modifier_creep_heartstopper_aura_lua:GetEffectAttachType()
	return PATTACH_POINT_FOLLOW
end

----------------------------------------------------------------------

modifier_creep_heartstopper_aura_lua_damage = class({})

function modifier_creep_heartstopper_aura_lua_damage:IsHidden()
	return false
end

function modifier_creep_heartstopper_aura_lua_damage:IsDebuff()
	return true
end

function modifier_creep_heartstopper_aura_lua_damage:IsPurgable()
	return false
end

function modifier_creep_heartstopper_aura_lua_damage:OnCreated()
	self.ability = self:GetAbility()
	if not self.ability then
		return
	end

	self.damage_pct = self.ability:GetSpecialValueFor("damage") + self.ability:GetSpecialValueFor("diff_boost_damage")
	self.heal_reduce = self.ability:GetSpecialValueFor("heal_reduce_pct")

	if IsServer() then
		self.caster = self:GetCaster()
		self.parent = self:GetParent()
		self:StartIntervalThink(0.1)
	end
end

function modifier_creep_heartstopper_aura_lua_damage:OnIntervalThink()
	if IsServer() then
		if not self.caster:PassivesDisabled() then
			local damage = self.parent:GetMaxHealth() * self.damage_pct / 1000 -- 1000 потому что 10 раз в сек
			ApplyDamage({
				attacker = self.caster,
				victim = self.parent,
				ability = self.ability,
				damage = damage,
				damage_type = DAMAGE_TYPE_PURE,
				damage_flags = DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
			})
		end
	end
end

function modifier_creep_heartstopper_aura_lua_damage:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_creep_heartstopper_aura_lua_damage:GetModifierHPRegenAmplify_Percentage()
	return -(self.heal_reduce or 0)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_reapers_scythe_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_reapers_scythe_stun", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)

creep_reapers_scythe_lua = class({})

function creep_reapers_scythe_lua:GetIntrinsicModifierName()
	return "modifier_creep_reapers_scythe_lua"
end

--------------------------------------------------------------------------------

modifier_creep_reapers_scythe_lua = class({})

function modifier_creep_reapers_scythe_lua:IsHidden()
	return true
end

function modifier_creep_reapers_scythe_lua:OnCreated()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	if not caster:HasModifier("modifier_boss_damage_boost") then
		caster:AddNewModifier(caster, self:GetAbility(), "modifier_boss_damage_boost", {})
	end
	self:StartIntervalThink(0.5)
end

function modifier_creep_reapers_scythe_lua:OnIntervalThink()
	if not IsServer() then
		return
	end
	local ability = self:GetAbility()
	local caster = self:GetCaster()

	if not ability:IsCooldownReady() or caster:IsStunned() or caster:IsSilenced() or not caster:IsAlive() then
		return
	end

	local range = ability:GetSpecialValueFor("cast_range")
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		range,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
		FIND_ANY_ORDER,
		false
	)

	local target = nil
	local min_hp_percent = 100

	for _, enemy in pairs(enemies) do
		if not enemy:IsMagicImmune() and not enemy:IsInvulnerable() then
			local current_hp = enemy:GetHealthPercent()
			if current_hp < min_hp_percent then
				min_hp_percent = current_hp
				target = enemy
			end
		end
	end

	if target and min_hp_percent >= 80 then
		target = nil
	end

	if target then
		ability:UseResources(true, false, false, true)
		caster:EmitSound("Hero_Necrolyte.ReapersScythe.Cast")
		target:EmitSound("Hero_Necrolyte.ReapersScythe.Target")
		local duration = ability:GetSpecialValueFor("stun_duration")
		target:AddNewModifier(caster, ability, "modifier_creep_reapers_scythe_stun", { duration = duration })
	end
end

--------------------------------------------------------------------------------

modifier_creep_reapers_scythe_stun = class({})

function modifier_creep_reapers_scythe_stun:IsPurgable()
	return false
end

function modifier_creep_reapers_scythe_stun:OnCreated()
	if not IsServer() then
		return
	end
	local target = self:GetParent()
	local caster = self:GetCaster()
	local scythe_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControlEnt(
		scythe_fx,
		0,
		caster,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		caster:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		scythe_fx,
		1,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		target:GetAbsOrigin(),
		true
	)
	self:AddParticle(scythe_fx, false, false, -1, false, false)
end

function modifier_creep_reapers_scythe_stun:CheckState()
	return { [MODIFIER_STATE_STUNNED] = true }
end

function modifier_creep_reapers_scythe_stun:OnDestroy()
	if not IsServer() then
		return
	end
	local target = self:GetParent()
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not target:IsAlive() or not ability then
		return
	end

	local damage_per_missing_hp = ability:GetSpecialValueFor("damage_per_missing_hp")
	local boost = ability:GetSpecialValueFor("diff_boost_damage")
	local missing_hp = target:GetMaxHealth() - target:GetHealth()

	local total_damage = missing_hp * (damage_per_missing_hp + boost)

	ApplyDamage({
		victim = target,
		attacker = caster,
		damage = total_damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = ability,
	})

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, target, total_damage, nil)
end

function modifier_creep_reapers_scythe_stun:GetEffectName()
	return "particles/units/heroes/hero_necrolyte/necrolyte_scythe.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

creep_purification_lua = class({})

function creep_purification_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf", context)
end

function creep_purification_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function creep_purification_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function creep_purification_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local heal = self:GetSpecialValueFor("heal") + self:GetSpecialValueFor("diff_boost_damage")
	local radius = self:GetSpecialValueFor("radius")

	target:Heal(heal, self)

	local enemies = FindUnitsInRadius(
		self:GetCaster():GetTeamNumber(),
		target:GetOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	local damageTable = {
		attacker = caster,
		damage = heal,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self,
	}
	for _, enemy in pairs(enemies) do
		damageTable.victim = enemy
		ApplyDamage(damageTable)
		self:PlayEffects2(target, enemy)
	end

	self:PlayEffects1(target, radius)
end

function creep_purification_lua:PlayEffects1(target, radius)
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf"
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf"
	local sound_target = "Hero_Omniknight.Purification"

	local effect_target = ParticleManager:CreateParticle(particle_target, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_target, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_target)
	EmitSoundOn(sound_target, target)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function creep_purification_lua:PlayEffects2(origin, target)
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf"
	local effect_target = ParticleManager:CreateParticle(particle_target, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		effect_target,
		0,
		origin,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		origin:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_target,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_target)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_creep_degen_aura_lua", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_creep_degen_aura_lua_effect", "abilities/creeps/zone_5/zone_5", LUA_MODIFIER_MOTION_NONE)

creep_degen_aura_lua = class({})

function creep_degen_aura_lua:GetIntrinsicModifierName()
	return "modifier_creep_degen_aura_lua"
end

--------------------------------------------------------------------------------

modifier_creep_degen_aura_lua = class({})

function modifier_creep_degen_aura_lua:IsHidden()
	return true
end

function modifier_creep_degen_aura_lua:IsDebuff()
	return false
end

function modifier_creep_degen_aura_lua:IsPurgable()
	return false
end

function modifier_creep_degen_aura_lua:IsAura()
	return true
end

function modifier_creep_degen_aura_lua:GetModifierAura()
	return "modifier_creep_degen_aura_lua_effect"
end

function modifier_creep_degen_aura_lua:GetAuraRadius()
	return self.radius
end

function modifier_creep_degen_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_creep_degen_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_creep_degen_aura_lua:GetAuraSearchFlags()
	return 0
end

function modifier_creep_degen_aura_lua:GetAuraDuration()
	return 0.5
end

function modifier_creep_degen_aura_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_creep_degen_aura_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))

	self:AddParticle(effect_cast, false, false, -1, false, false)
end

--------------------------------------------------------------------------------

modifier_creep_degen_aura_lua_effect = class({})

function modifier_creep_degen_aura_lua_effect:IsHidden()
	return false
end

function modifier_creep_degen_aura_lua_effect:IsDebuff()
	return true
end

function modifier_creep_degen_aura_lua_effect:IsPurgable()
	return false
end

function modifier_creep_degen_aura_lua_effect:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_bonus")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("speed_bonus")
end

function modifier_creep_degen_aura_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_creep_degen_aura_lua_effect:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end

function modifier_creep_degen_aura_lua_effect:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_creep_degen_aura_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_creep_degen_aura_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end