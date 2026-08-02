--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_axe_berserkers_call_lua", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_axe_berserkers_call_lua_debuff", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)

axe_berserkers_call_lua = class({})

function axe_berserkers_call_lua:OnAbilityPhaseInterrupted()
	local sound_cast = "Hero_Axe.BerserkersCall.Start"
	StopSoundOn(sound_cast, self:GetCaster())
end

function axe_berserkers_call_lua:OnAbilityPhaseStart()
	local sound_cast = "Hero_Axe.BerserkersCall.Start"
	EmitSoundOn(sound_cast, self:GetCaster())
	return true
end

function axe_berserkers_call_lua:OnSpellStart()
	local caster = self:GetCaster()
	local point = caster:GetOrigin()

	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		point,
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_axe_berserkers_call_lua_debuff", { duration = duration })
	end

	caster:AddNewModifier(caster, self, "modifier_axe_berserkers_call_lua", { duration = duration })

	EmitSoundOn("Hero_Axe.Berserkers_Call", self:GetCaster())
	self:PlayEffects()
end

function axe_berserkers_call_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetCaster()
	)

	ParticleManager:SetParticleControlEnt(
		effect_cast,
		1,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_mouth",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

--------------------------------------------------------------------------------

modifier_axe_berserkers_call_lua = class({})

function modifier_axe_berserkers_call_lua:IsHidden()
	return false
end

function modifier_axe_berserkers_call_lua:IsDebuff()
	return false
end

function modifier_axe_berserkers_call_lua:IsPurgable()
	return true
end

function modifier_axe_berserkers_call_lua:OnCreated(kv)
	self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_axe_berserkers_call_lua:OnRefresh(kv)
	self.armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_axe_berserkers_call_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}

	return funcs
end

function modifier_axe_berserkers_call_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end

function modifier_axe_berserkers_call_lua:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_axe_berserkers_call_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------

modifier_axe_berserkers_call_lua_debuff = class({})

function modifier_axe_berserkers_call_lua_debuff:IsHidden()
	return false
end

function modifier_axe_berserkers_call_lua_debuff:IsDebuff()
	return true
end

function modifier_axe_berserkers_call_lua_debuff:IsStunDebuff()
	return false
end

function modifier_axe_berserkers_call_lua_debuff:IsPurgable()
	return false
end

function modifier_axe_berserkers_call_lua_debuff:OnCreated(kv)
	if IsServer() then
		self:GetParent():SetForceAttackTarget(self:GetCaster())
		self:GetParent():MoveToTargetToAttack(self:GetCaster())
	end
end

function modifier_axe_berserkers_call_lua_debuff:OnRemoved()
	if IsServer() then
		self:GetParent():SetForceAttackTarget(nil)
	end
end

function modifier_axe_berserkers_call_lua_debuff:CheckState()
	local state = {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
	}

	return state
end

function modifier_axe_berserkers_call_lua_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_axe_counter_helix_lua", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)

axe_counter_helix_lua = class({})

function axe_counter_helix_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_axe_6")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 0.2
	end
	return self.BaseClass.GetCooldown(self, level)
end

function axe_counter_helix_lua:GetIntrinsicModifierName()
	return "modifier_axe_counter_helix_lua"
end

--------------------------------------------------------------------------------

modifier_axe_counter_helix_lua = class({})

function modifier_axe_counter_helix_lua:IsHidden()
	return true
end

function modifier_axe_counter_helix_lua:IsPurgable()
	return false
end

function modifier_axe_counter_helix_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_axe_counter_helix_lua:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if not ability or not caster or caster:PassivesDisabled() or not ability:IsFullyCastable() then
		return
	end

	local chance = ability:GetSpecialValueFor("chance")
	local radius = ability:GetSpecialValueFor("AbilityCastRange")
	local damage = ability:GetSpecialValueFor("damage")
	local hero_damage = ability:GetSpecialValueFor("hero_damage") * caster:GetBaseDamageMin() / 100

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_axe_5")
	if talent and talent:GetLevel() > 0 and caster:HasModifier("modifier_axe_berserkers_call_lua") then
		chance = 100
	end

	local is_attacking = false
	local is_being_attacked = params.target == caster and params.attacker:GetTeamNumber() ~= caster:GetTeamNumber()

	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_axe_8")
	if talent and talent:GetLevel() > 0 and params.attacker == caster then
		is_attacking = true
	end

	if not (is_being_attacked or is_attacking) then
		return
	end

	if params.attacker:IsOther() then
		return
	end

	if RandomInt(1, 100) <= chance then
		local true_damage = hero_damage + damage

		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			caster:GetAbsOrigin(),
			caster,
			radius,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
			FIND_ANY_ORDER,
			false
		)

		local damageTable = {
			attacker = caster,
			damage = true_damage,
			damage_type = ability:GetAbilityDamageType(),
			ability = ability,
			damage_flags = DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
		}

		for _, enemy in pairs(enemies) do
			damageTable.victim = enemy
			ApplyDamage(damageTable)
		end

		if not caster:HasModifier("modifier_axe_enrage_lua") then
			ability:UseResources(false, false, false, true)
		end

		self:PlayEffects()
	end
