--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


lua_abyssal_underlord_firestorm = lua_abyssal_underlord_firestorm or class({})

LinkLuaModifier(
	"modifier_lua_abyssal_underlord_firestorm",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_firestorm_thinker",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_firestorm_slow",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)

function lua_abyssal_underlord_firestorm:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function lua_abyssal_underlord_firestorm:OnAbilityPhaseStart()
	local point = self:GetCursorPosition()
	self:PlayEffects(point)
	return true
end

function lua_abyssal_underlord_firestorm:OnAbilityPhaseInterrupted()
	self:StopEffects()
end

function lua_abyssal_underlord_firestorm:OnSpellStart()
	if not IsServer() then
		return
	end
	self:StopEffects()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	CreateModifierThinker(
		caster,
		self,
		"modifier_lua_abyssal_underlord_firestorm_thinker",
		{},
		point,
		caster:GetTeamNumber(),
		false
	)
end

function lua_abyssal_underlord_firestorm:PlayEffects(point)
	local radius = self:GetSpecialValueFor("radius")
	self.effect_cast = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster(),
		self:GetCaster():GetTeamNumber()
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, point)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(2, 2, 2))
	local sound_cast = "Hero_AbyssalUnderlord.Firestorm.Start"
	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function lua_abyssal_underlord_firestorm:StopEffects()
	ParticleManager:DestroyParticle(self.effect_cast, true)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

--------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_firestorm_thinker = modifier_lua_abyssal_underlord_firestorm_thinker or class({})

function modifier_lua_abyssal_underlord_firestorm_thinker:IsHidden()
	return true
end

function modifier_lua_abyssal_underlord_firestorm_thinker:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_firestorm_thinker:OnCreated(kv)
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	local damage = self.ability:GetSpecialValueFor("wave_damage")
	self.radius = self.ability:GetSpecialValueFor("radius")
	self.count = self.ability:GetSpecialValueFor("wave_count")
	self.interval = self.ability:GetSpecialValueFor("wave_interval")
	if not IsServer() then
		return
	end

	self.wave = 0
	self.damageTable = {
		attacker = self.caster,
		damage = damage,
		damage_type = self.ability:GetAbilityDamageType(),
		ability = self.ability,
	}
	self:StartIntervalThink(0)
end

function modifier_lua_abyssal_underlord_firestorm_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_lua_abyssal_underlord_firestorm_thinker:OnIntervalThink()
	if not self.delayed then
		self.delayed = true
		self:StartIntervalThink(self.interval)
		self:OnIntervalThink()
		return
	end

	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage(self.damageTable)

		local modifier = enemy:AddNewModifier(
			self.caster,
			self.ability,
			"modifier_lua_abyssal_underlord_firestorm_slow",
			{ duration = 1 }
		)

		-- local modifier = enemy:AddNewModifier(self.caster, self.ability, "modifier_lua_abyssal_underlord_firestorm", {duration = self.burn_duration})
	end

	self:PlayEffects()

	self.wave = self.wave + 1
	if self.wave >= self.count then
		self:Destroy()
	end
end

