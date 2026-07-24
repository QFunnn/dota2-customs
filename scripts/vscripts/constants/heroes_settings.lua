--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Различные настройки героев
HEROES_SETTINGS = {
    npc_dota_hero_silencer = {
        Exceptions = {"monkey_king_wukongs_command"},
    },
    npc_dota_hero_razor = {
        Exceptions = {"monkey_king_wukongs_command"},
    },
    npc_dota_hero_meepo = {
        Exceptions = {"arc_warden_tempest_double_lua"},
        ShardAbilities = {"meepo_petrify"},
    },
    npc_dota_hero_rattletrap = {
        Exceptions = {"ability_phoenix_supernova"},
        ScepterAbilities = {"rattletrap_overclocking"},
        ShardAbilities = {"rattletrap_jetpack"},
    },
    npc_dota_hero_antimage = {
        ScepterAbilities = {"antimage_mana_overload"},
        ShardAbilities = {"antimage_counterspell_ally"},
    },
    npc_dota_hero_enchantress = {
        ScepterAbilities = {"enchantress_little_friends"},
        ShardAbilities = {"enchantress_bunny_hop"},
    },
    npc_dota_hero_treant = {
        ScepterAbilities = {"treant_eyes_in_the_forest"},
    },
    npc_dota_hero_ogre_magi = {
        ScepterAbilities = {"ogre_magi_unrefined_fireblast"},
        ShardAbilities = {"ogre_magi_smash"},
    },
    npc_dota_hero_earth_spirit = {
        ScepterAbilities = {"earth_spirit_petrify"},
    },
    npc_dota_hero_juggernaut = {
        ScepterAbilities = {"juggernaut_swift_slash_custom"},
    },
    npc_dota_hero_snapfire = {
        ScepterAbilities = {"snapfire_gobble_up_custom","snapfire_spit_creep"},
    },
    npc_dota_hero_nyx_assassin = {
        ScepterAbilities = {"nyx_assassin_burrow","nyx_assassin_unburrow"},
    },
    npc_dota_hero_shredder = {
        ScepterAbilities = {"shredder_chakram_2_lua","shredder_chakram_lua_2_return"},
        ShardAbilities = {"shredder_flamethrower"},
    },
    npc_dota_hero_tusk = {
        ScepterAbilities = {"tusk_walrus_kick"},
    },
    npc_dota_hero_grimstroke = {
        ScepterAbilities = {"grimstroke_dark_portrait"},
    },
    npc_dota_hero_zuus = {
        ScepterAbilities = {"zuus_cloud_custom"},
    },
    npc_dota_hero_clinkz = {
        ScepterAbilities = {"clinkz_burning_army"},
        ShardAbilities = {"clinkz_burning_barrage"},
    },
    npc_dota_hero_keeper_of_the_light = {
        ScepterAbilities = {"keeper_of_the_light_will_o_wisp"},
    },
    npc_dota_hero_leshrac = {
        ScepterAbilities = {"leshrac_greater_lightning_storm"},
    },
    npc_dota_hero_terrorblade = {
        ScepterAbilities = {"terrorblade_terror_wave"},
        ShardAbilities = {"terrorblade_demon_zeal"},
    },
    npc_dota_hero_templar_assassin = {
        ScepterAbilities = {"templar_assassin_trap_teleport"},
    },
    npc_dota_hero_visage = {
        ScepterAbilities = {"visage_silent_as_the_grave"},
    },
    npc_dota_hero_lycan = {
        ScepterAbilities = {"lycan_wolf_bite"},
    },
    npc_dota_hero_hoodwink = {
        -- Disabled until rework: hoodwink_decoy is practically Tempest Double without items
        -- ScepterAbilities = {"hoodwink_decoy"},
        ShardAbilities = {"hoodwink_hunters_boomerang"},
    },
    npc_dota_hero_broodmother = {
        ScepterAbilities = {"broodmother_sticky_snare"},
    },
    npc_dota_hero_dark_seer = {
        ScepterAbilities = {"dark_seer_normal_punch"},
    },
    npc_dota_hero_beastmaster = {
        ScepterAbilities = {"beastmaster_drums_of_slom"},
    },
    npc_dota_hero_viper = {
        ScepterAbilities = {"viper_nose_dive"},
    },
    npc_dota_hero_bloodseeker = {
        ScepterAbilities = {"bloodseeker_blood_mist_custom"},
    },
    npc_dota_hero_oracle = {
        ShardAbilities = {"oracle_rain_of_destiny"},
    },
    npc_dota_hero_centaur = {
        ScepterAbilities = {"centaur_work_horse", "centaur_mount"},
    },
    npc_dota_hero_lina = {
        ScepterAbilities = {"lina_flame_cloak_custom"},
    },
    npc_dota_hero_brewmaster = {
        ScepterAbilities = {"brewmaster_primal_companion"},
    },
    npc_dota_hero_crystal_maiden = {
        ShardAbilities = {"crystal_maiden_crystal_clone"},
    },
    npc_dota_hero_drow_ranger = {
        ShardAbilities = {"drow_ranger_glacier"},
    },
    npc_dota_hero_alchemist = {
        ShardAbilities = {"alchemist_berserk_potion"},
    },
    npc_dota_hero_furion = {
        ShardAbilities = {"furion_curse_of_the_forest"},
    },
    npc_dota_hero_bristleback = {
        ShardAbilities = {"bristleback_hairball"},
    },
    npc_dota_hero_venomancer = {
        ShardAbilities = {"venomancer_latent_poison"},
    },
    npc_dota_hero_tidehunter = {
        ShardAbilities = {"tidehunter_dead_in_the_water"},
    },
    npc_dota_hero_jakiro = {
        ShardAbilities = {"jakiro_liquid_ice_lua"},
    },
    npc_dota_hero_kunkka = {
        ShardAbilities = {"kunkka_tidal_wave"},
        ScepterAbilities = {"kunkka_torrent_storm_custom"},
    },
    npc_dota_hero_lich = {
        ShardAbilities = {"lich_ice_spire"},
    },
    npc_dota_hero_life_stealer = {
        ShardAbilities = {"life_stealer_open_wounds"},
    },
    npc_dota_hero_magnataur = {
        ScepterAbilities = {"magnataur_horn_toss"},
    },
    npc_dota_hero_necrolyte = {
        ShardAbilities = {"necrolyte_death_seeker"},
    },
    npc_dota_hero_omniknight = {
        ShardAbilities = {"omniknight_degen_aura_custom"},
    },
    npc_dota_hero_pangolier = {
        ShardAbilities = {"pangolier_rollup"},
    },
    npc_dota_hero_phantom_assassin = {
        ScepterAbilities = {"custom_phantom_assassin_fan_of_knives"},
    },
    npc_dota_hero_riki = {
        ShardAbilities = {"riki_poison_dart"},
    },
    npc_dota_hero_slark = {
        ShardAbilities = {"slark_depth_shroud_custom"},
    },
    npc_dota_hero_sniper = {
        ShardAbilities = {"sniper_concussive_grenade"},
    },
    npc_dota_hero_storm_spirit = {
        ShardAbilities = {"storm_spirit_electric_rave"},
    },
    npc_dota_hero_tinker = {
        ShardAbilities = {"tinker_warp_grenade"},
    },
    npc_dota_hero_tiny = {
        ShardAbilities = {"tiny_craggy_exterior"},
    },
    npc_dota_hero_witch_doctor = {
        ShardAbilities = {"witch_doctor_voodoo_switcheroo"},
    },
    npc_dota_hero_troll_warlord = {
        ShardAbilities = {"troll_warlord_rampage"},
    },
    npc_dota_hero_windrunner = {
        ShardAbilities = {"windrunner_gale_force"},
    },
    npc_dota_hero_primal_beast = {
        ShardAbilities = {"primal_beast_rock_throw"},
    },
    npc_dota_hero_skywrath_mage = {
        ShardAbilities = {"skywrath_mage_shield_of_the_scion"},
    },
    npc_dota_hero_spirit_breaker = {
        -- [NP-33] Planar Pocket выдаётся ШАРДОМ, а не скипетром.
        ShardAbilities = {"spirit_breaker_planar_pocket"},
    },
}