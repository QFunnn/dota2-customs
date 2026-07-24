--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [7212] = {
        ['item_id'] =7212,
        ['name'] ='Bloodfeather Wings',
        ['icon'] ='econ/items/queenofpain/bloody_raven_wings/bloody_raven_wings',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/bloody_raven_wings/bloody_raven_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_bloody_raven_wings/qop_bloody_raven_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [12322] = {
        ['item_id'] =12322,
        ['name'] ='Bloodfeather Feast',
        ['icon'] ='econ/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_ti_8_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_dagger_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_01"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_02"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_a"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_b"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_body.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_debuff.vpcf",
        }
    },
    [12337] = {
        ['item_id'] =12337,
        ['name'] ='Golden Bloodfeather Feast',
        ['icon'] ='econ/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12337, "#e6e467ff"}, {35221, "#8567e6"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_ti_8_weapon_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_dagger_golden_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_01"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_02"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_a"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_b"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_body.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_golden_shadow_strike.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_golden_shadow_strike_debuff.vpcf", 
        },
    },

    [35221] = {
        ['item_id'] =35221,
        ['name'] ='Tyrian Bloodfeather Feast',
        ['icon'] ='econ/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon2',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/queenofpain/qop_ti8_weapon/qop_ti8_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{12337, "#e6e467ff"}, {35221, "#8567e6"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_ti_8_weapon_custom_purple",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_dagger_purple_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_01"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_endblade_02"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_a"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_b"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_purple_body.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_purple.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/queen_ti8_shadow_strike_purple_debuff.vpcf",
            "particles/econ/items/queen_of_pain/qop_ti8_immortal/qop_ti8_base_attack_purple.vpcf",
        },
    },

    [23697] = 
    {
        ['item_id'] =23697,
        ['name'] ='Bloodfeather Finery',
        ['icon'] ='econ/items/queenofpain/qop_2022_immortal/qop_2022_immortal',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/queenofpain/qop_2022_immortal/qop_2022_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23697, "#e53437"}, {2369701, "#5f9aea"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_immortal_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_arcana_2022_ambient.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_ambient.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_owner.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/queenofpain/qop_2022_immortal/qop_2022_immortal.vmdl",
            "models/items/queenofpain/qop_2022_immortal/qop_2022_immortal_arcana_refit.vmdl",
        }
    },

    [24100] = 
    {
        ['item_id'] =24100,
        ['name'] ='Bloodfeather Boots',
        ['icon'] ='econ/items/queenofpain/qop_2022_immortal/qop_2022_immortal_legs',
        ['price'] = 4001,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_2022_immortal/qop_2022_immortal_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ["OtherModelsPrecache"] =
        {
            "models/items/queenofpain/qop_2022_immortal/qop_2022_immortal_legs_arcana_refit.vmdl",
        }
    },

    [2369701] = 
    {
        ["dota_id"] = 23697,
        ['item_id'] =2369701,
        ['name'] ='Bloodfeather Finery',
        ['icon'] ='econ/items/queenofpain/qop_2022_immortal/qop_2022_immortal_style1',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ["ItemStyle"] = "1",
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_2022_immortal/qop_2022_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23697, "#e53437"}, {2369701, "#5f9aea"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_immortal_custom_v2",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_ambient_blue.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_arcana_2022_ambient_blue_main.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_ambient_blue.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_projectile_blue.vpcf",
            "particles/econ/items/queen_of_pain/qop_2022_immortal/queen_2022_scream_of_pain_owner_blue.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/queenofpain/qop_2022_immortal/qop_2022_immortal.vmdl",
            "models/items/queenofpain/qop_2022_immortal/qop_2022_immortal_arcana_refit.vmdl",
        }
    },

    [5157] = {
        ['item_id'] =5157,
        ['name'] ='Shade of Anguish',
        ['icon'] ='econ/items/queenofpain/shadeofagony/shadeofagony',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/shadeofagony/shadeofagony.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'maze_of_anguish',
    },
    [5159] = {
        ['item_id'] =5159,
        ['name'] ='Guard of Anguish',
        ['icon'] ='econ/items/queenofpain/armorofagony/armorofagony',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/armorofagony/armorofagony.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'maze_of_anguish',
    },
    [6839] = {
        ['item_id'] =6839,
        ['name'] ='Crimson Agony',
        ['icon'] ='econ/items/queenofpain/sanguine_weapon/sanguine_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/sanguine_weapon/sanguine_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'maze_of_anguish',
    },

    [5162] = {
        ['item_id'] =5162,
        ['name'] ='Maze of Anguish',
        ['icon'] ='econ/items/queenofpain/wingsofagony/wingsofagony',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/wingsofagony/wingsofagony.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'maze_of_anguish',
    },

    

    [7750] = {
        ['item_id'] =7750,
        ['name'] ='Veil of the Parasols Sting',
        ['icon'] ='econ/items/queenofpain/regalia_of_the_ill_wind_wings/regalia_of_the_ill_wind_wings',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/regalia_of_the_ill_wind_wings/regalia_of_the_ill_wind_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'parsols_sting',
    },
    [7753] = {
        ['item_id'] =7753,
        ['name'] ='Ancipitous Strike of the Parasols Sting',
        ['icon'] ='econ/items/queenofpain/regalia_of_the_ill_wind_weapon/regalia_of_the_ill_wind_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/regalia_of_the_ill_wind_weapon/regalia_of_the_ill_wind_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'parsols_sting',
    },
    [7754] = {
        ['item_id'] =7754,
        ['name'] ='Jabot of the Parasols Sting',
        ['icon'] ='econ/items/queenofpain/regalia_of_the_ill_wind_shoulder/regalia_of_the_ill_wind_shoulder',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/regalia_of_the_ill_wind_shoulder/regalia_of_the_ill_wind_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'parsols_sting',
    },
    [7755] = {
        ['item_id'] =7755,
        ['name'] ='Ferronniere of the Parasols Sting',
        ['icon'] ='econ/items/queenofpain/regalia_of_the_ill_wind_head/regalia_of_the_ill_wind_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/regalia_of_the_ill_wind_head/regalia_of_the_ill_wind_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'parsols_sting',
    },



    [12930] = 
    {
        ['item_id'] =12930,
        ['name'] ='Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana',
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['is_exclusive'] = 1,
        ['HeroModel'] = "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_modest_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12930, "#e53437"}, {1293001, "#5f9aea"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_arcana_custom_1",
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_wings_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_hot_l"
                    },
                }
            },
        },
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_whip_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_end", "hero",
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_feet_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_start.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_end.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_anim_sonic_wave_trace.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonicwave_tgt.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_tgt_death.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
           "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_modest_wings.vmdl",
           "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_wings.vmdl"
        }
    },
    [1293001] = 
    {
        ["dota_id"] = 12930,
        ['item_id'] =1293001,
        ['name'] ='Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_style1',
        ['price'] = 15000,
        ['HeroModel'] = "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['is_exclusive'] = 1,
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_modest_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{12930, "#e53437"}, {1293001, "#5f9aea"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_queenofpain_arcana_custom_2",
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_wings_v2_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_hot_l"
                    },
                }
            },
        },
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_whip_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_end", "hero",
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_feet_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_start.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blink_v2_end.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonic_wave_v2.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_anim_sonic_wave_trace_v2.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_sonicwave_tgt_v2.vpcf",
            "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_v2_tgt_death.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
           "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_modest_wings.vmdl",
           "models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_wings.vmdl"
        },
    },

    [13768] = 
    {
           ['item_id'] =13768,
           ['name'] ='Raiments of the Eminence of Ristul',
           ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_armor_legacy',
           ['price'] = 0,
           ['HeroModel'] = nil,
           ['ArcanaAnim'] = nil,
           ['MaterialGroup'] = nil,
           ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_armor_legacy.vmdl',
           ['SetItems'] = nil,
           ['hide'] = 0,
           ['OtherItemsBundle'] = nil,
           ['SlotType'] = 'shoulder',
           ['RemoveDefaultItemsList'] = nil,
           --['Modifier'] = nil,
           ['sets'] = 'queenofpain_arcana',
    },
    [13769] = 
    {
        ['item_id'] =13769,
        ['name'] ='Crown of the Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{13769, "#e53437"}, {1376901, "#5f9aea"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [1376901] = 
    {
        ["dota_id"] = 13769,
        ['item_id'] =1376901,
        ['name'] ='Crown of the Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ["ItemStyle"] = "1",
        --['OtherItemsBundle'] = {{13769, "#e53437"}, {1376901, "#5f9aea"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_head_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [13770] = 
    {
        ['item_id'] =13770,
        ['name'] ='Grace of the Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_dagger',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_dagger.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{13770, "#e53437"}, {1377001, "#5f9aea"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blade_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [1377001] = 
    {
        ["dota_id"] = 13770,
        ['item_id'] =1377001,
        ['name'] ='Grace of the Eminence of Ristul',
        ['icon'] ='econ/items/queenofpain/queenofpain_arcana/queenofpain_arcana_dagger',
        ['price'] = 0,
        ["ItemStyle"] = "1",
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/queenofpain_arcana/queenofpain_arcana_dagger.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{13770, "#e53437"}, {1377001, "#5f9aea"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'queenofpain_arcana',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/qop_arcana/qop_arcana_blade_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },

    [8232] = {
            ['item_id'] =8232,
            ['name'] ='Span of Delightful Affliction',
            ['icon'] ='econ/items/queenofpain/esl_demonic_affliction_back/esl_demonic_affliction_back',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/queenofpain/esl_demonic_affliction_back/esl_demonic_affliction_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'delightfull_qop',
    },
    [8233] = {
            ['item_id'] =8233,
            ['name'] ='Dagger of Delightful Affliction',
            ['icon'] ='econ/items/queenofpain/esl_demonic_affliction_weapon/esl_demonic_affliction_weapon',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/queenofpain/esl_demonic_affliction_weapon/esl_demonic_affliction_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'delightfull_qop',
    },
    [8107] = {
            ['item_id'] =8107,
            ['name'] ='Prongs of Delightful Affliction',
            ['icon'] ='econ/items/queenofpain/esl_demonic_affliction_head/esl_demonic_affliction_head',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/queenofpain/esl_demonic_affliction_head/esl_demonic_affliction_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'delightfull_qop',
    },
    [8231] = {
            ['item_id'] =8231,
            ['name'] ='Mantle of Delightful Affliction',
            ['icon'] ='econ/items/queenofpain/esl_demonic_affliction_shoulder/esl_demonic_affliction_shoulder',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/queenofpain/esl_demonic_affliction_shoulder/esl_demonic_affliction_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'delightfull_qop',
    },
    [26380] = 
    {
        ['item_id'] =26380,
        ['name'] ='Exquisite Agonies - Back',
        ['icon'] ='econ/items/queenofpain/qop_deadly_whisper_back/qop_deadly_whisper_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_back/qop_deadly_whisper_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{26380, "#e53437"}, {263801, "#5f9aea"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [29615] = 
    {
        ['item_id'] =29615,
        ['name'] ='Exquisite Agonies - Head',
        ['icon'] ='econ/items/queenofpain/deadly_whisper_head/deadly_whisper_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_head/qop_deadly_whisper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29615, "#e53437"}, {296151, "#5f9aea"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/deadly_whisper/deadly_whisper_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [26379] = 
    {
        ['item_id'] =26379,
        ['name'] ='Exquisite Agonies - Weapon',
        ['icon'] ='econ/items/queenofpain/qop_deadly_whisper_weapon/qop_deadly_whisper_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_weapon/qop_deadly_whisper_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{26379, "#e53437"}, {263791, "#5f9aea"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [29614] = 
    {
        ['item_id'] =29614,
        ['name'] ='Exquisite Agonies - Legs',
        ['icon'] ='econ/items/queenofpain/deadly_whisper_legs/deadly_whisper_legs',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_legs/qop_deadly_whisper_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [29616] = 
    {
        ['item_id'] =29616,
        ['name'] ='Exquisite Agonies - Shoulder',
        ['icon'] ='econ/items/queenofpain/deadly_whisper_shoulder/deadly_whisper_shoulder',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_shoulder/qop_deadly_whisper_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29616, "#e53437"}, {296161, "#5f9aea"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [263801] = 
    {
        ["dota_id"] = 26380,
        ['item_id'] =263801,
        ["ItemStyle"] = "1",
        ['name'] ='Exquisite Agonies - Back',
        ['icon'] ='econ/items/queenofpain/qop_deadly_whisper_back/qop_deadly_whisper_back_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_back/qop_deadly_whisper_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26380, "#e53437"}, {263801, "#5f9aea"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [296151] = 
    {
        ["dota_id"] = 29615,
        ['item_id'] =296151,
        ["ItemStyle"] = "1",
        ['name'] ='Exquisite Agonies - Head',
        ['icon'] ='econ/items/queenofpain/deadly_whisper_head/deadly_whisper_head_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_head/qop_deadly_whisper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29615, "#e53437"}, {296151, "#5f9aea"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/queen_of_pain/deadly_whisper/deadly_whisper_head_blue_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [263791] = 
    {
        ["dota_id"] = 26379,
        ['item_id'] =263791,
        ["ItemStyle"] = "1",
        ['name'] ='Exquisite Agonies - Weapon',
        ['icon'] ='econ/items/queenofpain/qop_deadly_whisper_weapon/qop_deadly_whisper_weapon_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_weapon/qop_deadly_whisper_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26379, "#e53437"}, {263791, "#5f9aea"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },
    [296161] = 
    {
        ["dota_id"] = 29616,
        ['item_id'] =296161,
        ["ItemStyle"] = "1",
        ['name'] ='Exquisite Agonies - Shoulder',
        ['icon'] ='econ/items/queenofpain/deadly_whisper_shoulder/deadly_whisper_shoulder_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/queenofpain/qop_deadly_whisper_shoulder/qop_deadly_whisper_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29616, "#e53437"}, {296161, "#5f9aea"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'exquisite_agonies',
    },


    [36220] = {
['item_id'] =36220,
['name'] ='Mistress of Ceremonies - Head',
['icon'] ='econ/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_head',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'mistress_ceremonies',
},
[36221] = {
['item_id'] =36221,
['name'] ='Mistress of Ceremonies - Legs',
['icon'] ='econ/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_legs',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_legs.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'legs',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'mistress_ceremonies',
},
[36222] = {
['item_id'] =36222,
['name'] ='Mistress of Ceremonies - Shoulders',
['icon'] ='econ/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_shoulders',
['price'] = 800,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_shoulders.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'shoulder',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'mistress_ceremonies',
},
[36223] = {
['item_id'] =36223,
['name'] ='Mistress of Ceremonies - Weapon',
['icon'] ='econ/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_weapon',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_weapon.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'weapon',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'mistress_ceremonies',
},
[36219] = {
['item_id'] =36219,
['name'] ='Mistress of Ceremonies - Back',
['icon'] ='econ/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_back',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/queenofpain/dark_carnival_queen_of_pain/dark_carnival_queen_of_pain_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'mistress_ceremonies',
},
}