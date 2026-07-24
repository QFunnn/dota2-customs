--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Необходимо исправить список умений, связанных со способом атаки
HeroBuilder.attackCapabilityModifiers = {}
HeroBuilder.attackCapabilityModifiers["modifier_troll_warlord_berserkers_rage"] = true
HeroBuilder.attackCapabilityModifiers["modifier_lone_druid_true_form"] = true
HeroBuilder.attackCapabilityModifiers["modifier_terrorblade_metamorphosis"] = true
HeroBuilder.attackCapabilityModifiers["modifier_dragon_knight_dragon_form"] = true
HeroBuilder.attackCapabilityModifiers["modifier_dragon_knight_elder_dragon_form_lua_form"] = true

-- Взаимоисключающие умения, гарантирующие, что игрок не сможет выбрать их оба одновременно
abilityExclusion = {}

abilityExclusion["lone_druid_true_form"] = {"lone_druid_spirit_bear"} --todo подумать
abilityExclusion["lone_druid_spirit_bear"] = {"lone_druid_true_form"}
abilityExclusion["oracle_false_promise"] = {"abaddon_borrowed_time"}

-- Взаимоисключающие способности, связанные с моделью (персонажа).
heroExclusion = {}
heroExclusion["npc_dota_hero_silencer"] = {"monkey_king_wukongs_command"} --todo подумать
heroExclusion["npc_dota_hero_razor"] = {"monkey_king_wukongs_command"}
heroExclusion["npc_dota_hero_meepo"] = {"arc_warden_tempest_double_lua"}
heroExclusion["npc_dota_hero_sand_king"] = {"sandking_caustic_finale_lua"}
heroExclusion["npc_dota_hero_naga_siren"] = {"naga_siren_rip_tide"}
heroExclusion["npc_dota_hero_shadow_shaman"] = {"brewmaster_primal_split"}
heroExclusion["npc_dota_hero_alchemist"] = {"ogre_magi_multicast_lua"}

-- Аганимные способности привязанные к герою
scepterAbilities = {}
scepterAbilities["npc_dota_hero_rattletrap"] = {"rattletrap_overclocking"}
scepterAbilities["npc_dota_hero_earth_spirit"] = {"earth_spirit_petrify"}
scepterAbilities["npc_dota_hero_snapfire"] = {"snapfire_gobble_up", "snapfire_spit_creep"}
scepterAbilities["npc_dota_hero_nyx_assassin"] = {"nyx_assassin_burrow", "nyx_assassin_unburrow"}
scepterAbilities["npc_dota_hero_tusk"] = {"tusk_walrus_kick"}
scepterAbilities["npc_dota_hero_grimstroke"] = {"grimstroke_dark_portrait"}
scepterAbilities["npc_dota_hero_tiny"] = {"tiny_tree_channel"}
scepterAbilities["npc_dota_hero_keeper_of_the_light"] = {"keeper_of_the_light_will_o_wisp"}
scepterAbilities["npc_dota_hero_leshrac"] = {"leshrac_greater_lightning_storm"}
scepterAbilities["npc_dota_hero_visage"] = {"visage_silent_as_the_grave"}
scepterAbilities["npc_dota_hero_broodmother"] = {"broodmother_sticky_snare"}
scepterAbilities["npc_dota_hero_lina"] = {"lina_flame_cloak"}
scepterAbilities["npc_dota_hero_brewmaster"] = {"brewmaster_primal_companion"}
scepterAbilities["npc_dota_hero_dark_seer"] = {"dark_seer_normal_punch"}
scepterAbilities["npc_dota_hero_magnataur"] = {"magnataur_horn_toss"}
scepterAbilities["npc_dota_hero_enchantress"] = {"enchantress_little_friends"}
scepterAbilities["npc_dota_hero_spirit_breaker"] = {"spirit_breaker_planar_pocket"}
scepterAbilities["npc_dota_hero_phantom_assassin"] = {"phantom_assassin_fan_of_knives"}
scepterAbilities["npc_dota_hero_gyrocopter"] = {"gyrocopter_side_gunner_spawn_ability"}

