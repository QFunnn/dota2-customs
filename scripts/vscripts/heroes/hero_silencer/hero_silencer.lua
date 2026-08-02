--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_silencer_arcane_curse_lua", "heroes/hero_silencer/hero_silencer", LUA_MODIFIER_MOTION_NONE)

silencer_arcane_curse_lua = class({})

function silencer_arcane_curse_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function silencer_arcane_curse_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local duration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_silencer_arcane_curse_lua", { duration = duration })
	end

	self:PlayEffects1()
	self:PlayEffects2(point, radius)
end

function silencer_arcane_curse_lua:PlayEffects1()
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_curse_cast.vpcf"
	local sound_cast = "Hero_Silencer.Curse.Cast"

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
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

function silencer_arcane_curse_lua:PlayEffects2(point, radius)
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_curse_aoe.vpcf"
	local sound_cast = "Hero_Silencer.Curse"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(effect_cast, 0, point)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(effect_cast)

	-- EmitSoundOnLocationWithCaster( point, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

-------------------------------------------------------------------------------------------

modifier_silencer_arcane_curse_lua = class({})

function modifier_silencer_arcane_curse_lua:IsHidden()
	return false
end

function modifier_silencer_arcane_curse_lua:IsDebuff()
	return true
end

function modifier_silencer_arcane_curse_lua:IsStunDebuff()
	return false
end

function modifier_silencer_arcane_curse_lua:IsPurgable()
	return true
end

function modifier_silencer_arcane_curse_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_silencer_arcane_curse_lua:OnCreated(kv)
	self.penalty = self:GetAbility():GetSpecialValueFor("penalty_duration")
	self.slow = -self:GetAbility():GetSpecialValueFor("movespeed")

	if not IsServer() then
		return
	end

	local damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	self.interval = 1

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}

	self:StartIntervalThink(self.interval)

	local sound_cast = "Hero_Silencer.Curse.Impact"
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_silencer_arcane_curse_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_silencer_arcane_curse_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_silencer_arcane_curse_lua:OnAbilityFullyCast(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if params.ability:IsItem() then
		return
	end
	self:SetDuration(self:GetRemainingTime() + self.penalty, true)
end

function modifier_silencer_arcane_curse_lua:OnIntervalThink()
	if self:GetParent():IsSilenced() then
		self:SetDuration(self:GetRemainingTime() + self.interval, true)
		return
	end

	ApplyDamage(self.damageTable)

	local sound_cast = "Hero_Silencer.Curse_Tick"
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_silencer_arcane_curse_lua:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_curse.vpcf"
end

function modifier_silencer_arcane_curse_lua:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_generic_orb_effect_lua",
	"heroes/generic/modifier_generic_orb_effect_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_silencer_glaives_of_wisdom_lua",
	"heroes/hero_silencer/hero_silencer",
	LUA_MODIFIER_MOTION_NONE
)

silencer_glaives_of_wisdom_lua = class({})

function silencer_glaives_of_wisdom_lua:GetManaCost(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_silencer_4")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetManaCost(self, level) - 40
	end
	return self.BaseClass.GetManaCost(self, level)
end

function silencer_glaives_of_wisdom_lua:GetIntrinsicModifierName()
	return "modifier_silencer_glaives_of_wisdom_lua"
end

function silencer_glaives_of_wisdom_lua:GetProjectileName()
	return "particles/units/heroes/hero_silencer/silencer_glaives_of_wisdom.vpcf"
end

function silencer_glaives_of_wisdom_lua:OnOrbFire(params)
	local sound_cast = "Hero_Silencer.GlaivesOfWisdom"
	EmitSoundOn(sound_cast, self:GetCaster())
end

function silencer_glaives_of_wisdom_lua:OnOrbImpact(params)
	local caster = self:GetCaster()

	local int_mult = self:GetSpecialValueFor("intellect_damage_pct")
	local damage = caster:GetIntellect(true) * int_mult / 100

	local damageTable = {
		victim = params.target,
		attacker = caster,
		damage = damage,
		damage_type = self:GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		ability = self,
	}
	ApplyDamage(damageTable)

	SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.target, damage, nil)

	local sound_cast = "Hero_Silencer.GlaivesOfWisdom.Damage"
	EmitSoundOn(sound_cast, params.target)
end

-------------------------------------------------------------------------------------------

modifier_silencer_glaives_of_wisdom_lua = class({})

function modifier_silencer_glaives_of_wisdom_lua:IsHidden()
	return false
end

function modifier_silencer_glaives_of_wisdom_lua:IsDebuff()
	return false
end

function modifier_silencer_glaives_of_wisdom_lua:IsPurgable()
	return false
end

function modifier_silencer_glaives_of_wisdom_lua:OnCreated(kv)
	if not IsServer() then
		return
	end

	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_generic_orb_effect_lua", {})
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_silencer_last_word_lua", "heroes/hero_silencer/hero_silencer", LUA_MODIFIER_MOTION_NONE)

