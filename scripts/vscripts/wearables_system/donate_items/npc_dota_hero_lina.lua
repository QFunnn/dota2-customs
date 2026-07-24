--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [12217] = 
    {
        ['item_id'] =12217,
        ['name'] ='The Scarlet Flare Belt',
        ['icon'] ='econ/items/lina/the_scarlet_flare_belt/the_scarlet_flare_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_belt/the_scarlet_flare_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12217, "#d74f2a"}, {122171, "#2939b3"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_scarlet_flare/lina_scarlet_flare_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_foot_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_foot_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_purse_fx"
                    },
                }
            },
        },
    },
    [122171] = 
    {
        ["dota_id"] = 12217,
        ["ItemStyle"] = "1",
        ['item_id'] =122171,
        ['name'] ='The Scarlet Flare Belt',
        ['icon'] ='econ/items/lina/the_scarlet_flare_belt/the_scarlet_flare_belt_style1',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_belt/the_scarlet_flare_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['MaterialGroupItem'] = "1",
        ['OtherItemsBundle'] = {{12217, "#d74f2a"}, {122171, "#2939b3"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_scarlet_flare/lina_scarlet_flare_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_foot_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_foot_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_purse_fx"
                    },
                }
            },
        },   
    },
    [12228] = 
    {
        ['item_id'] =12228,
        ['name'] ='The Scarlet Flare Neck',
        ['icon'] ='econ/items/lina/the_scarlet_flare_neck/the_scarlet_flare_neck',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_neck/the_scarlet_flare_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12228, "#d74f2a"}, {122281, "#2939b3"}},
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
    },
    [122281] = 
    {
        ["dota_id"] = 12228,
        ["ItemStyle"] = "1",
        ['item_id'] =122281,
        ['name'] ='The Scarlet Flare Neck',
        ['icon'] ='econ/items/lina/the_scarlet_flare_neck/the_scarlet_flare_neck_style1',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_neck/the_scarlet_flare_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['MaterialGroupItem'] = "1",
        ['OtherItemsBundle'] = {{12228, "#d74f2a"}, {122281, "#2939b3"}},
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
    },
    [12229] = 
    {
        ['item_id'] =12229,
        ['name'] ='The Scarlet Flare Head',
        ['icon'] ='econ/items/lina/the_scarlet_flare_head/the_scarlet_flare_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_head/the_scarlet_flare_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12229, "#d74f2a"}, {122291, "#2939b3"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_scarlet_flare/lina_scarlet_flare_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [122291] = 
    {
        ["dota_id"] = 12229,
        ["ItemStyle"] = "1",
        ['item_id'] =122291,
        ['name'] ='The Scarlet Flare Head',
        ['icon'] ='econ/items/lina/the_scarlet_flare_head/the_scarlet_flare_head_style1',
        ['price'] = 600,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_head/the_scarlet_flare_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['MaterialGroupItem'] = "1",
        ['OtherItemsBundle'] = {{12229, "#d74f2a"}, {122291, "#2939b3"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_scarlet_flare/lina_scarlet_flare_head_v1.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [12227] = 
    {
        ['item_id'] =12227,
        ['name'] ='The Scarlet Flare Arms',
        ['icon'] ='econ/items/lina/the_scarlet_flare_arms/the_scarlet_flare_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_arms/the_scarlet_flare_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{12227, "#d74f2a"}, {122271, "#2939b3"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
    },
    [122271] = 
    {
        ["dota_id"] = 12227,
        ["ItemStyle"] = "1",
        ['item_id'] =122271,
        ['name'] ='The Scarlet Flare Arms',
        ['icon'] ='econ/items/lina/the_scarlet_flare_arms/the_scarlet_flare_arms_style1',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/the_scarlet_flare_arms/the_scarlet_flare_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['MaterialGroupItem'] = "1",
        ['OtherItemsBundle'] = {{12227, "#d74f2a"}, {122271, "#2939b3"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'scarlet_flare',
    },
    [14247] = 
    {
        ['item_id'] =14247,
        ['name'] ='Glory of the Elderflame - Belt',
        ['icon'] ='econ/items/lina/blazing_cosmos_belt/blazing_cosmos_belt',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/blazing_cosmos_belt/blazing_cosmos_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blazing_cosmos',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_blazing_cosmos/lina_blazing_cosmos_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14248] = 
    {
        ['item_id'] =14248,
        ['name'] ='Glory of the Elderflame - Arms',
        ['icon'] ='econ/items/lina/blazing_cosmos_arms/blazing_cosmos_arms',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/blazing_cosmos_arms/blazing_cosmos_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blazing_cosmos',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_blazing_cosmos/lina_blazing_cosmos_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14250] = 
    {
        ['item_id'] =14250,
        ['name'] ='Glory of the Elderflame - Neck',
        ['icon'] ='econ/items/lina/blazing_cosmos_neck/blazing_cosmos_neck',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/blazing_cosmos_neck/blazing_cosmos_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blazing_cosmos',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_blazing_cosmos/lina_blazing_cosmos_neck.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14251] = 
    {
        ['item_id'] =14251,
        ['name'] ='Glory of the Elderflame - Head',
        ['icon'] ='econ/items/lina/blazing_cosmos_head/blazing_cosmos_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/lina/blazing_cosmos_head/blazing_cosmos_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blazing_cosmos',
    },
    
    
    [27551] = 
    {
        ['item_id'] =27551,
        ['name'] ='Dead Heat Coronet',
        ['icon'] ='econ/items/lina/lina_calavera/lina_calavera_head',
        ['price'] = 150,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = "2",
        ['ItemModel'] ='models/items/lina/lina_calavera/lina_calavera_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_calavera',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_revenants_cinder/lina_revenants_cinder_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_001"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_002"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_003"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_004"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_005"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_r"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_l"
                    },
                }
            },
        },
    },
    [27550] = 
    {
        ['item_id'] =27550,
        ['name'] ='Dead Heat Bodice',
        ['icon'] ='econ/items/lina/lina_calavera/lina_calavera_neck',
        ['price'] = 350,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/lina_calavera/lina_calavera_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_calavera',
    },
    [27548] = 
    {
        ['item_id'] =27548,
        ['name'] ='Dead Heat Gloves',
        ['icon'] ='econ/items/lina/lina_calavera/lina_calavera_arms',
        ['price'] = 150,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/lina_calavera/lina_calavera_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_calavera',
    },
    [27564] = 
    {
        ['item_id'] =27564,
        ['name'] ='Dead Heat Gown',
        ['icon'] ='econ/items/lina/lina_calavera/lina_calavera_belt',
        ['price'] = 350,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/lina_calavera/lina_calavera_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_calavera',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_revenants_cinder/lina_revenants_cinder_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [8003] = 
    {
        ['item_id'] =8003,
        ['name'] ='Disciple of the Wyrmwrought Flame',
        ['icon'] ='econ/items/lina/lina_immortal_ii/mesh/lina_immortal_ii',
        ['price'] = 5000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/lina_immortal_ii/mesh/lina_immortal_ii.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lina_immortal_ii_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_ti6/lina_ti6_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lina/lina_ti6/lina_ti6_laguna_blade.vpcf"
        }
    },
    [7741] = 
    {
        ['item_id'] =7741,
        ['name'] ='Golden Wyrmwrought Flare',
        ['icon'] ='econ/items/lina/lina_ti7/lina_ti71',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/lina/lina_ti7/lina_ti7.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lina_immrotal_ti7_custom_golden",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_ti7/lina_ti7_gold_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7_gold.vpcf",
            "particles/econ/items/lina/lina_ti7/light_strike_array_pre_ti7_gold.vpcf"
        }
    },
    
    [9243] = 
    {
        ['item_id'] =9243,
        ['name'] ='Wyrmwrought Flare',
        ['icon'] ='econ/items/lina/lina_ti7/lina_ti7',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/lina_ti7/lina_ti7.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lina_immrotal_ti7_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_ti7/lina_ti7_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf",
            "particles/econ/items/lina/lina_ti7/light_strike_array_pre_ti7.vpcf"
        }
    },
    
    [4794] = 
    {
        ['item_id'] =4794,
        ['name'] ='Fiery Soul of the Slayer',
        ['icon'] ='econ/items/lina/origins_flamehair/origins_flamehair',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = "1",
        ['ItemModel'] ='models/items/lina/origins_flamehair/origins_flamehair.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_arcana_lina_custom",
        ['sets'] = 'rare',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_head_headflame/lina_headflame.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head", "hero",
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/lina/lina_head_headflame/lina_flame_hand_dual_headflame.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero",
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_headflame.vpcf",
            "particles/econ/items/lina/lina_head_headflame/lina_spell_dragon_slave_impact_headflame.vpcf",
        }
    },
    [32931] = 
    {
        ['item_id'] =32931,
        ['name'] ='Flame of Origin - Arms',
        ['icon'] ='econ/items/lina/flame_of_origin_arm_genesis/flame_of_origin_arm_genesis',
        ['price'] = 600,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{32931, "#fcb63b"}, {329311, "#fd614c"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
    [32932] = 
    {
        ['item_id'] =32932,
        ['name'] ='Flame of Origin - Belt',
        ['icon'] ='econ/items/lina/flame_of_origin_belt_genesis/flame_of_origin_belt_genesis',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{32932, "#fcb63b"}, {329321, "#fd614c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
    [32929] = 
    {
        ['item_id'] =32929,
        ['name'] ='Flame of Origin - Head',
        ['icon'] ='econ/items/lina/flame_of_origin_head_genesis/flame_of_origin_head_genesis',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{32929, "#fcb63b"}, {329291, "#fd614c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ['is_exclusive'] = 1,
        ----['Modifier'] = "modifier_lina_cosmic_body_group",
        ['sets'] = 'lina_flame_origin',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/flame_origin/flame_origin_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero",
                    },
                }
            },
        },
    },
    [32930] = 
    {
        ['item_id'] =32930,
        ['name'] ='Flame of Origin - Neck',
        ['icon'] ='econ/items/lina/flame_of_origin_neck_genesis/flame_of_origin_neck_genesis',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{32930, "#fcb63b"}, {329301, "#fd614c"}},
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
    [329311] = 
    {
        ["dota_id"] = 32931,
        ["ItemStyle"] = "1",
        ['item_id'] =329311,
        ['name'] ='Flame of Origin - Arms',
        ['icon'] ='econ/items/lina/flame_of_origin_arm_genesis/flame_of_origin_arm_genesis',
        ['price'] = 1,
        ['HeroModel'] = nil,
        
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{32931, "#fcb63b"}, {329311, "#fd614c"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
    [329321] = 
    {
        ["dota_id"] = 32932,
        ["ItemStyle"] = "1",
        ['item_id'] =329321,
        ['name'] ='Flame of Origin - Belt',
        ['icon'] ='econ/items/lina/flame_of_origin_belt_genesis/flame_of_origin_belt_genesis_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{32932, "#fcb63b"}, {329321, "#fd614c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
    [329291] = 
    {
        ["dota_id"] = 32929,
        ["ItemStyle"] = "1",
        ['item_id'] =329291,
        ['name'] ='Flame of Origin - Head',
        ['icon'] ='econ/items/lina/flame_of_origin_head_genesis/flame_of_origin_head_genesis_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{32929, "#fcb63b"}, {329291, "#fd614c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ['is_exclusive'] = 1,
        ----['Modifier'] = "modifier_lina_cosmic_body_group",
        ['sets'] = 'lina_flame_origin',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lina/flame_origin/flame_origin_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero",
                    },
                }
            },
        },
    },
    [329301] = 
    {
        ["dota_id"] = 32930,
        ["ItemStyle"] = "1",
        ['item_id'] =329301,
        ['name'] ='Flame of Origin - Neck',
        ['icon'] ='econ/items/lina/flame_of_origin_neck_genesis/flame_of_origin_neck_genesis_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/lina/flame_of_origin/flame_of_origin_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{32930, "#fcb63b"}, {329301, "#fd614c"}},
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lina_flame_origin',
    },
}