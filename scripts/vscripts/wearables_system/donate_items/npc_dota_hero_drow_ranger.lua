--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [19091] = 
    {
        ['item_id'] =19091,
        ['name'] ='Dread Retribution - Leg Armor',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_legs',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19091, "#24abe0"}, {190911, "#e6321e"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
    },
    [19092] = 
    {
        ['item_id'] =19092,
        ['name'] ='Dread Retribution - Quiver',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_quiver',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19092, "#24abe0"}, {190921, "#e6321e"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
    },
    [19093] = 
    {
        ['item_id'] =19093,
        ['name'] ='Dread Retribution - Shoulder Armor',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_shoulder',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19093, "#24abe0"}, {190931, "#e6321e"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
    },
    [19094] = 
    {
        ['item_id'] =19094,
        ['name'] ='Dread Retribution - Headwear',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19094, "#24abe0"}, {190941, "#e6321e"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
    },
    [19090] = 
    {
        ['item_id'] =19090,
        ['name'] ='Dread Retribution',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_weapon',
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/drow/drow_arcana/drow_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['is_exclusive'] = 1,
        ['OtherItemsBundle'] = {{19090, "#24abe0"}, {190901, "#e6321e"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_arcana_custom",
        ['sets'] = 'drow_arcana',
        ['ParticlesHero'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/drow/drow_arcana/drow_arcana_footsteps.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ['ParticleName'] = 'particles/econ/items/drow/drow_arcana/drow_arcana_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_arcana/drow_arcana_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_tip_fx",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_top_r_fx",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_top_l_fx",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_bot_l_fx",
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_bot_r_fx",
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_01",
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_02",
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_03",
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx",
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/drow/drow_arcana/drow_arcana_crit_or_marksmanship_proc_frost.vpcf",
            "particles/drow_ranger/multi_proj_scepter_arcana.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silenced.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silence_wave.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_base_attack.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_attack.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow_debuff.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_frost_arrow.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_buff.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silence_impact_dust.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
           "models/items/drow/drow_arcana/drow_arcana_shoulder.vmdl",
           "models/items/drow/drow_arcana/drow_arcana_back.vmdl",
        }
    },
    [19088] = 
    {
        ['item_id'] =19088,
        ['name'] ='Dread Retribution - Bracers',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_arms',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19088, "#24abe0"}, {190881, "#e6321e"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_arcana/drow_arcana_arm_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_r_fx", "hero",
                    },
                }
            },
        },
    },
    [19089] = 
    {
        ['item_id'] =19089,
        ['name'] ='Dread Retribution - Cape',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_back',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{19089, "#24abe0"}, {190891, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
    },

    -- 2 style
    [190911] = 
    {
        ["dota_id"] = 19091,
        ["ItemStyle"] = "1",
        ['item_id'] =190911,
        ['name'] ='Dread Retribution - Leg Armor',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_legs',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19091, "#24abe0"}, {190911, "#e6321e"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
    },
    [190921] = 
    {
        ["dota_id"] = 19092,
        ["ItemStyle"] = "1",
        ['item_id'] =190921,
        ['name'] ='Dread Retribution - Quiver',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_quiver',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19092, "#24abe0"}, {190921, "#e6321e"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
    },
    [190931] = 
    {
        ["dota_id"] = 19093,
        ["ItemStyle"] = "1",
        ['item_id'] =190931,
        ['name'] ='Dread Retribution - Shoulder Armor',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_shoulder',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19093, "#24abe0"}, {190931, "#e6321e"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
    },
    [190941] = 
    {
        ["dota_id"] = 19094,
        ["ItemStyle"] = "1",
        ['item_id'] =190941,
        ['name'] ='Dread Retribution - Headwear',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_head',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19094, "#24abe0"}, {190941, "#e6321e"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
    },
    [190901] = 
    {
        ["dota_id"] = 19090,
        ["ItemStyle"] = "1",
        ['item_id'] =190901,
        ['name'] ='Dread Retribution',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_weapon_style1',
        ['price'] = 1,
        ['HeroModel'] = "models/items/drow/drow_arcana/drow_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{19090, "#24abe0"}, {190901, "#e6321e"}},
        ['SlotType'] = 'weapon',
        ['is_exclusive'] = 1,
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_arcana_custom_v2",
        ['sets'] = 'drow_arcana',
        ['ParticlesHero'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/drow/drow_arcana/drow_arcana_v2_footsteps.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ['ParticleName'] = 'particles/econ/items/drow/drow_arcana/drow_arcana_ambient_v2.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ['ParticleName'] = 'particles/econ/items/drow/drow_arcana/drow_arcana_ambient_head.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r",
                    },
                }
            },
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_arcana/drow_arcana_weapon_v2_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_tip_fx",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_top_r_fx",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_top_l_fx",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_bot_l_fx",
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_flywheel_bot_r_fx",
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_01",
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_02",
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frost_arrow_fx_03",
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx",
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/drow/drow_arcana/drow_arcana_crit_or_marksmanship_proc_frost.vpcf",
            "particles/drow_ranger/multi_proj_scepter_arcana_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silenced_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silence_wave_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow_debuff_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_frost_arrow_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_base_attack_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_attack.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_v2_marksmanship_frost_arrow.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_buff_v2.vpcf",
            "particles/econ/items/drow/drow_arcana/drow_arcana_silence_impact_v2_dust.vpcf",
        }
    },
    [190881] = 
    {
        ["dota_id"] = 19088,
        ["ItemStyle"] = "1",
        ['item_id'] =190881,
        ['name'] ='Dread Retribution - Bracers',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_arms',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19088, "#24abe0"}, {190881, "#e6321e"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_arcana/drow_arcana_arm_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_r_fx", "hero",
                    },
                }
            },
        },
    },
    [190891] = 
    {
        ["dota_id"] = 19089,
        ["ItemStyle"] = "1",
        ['item_id'] =190891,
        ['name'] ='Dread Retribution - Cape',
        ['icon'] ='econ/items/drow/dread_retribution/drow_arcana_back',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_arcana/drow_arcana_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{19089, "#24abe0"}, {190891, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
    },

    [12946] = 
    {
        ['item_id'] =12946,
        ['name'] ='Reapers Wreath',
        ['icon'] ='econ/items/drow/drow_ti9_immortal_weapon/drow_ti9_immortal_weapon',
        ['price'] = 2000,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_ti9_immortal_weapon/drow_ti9_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_ti9_immortal_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_top"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_mid"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_bot"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bow_tip_r"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bow_tip_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_center_offset"
                    },
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_base_attack.vpcf",
            "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_frost_arrow.vpcf",
            "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_marksman.vpcf",
            "particles/econ/items/drow/drow_ti9_immortal/drow_ti9_marksman_frost.vpcf",
        }
    },
    [5386] = 
    {
        ['item_id'] =5386,
        ['name'] ='Monarch Bow',
        ['icon'] ='econ/items/drow/monarch_weapon/monarch_weapon',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/drow/monarch_weapon/monarch_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_monarch_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_bow_monarch/drow_bowstring_monarch.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_bot"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_mid"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_top"
                    },
                }
            },
        },
    },
    [8006] = 
    {
        ['item_id'] =8006,
        ['name'] ='Silent Wake',
        ['icon'] ='econ/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape',
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8006, "#2479d4"}, {8035, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_ti6_cape_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_ti6/drow_ti6_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/drow/drow_ti6/drow_ti6_silence_wave.vpcf",
            "particles/econ/items/drow/drow_ti6/drow_hero_silence_ti6.vpcf",
        }
    },
    [8035] = 
    {
        ['item_id'] =8035,
        ['name'] ='Silent Wake of the Crimson Witness',
        ['icon'] ='econ/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "witness",
        ['ItemModel'] ='models/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8006, "#2479d4"}, {8035, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_ti6_cape_custom_witness",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_ti6/drow_ti6_witness_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/drow/drow_ti6/drow_ti6_silence_wave.vpcf",
            "particles/econ/items/drow/drow_ti6/drow_hero_silence_ti6.vpcf",
        }
    },
    [8037] = 
    {
        ['item_id'] =8037,
        ['name'] ='Golden Silent Wake',
        ['icon'] ='econ/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape1',
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "gold",
        ['ItemModel'] ='models/items/drow/ti6_immortal_cape/mesh/drow_ti6_immortal_cape.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_ti6_cape_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_ti6_gold/drow_ti6_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/drow/drow_ti6_gold/drow_ti6_silence_gold_wave.vpcf",
            "particles/econ/items/drow/drow_ti6/drow_hero_silence_ti6.vpcf",
        }
    },
    [6785] = 
    {
        ['item_id'] =6785,
        ['name'] ='Manias Mask',
        ['icon'] ='econ/items/drow/mask_of_madness/mask_of_madness',
        ['price'] = 2500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/mask_of_madness/mask_of_madness.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_ranger_madness_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_head_mania/drow_head_mania.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                }
            },
        },
    },

    [19309] = 
    {
        ['item_id'] =19309,
        ['name'] ='Stranger in the Wandering Isles - Weapon',
        ['icon'] ='econ/items/drow/wandering_ranger_weapon/wandering_ranger_weapon',
        ['price'] = 700,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/drow/wandering_ranger_weapon/wandering_ranger_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2022_cc/drow_2022_cc_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_top_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_bot_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_string_top_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_string_bot_fx"
                    },
                }
            },
        },
    },
    [19310] = 
    {
        ['item_id'] =19310,
        ['name'] ='Stranger in the Wandering Isles - Shoulder',
        ['icon'] ='econ/items/drow/wandering_ranger_shoulder/wandering_ranger_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_shoulder/wandering_ranger_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2022_cc/drow_2022_cc_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19311] = 
    {
        ['item_id'] =19311,
        ['name'] ='Stranger in the Wandering Isles - Misc',
        ['icon'] ='econ/items/drow/wandering_ranger_misc/wandering_ranger_misc',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_misc/wandering_ranger_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2022_cc/drow_2022_cc_quiver.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [6] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [17868] = 
    {
        ['item_id'] =17868,
        ['name'] ='Stranger in the Wandering Isles - Legs',
        ['icon'] ='econ/items/drow/wandering_ranger_legs/wandering_ranger_legs',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_legs/wandering_ranger_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
    },
    [17869] = 
    {
        ['item_id'] =17869,
        ['name'] ='Stranger in the Wandering Isles - Head',
        ['icon'] ='econ/items/drow/wandering_ranger_head/wandering_ranger_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_head/wandering_ranger_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
    },
    [17870] = 
    {
        ['item_id'] =17870,
        ['name'] ='Stranger in the Wandering Isles - Back',
        ['icon'] ='econ/items/drow/wandering_ranger_back/wandering_ranger_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_back/wandering_ranger_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
    },
    [17871] = 
    {
        ['item_id'] =17871,
        ['name'] ='Stranger in the Wandering Isles - Arms',
        ['icon'] ='econ/items/drow/wandering_ranger_arms/wandering_ranger_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/wandering_ranger_arms/wandering_ranger_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_stranger',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2022_cc/drow_2022_cc_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },

    [27133] = 
    {
        ['item_id'] =27133,
        ['name'] ='Ravencloak - Legs',
        ['icon'] ='econ/items/drow/2023_crownfall_legs/drow_scree_legs',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_legs/drow_scree_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{27133, "#2479d4"}, {271331, "#e6321e"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },
    [30363] = 
    {
        ['item_id'] =30363,
        ['name'] ='Ravencloak - Quiver',
        ['icon'] ='econ/items/drow/2023_crownfall_quiver/drow_scree_quiver',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_quiver/drow_scree_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{30363, "#2479d4"}, {303631, "#e6321e"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_quiver_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center_left"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center_right"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                }
            },
        },
    },
    [30280] = 
    {
        ['item_id'] =30280,
        ['name'] ='Ravencloak - Weapon',
        ['icon'] ='econ/items/drow/2023_crownfall_weapon/drow_scree_weapon',
        ['price'] = 700,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_weapon/drow_scree_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{30280, "#2479d4"}, {302801, "#e6321e"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_crownfall_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [15] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                }
            },
        },
    },
    [27131] = 
    {
        ['item_id'] =27131,
        ['name'] ='Ravencloak - Arms',
        ['icon'] ='econ/items/drow/2023_crownfall_arms/drow_scree_arms',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_arms/drow_scree_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{27131, "#2479d4"}, {271311, "#e6321e"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },
    [29302] =
    {
        ['item_id'] =29302,
        ['name'] ='Ravencloak - Shoulders',
        ['icon'] ='econ/items/drow/2023_crownfall_shoulder/drow_scree_shoulder',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_shoulders/drow_scree_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29302, "#2479d4"}, {293021, "#e6321e"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_shoulder_eye.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye"
                    },
                }
            },
        },
    },
    [29303] = 
    {
        ['item_id'] =29303,
        ['name'] ='Ravencloak - Head',
        ['icon'] ='econ/items/drow/2023_crownfall_head/drow_scree_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_head/drow_scree_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29303, "#2479d4"}, {293031, "#e6321e"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_head_gem_glow_dark.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_gem_lower_center"
                    },
                }
            },
        },
    },
    [29304] =
    {
        ['item_id'] =29304,
        ['name'] ='Ravencloak - Back',
        ['icon'] ='econ/items/drow/2023_crownfall_back/drow_scree_back',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/2023_crownfall_back/drow_scree_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29304, "#2479d4"}, {293041, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },


    [271331] = 
    {
        ["dota_id"] = 27133,
        ["ItemStyle"] = "1",
        ['item_id'] =271331,
        ['name'] ='Ravencloak - Legs',
        ['icon'] ='econ/items/drow/2023_crownfall_legs/drow_scree_legs_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_legs/drow_scree_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{27133, "#2479d4"}, {271331, "#e6321e"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },
    [303631] = 
    {
        ["dota_id"] = 30363,
        ["ItemStyle"] = "1",
        ['item_id'] =303631,
        ['name'] ='Ravencloak - Quiver',
        ['icon'] ='econ/items/drow/2023_crownfall_quiver/drow_scree_quiver_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_quiver/drow_scree_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{30363, "#2479d4"}, {303631, "#e6321e"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_quiver_v2_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center_left"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center_right"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "quiver_01_center"
                    },
                }
            },
        },
    },
    [302801] = 
    {
        ["dota_id"] = 30280,
        ["ItemStyle"] = "1",
        ['item_id'] =302801,
        ['name'] ='Ravencloak - Weapon',
        ['icon'] ='econ/items/drow/2023_crownfall_weapon/drow_scree_weapon_style1',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_weapon/drow_scree_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{30280, "#2479d4"}, {302801, "#e6321e"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_crownfall_weapon_style2_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                    [15] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_eye"
                    },
                }
            },
        },
    },
    [271311] = 
    {
        ["dota_id"] = 27131,
        ["ItemStyle"] = "1",
        ['item_id'] =271311,
        ['name'] ='Ravencloak - Arms',
        ['icon'] ='econ/items/drow/2023_crownfall_arms/drow_scree_arms_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_arms/drow_scree_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{27131, "#2479d4"}, {271311, "#e6321e"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },
    [293021] =
    {
        ["dota_id"] = 29302,
        ["ItemStyle"] = "1",
        ['item_id'] =293021,
        ['name'] ='Ravencloak - Shoulders',
        ['icon'] ='econ/items/drow/2023_crownfall_shoulder/drow_scree_shoulder_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_shoulders/drow_scree_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29302, "#2479d4"}, {293021, "#e6321e"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_shoulder_eye_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye"
                    },
                }
            },
        },
    },
    [293031] = 
    {
        ["dota_id"] = 29303,
        ["ItemStyle"] = "1",
        ['item_id'] =293031,
        ['name'] ='Ravencloak - Head',
        ['icon'] ='econ/items/drow/2023_crownfall_head/drow_scree_head_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_head/drow_scree_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29303, "#2479d4"}, {293031, "#e6321e"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_2023_crownfall/drow_head_gem_glow_dark_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "crown_gem_lower_center"
                    },
                }
            },
        },
    },
    [293041] =
    {
        ["dota_id"] = 29304,
        ["ItemStyle"] = "1",
        ['item_id'] =293041,
        ['name'] ='Ravencloak - Back',
        ['icon'] ='econ/items/drow/2023_crownfall_back/drow_scree_back_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/drow/2023_crownfall_back/drow_scree_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29304, "#2479d4"}, {293041, "#e6321e"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_crownfall',
    },
    [13338] = 
    {
        ['item_id'] =13338,
        ['name'] ='Bow of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_weapon/drow_runic_archer_weapon',
        ['price'] = 600,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/drow/drow_runic_archer_weapon/drow_runic_archer_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_runic/drow_runic_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_bot"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_mid"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_top"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_front"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye"
                    },
                }
            },
        },
    },
    [13339] = 
    {
        ['item_id'] =13339,
        ['name'] ='Style of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_head/drow_runic_archer_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_head/drow_runic_archer_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
    },
    [13377] = 
    {
        ['item_id'] =13377,
        ['name'] ='Arms of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_arms/drow_runic_archer_arms',
        ['price'] = 500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_arms/drow_runic_archer_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
    },
    [13378] = 
    {
        ['item_id'] =13378,
        ['name'] ='Armor of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_shoulder/drow_runic_archer_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_shoulder/drow_runic_archer_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
    },
    [13379] = 
    {
        ['item_id'] =13379,
        ['name'] ='Legs of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_legs/drow_runic_archer_legs',
        ['price'] = 500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_legs/drow_runic_archer_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
    },
    [13380] = 
    {
        ['item_id'] =13380,
        ['name'] ='Cape of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_back/drow_runic_archer_back',
        ['price'] = 500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_back/drow_runic_archer_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
    },
    [13337] = 
    {
        ['item_id'] =13337,
        ['name'] ='Quiver of the Kha-Ren Faithful',
        ['icon'] ='econ/items/drow/drow_runic_archer_misc/drow_runic_archer_misc',
        ['price'] = 500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/drow_runic_archer_misc/drow_runic_archer_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_kharen',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_runic/drow_runic_misc.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_top"
                    },
                }
            },
        },
    },

    [7053] = 
    {
        ['item_id'] =7053,
        ['name'] ='Cape of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_back/dragonstouch_back',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_back/dragonstouch_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_eldwurm',
    },
    [7055] = 
    {
        ['item_id'] =7055,
        ['name'] ='Boots of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_legs/dragonstouch_legs',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_legs/dragonstouch_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_eldwurm',
    },
    [7057] = 
    {
        ['item_id'] =7057,
        ['name'] ='Pauldrons of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_shoulders/dragonstouch_shoulders',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_shoulders/dragonstouch_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_eldwurm',
    },
    [7058] = 
    {
        ['item_id'] =7058,
        ['name'] ='Bow of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_weapon/dragonstouch_weapon',
        ['price'] = 100,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/drow/dragonstouch_weapon/dragonstouch_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_eldwurm_activity_custom",
        ['sets'] = 'drow_eldwurm',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/drow_bow_dragons_touch/drow_dragons_touch.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_particle"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_drow/drow_bowstring.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_bot"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_mid"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_top"
                    },
                }
            },
        },
    },
    [7052] = 
    {
        ['item_id'] =7052,
        ['name'] ='Bracers of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_arms/dragonstouch_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_arms/dragonstouch_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_eldwurm',
    },
    [7056] = 
    {
        ['item_id'] =7056,
        ['name'] ='Quiver of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_quiver/dragonstouch_quiver',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_quiver/dragonstouch_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_eldwurm',
    },
    [7054] = 
    {
        ['item_id'] =7054,
        ['name'] ='Helmet of the Eldwurms Touch',
        ['icon'] ='econ/items/drow/dragonstouch_head/dragonstouch_head',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/dragonstouch_head/dragonstouch_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_drow_eldwurm_head_custom",
        ['sets'] = 'drow_eldwurm',
    },
    [13010] = 
    {
        ['item_id'] =13010,
        ['name'] ='Oaths of the Dragonborn Wing',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_wing_back_/vestment_of_the_dragonborn_maiden_wing_back_',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_wing_back_/vestment_of_the_dragonborn_maiden_wing_back_.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
    },
    [13011] = 
    {
        ['item_id'] =13011,
        ['name'] ='Oaths of the Dragonborn Head',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_head_01/vestment_of_the_dragonborn_maiden_head_01',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_head_01/vestment_of_the_dragonborn_maiden_head_01.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/drow/ti10_dragonborn/drow_dragonborn_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
    },
    [13001] = 
    {
        ['item_id'] =13001,
        ['name'] ='Oaths of the Dragonborn Arms',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_arms/vestment_of_the_dragonborn_maiden_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_arms/vestment_of_the_dragonborn_maiden_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
    },
    [13002] = 
    {
        ['item_id'] =13002,
        ['name'] ='Oaths of the Dragonborn Shoulders',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_shoulders/vestment_of_the_dragonborn_maiden_shoulders',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_shoulders/vestment_of_the_dragonborn_maiden_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
    },
    [13004] = 
        {
        ['item_id'] =13004,
        ['name'] ='Oaths of the Dragonborn Bow',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_bow/vestment_of_the_dragonborn_maiden_bow',
        ['price'] = 500,
        ['HeroModel'] = "models/heroes/drow/drow_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_bow/vestment_of_the_dragonborn_maiden_bow.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_drow/drow_bowstring.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_bot"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_mid"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bow_top"
                    },
                }
            },
        },
    },
    [13005] = 
    {
        ['item_id'] =13005,
        ['name'] ='Oaths of the Dragonborn Quiver',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_quiver/vestment_of_the_dragonborn_maiden_quiver',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_quiver/vestment_of_the_dragonborn_maiden_quiver.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
    },
    [13006] = 
    {
        ['item_id'] =13006,
        ['name'] ='Oaths of the Dragonborn Boots',
        ['icon'] ='econ/items/drow/vestment_of_the_dragonborn_maiden_legs/vestment_of_the_dragonborn_maiden_legs',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/drow/vestment_of_the_dragonborn_maiden_legs/vestment_of_the_dragonborn_maiden_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'drow_oaths',
    },


    [36053] = {
['item_id'] =36053,
['name'] ='Motley Marauder - Legs',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_legs',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_legs.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'legs',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36056] = {
['item_id'] =36056,
['name'] ='Motley Marauder - Back',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_back',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36058] = {
['item_id'] =36058,
['name'] ='Motley Marauder - Quiver',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_quiver',
['price'] = 200,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_quiver.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'misc',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36057] = {
['item_id'] =36057,
['name'] ='Motley Marauder - Weapon',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_weapon',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_weapon.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'weapon',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36055] = {
['item_id'] =36055,
['name'] ='Motley Marauder - Head',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_head',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36054] = {
['item_id'] =36054,
['name'] ='Motley Marauder - Shoulders',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_shoulders',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_shoulders.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'shoulder',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
[36052] = {
['item_id'] =36052,
['name'] ='Motley Marauder - Arms',
['icon'] ='econ/items/drow/drow_dark_carnival/drow_dark_carnival_arms',
['price'] = 200,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/drow/drow_dark_carnival/drow_dark_carnival_arms.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'arms',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'motley_marauder',
},
}