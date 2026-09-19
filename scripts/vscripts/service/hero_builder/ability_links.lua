--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class AbilityLinks
---@field scepterByHero table<string, string[]> аганимные способности, привязанные к герою
---@field scepterLinked table<string, string[]> доп. способности при наличии аганима
---@field shardLinked table<string, string[]> доп. способности при наличии шарда
---@field scepterShardByHero table<string, string[]> способности от шарда/аганима, привязанные к герою

local scepterByHero = {
	["npc_dota_hero_rattletrap"] = { "rattletrap_overclocking" },
	["npc_dota_hero_earth_spirit"] = { "earth_spirit_petrify" },
	["npc_dota_hero_snapfire"] = { "snapfire_gobble_up", "snapfire_spit_creep" },
	["npc_dota_hero_nyx_assassin"] = { "nyx_assassin_burrow", "nyx_assassin_unburrow" },
	["npc_dota_hero_tusk"] = { "tusk_walrus_kick" },
	["npc_dota_hero_grimstroke"] = { "grimstroke_dark_portrait" },
	["npc_dota_hero_tiny"] = { "tiny_tree_channel" },
	["npc_dota_hero_keeper_of_the_light"] = { "keeper_of_the_light_will_o_wisp" },
	["npc_dota_hero_leshrac"] = { "leshrac_greater_lightning_storm" },
	["npc_dota_hero_visage"] = { "visage_silent_as_the_grave" },
	["npc_dota_hero_broodmother"] = { "broodmother_sticky_snare" },
	["npc_dota_hero_lina"] = { "lina_flame_cloak" },
	["npc_dota_hero_brewmaster"] = { "brewmaster_primal_companion" },
	["npc_dota_hero_dark_seer"] = { "dark_seer_normal_punch" },
	["npc_dota_hero_magnataur"] = { "magnataur_horn_toss" },
	["npc_dota_hero_enchantress"] = { "enchantress_little_friends" },
	["npc_dota_hero_spirit_breaker"] = { "spirit_breaker_planar_pocket" },
	["npc_dota_hero_phantom_assassin"] = { "phantom_assassin_fan_of_knives" },
	["npc_dota_hero_gyrocopter"] = { "gyrocopter_side_gunner_spawn_ability" },
}

local scepterLinked = {
	-- ["kunkka_torrent"] = { "kunkka_torrent_storm" },
	["templar_assassin_psionic_trap"] = { "templar_assassin_trap_teleport" },
	["zuus_lightning_bolt"] = { "zuus_cloud" },
	["lycan_shapeshift"] = { "lycan_wolf_bite" },
	["viper_corrosive_skin"] = { "viper_nose_dive" },
	["bloodseeker_thirst_lua"] = { "bloodseeker_blood_mist_lua" },
	-- ["clinkz_death_pact"] = { "clinkz_burning_army" },
	["beastmaster_primal_roar"] = { "beastmaster_drums_of_slom" },
	["juggernaut_omni_slash"] = { "juggernaut_swift_slash" },
	["spectre_haunt_single"] = { "spectre_haunt" },
	["spectre_suffering_specter"] = { "spectre_haunted_night" },
	["centaur_stampede"] = { "centaur_work_horse", "centaur_mount" },
	["terrorblade_metamorphosis"] = { "terrorblade_terror_wave" },
	["ogre_magi_fireblast"] = { "ogre_magi_unrefined_fireblast" },
	["clinkz_wind_walk"] = { "clinkz_burning_army" },
	["hoodwink_sharpshooter"] = { "hoodwink_decoy" },
}

local shardLinked = {
	["shadow_demon_demonic_purge"] = { "shadow_demon_demonic_cleanse" },
	["medusa_mystic_snake"] = { "medusa_cold_blooded" },
	["necrolyte_death_pulse"] = { "necrolyte_death_seeker" },
	["slark_shadow_dance"] = { "slark_depth_shroud" },
	["witch_doctor_death_ward"] = { "witch_doctor_voodoo_switcheroo" },
	["dragon_knight_elder_dragon_form"] = { "dragon_knight_fireball" },
	-- ["clinkz_tar_bomb"] = { "clinkz_burning_barrage" },
	["zuus_arc_lightning_lua"] = { "zuus_lightning_hands_lua" },
	["drow_ranger_marksmanship"] = { "drow_ranger_glacier" },
	["antimage_counterspell"] = { "antimage_counterspell_ally" },
	["crystal_maiden_frostbite"] = { "crystal_maiden_crystal_clone" },
	["disruptor_kinetic_field"] = { "disruptor_kinetic_fence" },
	["shadow_shaman_mass_serpent_ward"] = { "shadow_shaman_urnaconda" },
}

local scepterShardByHero = {
	["npc_dota_hero_alchemist"] = { "alchemist_berserk_potion" },
	["npc_dota_hero_bristleback"] = { "bristleback_hairball" },
	["npc_dota_hero_rattletrap"] = { "rattletrap_jetpack" },
	["npc_dota_hero_kunkka"] = { "kunkka_tidal_wave" },
	["npc_dota_hero_lich"] = { "lich_ice_spire" },
	["npc_dota_hero_ogre_magi"] = { "ogre_magi_smash" },
	["npc_dota_hero_pangolier"] = { "pangolier_rollup" },
	["npc_dota_hero_sniper"] = { "sniper_concussive_grenade" },
	["npc_dota_hero_shredder"] = { "shredder_flamethrower" },
	["npc_dota_hero_tinker"] = { "tinker_warp_grenade" },
	["npc_dota_hero_terrorblade"] = { "terrorblade_demon_zeal" },
	["npc_dota_hero_windrunner"] = { "windrunner_gale_force" },
	["npc_dota_hero_primal_beast"] = { "primal_beast_rock_throw" },
	["npc_dota_hero_hoodwink"] = { "hoodwink_hunters_boomerang" },
	-- ["npc_dota_hero_skywrath_mage"] = { "skywrath_mage_shield_of_the_scion_lua" },
	["npc_dota_hero_oracle"] = { "oracle_rain_of_destiny" },
	["npc_dota_hero_meepo"] = { "meepo_petrify" },
	["npc_dota_hero_tidehunter"] = { "tidehunter_dead_in_the_water" },
	["npc_dota_hero_enchantress"] = { "enchantress_bunny_hop" },
	["npc_dota_hero_ringmaster"] = { "ringmaster_spotlight" },
	["npc_dota_hero_muerta"] = { "muerta_spectral_slug" },
	["npc_dota_hero_clinkz"] = { "clinkz_burning_barrage" },
}

return {
	scepterByHero = scepterByHero,
	scepterLinked = scepterLinked,
	shardLinked = shardLinked,
	scepterShardByHero = scepterShardByHero,
}