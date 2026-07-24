--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [34184] =
    {
        ['item_id'] = 34184,
        ['name'] ='Demon Eater - Head',
        ['icon'] = 'econ/heroes/shadow_fiend/shadow_fiend_arcana_head',
        ['price'] = 0,
        ['ItemModel'] = 'models/heroes/shadow_fiend/shadow_fiend_arcana_head.vmdl',
        ['SlotType'] = 'head',
        ['sets'] = 'nevermore_arcana',
        ['hide'] = 0,
    },
    [34185] =
    {
        ['item_id'] = 34185,
        ['name'] ='Demon Eater - Shoulders',
        ['icon'] = 'econ/heroes/shadow_fiend/shadow_fiend_arcana_shoulders',
        ['price'] = 0,
        ['ItemModel'] = 'models/heroes/shadow_fiend/shadow_fiend_arcana_shoulders.vmdl',
        ['SlotType'] = 'shoulder',
        ['sets'] = 'nevermore_arcana',
        ['hide'] = 0,
    },
    [34186] =
    {
        ['item_id'] = 34186,
        ['name'] ='Demon Eater - Arms',
        ['icon'] = 'econ/heroes/shadow_fiend/shadow_fiend_arcana_arms',
        ['price'] = 0,
        ['ItemModel'] = 'models/heroes/shadow_fiend/shadow_fiend_arcana_arms.vmdl',
        ['SlotType'] = 'arms',
        ['sets'] = 'nevermore_arcana',
        ['hide'] = 0,
    },
    [6996] = 
    {
        ['item_id'] =6996,
        ['name'] ='Demon Eater',
        ['icon'] ='econ/items/nevermore/shadowfiend_demon_eater',
        ['price'] = 9993,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/shadow_fiend/shadow_fiend_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/heroes/shadow_fiend/head_arcana.vmdl',
        ["ParticlesHero"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_R0"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_R1"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_R2"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_L0"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_L1"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_L2"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eyeL"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eyeR"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_trail.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = {},
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_shadow_fiend_arcana_custom",
        ['sets'] = 'nevermore_arcana',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_necro_souls.vpcf",
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_shadowraze.vpcf",
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_requiemofsouls.vpcf",
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_requiemofsouls_line.vpcf",
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_wings.vpcf",
            "particles/econ/items/shadow_fiend/sf_fire_arcana/sf_fire_arcana_base_attack.vpcf",

        }
    },
    [8259] = 
    {
        ['item_id'] =8259,
        ['name'] ='Arms of Desolation',
        ['icon'] ='econ/items/shadow_fiend/arms_deso/arms_deso',
        ['price'] = 2500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='kynomi/models/sf_arms_deso/arms_deso.vmdl',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_desolation/shadow_fiend_desolation_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_arm_L", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_arm_R", "hero"
                    },
                }
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_shadow_fiend_desolator_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/shadow_fiend/arms_deso/arms_deso.vmdl",
        }
    },
    [9021] = 
    {
            ['item_id'] =9021,
            ['name'] ='Horns of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_head/ferrum_chiroptera_head',
            ['price'] = 1000,
            ["MaterialGroupItem"] = "0",
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_head/ferrum_chiroptera_head.vmdl',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_head_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9021, "#d8d8d8"}, {22845, "#9d4c78"}},
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'eternalharverst',
    },
    [9019] = 
    {
            ['item_id'] =9019,
            ['name'] ='Grips of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_arms/ferrum_chiroptera_arms',
            ['price'] = 600,
            ["MaterialGroupItem"] = "0",
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_arms/ferrum_chiroptera_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9019, "#d8d8d8"}, {22843, "#9d4c78"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'eternalharverst',
    },
    [9020] = 
    {
            ['item_id'] =9020,
            ['name'] ='Pauldrons of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_shoulder/ferrum_chiroptera_shoulder',
            ['price'] = 4000,
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_shoulder_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
            ["MaterialGroupItem"] = "0",
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_shoulder/ferrum_chiroptera_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9020, "#d8d8d8"}, {22844, "#9d4c78"}},
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'eternalharverst',
    },

    [13505] = 
    {
        ['item_id'] =13505,
        ['name'] ='Souls Tyrant Head',
        ['icon'] ='econ/items/nevermore/sf_souls_tyrant_head/sf_souls_tyrant_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_souls_tyrant_head/sf_souls_tyrant_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulstyrant',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_souls_tyrant/sf_souls_tyrant_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_center"
                    },
                }
            },
        },
    },
    [13506] = 
    {
        ['item_id'] =13506,
        ['name'] ='Souls Tyrant Arms',
        ['icon'] ='econ/items/nevermore/sf_souls_tyrant_arms/sf_souls_tyrant_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_souls_tyrant_arms/sf_souls_tyrant_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulstyrant',
    },
    [13507] = 
    {
        ['item_id'] =13507,
        ['name'] ='Souls Tyrant Shoulder',
        ['icon'] ='econ/items/nevermore/sf_souls_tyrant_shoulder/sf_souls_tyrant_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_souls_tyrant_shoulder/sf_souls_tyrant_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulstyrant',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_souls_tyrant/sf_souls_tyrant_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_l"
                    },
                }
            },
        },
    },

    [12677] = 
    {
        ['item_id'] =12677,
        ['name'] ='Soul Corpulence - Shoulder',
        ['icon'] ='econ/items/nevermore/sf_immortal_flame_shoulder/sf_immortal_flame_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='kynomi/models/sf_immortal_flame_shoulder/sf_immortal_flame_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulcorplence',
        ["OtherModelsPrecache"] =
        {
            "models/items/nevermore/sf_immortal_flame_shoulder/sf_immortal_flame_shoulder.vmdl",
        }
    },
    [12678] = {
        ['item_id'] =12678,
        ['name'] ='Soul Corpulence - Head',
        ['icon'] ='econ/items/nevermore/sf_immortal_flame_head/sf_immortal_flame_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_immortal_flame_head/sf_immortal_flame_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulcorplence',
    },
    [12679] = {
        ['item_id'] =12679,
        ['name'] ='Soul Corpulence - Arms',
        ['icon'] ='econ/items/nevermore/sf_immortal_flame_arms/sf_immortal_flame_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='kynomi/models/sf_immortal_flame_arms/sf_immortal_flame_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'soulcorplence',
        ["OtherModelsPrecache"] =
        {
            "models/items/nevermore/sf_immortal_flame_arms/sf_immortal_flame_arms.vmdl",
        }
    },
    [22845] = 
    {
            ['item_id'] =22845,
            ['name'] ='Spring Lineage Horns of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_head/ferrum_chiroptera_head1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_head/ferrum_chiroptera_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9021, "#d8d8d8"}, {22845, "#9d4c78"}},
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ["MaterialGroupItem"] = "1",
            ['sets'] = 'eternalharverst',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_head_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [22844] = 
    {
            ['item_id'] =22844,
            ['name'] ='Spring Lineage Pauldrons of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_shoulder/ferrum_chiroptera_shoulder1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_shoulder/ferrum_chiroptera_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9020, "#d8d8d8"}, {22844, "#9d4c78"}},
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ["MaterialGroupItem"] = "1",
            ['sets'] = 'eternalharverst',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_ferrum/shadow_fiend_ferrum_shoulder_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [22843] = 
    {
            ['item_id'] =22843,
            ['name'] ='Spring Lineage Grips of Eternal Harvest',
            ['icon'] ='econ/items/nevermore/ferrum_chiroptera_arms/ferrum_chiroptera_arms1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/nevermore/ferrum_chiroptera_arms/ferrum_chiroptera_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9019, "#d8d8d8"}, {22843, "#9d4c78"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ["MaterialGroupItem"] = "1",
            ['sets'] = 'eternalharverst',
    },
    [18034] = 
    {
        ['item_id'] =18034,
        ['name'] ='Twilight Effigy Arms',
        ['icon'] ='econ/items/nevermore/harvest_effigy_arms/harvest_effigy_arms',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/harvest_effigy_arms/harvest_effigy_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'twilight_effigy',
    },
    [18035] = 
    {
        ['item_id'] =18035,
        ['name'] ='Twilight Effigy Head',
        ['icon'] ='econ/items/nevermore/harvest_effigy_head/harvest_effigy_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/harvest_effigy_head/harvest_effigy_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'twilight_effigy',
    },
    [18036] = 
    {
        ['item_id'] =18036,
        ['name'] ='Twilight Effigy Armor',
        ['icon'] ='econ/items/nevermore/harvest_effigy_shoulder/harvest_effigy_shoulder',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/harvest_effigy_shoulder/harvest_effigy_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'twilight_effigy',
    },

    [33211] = 
    {
        ['item_id'] =33211,
        ['name'] ='Lord of the Sundered Souls - Arms',
        ['icon'] ='econ/items/nevermore/lord_of_the_elder_dunes_arms/lord_of_the_elder_dunes_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/lord_of_the_elder_dunes_arms/lord_of_the_elder_dunes_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sundered_souls',
    },
    [33212] = 
    {
        ['item_id'] =33212,
        ['name'] ='Lord of the Sundered Souls - Head',
        ['icon'] ='econ/items/nevermore/lord_of_the_elder_dunes_head/lord_of_the_elder_dunes_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/lord_of_the_elder_dunes_head/lord_of_the_elder_dunes_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sundered_souls',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/elder_dunes/default/elder_dunes_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_POINT_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                }
            },
        },
    },
    [33210] = 
    {
        ['item_id'] =33210,
        ['name'] ='Lord of the Sundered Souls - Shoulders',
        ['icon'] ='econ/items/nevermore/lord_of_the_elder_dunes_shoulders/lord_of_the_elder_dunes_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/lord_of_the_elder_dunes_shoulders/lord_of_the_elder_dunes_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sundered_souls',
    },

    [26217] = 
    {
        ['item_id'] =26217,
        ['name'] ='Molten Maulers',
        ['icon'] ='econ/items/nevermore/sf_dark_lord_arms/sf_dark_lord_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_dark_lord_arms/sf_dark_lord_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'molten_monarch',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_dark_lord/sf_dark_lord_hands_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [26218] = 
    {
        ['item_id'] =26218,
        ['name'] ='Molten Maw',
        ['icon'] ='econ/items/nevermore/sf_dark_lord_head/sf_dark_lord_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_dark_lord_head/sf_dark_lord_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'molten_monarch',
    },
    [26216] = 
    {
        ['item_id'] =26216,
        ['name'] ='Molten Mantle',
        ['icon'] ='econ/items/nevermore/sf_dark_lord_shoulder/sf_dark_lord_shoulder',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nevermore/sf_dark_lord_shoulder/sf_dark_lord_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'molten_monarch',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/shadow_fiend/sf_dark_lord/sf_dark_lord_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
}