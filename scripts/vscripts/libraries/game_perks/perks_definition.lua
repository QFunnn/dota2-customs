--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


GAME_PERKS = {
	{
		name = "family",
		next_tier_tooltip = { 2, 3, 4 },
	},
	{
		name = "slow_resistance",
		slow_resistance = { 30, 51, 76, 94 },
	},
	{
		name = "jungler",
		neutral_creeps_dmg_pct = { 15, 30, 60, 120 },
	},
	{
		name = "vision",
		vision = { 250, 500, 1000, 2000 },
	},
	{
		name = "magician",
		aoe_flat = { 25, 40, 65, 105 },
	},
	{
		name = "all_stats_for_kill",
		per_kill = { 0.375, 0.75, 1.5, 3 },
		stack_limit = 40,
	},
	{
		name = "crit",
		crit_multi = 220,
		crit_chance = { 5, 10, 20, 40 },
	},
	{
		name = "summon_power",
		summon_health = { 8, 16, 32, 64 },
		summon_damage = { 8, 16, 32, 64 },
	},
	{
		name = "magical_constitution",
		mana_to_hp = { 15, 30, 60, 120 },
	},
	{
		name = "disarmor",
		disarmor = { 2.5, 5, 10, 20 },
	},
	{
		name = "magical_damage",
		flat = { 2, 4, 8, 16 },
		level_step = 1,
		per_level = { 1, 2, 4, 8 },
	},
	{
		name = "hp_per_kill",
		heal = { 150, 300, 600, 1200 },
		heal_per_creep = { 30, 60, 120, 240 },
	},
	{
		name = "mp_per_kill",
		mana_restore = { 100, 200, 400, 800 },
		mana_restore_creep = { 20, 40, 80, 160 },
	},
	{
		name = "attack_speed",
		flat = { 2.5, 5, 10, 20 },
		level_step = 1,
		per_level = { 1.25, 2.5, 5, 10 },
	},
	{
		name = "armor",
		flat = { 2, 4, 8, 16 },
		level_step = 1,
		per_level = { 0.1, 0.2, 0.4, 0.8 },
	},
	{
		name = "tinkerer",
		bonus_pct = { 25, 50, 100, 200 },
	},
	{
		name = "buff_amplify",
		bonus_pct = { 8, 16, 32, 64 },
	},
	{
		name = "delayed_damage",
		pct = { 10, 20, 40, 80 },
		time = 8,
		interval = 0.25,
	},
	{
		name = "str_for_kill",
		per_kill = { 0.75, 1.5, 3, 6 },
		stack_limit = 40,
	},
	{
		name = "agi_for_kill",
		per_kill = { 0.6, 1.2, 2.4, 4.8 },
		stack_limit = 40,
	},
	{
		name = "int_for_kill",
		per_kill = { 1.05, 2.1, 4.2, 8.4 },
		stack_limit = 40,
	},
	{
		name = "cleave",
		range_pct = { 10, 20, 40, 80 },
		melee_pct = { 15, 30, 60, 120 },
		range_pct_creep = { 7, 14, 28, 56 },
		melee_pct_creep = { 10, 20, 40, 80 },
		radius = 300,
	},
	{
		name = "manaburn",
		flat = { 2, 4, 8, 16 },
		level_step = 1,
		per_level = { 1, 2, 4, 8 },
		illusion_multiplier = 0.25,
		illusion_reduce_effect_tooltip = 75,
	},
	{
		name = "mp_regen",
		flat = { 0.4, 0.8, 1.6, 3.2 },
		level_step = 1,
		per_level = { 0.2, 0.4, 0.8, 1.6 },
	},
	{
		name = "hp_regen",
		flat = { 0.8, 1.6, 3.2, 6.4 },
		level_step = 1,
		per_level = { 0.4, 0.8, 1.6, 3.2 },
	},
	{
		name = "bonus_movespeed",
		bonus_ms = { 20, 40, 80, 160 },
	},
	{
		name = "bonus_agi",
		flat = 0,
		level_step = 1,
		per_level = { 0.4, 0.8, 1.6, 3.2 },
	},
	{
		name = "bonus_str",
		flat = 0,
		level_step = 1,
		per_level = { 0.5, 1, 2, 4 },
	},
	{
		name = "bonus_int",
		flat = 0,
		level_step = 1,
		per_level = { 0.7, 1.4, 2.8, 5.6 },
	},
	{
		name = "bonus_all_stats",
		flat = 0,
		level_step = 1,
		per_level = { 0.25, 0.5, 1, 2 },
	},
	{
		name = "attack_range",
		range_bonus = { 50, 100, 200, 400 },
		melee_bonus = { 40, 80, 160, 320 },
	},
	{
		name = "bonus_hp_pct",
		bonus_hp = { 7.5, 15, 30, 60 },
		interval = 0.3, -- Re-calculate each X seconds, because default pct hp modifier broken with "unit cannot heals"
	},
	{
		name = "cast_range",
		bonus_cast_range = { 35, 70, 140, 280 },
	},
	{
		name = "cooldown_reduction",
		cdr = { 5, 10, 17, 30 },
	},
	{
		name = "damage",
		flat = { 1.8, 3.5, 7, 14 },
		level_step = 1,
		per_level = { 0.9, 1.8, 3.5, 7 },
	},
	{
		name = "evasion",
		flat = { 9, 16, 26, 35 },
		level_step = 1,
		per_level = { 0.45, 0.8, 1.3, 1.75 },
	},
	{
		name = "lifesteal",
		lifesteal_pct = { 9, 18, 36, 72 },
	},
	{
		name = "mag_resist",
		resist = { 10, 18, 31, 47 },
	},
	{
		name = "spell_amp",
		spell_amp = { 4, 8, 16, 32 },
	},
	{
		name = "spell_lifesteal",
		lifesteal = { 6, 12, 24, 48 },
		lifesteal_creep = { 1.2, 2.4, 4.8, 9.6 },
	},
	{
		name = "status_resistance",
		status_res = { 16, 28, 43, 60 },
	},
	{
		name = "outcomming_heal_amplify",
		heal_amp = { 6, 12, 24, 48 },
	},
	{
		name = "debuff_time",
		debuff_amp = { 9, 18, 36, 72 },
	},
	{
		name = "bonus_gold",
		time_for_full_gold = 300,
		minutes_tooltip = 5,
		interval = CUSTOM_GPM_INTERVAL * 24,
		gold = { 400, 800, 1600, 3200 },
	},
}

