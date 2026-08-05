--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


/* 
	播放棋子的台词
*/
const DIALOGUE_LIST = {
	chess_tusk: {
		spawn: 'tusk_tusk_spawn_05',
		win: 'tusk_tusk_win_01',
		merge: 'tusk_tusk_superpunch_attack_01',
		thanks: 'tusk_tusk_thanks_01',
	},
	chess_cm: {
		spawn: 'crystalmaiden_cm_spawn_04',
		win: 'crystalmaiden_cm_win_02',
		merge: 'crystalmaiden_cm_spawn_06',
		thanks: 'crystalmaiden_cm_thanks_01',
	},
	chess_axe: {
		spawn: 'chess_axe.spawn',//'axe_axe_spawn_05',
		win: 'axe_axe_win_03',
		merge: 'axe_axe_level_01',
		thanks: 'axe_axe_thanks_01',
	},
	chess_eh: {
		spawn: 'enchantress_ench_spawn_03',
		win: 'enchantress_ench_rare_02',
		merge: 'enchantress_ench_respawn_10',
		thanks: 'enchantress_ench_thanks_02',
	},
	chess_om: {
		spawn: 'ogre_magi_ogmag_move_05',
		win: 'ogre_magi_ogmag_move_06',
		merge: 'ogre_magi_ogmag_move_15',
		thanks: 'ogre_magi_ogmag_thanks_03',
	},
	chess_am_wei: {
		spawn: 'antimage_amp_wei_ability2_01',
		win: 'antimage_amp_wei_respawn_09',
		merge: 'antimage_anti_rare_01',
		thanks: 'antimage_amp_wei_thanks_03',
	},
	chess_am: {
		spawn: 'antimage_anti_spawn_03',
		win: 'antimage_anti_win_03',
		merge: 'antimage_anti_rare_01',
		thanks: 'antimage_anti_thanks_01',
	},
	chess_clock: {
		spawn: 'rattletrap_ratt_respawn_18',
		win: 'rattletrap_ratt_move_14',
		merge: 'rattletrap_ratt_respawn_17',
		thanks: 'rattletrap_ratt_thanks_01',
	},
	chess_ss: {
		spawn: 'shadowshaman_shad_respawn_05',
		win: 'shadowshaman_shad_win_03',
		merge: 'shadowshaman_shad_rare_03',
		thanks: 'shadowshaman_shad_thanks_01',
	},
	chess_bh: {
		spawn: 'bounty_hunter_bount_spawn_02',
		win: 'bounty_hunter_bount_win_05',
		merge: 'bounty_hunter_bount_spawn_03',
		thanks: 'bounty_hunter_bount_thanks_01',
	},
	chess_wd: {
		spawn: 'witchdoctor_wdoc_spawn_04',
		win: 'witchdoctor_wdoc_win_02',
		merge: 'witchdoctor_wdoc_respawn_07',
		thanks: 'witchdoctor_wdoc_thanks_01',
	},
	chess_tk: {
		spawn: 'tinker_tink_spawn_08',
		win: 'tinker_tink_taunt_03',
		merge: 'tinker_tink_rare_01',
		thanks: 'tinker_tink_thanks_01',
	},
	chess_bm: {
		spawn: 'beastmaster_beas_spawn_02',
		win: 'beastmaster_beas_win_02',
		merge: 'beastmaster_beas_level_06',
		thanks: 'beastmaster_beas_thanks_01',
	},
	chess_jugg: {
		spawn: 'juggernaut_jug_spawn_05',
		win: 'juggernaut_jug_win_03',
		merge: 'juggernaut_jug_rare_03',
		thanks: 'juggernaut_jug_thanks_01',
	},
	chess_lyc: {
		spawn: 'lycan_lycan_spawn_02',
		win: 'lycan_lycan_respawn_06',
		merge: 'lycan_lycan_win_03',
		thanks: 'lycan_lycan_thanks_01',
	},
	chess_shredder: {
		spawn: 'shredder_timb_spawn_02',
		win: 'shredder_timb_levelup_07',
		merge: 'shredder_timb_move_08',
		thanks: 'shredder_timb_thanks_01',
	},
	chess_pa: {
		spawn: 'phantom_assassin_phass_spawn_04',
		win: 'phantom_assassin_phass_win_02',
		merge: 'phantom_assassin_phass_move_09',
		thanks: 'phantom_assassin_phass_thanks_01',
	},
	chess_puck: {
		spawn: 'puck_puck_spawn_05',
		win: 'puck_puck_win_04',
		merge: 'puck_puck_respawn_09',
		thanks: 'puck_puck_thanks_01',
	},
	chess_slardar: {
		spawn: 'slardar_slar_spawn_03',
		win: 'slardar_slar_win_05',
		merge: 'slardar_slar_level_07',
		thanks: 'slardar_slar_thanks_01',
	},
	chess_ck: {
		spawn: 'chaos_knight_chaknight_spawn_05',
		win: 'chaos_knight_chaknight_rival_13',
		merge: 'chaos_knight_chaknight_rare_01',
		thanks: 'chaos_knight_chaknight_thanks_01',
	},
	chess_dr: {
		spawn: 'drowranger_dro_spawn_04',
		win: 'drowranger_drow_levelup_07',
		merge: 'drowranger_dro_cast_01',
		thanks: "chess_dr.thanks",
	},
	chess_light: {
		spawn: 'keeper_of_the_light_keep_spawn_03',
		win: 'keeper_of_the_light_keep_win_04',
		merge: 'keeper_of_the_light_keep_levelup_10',
		thanks: 'keeper_of_the_light_keep_thanks_01',
	},
	chess_razor: {
		spawn: 'razor_raz_spawn_03',
		win: 'razor_raz_level_04',
		merge: 'razor_raz_level_05',
		thanks: 'razor_raz_thanks_01',
	},
	chess_ok: {
		spawn: 'omniknight_omni_level_01',
		win: 'omniknight_omni_level_08',
		merge: 'omniknight_omni_level_03',
		thanks: 'omniknight_omni_thanks_01',
	},
	chess_wr: {
		spawn: 'windrunner_wind_spawn_03',
		win: 'windrunner_wind_kill_03',
		merge: 'windrunner_wind_level_01',
		thanks: 'windrunner_wind_thanks_01',
	},
	chess_sk: {
		spawn: 'sandking_skg_spawn_07',
		win: 'sandking_skg_rare_01',
		merge: 'sandking_skg_kill_03',
		thanks: 'sandking_skg_thanks_01',
	},
	chess_abaddon: {
		spawn: 'abaddon_abad_spawn_02',
		win: 'abaddon_abad_win_04',
		merge: 'abaddon_abad_levelup_08',
		thanks: 'abaddon_abad_thanks_01',
	},
	chess_slark: {
		spawn: 'slark_slark_spawn_02',
		win: 'slark_slark_win_03',
		merge: 'slark_slark_levelup_06',
		thanks: 'slark_slark_thanks_01',
	},
	chess_sniper: {
		spawn: 'sniper_snip_spawn_03',
		win: 'sniper_snip_rare_01',
		merge: 'sniper_snip_level_03',
		thanks: 'sniper_snip_thanks_01',
	},
	chess_kunkka: {
		spawn: 'kunkka_kunk_spawn_09',
		win: 'kunkka_kunk_win_03',
		merge: 'kunkka_kunk_spawn_05',
		thanks: 'kunkka_kunk_thanks_01',
	},
	chess_doom: {
		spawn: 'doom_bringer_doom_spawn_04',
		win: 'doom_bringer_doom_respawn_09',
		merge: 'doom_bringer_doom_level_04',
		thanks: 'doom_bringer_doom_thanks_01',
	},
	chess_lina: {
		spawn: 'lina_lina_rare_02',
		win: 'lina_lina_win_03',
		merge: 'lina_lina_spawn_04',
		thanks: 'lina_lina_thanks_01',
	},
	chess_troll: {
		spawn: 'chess_troll.spawn',
		win: 'chess_troll.win',
		merge: 'chess_troll.merge',
		thanks: 'chess_troll.thanks',
	},
	chess_veno: {
		spawn: 'venomancer_venm_level_11',
		win: 'venomancer_venm_win_03',
		merge: 'venomancer_venm_level_04',
		thanks: 'venomancer_venm_thanks_01',
	},
	chess_nec: {
		spawn: 'necrolyte_necr_respawn_11',
		win: 'necrolyte_necr_win_04',
		merge: 'necrolyte_necr_rare_04',
		thanks: 'necrolyte_necr_thanks_01',
	},
	chess_ta: {
		spawn: 'templar_assassin_temp_kill_12',
		win: 'templar_assassin_temp_win_03',
		merge: 'templar_assassin_temp_levelup_04',
		thanks: 'templar_assassin_temp_thanks_01',
	},
	chess_gyro: {
		spawn: 'gyrocopter_gyro_spawn_06',
		win: 'gyrocopter_gyro_kill_07',
		merge: 'gyrocopter_gyro_spawn_03',
		thanks: 'gyrocopter_gyro_thanks_01',
	},
	chess_lich: {
		spawn: 'lich_lich_spawn_03',
		win: 'lich_lich_rare_01',
		merge: 'lich_lich_level_01',
		thanks: 'lich_lich_thanks_01',
	},
	chess_qop: {
		spawn: 'queenofpain_pain_rare_01',
		win: 'queenofpain_pain_kill_12',
		merge: 'queenofpain_pain_taunt_02',
		thanks: 'queenofpain_pain_thanks_01',
	},
	chess_th: {
		spawn: 'tidehunter_tide_win_03',
		win: 'tidehunter_tide_rare_01',
		merge: 'tidehunter_tide_level_20',
		thanks: 'tidehunter_tide_thanks_01',
	},
	chess_enigma: {
		spawn: 'enigma_enig_spawn_07',
		win: 'enigma_enig_ability_black_01',
		merge: 'enigma_enig_rare_04',
		thanks: 'enigma_enig_thanks_01',
	},

	chess_bat: {
		spawn: 'batrider_bat_spawn_02',
		win: 'batrider_bat_win_04',
		merge: 'batrider_bat_level_02',
		thanks: 'batrider_bat_thanks_01',
	},
	chess_luna: {
		spawn: 'luna_luna_spawn_03',
		win: 'luna_luna_win_03',
		merge: 'luna_luna_levelup_02',
		thanks: 'luna_luna_thanks_01',
	},
	chess_tp: {
		spawn: 'treant_treant_move_20',
		win: 'treant_treant_win_04',
		merge: 'treant_treant_move_18',
		thanks: 'treant_treant_thanks_01',
	},
	chess_sf: {
		spawn: 'nevermore_nev_spawn_10',
		win: 'nevermore_nev_win_03',
		merge: 'nevermore_nev_rare_04',
		thanks: 'nevermore_nev_thanks_01',
	},
	// chess_dk: {
	// 	spawn: 'dragon_knight_dragon_spawn_02',
	// 	win: 'dragon_knight_dragon_win_03',
	// 	merge: 'dragon_knight_dragon_respawn_08',
	// 	thanks: 'dragon_knight_dragon_thanks_01',
	// },
	chess_dk: {
		spawn: "chess_dk.spawn",
		win: "chess_dk.win",
		merge: "chess_dk.merge",
		thanks: "chess_dk.thanks",
	},
	chess_viper: {
		spawn: 'viper_vipe_spawn_04',
		win: 'viper_vipe_win_02',
		merge: 'viper_vipe_rare_03',
		thanks: 'viper_vipe_thanks_01',
	},
	chess_medusa: {
		spawn: 'medusa_medus_stonegaze_07',
		win: 'medusa_medus_win_05',
		merge: 'medusa_medus_rare_05',
		thanks: 'medusa_medus_thanks_01',
	},
	chess_disruptor: {
		spawn: 'disruptor_dis_spawn_02',
		win: 'disruptor_dis_win_05',
		merge: 'disruptor_dis_levelup_07',
		thanks: 'disruptor_dis_thanks_01',
	},
	chess_ga: {
		spawn: 'chess_ga.spawn',
		win: 'chess_ga.win',
		merge: 'chess_ga.merge',
		thanks: 'chess_ga.thanks',
	},
	chess_tech: {
		spawn: 'techies_tech_setmine_52',
		win: 'techies_tech_move_52',
		merge: 'techies_tech_move_40',
		thanks: 'techies_tech_thanks_01',
	},
	chess_fur: {
		spawn: 'furion_furi_move_13',
		win: 'furion_furi_view_victory_03',
		merge: 'furion_furi_move_06',
		thanks: 'furion_furi_thanks_01',
	},
	chess_ld: {
		spawn: 'lone_druid_lone_druid_anger_07',
		win: 'lone_druid_lone_druid_level_11',
		merge: 'lone_druid_lone_druid_ability_rabid_03',
		thanks: 'lone_druid_lone_druid_thanks_01',
	},

	chess_tiny: {
		spawn: 'tiny_tiny_move_12',
		win: 'tiny_tiny_win_04',
		merge: 'tiny_tiny_spawn_03',
		thanks: 'tiny_tiny_thanks_01',
	},
	chess_morph: {
		spawn: 'morphling_mrph_respawn_03',
		win: 'morphling_mrph_win_03',
		merge: 'morphling_mrph_ability_repfriend_01',
		thanks: 'morphling_mrph_thanks_01',
	},
	chess_tb: {
		spawn: 'terrorblade_terr_shards_respawn_05',
		win: 'terrorblade_terr_shards_rival_28',
		merge: 'terrorblade_terr_shards_rival_14',
		thanks: 'terrorblade_terr_shards_thanks_01',
	},
	chess_ck_ssr: {
		spawn: 'chaos_knight_chaknight_ability_phantasm_02',
		win: 'chaos_knight_chaknight_rival_24',
		merge: 'chaos_knight_chaknight_rare_01',
		thanks: 'chaos_knight_chaknight_thanks_01',
	},
	chess_nec_ssr: {
		spawn: 'necrolyte_necr_spawn_04',
		win: 'necrolyte_necr_respawn_13',
		merge: 'necrolyte_necr_rare_04',
		thanks: 'necrolyte_necr_thanks_01',
	},
	chess_riki: {
		spawn: 'riki_riki_rare_05',
		win: 'riki_riki_level_05',
		merge: 'riki_riki_respawn_05',
		thanks: 'riki_riki_thanks_01',
	},
	chess_pom: {
		spawn: "chess_pom.spawn",//'mirana_mir_rival_07',
		win: 'mirana_mir_rare_09',
		merge: 'mirana_mir_thanks_02',
		thanks: 'mirana_mir_thanks_01',
	},
	chess_dp: {
		spawn: 'death_prophet_dpro_respawn_03',
		win: 'death_prophet_dpro_levelup_14',
		merge: 'death_prophet_dpro_spawn_03',
		thanks: 'death_prophet_dpro_thanks_01',
	},

	chess_zeus: {
		spawn: 'zuus_zuus_spawn_04',
		win: 'zuus_zuus_rare_03',
		merge: 'zuus_zuus_spawn_06',
		thanks: 'zuus_zuus_thanks_01',
	},
	chess_mars: {
		spawn: 'mars_mars_spawn_20',
		win: 'mars_mars_02',
		merge: 'mars_mars_spawn_10',
		thanks: 'mars_mars_thanks_01',
	},
	chess_dazzle: {
		spawn: 'dazzle_dazz_ability_shalgrave_09',
		win: 'dazzle_dazz_spawn_04',
		merge: 'dazzle_dazz_ability_weave_07',
		thanks: 'dazzle_dazz_thanks_01',
	},
	chess_io: {
		spawn: 'wisp_laugh',
		win: 'wisp_win',
		merge: 'wisp_purchase_scepter',
		thanks: 'wisp_thanks',
	},
	chess_sven: {
		spawn: "chess_sven.spawn",
		win: "chess_sven.win",
		merge: "chess_sven.merge",
		thanks: 'wisp_thanks_01',
	},
	chess_ww: {
		spawn: "chess_ww.spawn",
		win: "chess_ww.win",
		merge: "chess_ww.merge",
		thanks: 'winter_wyvern_winwyv_thanks_04',
	},
	chess_rubick: {
		spawn: "chess_rubick.spawn",
		win: "chess_rubick.win",
		merge: "chess_rubick.merge",
		thanks: 'rubick_rubick_thanks_01',
	},
	chess_gs: {
		spawn: "chess_gs.spawn",
		win: "chess_gs.win",
		merge: "chess_gs.merge",
		thanks: 'rubick_rubick_thanks_01',
	},

	chess_visage: {
		spawn: "chess_visage.spawn",
		win: "chess_visage.win",
		merge: "chess_visage.merge",
		thanks: 'visage_visa_thanks_02',
	},
	chess_pudge: {
		spawn: "chess_pudge.spawn",
		win: "chess_pudge.win",
		merge: "chess_pudge.merge",
		thanks: 'pudge_pud_thanks_01',
	},
	chess_lion: {
		spawn: "chess_lion.spawn",
		win: "chess_lion.win",
		merge: "chess_lion.merge",
		thanks: 'lion_lion_thanks_01',
	},
	chess_oracle: {
		spawn: "chess_oracle.spawn",
		win: "chess_oracle.win",
		merge: "chess_oracle.merge",
		thanks: 'oracle_orac_thanks_01',
	},
	chess_na: {
		spawn: "chess_na.spawn",
		win: "chess_na.win",
		merge: "chess_na.merge",
		thanks: 'nyx_assassin_nyx_thanks_02',
	},
	chess_huskar: {
		spawn: "chess_huskar.spawn",
		win: "chess_huskar.win",
		merge: "chess_huskar.merge",
		thanks: 'huskar_husk_thanks_02',
	},
	chess_bs: {
		spawn: "chess_bs.spawn",
		win: "chess_bs.win",
		merge: "chess_bs.merge",
		thanks: 'bloodseeker_blod_thanks_01',
	},
	chess_snap: {
		spawn: "chess_snap.spawn",
		win: "chess_snap.win",
		merge: "chess_snap.merge",
		thanks: "chess_snap.thanks",
	},
	chess_br: {
		spawn: "chess_br.spawn",
		win: "chess_br.win",
		merge: "chess_br.merge",
		thanks: "broodmother_broo_thanks_01",
	},
	chess_kael: {
		spawn: "chess_kael.spawn",
		win: "chess_kael.win",
		merge: "chess_kael.merge",
		thanks: "chess_kael.thanks",
	},
	chess_lc: {
		spawn: "chess_lc.spawn",
		win: "chess_lc.win",
		merge: "chess_lc.merge",
		thanks: "chess_lc.thanks",
	},
	chess_chen: {
		spawn: "chess_chen.spawn",
		win: "chess_chen.win",
		merge: "chess_chen.merge",
		thanks: "chen_chen_thanks_01",
	},
	chess_thd: {
		spawn: "chess_thd.spawn",
		win: "chess_thd.win",
		merge: "chess_thd.merge",
		thanks: "jakiro_jak_thanks_01",
	},
	chess_dw: {
		spawn: "chess_dw.spawn",
		win: "chess_dw.win",
		merge: "chess_dw.merge",
		thanks: "chess_dw.thanks",
	},
	chess_brew: {
		spawn: "chess_brew.spawn",
		win: "chess_brew.win",
		merge: "chess_brew.merge",
		fish: "chess_brew.fish",
		thanks: "chess_brew.thanks",
	},
	chess_brew_ssr: {
		spawn: "chess_brew.spawn",
		win: "chess_brew.win",
		merge: "chess_brew.merge",
		fish: "chess_brew.fish",
		thanks: "chess_brew.thanks",
	},
	chess_storm: {
		spawn: "chess_storm.spawn",
		win: "chess_storm.win",
		merge: "chess_storm.merge",
		fish: "chess_storm.fish",
		thanks: "chess_storm.thanks",
	},
	chess_ember: {
		spawn: "chess_ember.spawn",
		win: "chess_ember.win",
		merge: "chess_ember.merge",
		fish: "chess_ember.fish",
		thanks: "chess_ember.thanks",
	},
	chess_mk: {
		spawn: "chess_mk.spawn",
		win: "chess_mk.win",
		merge: "chess_mk.merge",
		thanks: "chess_mk.thanks",
	},
	chess_earth: {
		spawn: "chess_earth.spawn",
		win: "chess_earth.win",
		merge: "chess_earth.merge",
		fish: "chess_earth.fish",
		thanks: "chess_earth.thanks",
	},
	chess_es: {
		spawn: "chess_es.spawn",
		win: "chess_es.win",
		merge: "chess_es.merge",
		thanks: "chess_es.thanks",
	},
	chess_sb: {
		spawn: "chess_sb.spawn",
		win: "chess_sb.win",
		merge: "chess_sb.merge",
		thanks: "chess_sb.thanks",
	},
	chess_meepo: {
		spawn: "chess_meepo.spawn",
		win: "chess_meepo.win",
		merge: "chess_meepo.merge",
		thanks: "chess_meepo.thanks",
		"devided.1": "chess_meepo.devided.1",
		"devided.2": "chess_meepo.devided.2",
	},
	chess_et: {
		spawn: "chess_et.spawn",
		win: "chess_et.win",
		merge: "chess_et.merge",
		thanks: "chess_et.thanks",
	},
	chess_fv: {
		spawn: "chess_fv.spawn",
		win: "chess_fv.win",
		merge: "chess_fv.merge",
		thanks: "chess_fv.thanks",
	},
	chess_pangolier: {
		spawn: "chess_pangolier.spawn",
		win: "chess_pangolier.win",
		merge: "chess_pangolier.merge",
		thanks: "chess_pangolier.thanks",
	},
	chess_wl: {
		spawn: "chess_wl.spawn",
		win: "chess_wl.win",
		merge: "chess_wl.merge",
		thanks: "chess_wl.thanks",
	},
	chess_vs: {
		spawn: "chess_vs.spawn",
		win: "chess_vs.win",
		merge: "chess_vs.merge",
		thanks: "chess_vs.thanks",
	},
	chess_hw: {
		spawn: "chess_hw.spawn",
		win: "chess_hw.win",
		merge: "chess_hw.merge",
		thanks: "chess_hw.thanks",
	},
	chess_aw: {
		spawn: "chess_aw.spawn",
		win: "chess_aw.win",
		merge: "chess_aw.merge",
		thanks: "chess_aw.thanks",
		"devided.1": "chess_aw.devided.1",
		"devided.2": "chess_aw.devided.2",
	},
	chess_spe: {
		spawn: "chess_spe.spawn",
		win: "chess_spe.win",
		merge: "chess_spe.merge",
		thanks: "chess_spe.thanks",
	},
	chess_marci: {
		spawn: "chess_marci.spawn",
		win: "chess_marci.win",
		merge: "chess_marci.merge",
		thanks: "chess_marci.thanks",
	},
	chess_naga: {
		spawn: "chess_naga.spawn",
		win: "chess_naga.win",
		merge: "chess_naga.merge",
		thanks: "chess_naga.thanks",
	},
	chess_void: {
		spawn: "chess_void.spawn",
		win: "chess_void.win",
		merge: "chess_void.merge",
		thanks: "chess_void.thanks",
		fish: "chess_void.fish",
	},
	chess_pb: {
		spawn: "chess_pb.spawn",
		win: "chess_pb.win",
		merge: "chess_pb.merge",
		thanks: "chess_pb.thanks",
	},
	chess_db: {
		spawn: "chess_db.spawn",
		win: "chess_db.win",
		merge: "chess_db.merge",
		thanks: "chess_db.thanks",
		tp: "chess_db.tp",
	},
	chess_ts: {
		spawn: "chess_ts.spawn",
		win: "chess_ts.win",
		merge: "chess_ts.merge",
		thanks: "chess_ts.thanks",
		tp: "chess_ts.tp",
	},
	chess_ud: {
		spawn: "chess_ud.spawn",
		win: "chess_ud.win",
		merge: "chess_ud.merge",
		thanks: "chess_ud.thanks",
	},

	chess_mag: {
		spawn: "chess_mag.spawn",
		win: "chess_mag.win",
		merge: "chess_mag.merge",
		thanks: "chess_mag.thanks",
	},
	chess_ct: {
		spawn: "chess_ct.spawn",
		win: "chess_ct.win",
		merge: "chess_ct.merge",
		thanks: "chess_ct.thanks",
	},
	chess_snk: {
		spawn: "chess_snk.spawn",
		win: "chess_snk.win",
		merge: "chess_snk.merge",
		thanks: "chess_snk.thanks",
	},
	chess_clinkz: {
		spawn: "chess_clinkz.spawn",
		win: "chess_clinkz.win",
		merge: "chess_clinkz.merge",
		thanks: "chess_clinkz.thanks",
	},

	chess_muerta: {
		spawn: "chess_muerta.spawn",
		win: "chess_muerta.win",
		merge: "chess_muerta.merge",
		thanks: "chess_muerta.thanks",
	},
	chess_ds: {
		spawn: "chess_ds.spawn",
		win: "chess_ds.win",
		merge: "chess_ds.merge",
		thanks: "chess_ds.thanks",
	},
	chess_sd: {
		spawn: "chess_sd.spawn",
		win: "chess_sd.win",
		merge: "chess_sd.merge",
		thanks: "chess_sd.thanks",
	},
	chess_sm: {
		spawn: "chess_sm.spawn",
		win: "chess_sm.win",
		merge: "chess_sm.merge",
		thanks: "chess_sm.thanks",
	},
	chess_rm: {
		spawn: "chess_rm.spawn",
		win: "chess_rm.win",
		merge: "chess_rm.merge",
		thanks: "chess_rm.thanks",
	},
	chess_bane: {
		spawn: "chess_bane.spawn",
		win: "chess_bane.win",
		merge: "chess_bane.merge",
		thanks: "chess_bane.thanks",
	},
	chess_kez: {
		spawn: "chess_kez.spawn",
		win: "chess_kez.win",
		merge: "chess_kez.merge",
		thanks: "chess_kez.thanks",
	},
	chess_naix: {
		spawn: "chess_naix.spawn",
		win: "chess_naix.win",
		merge: "chess_naix.merge",
		thanks: "chess_naix.thanks",
	},
	chess_au: {
		spawn: "chess_au.spawn",
		win: "chess_au.win",
		merge: "chess_au.merge",
		thanks: "chess_au.thanks",
	},
	chess_largo: {
		spawn: "chess_largo.spawn",
		win: "chess_largo.win",
		merge: "chess_largo.merge",
		thanks: "chess_largo.thanks",
	},
	chess_aa: {
		spawn: "chess_aa.spawn",
		win: "chess_aa.win",
		merge: "chess_aa.merge",
		thanks: "chess_aa.thanks",
	},
	chess_phx: {
		spawn: "chess_phx.spawn",
		win: "chess_phx.win",
		merge: "chess_phx.merge",
		thanks: "chess_phx.thanks",
	},
};

function OnPlayChessDialogue(keys) {
	var unit_name = keys.unit_name;
	// 特殊情况：女敌法
	if (unit_name == 'chess_am'){
		unit_name = 'chess_am_wei';
	}

	if (unit_name.indexOf('11') > -1) {
		unit_name = unit_name.substr(0, unit_name.length - 2);
	}
	if (unit_name.indexOf('1') > -1) {
		unit_name = unit_name.substr(0, unit_name.length - 1);
	}
	var dialogue_type = keys.dialogue_type;
	if (!DIALOGUE_LIST[unit_name]) {
		return;
	}

	var dialogue_name = DIALOGUE_LIST[unit_name][dialogue_type];
	
	if (dialogue_name) {
		if (dialogue_type == 'win') {
			$.Schedule(0.5, function () {
				Game.EmitSound(dialogue_name);
			});
		}
		else {
			Game.EmitSound(dialogue_name);
		}
	}
}
GameEvents.Subscribe("play_chess_dialogue", OnPlayChessDialogue);