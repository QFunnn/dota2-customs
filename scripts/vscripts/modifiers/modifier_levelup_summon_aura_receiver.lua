--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


modifier_levelup_summon_aura_receiver = class({})

local function create_empty_cache()
	if summon_aura_system and summon_aura_system.CreateEmptyAuraBucket then
		return summon_aura_system:CreateEmptyAuraBucket()
	end
	return {}
end

local function clone_cache(raw)
	if summon_aura_system and summon_aura_system.CloneAuraBucket then
		return summon_aura_system:CloneAuraBucket(raw)
	end
	return {}
end

local function is_valid_lua_modifier(modifier)
	return modifier ~= nil and (not modifier.IsNull or not modifier:IsNull())
end

local function numbers_are_close(left, right)
	if left == nil or right == nil then
		return false
	end
	return math.abs(to_number(left, 0) - to_number(right, 0)) <= 0.01
end

local function value_was_changed_externally(current_value, last_applied_value)
	return last_applied_value ~= nil and not numbers_are_close(current_value, last_applied_value)
end

local function resolve_current_base_value(current_value, previous_bonus, fallback)
	return to_number(current_value, fallback or 0) - to_number(previous_bonus, 0)
end

local function resolve_current_base_armor_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
	local current_armor = to_number(current_value, fallback or 0)
	local pct_multiplier = math.max(0.0001, 1 + to_number(previous_pct_bonus, 0) * 0.01)
	local value_without_pct = current_armor / pct_multiplier
	return value_without_pct - to_number(previous_flat_bonus, 0)
end

local function apply_armor_bonus_with_pct(base_value, flat_bonus, pct_bonus)
	local pre_pct_value = to_number(base_value, 0) + to_number(flat_bonus, 0)
	local pct_multiplier = math.max(0, 1 + to_number(pct_bonus, 0) * 0.01)
	return pre_pct_value * pct_multiplier
end

local function resolve_current_base_attack_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
	local current_damage = math.max(0, to_number(current_value, fallback or 0))
	local pct_multiplier = math.max(0.0001, 1 + to_number(previous_pct_bonus, 0) * 0.01)
	local value_without_pct = math.floor((current_damage / pct_multiplier) + 0.0001)
	return math.max(0, value_without_pct - to_number(previous_flat_bonus, 0))
end

local function apply_attack_bonus_with_pct(base_value, flat_bonus, pct_bonus)
	local pre_pct_value = math.max(0, to_number(base_value, 0) + to_number(flat_bonus, 0))
	local pct_multiplier = math.max(0, 1 + to_number(pct_bonus, 0) * 0.01)
	return math.max(0, math.floor(pre_pct_value * pct_multiplier + 0.5))
end

local function resolve_current_base_health_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
	local current_max_health = math.max(1, to_number(current_value, fallback or 1))
	local pct_multiplier = math.max(0.0001, 1 + to_number(previous_pct_bonus, 0) * 0.01)
	local value_without_pct = math.floor((current_max_health / pct_multiplier) + 0.0001)
	return math.max(1, value_without_pct - to_number(previous_flat_bonus, 0))
end

local function apply_health_bonus_with_pct(base_value, flat_bonus, pct_bonus)
	local pre_pct_value = math.max(1, to_number(base_value, 1) + to_number(flat_bonus, 0))
	local pct_multiplier = math.max(0, 1 + to_number(pct_bonus, 0) * 0.01)
	return math.max(1, math.ceil(pre_pct_value * pct_multiplier))
end

local function resolve_base_value_after_possible_external_write(
	current_value,
	previous_bonus,
	fallback,
	last_applied_value
)
	if value_was_changed_externally(current_value, last_applied_value) then
		return to_number(current_value, fallback or 0)
	end
	return resolve_current_base_value(current_value, previous_bonus, fallback)
end

local function resolve_base_armor_after_possible_external_write(
	current_value,
	previous_flat_bonus,
	previous_pct_bonus,
	fallback,
	last_applied_value
)
	if value_was_changed_externally(current_value, last_applied_value) then
		return to_number(current_value, fallback or 0)
	end
	return resolve_current_base_armor_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
end

local function resolve_base_attack_after_possible_external_write(
	current_value,
	previous_flat_bonus,
	previous_pct_bonus,
	fallback,
	last_applied_value
)
	if value_was_changed_externally(current_value, last_applied_value) then
		return math.max(0, to_number(current_value, fallback or 0))
	end
	return resolve_current_base_attack_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
end

local function resolve_base_health_after_possible_external_write(
	current_value,
	previous_flat_bonus,
	previous_pct_bonus,
	fallback,
	last_applied_value
)
	if value_was_changed_externally(current_value, last_applied_value) then
		return math.max(1, to_number(current_value, fallback or 1))
	end
	return resolve_current_base_health_value(current_value, previous_flat_bonus, previous_pct_bonus, fallback)
end

function modifier_levelup_summon_aura_receiver:IsHidden()
	return true
end
function modifier_levelup_summon_aura_receiver:IsPurgable()
	return false
end
function modifier_levelup_summon_aura_receiver:IsPurgeException()
	return false
