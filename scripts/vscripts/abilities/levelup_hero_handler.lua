--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_levelup_hero_handler", "abilities/levelup_hero_handler", LUA_MODIFIER_MOTION_NONE)

levelup_hero_handler = class({})

local CUSTOM_BASE_ATTRIBUTE = 100
local CUSTOM_BASE_ATTACK_DAMAGE = 300
local STR_HEALTH_FACTOR = 10
local STR_HEALTH_REGEN_FACTOR = 0.5
local AGI_ATTACK_PROC_PHYSICAL_FACTOR = 0.5
local INT_MAGICAL_SPELL_DAMAGE_FACTOR = 0.5
local INT_ARTEFACT_DAMAGE_LINEAR_FACTOR = 0.5
local BASE_HEALTH_FLAT = 3000
local BASE_ARMOR = 20
local BASE_MAGICAL_RESISTANCE = 25
local BASE_HEALTH_REGEN_FLAT = 60
local HEALTH_REGEN_PCT = 0
local FIXED_MAX_MANA = 100
local FIXED_MANA_REGEN = 4
local BASE_PHYSICAL_CRIT_CHANCE_PCT = 10
local BASE_PHYSICAL_CRIT_DAMAGE_PCT = 150
local BASE_MAGICAL_CRIT_CHANCE_PCT = 5
local BASE_MAGICAL_CRIT_DAMAGE_PCT = 140
local BASE_EXTRA_PROJECTILE_DAMAGE_PCT = 30
local BASE_BOUNCE_DAMAGE_PCT = 30

local STAT_KEYS = {
	-- Отдельные бонусы
	"attack_speed", -- Бонус к скорости атаки (pct)
	"extra_attack_projectiles", -- Количество дополнительных снарядов
	"extra_projectile_damage_pct", -- Урон от дополнительных снарядов (pct)
	"bounce_count", -- Количество отскоков (fixed)
	"bounce_damage_pct", -- Урон от отскока (pct)
	"move_speed", -- Бонус к скорости передвижения (fixed)
	"move_speed_pct", -- Бонус к скорости передвижения (pct)
	"base_attack_time_reduction", -- снижение базового интервала атаки (fixed)
	"cooldown_reduction", -- Сокращение перезарядки (pct)
	"passive_artefact_cooldown_reduction", -- Сокращение перезарядки Пробы артефакта (pct)
	"passive_artefact_bonus_pct", -- Усиление характеристик Пробы артефакта (pct)
	"chest_reward_gold_pct", -- Увеличение золота за сундуки (pct)
	"challenger_count_bonus", -- Дополнительное кол-во монстров в Пробах (fixed)
	"challenger_enemy_damage_pct", -- Урон по любому монстру Пробы (pct)
	"challenger_elite_damage_pct", -- Урон по элитному монстру Пробы (pct)
	"challenger_leader_damage_pct", -- Урон по монстру-лидеру Пробы (pct)
	"incoming_damage_pct", -- снижение входящего урона (pct)
	"incoming_damage_pct_plus", -- увеличение входящего урона (pct)
	"outgoing_damage_pct", -- снижение наносимого урона (pct)
	"evasion", -- уклонение (pct)
	"selected_str_hero_damage_bonus_pct",
	"selected_agi_hero_damage_bonus_pct",
	"selected_int_hero_damage_bonus_pct",
	"selected_universal_hero_damage_bonus_pct",
	"damage_per_units_in_radius_effect",
	"incoming_damage_per_units_in_radius_effect",

	-- Здоровье
	"health", -- Бонус к здоровью (fixed)
	"health_pct", -- Бонус к здоровью (pct)
	"health_coefficient", -- Коэффициент увеличения здоровья (pct)
	"health_per_sec", -- Бонус к здоровью в секунду (fixed)
	"health_per_kill", -- Бонус к здоровью за убийство (fixed)

	-- Мана
	"mana", -- Бонус к мане (fixed)
	"mana_pct", -- Бонус к мане (pct)

	-- Регенерация здоровья
	"health_regen", -- Бонус к регенерации здоровья (fixed)
	"health_regen_pct", -- Бонус к регенерации здоровья (pct)
	"str_health_factor_pct", -- Увеличение здоровья от силы (pct)
	"str_health_regen_factor_pct", -- Увеличение регенерации здоровья от силы (pct)

	-- Регенерация маны
	"mana_regen", -- Бонус к регенерации маны (fixed)
	"mana_regen_pct", -- Бонус к регенерации маны (pct)

	-- Броня
	"armor", -- Бонус к броне (fixed)
	"armor_pct", -- Бонус к броне (pct)
	"armor_penetration_pct", -- Игнорирование процента брони цели (pct)
	"magical_resistance", -- Сопротивление магии (fixed)

	-- Опыт
	"xp_gain_pct", -- Бонус к опыту (pct)
	"xp_per_sec", -- Опыт в секунду (fixed)
	"xp_per_sec_pct", -- Увеличение опыта в секунду (pct)

	-- Валюта
	"gold_per_sec", -- Золото в секунду (fixed)
	"wood_per_sec", -- Дерево в секунду (fixed)
	"kills_per_sec", -- Убийства в секунду (fixed)
	"gold_gain_pct", -- Увеличение получаемого золота (pct)
	"gold_per_sec_pct", -- Увеличение золота в секунду (pct)
	"wood_per_sec_pct", -- Увеличение дерева в секунду (pct)
	"kills_per_sec_pct", -- Увеличение убийств в секунду (pct)
	"kills_gain_pct", -- Увеличение получаемых душ/заслуг (pct)

	-- Все статы связанные с силой
	"str", -- Увеличение силы (fixed)
	"str_base_pct", -- Увеличение базовой силы (pct)
	"str_coefficient", -- Коэффициент увеличения силы (pct)
	"str_pct", -- Увеличение силы (pct)
	"str_per_kill", -- Увеличение силы за убийство (fixed)
	"str_per_sec", -- Увеличение силы в секунду (fixed)
	"str_to_fixed_damage_ratio",
	"str_pct_threshold_health_effect",
	"str_pct_100_health_bonus_pct",
	"str_pct_200_health_bonus_pct",
	"str_pct_300_health_bonus_pct",
	"str_pct_400_health_bonus_pct",
	"str_pct_500_health_bonus_pct",

	-- Все статы связанные с ловкостью
	"agi", -- Увеличение ловкости (fixed)
	"agi_base_pct", -- Увеличение базовой ловкости (pct)
	"agi_coefficient", -- Коэффициент увеличения ловкости (pct)
	"agi_pct", -- Увеличение ловкости (pct)
	"agi_per_kill", -- Увеличение ловкости за убийство (fixed)
	"agi_per_sec", -- Увеличение ловкости в секунду (fixed)
	"agi_to_fixed_damage_ratio",
	"agi_pct_threshold_fixed_damage_effect",
	"agi_pct_100_fixed_damage_bonus_pct",
	"agi_pct_200_fixed_damage_bonus_pct",
	"agi_pct_300_fixed_damage_bonus_pct",
	"agi_pct_400_fixed_damage_bonus_pct",
	"agi_pct_500_fixed_damage_bonus_pct",

	-- Все статы связанные с интеллектом
	"int", -- Увеличение интеллекта (fixed)
	"int_base_pct", -- Увеличение базового интеллекта (pct)
	"int_pct", -- Увеличение интеллекта (pct)
	"int_coefficient", -- Коэффициент увеличения интеллекта (pct)
	"int_per_kill", -- Увеличение интеллекта за убийство (fixed)
	"int_per_sec", -- Увеличение интеллекта в секунду (fixed)
	"int_to_fixed_damage_ratio",
	"int_pct_threshold_fixed_damage_effect",
	"int_pct_100_fixed_damage_bonus_pct",
	"int_pct_200_fixed_damage_bonus_pct",
	"int_pct_300_fixed_damage_bonus_pct",
	"int_pct_400_fixed_damage_bonus_pct",
	"int_pct_500_fixed_damage_bonus_pct",

	-- Отдельно все атрибуты
	"all_attributes_per_sec", -- Увеличение всех атрибутов в секунду (fixed)
	"all_attributes_per_kill", -- Увеличение всех атрибутов за убийство (fixed)
	"all_attributes_pct", -- Увеличение всех атрибутов (pct)
	"all_attributes_coefficient", -- Коэффициент увеличения всех атрибутов (pct)
	"primary_attribute_to_fixed_damage_ratio",
	"base_str_per_hero_level", -- Базовая сила за уровень героя (fixed)
	"base_agi_per_hero_level", -- Базовая ловкость за уровень героя (fixed)
	"base_int_per_hero_level", -- Базовый интеллект за уровень героя (fixed)
	"str_base_pct_per_hero_level", -- Базовая сила за уровень героя (pct)
	"agi_base_pct_per_hero_level", -- Базовая ловкость за уровень героя (pct)
	"int_base_pct_per_hero_level", -- Базовый интеллект за уровень героя (pct)

	-- Дальность атаки
	"attack_range", -- Увеличение дальности атаки (fixed)
	"attack_range_pct", -- Увеличение дальности атаки (pct)

	-- Все статы на урон
	"damage", -- Белый - Зеленый урон (Fixed)
	"damage_per_kill", -- Увеличение урона за убийство (fixed)
	"damage_per_sec", -- Увеличение урона в секунду (fixed)
	"damage_per_hero_level", -- Увеличение урона за уровень героя (fixed)
	"attack_damage_pct", -- Увеличение урона от атаки (pct)
	"final_attack_damage_pct", -- Финальный урон от атаки (pct)

	"damage_increase", -- Повышает наносимый урон (предмет Флакон урона) (pct)
	"damage_amplification", -- Усиление урона (предмет Усиление урона) (pct)
	"final_damage_pct", -- Финальный урон (Предмет Финальный артефакт) (pct)
	"ability_damage_pct", -- Урон способностей (pct)
	"ability_aoe_damage_pct", -- Урон массовых способностей (pct)
	"damage_pierce_pct", -- Универсальное пробивание сопротивлений (pct)
	"passive_artefact_damage_pct", -- Урон пассивных артефактов (pct)

	"physical_damage_pct", -- Увеличение физического урона (pct)
	"physical_damage_coefficient", -- Коэффициент увеличения физического урона (pct)
	"fixed_physical_damage", -- Фиксированный (постоянный) физический урон (Fixed)
	"fixed_physical_damage_pct", -- Увеличение фиксированного физического урона (pct)
	"fixed_physical_damage_per_hero_level", -- Фиксированный физический урон за уровень героя (fixed)
	"final_physical_damage", -- финальный физический урон (pct)

	"magical_damage_pct", -- Увеличение магического урона (pct)
	"magical_damage_coefficient", -- Коэффициент увеличения магического урона (pct)
	"fixed_magical_damage", -- Фиксированный магический урон (Fixed)
	"fixed_magical_damage_pct", -- Увеличение фиксированного магического урона (pct)
	"fixed_magical_damage_per_hero_level", -- Фиксированный магический урон за уровень героя (fixed)
	"final_magical_damage", -- финальный магический урон (pct)
	"health_per_hero_level", -- Здоровье за уровень героя (fixed)
	"hp_restore_amp_pct", -- Усиление восстановления здоровья (pct)

	"damage_coefficient_1", -- Коэффициент урона 1 (pct)
	"damage_coefficient_2", -- Коэффициент урона 2 (pct)
	"damage_coefficient_3", -- Коэффициент урона 3 (pct)
	"final_damage_coefficient", -- Финальный коэффициент урона (pct)
	"damage_coefficient_threshold_bonus_effect",
	"damage_coefficient_100_bonus_2_pct",
	"damage_coefficient_300_bonus_2_pct",
	"damage_coefficient_500_bonus_2_pct",
	"damage_coefficient_1000_bonus_2_pct",
	"delayed_primary_attribute_projectile_bonus",
	"level_up_attack_speed_gain",
	"level_up_attack_speed_gain_pct",

	-- Критические уроны
	"physical_crit_chance_pct", -- Шанс физического урона
	"physical_crit_damage_pct", -- Урон физического урона
	"final_physical_crit_damage_pct", -- Финальный физический урона (pct)

	"magical_crit_chance_pct", -- Шанс магического урона
	"magical_crit_damage_pct", -- Урон магического урона
	"final_magical_crit_damage_pct", -- Финальный магический урона (pct)
}

local STAT_KEYS_DEFAULTS = {
	physical_crit_chance_pct = BASE_PHYSICAL_CRIT_CHANCE_PCT,
	physical_crit_damage_pct = BASE_PHYSICAL_CRIT_DAMAGE_PCT,
	magical_crit_chance_pct = BASE_MAGICAL_CRIT_CHANCE_PCT,
	magical_crit_damage_pct = BASE_MAGICAL_CRIT_DAMAGE_PCT,
	extra_projectile_damage_pct = BASE_EXTRA_PROJECTILE_DAMAGE_PCT,
	bounce_damage_pct = BASE_BOUNCE_DAMAGE_PCT,
	health_regen_pct = HEALTH_REGEN_PCT,
}

local function create_empty_stat_bucket()
	local data = {}
	for _, key in ipairs(STAT_KEYS) do
		data[key] = 0
	end
	return data
end

-- Ниже идут приколы (штук 5) для определения, что и как подается на вход методу LevelUpSetCustomStatsBonus, их скипай
local function normalize_stat_bucket(raw)
	local data = {}
	if type(raw) ~= "table" then
		return data
	end
	for _, key in ipairs(STAT_KEYS) do
		local value = to_number(raw[key], 0)
		if value ~= 0 then
			data[key] = value
		end
	end
	return data
