--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if ability_special_empty == nil then
	ability_special_empty = class({})
end

local Particles = {
	"particles/units/heroes/hero_ogre_magi/ogre_magi_bloodlust_buff.vpcf",
	"particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf",
	"particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf",
	"particles/units/heroes/hero_omniknight/omniknight_guardian_angel_halo_buff.vpcf",
	"particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_spindle_rig.vpcf",
	"particles/econ/events/ti6/teleport_start_ti6.vpcf",
	"particles/econ/events/ti6/teleport_start_ti6_lvl3_rays.vpcf",
	"particles/econ/items/necrolyte/necro_sullen_harvest/necro_ti7_immortal_scythe_start.vpcf",
	"particles/econ/events/diretide_2020/emblem/fall20_emblem_v1_effect.vpcf",
    "particles/econ/events/diretide_2020/emblem/fall20_emblem_v3_effect.vpcf",
    "particles/econ/events/diretide_2020/emblem/fall20_emblem_v2_effect.vpcf",
    "particles/econ/events/diretide_2020/emblem/fall20_emblem_effect.vpcf",
    "particles/econ/events/plus/high_five/high_five_lvl1_overhead.vpcf",
    "particles/econ/events/plus/high_five/high_five_lvl1_travel.vpcf",
    "particles/econ/events/plus/high_five/high_five_impact.vpcf",
    "particles/leader/leader/leader_overhead.vpcf",
    "particles/econ/courier/courier_babyroshan_ti9/courier_babyroshan_ti9_ambient.vpcf",
    "particles/econ/courier/courier_roshan_darkmoon/courier_roshan_darkmoon.vpcf",
    "particles/econ/courier/courier_roshan_ti8/courier_roshan_ti8.vpcf",
    "particles/econ/world/ancient/radiant_dragon_king_2024/radiant_dragon_king_2024_ambient.vpcf",
    "particles/econ/items/legion/legion_weapon_voth_domosh/legion_duel_ring_arcana.vpcf",
    "particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf",
	"particles/boss_lightning.vpcf",
    "particles/boss_lightning_team.vpcf",
    "particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield.vpcf",
    "particles/units/heroes/hero_phoenix/phoenix_supernova_hit.vpcf",
	"particles/minigames_circle/minigames_circle.vpcf",
    "particles/minigames_circle/minigames_pre_circle.vpcf",
    "particles/econ/wards/f2p/f2p_ward/f2p_ward_true_sight_ambient.vpcf",
	"particles/econ/items/pets/pet_generic/pet_flee.vpcf",
    "particles/econ/items/pets/pet_generic/pet_spawn.vpcf",
    "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation_desolator.vpcf",
    "particles/units/heroes/hero_viper/viper_base_attack.vpcf",
    "particles/units/heroes/hero_phoenix/phoenix_base_attack.vpcf",
    "particles/items2_fx/skadi_projectile.vpcf",
    "particles/units/heroes/hero_void_spirit/base_attack/void_spirit_base_attack.vpcf",
    "particles/units/heroes/hero_windrunner/windrunner_base_attack.vpcf",
    "particles/world_tower/tower_upgrade/ti7_dire_tower_projectile.vpcf",
    "particles/units/heroes/hero_enigma/enigma_base_attack.vpcf",
    "particles/units/heroes/hero_stormspirit/stormspirit_base_attack.vpcf",
    "particles/units/heroes/hero_wisp/wisp_base_attack.vpcf",
    "particles/econ/events/ti10/emblem/ti10_emblem_effect.vpcf",
    "particles/econ/events/ti9/ti9_emblem_effect.vpcf",
    "particles/econ/events/ti8/ti8_hero_effect.vpcf",
    "particles/econ/events/summer_2021/summer_2021_emblem_effect.vpcf",
    "particles/econ/events/fall_2021/fall_2021_emblem_game_effect.vpcf",
    "particles/econ/events/fall_2022/player/fall_2022_emblem_effect_player_base.vpcf",
	"particles/minigames/win_buff_counter/win_buff_counter.vpcf",
}

function ability_special_empty:Precache(context)
	-- print("PRECACHING EMPTY ABILITY")

	for _, p in pairs(Particles) do
        PrecacheResource("particle", p, context)
    end
end