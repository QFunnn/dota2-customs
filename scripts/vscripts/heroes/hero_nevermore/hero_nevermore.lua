--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


shadow_fiend_shadowraze_a_lua = class({})
shadow_fiend_shadowraze_b_lua = class({})
shadow_fiend_shadowraze_c_lua = class({})

local RAZE_DISTANCES = {
	["shadow_fiend_shadowraze_a_lua"] = 200,
	["shadow_fiend_shadowraze_b_lua"] = 450,
	["shadow_fiend_shadowraze_c_lua"] = 700,
}

function shadow_fiend_shadowraze_a_lua:OnSpellStart()
	shadowraze.OnSpellStart(self)
end
function shadow_fiend_shadowraze_b_lua:OnSpellStart()
	shadowraze.OnSpellStart(self)
end
function shadow_fiend_shadowraze_c_lua:OnSpellStart()
	shadowraze.OnSpellStart(self)
end

if shadowraze == nil then
	shadowraze = {}
end

function shadowraze.ProcessRaze(self, target_pos, target_radius, base_damage, duration)
	local caster = self:GetCaster()
	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target_pos,
		nil,
		target_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		ApplyDamage({
			victim = enemy,
			attacker = caster,
			damage = base_damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end
	shadowraze.PlayEffects(self, target_pos, target_radius)
end

function shadowraze.OnSpellStart(self)
	local caster = self:GetCaster()
	local front = caster:GetForwardVector():Normalized()
	local origin = caster:GetOrigin()
	local target_radius = self:GetSpecialValueFor("shadowraze_radius")
	local base_damage = self:GetSpecialValueFor("shadowraze_damage")
	local duration = self:GetSpecialValueFor("duration")
	local soul_bonus = self:GetSpecialValueFor("soul")

	local necro_mod = caster:FindModifierByName("modifier_shadow_fiend_necromastery_lua")
	if necro_mod then
		base_damage = base_damage + (necro_mod:GetStackCount() * soul_bonus)
	end

	local talent = caster:FindAbilityByName("special_bonus_unique_shadow_fiend_8")
	if talent and talent:GetLevel() > 0 then
		for _, dist in pairs(RAZE_DISTANCES) do
			shadowraze.ProcessRaze(self, origin + front * dist, target_radius, base_damage, duration)
		end
	else
		local distance = RAZE_DISTANCES[self:GetName()] or 200
		shadowraze.ProcessRaze(self, origin + front * distance, target_radius, base_damage, duration)
	end
end

function shadowraze.PlayEffects(self, position, radius)
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_nevermore/nevermore_shadowraze.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect_cast, 0, position)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 1, 1))
	ParticleManager:ReleaseParticleIndex(effect_cast)
	local sound_cast = "Hero_Nevermore.Shadowraze"
	-- EmitSoundOnLocationWithCaster(position, sound_cast, self:GetCaster())
	EmitSoundOn(sound_cast, self:GetCaster())
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_shadow_fiend_necromastery_lua",
	"heroes/hero_nevermore/hero_nevermore",
	LUA_MODIFIER_MOTION_NONE
)

shadow_fiend_necromastery_lua = class({})

function shadow_fiend_necromastery_lua:GetIntrinsicModifierName()
	return "modifier_shadow_fiend_necromastery_lua"
end

--------------------------------------------------------------------------------

modifier_shadow_fiend_necromastery_lua = class({})

function modifier_shadow_fiend_necromastery_lua:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_shadow_fiend_necromastery_lua:IsDebuff()
	return false
end

function modifier_shadow_fiend_necromastery_lua:IsPurgable()
	return false
end

function modifier_shadow_fiend_necromastery_lua:RemoveOnDeath()
	return false
end

function modifier_shadow_fiend_necromastery_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function modifier_shadow_fiend_necromastery_lua:OnDeath(params)
	if IsServer() then
		if params.unit == self:GetParent() then
			self:DeathLogic(params)
		else
			self:KillLogic(params)
		end
	end
end

function modifier_shadow_fiend_necromastery_lua:GetModifierPreAttack_BonusDamage(params)
	if not self:GetParent():IsIllusion() and not self:GetParent():PassivesDisabled() then
		return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("soul_damage")
	end
end

function modifier_shadow_fiend_necromastery_lua:DeathLogic(params)
	local caster = self:GetCaster()
	local unit = params.unit

	if unit ~= self:GetParent() or params.reincarnate then
		return
	end

	self:SetStackCount(
		math.max(
			1,
			math.floor(self:GetStackCount() / 100 * (100 - self:GetAbility():GetSpecialValueFor("soul_release")))
		)
	)
end

function modifier_shadow_fiend_necromastery_lua:KillLogic(params)
	local target = params.unit
	local attacker = params.attacker

	if attacker ~= self:GetParent() or target == self:GetParent() or not attacker:IsAlive() then
		return
	end

	if target:IsIllusion() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end

	if not _G.excludedUnitsLookup[target:GetUnitName()] or attacker:HasModifier("modifier_guild_event") then
		return
	end

	self:IncrementStackCount()
end

function modifier_shadow_fiend_necromastery_lua:PlayEffects(target)
	local info = {
		Target = self:GetParent(),
		Source = target,
		EffectName = "particles/units/heroes/hero_nevermore/nevermore_necro_souls.vpcf",
		iMoveSpeed = 400,
		vSourceLoc = target:GetAbsOrigin(),
		bDodgeable = false,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 5,
		bProvidesVision = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_nevermore_aura", "heroes/hero_nevermore/hero_nevermore", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_nevermore_aura_effect", "heroes/hero_nevermore/hero_nevermore", LUA_MODIFIER_MOTION_NONE)