end

local function create_empty_source_entry()
	return {
		base = {},
		bonus = {},
	}
end

local function normalize_source_entry(raw_bonus_table, mode_or_options)
	local entry = create_empty_source_entry()
	local src = raw_bonus_table or {}

	if type(src) ~= "table" then
		return entry
	end

	local normalized = NormalizeStatBonuses(src, mode_or_options)
	entry.base = normalize_stat_bucket(normalized.base)
	entry.bonus = normalize_stat_bucket(normalized.bonus)

	return entry
end

local function add_buckets(target, source)
	for key, value in pairs(source) do
		local current = target[key]
		if current ~= nil then
			target[key] = current + to_number(value, 0)
		end
	end
end

local function get_multiplicative_reduction_pct_from_sources(sources, stat_key)
	if type(sources) ~= "table" or stat_key == nil then
		return 0
	end

	local remaining_multiplier = 1.0
	local contributing_sources = 0

	for _, source_entry in pairs(sources) do
		if type(source_entry) == "table" then
			local source_pct = (tonumber(source_entry.base and source_entry.base[stat_key]) or 0)
				+ (tonumber(source_entry.bonus and source_entry.bonus[stat_key]) or 0)

			if source_pct > 0 then
				remaining_multiplier = remaining_multiplier * math.max(0, 1 - source_pct * 0.01)
				contributing_sources = contributing_sources + 1
			end
		end
	end

	if contributing_sources <= 1 then
		return math.max(0, (1 - remaining_multiplier) * 100)
	end

	-- Асимптота для бонусов, складывающихся по закону убывающей полезности
	local cap = 0.9
	local softened_remaining = (1 - cap) + cap * remaining_multiplier ^ (1 / cap)

	return math.max(0, (1 - softened_remaining) * 100)
end

local function apply_percent_bonus(base_value, pct_bonus)
	return math.ceil(base_value * (1 + pct_bonus * 0.01))
end

local function get_coefficient_scaled_pct(pct_bonus, coefficient)
	return (tonumber(pct_bonus) or 0) * (1 + (tonumber(coefficient) or 0) * 0.0001)
end

local function get_percent_increase_bonus(base_value, pct_bonus)
	local value = (tonumber(base_value) or 0) * (tonumber(pct_bonus) or 0) * 0.01
	return value > 0 and math.ceil(value) or 0
end

local function get_threshold_bonus(value, thresholds)
	local result = 0
	value = tonumber(value) or 0
	for _, threshold_data in ipairs(thresholds or {}) do
		if value >= (tonumber(threshold_data.threshold) or 0) then
			result = tonumber(threshold_data.value) or result
		end
	end
	return result
end

local function get_current_dota_time()
	if GameRules and GameRules.GetDOTATime then
		local ok, dota_time = pcall(function()
			return GameRules:GetDOTATime(false, false)
		end)
		if ok and tonumber(dota_time) then
			return math.max(0, tonumber(dota_time) or 0)
		end
	end
	return GameRules and GameRules.GetGameTime and GameRules:GetGameTime() or 0
end

local function has_service_atlas_item(player_id, item_id)
	return services and services.HasAtlasItem and services:HasAtlasItem(player_id, item_id) == true
end

function levelup_hero_handler:Spawn()
	if not IsServer() then
		return
	end
	if self:IsTrained() then
		return
	end
	self:SetLevel(1)
end

function levelup_hero_handler:OnInventoryContentsChanged()
	self:RefreshStatModifier()
	if not IsServer() then
		return
	end
	CustomGameEventManager:Send_ServerToPlayer(self:GetCaster():GetPlayerOwner(), "game_event_sync_item_slots", {})
end

function levelup_hero_handler:OnHeroCalculateStatBonus()
	self:RefreshStatModifier()
end

function levelup_hero_handler:RefreshStatModifier()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end

	local modifier = caster:GetLevelUpHeroHandlerModifier()
	if not modifier or modifier:IsNull() then
		caster:UpdateClientStats()
		return
	end

	if modifier:IsRecalculating() then
		return
	end
	modifier:RecalculateStats()
end

function levelup_hero_handler:GetIntrinsicModifierName()
	return "modifier_levelup_hero_handler"
end

function levelup_hero_handler:OnProjectileHit_ExtraData(target, location, extra_data)
	if not IsServer() then
		return true
	end

	local caster = self:GetCaster()
	if not IsValid(caster) then
		return true
	end

	local modifier = caster:GetLevelUpHeroHandlerModifier()
	if not IsValid(modifier) then
		return true
	end

	return modifier:OnAttackProjectileHit(target, extra_data)
end

modifier_levelup_hero_handler = class({})

function modifier_levelup_hero_handler:IsHidden()
	return true
end
function modifier_levelup_hero_handler:IsPurgable()
	return false
end
function modifier_levelup_hero_handler:IsPurgeException()
	return false
end
function modifier_levelup_hero_handler:IsPermanent()
	return true
end
function modifier_levelup_hero_handler:RemoveOnDeath()
	return false
end

function modifier_levelup_hero_handler:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
		MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_PERCENTAGE,
		MODIFIER_PROPERTY_MANA_BONUS,
		MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
		MODIFIER_PROPERTY_EVASION_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,
		MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS,

		MODIFIER_EVENT_ON_ATTACK_START,
		MODIFIER_EVENT_ON_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_LANDED,
	}
end

function modifier_levelup_hero_handler:GetAttackSound()
	local parent = self.parent or self:GetParent()
	if not IsValid(parent) then
		return nil
	end

	return parent._levelup_attack_sound
end

function modifier_levelup_hero_handler:OnAttackStart(params)
	if not IsServer() then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end
	if params.no_attack_cooldown then
		return
	end
	if not IsValid(params.target) then
		return
	end

	self:EmitLevelUpPreAttackSound()
end

function modifier_levelup_hero_handler:EmitLevelUpPreAttackSound()
	local parent = self.parent
	if not IsValid(parent) then
		return
	end
	if not parent._levelup_pre_attack_sound then
		return
	end

	EmitSoundOn(parent._levelup_pre_attack_sound, parent)
end

function modifier_levelup_hero_handler:EmitLevelUpAttackImpactSound(target)
	local parent = self.parent
	if not IsValid(parent, target) then
		return
	end
	if not parent._levelup_attack_impact_sound then
		return
	end

	StopSoundOn("Hero_Sniper.ProjectileImpact", target)
	EmitSoundOn(parent._levelup_attack_impact_sound, target)
end