BONUS_GOLD_PLAYERS = {}
GAME_PERKS_BY_NAME = {}

for _, perk_data in pairs(GAME_PERKS) do
	GAME_PERKS_BY_NAME[perk_data.name] = perk_data
end

PERKS_FORBIDDEN_BY_HERO = {
	npc_dota_hero_ogre_magi = {
		int_for_kill = true,
		bonus_int = true,
	},
	npc_dota_hero_huskar = {
		mp_regen = true,
		mp_per_kill = true,
		magical_constitution = true,
	},
}

PERKS_FORBIDDEN_FOR_FAMILY = {
	summon_power = {
		npc_dota_hero_morphling = true,
		npc_dota_hero_rubick = true,
	},
}

PERKS_FORCE_ALLOWED = {
	summon_power = {
		npc_dota_hero_brewmaster = true,
		npc_dota_hero_lycan = true,
		npc_dota_hero_furion = true,
		npc_dota_hero_witch_doctor = true,
		npc_dota_hero_shadow_shaman = true,
		npc_dota_hero_broodmother = true,
		npc_dota_hero_beastmaster = true,
		npc_dota_hero_undying = true,
		npc_dota_hero_enigma = true,
		npc_dota_hero_venomancer = true,
		npc_dota_hero_visage = true,
		npc_dota_hero_skeleton_king = true,
		npc_dota_hero_enchantress = true,
		npc_dota_hero_chen = true,
		npc_dota_hero_invoker = true,
		npc_dota_hero_lich = true,
		npc_dota_hero_zuus = true,
		npc_dota_hero_warlock = true,
		npc_dota_hero_morphling = true,
		npc_dota_hero_rubick = true,
	},
}

PERKS_BLOCK_LIST_FOR_NON_HEROES = {
	bonus_gold = true,
	mp_per_kill = true,
	hp_per_kill = true,
	magical_damage = true,
}

PERKS_BLOCK_LIST_FOR_ILLUSIONS = {
	delayed_damage = true,
}