-- Доп. способности привязанные к скипетру аганима
scepterLinkAbilities = {}
-- scepterLinkAbilities["kunkka_torrent"] = {"kunkka_torrent_storm"}
scepterLinkAbilities["templar_assassin_psionic_trap"] = {"templar_assassin_trap_teleport"}
scepterLinkAbilities["zuus_lightning_bolt"] = {"zuus_cloud"}
scepterLinkAbilities["lycan_shapeshift"] = {"lycan_wolf_bite"}
scepterLinkAbilities["viper_corrosive_skin"] = {"viper_nose_dive"}
scepterLinkAbilities["bloodseeker_thirst_lua"] = {"bloodseeker_blood_mist_lua"}
-- scepterLinkAbilities["clinkz_death_pact"] = {"clinkz_burning_army"}
scepterLinkAbilities["beastmaster_primal_roar"] = {"beastmaster_drums_of_slom"}
scepterLinkAbilities["juggernaut_omni_slash"] = {"juggernaut_swift_slash"}
scepterLinkAbilities["spectre_haunt_single"] = {"spectre_haunt"}
scepterLinkAbilities["spectre_suffering_specter"] = {"spectre_haunted_night"}
scepterLinkAbilities["centaur_stampede"] = {"centaur_work_horse", "centaur_mount"}
scepterLinkAbilities["terrorblade_metamorphosis"] = {"terrorblade_terror_wave"}
scepterLinkAbilities["ogre_magi_fireblast"] = {"ogre_magi_unrefined_fireblast"}
scepterLinkAbilities["clinkz_wind_walk"] = { "clinkz_burning_army" }
scepterLinkAbilities["hoodwink_sharpshooter"]= {"hoodwink_decoy"}

-- Доп. способности привязанные к шарду
shardLinkAbilities = {}
shardLinkAbilities["shadow_demon_demonic_purge"] = {"shadow_demon_demonic_cleanse"}
shardLinkAbilities["medusa_mystic_snake"] = {"medusa_cold_blooded"}
shardLinkAbilities["necrolyte_death_pulse"] = {"necrolyte_death_seeker"}
shardLinkAbilities["slark_shadow_dance"] = {"slark_depth_shroud"}
shardLinkAbilities["witch_doctor_death_ward"] = {"witch_doctor_voodoo_switcheroo"}
shardLinkAbilities["dragon_knight_elder_dragon_form"] = {"dragon_knight_fireball"}
-- shardLinkAbilities["clinkz_tar_bomb"] = {"clinkz_burning_barrage"}
shardLinkAbilities["zuus_arc_lightning_lua"] = {"zuus_lightning_hands_lua"}
shardLinkAbilities["drow_ranger_marksmanship"] = {"drow_ranger_glacier"}
shardLinkAbilities["antimage_counterspell"] = {"antimage_counterspell_ally"}
shardLinkAbilities["crystal_maiden_frostbite"] = {"crystal_maiden_crystal_clone"}
shardLinkAbilities["necrolyte_death_pulse"] = {"necrolyte_death_seeker"}
shardLinkAbilities["disruptor_kinetic_field"] = {"disruptor_kinetic_fence"}
shardLinkAbilities["shadow_shaman_mass_serpent_ward"] = {"shadow_shaman_urnaconda"}

-- Доп. способности привязанные к шарду героя
scepterShardAbilities = {}
scepterShardAbilities["npc_dota_hero_alchemist"] = {"alchemist_berserk_potion"}
scepterShardAbilities["npc_dota_hero_bristleback"] = {"bristleback_hairball"}
scepterShardAbilities["npc_dota_hero_rattletrap"] = {"rattletrap_jetpack"}
scepterShardAbilities["npc_dota_hero_kunkka"] = {"kunkka_tidal_wave"}
scepterShardAbilities["npc_dota_hero_lich"] = {"lich_ice_spire"}
scepterShardAbilities["npc_dota_hero_ogre_magi"] = {"ogre_magi_smash"}
scepterShardAbilities["npc_dota_hero_pangolier"] = {"pangolier_rollup"}
scepterShardAbilities["npc_dota_hero_sniper"] = {"sniper_concussive_grenade"}
scepterShardAbilities["npc_dota_hero_shredder"] = {"shredder_flamethrower"}
scepterShardAbilities["npc_dota_hero_tinker"] = {"tinker_warp_grenade"}
scepterShardAbilities["npc_dota_hero_terrorblade"] = {"terrorblade_demon_zeal"}
scepterShardAbilities["npc_dota_hero_windrunner"] = {"windrunner_gale_force"}
scepterShardAbilities["npc_dota_hero_primal_beast"] = {"primal_beast_rock_throw"}
scepterShardAbilities["npc_dota_hero_hoodwink"] = {"hoodwink_hunters_boomerang"}
-- scepterShardAbilities["npc_dota_hero_skywrath_mage"] = {
--     "skywrath_mage_shield_of_the_scion_lua"
-- }
scepterShardAbilities["npc_dota_hero_oracle"] = {"oracle_rain_of_destiny"}
scepterShardAbilities["npc_dota_hero_meepo"] = {"meepo_petrify"}
scepterShardAbilities["npc_dota_hero_tidehunter"] = {
    "tidehunter_dead_in_the_water"
}
scepterShardAbilities["npc_dota_hero_enchantress"] = {"enchantress_bunny_hop"}
scepterShardAbilities["npc_dota_hero_ringmaster"] = {"ringmaster_spotlight"}
scepterShardAbilities["npc_dota_hero_muerta"] = {"muerta_spectral_slug"}
scepterShardAbilities["npc_dota_hero_clinkz"] = {"clinkz_burning_barrage"}