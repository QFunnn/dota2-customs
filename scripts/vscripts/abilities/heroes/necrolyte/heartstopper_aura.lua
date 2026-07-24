--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_heartstopper_aura_custom", "abilities/heroes/necrolyte/heartstopper_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_heartstopper_aura_damage_effect_custom", "abilities/heroes/necrolyte/heartstopper_aura", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_necrolyte_heartstopper_aura_counter_custom", "abilities/heroes/necrolyte/heartstopper_aura", LUA_MODIFIER_MOTION_NONE)

necrolyte_heartstopper_aura_custom = necrolyte_heartstopper_aura_custom or class({})

function necrolyte_heartstopper_aura_custom:GetCastRange(location, target)
	return self:GetSpecialValueFor("aura_radius")
end

function necrolyte_heartstopper_aura_custom:GetIntrinsicModifierName()
	return "modifier_necrolyte_heartstopper_aura_custom"
end


---------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_necrolyte_heartstopper_aura_custom = modifier_necrolyte_heartstopper_aura_custom or class({})

function modifier_necrolyte_heartstopper_aura_custom:IsHidden() return false end
function modifier_necrolyte_heartstopper_aura_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT end

function modifier_necrolyte_heartstopper_aura_custom:IsAura() return true end
function modifier_necrolyte_heartstopper_aura_custom:GetAuraEntityReject(target) return false end
function modifier_necrolyte_heartstopper_aura_custom:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("aura_radius") end
function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchFlags() return DOTA_UNIT_TARGET_FLAG_NOT_ANCIENTS end
function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_necrolyte_heartstopper_aura_custom:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_necrolyte_heartstopper_aura_custom:GetModifierAura() return "modifier_necrolyte_heartstopper_aura_damage_effect_custom" end

-- function modifier_necrolyte_heartstopper_aura_custom:DeclareFunctions()
-- 	return {
-- 		MODIFIER_EVENT_ON_DEATH,
-- 	}
-- end

function modifier_necrolyte_heartstopper_aura_custom:OnCreated()
	self.ability = self:GetAbility()
	self.regen_duration = self.ability:GetSpecialValueFor("regen_duration")
	self.hero_multiplier = self.ability:GetSpecialValueFor("hero_multiplier")
end

function modifier_necrolyte_heartstopper_aura_custom:OnRefresh()
	self:OnCreated()
end

-- function modifier_necrolyte_heartstopper_aura_custom:OnDeath(params)
-- 	if not IsServer() then return end
-- 	if params.attacker:PassivesDisabled() then return end
-- 	if params.attacker ~= self:GetParent() then return end
-- 	if not params.attacker:IsRealHero() then return end

-- 	local bonus_stacks = 1

-- 	if params.unit:IsRealHero() then
-- 		bonus_stacks = self.hero_multiplier
-- 	end

-- 	local modifier_sadist_handler = params.attacker:FindModifierByName("modifier_necrolyte_heartstopper_aura_counter_custom")

-- 	if not modifier_sadist_handler then
-- 		modifier_sadist_handler = params.attacker:AddNewModifier(params.attacker, self.ability, "modifier_necrolyte_heartstopper_aura_counter_custom", {})
-- 	end

-- 	if modifier_sadist_handler then
-- 		modifier_sadist_handler:AddIndependentStacks(bonus_stacks, self.regen_duration, nil, true)
-- 	end
-- end


------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_necrolyte_heartstopper_aura_damage_effect_custom = modifier_necrolyte_heartstopper_aura_damage_effect_custom or class({})

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:IsHidden() return self.is_hidden end
function modifier_necrolyte_heartstopper_aura_damage_effect_custom:IsDebuff() return true end
function modifier_necrolyte_heartstopper_aura_damage_effect_custom:IsPurgable() return false end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
	}
