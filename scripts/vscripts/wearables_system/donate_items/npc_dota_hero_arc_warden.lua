--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [13535] = 
    {
        ['item_id'] =13535,
        ['name'] ='Wraithbinder',
        ['icon'] ='econ/items/arc_warden/aw_ti9_immortal_shoulders/aw_ti9_immortal_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/aw_ti9_immortal_shoulders/aw_ti9_immortal_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_arc_warden_ti9_immortal_shoulders",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_finger_l_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_finger_r_02_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_finger_l_02_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_finger_r_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_01_fx"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_02_fx"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_01_fx"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_02_fx"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_l"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_r"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith.vpcf",
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_prj.vpcf",
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_wraith_cast.vpcf",
            "particles/econ/items/arc_warden/arc_warden_ti9_immortal/arc_warden_ti9_immortal_ambient.vpcf",
        },
    },
    [24762] = 
    {
        ['item_id'] =24762,
        ['name'] ='Orbuculum Equinox',
        ['icon'] ="econ/heroes/arc_warden/frostivus_arc_warden_head",
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/arc_warden/arc_warden_frostivus/arc_warden_frostivus_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{24762, "#f2504a"}, {24763, "#82d268"}, {24764, "#77a6e0"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_arc_warden_frostivus_head",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_snow"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "arc_warden/arc_warden_magnetic_ti9.vpcf",
            "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
        },
    },
    [24763] = 
    {
        ["dota_id"] = 24762,
        ["ItemStyle"] = "1",
        ['item_id'] =24763,
        ['name'] ='Orbuculum Equinox',
        ['icon'] ="econ/heroes/arc_warden/frostivus_arc_warden_head_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/arc_warden/arc_warden_frostivus/arc_warden_frostivus_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{24762, "#f2504a"}, {24763, "#82d268"}, {24764, "#77a6e0"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_arc_warden_frostivus_head",
        ['sets'] = 'head',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_snow"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "arc_warden/arc_warden_magnetic_ti9.vpcf",
            "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
        },
    },
    [24764] = 
    {
        ["dota_id"] = 24762,
        ["ItemStyle"] = "2",
        ['item_id'] =24764,
        ['name'] ='Orbuculum Equinox',
        ['icon'] = "econ/heroes/arc_warden/frostivus_arc_warden_head_style2",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/arc_warden/arc_warden_frostivus/arc_warden_frostivus_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{24762, "#f2504a"}, {24763, "#82d268"}, {24764, "#77a6e0"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_arc_warden_frostivus_head",
        ['sets'] = 'head',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_snow"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "arc_warden/arc_warden_magnetic_ti9.vpcf",
            "particles/econ/items/arc_warden/arc_warden_frostivus_2023/arc_warden_frostivus_head_ambient.vpcf",
        },
    },
    [13826] = 
    {
        ['item_id'] =13826,
        ['name'] ='Ire of the Ancient Gaoler Head',
        ['icon'] ='econ/items/arc_warden/wicked_space_knight_head/wicked_space_knight_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/wicked_space_knight_head/wicked_space_knight_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ire_ancient_gaoler',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_ti10_cache/arc_warden_ti10_cache_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [13827] = 
    {
        ['item_id'] =13827,
        ['name'] ='Ire of the Ancient Gaoler Back',
        ['icon'] ='econ/items/arc_warden/wicked_space_knight_back/wicked_space_knight_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/wicked_space_knight_back/wicked_space_knight_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ire_ancient_gaoler',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_ti10_cache/arc_warden_ti10_cache_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [13828] = 
    {
        ['item_id'] =13828,
        ['name'] ='Ire of the Ancient Gaoler Arms',
        ['icon'] ='econ/items/arc_warden/wicked_space_knight_arms/wicked_space_knight_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/wicked_space_knight_arms/wicked_space_knight_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ire_ancient_gaoler',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_arc_warden/arc_warden_bracer_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_ti10_cache/arc_warden_ti10_cache_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [13825] = 
    {
        ['item_id'] =13825,
        ['name'] ='Ire of the Ancient Gaoler Shoulder',
        ['icon'] ='econ/items/arc_warden/wicked_space_knight_shoulder/wicked_space_knight_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/wicked_space_knight_shoulder/wicked_space_knight_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ire_ancient_gaoler',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_ti10_cache/arc_warden_ti10_cache_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [31352] = 
    {
        ['item_id'] =31352,
        ['name'] ='Ancient Annihilator - Arm',
        ['icon'] ='econ/items/arc_warden/magnetite_abyss_watcher_arm/magnetite_abyss_watcher_arm',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/magnetite_abyss_watcher_arm/magnetite_abyss_watcher_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ancient_annihilator',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_arc_warden/arc_warden_bracer_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            },
        },
    },
    [31354] = 
    {
        ['item_id'] =31354,
        ['name'] ='Ancient Annihilator - Head',
        ['icon'] ='econ/items/arc_warden/magnetite_abyss_watcher_head/magnetite_abyss_watcher_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/magnetite_abyss_watcher_head/magnetite_abyss_watcher_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ancient_annihilator',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/arc_warden/arc_warden_magnetite_artifact_of_abyss_watcher/arc_warden_magnetite_artifact_of_abyss_watcher_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye"
                    },
                }
            },
        },
    },
    [31353] = 
    {
        ['item_id'] =31353,
        ['name'] ='Ancient Annihilator - Shoulders',
        ['icon'] ='econ/items/arc_warden/magnetite_abyss_watcher_shoulders/magnetite_abyss_watcher_shoulders',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/magnetite_abyss_watcher_shoulders/magnetite_abyss_watcher_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ancient_annihilator',
    },
    [31351] = 
    {
        ['item_id'] =31351,
        ['name'] ='Ancient Annihilator - Back',
        ['icon'] ='econ/items/arc_warden/magnetite_abyss_watcher_back/magnetite_abyss_watcher_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/magnetite_abyss_watcher_back/magnetite_abyss_watcher_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ancient_annihilator',
    },
    [13356] = 
    {
        ['item_id'] =13356,
        ['name'] ='Mask of Dormant Oblivion',
        ['icon'] ='econ/items/arc_warden/ti9_cache_aw_ancient_mechanism_head/ti9_cache_aw_ancient_mechanism_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/ti9_cache_aw_ancient_mechanism_head/ti9_cache_aw_ancient_mechanism_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mask_of_dormant',
    },
    [13355] = 
    {
        ['item_id'] =13355,
        ['name'] ='Pauldrons of Dormant Oblivion',
        ['icon'] ='econ/items/arc_warden/ti9_cache_aw_ancient_mechanism_shoulder/ti9_cache_aw_ancient_mechanism_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/ti9_cache_aw_ancient_mechanism_shoulder/ti9_cache_aw_ancient_mechanism_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mask_of_dormant',
    },
    [13357] = 
    {
        ['item_id'] =13357,
        ['name'] ='Cloak of Dormant Oblivion',
        ['icon'] ='econ/items/arc_warden/ti9_cache_aw_ancient_mechanism_back/ti9_cache_aw_ancient_mechanism_back',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/ti9_cache_aw_ancient_mechanism_back/ti9_cache_aw_ancient_mechanism_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mask_of_dormant',
    },
    [13358] = 
    {
        ['item_id'] =13358,
        ['name'] ='Arms of Dormant Oblivion',
        ['icon'] ='econ/items/arc_warden/ti9_cache_aw_ancient_mechanism_arms/ti9_cache_aw_ancient_mechanism_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/arc_warden/ti9_cache_aw_ancient_mechanism_arms/ti9_cache_aw_ancient_mechanism_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mask_of_dormant',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_arc_warden/arc_warden_bracer_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            },
        },
    },

    [36026] = {
['item_id'] =36026,
['name'] ='Palms of Prophecy - Back',
['icon'] ='econ/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_back',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'palms_prophecy',
},
[36027] = {
['item_id'] =36027,
['name'] ='Palms of Prophecy - Arms',
['icon'] ='econ/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_arms',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_arms.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'arms',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'palms_prophecy',
},
[36029] = {
['item_id'] =36029,
['name'] ='Palms of Prophecy - Head',
['icon'] ='econ/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_head',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'palms_prophecy',
},
[36028] = {
['item_id'] =36028,
['name'] ='Palms of Prophecy - Shoulder',
['icon'] ='econ/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_shoulders',
['price'] = 800,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/arc_warden/arc_warden_dark_carnival/arc_warden_dark_carnival_shoulders.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'shoulder',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'palms_prophecy',
},
}