function modifier_levelup_hero_handler:CheckState()
	return {
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_levelup_hero_handler:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	if not IsServer() then
		return
	end

	self.bonus_sources = {}
	self.bonus_cache_base = create_empty_stat_bucket()
	self.bonus_cache_bonus = create_empty_stat_bucket()

	self._is_recalculating = false
	self._is_initted = false

	self.str_custom_base = CUSTOM_BASE_ATTRIBUTE
	self.agi_custom_base = CUSTOM_BASE_ATTRIBUTE
	self.int_custom_base = CUSTOM_BASE_ATTRIBUTE

	self.str_custom_base_total = CUSTOM_BASE_ATTRIBUTE
	self.agi_custom_base_total = CUSTOM_BASE_ATTRIBUTE
	self.int_custom_base_total = CUSTOM_BASE_ATTRIBUTE

	self.str_custom_bonus = 0
	self.agi_custom_bonus = 0
	self.int_custom_bonus = 0

	self.str_custom = CUSTOM_BASE_ATTRIBUTE
	self.agi_custom = CUSTOM_BASE_ATTRIBUTE
	self.int_custom = CUSTOM_BASE_ATTRIBUTE

	self.primary_attribute = DOTA_ATTRIBUTE_STRENGTH
	self.primary_attribute_base_value = CUSTOM_BASE_ATTRIBUTE
	self.primary_attribute_bonus_value = 0
	self.primary_attribute_value = CUSTOM_BASE_ATTRIBUTE

	self.base_attack_bonus = 0
	self.pre_attack_bonus = 0
	self.attack_speed_base = 0
	self.attack_speed_bonus = 0
	self.attack_range_bonus = 0
	self.attack_range_bonus_pct = 0
	self.move_speed_constant = 0
	self.move_speed_pct_base = 0
	self.move_speed_pct_bonus = 0
	self.base_attack_time_reduction = 0
	self.armor_base = BASE_ARMOR
	self.armor_bonus = 0
	self.health_bonus = 0
	self.health_regen_constant = 0
	self.mana_bonus = 0
	self.mana_regen_constant = FIXED_MANA_REGEN
	self.proc_attack_bonus_physical = 0
	self.magical_spell_damage_bonus = 0
	self.artefact_damage_linear_bonus = 0
	self.xp_tick_accumulator = 0
	self.gold_tick_accumulator = 0
	self.wood_tick_accumulator = 0
	self.kills_tick_accumulator = 0
	self.str_tick_sum = 0
	self.agi_tick_sum = 0
	self.int_tick_sum = 0
	self.base_damage_min_initial = 0
	self.base_damage_max_initial = 0
	self.health_per_kill_sum = 0
	self.damage_per_kill_sum = 0
	self.damage_per_second_sum = 0
	self._extra_attack_depth = 0

	self.idle_damage_bonus = 0
	self.idle_damage_bonus_max = nil
	self._idle_time = 0
	self._idle_last_origin = nil

	self.double_strike_base = nil

	for _, key in ipairs(STAT_KEYS) do
		self[key] = 0
	end

	self:StartIntervalThink(1)
	self:RecalculateStats()
end

function modifier_levelup_hero_handler:OnRefresh()
	if not IsServer() then
		return
	end
	self:RecalculateStats()
end

function modifier_levelup_hero_handler:RecalculateStats()
	if not IsServer() then
		return
	end
	if self._is_recalculating then
		return
	end
	local parent = self.parent
	if not parent or parent:IsNull() then
		return
	end

	self._is_recalculating = true

	self.str_custom_base = math.max(1, to_number(self.str_custom_base, CUSTOM_BASE_ATTRIBUTE))
	self.agi_custom_base = math.max(1, to_number(self.agi_custom_base, CUSTOM_BASE_ATTRIBUTE))
	self.int_custom_base = math.max(1, to_number(self.int_custom_base, CUSTOM_BASE_ATTRIBUTE))

	self:RebuildBonusCache()

	local base_bonus = self.bonus_cache_base or create_empty_stat_bucket()
	local green_bonus = self.bonus_cache_bonus or create_empty_stat_bucket()
	local hero_level = math.max(1, parent:GetLevel())
	local player_id = parent:GetPlayerOwnerID()

	-- Другие вычисления (Пока сюда все закину)
	self.proc_attack_bonus_physical = self.agi_custom * AGI_ATTACK_PROC_PHYSICAL_FACTOR
	self.magical_spell_damage_bonus = self.int_custom * INT_MAGICAL_SPELL_DAMAGE_FACTOR
	self.artefact_damage_linear_bonus = self.int_custom * INT_ARTEFACT_DAMAGE_LINEAR_FACTOR
	self.chest_reward_gold_pct = base_bonus.chest_reward_gold_pct + green_bonus.chest_reward_gold_pct
	self.challenger_count_bonus =
		math.floor(base_bonus.challenger_count_bonus + green_bonus.challenger_count_bonus + 0.5)
	self.challenger_enemy_damage_pct =
		math.floor(base_bonus.challenger_enemy_damage_pct + green_bonus.challenger_enemy_damage_pct + 0.5)
	self.challenger_elite_damage_pct =
		math.floor(base_bonus.challenger_elite_damage_pct + green_bonus.challenger_elite_damage_pct + 0.5)
	self.challenger_leader_damage_pct =
		math.floor(base_bonus.challenger_leader_damage_pct + green_bonus.challenger_leader_damage_pct + 0.5)

	self.incoming_damage_pct = math.floor(base_bonus.incoming_damage_pct + green_bonus.incoming_damage_pct + 0.5)
	self.incoming_damage_pct_plus =
		math.floor(base_bonus.incoming_damage_pct_plus + green_bonus.incoming_damage_pct_plus + 0.5)
	self.damage_per_units_in_radius_effect = base_bonus.damage_per_units_in_radius_effect
		+ green_bonus.damage_per_units_in_radius_effect
	self.incoming_damage_per_units_in_radius_effect = base_bonus.incoming_damage_per_units_in_radius_effect
		+ green_bonus.incoming_damage_per_units_in_radius_effect
	self.outgoing_damage_pct = math.floor(base_bonus.outgoing_damage_pct + green_bonus.outgoing_damage_pct + 0.5)
	self.evasion = math.floor(base_bonus.evasion + green_bonus.evasion + 0.5)
	self.health_coefficient = math.floor(base_bonus.health_coefficient + green_bonus.health_coefficient + 0.5)
	self.health_per_sec = math.floor(base_bonus.health_per_sec + green_bonus.health_per_sec + 0.5)
	self.health_per_kill = math.floor(base_bonus.health_per_kill + green_bonus.health_per_kill + 0.5)
	self.mana_pct = math.floor(base_bonus.mana_pct + green_bonus.mana_pct + 0.5)
	self.mana_regen_pct = math.floor(base_bonus.mana_regen_pct + green_bonus.mana_regen_pct + 0.5)
	self.xp_per_sec_pct = math.floor(base_bonus.xp_per_sec_pct + green_bonus.xp_per_sec_pct + 0.5)
	self.str_coefficient = math.floor(base_bonus.str_coefficient + green_bonus.str_coefficient + 0.5)
	self.agi_coefficient = math.floor(base_bonus.agi_coefficient + green_bonus.agi_coefficient + 0.5)
	self.int_coefficient = math.floor(base_bonus.int_coefficient + green_bonus.int_coefficient + 0.5)
	self.all_attributes_per_sec =
		math.floor(base_bonus.all_attributes_per_sec + green_bonus.all_attributes_per_sec + 0.5)
	self.all_attributes_per_kill =
		math.floor(base_bonus.all_attributes_per_kill + green_bonus.all_attributes_per_kill + 0.5)
	self.all_attributes_pct = math.floor(base_bonus.all_attributes_pct + green_bonus.all_attributes_pct + 0.5)
	self.all_attributes_coefficient =
		math.floor(base_bonus.all_attributes_coefficient + green_bonus.all_attributes_coefficient + 0.5)
	self.damage_per_kill = math.floor(base_bonus.damage_per_kill + green_bonus.damage_per_kill + 0.5)
	self.damage_per_sec = math.floor(base_bonus.damage_per_sec + green_bonus.damage_per_sec + 0.5)
	self.attack_damage_pct = math.floor(base_bonus.attack_damage_pct + green_bonus.attack_damage_pct + 0.5)
	self.final_attack_damage_pct =
		math.floor(base_bonus.final_attack_damage_pct + green_bonus.final_attack_damage_pct + 0.5)
	self.damage_increase = math.floor(base_bonus.damage_increase + green_bonus.damage_increase + 0.5)
	self.damage_amplification = math.floor(base_bonus.damage_amplification + green_bonus.damage_amplification + 0.5)
	self.final_damage_coefficient =
		math.floor(base_bonus.final_damage_coefficient + green_bonus.final_damage_coefficient + 0.5)
	self.final_damage_pct = get_coefficient_scaled_pct(
		base_bonus.final_damage_pct + green_bonus.final_damage_pct,
		self.final_damage_coefficient
	)
	self.physical_damage_coefficient =
		math.floor(base_bonus.physical_damage_coefficient + green_bonus.physical_damage_coefficient + 0.5)
	self.physical_damage_pct = get_coefficient_scaled_pct(
		base_bonus.physical_damage_pct + green_bonus.physical_damage_pct,
		self.physical_damage_coefficient
	)
	self.fixed_physical_damage = math.floor(
		base_bonus.fixed_physical_damage
			+ green_bonus.fixed_physical_damage
			+ ((base_bonus.fixed_physical_damage_per_hero_level + green_bonus.fixed_physical_damage_per_hero_level) * hero_level)
			+ 0.5
	)
	self.fixed_physical_damage_pct =
		math.floor(base_bonus.fixed_physical_damage_pct + green_bonus.fixed_physical_damage_pct + 0.5)
	self.final_physical_damage = math.floor(base_bonus.final_physical_damage + green_bonus.final_physical_damage + 0.5)
	self.magical_damage_coefficient =
		math.floor(base_bonus.magical_damage_coefficient + green_bonus.magical_damage_coefficient + 0.5)
	self.magical_damage_pct = get_coefficient_scaled_pct(
		base_bonus.magical_damage_pct + green_bonus.magical_damage_pct,
		self.magical_damage_coefficient
	)
	self.fixed_magical_damage = math.floor(
		base_bonus.fixed_magical_damage
			+ green_bonus.fixed_magical_damage
			+ ((base_bonus.fixed_magical_damage_per_hero_level + green_bonus.fixed_magical_damage_per_hero_level) * hero_level)
			+ 0.5
	)
	self.fixed_magical_damage_pct =
		math.floor(base_bonus.fixed_magical_damage_pct + green_bonus.fixed_magical_damage_pct + 0.5)
	self.final_magical_damage = math.floor(base_bonus.final_magical_damage + green_bonus.final_magical_damage + 0.5)
	self.damage_coefficient_1 = math.floor(base_bonus.damage_coefficient_1 + green_bonus.damage_coefficient_1 + 0.5)
	self.damage_coefficient_2 = math.floor(base_bonus.damage_coefficient_2 + green_bonus.damage_coefficient_2 + 0.5)
	self.damage_coefficient_3 = math.floor(base_bonus.damage_coefficient_3 + green_bonus.damage_coefficient_3 + 0.5)
	if
		(base_bonus.damage_coefficient_threshold_bonus_effect + green_bonus.damage_coefficient_threshold_bonus_effect)
		> 0
	then
		self.damage_coefficient_2 = self.damage_coefficient_2
			+ get_threshold_bonus(self.damage_coefficient_1, {
				{
					threshold = 100,
					value = base_bonus.damage_coefficient_100_bonus_2_pct
						+ green_bonus.damage_coefficient_100_bonus_2_pct,
				},
				{
					threshold = 300,
					value = base_bonus.damage_coefficient_300_bonus_2_pct
						+ green_bonus.damage_coefficient_300_bonus_2_pct,
				},
				{
					threshold = 500,
					value = base_bonus.damage_coefficient_500_bonus_2_pct
						+ green_bonus.damage_coefficient_500_bonus_2_pct,
				},
				{
					threshold = 1000,
					value = base_bonus.damage_coefficient_1000_bonus_2_pct
						+ green_bonus.damage_coefficient_1000_bonus_2_pct,
				},
			})
	end
	self.final_physical_crit_damage_pct =
		math.floor(base_bonus.final_physical_crit_damage_pct + green_bonus.final_physical_crit_damage_pct + 0.5)
	self.magical_crit_chance_pct = BASE_MAGICAL_CRIT_CHANCE_PCT
		+ math.floor(base_bonus.magical_crit_chance_pct + green_bonus.magical_crit_chance_pct + 0.5)
	self.magical_crit_damage_pct = BASE_MAGICAL_CRIT_DAMAGE_PCT
		+ math.floor(base_bonus.magical_crit_damage_pct + green_bonus.magical_crit_damage_pct + 0.5)
	self.final_magical_crit_damage_pct =
		math.floor(base_bonus.final_magical_crit_damage_pct + green_bonus.final_magical_crit_damage_pct + 0.5)
	self.gold_gain_pct = math.floor(base_bonus.gold_gain_pct + green_bonus.gold_gain_pct + 0.5)
	self.kills_gain_pct = math.floor(base_bonus.kills_gain_pct + green_bonus.kills_gain_pct + 0.5)
	self.ability_damage_pct = math.floor(base_bonus.ability_damage_pct + green_bonus.ability_damage_pct + 0.5)
	self.ability_aoe_damage_pct =
		math.floor(base_bonus.ability_aoe_damage_pct + green_bonus.ability_aoe_damage_pct + 0.5)
	self.damage_pierce_pct = math.floor(base_bonus.damage_pierce_pct + green_bonus.damage_pierce_pct + 0.5)
	self.passive_artefact_damage_pct =
		math.floor(base_bonus.passive_artefact_damage_pct + green_bonus.passive_artefact_damage_pct + 0.5)
	self.hp_restore_amp_pct = math.floor(base_bonus.hp_restore_amp_pct + green_bonus.hp_restore_amp_pct + 0.5)

	local dynamic_str_base = (base_bonus.base_str_per_hero_level + green_bonus.base_str_per_hero_level) * hero_level
	local dynamic_agi_base = (base_bonus.base_agi_per_hero_level + green_bonus.base_agi_per_hero_level) * hero_level
	local dynamic_int_base = (base_bonus.base_int_per_hero_level + green_bonus.base_int_per_hero_level) * hero_level
	local dynamic_str_base_pct = (base_bonus.str_base_pct_per_hero_level + green_bonus.str_base_pct_per_hero_level)
		* hero_level
	local dynamic_agi_base_pct = (base_bonus.agi_base_pct_per_hero_level + green_bonus.agi_base_pct_per_hero_level)
		* hero_level
	local dynamic_int_base_pct = (base_bonus.int_base_pct_per_hero_level + green_bonus.int_base_pct_per_hero_level)
		* hero_level
	local dynamic_damage = (base_bonus.damage_per_hero_level + green_bonus.damage_per_hero_level) * hero_level
	local dynamic_health_base = base_bonus.health_per_hero_level * hero_level
	local dynamic_health_bonus = green_bonus.health_per_hero_level * hero_level

	-- Рассчет базовых и зеленых атрибутов
	local str_base_flat = self.str_custom_base + base_bonus.str + dynamic_str_base
	local agi_base_flat = self.agi_custom_base + base_bonus.agi + dynamic_agi_base
	local int_base_flat = self.int_custom_base + base_bonus.int + dynamic_int_base
	self.str_custom_base_flat = str_base_flat
	self.agi_custom_base_flat = agi_base_flat
	self.int_custom_base_flat = int_base_flat

	self.str_base_pct = base_bonus.str_base_pct + green_bonus.str_base_pct + dynamic_str_base_pct
	self.agi_base_pct = base_bonus.agi_base_pct + green_bonus.agi_base_pct + dynamic_agi_base_pct
	self.int_base_pct = base_bonus.int_base_pct + green_bonus.int_base_pct + dynamic_int_base_pct

	self.str_custom_base_total = math.max(1, math.floor(str_base_flat * (1 + self.str_base_pct * 0.01) + 0.5))
	self.agi_custom_base_total = math.max(1, math.floor(agi_base_flat * (1 + self.agi_base_pct * 0.01) + 0.5))
	self.int_custom_base_total = math.max(1, math.floor(int_base_flat * (1 + self.int_base_pct * 0.01) + 0.5))

	local all_attributes_total_pct_bonus =
		get_coefficient_scaled_pct(self.all_attributes_pct, self.all_attributes_coefficient)
	local str_total_pct_bonus = get_coefficient_scaled_pct(
		base_bonus.str_pct + green_bonus.str_pct,
		self.str_coefficient
	) + all_attributes_total_pct_bonus
	local agi_total_pct_bonus = get_coefficient_scaled_pct(
		base_bonus.agi_pct + green_bonus.agi_pct,
		self.agi_coefficient
	) + all_attributes_total_pct_bonus
	local int_total_pct_bonus = get_coefficient_scaled_pct(
		base_bonus.int_pct + green_bonus.int_pct,
		self.int_coefficient
	) + all_attributes_total_pct_bonus

	local atlas_scroll_001_bonus = 0
	local atlas_scroll_002_bonus = 0
	local atlas_scroll_003_bonus = 0
	local atlas_scroll_004_bonus = 0
	if player_id ~= nil and player_id >= 0 then
		if has_service_atlas_item(player_id, "atlas_scrolls_001") then
			local physical_crit_chance_for_scroll = BASE_PHYSICAL_CRIT_CHANCE_PCT
				+ base_bonus.physical_crit_chance_pct
				+ green_bonus.physical_crit_chance_pct
			local magical_crit_chance_for_scroll = BASE_MAGICAL_CRIT_CHANCE_PCT
				+ base_bonus.magical_crit_chance_pct
				+ green_bonus.magical_crit_chance_pct
			atlas_scroll_001_bonus = math.min(
				150,
				math.max(0, math.min(physical_crit_chance_for_scroll, magical_crit_chance_for_scroll) * 2)
			)
		end
		if has_service_atlas_item(player_id, "atlas_scrolls_002") then
			atlas_scroll_002_bonus = math.min(1000, math.floor(math.max(0, str_total_pct_bonus) / 10) * 10)
			self.damage_coefficient_1 = self.damage_coefficient_1 + atlas_scroll_002_bonus
		end
		if has_service_atlas_item(player_id, "atlas_scrolls_003") then
			atlas_scroll_003_bonus = math.min(5000, math.floor(math.max(0, agi_total_pct_bonus) / 10) * 50)
			self.physical_damage_coefficient = self.physical_damage_coefficient + atlas_scroll_003_bonus
			self.physical_damage_pct = get_coefficient_scaled_pct(
				base_bonus.physical_damage_pct + green_bonus.physical_damage_pct,
				self.physical_damage_coefficient
			)
		end
		if has_service_atlas_item(player_id, "atlas_scrolls_004") then
			atlas_scroll_004_bonus = math.min(5000, math.floor(math.max(0, int_total_pct_bonus) / 10) * 50)
			self.magical_damage_coefficient = self.magical_damage_coefficient + atlas_scroll_004_bonus
			self.magical_damage_pct = get_coefficient_scaled_pct(
				base_bonus.magical_damage_pct + green_bonus.magical_damage_pct,
				self.magical_damage_coefficient
			)
		end
		if
			atlas_scroll_002_bonus > 0
			and (
					base_bonus.damage_coefficient_threshold_bonus_effect
					+ green_bonus.damage_coefficient_threshold_bonus_effect
				)
				> 0
		then
			self.damage_coefficient_2 = math.floor(
				base_bonus.damage_coefficient_2 + green_bonus.damage_coefficient_2 + 0.5
			) + get_threshold_bonus(self.damage_coefficient_1, {
				{
					threshold = 100,
					value = base_bonus.damage_coefficient_100_bonus_2_pct
						+ green_bonus.damage_coefficient_100_bonus_2_pct,
				},
				{
					threshold = 300,
					value = base_bonus.damage_coefficient_300_bonus_2_pct
						+ green_bonus.damage_coefficient_300_bonus_2_pct,
				},
				{
					threshold = 500,
					value = base_bonus.damage_coefficient_500_bonus_2_pct
						+ green_bonus.damage_coefficient_500_bonus_2_pct,
				},
				{
					threshold = 1000,
					value = base_bonus.damage_coefficient_1000_bonus_2_pct
						+ green_bonus.damage_coefficient_1000_bonus_2_pct,
				},
			})
		end
		if has_service_atlas_item(player_id, "atlas_scrolls_005") then
			local min_scroll_bonus =
				math.min(atlas_scroll_001_bonus, atlas_scroll_002_bonus, atlas_scroll_003_bonus, atlas_scroll_004_bonus)
			if min_scroll_bonus > 0 then
				local threshold_bonus = get_threshold_bonus(min_scroll_bonus, {
					{ threshold = 10, value = 150 },
					{ threshold = 25, value = 300 },
					{ threshold = 50, value = 450 },
					{ threshold = 75, value = 600 },
					{ threshold = 100, value = 800 },
				})
				self.all_attributes_coefficient = self.all_attributes_coefficient
					+ math.floor(min_scroll_bonus + threshold_bonus + 0.5)
				all_attributes_total_pct_bonus =
					get_coefficient_scaled_pct(self.all_attributes_pct, self.all_attributes_coefficient)
				str_total_pct_bonus = get_coefficient_scaled_pct(
					base_bonus.str_pct + green_bonus.str_pct,
					self.str_coefficient
				) + all_attributes_total_pct_bonus
				agi_total_pct_bonus = get_coefficient_scaled_pct(
					base_bonus.agi_pct + green_bonus.agi_pct,
					self.agi_coefficient
				) + all_attributes_total_pct_bonus
				int_total_pct_bonus = get_coefficient_scaled_pct(
					base_bonus.int_pct + green_bonus.int_pct,
					self.int_coefficient
				) + all_attributes_total_pct_bonus
			end
		end
	end

	self.str_custom_bonus =
		math.max(0, green_bonus.str + get_percent_increase_bonus(self.str_custom_base_total, str_total_pct_bonus))
	self.agi_custom_bonus =
		math.max(0, green_bonus.agi + get_percent_increase_bonus(self.agi_custom_base_total, agi_total_pct_bonus))
	self.int_custom_bonus =
		math.max(0, green_bonus.int + get_percent_increase_bonus(self.int_custom_base_total, int_total_pct_bonus))

	self.str_custom = self.str_custom_base_total + self.str_custom_bonus
	self.agi_custom = self.agi_custom_base_total + self.agi_custom_bonus
	self.int_custom = self.int_custom_base_total + self.int_custom_bonus

	-- Вычисление значений основного атрибута
	local primary_attribute = self:SyncHeroPrimaryAttribute()
	if primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		self.primary_attribute_base_value = self.str_custom_base_total
		self.primary_attribute_bonus_value = self.str_custom_bonus
	elseif primary_attribute == DOTA_ATTRIBUTE_AGILITY then
		self.primary_attribute_base_value = self.agi_custom_base_total
		self.primary_attribute_bonus_value = self.agi_custom_bonus
	else
		self.primary_attribute_base_value = self.int_custom_base_total
		self.primary_attribute_bonus_value = self.int_custom_bonus
	end
	self.primary_attribute_value = self.primary_attribute_base_value + self.primary_attribute_bonus_value

	local selected_hero_damage_bonus_pct = base_bonus.selected_universal_hero_damage_bonus_pct
		+ green_bonus.selected_universal_hero_damage_bonus_pct
	if primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		selected_hero_damage_bonus_pct = selected_hero_damage_bonus_pct
			+ base_bonus.selected_str_hero_damage_bonus_pct
			+ green_bonus.selected_str_hero_damage_bonus_pct
	elseif primary_attribute == DOTA_ATTRIBUTE_AGILITY then
		selected_hero_damage_bonus_pct = selected_hero_damage_bonus_pct
			+ base_bonus.selected_agi_hero_damage_bonus_pct
			+ green_bonus.selected_agi_hero_damage_bonus_pct
	elseif primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
		selected_hero_damage_bonus_pct = selected_hero_damage_bonus_pct
			+ base_bonus.selected_int_hero_damage_bonus_pct
			+ green_bonus.selected_int_hero_damage_bonus_pct
	end
	self.damage_amplification = self.damage_amplification + math.floor(selected_hero_damage_bonus_pct + 0.5)

	local fixed_damage_from_attributes = self.str_custom
			* (base_bonus.str_to_fixed_damage_ratio + green_bonus.str_to_fixed_damage_ratio)
		+ self.agi_custom * (base_bonus.agi_to_fixed_damage_ratio + green_bonus.agi_to_fixed_damage_ratio)
		+ self.int_custom * (base_bonus.int_to_fixed_damage_ratio + green_bonus.int_to_fixed_damage_ratio)
		+ self.primary_attribute_value
			* (base_bonus.primary_attribute_to_fixed_damage_ratio + green_bonus.primary_attribute_to_fixed_damage_ratio)
	if fixed_damage_from_attributes > 0 then
		local fixed_damage_bonus = math.floor(fixed_damage_from_attributes + 0.5)
		self.fixed_physical_damage = self.fixed_physical_damage + fixed_damage_bonus
		self.fixed_magical_damage = self.fixed_magical_damage + fixed_damage_bonus
	end

	if (base_bonus.agi_pct_threshold_fixed_damage_effect + green_bonus.agi_pct_threshold_fixed_damage_effect) > 0 then
		local agi_fixed_damage_pct = get_threshold_bonus(agi_total_pct_bonus, {
			{
				threshold = 100,
				value = base_bonus.agi_pct_100_fixed_damage_bonus_pct + green_bonus.agi_pct_100_fixed_damage_bonus_pct,
			},
			{
				threshold = 200,
				value = base_bonus.agi_pct_200_fixed_damage_bonus_pct + green_bonus.agi_pct_200_fixed_damage_bonus_pct,
			},
			{
				threshold = 300,
				value = base_bonus.agi_pct_300_fixed_damage_bonus_pct + green_bonus.agi_pct_300_fixed_damage_bonus_pct,
			},
			{
				threshold = 400,
				value = base_bonus.agi_pct_400_fixed_damage_bonus_pct + green_bonus.agi_pct_400_fixed_damage_bonus_pct,
			},
			{
				threshold = 500,
				value = base_bonus.agi_pct_500_fixed_damage_bonus_pct + green_bonus.agi_pct_500_fixed_damage_bonus_pct,
			},
		})
		self.fixed_physical_damage_pct = self.fixed_physical_damage_pct + agi_fixed_damage_pct
		self.fixed_magical_damage_pct = self.fixed_magical_damage_pct + agi_fixed_damage_pct
	end

	if (base_bonus.int_pct_threshold_fixed_damage_effect + green_bonus.int_pct_threshold_fixed_damage_effect) > 0 then
		local int_fixed_damage_pct = get_threshold_bonus(int_total_pct_bonus, {
			{
				threshold = 100,
				value = base_bonus.int_pct_100_fixed_damage_bonus_pct + green_bonus.int_pct_100_fixed_damage_bonus_pct,
			},
			{
				threshold = 200,
				value = base_bonus.int_pct_200_fixed_damage_bonus_pct + green_bonus.int_pct_200_fixed_damage_bonus_pct,
			},
			{
				threshold = 300,
				value = base_bonus.int_pct_300_fixed_damage_bonus_pct + green_bonus.int_pct_300_fixed_damage_bonus_pct,
			},
			{
				threshold = 400,
				value = base_bonus.int_pct_400_fixed_damage_bonus_pct + green_bonus.int_pct_400_fixed_damage_bonus_pct,
			},
			{
				threshold = 500,
				value = base_bonus.int_pct_500_fixed_damage_bonus_pct + green_bonus.int_pct_500_fixed_damage_bonus_pct,
			},
		})
		self.fixed_physical_damage_pct = self.fixed_physical_damage_pct + int_fixed_damage_pct
		self.fixed_magical_damage_pct = self.fixed_magical_damage_pct + int_fixed_damage_pct
	end

	-- Вычисление значений белого и зеленого урона
	self.pet_beaver_fixed_damage_bonus = services
			and services:GetBeaverFixedDamageBonus(parent, self.primary_attribute_value)
		or 0
	local target_base_damage = CUSTOM_BASE_ATTACK_DAMAGE
		+ self.primary_attribute_value
		+ base_bonus.damage
		+ dynamic_damage
		+ self.pet_beaver_fixed_damage_bonus
	self.base_attack_bonus = math.floor(target_base_damage + self.damage_per_second_sum + 0.5)
	self.pre_attack_bonus = math.floor((green_bonus.damage + self.damage_per_kill_sum) + 0.5)

	-- Вычисление значений скорости атаки
	local dynamic_attack_speed = (
		base_bonus.level_up_attack_speed_gain
		+ green_bonus.level_up_attack_speed_gain
		+ base_bonus.level_up_attack_speed_gain_pct
		+ green_bonus.level_up_attack_speed_gain_pct
	) * math.max(0, hero_level - 1)
	self.attack_speed_base = math.floor(base_bonus.attack_speed + dynamic_attack_speed + 0.5)
	self.attack_speed_bonus = math.floor(green_bonus.attack_speed + 0.5)

	-- Вычисление значений дальности атаки
	local raw_attack_range_bonus = math.floor(base_bonus.attack_range + green_bonus.attack_range + 0.5)
	local raw_attack_range_bonus_pct = math.floor(base_bonus.attack_range_pct + green_bonus.attack_range_pct + 0.5)
	local previous_attack_range_bonus = self.attack_range_bonus or 0
	local current_script_attack_range = parent:Script_GetAttackRange() or 0
	local base_script_attack_range = math.max(0, current_script_attack_range - previous_attack_range_bonus)
	local attack_range_base_override = tonumber(parent._levelup_base_attack_range_override)
	local effective_base_attack_range = attack_range_base_override or base_script_attack_range
	local pct_attack_range_base = math.max(0, effective_base_attack_range + raw_attack_range_bonus)
	local pct_attack_range_bonus = 0
	if raw_attack_range_bonus_pct > 0 then
		pct_attack_range_bonus = math.ceil(pct_attack_range_base * raw_attack_range_bonus_pct * 0.01)
	end
	self.attack_range_bonus = (effective_base_attack_range - base_script_attack_range)
		+ raw_attack_range_bonus
		+ pct_attack_range_bonus
	self.attack_range_bonus_pct = raw_attack_range_bonus_pct

	self.move_speed_constant = math.floor(base_bonus.move_speed + green_bonus.move_speed + 0.5)
	self.base_attack_time_reduction = math.floor(
		(base_bonus.base_attack_time_reduction + green_bonus.base_attack_time_reduction) * 100 + 0.5
	) * 0.01

	-- Дополнительные атаки героя + отскоки
	self.delayed_primary_attribute_projectile_bonus_value = math.floor(
		base_bonus.delayed_primary_attribute_projectile_bonus + green_bonus.delayed_primary_attribute_projectile_bonus
	)
	local delayed_primary_bonus = 0
	if get_current_dota_time() >= 120 then
		delayed_primary_bonus = self.delayed_primary_attribute_projectile_bonus_value
		if delayed_primary_bonus > 0 then
			self.delayed_primary_attribute_bonus_applied = true
		end
	end

	self.extra_attack_projectiles = math.floor(base_bonus.extra_attack_projectiles)
		+ math.floor(green_bonus.extra_attack_projectiles)
	if delayed_primary_bonus > 0 and primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		self.extra_attack_projectiles = self.extra_attack_projectiles + delayed_primary_bonus
	elseif delayed_primary_bonus > 0 and primary_attribute == DOTA_ATTRIBUTE_AGILITY then
		self.extra_attack_projectiles = self.extra_attack_projectiles + delayed_primary_bonus * 2
	end
	self.extra_projectile_damage_pct = math.floor(
		BASE_EXTRA_PROJECTILE_DAMAGE_PCT
			+ base_bonus.extra_projectile_damage_pct
			+ green_bonus.extra_projectile_damage_pct
			+ 0.5
	)
	self.bounce_count = math.floor(base_bonus.bounce_count) + math.floor(green_bonus.bounce_count)
	if delayed_primary_bonus > 0 and primary_attribute == DOTA_ATTRIBUTE_STRENGTH then
		self.bounce_count = self.bounce_count + delayed_primary_bonus
	elseif delayed_primary_bonus > 0 and primary_attribute == DOTA_ATTRIBUTE_INTELLECT then
		self.bounce_count = self.bounce_count + delayed_primary_bonus * 2
	end
	self.bounce_damage_pct =
		math.floor(BASE_BOUNCE_DAMAGE_PCT + base_bonus.bounce_damage_pct + green_bonus.bounce_damage_pct + 0.5)

	-- Вычисление значений скорости передвижения в %
	self.move_speed_pct_base = base_bonus.move_speed_pct
	self.move_speed_pct_bonus = green_bonus.move_speed_pct

	-- Вычисление значений брони
	local armor_base_total = BASE_ARMOR + base_bonus.armor
	local armor_total =
		apply_percent_bonus(armor_base_total + green_bonus.armor, base_bonus.armor_pct + green_bonus.armor_pct)
	self.armor_base = armor_base_total
	self.armor_bonus = math.max(0, armor_total - armor_base_total)
	self.armor_pct = math.floor(base_bonus.armor_pct + green_bonus.armor_pct + 0.5)
	self.armor_penetration_pct = math.floor(base_bonus.armor_penetration_pct + green_bonus.armor_penetration_pct + 0.5)
	self.magical_resistance = BASE_MAGICAL_RESISTANCE + base_bonus.magical_resistance + green_bonus.magical_resistance

	-- Вычисление значений здоровья
	local str_health_factor_pct = base_bonus.str_health_factor_pct + green_bonus.str_health_factor_pct
	local str_health_regen_factor_pct = base_bonus.str_health_regen_factor_pct + green_bonus.str_health_regen_factor_pct
	local str_health_factor = STR_HEALTH_FACTOR * (1 + str_health_factor_pct * 0.01)
	local str_health_regen_factor = STR_HEALTH_REGEN_FACTOR * (1 + str_health_regen_factor_pct * 0.01)

	local health_base_total = BASE_HEALTH_FLAT
		+ (self.str_custom * str_health_factor)
		+ base_bonus.health
		+ dynamic_health_base
	local health_flat_bonus = green_bonus.health + dynamic_health_bonus + self.health_per_kill_sum
	local str_threshold_health_pct = 0
	if (base_bonus.str_pct_threshold_health_effect + green_bonus.str_pct_threshold_health_effect) > 0 then
		str_threshold_health_pct = get_threshold_bonus(str_total_pct_bonus, {
			{
				threshold = 100,
				value = base_bonus.str_pct_100_health_bonus_pct + green_bonus.str_pct_100_health_bonus_pct,
			},
			{
				threshold = 200,
				value = base_bonus.str_pct_200_health_bonus_pct + green_bonus.str_pct_200_health_bonus_pct,
			},
			{
				threshold = 300,
				value = base_bonus.str_pct_300_health_bonus_pct + green_bonus.str_pct_300_health_bonus_pct,
			},
			{
				threshold = 400,
				value = base_bonus.str_pct_400_health_bonus_pct + green_bonus.str_pct_400_health_bonus_pct,
			},
			{
				threshold = 500,
				value = base_bonus.str_pct_500_health_bonus_pct + green_bonus.str_pct_500_health_bonus_pct,
			},
		})
	end
	self.health_pct = get_coefficient_scaled_pct(
		base_bonus.health_pct + green_bonus.health_pct,
		self.health_coefficient
	) + str_threshold_health_pct
	self.health_bonus = math.max(
		0,
		math.ceil(
			health_base_total + health_flat_bonus + get_percent_increase_bonus(health_base_total, self.health_pct)
		)
	)

	-- Вычисление регенерации здоровья
	self.health_regen_pct = HEALTH_REGEN_PCT + base_bonus.health_regen_pct + green_bonus.health_regen_pct
	self.health_regen_constant = BASE_HEALTH_REGEN_FLAT
		+ (self.str_custom * str_health_regen_factor)
		+ base_bonus.health_regen
		+ green_bonus.health_regen

	-- Вычисление регенерации маны
	self.mana_regen = math.floor(base_bonus.mana_regen + green_bonus.mana_regen + 0.5)
	local pre_mana_regen_constant = FIXED_MANA_REGEN + self.mana_regen
	self.mana_regen_constant = math.max(0, apply_percent_bonus(pre_mana_regen_constant, self.mana_regen_pct))

	-- Вычисление критического урона
	self.physical_crit_chance_pct = BASE_PHYSICAL_CRIT_CHANCE_PCT
		+ base_bonus.physical_crit_chance_pct
		+ green_bonus.physical_crit_chance_pct
	self.physical_crit_damage_pct = BASE_PHYSICAL_CRIT_DAMAGE_PCT
		+ base_bonus.physical_crit_damage_pct
		+ green_bonus.physical_crit_damage_pct
	if player_id ~= nil and player_id >= 0 and has_service_atlas_item(player_id, "atlas_scrolls_001") then
		self.physical_crit_damage_pct = self.physical_crit_damage_pct
			+ math.min(150, math.max(0, self.physical_crit_chance_pct * 2))
		self.magical_crit_damage_pct = self.magical_crit_damage_pct
			+ math.min(150, math.max(0, self.magical_crit_chance_pct * 2))
	end

	if player_id ~= nil and player_id >= 0 and services and services.GetActiveSetEffect then
		local antimagic_transfer = services:GetActiveSetEffect(player_id, "antimagic_crit_transfer")
		if antimagic_transfer then
			local transfer = math.floor(
				math.max(0, self.magical_crit_damage_pct) * (tonumber(antimagic_transfer.pct) or 0) / 100 + 0.5
			)
			self.magical_crit_damage_pct = self.magical_crit_damage_pct - transfer
			self.physical_crit_damage_pct = self.physical_crit_damage_pct + transfer
		end
		local multimagic_transfer = services:GetActiveSetEffect(player_id, "multimagic_crit_transfer")
		if multimagic_transfer then
			local transfer = math.floor(
				math.max(0, self.physical_crit_damage_pct) * (tonumber(multimagic_transfer.pct) or 0) / 100 + 0.5
			)
			self.physical_crit_damage_pct = self.physical_crit_damage_pct - transfer
			self.magical_crit_damage_pct = self.magical_crit_damage_pct + transfer
		end
	end

	-- Вычисление опыта
	self.xp_gain_pct = base_bonus.xp_gain_pct + green_bonus.xp_gain_pct
	local xp_per_sec_pre_bonus = math.max(0, math.floor(base_bonus.xp_per_sec + green_bonus.xp_per_sec + 0.5))
	self.xp_per_sec = math.max(0, apply_percent_bonus(xp_per_sec_pre_bonus, self.xp_per_sec_pct))

	-- Вычисление перезарядки
	self.cooldown_reduction = get_multiplicative_reduction_pct_from_sources(self.bonus_sources, "cooldown_reduction")
	self.passive_artefact_cooldown_reduction =
		get_multiplicative_reduction_pct_from_sources(self.bonus_sources, "passive_artefact_cooldown_reduction")
	self.passive_artefact_bonus_pct =
		math.floor(base_bonus.passive_artefact_bonus_pct + green_bonus.passive_artefact_bonus_pct + 0.5)

	-- Валюта в секунду
	local gold_per_sec_base_total = base_bonus.gold_per_sec + green_bonus.gold_per_sec
	local wood_per_sec_base_total = base_bonus.wood_per_sec + green_bonus.wood_per_sec
	local kills_per_sec_base_total = base_bonus.kills_per_sec + green_bonus.kills_per_sec
	local gold_per_sec_pct_total = base_bonus.gold_per_sec_pct + green_bonus.gold_per_sec_pct
	local wood_per_sec_pct_total = base_bonus.wood_per_sec_pct + green_bonus.wood_per_sec_pct
	local kills_per_sec_pct_total = base_bonus.kills_per_sec_pct + green_bonus.kills_per_sec_pct
	self.gold_per_sec_pct = math.floor(gold_per_sec_pct_total + 0.5)
	self.wood_per_sec_pct = math.floor(wood_per_sec_pct_total + 0.5)
	self.kills_per_sec_pct = math.floor(kills_per_sec_pct_total + 0.5)
	self.gold_per_sec = math.max(0, gold_per_sec_base_total * (1 + gold_per_sec_pct_total * 0.01))
	self.wood_per_sec = math.max(0, wood_per_sec_base_total * (1 + wood_per_sec_pct_total * 0.01))
	self.kills_per_sec = math.max(0, kills_per_sec_base_total * (1 + kills_per_sec_pct_total * 0.01))

	-- Атрибуты в секунду
	self.str_per_sec = base_bonus.str_per_sec + green_bonus.str_per_sec + self.all_attributes_per_sec
	self.agi_per_sec = base_bonus.agi_per_sec + green_bonus.agi_per_sec + self.all_attributes_per_sec
	self.int_per_sec = base_bonus.int_per_sec + green_bonus.int_per_sec + self.all_attributes_per_sec

	-- Атрибуты за убийство
	self.str_per_kill = base_bonus.str_per_kill + green_bonus.str_per_kill
	self.agi_per_kill = base_bonus.agi_per_kill + green_bonus.agi_per_kill
	self.int_per_kill = base_bonus.int_per_kill + green_bonus.int_per_kill

	-- Мана
	local target_max_mana = math.max(0, math.floor(FIXED_MAX_MANA + base_bonus.mana + green_bonus.mana + 0.5))
	local previous_mana_bonus = self.mana_bonus or 0
	local current_max_mana = parent:GetMaxMana()
	local base_max_mana = current_max_mana - previous_mana_bonus
	local pre_mana_bonus = math.floor(target_max_mana - base_max_mana + 0.5)
	self.mana_bonus = math.max(0, apply_percent_bonus(pre_mana_bonus, self.mana_pct))

	parent:CalculateStatBonus(true)

	local new_max_mana = parent:GetMaxMana()
	if parent:GetMana() > new_max_mana then
		parent:SetMana(new_max_mana)
	end

	parent:LevelUpSetMaxHealth(self.health_bonus)
	if not self._is_initted then
		parent:LevelUpSetHealth(self.health_bonus)
	end

	if services and services.UpdateBeaverSummonAura then
		services:UpdateBeaverSummonAura(parent, self.pet_beaver_fixed_damage_bonus)
	end

	-- Апдейт
	parent:UpdateClientStats()
	self._is_recalculating = false
	self._is_initted = true
	if card_system and card_system.RefreshDynamicRuntimeBonuses then
		card_system:RefreshDynamicRuntimeBonuses(parent)
	end
end

function modifier_levelup_hero_handler:OnIntervalThink()
	local parent = self.parent
	if not parent:IsRealHero() then
		return
	end
	if wave_manager and wave_manager.IsPostStageActive and wave_manager:IsPostStageActive() then
		return
	end
	if afk_mode_system and afk_mode_system.IsActive and afk_mode_system:IsActive() then
		return
	end

	if services and services.RefreshDynamicSetBonuses then
		services:RefreshDynamicSetBonuses(parent:GetPlayerOwnerID(), parent)
	end

	if self.idle_damage_bonus_max == nil then
		self.idle_damage_bonus_max = 0
		if services and services.GetAtlasStat then
			self.idle_damage_bonus_max = math.max(
				0,
				tonumber(
					services:GetAtlasStat(
						parent:GetPlayerOwnerID(),
						"idle_damage_bonus_pct",
						{ runtime_modifiers = true }
					)
				) or 0
			)
		end
	end
	if self.idle_damage_bonus_max > 0 then
		local origin = parent:GetAbsOrigin()
		local last_origin = self._idle_last_origin
		local moved = last_origin == nil or (origin - last_origin):Length2D() > 8
		self._idle_last_origin = origin
		if moved then
			self._idle_time = 0
			self.idle_damage_bonus = 0
		else
			self._idle_time = (self._idle_time or 0) + 1
			if self._idle_time >= 3 then
				self.idle_damage_bonus = self.idle_damage_bonus_max
			end
		end
	end

	if
		not self.delayed_primary_attribute_bonus_applied
		and (tonumber(self.delayed_primary_attribute_projectile_bonus_value) or 0) > 0
		and get_current_dota_time() >= 120
	then
		self:RecalculateStats()
		return
	end

	-- Опыт в секунду
	if self.xp_per_sec > 0 then
		self.xp_tick_accumulator = (self.xp_tick_accumulator or 0) + self.xp_per_sec
		local whole_xp = math.floor(self.xp_tick_accumulator)
		if whole_xp > 0 then
			self.xp_tick_accumulator = self.xp_tick_accumulator - whole_xp
			parent:AddExperience(whole_xp, DOTA_ModifyXP_Unspecified, false, true)
		end
	end

	-- Золото в секунду
	if self.gold_per_sec > 0 then
		self.gold_tick_accumulator = (self.gold_tick_accumulator or 0) + self.gold_per_sec
		local whole_gold = math.floor(self.gold_tick_accumulator)
		if whole_gold > 0 then
			self.gold_tick_accumulator = self.gold_tick_accumulator - whole_gold
			parent:LevelUpModifyGold(whole_gold)
		end
	end

	-- Дерево в секунду
	if self.wood_per_sec > 0 then
		self.wood_tick_accumulator = (self.wood_tick_accumulator or 0) + self.wood_per_sec
		local whole_wood = math.floor(self.wood_tick_accumulator)
		if whole_wood > 0 then
			self.wood_tick_accumulator = self.wood_tick_accumulator - whole_wood
			parent:LevelUpModifyWood(whole_wood)
		end
	end

	-- Заслуги в секунду
	if self.kills_per_sec > 0 then
		self.kills_tick_accumulator = (self.kills_tick_accumulator or 0) + self.kills_per_sec
		local whole_kills = math.floor(self.kills_tick_accumulator)
		if whole_kills > 0 then
			self.kills_tick_accumulator = self.kills_tick_accumulator - whole_kills
			parent:LevelUpModifyKills(whole_kills)
		end
	end

	local str_gain, agi_gain, int_gain = 0, 0, 0

	-- Сила в секунду
	if self.str_per_sec > 0 then
		self.str_tick_sum = (self.str_tick_sum or 0) + self.str_per_sec
		str_gain = math.floor(self.str_tick_sum)
		if str_gain > 0 then
			self.str_tick_sum = self.str_tick_sum - str_gain
		end
	end

	-- Ловкость в секунду
	if self.agi_per_sec > 0 then
		self.agi_tick_sum = (self.agi_tick_sum or 0) + self.agi_per_sec
		agi_gain = math.floor(self.agi_tick_sum)
		if agi_gain > 0 then
			self.agi_tick_sum = self.agi_tick_sum - agi_gain
		end
	end

	-- Интеллект в секунду
	if self.int_per_sec > 0 then
		self.int_tick_sum = (self.int_tick_sum or 0) + self.int_per_sec
		int_gain = math.floor(self.int_tick_sum)
		if int_gain > 0 then
			self.int_tick_sum = self.int_tick_sum - int_gain
		end
	end

	if self.damage_per_sec > 0 then
		self.damage_per_second_sum = (self.damage_per_second_sum or 0) + self.damage_per_sec
		self:MarkStatsDirty()
	end

	if str_gain > 0 or agi_gain > 0 or int_gain > 0 then
		self:ModifyCustomAttributesDeferred(str_gain, agi_gain, int_gain)
	end
end

function modifier_levelup_hero_handler:ResolveHeroPrimaryAttribute()
	local parent = self.parent
	if not IsValid(parent) then
		return DOTA_ATTRIBUTE_STRENGTH
	end

	local str_value = tonumber(self.str_custom) or 0
	local agi_value = tonumber(self.agi_custom) or 0
	local int_value = tonumber(self.int_custom) or 0
	local max_value = math.max(str_value, agi_value, int_value)

	local current_primary = self.primary_attribute
	if current_primary == nil and parent.GetPrimaryAttribute then
		current_primary = parent:GetPrimaryAttribute()
	end

	if current_primary == DOTA_ATTRIBUTE_STRENGTH and str_value == max_value then
		return DOTA_ATTRIBUTE_STRENGTH
	end
	if current_primary == DOTA_ATTRIBUTE_AGILITY and agi_value == max_value then
		return DOTA_ATTRIBUTE_AGILITY
	end
	if current_primary == DOTA_ATTRIBUTE_INTELLECT and int_value == max_value then
		return DOTA_ATTRIBUTE_INTELLECT
	end

	if str_value == max_value then
		return DOTA_ATTRIBUTE_STRENGTH
	end
	if agi_value == max_value then
		return DOTA_ATTRIBUTE_AGILITY
	end

	return DOTA_ATTRIBUTE_INTELLECT
end

function modifier_levelup_hero_handler:SyncHeroPrimaryAttribute()
	local parent = self.parent
	local primary_attribute = self:ResolveHeroPrimaryAttribute()

	if IsServer() and IsValid(parent) and parent:GetPrimaryAttribute() ~= primary_attribute then
		parent:SetPrimaryAttribute(primary_attribute)
	end

	self.primary_attribute = primary_attribute
	return primary_attribute
end

-- Устанавливает абсолютную базу кастомных атрибутов (без source-бонусов).
function modifier_levelup_hero_handler:SetCustomBaseAttributes(str, agi, int)
	self.str_custom_base = math.max(1, math.floor(to_number(str, self.str_custom_base or CUSTOM_BASE_ATTRIBUTE) + 0.5))
	self.agi_custom_base = math.max(1, math.floor(to_number(agi, self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE) + 0.5))
	self.int_custom_base = math.max(1, math.floor(to_number(int, self.int_custom_base or CUSTOM_BASE_ATTRIBUTE) + 0.5))
	self:RecalculateStats()
end

-- Изменяет базу кастомных атрибутов на дельту.
function modifier_levelup_hero_handler:ModifyCustomAttributes(str_delta, agi_delta, int_delta)
	self.str_custom_base = math.max(1, (self.str_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(str_delta, 0))
	self.agi_custom_base = math.max(1, (self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(agi_delta, 0))
	self.int_custom_base = math.max(1, (self.int_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(int_delta, 0))
	self:RecalculateStats()
end

local STATS_RECALC_BATCH_INTERVAL = 0.5

function modifier_levelup_hero_handler:MarkStatsDirty()
	if not IsServer() then
		return
	end
	if self._stats_recalc_pending then
		return
	end
	self._stats_recalc_pending = true
	Timers:CreateTimer(STATS_RECALC_BATCH_INTERVAL, function()
		self._stats_recalc_pending = false
		if not self.parent or self.parent:IsNull() then
			return nil
		end
		self:RecalculateStats()
		return nil
	end)
end

function modifier_levelup_hero_handler:ModifyCustomAttributesDeferred(str_delta, agi_delta, int_delta)
	self.str_custom_base = math.max(1, (self.str_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(str_delta, 0))
	self.agi_custom_base = math.max(1, (self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(agi_delta, 0))
	self.int_custom_base = math.max(1, (self.int_custom_base or CUSTOM_BASE_ATTRIBUTE) + to_number(int_delta, 0))
	self:MarkStatsDirty()
end

-- Пересчитывает кэши base/bonus каналов по всем source-источникам.
function modifier_levelup_hero_handler:RebuildBonusCache()
	local base_cache = self.bonus_cache_base or create_empty_stat_bucket()
	local bonus_cache = self.bonus_cache_bonus or create_empty_stat_bucket()

	for _, key in ipairs(STAT_KEYS) do
		base_cache[key] = 0
		bonus_cache[key] = 0
	end

	local sources = self.bonus_sources or {}
	for _, source_entry in pairs(sources) do
		add_buckets(base_cache, source_entry.base or {})
		add_buckets(bonus_cache, source_entry.bonus or {})
	end

	self.bonus_cache_base = base_cache
	self.bonus_cache_bonus = bonus_cache
end

--[[ Назначает/обновляет source-бонус.
    Поддержка форматов:
    1) Дефолт: { damage = 50 } + mode=nil -> base канал.
    2) Быстрый "зелёный": { damage = 50 } + mode=true/"bonus" -> bonus канал.
    3) Смешанный: { base = {...}, bonus = {...} }.
]]
function modifier_levelup_hero_handler:SetCustomBonusFromSource(source_key, bonus_table, mode_or_options, skip_recalc)
	if source_key == nil then
		return false
	end

	self.bonus_sources = self.bonus_sources or {}
	self.bonus_sources[tostring(source_key)] = normalize_source_entry(bonus_table, mode_or_options)
	if skip_recalc ~= true then
		self:RecalculateStats()
	end
	return true
end

function modifier_levelup_hero_handler:ClearCustomBonusFromSource(source_key, skip_recalc)
	if source_key == nil then
		return false
	end
	if not self.bonus_sources then
		return false
	end
	if self.bonus_sources[tostring(source_key)] == nil then
		return false
	end

	self.bonus_sources[tostring(source_key)] = nil
	if skip_recalc ~= true then
		self:RecalculateStats()
	end
	return true
end

function modifier_levelup_hero_handler:ClearAllCustomBonuses()
	self.bonus_sources = {}
	self:RecalculateStats()
end

function modifier_levelup_hero_handler:OnEntityKilled(unit)
	if not IsServer() then
		return
	end
	local str_per_kill = (self.str_per_kill or 0) + (self.all_attributes_per_kill or 0)
	local agi_per_kill = (self.agi_per_kill or 0) + (self.all_attributes_per_kill or 0)
	local int_per_kill = (self.int_per_kill or 0) + (self.all_attributes_per_kill or 0)
	local damage_per_kill = self.damage_per_kill or 0
	local health_per_kill = self.health_per_kill or 0
	local dirty = false
	if damage_per_kill > 0 then
		self.damage_per_kill_sum = (self.damage_per_kill_sum or 0) + damage_per_kill
		dirty = true
	end
	if health_per_kill > 0 then
		self.health_per_kill_sum = (self.health_per_kill_sum or 0) + health_per_kill
		dirty = true
	end
	if str_per_kill > 0 or agi_per_kill > 0 or int_per_kill > 0 then
		self.str_custom_base = math.max(1, (self.str_custom_base or CUSTOM_BASE_ATTRIBUTE) + str_per_kill)
		self.agi_custom_base = math.max(1, (self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE) + agi_per_kill)
		self.int_custom_base = math.max(1, (self.int_custom_base or CUSTOM_BASE_ATTRIBUTE) + int_per_kill)
		dirty = true
	end
	if dirty then
		self:MarkStatsDirty()
	end
end

function modifier_levelup_hero_handler:ModifyCustomStrength(str_delta)
	self:ModifyCustomAttributes(str_delta, 0, 0)
end

function modifier_levelup_hero_handler:ModifyCustomAgility(agi_delta)
	self:ModifyCustomAttributes(0, agi_delta, 0)
end

function modifier_levelup_hero_handler:ModifyCustomIntellect(int_delta)
	self:ModifyCustomAttributes(0, 0, int_delta)
end

function modifier_levelup_hero_handler:FindAttackProjectileTargets(search_origin, main_target, max_targets)
	local parent = self.parent
	if not IsValid(parent, main_target) then
		return {}
	end

	local enemies = FindUnitsInRadius(
		parent:GetTeamNumber(),
		search_origin,
		nil,
		parent:Script_GetAttackRange() + 50,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
		FIND_CLOSEST,
		false
	)

	local targets = {}
	local main_target_entindex = main_target:entindex()

	for _, enemy in ipairs(enemies) do
		if enemy:entindex() ~= main_target_entindex then
			table.insert(targets, enemy)
			if #targets >= max_targets then
				break
			end
		end
	end

	return targets
end

function modifier_levelup_hero_handler:BuildAttackProjectileDamageData(damage_pct)
	if not IsValid(self.parent) then
		return nil
	end

	local damage_scale = damage_pct * 0.01
	local attack_damage = self:GetCustomDamageBonus()
	local proc_physical = self:GetCustomProcAttackPhysicalBonus()

	local damage_data = {
		physical_attack_damage = math.floor((attack_damage + proc_physical) * damage_scale + 0.5),
	}

	self._prepared_attack_projectile_next_id = (self._prepared_attack_projectile_next_id or 0) + 1
	local context_id = self._prepared_attack_projectile_next_id
	self._prepared_attack_projectile_damage = self._prepared_attack_projectile_damage or {}
	self._prepared_attack_projectile_damage[context_id] = {
		physical = damage_data.physical_attack_damage > 0 and health_system:BuildPreparedDamage({
			attacker = self.parent,
			ability = self.ability,
			damage = damage_data.physical_attack_damage,
			damage_type = DAMAGE_TYPE_PHYSICAL,
			damage_kind = "physical_attack",
		}) or nil,
	}

	damage_data.prepared_context_id = context_id

	Timers:CreateTimer(10, function()
		if self._prepared_attack_projectile_damage then
			self._prepared_attack_projectile_damage[context_id] = nil
		end
		return nil
	end)

	return damage_data
end

function modifier_levelup_hero_handler:LaunchAttackProjectile(target, source, source_attachment, damage_data)
	local parent = self.parent
	local ability = self.ability
	if not IsValid(parent, ability, target, source) then
		return false
	end
	if type(damage_data) ~= "table" then
		return false
	end

	local physical_attack_damage = damage_data.physical_attack_damage or 0
	local projectile_name = parent._levelup_secondary_attack_projectile_name or parent:GetRangedProjectileName()
	if not projectile_name or projectile_name == "" then
		return false
	end

	local projectile_speed = parent:GetProjectileSpeed()
	local projectile = ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = source,
		Ability = ability,
		vSourceLoc = GetProjectileFxSourceOrigin(source),
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		bProvidesVision = false,
		iSourceAttachment = source_attachment,
		ExtraData = {
			physical_attack_damage = physical_attack_damage,
			prepared_context_id = tonumber(damage_data.prepared_context_id) or nil,
		},
	})
	CreateProjectileFx(source, projectile, projectile_name, {
		target = target,
		speed = projectile_speed,
	})

	return true
end

function modifier_levelup_hero_handler:GetLevelUpPerformAttackInterval()
	local parent = self.parent
	if not IsValid(parent) then
		return 1.7
	end

	if parent.GetSecondsPerAttack then
		local ok, value = pcall(function()
			return parent:GetSecondsPerAttack()
		end)
		value = ok and tonumber(value) or nil
		if value and value > 0 then
			return value
		end
	end

	local base_attack_time = self:GetModifierBaseAttackTimeConstant()
	local attack_speed_pct = self:GetModifierAttackSpeedPercentage()
	return math.max(0.03, base_attack_time / math.max(0.01, 1 + attack_speed_pct * 0.01))
end

function modifier_levelup_hero_handler:SpendLevelUpPerformAttackCooldown()
	local parent = self.parent
	if not IsValid(parent) then
		return
	end

	local next_attack_time = GameRules:GetGameTime() + self:GetLevelUpPerformAttackInterval()
	self._levelup_next_perform_attack_time = next_attack_time
	parent._levelup_next_perform_attack_time = next_attack_time
end

function modifier_levelup_hero_handler:GetLevelUpPerformAttackModifier(modifier_name)
	local parent = self.parent
	if not IsValid(parent) then
		return nil
	end

	local modifier = parent:FindModifierByName(modifier_name)
	if IsValid(modifier) then
		return modifier
	end
	return nil
end

function modifier_levelup_hero_handler:DispatchLevelUpPerformAttackEvent(method_name, attack_event)
	if type(attack_event) ~= "table" then
		return
	end

	local ultimate_modifier = self:GetLevelUpPerformAttackModifier("modifier_levelup_ultimate_handler")
	if ultimate_modifier and type(ultimate_modifier[method_name]) == "function" then
		ultimate_modifier[method_name](ultimate_modifier, attack_event)
	end

	local passive_modifier = self:GetLevelUpPerformAttackModifier("modifier_levelup_upgrade_stats_passive_artefact")
	if passive_modifier and type(passive_modifier[method_name]) == "function" then
		passive_modifier[method_name](passive_modifier, attack_event)
	end
end

function modifier_levelup_hero_handler:BuildLevelUpPerformAttackEvent(target, options)
	local parent = self.parent
	self._levelup_perform_attack_next_record = (self._levelup_perform_attack_next_record or 0) + 1

	return {
		attacker = parent,
		target = target,
		record = -self._levelup_perform_attack_next_record,
		levelup_perform_attack = true,
		levelup_process_procs = options.process_procs == true,
		levelup_skip_cooldown = options.skip_cooldown == true,
		levelup_use_projectile = options.use_projectile == true,
		levelup_fake_attack = options.fake_attack == true,
	}
end

function modifier_levelup_hero_handler:ApplyLevelUpAttackDamage(target, attack_event, options)
	if options.fake_attack == true then
		return
	end
	if not IsValid(target) or not target:IsAlive() then
		return
	end

	local physical_attack_damage = self:GetCustomDamageBonus() + self:GetCustomProcAttackPhysicalBonus()
	if physical_attack_damage <= 0 then
		return
	end

	local physical_attack_data = {
		victim = target,
		attacker = self.parent,
		ability = self.ability,
		damage = physical_attack_damage,
		damage_type = DAMAGE_TYPE_PHYSICAL,
		damage_kind = "physical_attack",
		attack_event = attack_event,
		force_physical_crit = attack_event.levelup_force_physical_crit == true,
		disable_crit = options.process_procs ~= true,
	}

	ApplyDamage(physical_attack_data, "attack_damage")

	if options.process_procs == true and physical_attack_data.was_critical and card_system then
		card_system:HandleRuntimeByTrigger(self.parent, "on_attack_critical", {
			attacker = self.parent,
			target = target,
			original_attack_event = attack_event,
		}, self.ability)
	end

	if
		options.process_procs == true
		and options.levelup_double_strike ~= true
		and IsValid(target)
		and target:IsAlive()
	then
		local double_strike_chance = self:GetDoubleStrikeChance()
		if double_strike_chance > 0 and RollPercentage(double_strike_chance) then
			ApplyDamage({
				victim = target,
				attacker = self.parent,
				ability = self.ability,
				damage = physical_attack_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_kind = "physical_attack",
				attack_event = attack_event,
				disable_crit = true,
				levelup_double_strike = true,
			}, "attack_damage")
		end
	end
end

function modifier_levelup_hero_handler:GetDoubleStrikeChance()
	if self.double_strike_base == nil then
		self.double_strike_base = 0
		if services and services.GetAtlasStat then
			self.double_strike_base = math.max(
				0,
				tonumber(
					services:GetAtlasStat(
						self.parent:GetPlayerOwnerID(),
						"double_strike_base_chance_pct",
						{ runtime_modifiers = true }
					)
				) or 0
			)
		end
	end
	if self.double_strike_base <= 0 then
		return 0
	end

	local consumed_sets = 0
	if card_system and card_system.GetTotalConsumedBundleCompletions then
		consumed_sets = math.max(
			0,
			math.floor(tonumber(card_system:GetTotalConsumedBundleCompletions(self.parent:GetPlayerOwnerID())) or 0)
		)
	end

	return math.min(20, self.double_strike_base + consumed_sets)
end

function modifier_levelup_hero_handler:LaunchLevelUpAttackBounces(target)
	local bounce_count = math.floor(self.bounce_count or 0)
	if bounce_count <= 0 then
		return
	end

	local bounce_damage_data = self:BuildAttackProjectileDamageData(self.bounce_damage_pct)
	local bounce_targets = self:FindAttackProjectileTargets(target:GetAbsOrigin(), target, bounce_count)

	for _, bounce_target in ipairs(bounce_targets) do
		self:LaunchAttackProjectile(bounce_target, target, DOTA_PROJECTILE_ATTACHMENT_HITLOCATION, bounce_damage_data)
	end
end

function modifier_levelup_hero_handler:ResolveLevelUpAttackLanded(target, attack_event, options)
	local parent = self.parent
	if not IsServer() then
		return
	end
	if not IsValid(parent, target) then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	options = options or {}
	self:EmitLevelUpAttackImpactSound(target)

	local primary_hit_sound = tostring(parent._levelup_primary_attack_hit_sound or "")
	if primary_hit_sound ~= "" then
		target:EmitSound(primary_hit_sound)
	end

	if options.process_procs == true then
		attack_event.target = target
		if options.dispatch_landed_events == true then
			self:DispatchLevelUpPerformAttackEvent("OnAttackLanded", attack_event)
			if not IsValid(target) or not target:IsAlive() then
				return
			end
		end

		if card_system then
			card_system:HandleRuntimeByTrigger(parent, "on_attack_landed_before_damage", attack_event, self.ability)
			if not IsValid(target) or not target:IsAlive() then
				return
			end
			if attack_event.levelup_skip_attack_damage == true then
				return
			end
		end
	elseif not target:IsAlive() then
		return
	end

	self:ApplyLevelUpAttackDamage(target, attack_event, options)

	if options.process_procs == true and options.skip_bounces ~= true and IsValid(target) then
		self:LaunchLevelUpAttackBounces(target)
	end
end

function modifier_levelup_hero_handler:CreateLevelUpPerformAttackProjectileContext(attack_event, options)
	self._levelup_perform_attack_projectile_next_id = (self._levelup_perform_attack_projectile_next_id or 0) + 1
	local context_id = self._levelup_perform_attack_projectile_next_id

	self._levelup_perform_attack_projectile_contexts = self._levelup_perform_attack_projectile_contexts or {}
	self._levelup_perform_attack_projectile_contexts[context_id] = {
		attack_event = attack_event,
		options = options,
	}

	Timers:CreateTimer(10, function()
		if self._levelup_perform_attack_projectile_contexts then
			self._levelup_perform_attack_projectile_contexts[context_id] = nil
		end
		return nil
	end)

	return context_id
end

function modifier_levelup_hero_handler:LaunchLevelUpPerformAttackProjectile(target, attack_event, options)
	local parent = self.parent
	local ability = self.ability
	if not IsValid(parent, ability, target) then
		return false
	end

	local projectile_name = parent:GetRangedProjectileName()
	if not projectile_name or projectile_name == "" then
		return false
	end

	local context_id = self:CreateLevelUpPerformAttackProjectileContext(attack_event, options)
	local projectile_speed = parent:GetProjectileSpeed()
	local projectile = ProjectileManager:CreateTrackingProjectile({
		Target = target,
		Source = parent,
		Ability = ability,
		vSourceLoc = GetProjectileFxSourceOrigin(parent),
		iMoveSpeed = projectile_speed,
		bDodgeable = false,
		bProvidesVision = false,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
		ExtraData = {
			levelup_perform_attack_context_id = context_id,
		},
	})
	CreateProjectileFx(parent, projectile, projectile_name, {
		target = target,
		speed = projectile_speed,
	})

	return true
end

function modifier_levelup_hero_handler:OnAttackProjectileHit(target, extra_data)
	if not IsServer() then
		return true
	end
	extra_data = extra_data or {}

	local parent = self.parent
	local ability = self.ability
	if not IsValid(parent, ability, target) then
		return true
	end
	if not target:IsAlive() then
		return true
	end

	local perform_attack_context_id = tonumber(extra_data.levelup_perform_attack_context_id)
	if perform_attack_context_id then
		local contexts = self._levelup_perform_attack_projectile_contexts
		local context = contexts and contexts[perform_attack_context_id] or nil
		if context then
			contexts[perform_attack_context_id] = nil
			self:ResolveLevelUpAttackLanded(target, context.attack_event, context.options)
		end
		return true
	end

	local physical_attack_damage = extra_data.physical_attack_damage or 0
	local prepared_context_id = tonumber(extra_data.prepared_context_id)
	local prepared_context = prepared_context_id
			and self._prepared_attack_projectile_damage
			and self._prepared_attack_projectile_damage[prepared_context_id]
		or nil

	if physical_attack_damage > 0 then
		if prepared_context and prepared_context.physical then
			health_system:ApplyPreparedDamage(prepared_context.physical, target, "attack_damage")
		else
			ApplyDamage({
				victim = target,
				attacker = parent,
				ability = ability,
				damage = physical_attack_damage,
				damage_type = DAMAGE_TYPE_PHYSICAL,
				damage_kind = "physical_attack",
			}, "attack_damage")
		end
	end

	return true
end

function modifier_levelup_hero_handler:LevelUpPerformAttack(
	target,
	process_procs,
	skip_cooldown,
	use_projectile,
	fake_attack
)
	if not IsServer() then
		return false
	end

	local parent = self.parent
	if not IsValid(parent, target) then
		return false
	end
	if not parent:IsAlive() or not target:IsAlive() then
		return false
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return false
	end

	local options = {
		process_procs = process_procs ~= false,
		skip_cooldown = skip_cooldown == true,
		use_projectile = use_projectile ~= false,
		fake_attack = fake_attack == true,
	}

	local attack_event = self:BuildLevelUpPerformAttackEvent(target, options)

	parent:StartGesture(ACT_DOTA_ATTACK)
	self:EmitLevelUpPreAttackSound()

	if options.skip_cooldown ~= true then
		self:SpendLevelUpPerformAttackCooldown()
	end

	if options.process_procs == true then
		self:OnAttack(attack_event)
		self:DispatchLevelUpPerformAttackEvent("OnAttack", attack_event)
	end

	options.dispatch_landed_events = options.process_procs == true

	if options.use_projectile == true and self:LaunchLevelUpPerformAttackProjectile(target, attack_event, options) then
		return true
	end

	self:ResolveLevelUpAttackLanded(target, attack_event, options)
	return true
end

function modifier_levelup_hero_handler:OnAttack(params)
	if not IsServer() then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end
	if params.no_attack_cooldown then
		return
	end

	local target = params.target
	if not IsValid(target) or not target:IsAlive() then
		return
	end
	if target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	local extra_attacks = math.floor(self.extra_attack_projectiles or 0)
	if extra_attacks > 0 then
		local extra_damage_data = self:BuildAttackProjectileDamageData(self.extra_projectile_damage_pct)
		local extra_targets = self:FindAttackProjectileTargets(parent:GetAbsOrigin(), target, extra_attacks)

		for _, extra_target in ipairs(extra_targets) do
			self:LaunchAttackProjectile(extra_target, parent, DOTA_PROJECTILE_ATTACHMENT_ATTACK_1, extra_damage_data)
		end
	end
end

function modifier_levelup_hero_handler:OnAttackLanded(params)
	if not IsServer() then
		return
	end

	local parent = self.parent
	if params.attacker ~= parent then
		return
	end

	local target = params.target
	self:ResolveLevelUpAttackLanded(target, params, {
		process_procs = true,
		fake_attack = params.levelup_skip_attack_damage == true,
		skip_bounces = params.levelup_skip_attack_damage == true,
	})
end

-- Возврат кастомных значений
function modifier_levelup_hero_handler:IsRecalculating()
	return self._is_recalculating == true
end

function modifier_levelup_hero_handler:GetCustomStrength()
	return self.str_custom or 0
end

function modifier_levelup_hero_handler:GetCustomAgility()
	return self.agi_custom or 0
end

function modifier_levelup_hero_handler:GetCustomIntellect()
	return self.int_custom or 0
end

function modifier_levelup_hero_handler:GetCustomBaseStrength()
	return self.str_custom_base or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:GetCustomBaseAgility()
	return self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:GetCustomBaseIntellect()
	return self.int_custom_base or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:GetCustomDisplayBaseStrength()
	return self.str_custom_base_total or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:GetCustomDisplayBaseAgility()
	return self.agi_custom_base_total or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:GetCustomDisplayBaseIntellect()
	return self.int_custom_base_total or CUSTOM_BASE_ATTRIBUTE
end

function modifier_levelup_hero_handler:BuildCustomDisplayBaseAttributeDelta(attribute_name, display_delta)
	local requested_delta = to_number(display_delta, 0)
	if requested_delta == 0 then
		return 0, 0
	end

	local attribute = tostring(attribute_name or "")
	local current_raw = 0
	local current_flat = 0
	local current_display = 0
	local base_pct = 0

	if attribute == "strength" or attribute == "str" then
		current_raw = self.str_custom_base or CUSTOM_BASE_ATTRIBUTE
		current_flat = self.str_custom_base_flat or current_raw
		current_display = self.str_custom_base_total or CUSTOM_BASE_ATTRIBUTE
		base_pct = self.str_base_pct or 0
	elseif attribute == "agility" or attribute == "agi" then
		current_raw = self.agi_custom_base or CUSTOM_BASE_ATTRIBUTE
		current_flat = self.agi_custom_base_flat or current_raw
		current_display = self.agi_custom_base_total or CUSTOM_BASE_ATTRIBUTE
		base_pct = self.agi_base_pct or 0
	elseif attribute == "intellect" or attribute == "int" or attribute == "intelligence" then
		current_raw = self.int_custom_base or CUSTOM_BASE_ATTRIBUTE
		current_flat = self.int_custom_base_flat or current_raw
		current_display = self.int_custom_base_total or CUSTOM_BASE_ATTRIBUTE
		base_pct = self.int_base_pct or 0
	else
		return 0, 0
	end

	local multiplier = math.max(0.0001, 1 + base_pct * 0.01)
	local fixed_base = current_flat - current_raw
	local target_display = math.max(1, current_display + requested_delta)
	local target_raw = (target_display / multiplier) - fixed_base
	target_raw = math.max(1, target_raw)

	local function get_display_for_raw(raw_value)
		return math.max(1, math.floor((raw_value + fixed_base) * multiplier + 0.5))
	end

	local actual_delta = get_display_for_raw(target_raw) - current_display
	local step = 1 / multiplier

	if requested_delta > 0 then
		local guard = 0
		while actual_delta < requested_delta and guard < 20 do
			target_raw = target_raw + step
			actual_delta = get_display_for_raw(target_raw) - current_display
			guard = guard + 1
		end
	elseif requested_delta < 0 then
		local guard = 0
		while actual_delta > requested_delta and target_raw > 1 and guard < 20 do
			target_raw = math.max(1, target_raw - step)
			actual_delta = get_display_for_raw(target_raw) - current_display
			guard = guard + 1
		end
	end

	return target_raw - current_raw, actual_delta
end

function modifier_levelup_hero_handler:GetCustomDisplayBonusStrength()
	return self.str_custom_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomDisplayBonusAgility()
	return self.agi_custom_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomDisplayBonusIntellect()
	return self.int_custom_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomPrimaryAttribute()
	return self.primary_attribute or DOTA_ATTRIBUTE_STRENGTH
end

function modifier_levelup_hero_handler:GetCustomPrimaryAttributeValue()
	return self.primary_attribute_value or 0
end

function modifier_levelup_hero_handler:GetCustomDamageBonus()
	return (self.base_attack_bonus or 0) + (self.pre_attack_bonus or 0)
end

function modifier_levelup_hero_handler:GetCustomBaseDamageBonus()
	return self.base_attack_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomPreDamageBonus()
	return self.pre_attack_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomAttackSpeedBonus()
	return (self.attack_speed_base or 0) + (self.attack_speed_bonus or 0)
end

function modifier_levelup_hero_handler:GetCustomAttackRangeBonus()
	return self.attack_range_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomAttackRangeBonusPct()
	return self.attack_range_bonus_pct or 0
end

function modifier_levelup_hero_handler:GetCustomExtraAttackProjectiles()
	return math.floor(self.extra_attack_projectiles or 0)
end

function modifier_levelup_hero_handler:GetCustomExtraProjectileDamagePct()
	return self.extra_projectile_damage_pct or BASE_EXTRA_PROJECTILE_DAMAGE_PCT
end

function modifier_levelup_hero_handler:GetCustomBounceCount()
	return math.floor(self.bounce_count or 0)
end

function modifier_levelup_hero_handler:GetCustomBounceDamagePct()
	return self.bounce_damage_pct or BASE_BOUNCE_DAMAGE_PCT
end

function modifier_levelup_hero_handler:GetCustomMoveSpeedPctBonus()
	return (self.move_speed_pct_base or 0) + (self.move_speed_pct_bonus or 0)
end

function modifier_levelup_hero_handler:GetCustomArmorBonus()
	return (self.armor_base or 0) + (self.armor_bonus or 0)
end

function modifier_levelup_hero_handler:GetCustomBaseArmorBonus()
	return self.armor_base or 0
end

function modifier_levelup_hero_handler:GetCustomGreenArmorBonus()
	return self.armor_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomArmorPct()
	return self.armor_pct or 0
end

function modifier_levelup_hero_handler:GetCustomArmorPenetrationPct()
	return self.armor_penetration_pct or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalResistance()
	return self.magical_resistance or BASE_MAGICAL_RESISTANCE
end

function modifier_levelup_hero_handler:GetCustomExtraHealthBonus()
	return self.health_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomHealthPct()
	return self.health_pct or 0
end

function modifier_levelup_hero_handler:GetCustomHealthRegenPct()
	return self.health_regen_pct or 0
end

function modifier_levelup_hero_handler:GetCustomHealthRegenConstant()
	return self.health_regen_constant or 0
end

function modifier_levelup_hero_handler:GetCustomManaBonus()
	return self.mana_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomManaRegen()
	return self.mana_regen or 0
end

function modifier_levelup_hero_handler:GetCustomManaRegenConstant()
	return self.mana_regen_constant or 0
end

function modifier_levelup_hero_handler:GetCustomPhysicalCritChancePct()
	return self.physical_crit_chance_pct or 0
end

function modifier_levelup_hero_handler:GetCustomPhysicalCritDamagePct()
	return self.physical_crit_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomProcAttackPhysicalBonus()
	return self.proc_attack_bonus_physical or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalSpellDamageBonus()
	return self.magical_spell_damage_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomArtefactDamageLinearBonus()
	return self.artefact_damage_linear_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomExperienceGainPct()
	return self.xp_gain_pct or 0
end

function modifier_levelup_hero_handler:GetCustomExperiencePerSecond()
	return self.xp_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomCooldownReduction()
	return self.cooldown_reduction or 0
end

function modifier_levelup_hero_handler:GetCustomPassiveArtefactCooldownReduction()
	return self.passive_artefact_cooldown_reduction or 0
end

function modifier_levelup_hero_handler:GetCustomPassiveArtefactBonusPct()
	return self.passive_artefact_bonus_pct or 0
end

function modifier_levelup_hero_handler:GetCustomGoldPerSecond()
	return self.gold_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomGoldGainPct()
	return self.gold_gain_pct or 0
end

function modifier_levelup_hero_handler:GetCustomKillsGainPct()
	return self.kills_gain_pct or 0
end

function modifier_levelup_hero_handler:GetCustomWoodPerSecond()
	return self.wood_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomKillsPerSecond()
	return self.kills_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomGoldPerSecondPct()
	return self.gold_per_sec_pct or 0
end

function modifier_levelup_hero_handler:GetCustomWoodPerSecondPct()
	return self.wood_per_sec_pct or 0
end

function modifier_levelup_hero_handler:GetCustomKillsPerSecondPct()
	return self.kills_per_sec_pct or 0
end

function modifier_levelup_hero_handler:GetCustomStrengthPerKill()
	return self.str_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomAgilityPerKill()
	return self.agi_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomIntellectPerKill()
	return self.int_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomStrengthPerSecond()
	return self.str_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomAgilityPerSecond()
	return self.agi_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomIntellectPerSecond()
	return self.int_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomChestRewardGoldPct()
	return self.chest_reward_gold_pct or 0
end

function modifier_levelup_hero_handler:GetCustomChallengerCountBonus()
	return self.challenger_count_bonus or 0
end

function modifier_levelup_hero_handler:GetCustomChallengerEnemyDamagePct()
	return self.challenger_enemy_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomChallengerEliteDamagePct()
	return self.challenger_elite_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomChallengerLeaderDamagePct()
	return self.challenger_leader_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomIncomingDamagePct()
	return self.incoming_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomIncomingDamagePctPlus()
	return self.incoming_damage_pct_plus or 0
end

function modifier_levelup_hero_handler:GetCustomOutgoingDamagePct()
	return self.outgoing_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomEvasion()
	return self.evasion or 0
end

function modifier_levelup_hero_handler:GetCustomHealthCoefficient()
	return self.health_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomHealthPerSecond()
	return self.health_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomHealthPerKill()
	return self.health_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomManaPct()
	return self.mana_pct or 0
end

function modifier_levelup_hero_handler:GetCustomManaRegenPct()
	return self.mana_regen_pct or 0
end

function modifier_levelup_hero_handler:GetCustomXpPerSecondPct()
	return self.xp_per_sec_pct or 0
end

function modifier_levelup_hero_handler:GetCustomStrengthCoefficient()
	return self.str_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomAgilityCoefficient()
	return self.agi_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomIntellectCoefficient()
	return self.int_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomAllAttributesPerSecond()
	return self.all_attributes_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomAllAttributesPerKill()
	return self.all_attributes_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomAllAttributesPct()
	return self.all_attributes_pct or 0
end

function modifier_levelup_hero_handler:GetCustomAllAttributesCoefficient()
	return self.all_attributes_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomDamagePerKill()
	return self.damage_per_kill or 0
end

function modifier_levelup_hero_handler:GetCustomDamagePerSecond()
	return self.damage_per_sec or 0
end

function modifier_levelup_hero_handler:GetCustomAttackDamagePct()
	return self.attack_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomFinalAttackDamagePct()
	return self.final_attack_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomDamageIncrease()
	return self.damage_increase or 0
end

function modifier_levelup_hero_handler:GetCustomDamageAmplification()
	return self.damage_amplification or 0
end

function modifier_levelup_hero_handler:GetCustomFinalDamagePct()
	return self.final_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomAbilityDamagePct()
	return self.ability_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomAbilityAoeDamagePct()
	return self.ability_aoe_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomDamagePiercePct()
	return self.damage_pierce_pct or 0
end

function modifier_levelup_hero_handler:GetCustomPassiveArtefactDamagePct()
	return self.passive_artefact_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomHpRestoreAmpPct()
	return self.hp_restore_amp_pct or 0
end

function modifier_levelup_hero_handler:GetCustomPhysicalDamagePct()
	return self.physical_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomPhysicalDamageCoefficient()
	return self.physical_damage_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomFixedPhysicalDamage()
	return self.fixed_physical_damage or 0
end

function modifier_levelup_hero_handler:GetCustomFixedPhysicalDamagePct()
	return self.fixed_physical_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomFinalPhysicalDamage()
	return self.final_physical_damage or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalDamagePct()
	return self.magical_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalDamageCoefficient()
	return self.magical_damage_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomFixedMagicalDamage()
	return self.fixed_magical_damage or 0
end

function modifier_levelup_hero_handler:GetCustomFixedMagicalDamagePct()
	return self.fixed_magical_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomFinalMagicalDamage()
	return self.final_magical_damage or 0
end

function modifier_levelup_hero_handler:GetCustomDamageCoefficient1()
	return self.damage_coefficient_1 or 0
end

function modifier_levelup_hero_handler:GetCustomDamageCoefficient2()
	return self.damage_coefficient_2 or 0
end

function modifier_levelup_hero_handler:GetCustomDamageCoefficient3()
	return self.damage_coefficient_3 or 0
end

function modifier_levelup_hero_handler:GetCustomFinalDamageCoefficient()
	return self.final_damage_coefficient or 0
end

function modifier_levelup_hero_handler:GetCustomFinalPhysicalCritDamagePct()
	return self.final_physical_crit_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalCritChancePct()
	return self.magical_crit_chance_pct or 0
end

function modifier_levelup_hero_handler:GetCustomMagicalCritDamagePct()
	return self.magical_crit_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomFinalMagicalCritDamagePct()
	return self.final_magical_crit_damage_pct or 0
end

function modifier_levelup_hero_handler:GetCustomStrPct()
	return self.str_pct or 0
end

function modifier_levelup_hero_handler:GetCustomAgiPct()
	return self.agi_pct or 0
end

function modifier_levelup_hero_handler:GetCustomIntPct()
	return self.int_pct or 0
end

function modifier_levelup_hero_handler:GetCustomAttackRangePct()
	return self.attack_range_pct or 0
end

-- Возвращает адаптивное здоровье: от bonus str и bonus health (без базовой части).
function modifier_levelup_hero_handler:GetCustomAdaptiveHealth()
	local green_bonus = self.bonus_cache_bonus or create_empty_stat_bucket()
	local bonus_strength = tonumber(self.str_custom_bonus) or 0
	local bonus_health = tonumber(green_bonus.health) or 0
	return math.max(0, math.floor(bonus_strength * STR_HEALTH_FACTOR + bonus_health + 0.5))
end

-- Дотовские модификаторы значений
function modifier_levelup_hero_handler:GetModifierAttackSpeedPercentage()
	return (self.attack_speed_base or 0) + (self.attack_speed_bonus or 0)
end

function modifier_levelup_hero_handler:GetModifierAttackRangeBonus()
	return self.attack_range_bonus or 0
end

function modifier_levelup_hero_handler:GetModifierMoveSpeedBonus_Percentage()
	return (self.move_speed_pct_base or 0) + (self.move_speed_pct_bonus or 0)
end

function modifier_levelup_hero_handler:GetModifierManaBonus()
	return self.mana_bonus or 0
end

function modifier_levelup_hero_handler:GetModifierConstantManaRegen()
	return self.mana_regen_constant or 0
end

function modifier_levelup_hero_handler:GetModifierIncomingDamage_Percentage()
	return -10000
end

function modifier_levelup_hero_handler:GetModifierBaseAttackTimeConstant()
	return math.max(0.2, 1.7 - (self.base_attack_time_reduction or 0))
end

function modifier_levelup_hero_handler:GetModifierAttackSpeed_Limit()
	return 1
end

function modifier_levelup_hero_handler:GetModifierIgnoreMovespeedLimit()
	return 1
end

function modifier_levelup_hero_handler:GetModifierAttackSpeedBonus_Constant()
	return 0
end

function modifier_levelup_hero_handler:GetModifierMoveSpeedBonus_Constant()
	return self.move_speed_constant or 0
end

function modifier_levelup_hero_handler:GetModifierEvasion_Constant()
	return self.evasion or 0
end

function modifier_levelup_hero_handler:GetModifierProjectileSpeedBonus()
	if not IsServer() then
		return
	end
	if self:GetParent():GetLevelUpHeroName() ~= "npc_dota_hero_sniper" then
		return -1500
	end
end