--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [7385] = 
    {
        ['item_id'] =7385,
        ['name'] ='Frost Avalanche',
        ['icon'] ='econ/heroes/crystal_maiden/crystal_maiden_arcana_back2',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_arcana_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_arcana_body_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["OtherModelsPrecache"] =
        {
            "models/heroes/crystal_maiden/crystal_maiden_arcana_back_refit.vmdl",
            "models/items/crystal_maiden/cm_screeauk/cm_screeauk_back.vmdl",
            "models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl",
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_snow_arcana1.vpcf",
            "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_freezing_field_explosion_arcana1.vpcf",
            "particles/econ/items/crystal_maiden/crystal_maiden_maiden_of_icewrack/maiden_death_arcana.vpcf",
            "particles/cm_death_custom/maiden_death_arcana.vpcf",
        }
    },
    [13532] = 
    {
        ['item_id'] =13532,
        ['name'] ='Ice Blossom',
        ['icon'] ='econ/items/crystal_maiden/cm_ti9_immortal_weapon/cm_ti9_immortal_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/crystal_maiden/cm_ti9_immortal_weapon/cm_ti9_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_ti9_immortal_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/ti9_immortal_staff/cm_ti9_staff_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_ball"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_small_ball_1"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_small_ball_2"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_pommel"
                    },
                }
            },
        }
    },
    [13669] = 
    {
        ['item_id'] =13669,
        ['name'] ='Golden Ice Blossom',
        ['icon'] ='econ/items/crystal_maiden/cm_ti9_immortal_weapon/cm_ti9_immortal_weapon1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/cm_ti9_immortal_weapon/cm_ti9_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_cm_ti9_immortal_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/ti9_immortal_staff/cm_ti9_golden_staff_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_ball"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_small_ball_1"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_small_ball_2"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_pommel"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/crystal_maiden/ti9_immortal_staff/cm_ti9_golden_staff_lvlup_globe.vpcf"
        }
    },
    [6784] = 
    {
        ['item_id'] =6784,
        ['name'] ='White Sentry',
        ['icon'] ='econ/items/crystal_maiden/ward_staff/ward_staff',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/ward_staff/ward_staff.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_ward_staff_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_ward_staff/crystal_maiden_ward_staff_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_tip"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_base"
                    },
                }
            },
        }
    },
    [9205] = 
    {
        ['item_id'] =9205,
        ['name'] ='Yulsarias Mantle',
        ['icon'] ='econ/items/crystal_maiden/immortal_shoulders/cm_immortal_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/immortal_shoulders/cm_immortal_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_immortal_shoulders_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/ti7_immortal_shoulder/cm_ti7_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ball"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shard_1"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shard_2"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shard_3"
                    },
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/crystal_maiden/ti7_immortal_shoulder/cm_ti7_immortal_frostbite.vpcf", 
            "particles/econ/items/crystal_maiden/ti7_immortal_shoulder/cm_ti7_immortal_frostbite_proj.vpcf",    
        }
    },
    [6686] = 
    {
        ['item_id'] =6686,
        ['name'] ='Yulsarias Glacier',
        ['icon'] ='econ/items/crystal_maiden/cowl_of_ice/cowl_of_ice',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cowl_of_ice/cowl_of_ice.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_cownofice_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/crystal_maiden_cowl_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/crystal_maiden/crystal_maiden_cowl_of_ice/maiden_crystal_nova_cowlofice.vpcf"
        }
    },
    [9626] = 
    {
        ['item_id'] =9626,
        ['name'] ='Helm of Winters Warden',
        ['icon'] ='econ/items/crystal_maiden/frosty_valkyrie_head/frosty_valkyrie_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/frosty_valkyrie_head/frosty_valkyrie_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_winterwarden',
    },
    [9625] = 
    {
        ['item_id'] =9625,
        ['name'] ='Arms of Winters Warden',
        ['icon'] ='econ/items/crystal_maiden/frosty_valkyrie_arms/frosty_valkyrie_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/frosty_valkyrie_arms/frosty_valkyrie_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_winterwarden',
    },
    [9624] = 
    {
        ['item_id'] =9624,
        ['name'] ='Staff of Winters Warden',
        ['icon'] ='econ/items/crystal_maiden/frosty_valkyrie_weapon/frosty_valkyrie_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/frosty_valkyrie_weapon/frosty_valkyrie_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_winterwarden',
    },
    [9628] = 
    {
        ['item_id'] =9628,
        ['name'] ='Mantle of Winters Warden',
        ['icon'] ='econ/items/crystal_maiden/frosty_valkyrie_shoulder/frosty_valkyrie_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/frosty_valkyrie_shoulder/frosty_valkyrie_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_winterwarden',
    },
    [9627] = 
    {
        ['item_id'] =9627,
        ['name'] ='Skirt of Winters Warden',
        ['icon'] ='econ/items/crystal_maiden/frosty_valkyrie_back/frosty_valkyrie_back',
        ['price'] = 200,
        ['HeroModel'] = "models/heroes/crystal_maiden/crystal_maiden.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/frosty_valkyrie_back/frosty_valkyrie_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_winterwarden',
    },

    [13486] = 
    {
        ['item_id'] =13486,
        ['name'] ='Prelates Armor of the Wyvern Legion',
        ['icon'] ='econ/items/crystal_maiden/dota_plus_crystal_maiden_shoulder/dota_plus_crystal_maiden_shoulder',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/dota_plus_crystal_maiden_shoulder/dota_plus_crystal_maiden_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_prelate',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_dota_plus/crystal_maiden_dota_plus_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [13487] = 
    {
        ['item_id'] =13487,
        ['name'] ='Prelates Mantle of the Wyvern Legion',
        ['icon'] ='econ/items/crystal_maiden/dota_plus_crystal_maiden_head/dota_plus_crystal_maiden_head',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/dota_plus_crystal_maiden_head/dota_plus_crystal_maiden_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_prelate',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_dota_plus/crystal_maiden_dota_plus_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_02_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_03_fx"
                    },
                }
            },
        },
    },
    [13488] = 
    {
        ['item_id'] =13488,
        ['name'] ='Prelates Cloak of the Wyvern Legion',
        ['icon'] ='econ/items/crystal_maiden/dota_plus_crystal_maiden_back/dota_plus_crystal_maiden_back',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/crystal_maiden/crystal_maiden.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/dota_plus_crystal_maiden_back/dota_plus_crystal_maiden_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_prelate',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_dota_plus/crystal_maiden_dota_plus_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_knee_l_fx"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_knee_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_waist_fx"
                    },
                }
            },
        },
    },
    [13489] = 
    {
        ['item_id'] =13489,
        ['name'] ='Prelates Bracers of the Wyvern Legion',
        ['icon'] ='econ/items/crystal_maiden/dota_plus_crystal_maiden_arms/dota_plus_crystal_maiden_arms',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/dota_plus_crystal_maiden_arms/dota_plus_crystal_maiden_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_prelate',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_dota_plus/crystal_maiden_dota_plus_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_03_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_01_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_02_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_04_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_05_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_06_fx"
                    },
                }
            },
        },
    },
    [13490] = 
    {
        ['item_id'] =13490,
        ['name'] ='Prelates Staff of the Wyvern Legion',
        ['icon'] ='econ/items/crystal_maiden/dota_plus_crystal_maiden_weapon/dota_plus_crystal_maiden_weapon',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/dota_plus_crystal_maiden_weapon/dota_plus_crystal_maiden_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_prelate',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_dota_plus/crystal_maiden_dota_plus_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_beam_01_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_beam_02_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_bot_fx"
                    },
                }
            },
        },
    },

    [14558] = 
    {
        ['item_id'] =14558,
        ['name'] ='Whitewind Battlemage Skirt',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back',
        ['price'] = 600,
        ['HeroModel'] = "models/heroes/crystal_maiden/crystal_maiden.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{14558, "#b4cbdb"}, {145581, "#42b0e3"}, {145582, "#7f39db"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145581] = 
    {
        ["dota_id"] = 14558,
        ["ItemStyle"] = "1",
        ['item_id'] =145581,
        ['name'] ='Whitewind Battlemage Skirt',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back_1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14558, "#b4cbdb"}, {145581, "#42b0e3"}, {145582, "#7f39db"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [145582] = 
    {
        ["dota_id"] = 14558,
        ["ItemStyle"] = "2",
        ['item_id'] =145582,
        ['name'] ='Whitewind Battlemage Skirt',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back_style2',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/crystal_maiden/crystal_maiden.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_back/lady_whitewind_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14558, "#b4cbdb"}, {145581, "#42b0e3"}, {145582, "#7f39db"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_back_game_ambient_purple.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14559] = 
    {
        ['item_id'] =14559,
        ['name'] ='Whitewind Battlemage Bracers',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{14559, "#b4cbdb"}, {145591, "#42b0e3"}, {145592, "#7f39db"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145591] = 
    {
        ["dota_id"] = 14559,
        ["ItemStyle"] = "1",
        ['item_id'] =145591,
        ['name'] ='Whitewind Battlemage Bracers',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms_1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14559, "#b4cbdb"}, {145591, "#42b0e3"}, {145592, "#7f39db"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145592] = 
    {
        ["dota_id"] = 14559,
        ["ItemStyle"] = "2",
        ['item_id'] =145592,
        ['name'] ='Whitewind Battlemage Bracers',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_arms/lady_whitewind_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14559, "#b4cbdb"}, {145591, "#42b0e3"}, {145592, "#7f39db"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [14560] = 
    {
        ['item_id'] =14560,
        ['name'] ='Whitewind Battlemage Crown',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{14560, "#b4cbdb"}, {145601, "#42b0e3"}, {145602, "#7f39db"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145601] = 
    {
        ["dota_id"] = 14560,
        ["ItemStyle"] = "1",
        ['item_id'] =145601,
        ['name'] ='Whitewind Battlemage Crown',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head_1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14560, "#b4cbdb"}, {145601, "#42b0e3"}, {145602, "#7f39db"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
    },
    [145602] = 
    {
        ["dota_id"] = 14560,
        ["ItemStyle"] = "2",
        ['item_id'] =145602,
        ['name'] ='Whitewind Battlemage Crown',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_head/lady_whitewind_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14560, "#b4cbdb"}, {145601, "#42b0e3"}, {145602, "#7f39db"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_head_ambient_purple.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
    },
    [14561] = 
    {
        ['item_id'] =14561,
        ['name'] ='Whitewind Battlemage Mantle',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{14561, "#b4cbdb"}, {145611, "#42b0e3"}, {145612, "#7f39db"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145611] = 
    {
        ["dota_id"] = 14561,
        ["ItemStyle"] = "1",
        ['item_id'] =145611,
        ['name'] ='Whitewind Battlemage Mantle',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder_1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14561, "#b4cbdb"}, {145611, "#42b0e3"}, {145612, "#7f39db"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "chest_gem_fx"
                    },
                }
            },
        },
    },
    [145612] = 
    {
        ["dota_id"] = 14561,
        ["ItemStyle"] = "2",
        ['item_id'] =145612,
        ['name'] ='Whitewind Battlemage Mantle',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_shoulder/lady_whitewind_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14561, "#b4cbdb"}, {145611, "#42b0e3"}, {145612, "#7f39db"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_shoulder_ambient_purple.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "chest_gem_fx"
                    },
                }
            },
        },
    },
    [14562] = 
    {
        ['item_id'] =14562,
        ['name'] ='Whitewind Battlemage Staff',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{14562, "#b4cbdb"}, {145621, "#42b0e3"}, {145622, "#7f39db"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
    },
    [145621] = 
    {
        ["dota_id"] = 14562,
        ["ItemStyle"] = "1",
        ['item_id'] =145621,
        ['name'] ='Whitewind Battlemage Staff',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon_1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14562, "#b4cbdb"}, {145621, "#42b0e3"}, {145622, "#7f39db"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_staff_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "staff_gem_fx"
                    },
                }
            },
        },
    },
    [145622] = 
    {
        ["dota_id"] = 14562,
        ["ItemStyle"] = "2",
        ['item_id'] =145622,
        ['name'] ='Whitewind Battlemage Staff',
        ['icon'] ='econ/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/crystal_maiden/lady_whitewind_weapon/lady_whitewind_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{14562, "#b4cbdb"}, {145621, "#42b0e3"}, {145622, "#7f39db"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'crystal_white_wind',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/crystal_maiden_lady_whitewind/crystal_maiden_lady_whitewind_staff_purple_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "staff_gem_fx"
                    },
                }
            },
        },
    },
    [26559] = 
    {
        ["dota_id"] = 19205,
        ['item_id'] =26559,
        ['name'] ='Conduit of the Blueheart',
        ['icon'] ='econ/heroes/crystal_maiden_persona/crystal_maiden_persona_npc_dota_hero_crystal_maiden',
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ["is_persona_item"] = 1,
        ['HeroModel'] = "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_persona_1",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow.vpcf",
            "particles/cm_death_custom/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/heroes/crystal_maiden_persona/crystal_maiden_persona_armor.vmdl",
            "models/heroes/crystal_maiden_persona/crystal_maiden_persona_tail.vmdl",
            "models/heroes/crystal_maiden_persona/crystal_maiden_persona_mane.vmdl",
            "models/heroes/crystal_maiden_persona/crystal_maiden_persona_crystals.vmdl",
        },
    },
    [265591] = 
    {
        ['item_id'] =265591,
        ['name'] ='Guardian Snow Angel',
        ['icon'] ='econ/items/crystal_maiden/guardiana_glacial_armor/guardiana_glacial_set',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_persona_2",
        ['sets'] = 'crystal_persona',
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow.vpcf",
            "particles/cm_death_custom/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/crystal_maiden/guardiana_glacial_armor/guardiana_glacial_armor_no_baby.vmdl",
            "models/items/crystal_maiden/guardiana_glacial_tail/guardiana_glacial_tail.vmdl",
            "models/items/crystal_maiden/guardiana_glacial_head/guardiana_glacial_head.vmdl",
            "models/items/crystal_maiden/guardiana_glacial_cristals/guardiana_glacial_cristals.vmdl", 
        },
    },
    [265592] = 
    {
        ['item_id'] =265592,
        ['name'] ='Spirit of the frozen flow',
        ['icon'] ='econ/sets/DOTA_Item_Spirit_of_the_Frozen_Flow',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_persona_3",
        ['sets'] = 'crystal_persona',
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow.vpcf",
            "particles/cm_death_custom/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/crystal_maiden/familiars_regalia/familiars_regalia.vmdl",
            "models/items/crystal_maiden/familiars_tail/familiars_tail.vmdl",
            "models/items/crystal_maiden/familiars_sacred_horns/familiars_sacred_horns.vmdl",
            "models/items/crystal_maiden/frostfire_beads/frostfire_beads.vmdl",
        },
    },
    [29578] = 
    {
        ['item_id'] =29578,
        ['name'] ="Canis Crystallum",
        ['icon'] ="econ/sets/DOTA_Item_Canis_Crystallum",
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_persona_4",
        ['sets'] = 'crystal_persona',
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow.vpcf",
            "particles/cm_death_custom/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/crystal_maiden/crystal_diviner_tail/crystal_diviner_tail.vmdl",
            "models/items/crystal_maiden/crystal_diviner_armor/crystal_diviner_armor.vmdl",
            "models/items/crystal_maiden/crystal_diviner_head/crystal_diviner_head.vmdl",
            "models/items/crystal_maiden/crystal_diviner_misc/crystal_diviner_misc.vmdl",
        },
    },
    [33507] = 
    {
        ['item_id'] =33507,
        ['name'] ="Narwolf Nebula",
        ['icon'] ="econ/sets/DOTA_Item_Narwolf_Nebula",
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/crystal_maiden_persona/crystal_maiden_persona.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_crystal_maiden_persona_5",
        ['sets'] = 'crystal_persona',
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_explosion.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_freezing_field_snow.vpcf",
            "particles/cm_death_custom/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_death.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_nova.vpcf",
            "particles/units/heroes/hero_crystalmaiden_persona/cm_persona_ambient_crystals.vpcf",
            "particles/econ/items/crystal_maiden/cm_persona_avatar/cm_persona_avatar_tail_ambient.vpcf",
            "particles/econ/items/crystal_maiden/cm_persona_avatar/cm_persona_avatar_armor_ambient.vpcf",
            "particles/econ/items/crystal_maiden/cm_persona_avatar/cm_persona_avatar_crystals_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/crystal_maiden/avatar_of_crystal_nova_armor/avatar_of_crystal_nova_armor.vmdl",
            "models/items/crystal_maiden/avatar_of_crystal_nova_head/avatar_of_crystal_nova_head.vmdl",
            "models/items/crystal_maiden/avatar_of_crystal_nova_crystals/avatar_of_crystal_nova_crystals.vmdl",
            "models/items/crystal_maiden/avatar_of_crystal_nova_tail/avatar_of_crystal_nova_tail.vmdl",
        },
    },
    [27295] = 
    {
        ['item_id'] =27295,
        ['name'] ='Roost of the Winter Raven - Back',
        ['icon'] ='econ/items/crystal_maiden/cm_screeauk/cm_screeauk_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cm_screeauk/cm_screeauk_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_cm_screeauk_anim",
        ['sets'] = 'winter_raven',
    },
    [27212] = 
    {
        ['item_id'] =27212,
        ['name'] ='Roost of the Winter Raven - Arms',
        ['icon'] ='econ/items/crystal_maiden/cm_screeauk/cm_screeauk_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cm_screeauk/cm_screeauk_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'winter_raven',
    },
    [27561] = 
    {
        ['item_id'] =27561,
        ['name'] ='Roost of the Winter Raven - Head',
        ['icon'] ='econ/items/crystal_maiden/cm_screeauk/cm_screeauk_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cm_screeauk/cm_screeauk_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'winter_raven',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/cm_crownfall/cm_crownfall_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hat_eye_r_fx"
                    },
                }
            },
        },
    },
    [27562] = 
    {
        ['item_id'] =27562,
        ['name'] ='Roost of the Winter Raven - Shoulder',
        ['icon'] ='econ/items/crystal_maiden/cm_screeauk/cm_screeauk_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cm_screeauk/cm_screeauk_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_cm_screeauk_shoulder",
        ['sets'] = 'winter_raven',
        ["OtherModelsPrecache"] =
        {
            "models/heroes/crystal_maiden/crystal_maiden_arcana_back_refit.vmdl",
            "models/items/crystal_maiden/cm_screeauk/cm_screeauk_back.vmdl",
            "models/heroes/crystal_maiden/crystal_maiden_arcana_back.vmdl",
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/crystal_maiden/cm_screeauk/cm_screeauk_arcana_body_ambient.vpcf",
        },
    },
    [27563] = 
    {
        ['item_id'] =27563,
        ['name'] ='Roost of the Winter Raven - Weapon',
        ['icon'] ='econ/items/crystal_maiden/cm_screeauk/cm_screeauk_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/crystal_maiden/cm_screeauk/cm_screeauk_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'winter_raven',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/crystal_maiden/cm_crownfall/cm_crownfall_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_end_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx"
                    },
                }
            },
        },
    },









    [24857] = 
    {
        ["dota_id"] = 24857,
        ["item_id"] = 24857,
        ["SlotType"] = "misc_persona_1",
        ["name"] = "Guardian Snow Angel - Crystals",
        ["icon"] = "econ/items/crystal_maiden/guardiana_glacial_cristals/guardiana_glacial_cristals",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/guardiana_glacial_cristals/guardiana_glacial_cristals.vmdl",
        ["hide"] = 0,
        ["sets"] = "guardian_snow_angel",
    },
    [24881] = 
    {
        ["dota_id"] = 24881,
        ["item_id"] = 24881,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Guardian Snow Angel - Head",
        ["icon"] = "econ/items/crystal_maiden/guardiana_glacial_head/guardiana_glacial_head",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/guardiana_glacial_head/guardiana_glacial_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "guardian_snow_angel",
    },
    [24882] = 
    {
        ["dota_id"] = 24882,
        ["item_id"] = 24882,
        ["SlotType"] = "tail_persona_1",
        ["name"] = "Guardian Snow Angel - Tail",
        ["icon"] = "econ/items/crystal_maiden/guardiana_glacial_tail/guardiana_glacial_tail",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/guardiana_glacial_tail/guardiana_glacial_tail.vmdl",
        ["hide"] = 0,
        ["sets"] = "guardian_snow_angel",
    },
    [24883] = 
    {
        ["dota_id"] = 24883,
        ["item_id"] = 24883,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Guardian Snow Angel - Armor",
        ["icon"] = "econ/items/crystal_maiden/guardiana_glacial_armor/guardiana_glacial_armor",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/guardiana_glacial_armor/guardiana_glacial_armor_no_baby.vmdl",
        ["hide"] = 0,
        ["sets"] = "guardian_snow_angel",
    },

    [28141] = 
    {
        ["dota_id"] = 28141,
        ["item_id"] = 28141,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Spirit of the Frozen Flow - Armor",
        ["icon"] = "econ/items/crystal_maiden/familiars_regalia/familiars_regalia",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/familiars_regalia/familiars_regalia.vmdl",
        ["hide"] = 0,
        ["sets"] = "spirit_frozen_flow",
    },
    [28143] = 
    {
        ["dota_id"] = 28143,
        ["item_id"] = 28143,
        ["SlotType"] = "tail_persona_1",
        ["name"] = "Spirit of the Frozen Flow - Tail",
        ["icon"] = "econ/items/crystal_maiden/familiars_tail/familiars_tail",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/familiars_tail/familiars_tail.vmdl",
        ["hide"] = 0,
        ["sets"] = "spirit_frozen_flow",
    },
    [28144] = 
    {
        ["dota_id"] = 28144,
        ["item_id"] = 28144,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Spirit of the Frozen Flow - Head",
        ["icon"] = "econ/items/crystal_maiden/familiars_sacred_horns/familiars_sacred_horns",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/familiars_sacred_horns/familiars_sacred_horns.vmdl",
        ["hide"] = 0,
        ["sets"] = "spirit_frozen_flow",
    },
    [28152] = 
    {
        ["dota_id"] = 28152,
        ["item_id"] = 28152,
        ["SlotType"] = "misc_persona_1",
        ["name"] = "Spirit of the Frozen Flow - Orbs",
        ["icon"] = "econ/items/crystal_maiden/frostfire_beads/frostfire_beads",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/frostfire_beads/frostfire_beads.vmdl",
        ["hide"] = 0,
        ["sets"] = "spirit_frozen_flow",
    },

    [29566] = 
    {
        ["dota_id"] = 29566,
        ["item_id"] = 29566,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Canis Crystallum - Armor",
        ["icon"] = "econ/items/crystal_maiden/crystal_diviner_armor/crystal_diviner_armor",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/crystal_diviner_armor/crystal_diviner_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "canis_crystallum",
    },
    [29576] = 
    {
        ["dota_id"] = 29576,
        ["item_id"] = 29576,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Canis Crystallum - Head",
        ["icon"] = "econ/items/crystal_maiden/crystal_diviner_head/crystal_diviner_head",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/crystal_diviner_head/crystal_diviner_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "canis_crystallum",
    },
    [29577] = 
    {
        ["dota_id"] = 29577,
        ["item_id"] = 29577,
        ["SlotType"] = "misc_persona_1",
        ["name"] = "Canis Crystallum - Misc",
        ["icon"] = "econ/items/crystal_maiden/crystal_diviner_misc/crystal_diviner_misc",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/crystal_diviner_misc/crystal_diviner_misc.vmdl",
        ["hide"] = 0,
        ["sets"] = "canis_crystallum",
    },
    [24121] = 
    {
        ["dota_id"] = 24121,
        ["item_id"] = 24121,
        ["SlotType"] = "tail_persona_1",
        ["name"] = "Canis Crystallum - Tail",
        ["icon"] = "econ/items/crystal_maiden/crystal_diviner_tail/crystal_diviner_tail",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/crystal_diviner_tail/crystal_diviner_tail.vmdl",
        ["hide"] = 0,
        ["sets"] = "canis_crystallum",
    },

    [33503] = 
    {
        ["dota_id"] = 33503,
        ["item_id"] = 33503,
        ["SlotType"] = "tail_persona_1",
        ["name"] = "Narwolf Nebula - Tail",
        ["icon"] = "econ/items/crystal_maiden/avatar_of_crystal_nova_tail/avatar_of_crystal_nova_tail",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/avatar_of_crystal_nova_tail/avatar_of_crystal_nova_tail.vmdl",
        ["hide"] = 0,
        ["sets"] = "narwolf_nebula",
    },
    [33504] = 
    {
        ["dota_id"] = 33504,
        ["item_id"] = 33504,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Narwolf Nebula - Armor",
        ["icon"] = "econ/items/crystal_maiden/avatar_of_crystal_nova_armor/avatar_of_crystal_nova_armor",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/avatar_of_crystal_nova_armor/avatar_of_crystal_nova_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "narwolf_nebula",
    },
    [33505] = 
    {
        ["dota_id"] = 33505,
        ["item_id"] = 33505,
        ["SlotType"] = "misc_persona_1",
        ["name"] = "Narwolf Nebula - Stars",
        ["icon"] = "econ/items/crystal_maiden/avatar_of_crystal_nova_crystals/avatar_of_crystal_nova_crystals",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/avatar_of_crystal_nova_crystals/avatar_of_crystal_nova_crystals.vmdl",
        ["hide"] = 0,
        ["sets"] = "narwolf_nebula",
    },
    [33506] = 
    {
        ["dota_id"] = 33506,
        ["item_id"] = 33506,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Narwolf Nebula - Head",
        ["icon"] = "econ/items/crystal_maiden/avatar_of_crystal_nova_head/avatar_of_crystal_nova_head",
        ["price"] = 250,
        ["ItemModel"] = "models/items/crystal_maiden/avatar_of_crystal_nova_head/avatar_of_crystal_nova_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "narwolf_nebula",
    },


    [36021] = {
['item_id'] =36021,
['name'] ='Wintertroupe Warden - Shoulder',
['icon'] ='econ/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_shoulders',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_shoulders.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'shoulder',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'wintertroupe_warden',
},
[36020] = {
['item_id'] =36020,
['name'] ='Wintertroupe Warden - Arms',
['icon'] ='econ/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_arms',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_arms.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'arms',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'wintertroupe_warden',
},
[36019] = {
['item_id'] =36019,
['name'] ='Wintertroupe Warden - Weapon',
['icon'] ='econ/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_weapon',
['price'] = 400,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_weapon.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'weapon',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'wintertroupe_warden',
},
[36018] = {
['item_id'] =36018,
['name'] ='Wintertroupe Warden - Back',
['icon'] ='econ/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_back',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'wintertroupe_warden',
},
[36022] = {
['item_id'] =36022,
['name'] ='Wintertroupe Warden - Head',
['icon'] ='econ/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_head',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/crystal_maiden/crystal_maiden_dark_carnival/crystal_maiden_dark_carnival_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'wintertroupe_warden',
},
}