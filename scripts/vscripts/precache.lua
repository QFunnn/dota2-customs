--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


return function(context)
	PrecacheUnitByNameSync("npc_dota_hero_target_dummy", context, nil)

	local precached_models = {}
	for _, file_name in pairs({ "npc_items_custom", "npc_items_d", "npc_items_full_custom", "npc_items_other" }) do
		local t = LoadKeyValues("scripts/npc/" .. file_name .. ".txt")
		for k, v in pairs(t) do
			if v.Model and not precached_models[v.Model] then
				PrecacheModel(v.Model, context)
				precached_models[v.Model] = true
			end
		end
	end

	local root_files = {
		"npc_units_custom",
		"npc_units_heroes",
		"bosses/main_bosses_unit",
		"bosses/bosses_minion_unit",
		"bosses/additional_bosses_unit",
		"traps/traps",
	}
	local precached_units = {}
	local precached_units_creeps = {}

	for _, file_name in pairs(root_files) do
		local t = LoadKeyValues("scripts/npc/" .. file_name .. ".txt")
		for unit_name, _ in pairs(t) do
			if not precached_units[unit_name] then
				PrecacheUnitByNameSync(unit_name, context, nil)
				precached_units[unit_name] = true
			end
		end
	end

	for i = 1, 12 do
		local t = LoadKeyValues("scripts/npc/creeps/zone_" .. i .. "/unit_zone_" .. i .. ".txt")
		for unit_name, _ in pairs(t) do
			if not precached_units_creeps[unit_name] then
				PrecacheUnitByNameSync(unit_name, context, nil)
				precached_units_creeps[unit_name] = true
			end
		end
	end

	PrecacheUnitByNameSync("npc_dota_weaver_swarm", context)

	PrecacheResource("model", "models/events/crownfall/survivors/undying_minion/undying_minion_enemy.vmdl", context)

	PrecacheItemByNameSync("item_tombstone", context)
	PrecacheItemByNameSync("item_bag_of_gold", context)

	PrecacheResource("particle_folder", "particles/units/heroes/hero_dragon_knight", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_shadow_demon", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_grimstroke", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_venomancer", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_lina", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_axe", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_tusk", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_life_stealer", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_treant", context)
	PrecacheResource("particle_folder", "particles/darkmoon_last_hit_effect.vpcf", context)

	PrecacheResource("particle_folder", "particles/hny/", context)
	PrecacheResource("particle", "particles/econ/events/snowball/snowball_projectile.vpcf", context)
	PrecacheResource("particle", "particles/econ/items/tinker/boots_of_travel/teleport_start_bots.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_lich/lich_sinister_gaze.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/dagon.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_antimage/antimage_blink_start.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_antimage/antimage_blink_end.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_techies/techies_suicide_explosion.vpcf", context)

	PrecacheResource("particle", "particles/units/heroes/hero_winter_wyvern/wyvern_splinter_blast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf", context)

	PrecacheResource("particle", "particles/units/heroes/hero_leshrac/leshrac_lightning_bolt.vpcf", context)
	PrecacheResource("particle", "particles/econ/courier/courier_golden_roshan/golden_roshan_ambient.vpcf", context)
	PrecacheResource("particle", "particles/traps/temple_trap_arrow.vpcf", context)
	PrecacheResource("particle", "particles/trap_sunray.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_phantom_lancer/phantom_lancer_spawn_illusion.vpcf",
		context
	)

	PrecacheResource(
		"particle",
		"particles/econ/items/invoker/invoker_apex/invoker_sun_strike_team_immortal1.vpcf",
		context
	)
	PrecacheResource("particle", "particles/econ/items/invoker/invoker_apex/invoker_sun_strike_immortal1.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_terrorblade/terrorblade_scepter.vpcf", context)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf",
		context
	)
	PrecacheResource(
		"particle",
		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf",
		context
	)
	PrecacheResource("particle", "particles/bkb_flask.vpcf", context)

	PrecacheResource("particle", "particles/units/heroes/hero_zuus/zuus_arc_lightning_head.vpcf", context)
	PrecacheResource("particle", "particles/items_fx/chain_lightning.vpcf", context)

	PrecacheResource("particle", "particles/guild/behind_banner_1.vpcf", context)

	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bristleback.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_rattletrap.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bloodseeker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_drowranger.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_mirana.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_lancer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_puck.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pudge.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sandking.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_vengefulspirit.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_kunkka.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shadowshaman.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_slardar.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_witchdoctor.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_riki.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_necrolyte.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_queenofpain.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_skeletonking.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_death_prophet.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pugna.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_luna.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dazzle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_omniknight.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_weaver.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_batrider.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_chen.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_obsidian_destroyer.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lone_druid.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_treant.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_rubick.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_disruptor.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_naga_siren.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_wisp.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_visage.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_earth_spirit.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_monkey_king.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_pangolier.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_willow.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_void_spirit.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_snapfire.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_necrolyte.vsndevts", context)

	PrecacheResource("soundfile", "soundevents/game_sounds_ambient.vsndevts", context)

	PrecacheResource("soundfile", "soundevents/voscripts/game_sounds_vo_enigma.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/soundevents_conquest.vsndevts", context)

	PrecacheResource("soundfile", "soundevents/game_sounds_custom.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_winter_2018.vsndevts", context)

	PrecacheResource("soundfile", "sounds/music/stingers/quest_complete_01.vsnd", context)
	PrecacheResource("soundfile", "soundevents/music/game_sounds_music_tutorial.vsndevts", context)

	PrecacheResource("soundfile", "soundevents/game_sounds_tips.vsndevts", context)

	PrecacheResource("model", "models/gameplay/breakingcrate_dest.vmdl", context)
	PrecacheResource(
		"model",
		"models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_high_priest.vmdl",
		context
	)
	PrecacheResource("model", "models/heroes/undying/undying_tower.vmdl", context)
	PrecacheResource("model", "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl", context)
	PrecacheResource("model", "models/heroes/ursa/ursa.vmdl", context)
	PrecacheResource("model", "models/heroes/undying/undying_flesh_golem.vmdl", context)
	PrecacheResource("model", "models/heroes/tuskarr/tuskarr.vmdl", context)
	PrecacheResource("model", "models/heroes/crystal_maiden/crystal_maiden.vmdl", context)
	PrecacheResource("model", "models/heroes/ancient_apparition/ancient_apparition.vmdl", context)
	PrecacheResource("model", "models/heroes/lich/lich.vmdl", context)
	PrecacheResource("model", "models/creeps/ice_biome/ogreseal/ogreseal.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling.vmdl",
		context
	)
	PrecacheResource("model", "models/creeps/ice_biome/frostbitten/n_creep_frostbitten_shaman01.vmdl", context)
	PrecacheResource("model", "models/heroes/mirana/mirana.vmdl", context)
	PrecacheResource("model", "models/creeps/ice_biome/storegga/storegga.vmdl", context)
	PrecacheResource("model", "models/creeps/darkreef/gaoler/darkreef_gaoler.vmdl", context)
	PrecacheResource("model", "models/items/undying/idol_of_ruination/ruin_wight_minion_gold.vmdl", context)
	PrecacheResource("model", "models/creeps/bat_spitter/bat_spitter.vmdl", context)
	PrecacheResource("model", "models/heroes/nerubian_assassin/nerubian_assassin.vmdl", context)
	PrecacheResource("model", "models/creeps/omniknight_golem/omniknight_golem.vmdl", context)
	PrecacheResource("model", "models/heroes/slark/slark.vmdl", context)
	PrecacheResource("model", "models/heroes/morphling/morphling.vmdl", context)
	PrecacheResource("model", "models/heroes/siren/siren.vmdl", context)
	PrecacheResource("model", "models/heroes/slardar/slardar.vmdl", context)
	PrecacheResource("model", "models/heroes/treant_protector/treant_protector.vmdl", context)
	PrecacheResource("model", "models/creeps/forest_bear/forest_bear.vmdl", context)
	PrecacheResource("model", "models/heroes/enchantress/enchantress.vmdl", context)
	PrecacheResource("model", "models/heroes/life_stealer/life_stealer.vmdl", context)
	PrecacheResource("model", "models/heroes/warlock/warlock.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/visage/bound_of_the_soul_keeper_familiar/bound_of_the_soul_keeper_familiar.vmdl",
		context
	)
	PrecacheResource("model", "models/heroes/doom/doom.vmdl", context)
	PrecacheResource("model", "models/heroes/pudge/pudge.vmdl", context)
	PrecacheResource("model", "models/creeps/nyx_swarm/nyx_swarm.vmdl", context)
	PrecacheResource("model", "models/heroes/broodmother/broodmother.vmdl", context)
	PrecacheResource("model", "models/creeps/spiders/spider_poison.vmdl", context)
	PrecacheResource("model", "models/creeps/spiders/spidersack.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl",
		context
	)
	PrecacheResource("model", "models/heroes/zeus/zeus.vmdl", context)
	PrecacheResource("model", "models/heroes/phoenix/phoenix_bird.vmdl", context)
	PrecacheResource("model", "models/creeps/n_creep_ogre_med/n_creep_ogre_med.vmdl", context)
	PrecacheResource("model", "models/heroes/necrolyte/necrolyte.vmdl", context)
	PrecacheResource("model", "models/heroes/tristana/tristana.vmdl", context)
	PrecacheResource("model", "models/items/antimage/ti7_antimage_immortal/antimage_immortal_remnant_fx.vmdl", context)

	PrecacheResource("model", "models/heroes/treant_protector/treant_protector.vmdl", context)
	PrecacheResource("model", "models/heroes/juggernaut/jugg_healing_ward.vmdl", context)
	PrecacheResource("model", "models/items/lycan/ultimate/ambry_true_form/ambry_true_form.vmdl", context)
	PrecacheResource("model", "models/heroes/ancient_apparition/ancient_apparition.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_satyr_a/n_creep_satyr_a.vmdl", context)
	PrecacheResource("model", "models/creeps/nian/nian_creep.vmdl", context)
	PrecacheResource("model", "models/courier/baby_rosh/babyroshan_ti10_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/tuskarr/tuskarr.vmdl", context)
	PrecacheResource("model", "models/items/courier/el_gato_hero/el_gato_hero_flying.vmdl", context)
	PrecacheResource("model", "models/npc/forest_golem/forest_golem_red.vmdl", context)
	PrecacheResource("model", "models/items/courier/deathripper/deathripper_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/techies/techies.vmdl", context)
	PrecacheResource("model", "models/heroes/mirana/mirana.vmdl", context)
	PrecacheResource("model", "models/items/courier/livery_llama_courier/livery_llama_courier_flying.vmdl", context)
	PrecacheResource("model", "models/items/hex/sheep_hex/sheep_hex.vmdl", context)
	PrecacheResource("model", "models/creeps/lane_creeps/creep_bad_melee/creep_bad_melee_mega.vmdl", context)
	PrecacheResource("model", "models/items/courier/itsy/itsy_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/pudge/pudge.vmdl", context)
	PrecacheResource("model", "models/heroes/nerubian_assassin/nerubian_assassin.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/undying/flesh_golem/incurable_pestilence_golem/incurable_pestilence_golem.vmdl",
		context
	)
	PrecacheResource("model", "models/items/courier/defense4_radiant/defense4_radiant_flying.vmdl", context)
	PrecacheResource("model", "models/courier/smeevil_bird/smeevil_bird_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/techies/fx_techiesfx_mine.vmdl", context)
	PrecacheResource("model", "models/heroes/shadowshaman/shadowshaman_totem.vmdl", context)
	PrecacheResource("model", "models/items/wraith_king/arcana/wk_arcana_skeleton.vmdl", context)
	PrecacheResource("model", "models/items/rattletrap/clockmaster_cog/clockmaster_cog.vmdl", context)
	PrecacheResource("model", "models/development/invisiblebox.vmdl", context)
	PrecacheResource("model", "models/items/courier/mok/mok_flying.vmdl", context)
	PrecacheResource("model", "models/units/destroyer/destroyer.vmdl", context)
	PrecacheResource("model", "models/items/courier/arneyb_rabbit/arneyb_rabbit_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/earth_spirit/earth_spirit.vmdl", context)
	PrecacheResource("model", "models/items/courier/baekho/baekho_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/necrolyte/necrolyte.vmdl", context)
	PrecacheResource("model", "models/heroes/morphling/morphling.vmdl", context)
	PrecacheResource("model", "models/courier/navi_courier/navi_courier_flying.vmdl", context)
	PrecacheResource("model", "models/units/doppelganger/doppelganger.vmdl", context)
	PrecacheResource("model", "models/ui/battle_cup_trophy/mesh/battle_cup_fall_trophy.vmdl", context)
	PrecacheResource("model", "models/heroes/doom/doom.vmdl", context)
	PrecacheResource("model", "models/heroes/invoker/forge_spirit.vmdl", context)
	PrecacheResource("model", "models/props_gameplay/tombstoneb01.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_dragonspawn_a/n_creep_dragonspawn_a.vmdl", context)
	PrecacheResource("model", "models/props/traps/barking_dog/barking_dog.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/courier/frostivus2018_courier_serac_the_seal/frostivus2018_courier_serac_the_seal_flying.vmdl",
		context
	)
	PrecacheResource("model", "models/props_gameplay/tombstonea01.vmdl", context)
	PrecacheResource("model", "models/gameplay/breakingvase_dest.vmdl", context)
	PrecacheResource("model", "models/courier/baby_rosh/babyroshan_winter18_flying.vmdl", context)
	PrecacheResource("model", "models/props_structures/outpost.vmdl", context)
	PrecacheResource("model", "models/creeps/baby_rosh_halloween/baby_rosh_dire/baby_rosh_dire.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/furion/treant/allfather_of_nature_treant/allfather_of_nature_treant.vmdl",
		context
	)
	PrecacheResource("model", "models/creeps/bat_spitter/bat_spitter.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_satyr_b/n_creep_satyr_b.vmdl", context)
	PrecacheResource("model", "models/heroes/enchantress/enchantress.vmdl", context)
	PrecacheResource("model", "models/items/earth_spirit/demon_stone_summon/demon_stone_summon.vmdl", context)
	PrecacheResource("model", "models/heroes/disruptor/disruptor.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/rattletrap/scubawerk_ti7_scubawerk_power_cog/scubawerk_ti7_scubawerk_power_cog.vmdl",
		context
	)
	PrecacheResource("model", "models/heroes/monkey_king/monkey_king.vmdl", context)
	PrecacheResource("model", "models/items/courier/alphid_of_lecaciida/alphid_of_lecaciida_flying.vmdl", context)
	PrecacheResource("model", "models/creeps/omniknight_golem/omniknight_golem.vmdl", context)
	PrecacheResource("model", "models/courier/huntling/huntling_flying.vmdl", context)
	PrecacheResource("model", "models/items/lone_druid/viciouskraitpanda/viciouskrait_panda.vmdl", context)
	PrecacheResource("model", "models/courier/baby_rosh/babyroshan_alt_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/batrider/batrider.vmdl", context)
	PrecacheResource(
		"model",
		"models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl",
		context
	)
	PrecacheResource("model", "models/courier/minipudge/minipudge_flying.vmdl", context)
	PrecacheResource("model", "models/creeps/nyx_swarm/nyx_swarm.vmdl", context)
	PrecacheResource("model", "models/npc_minions/draft_siege_good.vmdl", context)
	PrecacheResource("model", "models/courier/courier_mech/courier_mech_flying.vmdl", context)
	PrecacheResource("model", "models/props/traps/pendulum/pendulum.vmdl", context)
	PrecacheResource("model", "models/courier/mech_donkey/mech_donkey_flying.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_beast/n_creep_beast.vmdl", context)
	PrecacheResource("model", "models/heroes/tristana/tristana.vmdl", context)
	PrecacheResource("model", "models/items/courier/tinkbot/tinkbot_flying.vmdl", context)
	PrecacheResource("model", "models/courier/frog/frog_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/mars/mars.vmdl", context)
	PrecacheResource("model", "models/heroes/medusa/medusa.vmdl", context)
	PrecacheResource("model", "models/heroes/crystal_maiden/crystal_maiden.vmdl", context)
	PrecacheResource("model", "models/courier/ram/ram_flying.vmdl", context)
	PrecacheResource("model", "models/courier/baby_winter_wyvern/baby_winter_wyvern_flying.vmdl", context)
	PrecacheResource(
		"model",
		"models/props_gameplay/npc/shopkeeper_the_lost_meepo/shopkeeper_the_lost_meepo.vmdl",
		context
	)
	PrecacheResource("model", "models/gameplay/breakingcrate_dest.vmdl", context)
	PrecacheResource("model", "models/props_structures/tower_upgrade/tower_upgrade_dest.vmdl", context)
	PrecacheResource("model", "models/units/anakim_pet/anakim_pet.vmdl", context)
	PrecacheResource("model", "models/courier/smeevil_magic_carpet/smeevil_magic_carpet_flying.vmdl", context)
	PrecacheResource("model", "models/courier/venoling/venoling_flying.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/warlock/golem/ti9_cache_warlock_tribal_warlock_golem/ti9_cache_warlock_tribal_golem_alt.vmdl",
		context
	)
	PrecacheResource("model", "models/items/pugna/ward/nether_grandmasters_ward/nether_grandmasters_ward.vmdl", context)
	PrecacheResource("model", "models/items/courier/axolotl/axolotl_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/furion/furion.vmdl", context)
	PrecacheResource("model", "models/heroes/slardar/slardar.vmdl", context)
	PrecacheResource("model", "models/courier/mechjaw/mechjaw_flying.vmdl", context)
	PrecacheResource("model", "models/courier/otter_dragon/otter_dragon_flying.vmdl", context)
	PrecacheResource("model", "models/courier/sillydragon/sillydragon_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/invoker_kid/invoker_kid.vmdl", context)
	PrecacheResource("model", "models/creeps/ice_biome/storegga/storegga.vmdl", context)
	PrecacheResource("model", "models/heroes/keeper_of_the_light/keeper_of_the_light.vmdl", context)
	PrecacheResource("model", "models/heroes/undying/undying_tower.vmdl", context)
	PrecacheResource("model", "models/heroes/arc_warden/arc_warden.vmdl", context)
	PrecacheResource("model", "models/heroes/clinkz/clinkz_archer.vmdl", context)
	PrecacheResource("model", "models/courier/baby_rosh/babyroshan_ti10_dire_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/undying/undying_minion.vmdl", context)
	PrecacheResource("model", "models/npc/babahooka/babahooka.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context)
	PrecacheResource("model", "models/creeps/forest_bear/forest_bear.vmdl", context)
	PrecacheResource("model", "models/items/courier/faceless_rex/faceless_rex_flying.vmdl", context)
	PrecacheResource("model", "models/items/lycan/wolves/ambry_summon/ambry_summon.vmdl", context)
	PrecacheResource("model", "models/creeps/darkreef/blob/darkreef_blob_02_small.vmdl", context)
	PrecacheResource("model", "models/props_garden/bad_stonewallstatue004.vmdl", context)
	PrecacheResource("model", "models/heroes/venomancer/venomancer_ward.vmdl", context)
	PrecacheResource("model", "models/npc/tu/tu.vmdl", context)
	PrecacheResource("model", "models/courier/tegu/tegu_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/sniper/sniper.vmdl", context)
	PrecacheResource("model", "models/creeps/spiders/spidersack.vmdl", context)
	PrecacheResource(
		"model",
		"models/creeps/neutral_creeps/n_creep_forest_trolls/n_creep_forest_troll_high_priest.vmdl",
		context
	)
	PrecacheResource("model", "models/props_structures/urn001c.vmdl", context)
	PrecacheResource("model", "models/creeps/roshan/roshan.vmdl", context)
	PrecacheResource("model", "models/items/undying/idol_of_ruination/idol_tower_sim.vmdl", context)
	PrecacheResource("model", "models/courier/baby_rosh/babyroshan_ti9_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/warlock/warlock_demon.vmdl", context)
	PrecacheResource("model", "models/heroes/gyro/gyro.vmdl", context)
	PrecacheResource("model", "models/props/traps/spiketrap/spiketrap.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context)
	PrecacheResource("model", "models/items/courier/jin_yin_white_fox/jin_yin_white_fox_flying.vmdl", context)
	PrecacheResource("model", "models/units/stegius/stegius.vmdl", context)
	PrecacheResource("model", "models/heroes/warlock/warlock.vmdl", context)
	PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_furbolg/n_creep_furbolg_disrupter.vmdl", context)
	PrecacheResource("model", "models/heroes/phoenix/phoenix_bird.vmdl", context)
	PrecacheResource("model", "models/items/rattletrap/warmachine_cog_dc/warmachine_cog_dc.vmdl", context)
	PrecacheResource("model", "models/heroes/undying/undying_minion_torso.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl",
		context
	)
	PrecacheResource("model", "models/events/crownfall/survivors/undying_minion/undying_minion_enemy.vmdl", context)
	PrecacheResource("model", "models/items/courier/weta_automaton/weta_automaton_flying.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/broodmother/spiderling/ti8_brood_the_great_arachne_spiderling/ti8_brood_the_great_arachne_spiderling.vmdl",
		context
	)
	PrecacheResource("model", "models/heroes/venomancer/venomancer.vmdl", context)
	PrecacheResource("model", "models/items/courier/butch_pudge_dog/butch_pudge_dog_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/aghanim/aghanim_model.vmdl", context)
	PrecacheResource("model", "models/items/courier/devourling/devourling_flying.vmdl", context)
	PrecacheResource(
		"model",
		"models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling.vmdl",
		context
	)
	PrecacheResource("model", "models/props_gameplay/shopkeeper_fountain/shopkeeper_fountain.vmdl", context)
	PrecacheResource("model", "models/heroes/ursa/ursa.vmdl", context)
	PrecacheResource("model", "models/machinegun_new.vmdl", context)
	PrecacheResource("model", "models/items/courier/amaterasu/amaterasu_flying.vmdl", context)
	PrecacheResource("model", "models/items/courier/bearzky_v2/bearzky_v2_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/enigma/enigma.vmdl", context)
	PrecacheResource("model", "models/courier/seekling/seekling_flying.vmdl", context)
	PrecacheResource("model", "models/items/courier/mighty_chicken/mighty_chicken.vmdl", context)
	PrecacheResource("model", "models/creeps/ice_biome/ogreseal/ogreseal.vmdl", context)
	PrecacheResource("model", "models/heroes/INVOKER/INVOKER.vmdl", context)
	PrecacheResource("model", "models/heroes/winterwyvern/winterwyvern.vmdl", context)
	PrecacheResource("model", "models/items/courier/captain_bamboo/captain_bamboo_flying.vmdl", context)
	PrecacheResource("model", "models/creeps/ice_biome/frostbitten/n_creep_frostbitten_swollen01.vmdl", context)
	PrecacheResource("model", "models/props/traps/hooded_fang/hooded_fang.vmdl", context)
	PrecacheResource("model", "models/heroes/lich/lich.vmdl", context)
	PrecacheResource("model", "models/props_gameplay/treasure_chest001.vmdl", context)
	PrecacheResource("model", "models/courier/drodo/drodo_flying.vmdl", context)
	PrecacheResource("model", "models/heroes/omniknight/omniknight.vmdl", context)
	PrecacheResource("model", "models/props_gameplay/dummy/dummy.vmdl", context)

	PrecacheResource("model", "models/heroes/fiddlesticks/fiddlesticks.vmdl", context)

	PrecacheResource("soundfile", "soundevents/cas/sound_spinning.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/bg_game_loop.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/you_win_sequence_1.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/you_win_sequence_2.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/you_win_sequence_3.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/item_has_been_sold.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/casino_jackpot.vsndevts", context)
	PrecacheResource("soundfile", "soundevents/cas/jackpot_win_notification.vsndevts", context)

	-- Akatsuki skins
	PrecacheResource("model", "models/naruto/pain/pain.vmdl", context)
	PrecacheResource("model", "models/naruto/itachi/itachi.vmdl", context)
	PrecacheResource("model", "models/naruto/kisame/kisame.vmdl", context)
	PrecacheResource("model", "models/naruto/hidan/hidan.vmdl", context)
	PrecacheResource("model", "models/naruto/tobi/tobi.vmdl", context)
	PrecacheResource("model", "models/naruto/zecu/zecu.vmdl", context)
	PrecacheResource("model", "models/naruto/konan/konan.vmdl", context)
	PrecacheResource("model", "models/naruto/deidara/deidara.vmdl", context)
	PrecacheResource("model", "models/naruto/kakuzu/kakuzu.vmdl", context)
	PrecacheResource("model", "models/naruto/sasori/sasori.vmdl", context)
end