function modifier_lua_abyssal_underlord_firestorm_thinker:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, self.parent:GetOrigin())
	ParticleManager:SetParticleControl(effect_cast, 4, Vector(self.radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	EmitSoundOn("Hero_AbyssalUnderlord.Firestorm", self.parent)
end

--------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_firestorm_slow = class({})

function modifier_lua_abyssal_underlord_firestorm_slow:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_firestorm_slow:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_firestorm_slow:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_firestorm_slow:OnCreated(kv) end

function modifier_lua_abyssal_underlord_firestorm_slow:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_lua_abyssal_underlord_firestorm_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow")
end

--------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_firestorm = modifier_lua_abyssal_underlord_firestorm or class({})

function modifier_lua_abyssal_underlord_firestorm:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_firestorm:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_firestorm:IsStunDebuff()
	return false
end

function modifier_lua_abyssal_underlord_firestorm:IsPurgable()
	return true
end

function modifier_lua_abyssal_underlord_firestorm:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage_type = DAMAGE_TYPE_PURE,
		damage = self:GetAbility():GetSpecialValueFor("wave_damage"),
		ability = self:GetAbility(),
	}
	self:StartIntervalThink(self:GetAbility():GetSpecialValueFor("burn_interval"))
end

function modifier_lua_abyssal_underlord_firestorm:OnIntervalThink()
	ApplyDamage(self.damageTable)
end

function modifier_lua_abyssal_underlord_firestorm:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave_burn.vpcf"
end

function modifier_lua_abyssal_underlord_firestorm:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

lua_abyssal_underlord_pit_of_malice = lua_abyssal_underlord_pit_of_malice or class({})

LinkLuaModifier(
	"modifier_lua_abyssal_underlord_pit_of_malice",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_pit_of_malice_cooldown",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_pit_of_malice_thinker",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)

function lua_abyssal_underlord_pit_of_malice:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function lua_abyssal_underlord_pit_of_malice:OnAbilityPhaseStart()
	self.point = self:GetCursorPosition()
	self:PlayEffects(self.point, true)
	return true
end

function lua_abyssal_underlord_pit_of_malice:OnAbilityPhaseInterrupted()
	ParticleManager:DestroyParticle(self.effect_cast, true)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
end

function lua_abyssal_underlord_pit_of_malice:OnSpellStart()
	if not IsServer() then
		return
	end
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("pit_duration")
	CreateModifierThinker(
		caster,
		self,
		"modifier_lua_abyssal_underlord_pit_of_malice_thinker",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
end

function lua_abyssal_underlord_pit_of_malice:PlayEffects(point, bPlaySound)
	local radius = self:GetSpecialValueFor("radius")
	self.effect_cast = ParticleManager:CreateParticleForTeam(
		"particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster(),
		self:GetCaster():GetTeamNumber()
	)
	ParticleManager:SetParticleControl(self.effect_cast, 0, point)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(radius, 1, 1))
	if bPlaySound and bPlaySound == true then
		local sound_cast = "Hero_AbyssalUnderlord.PitOfMalice.Start"
		-- EmitSoundOnLocationForAllies( point, sound_cast, self:GetCaster() )
		EmitSoundOn(sound_cast, self:GetCaster())
	end
end

--------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_pit_of_malice_thinker = modifier_lua_abyssal_underlord_pit_of_malice_thinker or class({})

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:IsDebuff()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.duration = self:GetAbility():GetSpecialValueFor("ensnare_duration")

	if not IsServer() then
		return
	end
	self.caster = self:GetCaster()
	self.parent = self:GetParent()

	self:StartIntervalThink(0.033)
	self:OnIntervalThink()
	self:PlayEffects()
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:OnRemoved()
	if not IsServer() then
		return
	end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:OnDestroy()
	if not IsServer() then
		return
	end
	UTIL_Remove(self:GetParent())
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:OnIntervalThink()
	local enemies = FindUnitsInRadius(
		self.caster:GetTeamNumber(),
		self.parent:GetOrigin(),
		self.parent,
		self.radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)
	for _, enemy in pairs(enemies) do
		local modifier =
			enemy:FindModifierByNameAndCaster("modifier_lua_abyssal_underlord_pit_of_malice_cooldown", self:GetCaster())
		if not modifier then
			enemy:AddNewModifier(
				self.caster,
				self:GetAbility(),
				"modifier_lua_abyssal_underlord_pit_of_malice",
				{ duration = self.duration }
			)
			self:PlayEffects()
		end
	end
end

function modifier_lua_abyssal_underlord_pit_of_malice_thinker:PlayEffects()
	local parent = self:GetParent()
	self.radius = self:GetAbility():GetSpecialValueFor("radius")

	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end

	self.pfx = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(self.pfx, 0, parent:GetOrigin())
	ParticleManager:SetParticleControl(self.pfx, 1, Vector(self.radius, 1, 1))
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self:GetDuration(), 0, 0))

	EmitSoundOn("Hero_AbyssalUnderlord.PitOfMalice", parent)
end

--------------------------------------------------------------------------------
modifier_lua_abyssal_underlord_pit_of_malice_cooldown = modifier_lua_abyssal_underlord_pit_of_malice_cooldown
	or class({})

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:IsHidden()
	return true
end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:OnCreated(kv) end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:OnRefresh(kv) end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:OnRemoved() end

function modifier_lua_abyssal_underlord_pit_of_malice_cooldown:OnDestroy() end

--------------------------------------------------------------------------------
modifier_lua_abyssal_underlord_pit_of_malice = modifier_lua_abyssal_underlord_pit_of_malice or class({})

function modifier_lua_abyssal_underlord_pit_of_malice:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_pit_of_malice:IsStunDebuff()
	return false
end

function modifier_lua_abyssal_underlord_pit_of_malice:IsPurgable()
	return true
end

