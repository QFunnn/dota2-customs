--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ot3_borrowed_time_buff_hot_caster", "abilities/heroes/abaddon/abaddon_borrowed_time.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ot3_borrowed_time_handler", "abilities/heroes/abaddon/abaddon_borrowed_time.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ot3_borrowed_time_coil_counter", "abilities/heroes/abaddon/abaddon_borrowed_time.lua", LUA_MODIFIER_MOTION_NONE)

ot3_abaddon_borrowed_time = ot3_abaddon_borrowed_time or class({})

function ot3_abaddon_borrowed_time:GetIntrinsicModifierName()
	if self:GetCaster():IsRealHero() then
		return "modifier_ot3_borrowed_time_handler"
	end
end

function ot3_abaddon_borrowed_time:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local buff_duration = self:GetSpecialValueFor("duration")

	if caster:HasScepter() then
		buff_duration = self:GetSpecialValueFor("duration_scepter")
	end

	caster:AddNewModifier(caster, self, "modifier_ot3_borrowed_time_buff_hot_caster", { duration = buff_duration })
end

modifier_ot3_borrowed_time_handler = modifier_ot3_borrowed_time_handler or class({})

function modifier_ot3_borrowed_time_handler:IsHidden() return true end
function modifier_ot3_borrowed_time_handler:IsPurgable() return false end
function modifier_ot3_borrowed_time_handler:AllowIllusionDuplicate() return false end

function modifier_ot3_borrowed_time_handler:DeclareFunctions() return {
	MODIFIER_EVENT_ON_TAKEDAMAGE,
	MODIFIER_EVENT_ON_STATE_CHANGED,
} end

function modifier_ot3_borrowed_time_handler:OnCreated()
	if not IsServer() then return end

	local target = self:GetParent()

	if target:IsIllusion() then
		self:Destroy()
	else
		self.hp_threshold = self:GetAbility():GetSpecialValueFor("hp_threshold")

		-- Check if we need to auto cast immediately
		self:_CheckHealth(0)
	end
end

function modifier_ot3_borrowed_time_handler:OnTakeDamage(kv)
	if not IsServer() then return end

	local target = self:GetParent()

	if target == kv.unit then
		-- Auto cast borrowed time if damage will bring target to lower than hp_threshold
		self:_CheckHealth(kv.damage)
	end
end

function modifier_ot3_borrowed_time_handler:OnStateChanged(kv)
	-- Trigger borrowed time if health below hp_threshold after silence/hex
	if not IsServer() then return end

	local target = self:GetParent()

	if target == kv.unit then
		self:_CheckHealth(0)
	end
end

function modifier_ot3_borrowed_time_handler:_CheckHealth(damage)
	local target = self:GetParent()
	local ability = self:GetAbility()

	if not ability:IsHidden() and ability:IsCooldownReady() and not target:PassivesDisabled() and target:IsAlive() then
		local hp_threshold = self.hp_threshold
		local current_hp = target:GetHealth()

		if current_hp <= hp_threshold then
			target:CastAbilityImmediately(ability, target:GetPlayerID())
		end
	end
end

modifier_ot3_borrowed_time_buff_hot_caster = modifier_ot3_borrowed_time_buff_hot_caster or class({})

function modifier_ot3_borrowed_time_buff_hot_caster:IsPurgable() return false end
function modifier_ot3_borrowed_time_buff_hot_caster:IsAura() return true end
function modifier_ot3_borrowed_time_buff_hot_caster:GetModifierAura() return "modifier_ot3_borrowed_time_buff_hot_ally" end
function modifier_ot3_borrowed_time_buff_hot_caster:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO end
function modifier_ot3_borrowed_time_buff_hot_caster:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end
function modifier_ot3_borrowed_time_buff_hot_caster:GetEffectName() return "particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf" end
function modifier_ot3_borrowed_time_buff_hot_caster:GetEffectAttachType() return PATTACH_ABSORIGIN_FOLLOW end
function modifier_ot3_borrowed_time_buff_hot_caster:GetStatusEffectName() return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf" end
function modifier_ot3_borrowed_time_buff_hot_caster:StatusEffectPriority() return 15 end

function modifier_ot3_borrowed_time_buff_hot_caster:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("redirect_range")
end

