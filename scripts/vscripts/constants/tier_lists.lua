--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Шансы на бан групп
RANDOM_BANS_CHANCES = {
    SSS = 25,
    A = 0,
    FAVORITES = 25,
}

-- Единственный источник правды по тирам.
-- Структура: SPEICAL_TIERS_TABLE[Category][Tier][SubGroup] = { ability_or_hero_name, ... }
--   Category : "ABILITIES" | "HEROES"
--   Tier     : "SSS" | "A" | ...
--   SubGroup : человекочитаемая подгруппа (FORMS / OP / MAGICAL / ...)
-- Используется напрямую в:
--   * addon_game_mode.lua — отправляется клиенту как bans_categories для меню банов
--   * states.lua          — формирует unbanned_sss_abilities по подгруппам
--   * key_values.lua      — GetSSSHeroCategory(HeroName) ищет подгруппу героя
-- Плоский RANDOM_BANS_GROUPS ниже собирается из этой таблицы автоматически.
SPEICAL_TIERS_TABLE  = {
    ABILITIES = {
        SSS = {
            FORMS = {
                "dragon_knight_elder_dragon_form_custom",
                "keeper_of_the_light_spirit_form_custom",
                "lina_laguna_blade_custom",
                "lycan_shapeshift_custom",
                "sven_gods_strength_custom",
                "undying_flesh_golem_custom",
                "winter_wyvern_arctic_burn",
            },
            SPLASHES = {
                "kunkka_tidebringer_custom",
                "sven_great_cleave",
                "tiny_tree_grab_lua",
            },
            OP = {
                "doom_bringer_doom",
                "faceless_void_chronosphere",
                "ogre_magi_multicast_lua",
                "shadow_demon_disseminate_custom",
                "tinker_rearm_datadriven",
                "witch_doctor_death_ward",
                "witch_doctor_maledict_custom",
                "elder_titan_natural_order",
                "warlock_fatal_bonds_lua",
                "magnataur_reverse_polarity",
                "magnataur_reverse_reverse_polarity",
                "disruptor_static_storm_custom",
            },
            BKB = {
                "chen_hand_of_god_custom",
                "juggernaut_blade_fury",
                "legion_commander_press_the_attack_custom",
                "life_stealer_rage",
            },
            BASHES = {
                "faceless_void_time_lock_custom",
                "slardar_bash",
                "spirit_breaker_greater_bash",
            },
            PERCENT = {
                "bloodseeker_bloodrage_custom",
                "bloodseeker_thirst",
                "broodmother_insatiable_hunger_custom",
                "enigma_black_hole",
                "life_stealer_feast_custom",
                "meepo_ransack_custom",
                "enigma_midnight_pulse_custom",
                "terrorblade_reflection_lua",
                "venomancer_poison_nova_custom",
                "wisp_overcharge_custom",
                "zuus_heavenly_jump_custom",
                "zuus_static_field_custom",
                "zuus_lightning_bolt_custom",
                "necrolyte_heartstopper_aura_lua",
                "zuus_arc_lightning_custom",
                "zuus_thundergods_vengeance_custom",
            },
            SAVES = {
                "abaddon_borrowed_time_custom",
                "dark_willow_shadow_realm",
                "dazzle_shallow_grave",
                "muerta_pierce_the_veil",
                "obsidian_destroyer_astral_imprisonment",
                "oracle_false_promise_custom",
                "phantom_assassin_blur_custom",
                "puck_phase_shift_custom",
                "slark_shadow_dance_custom",
                "troll_warlord_battle_trance",
                "tusk_snowball",
                "ursa_enrage",
                "visage_gravekeepers_cloak_lua",
            },
            USEFUL = {
                "huskar_inner_fire_custom",
                "invoker_deafening_blast_lua",
                "spectre_dispersion_custom",
                "obsidian_destroyer_arcane_orb",
                "silencer_glaives_of_wisdom",
                "pangolier_heartpiercer_custom",
                "rubick_spell_steal",
                "drow_ranger_marksmanship_custom",
            },
        },
    },
    HEROES = {
        SSS = {
            DEFAULT = {
            },
            MAGICAL = {
                "npc_dota_hero_witch_doctor",
                "npc_dota_hero_death_prophet",
                "npc_dota_hero_oracle",
                "npc_dota_hero_zuus",
                "npc_dota_hero_beastmaster",
                "npc_dota_hero_chen",
                "npc_dota_hero_doom_bringer",
                "npc_dota_hero_enigma",
                "npc_dota_hero_grimstroke",
                "npc_dota_hero_leshrac",
                "npc_dota_hero_marci",
                "npc_dota_hero_lina",
                "npc_dota_hero_ogre_magi",
                "npc_dota_hero_obsidian_destroyer",
                "npc_dota_hero_nyx_assassin",
            },
            PHYSICAL = {
                "npc_dota_hero_wisp",
                "npc_dota_hero_drow_ranger",
                "npc_dota_hero_broodmother",
                "npc_dota_hero_life_stealer",
                "npc_dota_hero_meepo",
                "npc_dota_hero_naga_siren",
                "npc_dota_hero_troll_warlord",
            },
            UNIVERSAL = {
                "npc_dota_hero_bloodseeker",
                "npc_dota_hero_rattletrap",
                "npc_dota_hero_tusk",
                "npc_dota_hero_lycan",
                "npc_dota_hero_phantom_assassin",
                "npc_dota_hero_terrorblade",
                "npc_dota_hero_venomancer",
                "npc_dota_hero_abaddon",
                "npc_dota_hero_bounty_hunter",
                "npc_dota_hero_dark_willow",
                "npc_dota_hero_elder_titan",
                "npc_dota_hero_muerta",
                "npc_dota_hero_spectre",
            },
        },
    },
}

-- Автогенерация плоских списков для рандом-банов.
-- Никогда не редактируйте RANDOM_BANS_GROUPS вручную — правьте SPEICAL_TIERS_TABLE выше.
-- Дубликаты внутри подгрупп схлопываются (любая способность/герой попадёт в плоский
-- список один раз, чтобы вероятность рандом-бана не зависела от случайных повторов в KV).
RANDOM_BANS_GROUPS = {}

for Category, TiersByName in pairs(SPEICAL_TIERS_TABLE) do          -- ABILITIES / HEROES
    RANDOM_BANS_GROUPS[Category] = {}
    for Tier, SubGroups in pairs(TiersByName) do                    -- SSS / A / ...
        local Flat, Seen = {}, {}
        for _, List in pairs(SubGroups) do                          -- FORMS / OP / MAGICAL / ...
            for _, Name in ipairs(List) do
                if not Seen[Name] then
                    Seen[Name] = true
                    table.insert(Flat, Name)
                end
            end
        end
        RANDOM_BANS_GROUPS[Category][Tier] = Flat
    end
end