end

function modifier_axe_counter_helix_lua:PlayEffects2(target)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_skeletonking/wraith_king_vampiric_aura_lifesteal.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		target
	)
	ParticleManager:SetParticleControl(effect_cast, 1, target:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function modifier_axe_counter_helix_lua:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_counterhelix.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	local effect_cast2 = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_axe/axe_attack_blur_counterhelix.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	ParticleManager:ReleaseParticleIndex(effect_cast2)

	EmitSoundOn("Hero_Axe.CounterHelix", self:GetParent())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_axe_blood_lua", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_axe_blood_lua_stacks", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)

axe_blood_lua = class({})

function axe_blood_lua:GetIntrinsicModifierName()
	return "modifier_axe_blood_lua"
end

--------------------------------------------------------------------------------

modifier_axe_blood_lua = class({})

function modifier_axe_blood_lua:IsHidden()
	return true
end
function modifier_axe_blood_lua:IsPurgable()
	return false
end
function modifier_axe_blood_lua:RemoveOnDeath()
	return false
end

function modifier_axe_blood_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFIER,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_axe_blood_lua:GetModifierMagicalResistanceDirectModifier()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("mag_armor")
	end
end

function modifier_axe_blood_lua:OnDeath(params)
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local ability = self:GetAbility()

	if params.attacker ~= caster or caster:PassivesDisabled() then
		return
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return
	end

	local duration = ability:GetSpecialValueFor("duration")
	local mod = caster:AddNewModifier(caster, ability, "modifier_axe_blood_lua_stacks", { duration = duration })
	if mod then
		mod:AddStack(duration)
	end
end

--------------------------------------------------------------------------------

modifier_axe_blood_lua_stacks = class({})

function modifier_axe_blood_lua_stacks:IsHidden()
	return false
end
function modifier_axe_blood_lua_stacks:IsPurgable()
	return false
end
function modifier_axe_blood_lua_stacks:GetTexture()
	return "axepassive"
end

function modifier_axe_blood_lua_stacks:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(0)
end

function modifier_axe_blood_lua_stacks:AddStack(duration)
	if not IsServer() then
		return
	end
	self:IncrementStackCount()
	self:SetDuration(duration, true)

	self:GetAbility():SetContextThink(DoUniqueString("blood_stack"), function()
		if not self:IsNull() then
			self:DecrementStackCount()
			if self:GetStackCount() <= 0 then
				self:Destroy()
			end
		end
		return nil
	end, duration)
end

function modifier_axe_blood_lua_stacks:DeclareFunctions()
	return { MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT }
end

function modifier_axe_blood_lua_stacks:GetModifierConstantHealthRegen()
	if self:GetAbility() then
		return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	end
	return 0
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_axe_enrage_lua", "heroes/hero_axe/hero_axe", LUA_MODIFIER_MOTION_NONE)

axe_enrage_lua = class({})

function axe_enrage_lua:OnSpellStart()
	self:GetCaster():AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_axe_enrage_lua",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	EmitSoundOn("Hero_Ursa.Enrage", self:GetCaster())
end

--------------------------------------------------------------------------------

modifier_axe_enrage_lua = class({})

function modifier_axe_enrage_lua:IsHidden()
	return false
end

function modifier_axe_enrage_lua:IsDebuff()
	return false
end

function modifier_axe_enrage_lua:IsPurgable()
	return false
end

function modifier_axe_enrage_lua:OnCreated()
	if not IsServer() then
		return
	end
	self:GetCaster():FindAbilityByName("axe_counter_helix_lua"):EndCooldown()
end

function modifier_axe_enrage_lua:GetModifierModelScale()
	return 45
end

function modifier_axe_enrage_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MIN_HEALTH,
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
	}
end

function modifier_axe_enrage_lua:GetMinHealth()
	return 1
end

function modifier_axe_enrage_lua:GetModifierHealthRegenPercentage()
	return self:GetAbility():GetSpecialValueFor("hp_regen")
end

function modifier_axe_enrage_lua:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_axe_enrage_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end