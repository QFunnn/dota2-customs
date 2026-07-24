--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Различные настройки абилок
ABILITIES_SETTINGS = {
    skeleton_king_vampiric_spirit = {
        bIgnoredInnate = true,
    },
    ogre_magi_dumb_luck = {
        bIgnoredInnate = true,
    },
    lich_death_charge = {
        bIgnoredInnate = true,
    },
    medusa_mana_shield = {
        bIgnoredInnate = false,
        Exceptions = {"crystal_maiden_brilliance_aura"},
    },
    templar_assassin_third_eye = {
        bIgnoredInnate = false,
    },
    tiny_rocksteady = {
        bIgnoredInnate = false,
    },
    monkey_king_mischief = {
        bIgnoredInnate = false,
    },
    troll_warlord_switch_stance = {
        bIgnoredInnate = false,
    },
    nevermore_necromastery = {
        bIgnoredInnate = false,
    },
    undying_ceaseless_dirge = {
        bIgnoredInnate = false,
    },
    ringmaster_tame_the_beasts_crack = {
        bIgnoredInnate = false,
    },
    ringmaster_dark_carnival_souvenirs = {
        bIgnoredInnate = false,
    },
    ringmaster_empty_souvenir = {
        bIgnoredInnate = false,
    },
    huskar_blood_magic = {
        bIgnoredInnate = false,
    },
    phantom_lancer_illusory_armaments = {
        bIgnoredInnate = false,
    },
    hoodwink_mistwoods_wayfarer = {
        bIgnoredInnate = false,
    },
    snapfire_buckshot = {
        bIgnoredInnate = false,
    },
    chen_summon_convert = {
        bIgnoredInnate = false,
    },
    kez_switch_weapons = {
        bIgnoredInnate = false,
    },
    enchantress_rabblerouser = {
        bIgnoredInnate = true,
    },
    tiny_tree_grab_lua = {
        Exceptions = {"puck_dream_coil_custom"},
    },
    sven_great_cleave = {
        Exceptions = {"puck_dream_coil_custom"}, 
    },
    puck_dream_coil_custom = {
        Exceptions = {"sven_great_cleave", "tiny_tree_grab_lua"},
        bIsDisabledOnHub = true,
    },
    crystal_maiden_brilliance_aura = {
        Exceptions = {"medusa_mana_shield"},
    },
    medusa_split_shot = {
        Exceptions = {"obsidian_destroyer_arcane_orb", "spirit_breaker_greater_bash"},
    },
    spirit_breaker_greater_bash = {
        Exceptions = {"medusa_split_shot"},
    },
    obsidian_destroyer_arcane_orb = {
        Exceptions = {"medusa_split_shot", "frostivus2018_weaver_geminate_attack_custom"},
    },
    frostivus2018_weaver_geminate_attack_custom = {
        Exceptions = {"obsidian_destroyer_arcane_orb"},
    },
    morphling_morph_agi = {
        Exceptions = {"undying_flesh_golem_custom"},
    },
    undying_flesh_golem_custom = { 
        Exceptions = {"morphling_morph_agi"},
    },
    monkey_king_wukongs_command = {
        bUnremovable = true,
    },
    ability_marci_special_delivery = {
        bUnremovable = true,
    },
    lone_druid_entangle = {
        bUnremovable = true,
    },
    shredder_chakram_lua = {
        ScepterAbilities = {"shredder_chakram_2_lua","shredder_chakram_lua_2_return"},
    },
    templar_assassin_psionic_trap = {
        ScepterAbilities = {"templar_assassin_trap_teleport"},
    },
    zuus_lightning_bolt_custom = {
        ScepterAbilities = {"zuus_cloud_custom"},
        -- [NP3-5] Nimbus кастует болты с этим инфликтором → пропускаем урон в чужую арену.
        bWorkOnOtherArena = true,
    },
    lycan_shapeshift_custom = {
        ScepterAbilities = {"lycan_wolf_bite"},
    },
    lina_laguna_blade_custom = {
        ScepterAbilities = {"lina_flame_cloak_custom"},
        bIsDisabledOnHub = true,
    },
    juggernaut_omni_slash_custom = {
        ScepterAbilities = {"juggernaut_swift_slash_custom"},
    },
    grimstroke_soul_chain = {
        ScepterAbilities = {"grimstroke_dark_portrait"},
    },
    bloodseeker_thirst = {
        ScepterAbilities = {"bloodseeker_blood_mist_custom"},
    },
    leshrac_pulse_nova = {
        ScepterAbilities = {"leshrac_greater_lightning_storm"},
    },
    nyx_assassin_vendetta = {
        ScepterAbilities = {"nyx_assassin_burrow","nyx_assassin_unburrow"},
    },
    tusk_walrus_punch = {
        ScepterAbilities = {"tusk_walrus_kick"},
    },
    viper_corrosive_skin = {
        ScepterAbilities = {"viper_nose_dive"},
    },
    visage_summon_familiars = {
        ScepterAbilities = {"visage_silent_as_the_grave"},
        bIsSummonAbility = true,
    },
    shadow_demon_demonic_purge = {
        ShardAbilities = {"shadow_demon_demonic_cleanse"},
    },
    medusa_mystic_snake = {
        ShardAbilities = {"medusa_cold_blooded"},
    },
    necrolyte_death_pulse = {
        ShardAbilities = {"necrolyte_death_seeker"},
    },
    slark_shadow_dance_custom = {
        ShardAbilities = {"slark_depth_shroud_custom"},
    },
    witch_doctor_death_ward = {
        ShardAbilities = {"witch_doctor_voodoo_switcheroo"},
        bIsSummonAbility = true,
    },
    tusk_snowball = {
        ShardAbilities = {"tusk_launch_snowball"},
    },
    dragon_knight_elder_dragon_form_custom = {
        ShardAbilities = {"dragon_knight_fireball"},
    },
    alchemist_chemical_rage = {
        ShardAbilities = {"alchemist_berserk_potion"},
    },
    jakiro_liquid_fire_lua = {
        ShardAbilities = {"jakiro_liquid_ice_lua"},
    },
    lich_chain_frost_custom = {
        ShardAbilities = {"lich_ice_spire"},
    },
    shredder_whirling_death = {
        ShardAbilities = {"shredder_flamethrower"},
    },
    tinker_laser = {
        ShardAbilities = {"tinker_warp_grenade"},
    },
    -- venomancer_noxious_plague = {
    --     ShardAbilities = {"venomancer_latent_poison"},
    --     BonusModifiers = {"modifier_noxious_plague_controller"},
    -- },
    magnataur_shockwave = {
        ScepterAbilities = {"magnataur_horn_toss"},
    },
    pangolier_gyroshell = {
        ShardAbilities = {"pangolier_rollup"},
        bIsDisabledOnHub = true,
    },
    sniper_shrapnel = {
        ShardAbilities = {"sniper_concussive_grenade"},
    },
    ogre_magi_ignite_custom = {
        ShardAbilities = {"ogre_magi_smash"},
    },
    zuus_arc_lightning_custom = {
        ShardAbilities = {"zuus_lightning_hands_custom"},
    },
    clinkz_tar_bomb = {
        ShardAbilities = {"clinkz_burning_barrage"},
    },
    kunkka_torrent = {
        ScepterAbilities = {"kunkka_torrent_storm_custom"},
    },  
    beastmaster_call_of_the_wild_boar = {
        bIsSummonAbility = true,
    },
    shadow_shaman_mass_serpent_ward = {
        bIsSummonAbility = true,
    },
    furion_force_of_nature_custom = {
        bIsSummonAbility = true,
    },
    lone_druid_spirit_bear = {
        bIsSummonAbility = true,
        bIgnoredInnate = false,
    },
    venomancer_plague_ward = {
        bIsSummonAbility = true,
    },
    warlock_rain_of_chaos = {
        bIsSummonAbility = true,
        bIsDisabledOnHub = true,
    },
    lycan_summon_wolves = {
        bIsSummonAbility = true,
    },
    broodmother_spawn_spiderlings = {
        bIsSummonAbility = true,
    },
    invoker_forge_spirit_lua = {
        bIsSummonAbility = true,
    },
    enigma_demonic_conversion_custom = {
        bIsSummonAbility = true,
    },
    undying_tombstone_lua = {
        bIsSummonAbility = true,
    },
    muerta_pierce_the_veil = {
        bIsDisabledOnHub = true,
    },
    centaur_return = {
        BonusModifiers = {"modifier_centaur_return_unique_buff"},
    },
    primal_beast_uproar = {
        BonusModifiers = {"modifier_primal_beast_uproar_custom_creep"},
    },
    tiny_grow = {
        BonusModifiers = {"modifier_tiny_grow_custom"},
    },
    skywrath_mage_concussive_shot = {
        BonusModifiers = {"modifier_hero_unique_modifier_skywrath_mage_concussive_shot"},
    },
    skeleton_king_hellfire_blast = {
        BonusModifiers = {"modifier_hero_unique_modifier_skeleton_king_hellfire_blast"},
    },
    templar_assassin_meld = {
        BonusModifiers = {"modifier_hero_unique_modifier_templar_assassin_meld"},
    },
    chaos_knight_chaos_bolt = {
        BonusModifiers = {"modifier_hero_unique_modifier_chaos_knight_chaos_bolt"},
    },
    tinker_defense_matrix = {
        BonusModifiers = {"modifier_hero_unique_modifier_tinker_defense_matrix"},
    },
    abaddon_aphotic_shield = {
        BonusModifiers = {"modifier_hero_unique_modifier_abaddon_aphotic_shield"},
    },
    riki_backstab_custom = {
        BonusModifiers = {"modifier_hero_unique_modifier_riki_backstab_custom"},
    },
    phantom_assassin_phantom_strike = {
        BonusModifiers = {"modifier_hero_unique_modifier_phantom_assassin_phantom_strike"},
    },
    clinkz_strafe = {
        BonusModifiers = {"modifier_hero_unique_modifier_clinkz_strafe"},
    },
    spectre_spectral_dagger = {
        BonusModifiers = {"modifier_hero_unique_modifier_spectre_spectral_dagger"},
    },
    slark_dark_pact = {
        BonusModifiers = {"modifier_hero_unique_modifier_slark_dark_pact"},
    },
    enchantress_natures_attendants = {
        BonusModifiers = {"modifier_hero_unique_modifier_enchantress_natures_attendants"},
    },
    weaver_shukuchi = {
        BonusModifiers = {"modifier_hero_unique_modifier_weaver_shukuchi"},
    },
    troll_warlord_berserkers_rage = {
        BonusModifiers = {"modifier_hero_unique_modifier_troll_warlord_berserkers_rage"},
    },
    nevermore_dark_lord = {
        BonusModifiers = {"modifier_hero_unique_modifier_nevermore_dark_lord"},
    },
    dazzle_poison_touch = {
        BonusModifiers = {"modifier_hero_unique_modifier_dazzle_poison_touch"},
    },
    queenofpain_scream_of_pain = {
        BonusModifiers = {"modifier_hero_unique_modifier_queenofpain_scream_of_pain"},
    },
    earthshaker_enchant_totem = {
        BonusModifiers = {"modifier_hero_unique_modifier_earthshaker_enchant_totem"},
    },
    spirit_breaker_bulldoze = {
        BonusModifiers = {"modifier_hero_unique_modifier_spirit_breaker_bulldoze"},
    },
    ursa_overpower = {
        BonusModifiers = {"modifier_hero_unique_modifier_ursa_overpower"},
    },
    mars_gods_rebuke = {
        BonusModifiers = {"modifier_hero_unique_modifier_mars_gods_rebuke"},
    },
    dragon_knight_breathe_fire = {
        BonusModifiers = {"modifier_hero_unique_modifier_dragon_knight_breathe_fire"},
    },
    elder_titan_natural_order = {
        BonusModifiers = {"modifier_hero_unique_modifier_elder_titan_natural_order"},
    },
    alchemist_corrosive_weaponry = {
        BonusModifiers = {"modifier_hero_unique_modifier_alchemist_corrosive_weaponry"},
    },
    enchantress_impetus = {
        BonusModifiers = {"modifier_hero_unique_modifier_enchantress_impetus"},
    },
    antimage_blink = {
        BonusModifiers = {"modifier_hero_unique_modifier_antimage_blink"},
    },
    shredder_reactive_armor = {
        BonusModifiers = {"modifier_hero_unique_modifier_shredder_reactive_armor"},
    },
    abaddon_death_coil = {
        BonusModifiers = {"modifier_hero_unique_modifier_abaddon_death_coil"},
    },
    nyx_assassin_burrow = {
        BonusModifiers = {"modifier_hero_unique_modifier_nyx_assassin_burrow"},
    },
    wisp_overcharge_custom = {
        bIsPercentAbility = true,
    },
    broodmother_insatiable_hunger_custom = {
        bIsPercentAbility = true,
    },
    life_stealer_feast_custom = {
        bIsPercentAbility = true,
    },
    bloodseeker_bloodrage_custom = {
        bIsPercentAbility = true,
    },
    meepo_ransack_custom = {
        bIsPercentAbility = true,
    },
    legion_commander_press_the_attack_custom = {
        bIsBlackKingBarAbility = true,
    },
    juggernaut_blade_fury = {
        bIsBlackKingBarAbility = true,
    },
    chen_hand_of_god_custom = {
        bIsBlackKingBarAbility = true,
    },
    life_stealer_rage = {
        bIsBlackKingBarAbility = true,
    },
    mars_spear = {
        bIsDisabledOnHub = true,
    },
    furion_teleportation = {
        bIsDisabledOnHub = true,
    },
    elder_titan_ancestral_spirit = {
        bIsDisabledOnHub = true,
    },
    lion_impale = {
        bIsDisabledOnHub = true,
    },
    earth_spirit_rolling_boulder = {
        bIsDisabledOnHub = true,
    },
    rubick_spell_steal_custom = {
        bIsDisabledOnHub = true,
    },
    windrunner_powershot = {
        bIsDisabledOnHub = true,
    },
    life_stealer_infest = {
        bIsDisabledOnHub = true,
    },
    lion_finger_of_death_custom = {
        bIsDisabledOnHub = true,
    },
    bounty_hunter_track = {
        bIsDisabledOnHub = true,
    },
    ursa_earthshock = {
        bIsDisabledOnHub = true,
    },
    ursa_enrage = {
        bIsDisabledOnHub = true,
    },
    doom_bringer_doom = {
        bIsDisabledOnHub = true,
    },
    chen_holy_persuasion_custom = {
        bIsDisabledOnHub = true,
    },
    abyssal_underlord_firestorm_custom = {
        bIsDisabledOnHub = true,
    },
    pudge_meat_hook = {
        bIsDisabledOnHub = true,
    },
    monkey_king_tree_dance = {
        bIsDisabledOnHub = true,
    },
    oracle_false_promise_custom = {
        bIsDisabledOnHub = true,
        Exceptions = {"npc_dota_hero_undying"},
    },
    enigma_midnight_pulse_custom = {
        bIsDisabledOnHub = true,
    },
    wisp_relocate = {
        bIsDisabledOnHub = true,
    },
    ability_phoenix_supernova = {
        bIsDisabledOnHub = true,
    },
    shredder_timber_chain = {
        bIsDisabledOnHub = true,
    },
    ancient_apparition_ice_blast = {
        bIsDisabledOnHub = true,
        bWorkOnOtherArena = true,
        bCanCastOnOtherArena = true,
    },
    brewmaster_primal_split = {
        bIsDisabledOnHub = true,
    },
    axe_berserkers_call = {
        bIsDisabledOnHub = true,
    },
    rattletrap_hookshot = {
        bIsDisabledOnHub = true,
    },
    magnataur_reverse_polarity = {
        bIsDisabledOnHub = true,
    },
    treant_overgrowth = {
        bIsDisabledOnHub = true,
    },
    faceless_void_chronosphere = {
        bIsDisabledOnHub = true,
    },
    medusa_stone_gaze = {
        bIsDisabledOnHub = true,
    },
    venomancer_poison_nova_custom = {
        bIsDisabledOnHub = true,
    },
    enigma_black_hole = {
        bIsDisabledOnHub = true,
    },
    queenofpain_sonic_wave = {
        bIsDisabledOnHub = true,
    },
    ability_elder_titan_earth_splitter = {
        bIsDisabledOnHub = true,
    },
    dawnbreaker_fire_wreath = {
        bIsDisabledOnHub = true,
    },
    bristleback_quill_spray = {
        bIsDisabledOnHub = true,
    },
    earth_spirit_magnetize = {
        bIsDisabledOnHub = true,
    },
    magnataur_reverse_reverse_polarity = {
        bIsDisabledOnHub = true,
    },
    zuus_cloud_custom = {
        bIsDisabledOnHub = true,
        -- Nimbus — можно ПОСТАВИТЬ облако на чужую арену (каст). Урон самих болтов облака
        -- идёт с инфликтором zuus_lightning_bolt_custom (у него стоит bWorkOnOtherArena).
        bCanCastOnOtherArena = true,
    },
    furion_wrath_of_nature = {
        bIsDisabledOnHub = true,
        bWorkOnOtherArena = true,
        bCanCastOnOtherArena = true,
    },
    zuus_thundergods_vengeance_custom = {
        bIsDisabledOnHub = true,
    },
    zuus_thundergods_wrath = {
        bIsDisabledOnHub = true,
        bWorkOnOtherArena = true,
    },
    omniknight_guardian_angel = {
        bIsDisabledOnHub = true,
    },
    broodmother_spin_web = {
        bIsDisabledOnHub = true,
    },
    custom_legion_commander_duel = {
        bIsDisabledOnHub = true,
    },
    silencer_global_silence = {
        bWorkOnOtherArena = true,
    },
    -- [NP3-4] Рефлекты должны доходить до кастера в ДРУГОЙ арене: у отражённого урона
    -- инфликтор — сам item_blade_mail / способность рефлекта, и межаренный гейт его резал.
    item_blade_mail = {
        bWorkOnOtherArena = true,
    },
    spectre_dispersion_custom = {
        bWorkOnOtherArena = true,
    },
    shadow_demon_disseminate_custom = {
        bWorkOnOtherArena = true,
    },
    -- Глобальные способности — наносят урон сквозь арены.
    invoker_sun_strike_lua = {
        bIsDisabledOnHub = true,
        bWorkOnOtherArena = true,
        bCanCastOnOtherArena = true,
    },
    rattletrap_rocket_flare = {
        bIsDisabledOnHub = true,
        bWorkOnOtherArena = true,
        bCanCastOnOtherArena = true,
    }
}

