--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [6412] = 
    {
        ['item_id'] =6412,
        ['name'] ='Blade of the Demonic Vessel',
        ['icon'] ='econ/items/abaddon/alliance_abba_weapon/alliance_abba_weapon',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/alliance_abba_weapon/alliance_abba_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_abaddon_alliance_weapon_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/abaddon/abaddon_alliance/abaddon_death_coil_alliance.vpcf",
            "particles/econ/items/abaddon/abaddon_alliance/abaddon_aphotic_shield_alliance.vpcf",
        },
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_abaddon/abaddon_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        }
    },

    [28356] = 
    {
        ['item_id'] =28356,
        ['name'] ='Phantom Balladeer - Weapon',
        ['icon'] ='econ/items/abaddon/wandering_poet_weapon/wandering_poet_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/wandering_poet_weapon/wandering_poet_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'phantom_ballader',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_abaddon/abaddon_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        }
    },
    [28357] = 
    {
        ['item_id'] =28357,
        ['name'] ='Phantom Balladeer - Head',
        ['icon'] ='econ/items/abaddon/wandering_poet_head/wandering_poet_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/wandering_poet_head/wandering_poet_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'phantom_ballader',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_2024_cc_wandering_poet_head/abaddon_2024_cc_wandering_poet_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_eye"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_eye"
                    },
                }
            },
        },
    },
    [28358] = 
    {
        ['item_id'] =28358,
        ['name'] ='Phantom Balladeer - Back',
        ['icon'] ='econ/items/abaddon/wandering_poet_back/wandering_poet_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/wandering_poet_back/wandering_poet_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'phantom_ballader',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_2024_cc_wandering_poet_back/abaddon_2024_cc_wandering_poet_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_eye_left"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_eye_right"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_eye_right"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_eye_left"
                    }
                }
            },
        },
    },
    [28359] = 
    {
        ['item_id'] =28359,
        ['name'] ='Phantom Balladeer - Shoulder',
        ['icon'] ='econ/items/abaddon/wandering_poet_shoulders/wandering_poet_shoulders',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/wandering_poet_shoulders/wandering_poet_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'phantom_ballader',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_2024_cc_wandering_poet_shoulder/abaddon_2024_cc_wandering_poet_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [28360] = 
    {
        ['item_id'] =28360,
        ['name'] ='Phantom Balladeer - Mount',
        ['icon'] ='econ/items/abaddon/wandering_poet_mount/wandering_poet_mount',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/wandering_poet_mount/wandering_poet_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'phantom_ballader',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_2024_cc_wandering_poet_mount/abaddon_2024_cc_wandering_poet_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_nose"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_nose"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_eye"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_eye"
                    },
                }
            },
        },
    },


    [28497] = 
    {
        ['item_id'] =28497,
        ['name'] ='Dreadmist Dragoon - Weapon',
        ['icon'] ='econ/items/abaddon/abaddon_blackmist_reaper_weapon/abaddon_blackmist_reaper_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_blackmist_reaper_weapon/abaddon_blackmist_reaper_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dreadmist_dragoon',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_abaddon/abaddon_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        }
    },
    [28487] = 
    {
        ['item_id'] =28487,
        ['name'] ='Dreadmist Dragoon - Shoulder',
        ['icon'] ='econ/items/abaddon/abaddon_blackmist_reaper_shoulder/abaddon_blackmist_reaper_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_blackmist_reaper_shoulder/abaddon_blackmist_reaper_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dreadmist_dragoon',
    },
    [28477] = 
    {
        ['item_id'] =28477,
        ['name'] ='Dreadmist Dragoon - Mount',
        ['icon'] ='econ/items/abaddon/abaddon_blackmist_reaper_mount/abaddon_blackmist_reaper_mount',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_blackmist_reaper_mount/abaddon_blackmist_reaper_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dreadmist_dragoon',
    },
    [28473] = 
    {
        ['item_id'] =28473,
        ['name'] ='Dreadmist Dragoon - Head',
        ['icon'] ='econ/items/abaddon/abaddon_blackmist_reaper_head/abaddon_blackmist_reaper_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_blackmist_reaper_head/abaddon_blackmist_reaper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dreadmist_dragoon',
    },
    [28472] = 
    {
        ['item_id'] =28472,
        ['name'] ='Dreadmist Dragoon - Back',
        ['icon'] ='econ/items/abaddon/abaddon_blackmist_reaper_back/abaddon_blackmist_reaper_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_blackmist_reaper_back/abaddon_blackmist_reaper_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dreadmist_dragoon',
    },


    [6409] = 
    {
        ['item_id'] =6409,
        ['name'] ='Hood of the Demonic Vessel',
        ['icon'] ='econ/items/abaddon/alliance_abba_head/alliance_abba_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/alliance_abba_head/alliance_abba_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demonic_vessel',
    },
    [6411] = 
    {
        ['item_id'] =6411,
        ['name'] ='Prey of the Demonic Vessel',
        ['icon'] ='econ/items/abaddon/alliance_abba_shoulder/alliance_abba_shoulder',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/alliance_abba_shoulder/alliance_abba_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demonic_vessel',
    },
    [6410] = 
    {
        ['item_id'] =6410,
        ['name'] ='Warhorse of the Demonic Vessel',
        ['icon'] ='econ/items/abaddon/alliance_abba_mount/alliance_abba_mount',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/alliance_abba_mount/alliance_abba_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demonic_vessel',
    },
    [6408] = 
    {
        ['item_id'] =6408,
        ['name'] ='Cloak of the Demonic Vessel',
        ['icon'] ='econ/items/abaddon/alliance_abba_back/alliance_abba_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/alliance_abba_back/alliance_abba_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demonic_vessel',
    },


    [13457] = 
    {
        ['item_id'] =13457,
        ['name'] ='Scythe of the Everblack',
        ['icon'] ='econ/items/abaddon/ti9_cache_abbaddon_everblack_weapon/ti9_cache_abbaddon_everblack_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/ti9_cache_abbaddon_everblack_weapon/ti9_cache_abbaddon_everblack_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_everblack',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_everblack/abaddon_everblack_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_abaddon/abaddon_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        },
    },
    [13458] = 
    {
        ['item_id'] =13458,
        ['name'] ='Hood of the Everblack',
        ['icon'] ='econ/items/abaddon/ti9_cache_abbaddon_everblack_head/ti9_cache_abbaddon_everblack_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/ti9_cache_abbaddon_everblack_head/ti9_cache_abbaddon_everblack_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_everblack',
    },
    [13459] = 
    {
        ['item_id'] =13459,
        ['name'] ='Pauldrons of the Everblack',
        ['icon'] ='econ/items/abaddon/ti9_cache_abbaddon_everblack_shoulder/ti9_cache_abbaddon_everblack_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/ti9_cache_abbaddon_everblack_shoulder/ti9_cache_abbaddon_everblack_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_everblack',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_everblack/abaddon_everblack_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_a_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_a_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_b_l"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_b_r"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_c_l"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bone_c_r"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine"
                    },
                }
            },
        },
    },
    [13460] = 
    {
        ['item_id'] =13460,
        ['name'] ='Cape of the Everblack',
        ['icon'] ='econ/items/abaddon/ti9_cache_abbaddon_everblack_back/ti9_cache_abbaddon_everblack_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/ti9_cache_abbaddon_everblack_back/ti9_cache_abbaddon_everblack_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_everblack',
    },
    [13461] = 
    {
        ['item_id'] =13461,
        ['name'] ='Mount of the Everblack',
        ['icon'] ='econ/items/abaddon/ti9_cache_abbaddon_everblack_mount/ti9_cache_abbaddon_everblack_mount',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/ti9_cache_abbaddon_everblack_mount/ti9_cache_abbaddon_everblack_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_everblack',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_everblack/abaddon_everblack_horse_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck_01"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck_02"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_neck_03"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail"
                    },
                }
            },
        },
    },


    [28625] = 
    {
        ['item_id'] =28625,
        ['name'] ='Spectral Shadow Mount',
        ['icon'] ='econ/items/abaddon/abaddon_curse_of_demonic_crown_mount/abaddon_curse_of_demonic_crown_mount',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_curse_of_demonic_crown_mount/abaddon_curse_of_demonic_crown_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'spectral_shadow',
    },
    [28603] = 
    {
        ['item_id'] =28603,
        ['name'] ='Spectral Shadow Weapon',
        ['icon'] ='econ/items/abaddon/abaddon_curse_of_demonic_crown_weapon/abaddon_curse_of_demonic_crown_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_curse_of_demonic_crown_weapon/abaddon_curse_of_demonic_crown_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'spectral_shadow',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_demonic_crown/abaddon_demonic_crown_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_abaddon/abaddon_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        },
    },
    [28601] = 
    {
        ['item_id'] =28601,
        ['name'] ='Spectral Shadow Shoulder',
        ['icon'] ='econ/items/abaddon/abaddon_curse_of_demonic_crown_shoulder/abaddon_curse_of_demonic_crown_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_curse_of_demonic_crown_shoulder/abaddon_curse_of_demonic_crown_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'spectral_shadow',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_demonic_crown/abaddon_demonic_crown_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_L_eye_left"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_L_eye_right"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_R_eye_left"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_R_eye_right"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_L_eye_light"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_R_eye_light"
                    },
                }
            },
        },
    },
    [28600] = 
    {
        ['item_id'] =28600,
        ['name'] ='Spectral Shadow Head',
        ['icon'] ='econ/items/abaddon/abaddon_curse_of_demonic_crown_head/abaddon_curse_of_demonic_crown_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_curse_of_demonic_crown_head/abaddon_curse_of_demonic_crown_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'spectral_shadow',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_demonic_crown/abaddon_demonic_crown_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_2"
                    },
                }
            },
        },
    },
    [28602] = 
    {
        ['item_id'] =28602,
        ['name'] ='Spectral Shadow Back',
        ['icon'] ='econ/items/abaddon/abaddon_curse_of_demonic_crown_back/abaddon_curse_of_demonic_crown_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_curse_of_demonic_crown_back/abaddon_curse_of_demonic_crown_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'spectral_shadow',
    },



    [19415] = 
    {
        ['item_id'] =19415,
        ['name'] ='Blightfall - Back',
        ['icon'] ='econ/items/abaddon/soul_of_darkness_back/soul_of_darkness_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/soul_of_darkness_back/soul_of_darkness_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_blightfall',
    },
    [19416] = 
    {
        ['item_id'] =19416,
        ['name'] ='Blightfall - Head',
        ['icon'] ='econ/items/abaddon/soul_of_darkness_head/soul_of_darkness_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/soul_of_darkness_head/soul_of_darkness_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_blightfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_soul_of_darkness/abaddon_soul_of_darkness_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                { 
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                }
            },
        },
    },
    [19417] = 
    {
        ['item_id'] =19417,
        ['name'] ='Blightfall - Mount',
        ['icon'] ='econ/items/abaddon/soul_of_darkness_mount/soul_of_darkness_mount',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/soul_of_darkness_mount/soul_of_darkness_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_blightfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_soul_of_darkness/abaddon_soul_of_darkness_mount_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_forehead"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                }
            },
        },
    },
    [19418] =
    {
        ['item_id'] =19418,
        ['name'] ='Blightfall - Shoulder',
        ['icon'] ='econ/items/abaddon/soul_of_darkness_shoulder/soul_of_darkness_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/soul_of_darkness_shoulder/soul_of_darkness_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_blightfall',
    },
    [19419] = 
    {
        ['item_id'] =19419,
        ['name'] ='Blightfall - Weapon',
        ['icon'] ='econ/items/abaddon/soul_of_darkness_weapon/soul_of_darkness_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/soul_of_darkness_weapon/soul_of_darkness_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abaddon_blightfall',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_soul_of_darkness/abaddon_soul_of_darkness_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },



    [13236] = 
    {
        ['item_id'] =13236,
        ['name'] ='Endless Night Head',
        ['icon'] ='econ/items/abaddon/abaddon_endless_night_head/abaddon_endless_night_head',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_endless_night_head/abaddon_endless_night_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'endless_night',
    },
    [13262] = 
    {
        ['item_id'] =13262,
        ['name'] ='Endless Night Cape',
        ['icon'] ='econ/items/abaddon/abaddon_endless_night_back/abaddon_endless_night_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_endless_night_back/abaddon_endless_night_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'endless_night',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_endless/abaddon_endless_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [13263] = 
    {
        ['item_id'] =13263,
        ['name'] ='Endless Night Shoulder',
        ['icon'] ='econ/items/abaddon/abaddon_endless_night_shoulder/abaddon_endless_night_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_endless_night_shoulder/abaddon_endless_night_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'endless_night',
    },
    [13264] = 
    {
        ['item_id'] =13264,
        ['name'] ='Endless Night Mount',
        ['icon'] ='econ/items/abaddon/abaddon_endless_night_mount/abaddon_endless_night_mount',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_endless_night_mount/abaddon_endless_night_mount.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'mount',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'endless_night',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_endless/abaddon_endless_mount_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_top"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_btm"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_top"
                    },
                }
            },
        },
    },
    [13235] = 
    {
        ['item_id'] =13235,
        ['name'] ='Endless Night Sword',
        ['icon'] ='econ/items/abaddon/abaddon_endless_night_weapon/abaddon_endless_night_weapon',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/abaddon/abaddon_endless_night_weapon/abaddon_endless_night_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'endless_night',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/abaddon/abaddon_endless/abaddon_endless_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
}