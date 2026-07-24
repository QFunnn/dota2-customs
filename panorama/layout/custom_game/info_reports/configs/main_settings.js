--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var max_games = 5
var new_items =
{
    "npc_dota_hero_furion": true,
	"npc_dota_hero_muerta": true,
    "npc_dota_hero_axe": true,
    "npc_dota_hero_morphling": true,
    "npc_dota_hero_bristleback": true,
    "npc_dota_hero_legion_commander": true,
}
var thresh = [50,60,70,80, 100,120,140,160,180,200, 230,260,290,320,350,380, 420,460,500,540,580,620,680, 800,900,1000,1100,1200, 1500]
var WINDOWS_MAX_COUNTER = 6
var active_shard_sale = false
var active_sub_sale = false
var effects_icons =
{
    emblems : "file://{images}/custom_game/shop/effects/section/effects_emblems.png",
    effect_attack : "file://{images}/custom_game/shop/effects/section/attack.png",
    effect_regeneration : "file://{images}/custom_game/shop/effects/section/regeneration.png",
    effect_teleportation : "file://{images}/custom_game/shop/effects/section/effects_scroll.png",
    effect_blink : "file://{images}/custom_game/shop/effects/section/effects_blink.png",
    effect_eul : "file://{images}/custom_game/shop/effects/section/effects_eul.png",
    effect_force_staff : "file://{images}/custom_game/shop/effects/section/effects_pike.png",
    effect_phase_boots : "file://{images}/custom_game/shop/effects/section/effects_phase.png",
    effect_radiance : "file://{images}/custom_game/shop/effects/section/effects_radiance.png",
    effect_mekansm : "file://{images}/custom_game/shop/effects/section/effects_greaves.png",
    effect_shivas : "file://{images}/custom_game/shop/effects/section/effects_shiva.png",
    effect_mjollnir : "file://{images}/custom_game/shop/effects/section/effects_mjollnir.png",
    effect_dagon : "file://{images}/custom_game/shop/effects/section/dagon.png",
    effect_hex : "file://{images}/custom_game/shop/effects/section/hex.png",
}

var effects_items_icons =
{
    effect_regeneration : [],
    effect_teleportation : ["item_tpscroll_custom"],
    effect_blink : ["item_blink_custom", "item_arcane_blink_custom", "item_swift_blink_custom", "item_overwhelming_blink_custom"],
    effect_eul : ["item_cyclone_custom", "item_wind_waker_custom"],
    effect_force_staff : ["item_force_staff_custom", "item_hurricane_pike_custom", "item_harpoon_custom"],
    effect_phase_boots : ["item_phase_boots_custom"],
    effect_radiance : ["item_radiance_custom"],
    effect_mekansm : ["item_mekansm_custom", "item_guardian_greaves_custom"],
    effect_shivas : ["item_shivas_guard_custom"],
    effect_mjollnir : ["item_mjollnir_custom", "item_maelstrom_custom"],
    effect_dagon : ["item_dagon_custom"],
    effect_attack : [],
    effect_hex : ["item_sheepstick_custom"],
}