end
function modifier_levelup_summon_aura_receiver:RemoveOnDeath()
	return false
end

function modifier_levelup_summon_aura_receiver:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_levelup_summon_aura_receiver:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local owner_hero = GetLevelUpUnitOwnerHero(parent)

	self.owner_player_id = tonumber(parent.levelup_summon_owner_player_id) or GetLevelUpUnitOwnerPlayerID(parent) or -1
	self.owner_hero_entindex = IsValid(owner_hero) and owner_hero:entindex()
		or tonumber(parent.levelup_summon_owner_hero_entindex)

	self.fallback_attack_damage_min = to_number(parent._levelup_custom_attack_damage_min, 0)
	self.fallback_attack_damage_max =
		to_number(parent._levelup_custom_attack_damage_max, self.fallback_attack_damage_min)
	self.fallback_custom_armor =
		to_number(parent._levelup_custom_armor, health_system and health_system:GetVictimArmor(parent) or 0)
	self.fallback_health_regen = to_number(
		parent._levelup_custom_health_regen,
		health_system and health_system:GetConfiguredNonHeroStat(parent, "health_regen") or 0
	)
	self.fallback_health_regen_pct = to_number(parent._levelup_custom_health_regen_pct, 0)
	self.base_health_regen_constant = self.fallback_health_regen
	self.base_health_regen_pct = self.fallback_health_regen_pct
	self.fallback_max_health = to_number(
		parent._levelup_max_health,
		health_system and health_system:GetDefaultCustomHealthForUnit(parent) or 1
	)
	self.fallback_max_health = math.max(1, self.fallback_max_health)

	self.aura_cache = create_empty_cache()
	self.bonus_damage = 0
	self.attack_damage_pct_bonus = 0
	self.attack_speed_pct = 0
	self.attack_range_bonus = 0
	self.armor_bonus = 0
	self.armor_pct_bonus = 0
	self.health_bonus = 0
	self.health_pct_bonus = 0
	self.move_speed_pct = 0
	self.health_regen_constant = 0
	self.health_regen_pct = 0
	self.physical_crit_chance_pct = 0
	self.physical_crit_damage_pct = 100
	self.final_physical_crit_damage_pct = 0
	self.physical_damage_pct = 0
	self.magical_damage_pct = 0
	self.damage_amplification = 0
	self.final_damage_pct = 0
	self.magical_crit_chance_pct = 0
	self.magical_crit_damage_pct = 100
	self.final_magical_crit_damage_pct = 0
	self.incoming_damage_pct = 0

	self:ForceRefreshFromManager()
end

function modifier_levelup_summon_aura_receiver:GetOwnerHero()
	local owner_hero_entindex = tonumber(self.owner_hero_entindex)
	if owner_hero_entindex ~= nil then
		local owner_hero = EntIndexToHScript(owner_hero_entindex)
		if IsValid(owner_hero) and owner_hero.IsRealHero and owner_hero:IsRealHero() then
			return owner_hero
		end
	end

	local owner_hero = GetLevelUpUnitOwnerHero(self:GetParent())
	if IsValid(owner_hero) then
		self.owner_hero_entindex = owner_hero:entindex()
		self.owner_player_id = owner_hero:GetPlayerOwnerID()
		return owner_hero
	end

	return nil
end

function modifier_levelup_summon_aura_receiver:GetOwnerManager()
	local owner_hero = self:GetOwnerHero()
	if not IsValid(owner_hero) then
		return nil
	end

	return owner_hero:GetLevelUpSummonAuraManagerModifier()
end

