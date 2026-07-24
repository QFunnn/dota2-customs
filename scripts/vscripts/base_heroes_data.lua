--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
   ["npc_dota_hero_dragon_knight"] = 
   {
      ["items"] = 
      {
         ["models/heroes/dragon_knight/shoulders.vmdl"] = "true",
         ["models/heroes/dragon_knight/bracers.vmdl"] = "true",
         ["models/heroes/dragon_knight/weapon.vmdl"] = "true",
         ["models/heroes/dragon_knight/shield.vmdl"] = "true",
         ["models/heroes/dragon_knight/skirt.vmdl"] = "true",
         ["models/heroes/dragon_knight/helmet.vmdl"] = "true",
      },
      ["model"] = "models/heroes/dragon_knight/dragon_knight.vmdl",
   },
   ["npc_dota_hero_lycan"] = 
   {
      ["items"] = 
      {
         ["models/heroes/lycan/lycan_armor.vmdl"] = "true",
         ["models/heroes/lycan/lycan_fur.vmdl"] = "true",
         ["models/heroes/lycan/lycan_belt.vmdl"] = "true",
         ["models/heroes/lycan/lycan_blades.vmdl"] = "true",
         ["models/heroes/lycan/lycan_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lycan/lycan.vmdl",
   },
   ["npc_dota_hero_brewmaster"] = 
   {
      ["items"] = 
      {
         ["models/heroes/brewmaster/bracer.vmdl"] = "true",
         ["models/heroes/brewmaster/back.vmdl"] = "true",
         ["models/heroes/brewmaster/shoulder.vmdl"] = "true",
         ["models/heroes/brewmaster/barrel.vmdl"] = "true",
         ["models/heroes/brewmaster/weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/brewmaster/brewmaster.vmdl",
   },
   ["npc_dota_hero_beastmaster"] = 
   {
      ["items"] = 
      {
         ["models/heroes/beastmaster/beastmaster_shoulder.vmdl"] = "true",
         ["models/heroes/beastmaster/beastmaster_arms.vmdl"] = "true",
         ["models/heroes/beastmaster/beastmaster_belt.vmdl"] = "true",
         ["models/heroes/beastmaster/beastmaster_weapon.vmdl"] = "true",
         ["models/heroes/beastmaster/beastmaster_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/beastmaster/beastmaster.vmdl",
   },
   ["npc_dota_hero_meepo"] = 
   {
      ["items"] = 
      {
         ["models/heroes/meepo/bracers.vmdl"] = "true",
         ["models/heroes/meepo/hood.vmdl"] = "true",
         ["models/heroes/meepo/pack.vmdl"] = "true",
         ["models/heroes/meepo/shoulders.vmdl"] = "true",
         ["models/heroes/meepo/tail.vmdl"] = "true",
         ["models/heroes/meepo/meepo_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/meepo/meepo.vmdl",
   },
   ["npc_dota_hero_ringmaster"] = 
   {
      ["items"] = 
      {
         ["models/heroes/ringmaster/ringmaster_head.vmdl"] = "true",
         ["models/heroes/ringmaster/ringmaster_belt.vmdl"] = "true",
         ["models/heroes/ringmaster/ringmaster_armor.vmdl"] = "true",
         ["models/heroes/ringmaster/ringmaster_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/ringmaster/ringmaster_base.vmdl",
   },
   ["npc_dota_hero_lion"] = 
   {
      ["items"] = 
      {
         ["models/heroes/lion/lion_shoulder.vmdl"] = "true",
         ["models/heroes/lion/lion_demonarm.vmdl"] = "true",
         ["models/heroes/lion/lion_weapon.vmdl"] = "true",
         ["models/heroes/lion/lion_cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lion/lion.vmdl",
   },
   ["npc_dota_hero_chaos_knight"] = 
   {
      ["items"] = 
      {
         ["models/heroes/chaos_knight/chaos_knight_shield.vmdl"] = "true",
         ["models/heroes/chaos_knight/chaos_knight_mount.vmdl"] = "true",
         ["models/heroes/chaos_knight/chaos_knight_shoulderpads.vmdl"] = "true",
         ["models/heroes/chaos_knight/chaos_knight_helmet.vmdl"] = "true",
         ["models/heroes/chaos_knight/chaos_knight_mace.vmdl"] = "true",
      },
      ["model"] = "models/heroes/chaos_knight/chaos_knight.vmdl",
   },
   ["npc_dota_hero_kunkka"] = 
   {
      ["items"] = 
      {
         ["models/heroes/kunkka/kunkka_sword.vmdl"] = "true",
         ["models/heroes/kunkka/kunkka_spyglass.vmdl"] = "true",
         ["models/heroes/kunkka/kunkka_shoulders.vmdl"] = "true",
         ["models/heroes/kunkka/kunkka_feet.vmdl"] = "true",
         ["models/heroes/kunkka/kunkka_hair.vmdl"] = "true",
         ["models/heroes/kunkka/kunkka_hands.vmdl"] = "true",
      },
      ["model"] = "models/heroes/kunkka/kunkka.vmdl",
   },
   ["npc_dota_hero_templar_assassin"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_templar_assassin/templar_assassin_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_eyeL",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_eyeR",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/lanaya/lanaya_cowl_shoulder.vmdl"] = "true",
         ["models/heroes/lanaya/lanaya_bracers_skirt.vmdl"] = "true",
         ["models/heroes/lanaya/lanaya_hair.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lanaya/lanaya.vmdl",
   },
   ["npc_dota_hero_mars"] = 
   {
      ["items"] = 
      {
         ["models/heroes/mars/mars_spear.vmdl"] = "true",
         ["models/heroes/mars/mars_upper.vmdl"] = "true",
         ["models/heroes/mars/mars_lower.vmdl"] = "true",
         ["models/heroes/mars/mars_shield.vmdl"] = "true",
      },
      ["model"] = "models/heroes/mars/mars.vmdl",
   },
   ["npc_dota_hero_ember_spirit"] = 
   {
      ["items"] = 
      {
         ["models/heroes/ember_spirit/weapon2.vmdl"] = "true",
         ["models/heroes/ember_spirit/arm.vmdl"] = "true",
         ["models/heroes/ember_spirit/back.vmdl"] = "true",
         ["models/heroes/ember_spirit/shoulder.vmdl"] = "true",
         ["models/heroes/ember_spirit/belt.vmdl"] = "true",
         ["models/heroes/ember_spirit/weapon1.vmdl"] = "true",
      },
      ["model"] = "models/heroes/ember_spirit/ember_spirit.vmdl",
   },
   ["npc_dota_hero_marci"] = 
   {
      ["items"] = 
      {
         ["models/heroes/marci/marci_shoulders.vmdl"] = "true",
         ["models/heroes/marci/marci_head.vmdl"] = "true",
         ["models/heroes/marci/marci_back.vmdl"] = "true",
         ["models/heroes/marci/marci_costume.vmdl"] = "true",
      },
      ["model"] = "models/heroes/marci/marci_base.vmdl",
   },
   ["npc_dota_hero_sand_king"] = 
   {
      ["items"] = 
      {
         ["models/heroes/sand_king/sand_king_arms.vmdl"] = "true",
         ["models/heroes/sand_king/sand_king_tail.vmdl"] = "true",
         ["models/heroes/sand_king/sand_king_shoulder.vmdl"] = "true",
         ["models/heroes/sand_king/sand_king_legs.vmdl"] = "true",
         ["models/heroes/sand_king/sand_king_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/sand_king/sand_king.vmdl",
   },
   ["npc_dota_hero_enigma"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_enigma/enigma_ambient_eyes.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_eyes",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_enigma/enigma_ambient_body.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["model"] = "models/heroes/enigma/enigma.vmdl",
   },
   ["npc_dota_hero_clinkz"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_clinkz/clinkz_body_fire.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/clinkz/clinkz_back.vmdl"] = "true",
         ["models/heroes/clinkz/clinkz_gloves.vmdl"] = "true",
         ["models/heroes/clinkz/clinkz_head.vmdl"] = "true",
         ["models/heroes/clinkz/clinkz_bow.vmdl"] = "true",
         ["models/heroes/clinkz/clinkz_pads.vmdl"] = "true",
         ["models/heroes/clinkz/clinkz_horns.vmdl"] = "true",
      },
      ["model"] = "models/heroes/clinkz/clinkz.vmdl",
   },
   ["npc_dota_hero_bristleback"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_bristleback/bristleback_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_weapon",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/bristleback/bristleback_necklace.vmdl"] = "true",
         ["models/heroes/bristleback/bristleback_back.vmdl"] = "true",
         ["models/heroes/bristleback/bristleback_head.vmdl"] = "true",
         ["models/heroes/bristleback/bristleback_weapon.vmdl"] = "true",
         ["models/heroes/bristleback/bristleback_bracer.vmdl"] = "true",
      },
      ["model"] = "models/heroes/bristleback/bristleback.vmdl",
   },
   ["npc_dota_hero_puck"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_puck/puck_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/puck/puck_tail.vmdl"] = "true",
         ["models/heroes/puck/puck_wings.vmdl"] = "true",
         ["models/heroes/puck/puck_horns.vmdl"] = "true",
      },
      ["model"] = "models/heroes/puck/puck.vmdl",
   },
   ["npc_dota_hero_hoodwink"] = 
   {
      ["items"] = 
      {
         ["models/heroes/hoodwink/hoodwink_crossbow.vmdl"] = "true",
         ["models/heroes/hoodwink/hoodwink_hood.vmdl"] = "true",
         ["models/heroes/hoodwink/hoodwink_tail.vmdl"] = "true",
         ["models/heroes/hoodwink/hoodwink_costume.vmdl"] = "true",
      },
      ["model"] = "models/heroes/hoodwink/hoodwink.vmdl",
   },
   ["npc_dota_hero_alchemist"] = 
   {
      ["items"] = 
      {
         ["models/heroes/alchemist/alchemist_goblinhat.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_ogre_head.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_scabbard.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_gauntlets.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_leftbottle.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_goblin_head.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_shoulderbottles.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_goblin_body.vmdl"] = "true",
         ["models/heroes/alchemist/alchemist_saddlehat.vmdl"] = "true",
      },
      ["model"] = "models/heroes/alchemist/alchemist.vmdl",
   },
   ["npc_dota_hero_primal_beast"] = 
   {
      ["items"] = 
      {
         ["models/heroes/primal_beast/primal_beast_back.vmdl"] = "true",
         ["models/heroes/primal_beast/primal_beast_leg.vmdl"] = "true",
         ["models/heroes/primal_beast/primal_beast_armor.vmdl"] = "true",
      },
      ["model"] = "models/heroes/primal_beast/primal_beast_base.vmdl",
   },
   ["npc_dota_hero_bloodseeker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/blood_seeker/cape.vmdl"] = "true",
         ["models/heroes/blood_seeker/weapon.vmdl"] = "true",
         ["models/heroes/blood_seeker/weapon_offhand.vmdl"] = "true",
         ["models/heroes/blood_seeker/neck.vmdl"] = "true",
         ["models/heroes/blood_seeker/bracer.vmdl"] = "true",
         ["models/heroes/blood_seeker/helmet.vmdl"] = "true",
         ["models/heroes/blood_seeker/belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/blood_seeker/blood_seeker.vmdl",
   },
   ["npc_dota_hero_leshrac"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_leshrac/leshrac_ambient_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/leshrac/leshrac_armor.vmdl"] = "true",
         ["models/heroes/leshrac/leshrac_head.vmdl"] = "true",
         ["models/heroes/leshrac/leshrac_tail.vmdl"] = "true",
      },
      ["model"] = "models/heroes/leshrac/leshrac.vmdl",
   },
   ["npc_dota_hero_snapfire"] = 
   {
      ["items"] = 
      {
         ["models/heroes/snapfire/snapfire_weapon.vmdl"] = "true",
         ["models/heroes/snapfire/snapfire_hair.vmdl"] = "true",
         ["models/heroes/snapfire/snapfire_body.vmdl"] = "true",
         ["models/heroes/snapfire/snapfire_armor.vmdl"] = "true",
         ["models/heroes/snapfire/snapfire_mount.vmdl"] = "true",
      },
      ["model"] = "models/heroes/snapfire/snapfire.vmdl",
   },
   ["npc_dota_hero_sven"] = 
   {
      ["items"] = 
      {
         ["models/heroes/sven/sven_gauntlet.vmdl"] = "true",
         ["models/heroes/sven/sven_belt.vmdl"] = "true",
         ["models/heroes/sven/sven_mask.vmdl"] = "true",
         ["models/heroes/sven/sven_sword.vmdl"] = "true",
         ["models/heroes/sven/sven_shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/sven/sven.vmdl",
   },
   ["npc_dota_hero_sniper"] = 
   {
      ["items"] = 
      {
         ["models/heroes/sniper/cape.vmdl"] = "true",
         ["models/heroes/sniper/headitem.vmdl"] = "true",
         ["models/heroes/sniper/shoulder.vmdl"] = "true",
         ["models/heroes/sniper/bracer.vmdl"] = "true",
         ["models/heroes/sniper/weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/sniper/sniper.vmdl",
   },
   ["npc_dota_hero_shredder"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_shredder/shredder_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_chimmney",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_armor",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_saw",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/shredder/shredder_armor.vmdl"] = "true",
         ["models/heroes/shredder/shredder_hook.vmdl"] = "true",
         ["models/heroes/shredder/shredder_shoulders.vmdl"] = "true",
         ["models/heroes/shredder/shredder_chainsaw.vmdl"] = "true",
         ["models/heroes/shredder/shredder_body.vmdl"] = "true",
         ["models/heroes/shredder/shredder_driver_hat.vmdl"] = "true",
         ["models/heroes/shredder/shredder_blade.vmdl"] = "true",
      },
      ["model"] = "models/heroes/shredder/shredder.vmdl",
   },
   ["npc_dota_hero_treant"] = 
   {
      ["items"] = 
      {
         ["models/heroes/treant_protector/legs.vmdl"] = "true",
         ["models/heroes/treant_protector/head.vmdl"] = "true",
         ["models/heroes/treant_protector/foliage.vmdl"] = "true",
         ["models/heroes/treant_protector/hands.vmdl"] = "true",
      },
      ["model"] = "models/heroes/treant_protector/treant_protector.vmdl",
   },
   ["npc_dota_hero_undying"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_undying/undying_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/undying/undying_helmet.vmdl"] = "true",
         ["models/heroes/undying/undying_armor.vmdl"] = "true",
         ["models/heroes/undying/mesh/undying_arm.vmdl"] = "true",
      },
      ["model"] = "models/heroes/undying/undying.vmdl",
   },
   ["npc_dota_hero_vengefulspirit"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_vengeful/vengeful_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_uppertorso",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/vengeful/vengeful_upperbody.vmdl"] = "true",
         ["models/heroes/vengeful/vengeful_lowerbody.vmdl"] = "true",
         ["models/heroes/vengeful/vengeful_hair.vmdl"] = "true",
         ["models/heroes/vengeful/vengeful_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/vengeful/vengeful.vmdl",
   },
   ["npc_dota_hero_weaver"] = 
   {
      ["items"] = 
      {
         ["models/heroes/weaver/weaver_antlers.vmdl"] = "true",
         ["models/heroes/weaver/weaver_legs.vmdl"] = "true",
         ["models/heroes/weaver/weaver_head.vmdl"] = "true",
         ["models/heroes/weaver/weaver_arms.vmdl"] = "true",
      },
      ["model"] = "models/heroes/weaver/weaver.vmdl",
   },
   ["npc_dota_hero_windrunner"] = 
   {
      ["items"] = 
      {
         ["models/heroes/windrunner/windrunner_quiver.vmdl"] = "true",
         ["models/heroes/windrunner/windrunner_shoulderpads.vmdl"] = "true",
         ["models/heroes/windrunner/windrunner_head.vmdl"] = "true",
         ["models/heroes/windrunner/windrunner_bow.vmdl"] = "true",
         ["models/heroes/windrunner/windrunner_cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/windrunner/windrunner.vmdl",
   },
   ["npc_dota_hero_centaur"] = 
   {
      ["items"] = 
      {
         ["models/heroes/centaur/belt.vmdl"] = "true",
         ["models/heroes/centaur/weapon.vmdl"] = "true",
         ["models/heroes/centaur/tail.vmdl"] = "true",
         ["models/heroes/centaur/bracer.vmdl"] = "true",
         ["models/heroes/centaur/headitem.vmdl"] = "true",
         ["models/heroes/centaur/shield.vmdl"] = "true",
         ["models/heroes/centaur/shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/centaur/centaur.vmdl",
   },
   ["npc_dota_hero_jakiro"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_jakiro/jakiro_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_ice_eye_l",
                  ["attach_type"] = "point_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "6",
                  ["attachment"] = "attach_fire_eye_l",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "attach_fire_eye_r",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_ice_eye_r",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["model"] = "models/heroes/jakiro/jakiro.vmdl",
      ["items"] = 
      {
         ["models/heroes/jakiro/jakiro_wings.vmdl"] = "true",
      },
   },
   ["npc_dota_hero_shadow_demon"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_shadow_demon/shadow_demon_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "eye_R",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "eye_L",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/shadow_demon/shadow_demon_cape.vmdl"] = "true",
         ["models/heroes/shadow_demon/shadow_demon_chain.vmdl"] = "true",
         ["models/heroes/shadow_demon/shadow_demon_belt.vmdl"] = "true",
         ["models/heroes/shadow_demon/shadow_demon_tail.vmdl"] = "true",
      },
      ["model"] = "models/heroes/shadow_demon/shadow_demon.vmdl",
   },
   ["npc_dota_hero_phoenix"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_phoenix/phoenix_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_spine2",
                  ["attach_type"] = "point_follow",
               },
               ["6"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "6",
                  ["attachment"] = "attach_wingtipL",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "attach_wingtipR",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_tailbase",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_neck",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/phoenix/phoenix_bird_head.vmdl"] = "true",
         ["models/heroes/phoenix/phoenix_wings.vmdl"] = "true",
      },
      ["model"] = "models/heroes/phoenix/phoenix_bird.vmdl",
   },
   ["npc_dota_hero_abyssal_underlord"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/heroes_underlord/underlord_ambient_eyes.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_eye_r",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_eye_l",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/abyssal_underlord/mesh/underlord_head.vmdl"] = "true",
         ["models/heroes/abyssal_underlord/mesh/underlord_headitem.vmdl"] = "true",
         ["models/heroes/abyssal_underlord/mesh/underlord_armor.vmdl"] = "true",
         ["models/heroes/abyssal_underlord/mesh/underlord_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/abyssal_underlord/abyssal_underlord_v2.vmdl",
   },
   ["npc_dota_hero_dark_willow"] = 
   {
      ["effects"] = 
      {
      },
      ["items"] = 
      {
         ["models/heroes/dark_willow/dark_willow_head.vmdl"] = "true",
         ["models/heroes/dark_willow/dark_willow_armor.vmdl"] = "true",
         ["models/heroes/dark_willow/dark_willow_wings.vmdl"] = "true",
         ["models/heroes/dark_willow/dark_willow_chakram.vmdl"] = "true",
         ["models/heroes/dark_willow/dark_willow_offhand.vmdl"] = "true",
      },
      ["model"] = "models/heroes/dark_willow/dark_willow.vmdl",
   },
   ["npc_dota_hero_grimstroke"] = 
   {
      ["items"] = 
      {
         ["models/heroes/grimstroke/grimstroke_armor.vmdl"] = "true",
         ["models/heroes/grimstroke/grimstroke_skirt.vmdl"] = "true",
         ["models/heroes/grimstroke/grimstroke_weapon.vmdl"] = "true",
         ["models/heroes/grimstroke/grimstroke_head_item.vmdl"] = "true",
      },
      ["model"] = "models/heroes/grimstroke/grimstroke.vmdl",
   },
   ["npc_dota_hero_dazzle"] = 
   {
      ["items"] = 
      {
         ["models/heroes/dazzle/dazzle_mohawk.vmdl"] = "true",
         ["models/heroes/dazzle/dazzle_sleeve.vmdl"] = "true",
         ["models/heroes/dazzle/dazzle_staff.vmdl"] = "true",
         ["models/heroes/dazzle/dazzle_shoulder.vmdl"] = "true",
         ["models/heroes/dazzle/dazzle_dress.vmdl"] = "true",
      },
      ["model"] = "models/heroes/dazzle/dazzle.vmdl",
   },
   ["npc_dota_hero_elder_titan"] = 
   {
      ["items"] = 
      {
         ["models/heroes/elder_titan/elder_titan_bracer.vmdl"] = "true",
         ["models/heroes/elder_titan/elder_titan_totem.vmdl"] = "true",
         ["models/heroes/elder_titan/elder_titan_hammer.vmdl"] = "true",
         ["models/heroes/elder_titan/elder_titan_hair.vmdl"] = "true",
         ["models/heroes/elder_titan/elder_titan_shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/elder_titan/elder_titan.vmdl",
   },
   ["npc_dota_hero_disruptor"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_disruptor/disruptor_ambient_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "left_elec",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "right_elec",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/disruptor/mount.vmdl"] = "true",
         ["models/heroes/disruptor/weapon.vmdl"] = "true",
         ["models/heroes/disruptor/shoulder.vmdl"] = "true",
         ["models/heroes/disruptor/hair.vmdl"] = "true",
         ["models/heroes/disruptor/bracers.vmdl"] = "true",
         ["models/heroes/disruptor/back.vmdl"] = "true",
      },
      ["model"] = "models/heroes/disruptor/disruptor.vmdl",
   },
   ["npc_dota_hero_necrolyte"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_necrolyte/necrolyte_ambient_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["model"] = "models/heroes/necrolyte/necrolyte.vmdl",
      ["items"] = 
      {
         ["models/heroes/necrolyte/hat.vmdl"] = "true",
         ["models/heroes/necrolyte/legs.vmdl"] = "true",
         ["models/heroes/necrolyte/necrolyte_sickle.vmdl"] = "true",
         ["models/heroes/necrolyte/beard.vmdl"] = "true",
         ["models/heroes/necrolyte/shoulders.vmdl"] = "true",
      },
   },
   ["npc_dota_hero_omniknight"] = 
   {
      ["items"] = 
      {
         ["models/heroes/omniknight/cape.vmdl"] = "true",
         ["models/heroes/omniknight/hair.vmdl"] = "true",
         ["models/heroes/omniknight/bracer.vmdl"] = "true",
         ["models/heroes/omniknight/hammer.vmdl"] = "true",
         ["models/heroes/omniknight/head.vmdl"] = "true",
         ["models/heroes/omniknight/shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/omniknight/omniknight.vmdl",
   },
   ["npc_dota_hero_pugna"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_pugna/pugna_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_belly",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_neck",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_pugna/pugna_weapon_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/pugna/pugna_belt.vmdl"] = "true",
         ["models/heroes/pugna/pugna_shoulder.vmdl"] = "true",
         ["models/heroes/pugna/pugna_head.vmdl"] = "true",
         ["models/heroes/pugna/pugna_cape.vmdl"] = "true",
         ["models/heroes/pugna/pugna_bracers.vmdl"] = "true",
         ["models/heroes/pugna/pugna_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/pugna/pugna.vmdl",
   },
   ["npc_dota_hero_shadow_shaman"] = 
   {
      ["items"] = 
      {
         ["models/heroes/shadowshaman/helmet.vmdl"] = "true",
         ["models/heroes/shadowshaman/armarmor.vmdl"] = "true",
         ["models/heroes/shadowshaman/weapon_offhand.vmdl"] = "true",
         ["models/heroes/shadowshaman/head.vmdl"] = "true",
         ["models/heroes/shadowshaman/weapon.vmdl"] = "true",
         ["models/heroes/shadowshaman/belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/shadowshaman/shadowshaman.vmdl",
   },
   ["npc_dota_hero_silencer"] = 
   {
      ["items"] = 
      {
         ["models/heroes/silencer/silencer_shield.vmdl"] = "true",
         ["models/heroes/silencer/silencer_weapon.vmdl"] = "true",
         ["models/heroes/silencer/silender_bracers.vmdl"] = "true",
         ["models/heroes/silencer/silencer_helmet.vmdl"] = "true",
         ["models/heroes/silencer/silencer_shoulder.vmdl"] = "true",
         ["models/heroes/silencer/silencer_robe.vmdl"] = "true",
      },
      ["model"] = "models/heroes/silencer/silencer.vmdl",
   },
   ["npc_dota_hero_spectre"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_spectre/spectre_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/spectre/spectre_weapon.vmdl"] = "true",
         ["models/heroes/spectre/spectre_hat.vmdl"] = "true",
         ["models/heroes/spectre/spectre_dress.vmdl"] = "true",
         ["models/heroes/spectre/spectre_wings.vmdl"] = "true",
      },
      ["model"] = "models/heroes/spectre/spectre.vmdl",
   },
   ["npc_dota_hero_spirit_breaker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/spirit_breaker/spirit_breaker_bracers.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_tail.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_head.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_horns.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_shoulders.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_weapon.vmdl"] = "true",
         ["models/heroes/spirit_breaker/spirit_breaker_lower_armor.vmdl"] = "true",
      },
      ["model"] = "models/heroes/spirit_breaker/spirit_breaker.vmdl",
   },
   ["npc_dota_hero_ursa"] = 
   {
      ["items"] = 
      {
         ["models/heroes/ursa/skirt.vmdl"] = "true",
         ["models/heroes/ursa/helmet.vmdl"] = "true",
         ["models/heroes/ursa/fur.vmdl"] = "true",
         ["models/heroes/ursa/bracers.vmdl"] = "true",
      },
      ["model"] = "models/heroes/ursa/ursa.vmdl",
   },
   ["npc_dota_hero_venomancer"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_venomancer/veno_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_mouth",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/venomancer/venomancer_tail.vmdl"] = "true",
         ["models/heroes/venomancer/venomancer_jaw.vmdl"] = "true",
         ["models/heroes/venomancer/venomancer_shoulder.vmdl"] = "true",
         ["models/heroes/venomancer/venomancer_arms.vmdl"] = "true",
      },
      ["model"] = "models/heroes/venomancer/venomancer.vmdl",
   },
   ["npc_dota_hero_viper"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_viper/viper_ambient_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/viper/viper_back.vmdl"] = "true",
      },
      ["model"] = "models/heroes/viper/viper.vmdl",
   },
   ["npc_dota_hero_visage"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_visage/visage_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_wingL0",
                  ["attach_type"] = "point_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "attach_wingR1",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_wingL1",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_wingR0",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/visage/visage_armor.vmdl"] = "true",
         ["models/heroes/visage/visage_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/visage/visage.vmdl",
   },
   ["npc_dota_hero_night_stalker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/nightstalker/nightstalker_legarmor.vmdl"] = "true",
         ["models/heroes/nightstalker/nightstalker_tail.vmdl"] = "true",
         ["models/heroes/nightstalker/nightstalker_wings.vmdl"] = "true",
      },
      ["model"] = "models/heroes/nightstalker/nightstalker.vmdl",
   },
   ["npc_dota_hero_target_dummy"] = 
   {
      ["model"] = "models/props_gameplay/dummy/dummy_large.vmdl",
   },
   ["npc_dota_hero_obsidian_destroyer"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_obsidian_destroyer/obsidian_destroyer_staff.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/obsidian_destroyer/obsidian_destroyer_wings.vmdl"] = "true",
         ["models/heroes/obsidian_destroyer/obsidian_destroyer_head.vmdl"] = "true",
         ["models/heroes/obsidian_destroyer/obsidian_destroyer_horns.vmdl"] = "true",
         ["models/heroes/obsidian_destroyer/obsidian_destroyer_rocks.vmdl"] = "true",
         ["models/heroes/obsidian_destroyer/obsidian_destroyer_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/obsidian_destroyer/obsidian_destroyer.vmdl",
   },
   ["npc_dota_hero_luna"] = 
   {
      ["items"] = 
      {
         ["models/heroes/luna/luna_shield.vmdl"] = "true",
         ["models/heroes/luna/luna_weapon.vmdl"] = "true",
         ["models/heroes/luna/luna_helmet.vmdl"] = "true",
         ["models/heroes/luna/luna_shoulder.vmdl"] = "true",
         ["models/heroes/luna/luna_mount.vmdl"] = "true",
         ["models/heroes/luna/luna_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/luna/luna.vmdl",
   },
   ["npc_dota_hero_bounty_hunter"] = 
   {
      ["items"] = 
      {
         ["models/heroes/bounty_hunter/bounty_hunter_lweapon.vmdl"] = "true",
         ["models/heroes/bounty_hunter/bounty_hunter_pads.vmdl"] = "true",
         ["models/heroes/bounty_hunter/bounty_hunter_rweapon.vmdl"] = "true",
         ["models/heroes/bounty_hunter/bounty_hunter_backpack.vmdl"] = "true",
         ["models/heroes/bounty_hunter/bounty_hunter_bandana.vmdl"] = "true",
         ["models/heroes/bounty_hunter/bounty_hunter_bweapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/bounty_hunter/bounty_hunter.vmdl",
   },
   ["npc_dota_hero_lone_druid"] = 
   {
      ["items"] = 
      {
         ["models/heroes/lone_druid/body.vmdl"] = "true",
         ["models/heroes/lone_druid/head.vmdl"] = "true",
         ["models/heroes/lone_druid/weapon.vmdl"] = "true",
         ["models/heroes/lone_druid/shoulder.vmdl"] = "true",
         ["models/heroes/lone_druid/arms.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lone_druid/lone_druid.vmdl",
   },
   ["npc_dota_hero_medusa"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_medusa/medusa_bow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_bow_top",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_bow_mid",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_bow_bottom",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/medusa/medusa_torso.vmdl"] = "true",
         ["models/heroes/medusa/medusa_arms.vmdl"] = "true",
         ["models/heroes/medusa/medusa_tail.vmdl"] = "true",
         ["models/heroes/medusa/medusa_bow.vmdl"] = "true",
         ["models/heroes/medusa/medusa_veil.vmdl"] = "true",
      },
      ["model"] = "models/heroes/medusa/medusa.vmdl",
   },
   ["npc_dota_hero_tinker"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_tinker/tinker_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_ambient",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/tinker/tinker_left_arm.vmdl"] = "true",
         ["models/heroes/tinker/tinker_shoulders.vmdl"] = "true",
         ["models/heroes/tinker/tinker_helmet.vmdl"] = "true",
         ["models/heroes/tinker/tinker_body_head.vmdl"] = "true",
         ["models/heroes/tinker/tinker_cape.vmdl"] = "true",
         ["models/heroes/tinker/tinker_right_arm.vmdl"] = "true",
      },
      ["model"] = "models/heroes/tinker/tinker.vmdl",
   },
   ["npc_dota_hero_rubick"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_rubick/rubick_staff_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_staff_ambient",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/rubick/rubick_staff.vmdl"] = "true",
         ["models/heroes/rubick/shoulder.vmdl"] = "true",
         ["models/heroes/rubick/rubick_head.vmdl"] = "true",
         ["models/heroes/rubick/cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/rubick/rubick.vmdl",
   },
   ["npc_dota_hero_warlock"] = 
   {
      ["items"] = 
      {
         ["models/heroes/warlock/warlock_cape.vmdl"] = "true",
         ["models/heroes/warlock/warlock_bracers.vmdl"] = "true",
         ["models/heroes/warlock/warlock_robe.vmdl"] = "true",
         ["models/heroes/warlock/warlock_bag.vmdl"] = "true",
         ["models/heroes/warlock/warlock_shoulder.vmdl"] = "true",
         ["models/heroes/warlock/warlock_staff.vmdl"] = "true",
         ["models/heroes/warlock/warlock_lantern.vmdl"] = "true",
      },
      ["model"] = "models/heroes/warlock/warlock.vmdl",
   },
   ["npc_dota_hero_winter_wyvern"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_winter_wyvern/wyvern_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_eye_r",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_eye_l",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["model"] = "models/heroes/winterwyvern/winterwyvern.vmdl",
      ["items"] = 
      {
         ["models/heroes/winterwyvern/winterwyvern_backitem.vmdl"] = "true",
         ["models/heroes/winterwyvern/winterwyvern_crown.vmdl"] = "true",
      },
   },
   ["npc_dota_hero_techies"] = 
   {
      ["items"] = 
      {
         ["models/heroes/techies/techies_squee_costume.vmdl"] = "true",
         ["models/heroes/techies/techies_cart.vmdl"] = "true",
         ["models/heroes/techies/techies_spleen_costume.vmdl"] = "true",
         ["models/heroes/techies/techies_barrel.vmdl"] = "true",
         ["models/heroes/techies/techies_spleen_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/techies/techies.vmdl",
   },
   ["npc_dota_hero_tidehunter"] = 
   {
      ["items"] = 
      {
         ["models/heroes/tidehunter/tidehunter_anchor.vmdl"] = "true",
         ["models/heroes/tidehunter/tidehunter_fish.vmdl"] = "true",
         ["models/heroes/tidehunter/tidehunter_belt.vmdl"] = "true",
         ["models/heroes/tidehunter/tidehunter_bracer.vmdl"] = "true",
      },
      ["model"] = "models/heroes/tidehunter/tidehunter.vmdl",
   },
   ["npc_dota_hero_naga_siren"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_siren/siren_ambient_lamp.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_lamp",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_siren/siren_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/siren/siren_weapon_offhand.vmdl"] = "true",
         ["models/heroes/siren/siren_hair.vmdl"] = "true",
         ["models/heroes/siren/siren_weapon.vmdl"] = "true",
         ["models/heroes/siren/siren_tail.vmdl"] = "true",
         ["models/heroes/siren/siren_armor.vmdl"] = "true",
      },
      ["model"] = "models/heroes/siren/siren.vmdl",
   },
   ["npc_dota_hero_juggernaut"] = 
   {
      ["items"] = 
      {
         ["models/heroes/juggernaut/juggernaut_pants.vmdl"] = "true",
         ["models/heroes/juggernaut/jugg_cape.vmdl"] = "true",
         ["models/heroes/juggernaut/jugg_bracers.vmdl"] = "true",
         ["models/heroes/juggernaut/jugg_mask.vmdl"] = "true",
         ["models/heroes/juggernaut/jugg_sword.vmdl"] = "true",
      },
      ["model"] = "models/heroes/juggernaut/juggernaut.vmdl",
   },
   ["npc_dota_hero_earth_spirit"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_earth_spirit/espirit_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/earth_spirit/earth_spirit_torso.vmdl"] = "true",
         ["models/heroes/earth_spirit/earth_spirit_arms.vmdl"] = "true",
         ["models/heroes/earth_spirit/earth_spirit_head.vmdl"] = "true",
         ["models/heroes/earth_spirit/earth_spirit_belt.vmdl"] = "true",
         ["models/heroes/earth_spirit/earth_spirit_staff.vmdl"] = "true",
         ["models/heroes/earth_spirit/earth_spirit_hair.vmdl"] = "true",
      },
      ["model"] = "models/heroes/earth_spirit/earth_spirit.vmdl",
   },
   ["npc_dota_hero_phantom_assassin"] = 
   {
      ["items"] = 
      {
         ["models/heroes/phantom_assassin/phantom_assassin_shoulders.vmdl"] = "true",
         ["models/heroes/phantom_assassin/phantom_assassin_weapon.vmdl"] = "true",
         ["models/heroes/phantom_assassin/phantom_assassin_daggers.vmdl"] = "true",
         ["models/heroes/phantom_assassin/phantom_assassin_cape.vmdl"] = "true",
         ["models/heroes/phantom_assassin/phantom_assassin_helmet.vmdl"] = "true",
      },
      ["model"] = "models/heroes/phantom_assassin/phantom_assassin.vmdl",
   },
   ["npc_dota_hero_batrider"] = 
   {
      ["items"] = 
      {
         ["models/heroes/batrider/batrider_mount.vmdl"] = "true",
         ["models/heroes/batrider/batrider_head.vmdl"] = "true",
         ["models/heroes/batrider/batrider_cloak.vmdl"] = "true",
         ["models/heroes/batrider/batrider_belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/batrider/batrider.vmdl",
   },
   ["npc_dota_hero_huskar"] = 
   {
      ["items"] = 
      {
         ["models/heroes/huskar/huskar_spear.vmdl"] = "true",
         ["models/heroes/huskar/huskar_bracer.vmdl"] = "true",
         ["models/heroes/huskar/huskar_dagger.vmdl"] = "true",
         ["models/heroes/huskar/huskar_helmet.vmdl"] = "true",
         ["models/heroes/huskar/huskar_shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/huskar/huskar.vmdl",
   },
   ["npc_dota_hero_kez"] = 
   {
      ["items"] = 
      {
         ["models/heroes/kez/kez_head.vmdl"] = "true",
         ["models/heroes/kez/kez_weapon.vmdl"] = "true",
         ["models/heroes/kez/kez_shoulder.vmdl"] = "true",
         ["models/heroes/kez/kez_belt.vmdl"] = "true",
         ["models/heroes/kez/kez_offhand.vmdl"] = "true",
      },
      ["model"] = "models/heroes/kez/kez_base.vmdl",
   },
   ["npc_dota_hero_razor"] = 
   {
      ["effects"] = 
      {
         ["particles/razor_custom/razor_whip.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_whip2",
                  ["attach_type"] = "point_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "attach_whip5",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_whip",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_whip4",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_whip3",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_whip1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/razor_custom/razor_ambient_main.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "energyCore",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/razor_custom/razor_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "energyCore",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "4",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/razor/razor_armor.vmdl"] = "true",
         ["models/heroes/razor/razor_bracers.vmdl"] = "true",
         ["models/heroes/razor/razor_head.vmdl"] = "true",
         ["models/heroes/razor/razor_weapon.vmdl"] = "true",
         ["models/heroes/razor/razor_robe.vmdl"] = "true",
      },
      ["model"] = "models/heroes/razor/razor.vmdl",
   },
   ["npc_dota_hero_chen"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_chen/chen_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/chen/shoulders.vmdl"] = "true",
         ["models/heroes/chen/weapon.vmdl"] = "true",
         ["models/heroes/chen/mount.vmdl"] = "true",
         ["models/heroes/chen/helmet.vmdl"] = "true",
         ["models/heroes/chen/bracers.vmdl"] = "true",
      },
      ["model"] = "models/heroes/chen/chen.vmdl",
   },
   ["npc_dota_hero_nevermore"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_nevermore/nevermore_trail.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
         ["particles/units/heroes/hero_nevermore/nevermore_ambient_glow.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/shadow_fiend/shadow_fiend_arms.vmdl"] = "true",
         ["models/heroes/shadow_fiend/shadow_fiend_head.vmdl"] = "true",
         ["models/heroes/shadow_fiend/shadow_fiend_shoulders.vmdl"] = "true",
      },
      ["model"] = "models/heroes/shadow_fiend/shadow_fiend.vmdl",
   },
   ["npc_dota_hero_rattletrap"] = 
   {
      ["items"] = 
      {
         ["models/heroes/rattletrap/rattletrap_head.vmdl"] = "true",
         ["models/heroes/rattletrap/rattletrap_weapon.vmdl"] = "true",
         ["models/heroes/rattletrap/rattletrap_rocket.vmdl"] = "true",
         ["models/heroes/rattletrap/rattletrap_armor.vmdl"] = "true",
      },
      ["model"] = "models/heroes/rattletrap/rattletrap.vmdl",
   },
   ["npc_dota_hero_legion_commander"] = 
   {
      ["items"] = 
      {
         ["models/heroes/legion_commander/legion_commander_head.vmdl"] = "true",
         ["models/heroes/legion_commander/legion_commander_shoulders.vmdl"] = "true",
         ["models/heroes/legion_commander/legion_commander_arms.vmdl"] = "true",
         ["models/heroes/legion_commander/legion_commander_back.vmdl"] = "true",
         ["models/heroes/legion_commander/legion_commander_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/legion_commander/legion_commander.vmdl",
   },
   ["npc_dota_hero_dawnbreaker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/dawnbreaker/dawnbreaker_arms.vmdl"] = "true",
         ["models/heroes/dawnbreaker/dawnbreaker_armor.vmdl"] = "true",
         ["models/heroes/dawnbreaker/dawnbreaker_weapon.vmdl"] = "true",
         ["models/heroes/dawnbreaker/dawnbreaker_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/dawnbreaker/dawnbreaker.vmdl",
   },
   ["npc_dota_hero_queenofpain"] = 
   {
      ["items"] = 
      {
         ["models/heroes/queenofpain/hair.vmdl"] = "true",
         ["models/heroes/queenofpain/queenofpain_legs.vmdl"] = "true",
         ["models/heroes/queenofpain/wings.vmdl"] = "true",
         ["models/heroes/queenofpain/queenofpain_weapon.vmdl"] = "true",
         ["models/heroes/queenofpain/shoulders.vmdl"] = "true",
      },
      ["model"] = "models/heroes/queenofpain/queenofpain.vmdl",
   },
   ["npc_dota_hero_death_prophet"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_death_prophet/death_prophet_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "renderorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/death_prophet/death_prophet_hair.vmdl"] = "true",
         ["models/heroes/death_prophet/death_prophet_scarf.vmdl"] = "true",
         ["models/heroes/death_prophet/death_prophet_dress.vmdl"] = "true",
         ["models/heroes/death_prophet/death_prophet_dresstop.vmdl"] = "true",
      },
      ["model"] = "models/heroes/death_prophet/death_prophet.vmdl",
   },
   ["npc_dota_hero_skeleton_king"] = 
   {
      ["items"] = 
      {
         ["models/heroes/wraith_king/wraith_king_gauntlet.vmdl"] = "true",
         ["models/heroes/wraith_king/wraith_king_cape.vmdl"] = "true",
         ["models/heroes/wraith_king/wraith_king_weapon.vmdl"] = "true",
         ["models/heroes/wraith_king/wraith_king_chest.vmdl"] = "true",
         ["models/heroes/wraith_king/wraith_king_shoulder.vmdl"] = "true",
         ["models/heroes/wraith_king/wraith_king_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/wraith_king/wraith_king.vmdl",
   },
   ["npc_dota_hero_doom_bringer"] = 
   {
      ["items"] = 
      {
         ["models/heroes/doom/doom_sword.vmdl"] = "true",
         ["models/heroes/doom/doom_helm.vmdl"] = "true",
         ["models/heroes/doom/shoulders.vmdl"] = "true",
         ["models/heroes/doom/belt.vmdl"] = "true",
         ["models/heroes/doom/wings.vmdl"] = "true",
         ["models/heroes/doom/tail.vmdl"] = "true",
         ["models/heroes/doom/bracer.vmdl"] = "true",
      },
      ["model"] = "models/heroes/doom/doom.vmdl",
   },
   ["npc_dota_hero_monkey_king"] = 
   {
      ["items"] = 
      {
         ["models/heroes/monkey_king/monkey_king_shoulders.vmdl"] = "true",
         ["models/heroes/monkey_king/monkey_king_armor.vmdl"] = "true",
         ["models/heroes/monkey_king/monkey_king_hair.vmdl"] = "true",
         ["models/heroes/monkey_king/monkey_king_base_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/monkey_king/monkey_king.vmdl",
   },
   ["npc_dota_hero_earthshaker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/earthshaker/bracers.vmdl"] = "true",
         ["models/heroes/earthshaker/belt.vmdl"] = "true",
         ["models/heroes/earthshaker/totem.vmdl"] = "true",
      },
      ["model"] = "models/heroes/earthshaker/earthshaker.vmdl",
   },
   ["npc_dota_hero_lina"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_lina/lina_flame_hand_dual.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/lina/lina_neck.vmdl"] = "true",
         ["models/heroes/lina/lina_head.vmdl"] = "true",
         ["models/heroes/lina/lina_arms.vmdl"] = "true",
         ["models/heroes/lina/lina_belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lina/lina.vmdl",
   },
   ["npc_dota_hero_enchantress"] = 
   {
      ["items"] = 
      {
         ["models/heroes/enchantress/enchantress_dress.vmdl"] = "true",
         ["models/heroes/enchantress/enchantress_bracers.vmdl"] = "true",
         ["models/heroes/enchantress/enchantress_weapon.vmdl"] = "true",
         ["models/heroes/enchantress/enchantress_necklace.vmdl"] = "true",
         ["models/heroes/enchantress/enchantress_hair.vmdl"] = "true",
      },
      ["model"] = "models/heroes/enchantress/enchantress.vmdl",
   },
   ["npc_dota_hero_pudge"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_pudge/pudge_ambient_flies.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
         ["particles/units/heroes/hero_pudge/pudge_ambient_chain_right.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_weapon_chain_rt",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_arm_chain_rt",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin",
         },
         ["particles/units/heroes/hero_pudge/pudge_ambient_chain.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_weapon_chain_lf",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_arm_chain_lf",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/pudge/leftweapon.vmdl"] = "true",
         ["models/heroes/pudge/leftarm.vmdl"] = "true",
         ["models/heroes/pudge/back.vmdl"] = "true",
         ["models/heroes/pudge/bracer.vmdl"] = "true",
         ["models/heroes/pudge/belt.vmdl"] = "true",
         ["models/heroes/pudge/hair.vmdl"] = "true",
         ["models/heroes/pudge/righthook.vmdl"] = "true",
      },
      ["model"] = "models/heroes/pudge/pudge.vmdl",
   },
   ["npc_dota_hero_gyrocopter"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_gyrocopter/gyro_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_prop2",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_prop1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_exhaust",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/gyro/gyro_missile.vmdl"] = "true",
         ["models/heroes/gyro/gyro_bottles.vmdl"] = "true",
         ["models/heroes/gyro/gyro_head.vmdl"] = "true",
         ["models/heroes/gyro/gyro_goggles.vmdl"] = "true",
         ["models/heroes/gyro/gyro_guns.vmdl"] = "true",
         ["models/heroes/gyro/gyro_propeller.vmdl"] = "true",
      },
      ["model"] = "models/heroes/gyro/gyro.vmdl",
   },
   ["npc_dota_hero_zuus"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_zeus/zeus_ambient_hands.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin_follow",
         },
         ["particles/units/heroes/hero_zeus/zeus_ambient_eyes.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_eye_l",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_eye_r",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/zeus/zeus_vest.vmdl"] = "true",
         ["models/heroes/zeus/zeus_hair.vmdl"] = "true",
         ["models/heroes/zeus/zeus_bracers.vmdl"] = "true",
         ["models/heroes/zeus/zeus_belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/zeus/zeus.vmdl",
   },
   ["npc_dota_hero_keeper_of_the_light"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_keeper_of_the_light/keeper_of_the_light_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/keeper_of_the_light/kotl_horse_accesories.vmdl"] = "true",
         ["models/heroes/keeper_of_the_light/kotl_hood.vmdl"] = "true",
         ["models/heroes/keeper_of_the_light/kotl_mount.vmdl"] = "true",
         ["models/heroes/keeper_of_the_light/kotl_staff.vmdl"] = "true",
         ["models/heroes/keeper_of_the_light/kotl_skirt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/keeper_of_the_light/keeper_of_the_light.vmdl",
   },
   ["npc_dota_hero_drow_ranger"] = 
   {
      ["items"] = 
      {
         ["models/heroes/drow/drow_legs.vmdl"] = "true",
         ["models/heroes/drow/drow_quiver.vmdl"] = "true",
         ["models/heroes/drow/drow_weapon.vmdl"] = "true",
         ["models/heroes/drow/drow_bracer.vmdl"] = "true",
         ["models/heroes/drow/drow_haircowl.vmdl"] = "true",
         ["models/heroes/drow/drow_armor.vmdl"] = "true",
         ["models/heroes/drow/drow_cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/drow/drow_base.vmdl",
   },
   ["npc_dota_hero_lich"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_lich/lich_ambient_frost.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_lich/lich_ambient_frost_legs.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/lich/lich_neck_rock.vmdl"] = "true",
         ["models/heroes/lich/lich_horns.vmdl"] = "true",
         ["models/heroes/lich/lich_dress.vmdl"] = "true",
         ["models/heroes/lich/lich_bracer.vmdl"] = "true",
      },
      ["model"] = "models/heroes/lich/lich.vmdl",
   },
   ["npc_dota_hero_crystal_maiden"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_crystalmaiden/maiden_ambient_hand.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_crystalmaiden/maiden_ambient_mouth.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_mouth",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/crystal_maiden/crystal_maiden_staff.vmdl"] = "true",
         ["models/heroes/crystal_maiden/crystal_maiden_cuffs.vmdl"] = "true",
         ["models/heroes/crystal_maiden/crystal_maiden_shoulders.vmdl"] = "true",
         ["models/heroes/crystal_maiden/head_item.vmdl"] = "true",
         ["models/heroes/crystal_maiden/crystal_maiden_cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/crystal_maiden/crystal_maiden.vmdl",
   },
   ["npc_dota_hero_magnataur"] = 
   {
      ["items"] = 
      {
         ["models/heroes/magnataur/magnataur_weapon.vmdl"] = "true",
         ["models/heroes/magnataur/magnataur_bracers.vmdl"] = "true",
         ["models/heroes/magnataur/magnataur_hair.vmdl"] = "true",
         ["models/heroes/magnataur/magnataur_horn.vmdl"] = "true",
         ["models/heroes/magnataur/magnataur_belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/magnataur/magnataur.vmdl",
   },
   ["npc_dota_hero_ogre_magi"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_ogre_magi/ogre_magi_weapon.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/ogre_magi/ogre_magi_hats.vmdl"] = "true",
         ["models/heroes/ogre_magi/ogre_magi_bracers.vmdl"] = "true",
         ["models/heroes/ogre_magi/ogre_magi_belt.vmdl"] = "true",
         ["models/heroes/ogre_magi/ogre_magi_weapon.vmdl"] = "true",
         ["models/heroes/ogre_magi/ogre_magi_cape.vmdl"] = "true",
      },
      ["model"] = "models/heroes/ogre_magi/ogre_magi.vmdl",
   },
   ["npc_dota_hero_mirana"] = 
   {
      ["items"] = 
      {
         ["models/heroes/mirana/quiver.vmdl"] = "true",
         ["models/heroes/mirana/bow.vmdl"] = "true",
         ["models/heroes/mirana/mount.vmdl"] = "true",
         ["models/heroes/mirana/head_item.vmdl"] = "true",
         ["models/heroes/mirana/cape.vmdl"] = "true",
         ["models/heroes/mirana/shoulders.vmdl"] = "true",
         ["models/heroes/mirana/bracers.vmdl"] = "true",
      },
      ["model"] = "models/heroes/mirana/mirana.vmdl",
   },
   ["npc_dota_hero_terrorblade"] = 
   {
      ["effects"] = 
      {
         ["particles/terrorblade_custom/terrorblade_feet_effects.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/terrorblade/wings.vmdl"] = "true",
         ["models/heroes/terrorblade/weapon.vmdl"] = "true",
         ["models/heroes/terrorblade/armor.vmdl"] = "true",
         ["models/heroes/terrorblade/horns.vmdl"] = "true",
      },
      ["model"] = "models/heroes/terrorblade/terrorblade.vmdl",
   },
   ["npc_dota_hero_ancient_apparition"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_ancient_apparition/ancient_apparition_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/ancient_apparition/ancient_apparition_tail.vmdl"] = "true",
         ["models/heroes/ancient_apparition/ancient_apparition_shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/ancient_apparition/ancient_apparition.vmdl",
   },
   ["npc_dota_hero_skywrath_mage"] = 
   {
      ["items"] = 
      {
         ["models/heroes/skywrath_mage/skywrath_mage_head.vmdl"] = "true",
         ["models/heroes/skywrath_mage/skywrath_mage_belt.vmdl"] = "true",
         ["models/heroes/skywrath_mage/skywrath_mage_shoulders.vmdl"] = "true",
         ["models/heroes/skywrath_mage/skywrath_mage_bracers.vmdl"] = "true",
         ["models/heroes/skywrath_mage/skywrath_mage_staff.vmdl"] = "true",
         ["models/heroes/skywrath_mage/skywrath_mage_wings.vmdl"] = "true",
      },
      ["model"] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
   },
   ["npc_dota_hero_dark_seer"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_dark_seer/dark_seer_ambient_hands.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/dark_seer/dark_seer_back.vmdl"] = "true",
         ["models/heroes/dark_seer/dark_seer_arm.vmdl"] = "true",
         ["models/heroes/dark_seer/dark_seer_waist.vmdl"] = "true",
         ["models/heroes/dark_seer/dark_seer_head.vmdl"] = "true",
         ["models/heroes/dark_seer/dark_seer_neck.vmdl"] = "true",
      },
      ["model"] = "models/heroes/dark_seer/dark_seer.vmdl",
   },
   ["npc_dota_hero_axe"] = 
   {
      ["items"] = 
      {
         ["models/heroes/axe/axe_weapon.vmdl"] = "true",
         ["models/heroes/axe/axe_belt.vmdl"] = "true",
         ["models/heroes/axe/axe_armor.vmdl"] = "true",
         ["models/heroes/axe/axe_ponytail.vmdl"] = "true",
      },
      ["model"] = "models/heroes/axe/axe.vmdl",
   },
   ["npc_dota_hero_phantom_lancer"] = 
   {
      ["items"] = 
      {
         ["models/heroes/phantom_lancer/phantom_lancer_weapon.vmdl"] = "true",
         ["models/heroes/phantom_lancer/phantom_lancer_belt.vmdl"] = "true",
         ["models/heroes/phantom_lancer/phantom_lancer_gauntlet.vmdl"] = "true",
         ["models/heroes/phantom_lancer/phantom_lancer_shoulderpad.vmdl"] = "true",
         ["models/heroes/phantom_lancer/phantom_lancer_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/phantom_lancer/phantom_lancer.vmdl",
   },
   ["npc_dota_hero_invoker"] = 
   {
      ["items"] = 
      {
         ["models/heroes/invoker/invoker_bracer.vmdl"] = "true",
         ["models/heroes/invoker/invoker_dress.vmdl"] = "true",
         ["models/heroes/invoker/invoker_cape.vmdl"] = "true",
         ["models/heroes/invoker/invoker_head.vmdl"] = "true",
         ["models/heroes/invoker/invoker_hair.vmdl"] = "true",
         ["models/heroes/invoker/invoker_shoulder.vmdl"] = "true",
      },
      ["model"] = "models/heroes/invoker/invoker.vmdl",
   },
   ["npc_dota_hero_life_stealer"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_life_stealer/life_stealer_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_jaw",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/life_stealer/life_stealer_chains.vmdl"] = "true",
         ["models/heroes/life_stealer/life_stealer_loincloth.vmdl"] = "true",
      },
      ["model"] = "models/heroes/life_stealer/life_stealer.vmdl",
   },
   ["npc_dota_hero_antimage"] = 
   {
      ["items"] = 
      {
         ["models/heroes/antimage/antimage_belt.vmdl"] = "true",
         ["models/heroes/antimage/antimage_offhand_weapon.vmdl"] = "true",
         ["models/heroes/antimage/antimage_head.vmdl"] = "true",
         ["models/heroes/antimage/antimage_chest.vmdl"] = "true",
         ["models/heroes/antimage/antimage_weapon.vmdl"] = "true",
         ["models/heroes/antimage/antimage_arms.vmdl"] = "true",
      },
      ["model"] = "models/heroes/antimage/antimage.vmdl",
   },
   ["npc_dota_hero_slardar"] = 
   {
      ["items"] = 
      {
         ["models/heroes/slardar/slardar_weapon.vmdl"] = "true",
         ["models/heroes/slardar/slardar_back.vmdl"] = "true",
         ["models/heroes/slardar/slardar_arms.vmdl"] = "true",
      },
      ["model"] = "models/heroes/slardar/slardar.vmdl",
   },
   ["npc_dota_hero_troll_warlord"] = 
   {
      ["items"] = 
      {
         ["models/heroes/troll_warlord/mesh/troll_warlord_armor_model_lod0.vmdl"] = "true",
         ["models/heroes/troll_warlord/troll_warlord_shoulders.vmdl"] = "true",
         ["models/heroes/troll_warlord/troll_warlord_weapons.vmdl"] = "true",
         ["models/heroes/troll_warlord/troll_warlord_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/troll_warlord/troll_warlord.vmdl",
   },
   ["npc_dota_hero_tusk"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_tusk/tusk_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
         ["particles/units/heroes/hero_tusk/tusk_ambient_mouth.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_mouth",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/tuskarr/tusk_armor_glove.vmdl"] = "true",
         ["models/heroes/tuskarr/tusk_cowl.vmdl"] = "true",
         ["models/heroes/tuskarr/tusk_hat.vmdl"] = "true",
         ["models/heroes/tuskarr/tusk_horns.vmdl"] = "true",
         ["models/heroes/tuskarr/tusk_weapon.vmdl"] = "true",
         ["models/heroes/tuskarr/tusk_fish_basket.vmdl"] = "true",
      },
      ["model"] = "models/heroes/tuskarr/tuskarr.vmdl",
   },
   ["npc_dota_hero_void_spirit"] = 
   {
      ["effects"] = 
      {
      },
      ["items"] = 
      {
         ["models/heroes/void_spirit/void_spirit_armor.vmdl"] = "true",
         ["models/heroes/void_spirit/void_spirit_belt.vmdl"] = "true",
         ["models/heroes/void_spirit/void_spirit_head.vmdl"] = "true",
         ["models/heroes/void_spirit/void_spirit_weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/void_spirit/void_spirit.vmdl",
   },
   ["npc_dota_hero_witch_doctor"] = 
   {
      ["items"] = 
      {
         ["models/heroes/witchdoctor/witchdoctor_staff.vmdl"] = "true",
         ["models/heroes/witchdoctor/witchdoctor_head.vmdl"] = "true",
         ["models/heroes/witchdoctor/witchdoctor_bag.vmdl"] = "true",
         ["models/heroes/witchdoctor/witchdoctor_belt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/witchdoctor/witchdoctor.vmdl",
   },
   ["npc_dota_hero_bane"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_bane/bane_hand_drip_right.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack2",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
         ["particles/units/heroes/hero_bane/bane_hand_drip.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
         ["particles/units/heroes/hero_bane/bane_slime_trail.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/bane/bane_head.vmdl"] = "true",
         ["models/heroes/bane/bane_shoulders.vmdl"] = "true",
      },
      ["model"] = "models/heroes/bane/bane.vmdl",
   },
   ["npc_dota_hero_wisp"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_wisp/wisp_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "10",
                  ["position"] = "1 1 0",
                  ["attach_type"] = "worldorigin",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "13",
                  ["position"] = "0 1 1",
                  ["attach_type"] = "worldorigin",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "11",
                  ["position"] = "1 0 0",
                  ["attach_type"] = "worldorigin",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["model"] = "models/heroes/wisp/wisp.vmdl",
   },
   ["npc_dota_hero_morphling"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_morphling/morphling_ambient_new.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_ambient_spine2",
                  ["attach_type"] = "point_follow",
               },
               ["5"] = 
               {
                  ["control_point_index"] = "0",
                  ["attach_type"] = "absorigin_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_base",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "5",
                  ["attachment"] = "attach_ambient_head_2",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_ambient_head",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_ambient_spine1",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["model"] = "models/heroes/morphling/morphling.vmdl",
   },
   ["npc_dota_hero_broodmother"] = 
   {
      ["items"] = 
      {
         ["models/heroes/broodmother/broodmother_legs.vmdl"] = "true",
         ["models/heroes/broodmother/broodmother_abdomen.vmdl"] = "true",
         ["models/heroes/broodmother/broodmother_hair.vmdl"] = "true",
      },
      ["model"] = "models/heroes/broodmother/broodmother.vmdl",
   },
   ["npc_dota_hero_tiny"] = 
   {
      ["effects"] = 
      {
      },
      ["items"] = 
      {
         ["models/heroes/tiny/tiny_tree/tiny_tree.vmdl"] = "true",
         ["models/heroes/tiny_01/tiny_01_head.vmdl"] = "true",
         ["models/heroes/tiny_01/tiny_01_body.vmdl"] = "true",
         ["models/heroes/tiny_01/tiny_01_left_arm.vmdl"] = "true",
         ["models/heroes/tiny_01/tiny_01_right_arm.vmdl"] = "true",
      },
      ["model"] = "models/heroes/tiny/tiny_01/tiny_01.vmdl",
   },
   ["npc_dota_hero_storm_spirit"] = 
   {
      ["items"] = 
      {
         ["models/heroes/storm_spirit/storm_hat.vmdl"] = "true",
         ["models/heroes/storm_spirit/storm_shoulder.vmdl"] = "true",
         ["models/heroes/storm_spirit/storm_shirt.vmdl"] = "true",
      },
      ["model"] = "models/heroes/storm_spirit/storm_spirit.vmdl",
   },
   ["npc_dota_hero_riki"] = 
   {
      ["items"] = 
      {
         ["models/heroes/rikimaru/rikimaru_weapon.vmdl"] = "true",
         ["models/heroes/rikimaru/rikimaru_tail.vmdl"] = "true",
         ["models/heroes/rikimaru/rikimaru_shoulder.vmdl"] = "true",
         ["models/heroes/rikimaru/rikimaru__offhand_weapon.vmdl"] = "true",
         ["models/heroes/rikimaru/rikimaru_head.vmdl"] = "true",
         ["models/heroes/rikimaru/rikimaru_gloves.vmdl"] = "true",
      },
      ["model"] = "models/heroes/rikimaru/rikimaru.vmdl",
   },
   ["npc_dota_hero_faceless_void"] = 
   {
      ["items"] = 
      {
         ["models/heroes/faceless_void/faceless_void_belt.vmdl"] = "true",
         ["models/heroes/faceless_void/faceless_void_head.vmdl"] = "true",
         ["models/heroes/faceless_void/faceless_void_weapon.vmdl"] = "true",
         ["models/heroes/faceless_void/faceless_void_shoulder.vmdl"] = "true",
         ["models/heroes/faceless_void/faceless_void_bracer.vmdl"] = "true",
      },
      ["model"] = "models/heroes/faceless_void/faceless_void.vmdl",
   },
   ["npc_dota_hero_slark"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_slark/slark_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_jaw",
                  ["attach_type"] = "point_follow",
               },
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["4"] = 
               {
                  ["control_point_index"] = "4",
                  ["attachment"] = "attach_eyeL",
                  ["attach_type"] = "point_follow",
               },
               ["3"] = 
               {
                  ["control_point_index"] = "3",
                  ["attachment"] = "attach_eyeR",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attach_type"] = "absorigin_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["items"] = 
      {
         ["models/heroes/slark/shoulder.vmdl"] = "true",
         ["models/heroes/slark/cape.vmdl"] = "true",
         ["models/heroes/slark/hood.vmdl"] = "true",
         ["models/heroes/slark/weapon.vmdl"] = "true",
         ["models/heroes/slark/bracer.vmdl"] = "true",
      },
      ["model"] = "models/new_models/slark/slark.vmdl",
   },
   ["npc_dota_hero_abaddon"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_abaddon/abaddon_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_eye_l",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_attack1",
                  ["attach_type"] = "point_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "2",
                  ["attachment"] = "attach_eye_r",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "absorigin_follow",
         },
      },
      ["items"] = 
      {
         ["models/heroes/abaddon/helmet.vmdl"] = "true",
         ["models/heroes/abaddon/cape.vmdl"] = "true",
         ["models/heroes/abaddon/mount.vmdl"] = "true",
         ["models/heroes/abaddon/shoulders.vmdl"] = "true",
         ["models/heroes/abaddon/weapon.vmdl"] = "true",
      },
      ["model"] = "models/heroes/abaddon/abaddon.vmdl",
   },
   ["npc_dota_hero_furion"] = 
   {
      ["items"] = 
      {
         ["models/heroes/furion/furion_beard.vmdl"] = "true",
         ["models/heroes/furion/furion_necklace.vmdl"] = "true",
         ["models/heroes/furion/furion_horns.vmdl"] = "true",
         ["models/heroes/furion/furion_bracer.vmdl"] = "true",
         ["models/heroes/furion/furion_cape.vmdl"] = "true",
         ["models/heroes/furion/furion_staff.vmdl"] = "true",
      },
      ["model"] = "models/heroes/furion/furion.vmdl",
   },
   ["npc_dota_hero_arc_warden"] = 
   {
      ["effects"] = 
      {
         ["particles/units/heroes/hero_arc_warden/arc_warden_ambient.vpcf"] = 
         {
            ["attach_entity"] = "parent",
            ["control_points"] = 
            {
               ["0"] = 
               {
                  ["control_point_index"] = "0",
                  ["attachment"] = "attach_hitloc",
                  ["attach_type"] = "point_follow",
               },
               ["2"] = 
               {
                  ["control_point_index"] = "2",
                  ["attach_type"] = "absorigin_follow",
               },
               ["1"] = 
               {
                  ["control_point_index"] = "1",
                  ["attachment"] = "attach_head",
                  ["attach_type"] = "point_follow",
               },
            },
            ["attach_type"] = "customorigin",
         },
      },
      ["model"] = "models/heroes/arc_warden/arc_warden.vmdl",
      ["items"] = 
      {
         ["models/heroes/arc_warden/arc_warden_back.vmdl"] = "true",
         ["models/heroes/arc_warden/arc_warden_bracers.vmdl"] = "true",
         ["models/heroes/arc_warden/arc_warden_shoulder.vmdl"] = "true",
      },
   },
   ["npc_dota_hero_pangolier"] = 
   {
      ["items"] = 
      {
         ["models/heroes/pangolier/pangolier_armor.vmdl"] = "true",
         ["models/heroes/pangolier/pangolier_weapon.vmdl"] = "true",
         ["models/heroes/pangolier/pangolier_head.vmdl"] = "true",
      },
      ["model"] = "models/heroes/pangolier/pangolier.vmdl",
   },
   ["npc_dota_hero_muerta"] = 
   {
      ["items"] = 
      {
         ["models/heroes/muerta/muerta_back.vmdl"] = "true",
         ["models/heroes/muerta/muerta_armor.vmdl"] = "true",
         ["models/heroes/muerta/muerta_weapons.vmdl"] = "true",
         ["models/heroes/muerta/muerta_head.vmdl"] = "true",
      },
      ["model"] = "models/muerta/muerta.vmdl",
   },
   ["npc_dota_hero_oracle"] = 
   {
      ["items"] = 
      {
         ["models/heroes/oracle/head_item.vmdl"] = "true",
         ["models/heroes/oracle/back_item.vmdl"] = "true",
         ["models/heroes/oracle/weapon.vmdl"] = "true",
         ["models/heroes/oracle/armor.vmdl"] = "true",
      },
      ["model"] = "models/heroes/oracle/oracle.vmdl",
   },
   ["npc_dota_hero_nyx_assassin"] = 
   {
      ["items"] = 
      {
         ["models/heroes/nerubian_assassin/nerubian_assassin_weapon.vmdl"] = "true",
         ["models/heroes/nerubian_assassin/nerubian_assassin_armor.vmdl"] = "true",
         ["models/heroes/nerubian_assassin/nerubian_assassin_helmet.vmdl"] = "true",
      },
      ["model"] = "models/heroes/nerubian_assassin/nerubian_assassin.vmdl",
   },
}