function modifier_lua_abyssal_underlord_pit_of_malice:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_lua_abyssal_underlord_pit_of_malice:OnCreated(kv)
	local interval = self:GetAbility():GetSpecialValueFor("pit_interval")
	if not IsServer() then
		return
	end

	ApplyDamage({
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage_type = DAMAGE_TYPE_PURE,
		damage = self:GetAbility():GetSpecialValueFor("pit_damage"),
		ability = self:GetAbility(),
	})

	self:GetParent():AddNewModifier(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_lua_abyssal_underlord_pit_of_malice_cooldown",
		{ duration = interval }
	)
	EmitSoundOn("Hero_AbyssalUnderlord.Pit.Target", self:GetParent())
end

function modifier_lua_abyssal_underlord_pit_of_malice:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = false,
		[MODIFIER_STATE_ROOTED] = true,
	}
	return state
end

function modifier_lua_abyssal_underlord_pit_of_malice:GetEffectName()
	return "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf"
end

function modifier_lua_abyssal_underlord_pit_of_malice:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

lua_abyssal_underlord_atrophy_aura = lua_abyssal_underlord_atrophy_aura or class({})
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura_debuff",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura_stack",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura_permanent_stack",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura_scepter",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_atrophy_aura_active",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)

function lua_abyssal_underlord_atrophy_aura:GetIntrinsicModifierName()
	return "modifier_lua_abyssal_underlord_atrophy_aura"
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_atrophy_aura = modifier_lua_abyssal_underlord_atrophy_aura or class({})

function modifier_lua_abyssal_underlord_atrophy_aura:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_lua_abyssal_underlord_atrophy_aura:IsDebuff()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:IsStunDebuff()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_lua_abyssal_underlord_atrophy_aura:RemoveOnDeath()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:DestroyOnExpire()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.creep_bonus = self:GetAbility():GetSpecialValueFor("bonus_damage_from_creep")
	self.duration = self:GetAbility():GetSpecialValueFor("bonus_damage_duration")
end

function modifier_lua_abyssal_underlord_atrophy_aura:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	self.creep_bonus = self:GetAbility():GetSpecialValueFor("bonus_damage_from_creep")
	self.duration = self:GetAbility():GetSpecialValueFor("bonus_damage_duration")
end