HIDDEN_TABLE = {
    --DAWNBREAKER CELESTIAL HAMMER
    dawnbreaker_celestial_hammer = {
        linked = "dawnbreaker_converge",
        modifier = "modifier_dawnbreaker_celestial_hammer_caster"
    },
    dawnbreaker_converge = {
        linked = "dawnbreaker_celestial_hammer"
    },

    --PHOENIX ICARUS DIVE
    phoenix_icarus_dive = {
        linked = "phoenix_icarus_dive_stop",
        modifier = "modifier_phoenix_icarus_dive"
    },
    phoenix_icarus_dive_stop = {
       linked =  "phoenix_icarus_dive"
    },

    --PHOENIX SUN RAY
    phoenix_sun_ray = {
        linked = "phoenix_sun_ray_stop",
        modifier = "modifier_phoenix_sun_ray"
    },
    phoenix_sun_ray_stop = {
       linked =  "phoenix_sun_ray"
    },

    --PHOENIX FIRE SPIRITS
    phoenix_fire_spirits = {
        linked = "phoenix_launch_fire_spirit",
        modifier = "modifier_phoenix_fire_spirit_count"
    },
    phoenix_launch_fire_spirit = {
       linked =  "phoenix_fire_spirits"
    },

    --PRIMAL BEAST ONSLAUGHT
    primal_beast_onslaught = {
        linked = "primal_beast_onslaught_release",
        modifier = "modifier_primal_beast_onslaught_windup"
    },
    primal_beast_onslaught_release = {
       linked =  "primal_beast_onslaught"
    },

    --TUSK SNOWBALL
    tusk_snowball = {
        linked = "tusk_launch_snowball",
        modifier = "modifier_tusk_snowball_movement"
    },
    tusk_launch_snowball = {
       linked =  "tusk_snowball"
    },

    --KEZ SHODO SAI
    kez_shodo_sai = {
        linked = "kez_shodo_sai_parry_cancel",
        modifier = "modifier_kez_shodo_sai_parry"
    },
    kez_shodo_sai_parry_cancel = {
       linked =  "kez_shodo_sai"
    },

    --ANCIENT APPARITION ICE BLAST
    ancient_apparition_ice_blast = {
        linked = "ancient_apparition_ice_blast_release",
    },
    ancient_apparition_ice_blast_release = {
       linked =  "ancient_apparition_ice_blast"
    },

    --BANE SHODO NIGHTMARE
    bane_nightmare = {
        linked = "bane_nightmare_end",
        modifier = "modifier_bane_nightmare",
        parent = true
    },
    bane_nightmare_end = {
       linked =  "bane_nightmare"
    },

    --NYX ASSASSIN BURROW
    nyx_assassin_burrow = {
        linked = "nyx_assassin_unburrow",
        modifier = "modifier_nyx_assassin_burrow"
    },
    nyx_assassin_unburrow = {
       linked =  "nyx_assassin_burrow"
    },

    --PANGOLIER ROLLING THUNDER
    pangolier_gyroshell = {
        linked = "pangolier_gyroshell_stop",
        modifier = "modifier_pangolier_gyroshell"
    },
    pangolier_gyroshell_stop = {
       linked =  "pangolier_gyroshell"
    },

    --HOODWINK SHARPSHOOTER
    hoodwink_sharpshooter = {
        linked = "hoodwink_sharpshooter_release",
        modifier = "modifier_hoodwink_sharpshooter_windup"
    },
    hoodwink_sharpshooter_release = {
       linked =  "hoodwink_sharpshooter"
    },

    --TECHIES REACTIVE TAZER
    techies_reactive_tazer = {
        linked = "techies_reactive_tazer_stop",
        modifier = "modifier_techies_reactive_tazer",
        parent = true
    },
    techies_reactive_tazer_stop = {
       linked =  "techies_reactive_tazer"
    },
}

