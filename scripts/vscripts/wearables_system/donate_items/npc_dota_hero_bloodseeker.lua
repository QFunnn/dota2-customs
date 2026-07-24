--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [7425] = 
    {
        ['item_id'] =7425,
        ['name'] ='Thirst of Eztzhok Blade',
        ['icon'] ='econ/items/blood_seeker/thirst_of_eztzhok_immortal_weapon/thirst_of_eztzhok_immortal',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/thirst_of_eztzhok_weapon/thirst_of_eztzhok.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_immortal_bloodseeker_weapon_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/bloodseeker/bloodseeker_bloodrage_immortal.vpcf",
            "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok.vpcf",
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_eztzhok_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_fx",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hole_fx",
                    },
                }
            },
        },
    },
    [7426] = 
    {
        ['item_id'] =7426,
        ['name'] ='Thirst of Eztzhok - Off-Hand',
        ['icon'] ='econ/items/blood_seeker/thirst_of_eztzhok_immortal_weapon_offhand/thirst_of_eztzhok_immortal_offhand',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/thirst_of_eztzhok_weapon_offhand/thirst_of_eztzhok_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_immortal_bloodseeker_offhand_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/bloodseeker/bloodseeker_bloodrage_immortal.vpcf",
            "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon/bloodseeker_bloodbath_eztzhok.vpcf",
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/bloodseeker_eztzhok_weapon_offhand/bloodseeker_eztzhok_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_fx",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hole_fx",
                    },
                }
            },
        },
    },
    [32137] = 
    {
        ['item_id'] =32137,
        ['name'] ='Heart of Eztzhok',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_immortal_bloodseeker_heart_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bloodseeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal_rupture.vpcf",
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/bloodseeker_crownfall_immortal/bloodseeker_crownfall_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_fx_l",
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_fx_r",
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "heart_fx",
                    },
                }
            },
        },
    },
    [9241] = 
    {
        ['item_id'] =9241,
        ['name'] ='Maw of Eztzhok',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_immortal_head/bloodseeker_immortal_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_immortal_head/bloodseeker_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_immortal_bloodseeker_maw_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_thirst_owner.vpcf",
            "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_overhead_vision.vpcf",
            "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_thirst_stacks_ti7.vpcf",
            "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_thirst_stacks_ti7_loadout.vpcf",
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/bloodseeker_ti7/bloodseeker_ti7_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head",
                    },
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
    },
    [13443] = 
    {
        ['item_id'] =13443,
        ['name'] ='Off-Hand Weapon of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_off_hand/ti9_cache_bloodseeker_boiling_blood_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_off_hand/ti9_cache_bloodseeker_boiling_blood_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti9_bs_boiling_blood_off_hand/ti9_bloodseeker_blood_off_hand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_wheel",
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fire_attach",
                    },
                }
            },
        },
    },
    [13444] = 
    {
        ['item_id'] =13444,
        ['name'] ='Weapon of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_weapon/ti9_cache_bloodseeker_boiling_blood_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_weapon/ti9_cache_bloodseeker_boiling_blood_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti9_bs_boiling_blood_weapon/ti9_bloodseeker_blood_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_wheel",
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fire_attach",
                    },
                }
            },
        },
    },
    [13445] = 
    {
        ['item_id'] =13445,
        ['name'] ='Shoulder of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_shoulder/ti9_cache_bloodseeker_boiling_blood_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_shoulder/ti9_cache_bloodseeker_boiling_blood_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti9_bs_boiling_blood_shoulders/ti9_bs_boiling_blood_shoulders_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [13446] = 
    {
        ['item_id'] =13446,
        ['name'] ='Mask of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_head/ti9_cache_bloodseeker_boiling_blood_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_head/ti9_cache_bloodseeker_boiling_blood_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti9_bs_boiling_blood_head/ti9_bloodseeker_blood_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eyeL",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eyeR",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "mouth",
                    },
                }
            },
        },
    },
    [13447] = 
    {
        ['item_id'] =13447,
        ['name'] ='Belt of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_belt/ti9_cache_bloodseeker_boiling_blood_belt',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_belt/ti9_cache_bloodseeker_boiling_blood_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
    },
    [13448] = 
    {
        ['item_id'] =13448,
        ['name'] ='Cape of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_back/ti9_cache_bloodseeker_boiling_blood_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_back/ti9_cache_bloodseeker_boiling_blood_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
    },
    [13449] = 
    {
        ['item_id'] =13449,
        ['name'] ='Bracer of the Bloodforge',
        ['icon'] ='econ/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_arms/ti9_cache_bloodseeker_boiling_blood_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti9_cache_bloodseeker_boiling_blood_arms/ti9_cache_bloodseeker_boiling_blood_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_bloodforge',
    },
    [9819] = 
    {
        ['item_id'] =9819,
        ['name'] ='Shoulder of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_shoulder/ti8_bs_sanguine_nightmare_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_shoulder/ti8_bs_sanguine_nightmare_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
    },
    [9821] = 
    {
        ['item_id'] =9821,
        ['name'] ='Arms of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_arms/ti8_bs_sanguine_nightmare_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_arms/ti8_bs_sanguine_nightmare_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
    },
    [9820] = 
    {
        ['item_id'] =9820,
        ['name'] ='Blade of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_weapon/ti8_bs_sanguine_nightmare_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_weapon/ti8_bs_sanguine_nightmare_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti8_bs_sanguine_weapon/ti8_bs_sanguine_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [9810] = 
    {
        ['item_id'] =9810,
        ['name'] ='Head of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_head/ti8_bs_sanguine_nightmare_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_head/ti8_bs_sanguine_nightmare_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti8_bs_sanguine_head/ti8_bs_sanguine_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r",
                    },
                }
            },
        },
    },
    [9811] = 
    {
        ['item_id'] =9811,
        ['name'] ='Back of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_back/ti8_bs_sanguine_nightmare_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_back/ti8_bs_sanguine_nightmare_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
    },
    [9817] = 
    {
        ['item_id'] =9817,
        ['name'] ='Off-Hand of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_off_hand/ti8_bs_sanguine_nightmare_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_off_hand/ti8_bs_sanguine_nightmare_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/ti8_bs_sanguine_off_hand/ti8_bs_sanguine_off_hand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [9809] = 
    {
        ['item_id'] =9809,
        ['name'] ='Belt of the Sanguine Spectrum',
        ['icon'] ='econ/items/blood_seeker/ti8_bs_sanguine_nightmare_belt/ti8_bs_sanguine_nightmare_belt',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/ti8_bs_sanguine_nightmare_belt/ti8_bs_sanguine_nightmare_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sanguine_spectrum',
    },
    [12722] = 
    {
        ['item_id'] =12722,
        ['name'] ='Shoulder of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_shoulder/frostivus2018_bs_iceblood_hound_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_shoulder/frostivus2018_bs_iceblood_hound_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [12718] = 
    {
        ['item_id'] =12718,
        ['name'] ='Blade of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_weapon/frostivus2018_bs_iceblood_hound_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_weapon/frostivus2018_bs_iceblood_hound_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [12720] = 
    {
        ['item_id'] =12720,
        ['name'] ='Back of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_back/frostivus2018_bs_iceblood_hound_back',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_back/frostivus2018_bs_iceblood_hound_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [12723] = 
    {
        ['item_id'] =12723,
        ['name'] ='Head of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_head/frostivus2018_bs_iceblood_hound_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_head/frostivus2018_bs_iceblood_hound_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/2018_frostivus_iceblood_head/2018_frostivus_iceblood_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_L",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_R",
                    },
                }
            },
        },
    },
    [12717] = 
    {
        ['item_id'] =12717,
        ['name'] ='Off-Hand of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_off_hand/frostivus2018_bs_iceblood_hound_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_off_hand/frostivus2018_bs_iceblood_hound_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [12721] = 
    {
        ['item_id'] =12721,
        ['name'] ='Arms of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_arms/frostivus2018_bs_iceblood_hound_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_arms/frostivus2018_bs_iceblood_hound_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [12719] = 
    {
        ['item_id'] =12719,
        ['name'] ='Belt of Harvests Hound',
        ['icon'] ='econ/items/blood_seeker/frostivus2018_bs_iceblood_hound_belt/frostivus2018_bs_iceblood_hound_belt',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/frostivus2018_bs_iceblood_hound_belt/frostivus2018_bs_iceblood_hound_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bs_hound',
    },
    [8736] = 
    {
        ['item_id'] =8736,
        ['name'] ='Helm of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_head/bloodseeker_relentless_hunter_head_1',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_head/bloodseeker_relentless_hunter_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bloodseeker/bloodseeker_relentless_hunter/bloodseeker_relentless_hunter_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_l_eye",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_r_eye",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_l_feathers",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_r_feathers",
                    },
                }
            },
        },
    },
    [8835] = 
    {
        ['item_id'] =8835,
        ['name'] ='Gauntlets of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_arms/bloodseeker_relentless_hunter_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_arms/bloodseeker_relentless_hunter_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
    [8836] = 
    {
        ['item_id'] =8836,
        ['name'] ='Shield of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_back/bloodseeker_relentless_hunter_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_back/bloodseeker_relentless_hunter_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
    [8838] = 
    {
        ['item_id'] =8838,
        ['name'] ='Tattoo of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_shoulder/bloodseeker_relentless_hunter_shoulder',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_shoulder/bloodseeker_relentless_hunter_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
    [8837] = 
    {
        ['item_id'] =8837,
        ['name'] ='Belt of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_belt/bloodseeker_relentless_hunter_belt',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_belt/bloodseeker_relentless_hunter_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
    [8839] = 
    {
        ['item_id'] =8839,
        ['name'] ='Off-Hand Blade of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_off_hand/bloodseeker_relentless_hunter_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_off_hand/bloodseeker_relentless_hunter_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
    [8873] = 
    {
        ['item_id'] =8873,
        ['name'] ='Blade of the Primeval Predator',
        ['icon'] ='econ/items/blood_seeker/bloodseeker_relentless_hunter_weapon/bloodseeker_relentless_hunter_weapon',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/blood_seeker/bloodseeker_relentless_hunter_weapon/bloodseeker_relentless_hunter_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'primeval_predator',
    },
}