nevermore_aura = class({})

function nevermore_aura:GetIntrinsicModifierName()
	return "modifier_nevermore_aura"
end

--------------------------------------------------------------------------------

modifier_nevermore_aura = class({})

function modifier_nevermore_aura:IsHidden()
	return true
end

function modifier_nevermore_aura:IsDebuff()
	return false
end

function modifier_nevermore_aura:IsPurgable()
	return false
end

function modifier_nevermore_aura:IsAura()
	return (not self:GetCaster():PassivesDisabled())
end

function modifier_nevermore_aura:GetModifierAura()
	return "modifier_nevermore_aura_effect"
end

function modifier_nevermore_aura:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("AbilityCastRange")
end

function modifier_nevermore_aura:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_nevermore_aura:GetAuraSearchType()
	return DOTA_UNIT_TARGET_BASIC
end

function modifier_nevermore_aura:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
	}
end

function modifier_nevermore_aura:GetModifierPreAttack_CriticalStrike(params)
	if not IsServer() or self:GetParent():PassivesDisabled() then
		return
	end
	if params.target:GetTeamNumber() ~= self:GetParent():GetTeamNumber() then
		local necro_mod = self:GetParent():FindModifierByName("modifier_shadow_fiend_necromastery_lua")
		if necro_mod then
			if RollPercentage(self:GetAbility():GetSpecialValueFor("chance")) then
				self.record = params.record
				return 100 + necro_mod:GetStackCount()
			end
		end
	end
end

function modifier_nevermore_aura:GetModifierProcAttack_Feedback(params)
	if IsServer() and self.record and self.record == params.record then
		self.record = nil
		EmitSoundOn("Hero_Juggernaut.BladeDance", params.target)
	end
end

--------------------------------------------------------------------------------

modifier_nevermore_aura_effect = class({})

function modifier_nevermore_aura_effect:IsHidden()
	return false
end

function modifier_nevermore_aura_effect:IsDebuff()
	return true
end

function modifier_nevermore_aura_effect:IsPurgable()
	return false
end

function modifier_nevermore_aura_effect:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_nevermore_aura_effect:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("reduction")
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

shadow_fiend_requiem_of_souls_lua = class({})

function shadow_fiend_requiem_of_souls_lua:CastFilterResult()
	if not IsServer() then
		return
	end
	local caster = self:GetCaster()
	local necro_modifier = caster:FindModifierByName("modifier_shadow_fiend_necromastery_lua")

	local souls = 0
	if necro_modifier then
		souls = necro_modifier:GetStackCount()
	end

	if souls <= 0 then
		return UF_FAIL_CUSTOM
	end

	return UF_SUCCESS
end

function shadow_fiend_requiem_of_souls_lua:GetCustomCastError()
	return "#shadow_fiend_requiem_of_souls_lua"
end

function shadow_fiend_requiem_of_souls_lua:OnAbilityPhaseStart()
	if self:CastFilterResult() ~= UF_SUCCESS then
		return false
	end
	self:PlayEffects1()
	return true
end

function shadow_fiend_requiem_of_souls_lua:OnAbilityPhaseInterrupted()
	self:StopEffects1(false)
end

function shadow_fiend_requiem_of_souls_lua:OnSpellStart()
	local caster = self:GetCaster()
	local necro_modifier = caster:FindModifierByName("modifier_shadow_fiend_necromastery_lua")

	local souls = 0
	if necro_modifier then
		souls = necro_modifier:GetStackCount()
	end

	if souls <= 0 then
		return
	end

	local line_length = self:GetSpecialValueFor("requiem_range")
	local width_start = self:GetSpecialValueFor("requiem_line_width_start")
	local width_end = self:GetSpecialValueFor("requiem_line_width_end")
	local line_speed = self:GetSpecialValueFor("requiem_line_speed")
	local damage_per_soul = self:GetSpecialValueFor("damage")

	local direction = caster:GetForwardVector()
	local damage_to_send = damage_per_soul * souls

	local info = {
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf",
		vSpawnOrigin = caster:GetAbsOrigin(),
		fDistance = line_length,
		vVelocity = direction * line_speed,
		fStartRadius = width_start,
		fEndRadius = width_end,
		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		bReplaceExisting = false,
		bProvidesVision = false,
		ExtraData = {
			damage = damage_to_send,
		},
	}
	ProjectileManager:CreateLinearProjectile(info)

	self:StopEffects1(true)
	EmitSoundOn("Hero_Nevermore.RequiemOfSouls", caster)
end

function shadow_fiend_requiem_of_souls_lua:OnProjectileHit_ExtraData(hTarget, vLocation, table)
	if hTarget ~= nil then
		local damage_to_apply = table.damage
		ApplyDamage({
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = damage_to_apply,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		})
	end
	return false
end

function shadow_fiend_requiem_of_souls_lua:PlayEffects1()
	local particle_precast = "particles/units/heroes/hero_nevermore/nevermore_wings.vpcf"
	self.effect_precast = ParticleManager:CreateParticle(particle_precast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	EmitSoundOn("Hero_Nevermore.RequiemOfSoulsCast", self:GetCaster())
end

function shadow_fiend_requiem_of_souls_lua:StopEffects1(success)
	if not success and self.effect_precast then
		ParticleManager:DestroyParticle(self.effect_precast, true)
		StopSoundOn("Hero_Nevermore.RequiemOfSoulsCast", self:GetCaster())
	end
	if self.effect_precast then
		ParticleManager:ReleaseParticleIndex(self.effect_precast)
		self.effect_precast = nil
	end
end