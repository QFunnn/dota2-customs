--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [8326] = 
    {
        ['item_id'] =8326,
        ['name'] ='World Chasm Artifact',
        ['icon'] ='econ/items/enigma/world_chasm/world_chasm',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/world_chasm/world_chasm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_enigma_immortal_chasm",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_world_chasm/enigma_world_chasm_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_L", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_R", "hero"
                    },
                    [3] = {"SetParticleControl", "default"},
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_ti5.vpcf",
            "particles/econ/items/enigma/enigma_world_chasm/status_effect_enigma_blackhole_tgt_ti5.vpcf",
            "particles/econ/items/enigma/enigma_world_chasm/enigma_blackhole_target_ti5.vpcf"
        }
    },

    [12330] = 
    {
        ['item_id'] =12330,
        ['name'] ='Armor of Twisted Maelstrom',
        ['icon'] ='econ/items/enigma/absolute_zero_updated_armour/absolute_zero_updated_armour',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/absolute_zero_updated_armour/absolute_zero_updated_armour.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'twisted_maelstrom',

        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_absolute_armour/enigma_absolute_armour_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ribbon_a"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ribbon_d"
                    },
                }
            },
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_absolute_armour/enigma_absolute_armour_body_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [12329] = 
    {
        ['item_id'] =12329,
        ['name'] ='Armguards of Twisted Maelstrom',
        ['icon'] ='econ/items/enigma/absolute_zero_updated_arms/absolute_zero_updated_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/absolute_zero_updated_arms/absolute_zero_updated_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'twisted_maelstrom',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_absolute_arms/enigma_absolute_arms_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [12332] = 
    {
        ['item_id'] =12332,
        ['name'] ='Eye of Twisted Maelstrom',
        ['icon'] ='econ/items/enigma/absolute_zero_updated_head/absolute_zero_updated_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/absolute_zero_updated_head/absolute_zero_updated_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_enigma_twisted_maelstrom_ambient",
        ['sets'] = 'twisted_maelstrom',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_absolute_head/enigma_absolute_head_ambient_eye.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            }
        },
    },

    [14749] = 
    {
        ['item_id'] =14749,
        ['name'] ='Evolution of the Infinite Hood',
        ['icon'] ='econ/items/enigma/enigma_seer_of_infinity_space_head/enigma_seer_of_infinity_space_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/enigma_seer_of_infinity_space_head/enigma_seer_of_infinity_space_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'evolution_infinite',
    },
    [14750] = 
    {
        ['item_id'] =14750,
        ['name'] ='Evolution of the Infinite Armor',
        ['icon'] ='econ/items/enigma/enigma_seer_of_infinity_space_armor/enigma_seer_of_infinity_space_armor',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/enigma_seer_of_infinity_space_armor/enigma_seer_of_infinity_space_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'evolution_infinite',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/ti10_seer_of_infinity_armor/ti10_enigma_seer_of_infinity_armor.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Left_planet_1"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Right_planet_1"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Left_planet_1"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Right_planet_1"
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Left_planet_1"
                    },
                    [15] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Right_planet_1"
                    },
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Spine_3"
                    },
                    [30] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_back2"
                    },
                    [31] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_front2"
                    },
                    [32] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_back2"
                    },
                    [33] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_front2"
                    },
                    [34] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_back2"
                    },
                    [35] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "planet_front2"
                    },
                }
            }
        },
    },
    [14751] = 
    {
        ['item_id'] =14751,
        ['name'] ='Evolution of the Infinite Bracers',
        ['icon'] ='econ/items/enigma/enigma_seer_of_infinity_space_arms/enigma_seer_of_infinity_space_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/enigma_seer_of_infinity_space_arms/enigma_seer_of_infinity_space_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'evolution_infinite',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/ti10_seer_of_infinity_elbows/ti10_seer_of_infinity_elbows.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_L"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_R"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_L"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_R"
                    },
                }
            }
        },
    },

    [13021] = 
    {
        ['item_id'] =13021,
        ['name'] ='Turban of Mortal Deception',
        ['icon'] ='econ/items/enigma/ti9_cache_enigma_lord_of_luminaries_head/ti9_cache_enigma_lord_of_luminaries_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/ti9_cache_enigma_lord_of_luminaries_head/ti9_cache_enigma_lord_of_luminaries_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mortal_deceiption',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/ti9_cache_enigma_lord_head/ti9_cache_enigma_lord_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [13023] = 
    {
        ['item_id'] =13023,
        ['name'] ='Armor of Mortal Deception',
        ['icon'] ='econ/items/enigma/ti9_cache_enigma_lord_of_luminaries_armor/ti9_cache_enigma_lord_of_luminaries_armor',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/ti9_cache_enigma_lord_of_luminaries_armor/ti9_cache_enigma_lord_of_luminaries_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mortal_deceiption',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/ti9_cache_enigma_lord_armor/ti9_cache_enigma_lord_armor_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ball"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_back"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_front"
                    },
                }
            }
        },
    },
    [13022] = 
    {
        ['item_id'] =13022,
        ['name'] ='Bracer of Mortal Deception',
        ['icon'] ='econ/items/enigma/ti9_cache_enigma_lord_of_luminaries_arms/ti9_cache_enigma_lord_of_luminaries_arms',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/ti9_cache_enigma_lord_of_luminaries_arms/ti9_cache_enigma_lord_of_luminaries_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mortal_deceiption',
    },

    [32988] = 
    {
        ['item_id'] =32988,
        ['name'] ='Graviton Blackguard - Helm',
        ['icon'] ='econ/items/enigma/cosmic_conqueror_crown/cosmic_conqueror_crown',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/cosmic_conqueror_crown/cosmic_conqueror_crown.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'graviton_blackguard',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_cosmic/enigma_cosmic_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_orb"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_visor"
                    },
                }
            }
        },
    },
    [32987] = 
    {
        ['item_id'] =32987,
        ['name'] ='Graviton Blackguard - Arms',
        ['icon'] ='econ/items/enigma/cosmic_conqueror_claws/cosmic_conqueror_claws',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/cosmic_conqueror_claws/cosmic_conqueror_claws.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'graviton_blackguard',
    },
    [32986] = 
    {
        ['item_id'] =32986,
        ['name'] ='Graviton Blackguard - Armor',
        ['icon'] ='econ/items/enigma/cosmic_conqueror_armor/cosmic_conqueror_armor',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/cosmic_conqueror_armor/cosmic_conqueror_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_graviton_enigma_ambient",
        ['sets'] = 'graviton_blackguard',
        ['ParticlesHero'] = {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/enigma_cosmic/enigma_cosmic_armor_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
            }
        },
        -- ['ParticlesItems'] = 
        -- {
        --     {
        --         ['ParticleName'] = 'particles/econ/items/enigma/enigma_cosmic/enigma_cosmic_armor_ambient.vpcf',
        --         ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
        --         ["IsHero"] = 1,
        --         ['ControllPoints'] = 
        --         {
        --             [0] = {"SetParticleControl", "default"},
        --             [1] = {"SetParticleControl", "default"},
        --             [2] = {"SetParticleControl", "default"},
        --         }
        --     }
        -- },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/cosmic_conqueror_armor/cosmic_conqueror_armor_skirt.vmdl"
        },
    },

    [6480] = 
    {
        ["item_id"] = 6480,
        ["name"] = "Geodesic Eidolon",
        ["icon"] = "econ/items/enigma/eidolon/geodesic/geodesic_npc_dota_lesser_eidolon",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_1",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/enigma/enigma_geodesic/enigma_base_attack_eidolon_geodesic.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/geodesic/geodesic.vmdl"
        },
    },
    [12331] = 
    {
        ["item_id"] = 12331,
        ["name"] = "Eidelon of Twisted Maelstrom",
        ["icon"] = "econ/items/enigma/eidolon/absolute_zero_updated_eidolon/absolute_zero_updated_eidolon_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_2",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/absolute_zero_updated_eidolon/absolute_zero_updated_eidolon.vmdl"
        },
    },
    [32989] = 
    {
        ["item_id"] = 32989,
        ["name"] = "Graviton Blackguard Probe",
        ["icon"] = "econ/items/enigma/eidolon/cosmic_probe/cosmic_probe_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_3",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/cosmic_probe/cosmic_probe.vmdl"
        },
    },
    [9473] = 
    {
        ["item_id"] = 9473,
        ["name"] = "Servants of Endless Stars",
        ["icon"] = "econ/items/enigma/eidolon/tentacular_conqueror_tentacular_conqueror_eidolons/tentacular_conqueror_tentacular_conqueror_eidolons_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_4",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/tentacular_conqueror_tentacular_conqueror_eidolons/tentacular_conqueror_tentacular_conqueror_eidolons.vmdl"
        },
    },
    [17976] = 
    {
        ["item_id"] = 17976,
        ["name"] = "Patterns of the Pristine Eidelons",
        ["icon"] = "econ/items/enigma/eidolon/life_cycle_life_cycle_eidolons/life_cycle_life_cycle_eidolons_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_5",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/life_cycle_life_cycle_eidolons/life_cycle_life_cycle_eidolons.vmdl"
        },
    },
    [14748] = 
    {
        ["item_id"] = 14748,
        ["name"] = "Evolution of the Infinite Eidolon",
        ["icon"] = "econ/items/enigma/eidolon/enigma_seer_of_infinity_space_eidolon/enigma_seer_of_infinity_space_eidolon_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_6",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/enigma_seer_of_infinity_space_eidolon/enigma_seer_of_infinity_space_eidolon.vmdl"   
        },
    },
    [13401] = 
    {
        ["item_id"] = 13401,
        ["name"] = "Astral Terminus - Eidolon",
        ["icon"] = "econ/items/enigma/eidolon/world_eater_eidelon/world_eater_eidelon_npc_dota_eidolon",
        ["price"] = 400,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_7",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/world_eater_eidelon/world_eater_eidelon.vmdl"
        },
    },
    [9352] = 
    {
        ["item_id"] = 9352,
        ["name"] = "Eidolons of Abyssal Vortex",
        ["icon"] = "econ/items/enigma/eidolon/artifacts_of_crushing_depths_eidolon_of_crushing_depths/artifacts_of_crushing_depths_eidolon_of_crushing_depths_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_8",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/artifacts_of_crushing_depths_eidolon_of_crushing_depths/artifacts_of_crushing_depths_eidolon_of_crushing_depths.vmdl"
        },
    },
    [13020] = 
    {
        ["item_id"] = 13020,
        ["name"] = "Eidelon of Mortal Deception",
        ["icon"] = "econ/items/enigma/eidolon/ti9_cache_enigma_lord_of_luminaries_eidolons/ti9_cache_enigma_lord_of_luminaries_eidolons_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_9",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/ti9_cache_enigma_lord_of_luminaries_eidolons/ti9_cache_enigma_lord_of_luminaries_eidolons.vmdl"
        },
    },


    [32864] = 
    {
        ['item_id'] =32864,
        ['name'] ='Angel of the Abyss - Fetters',
        ['icon'] ='econ/items/enigma/armisaels_shackles/armisaels_shackles',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/armisaels_shackles/armisaels_shackles.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'angel_abyss',
    },
    [32862] = 
    {
        ['item_id'] =32862,
        ['name'] ='Angel of the Abyss - Armor',
        ['icon'] ='econ/items/enigma/armisaels_galactic_maw/armisaels_galactic_maw',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/armisaels_galactic_maw/armisaels_galactic_maw.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_enigma_angel_abyss_armor",
        ['sets'] = 'angel_abyss',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/enigma/angel_abyss/angel_abyss_armor_ambient.vpcf",
        },
        ['ParticlesHero'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/enigma/angel_abyss/angel_abyss_armor_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
            }
        },
    },
    [32861] = 
    {
        ['item_id'] =32861,
        ['name'] ='Angel of the Abyss - Halo',
        ['icon'] ='econ/items/enigma/armisaels_fallen_halo/armisaels_fallen_halo',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/enigma/armisaels_fallen_halo/armisaels_fallen_halo.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_enigma_angel_abyss_head",
        ['sets'] = 'angel_abyss',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/enigma/angel_abyss/angel_abyss_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_POINT_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_center"
                    },
                }
            },
        },
    },
    [32863] = 
    {
        ["item_id"] = 32863,
        ["name"] = "Angel of the Abyss - Servants",
        ["icon"] = "econ/items/enigma/eidolon/armisaels_severed_shades/armisaels_severed_shades_npc_dota_eidolon",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "enigma_eidelon",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_enigma_eidolon_custom_10",
        ['sets'] = "enigma_eidolons",
        ["ParticlesSkills"] =
        {
            
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/enigma/eidolon/armisaels_severed_shades/armisaels_severed_shades.vmdl"
        },
    },
}