function modifier_ot3_borrowed_time_buff_hot_caster:GetAuraEntityReject(hEntity)
	-- Do not apply aura to target
	if hEntity == self:GetParent() or hEntity:HasModifier("modifier_ot3_borrowed_time_buff_hot_caster") then
		return true
	end

	return false
end

function modifier_ot3_borrowed_time_buff_hot_caster:DeclareFunctions() return {
	MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	MODIFIER_EVENT_ON_TAKEDAMAGE,
} end

function modifier_ot3_borrowed_time_buff_hot_caster:OnCreated()
	if not IsServer() then return end

	local target = self:GetParent()

	self.target_current_health = target:GetHealth()
	self.ally_threshold_scepter = self:GetAbility():GetSpecialValueFor("ally_threshold_scepter")
	self.redirect_range_scepter = self:GetAbility():GetSpecialValueFor("redirect_range_scepter")
	self.max_coil_per_ultimate = self:GetAbility():GetSpecialValueFor("max_coil_per_ultimate")

	target:EmitSound("Hero_Abaddon.BorrowedTime")

	-- Strong Dispel
	target:Purge(false, true, false, true, false)
end

function modifier_ot3_borrowed_time_buff_hot_caster:OnTakeDamage(kv)
	if not IsServer() then return end

	local caster = self:GetCaster()
	if not IsValidEntity(caster) then return end

	local unit = kv.unit
	if not IsValidEntity(unit) then return end

	if not caster:HasScepter() then return end
	if caster:GetTeamNumber() ~= unit:GetTeamNumber() then return end
	if unit:IsBuilding() then return end
	if (unit:GetAbsOrigin() - caster:GetAbsOrigin()):Length2D() > self.redirect_range_scepter then return end

	local unit_damage_taken = unit.borrowed_time_damage_taken
	if not unit_damage_taken then unit.borrowed_time_damage_taken = 0 end

	unit.borrowed_time_damage_taken = unit.borrowed_time_damage_taken + kv.damage
	if unit.borrowed_time_damage_taken / self.ally_threshold_scepter < 1 then return end

	local coil_counter_modifier = unit:FindModifierByName("modifier_ot3_borrowed_time_coil_counter")
	local coil_ability = caster:FindAbilityByName("ot3_abaddon_death_coil")

	for i = 1, unit.borrowed_time_damage_taken / self.ally_threshold_scepter do
		local counter = 0

		if coil_counter_modifier and not coil_counter_modifier:IsNull() then
			counter = coil_counter_modifier:GetStackCount()
		else
			coil_counter_modifier = unit:AddNewModifier(
				caster, self:GetAbility(), "modifier_ot3_borrowed_time_coil_counter", {
					duration = self:GetRemainingTime()
				}
			)
		end

		if not coil_counter_modifier or coil_counter_modifier:IsNull() then return end

		if IsValidEntity(coil_ability) and counter < self.max_coil_per_ultimate then
			unit.borrowed_time_damage_taken = unit.borrowed_time_damage_taken - self.ally_threshold_scepter

			coil_ability:OnSpellStart(unit, true)
			coil_counter_modifier:IncrementStackCount()
			coil_counter_modifier:SetDuration(self:GetRemainingTime(), true)
		end
	end
end

function modifier_ot3_borrowed_time_buff_hot_caster:GetModifierIncomingDamage_Percentage(kv)
	if not IsServer() then return end

	local target = self:GetParent()

	local heal_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time_heal.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
	local target_vector = target:GetAbsOrigin()

	ParticleManager:SetParticleControl(heal_particle, 0, target_vector)
	ParticleManager:SetParticleControl(heal_particle, 1, target_vector)
	ParticleManager:ReleaseParticleIndex(heal_particle)

	target:Heal(kv.damage, target)

	return -9999999
end

modifier_ot3_borrowed_time_coil_counter = modifier_ot3_borrowed_time_coil_counter or class({})

function modifier_ot3_borrowed_time_coil_counter:IsPurgable() return false end

function modifier_ot3_borrowed_time_coil_counter:OnRemoved()
	if not IsServer() then return end

	self:GetParent().borrowed_time_damage_taken = 0
end