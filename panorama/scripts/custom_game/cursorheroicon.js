--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


// /* 
// 	显示鼠标上悬浮的英雄图标

// 	js调用方法：
// 	// 显示
// 	show_cursor_hero('chess_tusk');  
// 	// 隐藏
// 	hide_cursor_hero();				

// 	lua调用方法：
// 	--显示
// 	CustomGameEventManager:Send_ServerToTeam(caster:GetTeam(),"show_cursor_hero_icon",{
// 		unit = target:GetUnitName()
// 	})
// 	--隐藏
// 	CustomGameEventManager:Send_ServerToTeam(caster:GetTeam(),"show_cursor_hero_icon",{})
// */ 
// const UNIT_2_HERO = {
// 	// 1
// 	chess_tusk: 'npc_dota_hero_tusk',
// 	chess_cm: 'npc_dota_hero_crystal_maiden',
// 	chess_axe: 'npc_dota_hero_axe', 
// 	chess_eh: 'npc_dota_hero_enchantress',
// 	chess_om: 'npc_dota_hero_ogre_magi',
// 	chess_am: 'npc_dota_hero_antimage',
// 	chess_clock: 'npc_dota_hero_rattletrap',
// 	chess_ss: 'npc_dota_hero_shadow_shaman',
// 	chess_ss_ssr: 'npc_dota_hero_shadow_shaman',
// 	chess_bh: 'npc_dota_hero_bounty_hunter',
// 	chess_wd: 'npc_dota_hero_witch_doctor',
// 	// 2
// 	chess_tk: 'npc_dota_hero_tinker',
// 	chess_bm: 'npc_dota_hero_beastmaster',
// 	chess_jugg: 'npc_dota_hero_juggernaut',
// 	chess_lyc: 'npc_dota_hero_lycan',
// 	chess_shredder: 'npc_dota_hero_shredder',
// 	chess_pa: 'npc_dota_hero_phantom_assassin',
// 	chess_puck: 'npc_dota_hero_puck',
// 	chess_slardar: 'npc_dota_hero_slardar',
// 	chess_ck: 'npc_dota_hero_chaos_knight',
// 	// 3
// 	chess_dr: 'npc_dota_hero_drow_ranger',
// 	chess_light: 'npc_dota_hero_keeper_of_the_light',
// 	chess_razor: 'npc_dota_hero_razor',
// 	chess_ok: 'npc_dota_hero_omniknight',
// 	chess_wr: 'npc_dota_hero_windrunner',
// 	chess_sk: 'npc_dota_hero_sand_king',
// 	chess_abaddon: 'npc_dota_hero_abaddon',
// 	chess_slark: 'npc_dota_hero_slark',
// 	chess_sniper: 'npc_dota_hero_sniper',
// 	// 4
// 	chess_kunkka: 'npc_dota_hero_kunkka',
// 	chess_doom: 'npc_dota_hero_doom_bringer',
// 	chess_lina: 'npc_dota_hero_lina',
// 	chess_troll: 'npc_dota_hero_troll_warlord',
// 	chess_veno: 'npc_dota_hero_venomancer',
// 	chess_nec: 'npc_dota_hero_necrolyte',
// 	chess_ta: 'npc_dota_hero_templar_assassin',
// 	// 5
// 	chess_gyro: 'npc_dota_hero_gyrocopter',
// 	chess_lich: 'npc_dota_hero_lich',
// 	chess_qop: 'npc_dota_hero_queenofpain',
// 	chess_th: 'npc_dota_hero_tidehunter',
// 	chess_enigma: 'npc_dota_hero_enigma',
// 	// new
// 	chess_bat: 'npc_dota_hero_batrider',
//     chess_luna: 'npc_dota_hero_luna',
//     chess_tp: 'npc_dota_hero_treant',
//     chess_sf: 'npc_dota_hero_nevermore',
//     chess_dk: 'npc_dota_hero_dragon_knight',
//     chess_viper: 'npc_dota_hero_viper',
//     chess_medusa: 'npc_dota_hero_medusa',
//     chess_disruptor: 'npc_dota_hero_disruptor',
//     chess_ga: 'npc_dota_hero_alchemist',
//     chess_tech: 'npc_dota_hero_techies',
//     //
//     chess_fur: 'npc_dota_hero_furion',
//     chess_ld: 'npc_dota_hero_lone_druid',
//     chess_morph: 'npc_dota_hero_morphling',
//     chess_tb: 'npc_dota_hero_terrorblade',
//     chess_tiny: 'npc_dota_hero_tiny',
//     chess_nec_ssr: 'npc_dota_hero_necrolyte',
//     chess_ck_ssr: 'npc_dota_hero_chaos_knight',
//     //
//     chess_riki: 'npc_dota_hero_riki',
//     chess_dp: 'npc_dota_hero_death_prophet',
//     chess_pom: 'npc_dota_hero_mirana',
//     //
//     chess_zeus: 'npc_dota_hero_zuus',
//     chess_mars: 'npc_dota_hero_mars',
//     chess_dazzle: 'npc_dota_hero_dazzle',
//     chess_io: 'npc_dota_hero_wisp',
//     chess_sven: 'npc_dota_hero_sven',
//     chess_ww: 'npc_dota_hero_winter_wyvern',
//     chess_gs: 'npc_dota_hero_grimstroke',
//     chess_rubick: 'npc_dota_hero_rubick',

//     chess_pudge: 'npc_dota_hero_pudge',
//     chess_visage: 'npc_dota_hero_visage',
//     chess_lion: 'npc_dota_hero_lion',
//     chess_oracle: 'npc_dota_hero_oracle',
//     chess_na: 'npc_dota_hero_nyx_assassin',
//     chess_huskar: 'npc_dota_hero_huskar',
//     chess_bs: 'npc_dota_hero_bloodseeker',
//     chess_mk: 'npc_dota_hero_monkey_king',
//     chess_snap: 'npc_dota_hero_snapfire',
//     chess_br: 'npc_dota_hero_broodmother',
//     chess_kael: 'npc_dota_hero_invoker',
//     chess_lc: 'npc_dota_hero_legion_commander',
//     chess_chen: 'npc_dota_hero_chen',
//     chess_thd: 'npc_dota_hero_jakiro',
//     chess_dw: 'npc_dota_hero_dark_willow',
//     chess_brew: 'npc_dota_hero_brewmaster',
//     chess_storm: 'npc_dota_hero_storm_spirit',
//     chess_ember: 'npc_dota_hero_ember_spirit',
//     chess_earth: 'npc_dota_hero_earth_spirit',
//     chess_brew_ssr: 'npc_dota_hero_brewmaster',
    
//     chess_es: 'npc_dota_hero_earthshaker',
//     chess_sb: 'npc_dota_hero_spirit_breaker',
//     chess_et: 'npc_dota_hero_elder_titan',
//     chess_meepo: 'npc_dota_hero_meepo',
// }
// // var IS_CURSOR_HERO_ICON_SHOWING = false;
// start_cursor_hero_icon();
// (function () {
//     
// })();


// function start_cursor_hero_icon(){
//     var cursor_position = GameUI.GetCursorPosition();
//     $('#cursor_hero_icon').style['position'] = ''+(cursor_position[0]-30)*1920/Game.GetScreenWidth()+'px '+(cursor_position[1]-30)*1080/Game.GetScreenHeight()+'px 0px';
//     $.Schedule(0.01,function(){
//         start_cursor_hero_icon();
//     });
// }