function modifier_levelup_summon_aura_receiver:ApplyAuraCache(aura_cache)
	local parent = self:GetParent()
	if not IsValid(parent) then
		return
	end

	local previous_cache = self.aura_cache or create_empty_cache()
	local next_cache = clone_cache(aura_cache)

	local base_attack_damage_min = resolve_base_attack_after_possible_external_write(
		parent._levelup_custom_attack_damage_min,
		previous_cache.damage,
		previous_cache.attack_damage_pct,
		self.fallback_attack_damage_min,
		self.last_applied_attack_damage_min
	)
	local base_attack_damage_max = resolve_base_attack_after_possible_external_write(
		parent._levelup_custom_attack_damage_max,
		previous_cache.damage,
		previous_cache.attack_damage_pct,
		self.fallback_attack_damage_max,
		self.last_applied_attack_damage_max
	)
	self.fallback_attack_damage_min = base_attack_damage_min
	self.fallback_attack_damage_max = base_attack_damage_max
	parent._levelup_custom_attack_damage_min =
		apply_attack_bonus_with_pct(base_attack_damage_min, next_cache.damage, next_cache.attack_damage_pct)
	parent._levelup_custom_attack_damage_max = math.max(
		parent._levelup_custom_attack_damage_min,
		apply_attack_bonus_with_pct(base_attack_damage_max, next_cache.damage, next_cache.attack_damage_pct)
	)
	self.last_applied_attack_damage_min = parent._levelup_custom_attack_damage_min
	self.last_applied_attack_damage_max = parent._levelup_custom_attack_damage_max

	local current_custom_armor = parent._levelup_custom_armor
	if current_custom_armor == nil and health_system and health_system.GetVictimArmor then
		current_custom_armor = health_system:GetVictimArmor(parent)
	end
	local base_custom_armor = resolve_base_armor_after_possible_external_write(
		current_custom_armor,
		previous_cache.armor,
		previous_cache.armor_pct,
		self.fallback_custom_armor,
		self.last_applied_custom_armor
	)
	self.fallback_custom_armor = base_custom_armor
	parent._levelup_custom_armor = apply_armor_bonus_with_pct(base_custom_armor, next_cache.armor, next_cache.armor_pct)
	self.last_applied_custom_armor = parent._levelup_custom_armor

	local base_regen = resolve_base_value_after_possible_external_write(
		parent._levelup_custom_health_regen,
		previous_cache.health_regen,
		self.fallback_health_regen,
		self.last_applied_health_regen
	)
	local base_regen_pct = resolve_base_value_after_possible_external_write(
		parent._levelup_custom_health_regen_pct,
		previous_cache.health_regen_pct,
		self.fallback_health_regen_pct,
		self.last_applied_health_regen_pct
	)
	self.fallback_health_regen = base_regen
	self.fallback_health_regen_pct = base_regen_pct
	self.base_health_regen_constant = base_regen
	self.base_health_regen_pct = base_regen_pct
	parent._levelup_custom_health_regen = base_regen + next_cache.health_regen
	parent._levelup_custom_health_regen_pct = base_regen_pct + next_cache.health_regen_pct
	self.last_applied_health_regen = parent._levelup_custom_health_regen
	self.last_applied_health_regen_pct = parent._levelup_custom_health_regen_pct

	local base_max_health = resolve_base_health_after_possible_external_write(
		parent._levelup_max_health,
		previous_cache.health,
		previous_cache.health_pct,
		self.fallback_max_health,
		self.last_applied_max_health
	)
	self.fallback_max_health = math.max(1, base_max_health)
	parent:LevelUpSetMaxHealth(
		apply_health_bonus_with_pct(self.fallback_max_health, next_cache.health, next_cache.health_pct)
	)
	self.last_applied_max_health = parent._levelup_max_health

	self.aura_cache = next_cache
	self.bonus_damage = math.floor(next_cache.damage + 0.5)
	self.attack_damage_pct_bonus = math.floor(next_cache.attack_damage_pct + 0.5)
	self.attack_speed_pct = math.floor(next_cache.attack_speed + 0.5)
	self.attack_range_bonus = math.floor(next_cache.attack_range + 0.5)
	self.armor_bonus = math.floor((parent._levelup_custom_armor - base_custom_armor) + 0.5)
	self.armor_pct_bonus = math.floor(next_cache.armor_pct + 0.5)
	self.health_bonus = math.floor(next_cache.health + 0.5)
	self.health_pct_bonus = math.floor(next_cache.health_pct + 0.5)
	self.move_speed_pct = math.floor(next_cache.move_speed_pct + 0.5)
	self.health_regen_constant = next_cache.health_regen
	self.health_regen_pct = next_cache.health_regen_pct
	self.physical_crit_chance_pct = math.floor(next_cache.physical_crit_chance_pct + 0.5)
	self.physical_crit_damage_pct = 100 + math.floor(next_cache.physical_crit_damage_pct + 0.5)
	self.final_physical_crit_damage_pct = 0
	self.physical_damage_pct = math.floor(next_cache.physical_damage_pct + 0.5)
	self.magical_damage_pct = math.floor(next_cache.magical_damage_pct + 0.5)
	self.damage_amplification = math.floor(next_cache.damage_amplification + 0.5)
	self.final_damage_pct = math.floor(next_cache.final_damage_pct + 0.5)
	self.magical_crit_chance_pct = math.floor(next_cache.magical_crit_chance_pct + 0.5)
	self.magical_crit_damage_pct = 100 + math.floor(next_cache.magical_crit_damage_pct + 0.5)
	self.final_magical_crit_damage_pct = 0
	self.incoming_damage_pct = math.floor(next_cache.incoming_damage_pct + 0.5)
end

function modifier_levelup_summon_aura_receiver:ForceRefreshFromManager(manager_override)
	if not IsServer() then
		return
	end

	local manager = manager_override
	if not is_valid_lua_modifier(manager) or not manager.GetAuraCache then
		manager = self:GetOwnerManager()
	end

	local aura_cache = manager and manager:GetAuraCache() or create_empty_cache()
	self:ApplyAuraCache(aura_cache)
	self:ForceRefresh()
end

function modifier_levelup_summon_aura_receiver:GetModifierAttackSpeedPercentage()
	return self.attack_speed_pct or 0
end

function modifier_levelup_summon_aura_receiver:GetModifierAttackRangeBonus()
	return self.attack_range_bonus or 0
end

function modifier_levelup_summon_aura_receiver:GetModifierMoveSpeedBonus_Percentage()
	return self.move_speed_pct or 0
end