DUEL_DEACTIVATE_LIST = {
    "ability_phoenix_supernova",
    "weaver_time_lapse",
    "oracle_false_promise_custom",
    "dazzle_shallow_grave",
    "troll_warlord_battle_trance",
    "brewmaster_primal_split",
    "ability_undying_reincarnate"
}

DUEL_COOLDOWN_LIST = {
    "skeleton_king_reincarnation"
}

EXTRA_CREATURES_LIST = {
    item_extra_creature_roshling_big = "npc_dota_roshling_big",
    item_extra_creature_big_thunder_lizard = "npc_dota_big_thunder_lizard",
    item_extra_creature_centaur_khan = "npc_dota_centaur_khan",
    item_extra_creature_dark_troll_warlord = "npc_dota_dark_troll_summoner",
    item_extra_creature_elf_wolf = "npc_dota_elf_wolf",
    item_extra_creature_explode_spider = "npc_dota_explode_spider",
    item_extra_creature_ghost = "npc_dota_ghost",
    item_extra_creature_gnoll_assassin = "npc_dota_gnoll_assassin",
    item_extra_creature_granite_golem = "npc_dota_granite_golem",
    item_extra_creature_kobold = "npc_dota_kobold",
    item_extra_creature_ogreseal = "npc_dota_ogreseal_big",
    item_extra_creature_prowler_shaman = "npc_dota_prowler_shaman",
    item_extra_creature_rock_golem = "npc_dota_rock_golem",
    item_extra_creature_satyr_trickster = "npc_dota_satyr_trickster",
    item_extra_creature_siltbreaker = "npc_dota_siltbreaker_red",
    item_extra_creature_spider_range = "npc_dota_spider_range",
    item_extra_creature_timber_spider = "npc_dota_timber_spider",
    item_extra_creature_warpine = "npc_dota_warpine_cone_custom",
}