function modifier_lua_abyssal_underlord_atrophy_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_lua_abyssal_underlord_atrophy_aura:OnDeath(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if parent:PassivesDisabled() then
		return
	end
	if params.unit:IsIllusion() then
		return
	end
	if not params.unit:FindModifierByNameAndCaster("modifier_lua_abyssal_underlord_atrophy_aura_debuff", parent) then
		return
	end

	bonus = self.creep_bonus
	duration = self.duration

	if not IsMyKilledBadGuys(parent, params) then
		return
	end

	self:SetStackCount(self:GetStackCount() + bonus)

	local modifier = parent:AddNewModifier(
		parent,
		self:GetAbility(),
		"modifier_lua_abyssal_underlord_atrophy_aura_stack",
		{ duration = duration }
	)
	modifier.parent = self
	modifier.bonus = bonus

	self:SetDuration(self.duration, true)
end

function IsMyKilledBadGuys(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end

	return true
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetModifierPreAttack_BonusDamage()
	return self:GetStackCount()
end

function modifier_lua_abyssal_underlord_atrophy_aura:RemoveStack(value)
	self:SetStackCount(self:GetStackCount() - value)
end

function modifier_lua_abyssal_underlord_atrophy_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetModifierAura()
	return "modifier_lua_abyssal_underlord_atrophy_aura_debuff"
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraRadius()
	return self.radius
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraDuration()
	return 0.5
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_lua_abyssal_underlord_atrophy_aura:IsAuraActiveOnDeath()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura:GetAuraEntityReject(hEntity)
	if IsServer() then
		if hEntity == self:GetCaster() then
			return true
		end
	end
	return false
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_atrophy_aura_debuff = modifier_lua_abyssal_underlord_atrophy_aura_debuff or class({})

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:IsStunDebuff()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:IsPurgable()
	return true
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:OnCreated(kv)
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction_pct")
	if not IsServer() then
		return
	end
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:OnRefresh(kv)
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction_pct")
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_lua_abyssal_underlord_atrophy_aura_debuff:GetModifierBaseDamageOutgoing_Percentage(params)
	return -self.reduction
end

--------------------------------------------------------------------------------

modifier_lua_abyssal_underlord_atrophy_aura_stack = modifier_lua_abyssal_underlord_atrophy_aura_stack or class({})

function modifier_lua_abyssal_underlord_atrophy_aura_stack:IsHidden()
	return true
end

function modifier_lua_abyssal_underlord_atrophy_aura_stack:IsDebuff()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura_stack:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura_stack:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_lua_abyssal_underlord_atrophy_aura_stack:RemoveOnDeath()
	return false
end

function modifier_lua_abyssal_underlord_atrophy_aura_stack:OnDestroy()
	if not IsServer() then
		return
	end
	self.parent:RemoveStack(self.bonus)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------

lua_abyssal_underlord_dark_rift = class({})

function lua_abyssal_underlord_dark_rift:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_underlord_8")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 30
	end
	return self.BaseClass.GetCooldown(self, level)
end

LinkLuaModifier(
	"modifier_lua_abyssal_underlord_dark_rift",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_lua_abyssal_underlord_dark_rift_effect",
	"heroes/hero_underlord/hero_underlord",
	LUA_MODIFIER_MOTION_NONE
)

function lua_abyssal_underlord_dark_rift:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor("duration")

	CreateModifierThinker(
		caster,
		self,
		"modifier_lua_abyssal_underlord_dark_rift",
		{ duration = duration },
		point,
		caster:GetTeamNumber(),
		false
	)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------
modifier_lua_abyssal_underlord_dark_rift = modifier_lua_abyssal_underlord_dark_rift or class({})

function modifier_lua_abyssal_underlord_dark_rift:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_dark_rift:IsDebuff()
	return false
end

function modifier_lua_abyssal_underlord_dark_rift:IsPurgable()
	return false
end

function modifier_lua_abyssal_underlord_dark_rift:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_lua_abyssal_underlord_dark_rift:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
	if not IsServer() then
		return
	end
	self.success = true
	self:PlayEffects1()
	self:PlayEffects2()
end

function modifier_lua_abyssal_underlord_dark_rift:PlayEffects1()
	local parent = self:GetParent()

	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/abyssal_underlord_darkrift_target.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		6,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	EmitSoundOn("Hero_AbyssalUnderlord.DarkRift.Target", parent)
end

function modifier_lua_abyssal_underlord_dark_rift:PlayEffects2()
	local caster = self:GetCaster()
	local parent = self:GetParent()

	self.effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/heroes_underlord/abbysal_underlord_darkrift_ambient.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		parent
	)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self.radius, 0, 0))
	ParticleManager:SetParticleControlEnt(
		self.effect_cast,
		2,
		parent,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0), -- unknown
		true -- unknown, true
	)

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn("Hero_AbyssalUnderlord.DarkRift.Cast", parent)
end

function modifier_lua_abyssal_underlord_dark_rift:IsAura()
	return true
end
function modifier_lua_abyssal_underlord_dark_rift:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end
function modifier_lua_abyssal_underlord_dark_rift:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end
function modifier_lua_abyssal_underlord_dark_rift:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end
function modifier_lua_abyssal_underlord_dark_rift:GetAuraRadius()
	return self.radius
end
function modifier_lua_abyssal_underlord_dark_rift:GetModifierAura()
	return "modifier_lua_abyssal_underlord_dark_rift_effect"
end

------------------------------------------------

modifier_lua_abyssal_underlord_dark_rift_effect = modifier_lua_abyssal_underlord_dark_rift_effect or class({})

function modifier_lua_abyssal_underlord_dark_rift_effect:IsHidden()
	return false
end

function modifier_lua_abyssal_underlord_dark_rift_effect:IsDebuff()
	return true
end

function modifier_lua_abyssal_underlord_dark_rift_effect:IsStunDebuff()
	return false
end

function modifier_lua_abyssal_underlord_dark_rift_effect:IsPurgable()
	return true
end

function modifier_lua_abyssal_underlord_dark_rift_effect:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function modifier_lua_abyssal_underlord_dark_rift_effect:OnCreated(kv)
	self.hr_regen = self:GetAbility():GetSpecialValueFor("hr_regen")
	self.armor = self:GetAbility():GetSpecialValueFor("armor")
	self.resist = self:GetAbility():GetSpecialValueFor("resist")
	if not IsServer() then
		return
	end
end

function modifier_lua_abyssal_underlord_dark_rift_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end

function modifier_lua_abyssal_underlord_dark_rift_effect:GetModifierHealthRegenPercentage(params)
	return self.hr_regen
end

function modifier_lua_abyssal_underlord_dark_rift_effect:GetModifierPhysicalArmorBonus(params)
	return self.armor
end

function modifier_lua_abyssal_underlord_dark_rift_effect:GetModifierMagicalResistanceBonus(params)
	return self.resist
end