end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	self:OnRefresh()

	if not IsServer() then return end

	self:HandleEnemyVisibility() -- this also initialize self.is_hidden, therefore should be called before SetHasCustomTransmitterData
	self:SetHasCustomTransmitterData(true)

	if not self.timer then
		self:StartIntervalThink(self.tick_rate)
		self.timer = true
	end

	self.damage_table = {
		attacker = self.caster,
		victim = self.parent,
		ability = self.ability,
		damage_flags 	= DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
		--damage = damage,
		damage_type 	= DAMAGE_TYPE_MAGICAL,
	}
end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:OnRefresh()
	if not IsValidEntity(self.ability) then return end

	self.tick_rate = self.ability:GetSpecialValueFor("tick_rate")
	self.scepter_heal_regen_to_damage = self.ability:GetSpecialValueFor("heal_regen_to_damage")  * self.tick_rate / 100.0
end

-- Server
function modifier_necrolyte_heartstopper_aura_damage_effect_custom:AddCustomTransmitterData()
	return {
		is_hidden = self.is_hidden,
	}
end

-- Client
function modifier_necrolyte_heartstopper_aura_damage_effect_custom:HandleCustomTransmitterData(data)
	self.is_hidden = data.is_hidden
end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:HandleEnemyVisibility()
	if not IsValidEntity(self.parent) or not IsValidEntity(self.caster) then return end
	self.is_hidden = self.parent:CanEntityBeSeenByMyTeam(self.caster)
end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:OnIntervalThink()
	if not IsValidEntity(self.parent) or not IsValidEntity(self.caster) then return end

	if not self.parent:IsAlive() then
		self:StartIntervalThink(-1)
		self:Destroy()
		return
	end

	self:HandleEnemyVisibility()

	if self.caster:PassivesDisabled() then return end

	local damage = self.parent:GetMaxHealth() * (self.ability:GetSpecialValueFor("aura_damage") * self.tick_rate) / 100

	if self.caster:HasScepter() then
		-- otherwise applied aura effects won't have it until aura re-enter
		if self.scepter_heal_regen_to_damage <= 0 then
			self:OnRefresh()
		end

		damage = damage + (self.scepter_heal_regen_to_damage * self.caster:GetHealthRegen())
	end

	self.damage_table.damage = damage
	ApplyDamage(self.damage_table)
end

function modifier_necrolyte_heartstopper_aura_damage_effect_custom:GetModifierHPRegenAmplify_Percentage()
	if not IsValidEntity(self.ability) then return end
	if self.caster:PassivesDisabled() then return end
	return self.ability:GetSpecialValueFor("heal_reduction_pct") * -1
end


------------------------------------------------------------------------------------------------------------------------------------------------------


modifier_necrolyte_heartstopper_aura_counter_custom = modifier_necrolyte_heartstopper_aura_counter_custom or class({})

function modifier_necrolyte_heartstopper_aura_counter_custom:IsHidden() return false end
function modifier_necrolyte_heartstopper_aura_counter_custom:IsPurgable() return false end
function modifier_necrolyte_heartstopper_aura_counter_custom:IsDebuff() return false end

function modifier_necrolyte_heartstopper_aura_counter_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
	}
end

function modifier_necrolyte_heartstopper_aura_counter_custom:OnCreated()
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()

	if not self.caster or self.caster:IsNull() then return end
	if not self.parent or self.parent:IsNull() then return end
	if not self.ability or self.ability:IsNull() then return end

	if not IsServer() then return end

	self.regen_duration = self.ability:GetSpecialValueFor("regen_duration")
	self.stacks_table = {}

	self:StartIntervalThink(0.1)
end

function modifier_necrolyte_heartstopper_aura_counter_custom:GetModifierConstantManaRegen()
	if not IsValidEntity(self.ability) or not IsValidEntity(self.caster) then return end
	local kv_mana_regen = self.ability:GetSpecialValueFor("mana_regen") or 0

	return kv_mana_regen * self:GetStackCount()
end

function modifier_necrolyte_heartstopper_aura_counter_custom:GetModifierConstantHealthRegen()
	if not IsValidEntity(self.ability) or not IsValidEntity(self.caster) then return end
	local kv_health_regen = self.ability:GetSpecialValueFor("health_regen") or 0

	return kv_health_regen * self:GetStackCount()
end