silencer_last_word_lua = class({})

function silencer_last_word_lua:GetAOERadius()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_silencer_5")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return self:GetSpecialValueFor("radius")
	end
	return 0
end

function silencer_last_word_lua:GetBehavior()
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_silencer_5")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	end

	return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function silencer_last_word_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("debuff_duration")

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_silencer_5")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		local radius = self:GetSpecialValueFor("radius")
		local target_point = self:GetCursorPosition()
		local units = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target_point,
			nil,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, unit in pairs(units) do
			unit:AddNewModifier(caster, self, "modifier_silencer_last_word_lua", { duration = duration })
			self:PlayEffects(unit)
		end
	else
		local target = self:GetCursorTarget()
		target:AddNewModifier(caster, self, "modifier_silencer_last_word_lua", { duration = duration })
		self:PlayEffects(target)
	end
end

function silencer_last_word_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_last_word_status_cast.vpcf"
	local sound_cast = "Hero_Silencer.LastWord.Cast"

	local direction = target:GetOrigin() - self:GetCaster():GetOrigin()
	direction.z = 0
	direction = direction:Normalized()

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
	ParticleManager:SetParticleControlForward(effect_cast, 1, direction)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetCaster())
end

-------------------------------------------------------------------------------------------

modifier_silencer_last_word_lua = class({})

function modifier_silencer_last_word_lua:IsHidden()
	return false
end

function modifier_silencer_last_word_lua:IsDebuff()
	return true
end

function modifier_silencer_last_word_lua:IsStunDebuff()
	return false
end

function modifier_silencer_last_word_lua:IsPurgable()
	return true
end

function modifier_silencer_last_word_lua:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_silencer_last_word_lua:OnCreated(kv)
	self.duration = self:GetAbility():GetSpecialValueFor("duration")

	if not IsServer() then
		return
	end

	self.damage = self:GetAbility():GetSpecialValueFor("damage")
		+ self:GetCaster():ExtraIntelligenceDamage()
			* self:GetAbility():GetSpecialValueFor("ExtraIntelligenceDamage")

	self:StartIntervalThink(kv.duration)

	local sound_cast = "Hero_Silencer.LastWord.Target"
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_silencer_last_word_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION,
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_silencer_last_word_lua:GetModifierProvidesFOWVision()
	return 1
end

function modifier_silencer_last_word_lua:OnAbilityFullyCast(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if params.ability:IsItem() then
		return
	end

	self:Silence()
end

function modifier_silencer_last_word_lua:OnIntervalThink()
	self:Silence()
end

function modifier_silencer_last_word_lua:Silence()
	self:GetParent()
		:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_silence", { duration = self.duration })

	local damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = self.damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self:GetAbility(),
	}
	ApplyDamage(damageTable)

	self:PlayEffects()

	local sound_cast = "Hero_Silencer.LastWord.Target"
	StopSoundOn(sound_cast, self:GetParent())

	self:Destroy()
end

function modifier_silencer_last_word_lua:GetEffectName()
	return "particles/units/heroes/hero_silencer/silencer_last_word_status.vpcf"
end

function modifier_silencer_last_word_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_silencer_last_word_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_silencer/silencer_last_word_dmg.vpcf"
	local sound_cast = "Hero_Silencer.LastWord.Damage"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, self:GetParent())
end

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_silencer_infinite_int_lua", "heroes/hero_silencer/hero_silencer", LUA_MODIFIER_MOTION_NONE)

silencer_infinite_int_lua = class({})

function silencer_infinite_int_lua:GetIntrinsicModifierName()
	return "modifier_silencer_infinite_int_lua"
end

-------------------------------------------------------------------------------------------

modifier_silencer_infinite_int_lua = class({})

function modifier_silencer_infinite_int_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_silencer_infinite_int_lua:OnDeath(params)
	local parent = self:GetParent()
	if self:GetStackCount() < self:GetAbility():GetSpecialValueFor("max_stack_count") then
		if IsMyKilledBadGuys2(parent, params) then
			self:IncrementStackCount()
			parent:CalculateStatBonus(true)
		end
	end
end

function modifier_silencer_infinite_int_lua:GetModifierBonusStats_Intellect(params)
	silencer_bonus_int = self:GetAbility():GetSpecialValueFor("stack_bonus_int")
	return self:GetStackCount() * silencer_bonus_int + self:GetAbility():GetSpecialValueFor("bonus_int")
end

function modifier_silencer_infinite_int_lua:IsHidden()
	return false
end

function modifier_silencer_infinite_int_lua:IsPurgable()
	return false
end

function modifier_silencer_infinite_int_lua:RemoveOnDeath()
	return false
end

function modifier_silencer_infinite_int_lua:OnCreated(kv) end

function IsMyKilledBadGuys2(hero, params)
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