--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [9679] = 
    {
        ['item_id'] =9679,
        ['name'] ='Bonkers of Awaleb',
        ['icon'] ='econ/items/witchdoctor/wd_ti8_immortal_bonkers/wd_ti8_immortal_bonkers',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_ti8_immortal_bonkers/wd_ti8_immortal_bonkers.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8267, "#e4c17f"}, {9679, "#af8cf5"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_ti8_bonkers",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_monkey/witchdoctor_bonkers_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_ti8_immortal_bonkers/wd_ti8_immortal_bonkers_ambient.vpcf",
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
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_ti8_immortal_bonkers/wd_ti8_immortal_bonkers_cask.vpcf",
        }
    },
    [8267] = 
    {
        ['item_id'] =8267,
        ['name'] ='Bonkers the Mad',
        ['icon'] ='econ/items/witchdoctor/bonkers_the_mad/bonkers_the_mad',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/bonkers_the_mad/bonkers_the_mad.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8267, "#e4c17f"}, {9679, "#af8cf5"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_bonkers_the_mad",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_monkey/witchdoctor_bonkers_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_monkey/witchdoctor_cask_monkey.vpcf",
        }
    },
    [12328] = 
    {
        ['item_id'] =12328,
        ['name'] ='Masque of Awaleb',
        ['icon'] ='econ/items/witchdoctor/wd_ti8_immortal_head/wd_ti8_immortal_head',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_ti8_immortal_head/wd_ti8_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_head_ti8_immortal",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_ti8_immortal_head/wd_ti8_immortal_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_basin"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_drip"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_drip_b"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_drip_c"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_ti8_immortal_head/wd_ti8_immortal_maledict.vpcf",
            "particles/econ/items/witch_doctor/wd_ti8_immortal_head/wd_ti8_immortal_maledict_aoe.vpcf",
        }
    },


    [13819] = 
    {
        ['item_id'] =13819,
        ['name'] ='Awalebs Trundleweed',
        ['icon'] ='econ/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_weapon_immortal_1",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon/wd_ti10_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_1"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_2"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_3"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon/wd_ti10_immortal_voodoo.vpcf",
        }
    },
    [14975] = 
    {
        ['item_id'] =14975,
        ['name'] ='Golden Awalebs Trundleweed',
        ['icon'] ='econ/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_weapon_immortal_2",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon_gold/wd_ti10_immortal_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_1"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_2"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_3"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon_gold/wd_ti10_immortal_voodoo_gold.vpcf",
        }
    },
    [29575] = 
    {
        ['item_id'] =29575,
        ['name'] ='Awalebs Trundleweed of the Crimson Witness',
        ['icon'] ='econ/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon2',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/witchdoctor/wd_ti10_immortal_weapon/wd_ti10_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_witch_doctor_weapon_immortal_3",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon/wd_ti10_immortal_ambient_crimson.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_1"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_2"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_3"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_ti10_immortal_weapon/wd_ti10_immortal_voodoo_crimson.vpcf",
        }
    },
    [19150] = 
    {
        ['item_id'] =19150,
        ['name'] ='Footfalls of the Sporefathers - Back',
        ['icon'] ='econ/items/witchdoctor/father_of_the_fungal_forest_back/father_of_the_fungal_forest_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/father_of_the_fungal_forest_back/father_of_the_fungal_forest_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sporefathers_footfalls',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2021_cache/wd_2021_cache_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19151] = 
    {
        ['item_id'] =19151,
        ['name'] ='Footfalls of the Sporefathers - Belt',
        ['icon'] ='econ/items/witchdoctor/father_of_the_fungal_forest_belt/father_of_the_fungal_forest_belt',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/father_of_the_fungal_forest_belt/father_of_the_fungal_forest_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sporefathers_footfalls',
    },
    [19152] = 
    {
        ['item_id'] =19152,
        ['name'] ='Footfalls of the Sporefathers - Head',
        ['icon'] ='econ/items/witchdoctor/father_of_the_fungal_forest_head/father_of_the_fungal_forest_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/father_of_the_fungal_forest_head/father_of_the_fungal_forest_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sporefathers_footfalls',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2021_cache/wd_2021_cache_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leaves_fx"
                    },
                }
            },
        },
    },
    [19154] = 
    {
        ['item_id'] =19154,
        ['name'] ='Footfalls of the Sporefathers - Shoulder',
        ['icon'] ='econ/items/witchdoctor/father_of_the_fungal_forest_shoulder/father_of_the_fungal_forest_shoulder',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/father_of_the_fungal_forest_shoulder/father_of_the_fungal_forest_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sporefathers_footfalls',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2021_cache/wd_2021_cache_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leaf_fx_01"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leaf_fx_02"
                    },
                }
            },
        },
    },
    [19155] = 
    {
        ['item_id'] =19155,
        ['name'] ='Footfalls of the Sporefathers - Weapon',
        ['icon'] ='econ/items/witchdoctor/father_of_the_fungal_forest_weapon/father_of_the_fungal_forest_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/father_of_the_fungal_forest_weapon/father_of_the_fungal_forest_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sporefathers_footfalls',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2021_cache/wd_2021_cache_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_fx"
                    },
                }
            },
        },
    },



    [18552] = 
    {
        ['item_id'] =18552,
        ['name'] ='Prodigy of Prefectura - Belt',
        ['icon'] ='econ/items/witchdoctor/aghsbp_2021_witch_doctor_belt/aghsbp_2021_witch_doctor_belt',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/aghsbp_2021_witch_doctor_belt/aghsbp_2021_witch_doctor_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'prodigy_prefecture',
    },
    [18553] = 
    {
        ['item_id'] =18553,
        ['name'] ='Prodigy of Prefectura - Head',
        ['icon'] ='econ/items/witchdoctor/aghsbp_2021_witch_doctor_head/aghsbp_2021_witch_doctor_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/aghsbp_2021_witch_doctor_head/aghsbp_2021_witch_doctor_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'prodigy_prefecture',
    },
    [18554] = 
    {
        ['item_id'] =18554,
        ['name'] ='Prodigy of Prefectura - Shoulder',
        ['icon'] ='econ/items/witchdoctor/aghsbp_2021_witch_doctor_shoulder/aghsbp_2021_witch_doctor_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/aghsbp_2021_witch_doctor_shoulder/aghsbp_2021_witch_doctor_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'prodigy_prefecture',
    },
    [18555] = 
    {
        ['item_id'] =18555,
        ['name'] ='Prodigy of Prefectura - Weapon',
        ['icon'] ='econ/items/witchdoctor/aghsbp_2021_witch_doctor_weapon/aghsbp_2021_witch_doctor_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/aghsbp_2021_witch_doctor_weapon/aghsbp_2021_witch_doctor_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'prodigy_prefecture',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/aghsbp_2021/aghsbp_2021_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_1"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_2"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_3"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_4"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_core"
                    },
                }
            },
        },
    },
    [18551] = 
    {
        ['item_id'] =18551,
        ['name'] ='Prodigy of Prefectura - Back',
        ['icon'] ='econ/items/witchdoctor/aghsbp_2021_witch_doctor_back/aghsbp_2021_witch_doctor_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/aghsbp_2021_witch_doctor_back/aghsbp_2021_witch_doctor_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'prodigy_prefecture',
    },



    [9933] = 
    {
        ['item_id'] =9933,
        ['name'] ='Satchel of Morbific Provision',
        ['icon'] ='econ/items/witchdoctor/ti8_wd_spore_gardener_shoulder/ti8_wd_spore_gardener_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/ti8_wd_spore_gardener_shoulder/ti8_wd_spore_gardener_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morbfic_provision',
    },
    [9934] = 
    {
        ['item_id'] =9934,
        ['name'] ='Head of Morbific Provision',
        ['icon'] ='econ/items/witchdoctor/ti8_wd_spore_gardener_head/ti8_wd_spore_gardener_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/ti8_wd_spore_gardener_head/ti8_wd_spore_gardener_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morbfic_provision',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/ti8_wd_spore_gardener_head/ti8_wd_spore_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [9935] = 
    {
        ['item_id'] =9935,
        ['name'] ='Belt of Morbific Provision',
        ['icon'] ='econ/items/witchdoctor/ti8_wd_spore_gardener_belt/ti8_wd_spore_gardener_belt',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/ti8_wd_spore_gardener_belt/ti8_wd_spore_gardener_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morbfic_provision',
    },
    [9936] = 
    {
        ['item_id'] =9936,
        ['name'] ='Garb of Morbific Provision',
        ['icon'] ='econ/items/witchdoctor/ti8_wd_spore_gardener_back/ti8_wd_spore_gardener_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/ti8_wd_spore_gardener_back/ti8_wd_spore_gardener_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morbfic_provision',
    },
    [9937] = 
    {
        ['item_id'] =9937,
        ['name'] ='Staff of Morbific Provision',
        ['icon'] ='econ/items/witchdoctor/ti8_wd_spore_gardener_weapon/ti8_wd_spore_gardener_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/ti8_wd_spore_gardener_weapon/ti8_wd_spore_gardener_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morbfic_provision',
    },






    [19658] = 
    {
        ['item_id'] =19658,
        ['name'] ='Servant of the Sightless Shamans Belt',
        ['icon'] ='econ/items/witchdoctor/monke_belt/monke_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/monke_belt/monke_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sightless_shamans',
    },
    [19659] = 
    {
        ['item_id'] =19659,
        ['name'] ='Servant of the Sightless Shamans Head',
        ['icon'] ='econ/items/witchdoctor/monke_head/monke_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/monke_head/monke_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sightless_shamans',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2022_monke/wd_2022_monke_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_a"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_b"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_c"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_d"
                    },
                }
            },
        },
    },
    [19661] = 
    {
        ['item_id'] =19661,
        ['name'] ='Servant of the Sightless Shamans Shoulder',
        ['icon'] ='econ/items/witchdoctor/monke_shoulder/monke_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/monke_shoulder/monke_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sightless_shamans',
    },
    [19662] = 
    {
        ['item_id'] =19662,
        ['name'] ='Servant of the Sightless Shamans Weapon',
        ['icon'] ='econ/items/witchdoctor/monke_weapon/monke_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/monke_weapon/monke_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sightless_shamans',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_2022_monke/wd_2022_monke_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19657] = 
    {
        ['item_id'] =19657,
        ['name'] ='Servant of the Sightless Shamans Back',
        ['icon'] ='econ/items/witchdoctor/monke_back/monke_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/monke_back/monke_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sightless_shamans',
    },



    [14314] = 
    {
        ['item_id'] =14314,
        ['name'] ='Papa Wangas Basket',
        ['icon'] ='econ/items/witchdoctor/wd_voodoo_doc_shoulder/wd_voodoo_doc_shoulder',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_voodoo_doc_shoulder/wd_voodoo_doc_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'papa_wanga',
    },
    [14316] = 
    {
        ['item_id'] =14316,
        ['name'] ='Papa Wangas Mask',
        ['icon'] ='econ/items/witchdoctor/wd_voodoo_doc_head/wd_voodoo_doc_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_voodoo_doc_head/wd_voodoo_doc_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'papa_wanga',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_voodoo_doc/wd_voodoo_doc_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                }
            },
        },
    },
    [14317] = 
    {
        ['item_id'] =14317,
        ['name'] ='Papa Wangas Belt',
        ['icon'] ='econ/items/witchdoctor/wd_voodoo_doc_belt/wd_voodoo_doc_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_voodoo_doc_belt/wd_voodoo_doc_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'papa_wanga',
    },
    [14318] = 
    {
        ['item_id'] =14318,
        ['name'] ='Papa Wangas Backplate',
        ['icon'] ='econ/items/witchdoctor/wd_voodoo_doc_back/wd_voodoo_doc_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_voodoo_doc_back/wd_voodoo_doc_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'papa_wanga',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_voodoo_doc/wd_voodoo_doc_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back_eye_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back_eye_R"
                    },
                }
            },
        },
    },
    [14312] = 
    {
        ['item_id'] =14312,
        ['name'] ='Papa Wangas Staff',
        ['icon'] ='econ/items/witchdoctor/wd_voodoo_doc_weapon/wd_voodoo_doc_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/witchdoctor/wd_voodoo_doc_weapon/wd_voodoo_doc_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'papa_wanga',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/witch_doctor/wd_voodoo_doc/wd_voodoo_doc_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                }
            },
        },
    },


    [7380] = 
    {
        ["item_id"] = 7380,
        ["name"] = "Padda'pon of Ribbi'tar",
        ["icon"] = "econ/items/witchdoctor/wd_ward/ribbitar_ward/ribbitar_ward_npc_dota_witch_doctor_death_ward",
        ["price"] = 2000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_1",
        ['sets'] = "rare",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/ribbitar_ward/ribbitar_ward.vmdl"
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/witch_doctor_ribbitar/witch_doctor_ribbitar_ward_attack.vpcf",
            "particles/econ/items/witch_doctor/witch_doctor_ribbitar/witchdoctor_ribbitar_ward_skull.vpcf",
            "particles/econ/items/witch_doctor/witch_doctor_ribbitar/witchdoctor_ward_cast_staff_fire_ribbitar.vpcf",
        }
    },
    [19660] = 
    {
        ["item_id"] = 19660,
        ["name"] = "Servant of the Sightless Shamans Ward",
        ["icon"] = "econ/items/witchdoctor/wd_ward/monke_monkes_puppet/monke_monkes_puppet_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_2",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/monke_monkes_puppet/monke_monkes_puppet.vmdl"
        }
    },
    [17875] = 
    {
        ["item_id"] = 17875,
        ["name"] = "Cunning Cultivations Ward",
        ["icon"] = "econ/items/witchdoctor/wd_ward/record_holder_grower_ward/record_holder_grower_ward_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_3",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/record_holder_grower_ward/record_holder_grower_ward.vmdl"
        }
    },
    [9175] = 
    {
        ["item_id"] = 9175,
        ["name"] = "Death Ward of the Foreteller's Oath",
        ["icon"] = "econ/items/witchdoctor/wd_ward/teller_of_the_auspice_ability/teller_of_the_auspice_ability_npc_dota_witch_doctor_death_ward",
        ["price"] = 500,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_4",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/teller_of_the_auspice_ability/teller_of_the_auspice_ability.vmdl"
        }
    },
    [26629] = 
    {
        ["item_id"] = 26629,
        ["name"] = "Deathstitch Shaman - Death Ward",
        ["icon"] = "econ/items/witchdoctor/wd_ward/wd_voodoo_harvest_ability/wd_voodoo_harvest_ability_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_5",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/wd_voodoo_harvest_ability/wd_voodoo_harvest_ability.vmdl"
        }
    },
    [19153] = 
    {
        ["item_id"] = 19153,
        ["name"] = "Footfalls of the Sporefathers - Death Ward",
        ["icon"] = "econ/items/witchdoctor/wd_ward/father_of_the_fungal_forest_death_ward/father_of_the_fungal_forest_death_ward_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_6",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/father_of_the_fungal_forest_death_ward/father_of_the_fungal_forest_death_ward.vmdl"
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_2021_cache/wd_2021_cache_death_ward.vpcf",
        }
    },
    [9932] = 
    {
        ["item_id"] = 9932,
        ["name"] = "Servant of Morbific Provision",
        ["icon"] = "econ/items/witchdoctor/wd_ward/ti8_wd_spore_gardener_spore_abomination_ti8/ti8_wd_spore_gardener_spore_abomination_ti8_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_7",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/ti8_wd_spore_gardener_spore_abomination_ti8/ti8_wd_spore_gardener_spore_abomination_ti8.vmdl"
        }
    },
    [14313] = 
    {
        ["item_id"] = 14313,
        ["name"] = "Papa Wanga's Poppet",
        ["icon"] = "econ/items/witchdoctor/wd_ward/wd_voodoo_doc_ward/wd_voodoo_doc_ward_npc_dota_witch_doctor_death_ward",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/development/invisiblebox.vmdl",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "witch_doctor_ward",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_witch_doctor_ward_8",
        ['sets'] = "witch_doctor_wards",
        ["OtherModelsPrecache"] =
        {
            "models/items/witchdoctor/wd_ward/wd_voodoo_doc_ward/wd_voodoo_doc_ward.vmdl"
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/witch_doctor/wd_voodoo_doc/wd_voodoo_doc_summons_ambient.vpcf",
        }
    },
}