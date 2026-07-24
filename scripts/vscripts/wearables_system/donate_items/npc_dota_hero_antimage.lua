--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [5395] = 
    {
        ['item_id'] =5395,
        ['name'] = "Arc of Manta - Off-Hand",
        ['icon'] = "econ/items/antimage/arc_of_manta__offhand/arc_of_manta__offhand",
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/antimage/arc_of_manta__offhand/arc_of_manta__offhand.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_manta/antimage_blade_offhand_manta_passive.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [16] = {'SetParticleControl', {0, 0, 0}}
                }
            },
        },
    },
    [5396] = 
    {
        ['item_id'] =5396,
        ['name'] = "Arc of Manta",
        ['icon'] = "econ/items/antimage/arc_of_manta/arc_of_manta",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/arc_of_manta/arc_of_manta.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_manta/antimage_blade_primary_manta_passive.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                        "attach_attack1", "hero"
                    },
                }
            },
        },
    },



    [8271] = 
    {
        ['item_id'] =8271,
        ['name'] ='Basher of Mage Skulls',
        ['icon'] ='econ/items/antimage/skullbasher/skullbasher1',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/skullbasher/skullbasher.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_basher_1_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_ambient_skullbasher.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                        "attach_attack1", "hero"
                    },
                }
            },
        },
        ['ParticlesSkills'] = 
        {
            "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf",
            "particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5.vpcf"
        }
    },
    [8324] = 
    {
        ['item_id'] =8324,
        ['name'] ='Offhand Basher of Mage Skulls',
        ['icon'] ='econ/items/antimage/skullbasher_offhand/skullbasher_offhand1',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/skullbasher/skullbasher_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_basher_2_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_ambient_skullbasher_offhand.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            },
        },
        ['ParticlesSkills'] = 
        {
            "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_manavoid_ti_5.vpcf",
            "particles/econ/items/antimage/antimage_weapon_basher_ti5/am_manaburn_basher_ti_5.vpcf"
        }
    },
    [7276] = 
    {
        ['item_id'] =7276,
        ['name'] ='Golden Offhand Basher of Mage Skulls',
        ['icon'] ='econ/items/antimage/skullbasher_gold_offhand/skullbasher_gold_offhand1',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/skullbasher/skullbasher_gold_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_basher_1_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_ambient_skullbasher_offhand.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            },
        },
        ['ParticlesSkills'] = 
        {
            "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/antimage_manavoid_ti_5_gold.vpcf",
            "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf"
        }
    },
    [7277] = 
    {
        ['item_id'] =7277,
        ['name'] ='Golden Basher of Mage Skulls',
        ['icon'] ='econ/items/antimage/skullbasher_gold/skullbasher_gold1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/skullbasher/skullbasher_gold.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_basher_2_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_basher_ti5/antimage_ambient_skullbasher.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                        "attach_attack1", "hero"
                    },
                }
            },
        },
        ['ParticlesSkills'] = 
        {
            "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/antimage_manavoid_ti_5_gold.vpcf",
            "particles/econ/items/antimage/antimage_weapon_basher_ti5_gold/am_manaburn_basher_ti_5_gold.vpcf"
        }
    },
    [9249] = 
    {
        ['item_id'] =9249,
        ['name'] ='Origins of Faith',
        ['icon'] ='econ/items/antimage/ti7_antimage_immortal/ti7_immortal_armor',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/ti7_antimage_immortal/ti7_immortal_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_ti7_armor_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_ti7/antimage_ti7_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem",
                    },
                }
            },
        },
        ['ParticlesSkills'] =
        {
            "particles/econ/items/antimage/antimage_ti7/antimage_blink_start_ti7.vpcf",
            "particles/econ/items/antimage/antimage_ti7/antimage_blink_ti7_end.vpcf"
        }
    },
    [9457] = 
    {
        ['item_id'] =9457,
        ['name'] ='Golden Origins of Faith',
        ['icon'] ='econ/items/antimage/ti7_antimage_immortal/ti7_immortal_armor1',
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/antimage/ti7_antimage_immortal/ti7_immortal_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_ti7_armor_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_ti7_golden/antimage_ti7_golden_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem",
                    },
                }
            },
        },
        ['ParticlesSkills'] =
        {
            "particles/econ/items/antimage/antimage_ti7_golden/antimage_blink_start_ti7_golden.vpcf",
            "particles/econ/items/antimage/antimage_ti7_golden/antimage_blink_ti7_golden_end.vpcf"
        }
    },
    [8729] = 
    {
        ['item_id'] =8729,
        ['name'] ='Bracers of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_arms/god_eater_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_arms/god_eater_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_bracer_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bracer_l"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bracer_r"
                    },
                }
            },
        },
    },
    [8732] = 
    {
        ['item_id'] =8732,
        ['name'] ='Hair of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_head/god_eater_head',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_head/god_eater_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_head_ambient.vpcf",
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
    },
    [8734] = 
    {
        ['item_id'] =8734,
        ['name'] ='Blade of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_weapon/god_eater_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_weapon/god_eater_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_blade_primary_godeater.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                        "attach_attack1", "hero"
                    },
                }
            },
        },
    },
    [8735] = 
    {
        ['item_id'] =8735,
        ['name'] ='Offhand Blade of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_off_hand/god_eater_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_off_hand/god_eater_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_blade_offhand_godeater.vpcf",
                ["IsHero"] = 1,
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
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
    [8730] = 
    {
        ['item_id'] =8730,
        ['name'] ='Tunic of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_armor/god_eater_armor',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_armor/god_eater_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
    },
    [8733] = 
    {
        ['item_id'] =8733,
        ['name'] ='Shoulders of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_shoulder/god_eater_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_shoulder/god_eater_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_weapon_godeater/antimage_godeater_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_l"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_r"
                    },
                }
            },
        },
    },
    [8731] = 
    {
        ['item_id'] =8731,
        ['name'] ='Belt of the Survivor',
        ['icon'] ='econ/items/antimage/god_eater_belt/god_eater_belt',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/god_eater_belt/god_eater_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_god_eater',
    },



    [14506] = 
    {
        ['item_id'] =14506,
        ['name'] ='Armor of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_armor/am_shinobi_armor',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_armor/am_shinobi_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_armor.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_fx_left",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_fx_right",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_fx_left_02",
                    },
                }
            },
        },
    },
    [14508] = 
    {
        ['item_id'] =14508,
        ['name'] ='Belt of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_belt/am_shinobi_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_belt/am_shinobi_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
    },
    [14509] = 
    {
        ['item_id'] =14509,
        ['name'] ='Mask of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_head/am_shinobi_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_head/am_shinobi_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_fx",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_fx",
                    },
                }
            },
        },
    },
    [14512] = 
    {
        ['item_id'] =14512,
        ['name'] ='Weapon of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_weapon/am_shinobi_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_weapon/am_shinobi_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14510] = 
    {
        ['item_id'] =14510,
        ['name'] ='Off-Hand Weapon of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_off_hand/am_shinobi_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_off_hand/am_shinobi_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_offhand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14511] = 
    {
        ['item_id'] =14511,
        ['name'] ='Pauldron of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_shoulder/am_shinobi_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_shoulder/am_shinobi_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_fx",
                    },
                }
            },
        },
    },
    [14507] = 
    {
        ['item_id'] =14507,
        ['name'] ='Bracer of the Forgotten Plane',
        ['icon'] ='econ/items/antimage/am_shinobi_arms/am_shinobi_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_shinobi_arms/am_shinobi_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_shinobi',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_shinobi/antimage_shinobi_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },


    [24932] = 
    {
        ['item_id'] =24932,
        ['name'] ='Brands of the Reaper - Off-Hand Weapon',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_weapon_offhand/am_eternal_reaper_weapon_offhand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_weapon_offhand/am_eternal_reaper_weapon_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/am_eternal_reaper/am_eternal_weapon_off_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [24931] = 
    {
        ['item_id'] =24931,
        ['name'] ='Brands of the Reaper - Weapon',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_weapon/am_eternal_reaper_weapon',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_weapon/am_eternal_reaper_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/am_eternal_reaper/am_eternal_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [24930] = 
    {
        ['item_id'] =24930,
        ['name'] ='Brands of the Reaper - Shoulders',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_shoulders/am_eternal_reaper_shoulders',
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_shoulders/am_eternal_reaper_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/am_eternal_reaper/am_eternal_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [24924] = 
    {
        ['item_id'] =24924,
        ['name'] ='Brands of the Reaper - Head',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_head/am_eternal_reaper_head',
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_head/am_eternal_reaper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/am_eternal_reaper/am_eternal_head_ambient.vpcf",
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
    [24923] = 
    {
        ['item_id'] =24923,
        ['name'] ='Brands of the Reaper - Belt',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_belt/am_eternal_reaper_belt',
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_belt/am_eternal_reaper_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
    },
    [24922] = 
    {
        ['item_id'] =24922,
        ['name'] ='Brands of the Reaper - Arms',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_arms/am_eternal_reaper_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_arms/am_eternal_reaper_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
    },
    [24921] = 
    {
        ['item_id'] =24921,
        ['name'] ='Brands of the Reaper - Armor',
        ['icon'] ='econ/items/antimage/am_eternal_reaper_armor/am_eternal_reaper_armor',
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/am_eternal_reaper_armor/am_eternal_reaper_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'brand_of_the_reaper',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/am_eternal_reaper/am_eternal_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem",
                    },
                }
            },
        },
    },


    [23776] = 
    {
        ['item_id'] =23776,
        ['name'] ='Belt of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_belt_high',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_belt_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
    },
    [23778] = 
    {
        ['item_id'] =23778,
        ['name'] ='Shoulders of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_shoulder_high',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_shoulder_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
    },
    [23779] = 
    {
        ['item_id'] =23779,
        ['name'] ='Armor of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_armor_high',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_armor_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
    },
    [23780] = 
    {
        ['item_id'] =23780,
        ['name'] ='Mohawk of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_hair_high',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_hair_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_calavera/antimage_calavera_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
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
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l",
                    },
                }
            },
        },
    },
    [23781] = 
    {
        ['item_id'] =23781,
        ['name'] ='Blade of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_weapon_high',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_weapon_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_revenants_crescent/antimage_revenants_crescent_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_001",
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_002",
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_003",
                    },
                    [23] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_004",
                    },
                    [24] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_005",
                    },
                    [25] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_006",
                    },
                    [26] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_007",
                    },
                    [27] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_008",
                    },
                    [28] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_009",
                    },
                    [29] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "weapon_tip_0010",
                    },
                }
            },
        },
    },
    [23782] = 
    {
        ['item_id'] =23782,
        ['name'] ='Offhand of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_offhand_high',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_offhand_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/antimage/antimage_revenants_crescent/antimage_revenants_crescent_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [40] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_001",
                    },
                    [41] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_002",
                    },
                    [42] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_003",
                    },
                    [43] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_004",
                    },
                    [44] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_005",
                    },
                    [45] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_006",
                    },
                    [46] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_007",
                    },
                    [47] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_008",
                    },
                    [48] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_009",
                    },
                    [49] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "offhand_tip_0010",
                    },
                }
            },
        },
    },
    [23775] = 
    {
        ['item_id'] =23775,
        ['name'] ='Bracers of the Spectral Hunter',
        ['icon'] ='econ/items/antimage/antimage_calavera/antimage_calavera_arms_high',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/antimage/antimage_calavera/antimage_calavera_arms_high.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'am_spectral_hunter',
    },
    [13783] = 
    {
        ["dota_id"] = 13783,
        ['item_id'] = 13783,
        ['name'] = "The Disciples Path",
        ['icon'] = "econ/heroes/antimage_female/antimage_female",
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ["is_persona_item"] = 1,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_1",
        ['sets'] = 'rare',
        ['persona'] = 1,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_antimage_female/am_female_blade_r_ambient.vpcf",
            "particles/units/heroes/hero_antimage_female/am_female_blade_l_ambient.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/heroes/antimage_female/antimage_female_clothing.vmdl",
            "models/heroes/antimage_female/antimage_female_hair.vmdl",
            "models/heroes/antimage_female/antimage_female_offhand.vmdl",
            "models/heroes/antimage_female/antimage_female_weapon.vmdl",
        },
    },
    [29296] = 
    {
        ['item_id'] = 29296,
        ['name'] = "Turstarkuri Pilgrim",
        ['icon'] = "econ/sets/DOTA_Item_Anti_Mage_Nemesis_Slayer",
        ['price'] = 1000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_2",
        ['sets'] = 'antimage_persona',
        ['persona'] = 2,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {

            "particles/econ/items/antimage_female/nemesis_slayer/nemesis_weapon_l_ambient.vpcf",
            "particles/econ/items/antimage_female/nemesis_slayer/nemesis_weapon_r_ambient.vpcf",
            "particles/econ/items/antimage_female/nemesis_slayer/nemesis_armor_ambient.vpcf",
            "particles/econ/items/antimage_female/nemesis_slayer/nemesis_head_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/antimage_female/anti_mage_nemesis_slayer_offhand_weapon_persona_1/anti_mage_nemesis_slayer_offhand_weapon_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_nemesis_slayer_armor_persona_1/anti_mage_nemesis_slayer_armor_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_nemesis_slayer_head_persona_1/anti_mage_nemesis_slayer_head_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_nemesis_slayer_weapon_persona_1/anti_mage_nemesis_slayer_weapon_persona_1.vmdl",
        },
    },
    [29137] = 
    {
        ['item_id'] = 29137,
        ['name'] = "Proselyte of the Sakura Clan",
        ['icon'] = "econ/sets/DOTA_Item_Proselyte_of_the_Sakura_Clan",
        ['price'] = 1000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_3",
        ['sets'] = 'antimage_persona',
        ['persona'] = 3,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {

            "particles/econ/items/antimage_female/cherry_blossom/cherry_blossom_armor_ambient.vpcf",
            "particles/econ/items/antimage_female/cherry_blossom/cherry_blossom_head_ambient.vpcf",
            "particles/econ/items/antimage_female/cherry_blossom/cherry_blossom_offhand_ambient.vpcf",
            "particles/econ/items/antimage_female/cherry_blossom/cherry_blossom_weapon_ambient.vpcf", 
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/antimage_female/anti_mage_cherry_blossom_armor_persona_1/anti_mage_cherry_blossom_armor_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_cherry_blossom_head_persona_1/anti_mage_cherry_blossom_head_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_cherry_blossom_offhand_weapon_persona_1/anti_mage_cherry_blossom_offhand_weapon_persona_1.vmdl",
            "models/items/antimage_female/anti_mage_cherry_blossom_weapon_persona_1/anti_mage_cherry_blossom_weapon_persona_1.vmdl",
        },
    },
    [27297] = 
    {
        ['item_id'] = 27297,
        ['name'] = "Pinions of Piety",
        ['icon'] = "econ/sets/DOTA_Item_Screeauk_AM_Set",
        ['price'] = 1000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_4",
        ['sets'] = 'antimage_persona',
        ['persona'] = 4,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/econ/items/antimage_female/am_screeauk/am_screeauk_weapon_l_ambient.vpcf",
            "particles/econ/items/antimage_female/am_screeauk/am_screeauk_weapon_r_ambient.vpcf",
            "particles/econ/items/antimage_female/am_screeauk/am_screeauk_head_ambient.vpcf"  
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/antimage_female/am_screeauk/am_screeauk_weapon.vmdl",
            "models/items/antimage_female/am_screeauk/am_screeauk_offhand.vmdl",
            "models/items/antimage_female/am_screeauk/am_screeauk_hair.vmdl",
            "models/items/antimage_female/am_screeauk/am_screeauk_armor.vmdl",
        },
    },
    [28278] = 
    {
        ['item_id'] = 28278,
        ['name'] = "Designs of the Dragon",
        ['icon'] = "econ/sets/DOTA_Item_Designs_of_the_Dragon",
        ['price'] = 1000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_5",
        ['sets'] = 'antimage_persona',
        ['persona'] = 5,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/econ/items/antimage_female/loong_warrior/loong_warrior_blade_l_ambient.vpcf",
            "particles/econ/items/antimage_female/loong_warrior/loong_warrior_blade_r_ambient.vpcf", 
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/antimage_female/loong_warrior_weapon_l/loong_warrior_weapon_l.vmdl",
            "models/items/antimage_female/loong_warrior_weapon_r/loong_warrior_weapon_r.vmdl",
            "models/items/antimage_female/loong_warrior_head/loong_warrior_head.vmdl",
            "models/items/antimage_female/loong_warrior_aromr/loong_warrior_aromr.vmdl",
        },
    },
    [29126] = 
    {
        ['item_id'] = 29126,
        ['name'] = "Spellbreaker's Braid",
        ['icon'] = "econ/sets/DOTA_Item_Spellbreakers_Braid",
        ['price'] = 1000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/antimage_female/antimage_female.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_antimage_persona_custom_6",
        ['sets'] = 'antimage_persona',
        ['persona'] = 6,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/econ/items/antimage_female/jewels_spellbreaker/jewels_spellbreaker_head_ambient.vpcf",
            "particles/econ/items/antimage_female/jewels_spellbreaker/jewels_spellbreaker_weapon_ambient.vpcf",
            "particles/econ/items/antimage_female/jewels_spellbreaker/jewels_spellbreaker_offhand_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/antimage_female/jewels_of_the_spellbreaker_head/jewels_of_the_spellbreaker_head.vmdl",
            "models/items/antimage_female/jewels_of_the_spellbreaker_armor/jewels_of_the_spellbreaker_armor.vmdl",
            "models/items/antimage_female/jewels_of_the_spellbreaker_weapon/jewels_of_the_spellbreaker_weapon.vmdl",
            "models/items/antimage_female/jewels_of_the_spellbreaker_offhand/jewels_of_the_spellbreaker_offhand.vmdl",
        },
    },
    [28946] = {
    ['item_id'] =28946,
    ['name'] ='Turstarkuri Pilgrim Offhand Weapon',
    ['icon'] ='econ/items/antimage_female/anti_mage_nemesis_slayer_offhand_weapon_persona_1/anti_mage_nemesis_slayer_offhand_weapon_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_nemesis_slayer_offhand_weapon_persona_1/anti_mage_nemesis_slayer_offhand_weapon_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'turstarkuri_pilgrim',
    },
    [29279] = {
    ['item_id'] =29279,
    ['name'] ='Turstarkuri Pilgrim Armor',
    ['icon'] ='econ/items/antimage_female/anti_mage_nemesis_slayer_armor_persona_1/anti_mage_nemesis_slayer_armor_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_nemesis_slayer_armor_persona_1/anti_mage_nemesis_slayer_armor_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'turstarkuri_pilgrim',
    },
    [29280] = {
    ['item_id'] =29280,
    ['name'] ='Turstarkuri Pilgrim Head',
    ['icon'] ='econ/items/antimage_female/anti_mage_nemesis_slayer_head_persona_1/anti_mage_nemesis_slayer_head_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_nemesis_slayer_head_persona_1/anti_mage_nemesis_slayer_head_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'turstarkuri_pilgrim',
    },
    [29281] = {
    ['item_id'] =29281,
    ['name'] ='Turstarkuri Pilgrim Weapon',
    ['icon'] ='econ/items/antimage_female/anti_mage_nemesis_slayer_weapon_persona_1/anti_mage_nemesis_slayer_weapon_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_nemesis_slayer_weapon_persona_1/anti_mage_nemesis_slayer_weapon_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'turstarkuri_pilgrim',
    },
    [28570] = {
    ['item_id'] =28570,
    ['name'] ='Proselyte of the Sakura Clan - Head',
    ['icon'] ='econ/items/antimage_female/anti_mage_cherry_blossom_head_persona_1/anti_mage_cherry_blossom_head_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_cherry_blossom_head_persona_1/anti_mage_cherry_blossom_head_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'proselyte_sakura',
    },
    [28571] = {
    ['item_id'] =28571,
    ['name'] ='Proselyte of the Sakura Clan - Offhand',
    ['icon'] ='econ/items/antimage_female/anti_mage_cherry_blossom_offhand_weapon_persona_1/anti_mage_cherry_blossom_offhand_weapon_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_cherry_blossom_offhand_weapon_persona_1/anti_mage_cherry_blossom_offhand_weapon_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'proselyte_sakura',
    },
    [28572] = {
    ['item_id'] =28572,
    ['name'] ='Proselyte of the Sakura Clan - Weapon',
    ['icon'] ='econ/items/antimage_female/anti_mage_cherry_blossom_weapon_persona_1/anti_mage_cherry_blossom_weapon_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_cherry_blossom_weapon_persona_1/anti_mage_cherry_blossom_weapon_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'proselyte_sakura',
    },
    [28569] = {
    ['item_id'] =28569,
    ['name'] ='Proselyte of the Sakura Clan - Armor',
    ['icon'] ='econ/items/antimage_female/anti_mage_cherry_blossom_armor_persona_1/anti_mage_cherry_blossom_armor_persona_1',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/anti_mage_cherry_blossom_armor_persona_1/anti_mage_cherry_blossom_armor_persona_1.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'proselyte_sakura',
    },

    [27296] = {
    ['item_id'] =27296,
    ['name'] ='Pinions of Piety - Head',
    ['icon'] ='econ/items/antimage_female/am_screeauk/am_screeauk_hair',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_hair.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{27296, "#922bc2"}, {272961, "#27308d"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    },
    [26785] = {
    ['item_id'] =26785,
    ['name'] ='Pinions of Piety - Weapon',
    ['icon'] ='econ/items/antimage_female/am_screeauk/am_screeauk_weapon',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{26785, "#922bc2"}, {267851, "#27308d"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    },
    [27224] = {
    ['item_id'] =27224,
    ['name'] ='Pinions of Piety - Offhand',
    ['icon'] ='econ/items/antimage_female/am_screeauk/am_screeauk_offhand',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{27224, "#922bc2"}, {272241, "#27308d"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    },
    [27560] = {
    ['item_id'] =27560,
    ['name'] ='Pinions of Piety - Armor',
    ['icon'] ='econ/items/antimage_female/am_screeauk/am_screeauk_armor',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{27560, "#922bc2"}, {275601, "#27308d"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    },


    [272961] = {
    ['dota_id'] = 27296,
    ['item_id'] =272961,
    ["ItemStyle"] = "1",
    ['name'] ='Pinions of Piety - Head',
    ['icon'] ="econ/items/antimage_female/am_screeauk/am_screeauk_hair_style1",
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ="models/items/antimage_female/am_screeauk/am_screeauk_hair.vmdl",
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{27296, "#922bc2"}, {272961, "#27308d"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    ['MaterialGroupItem'] = "1",
    },
    [267851] = {
    ['dota_id'] = 26785,
    ['item_id'] =267851,
    ["ItemStyle"] = "1",
    ['name'] ='Pinions of Piety - Weapon',
    ['icon'] ="econ/items/antimage_female/am_screeauk/am_screeauk_weapon_style1",
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{26785, "#922bc2"}, {267851, "#27308d"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    ['MaterialGroupItem'] = "1",
    },
    [272241] = {
    ['dota_id'] = 27224,
    ['item_id'] =272241,
    ["ItemStyle"] = "1",
    ['name'] ='Pinions of Piety - Offhand',
    ['icon'] ="econ/items/antimage_female/am_screeauk/am_screeauk_offhand_style1",
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{27224, "#922bc2"}, {272241, "#27308d"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    ['MaterialGroupItem'] = "1",
    },
    [275601] = {
    ['dota_id'] = 27560,
    ['item_id'] =275601,
    ["ItemStyle"] = "1",
    ['name'] ='Pinions of Piety - Armor',
    ['icon'] ="econ/items/antimage_female/am_screeauk/am_screeauk_armor_style1",
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/am_screeauk/am_screeauk_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{27560, "#922bc2"}, {275601, "#27308d"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'pinions_piety',
    ['MaterialGroupItem'] = "1",
    },


    [28263] = {
    ['item_id'] =28263,
    ['name'] ='Designs of the Dragon - Armor',
    ['icon'] ='econ/items/antimage_female/loong_warrior_aromr/loong_warrior_aromr',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/loong_warrior_aromr/loong_warrior_aromr.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'designs_dragon',
    },
    [28261] = {
    ['item_id'] =28261,
    ['name'] ='Designs of the Dragon - Offhand',
    ['icon'] ='econ/items/antimage_female/loong_warrior_weapon_l/loong_warrior_weapon_l',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/loong_warrior_weapon_l/loong_warrior_weapon_l.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'designs_dragon',
    },
    [28260] = {
    ['item_id'] =28260,
    ['name'] ='Designs of the Dragon - Weapon',
    ['icon'] ='econ/items/antimage_female/loong_warrior_weapon_r/loong_warrior_weapon_r',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/loong_warrior_weapon_r/loong_warrior_weapon_r.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'designs_dragon',
    },
    [28262] = {
    ['item_id'] =28262,
    ['name'] ='Designs of the Dragon - Head',
    ['icon'] ='econ/items/antimage_female/loong_warrior_head/loong_warrior_head',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/loong_warrior_head/loong_warrior_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'designs_dragon',
    },
    [31144] = {
    ['item_id'] =31144,
    ['name'] = "Spellbreaker's Braid - Offhand Weapon",
    ['icon'] ='econ/items/antimage_female/jewels_of_the_spellbreaker_offhand/jewels_of_the_spellbreaker_offhand',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/jewels_of_the_spellbreaker_offhand/jewels_of_the_spellbreaker_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'spellbreaker_braid',
    },
    [31143] = {
    ['item_id'] =31143,
    ['name'] = "Spellbreaker's Braid - Weapon",
    ['icon'] ='econ/items/antimage_female/jewels_of_the_spellbreaker_weapon/jewels_of_the_spellbreaker_weapon',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/jewels_of_the_spellbreaker_weapon/jewels_of_the_spellbreaker_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'spellbreaker_braid',
    },
    [31141] = {
    ['item_id'] =31141,
    ['name'] = "Spellbreaker's Braid - Head",
    ['icon'] ='econ/items/antimage_female/jewels_of_the_spellbreaker_head/jewels_of_the_spellbreaker_head',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/jewels_of_the_spellbreaker_head/jewels_of_the_spellbreaker_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'spellbreaker_braid',
    },
    [31142] = {
    ['item_id'] =31142,
    ['name'] = "Spellbreaker's Braid - Armor",
    ['icon'] ='econ/items/antimage_female/jewels_of_the_spellbreaker_armor/jewels_of_the_spellbreaker_armor',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/jewels_of_the_spellbreaker_armor/jewels_of_the_spellbreaker_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'spellbreaker_braid',
    },

[34226] = 
{
    ['item_id'] =34226,
    ['name'] ='Kirin Horn',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_head',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{34226, "#7339aa"}, {35834, "#4144cf"}, {35839, "#d59843"}, {35844, "#59a4ea"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[34227] = 
{
    ['item_id'] =34227,
    ['name'] ='Kirin Jacket and Hoop',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{34227, "#7339aa"}, {35833, "#4144cf"}, {35838, "#d59843"}, {35843, "#59a4ea"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[34228] = 
{
    ['item_id'] =34228,
    ['name'] ='Kirin Bolts Dual Blade',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{34228, "#7339aa"}, {35835, "#4144cf"}, {35840, "#d59843"}, {35845, "#59a4ea"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[34229] = 
{
    ['item_id'] =34229,
    ['name'] ='Kirin Bolts Dual Blade Offhand',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand',
    ['price'] = 250,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = {{34229, "#7339aa"}, {35836, "#4144cf"}, {35841, "#d59843"}, {35846, "#59a4ea"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},

[35834] = 
{
    ['item_id'] =35834,
    ['name'] ='Icewrack Kirin Horn',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_horn',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "2",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34226, "#7339aa"}, {35834, "#4144cf"}, {35839, "#d59843"}, {35844, "#59a4ea"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35833] = 
{
    ['item_id'] =35833,
    ['name'] ='Icewrack Kirin Jacket and Hoop',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor_oroshi',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "1",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34227, "#7339aa"}, {35833, "#4144cf"}, {35838, "#d59843"}, {35843, "#59a4ea"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35835] = 
{
    ['item_id'] =35835,
    ['name'] ='Icewrack Kirin Bolts Dual Blade',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon_oroshi',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "2",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34228, "#7339aa"}, {35835, "#4144cf"}, {35840, "#d59843"}, {35845, "#59a4ea"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35836] = 
{
    ['item_id'] =35836,
    ['name'] ='Icewrack Kirin Bolts Dual Blade Offhand',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand_oroshi',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "2",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34229, "#7339aa"}, {35836, "#4144cf"}, {35841, "#d59843"}, {35846, "#59a4ea"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},

[35839] = 
{
    ['item_id'] =35839,
    ['name'] ='Golden Basher Kirin Horn',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_horn_thunder',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "3",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34226, "#7339aa"}, {35834, "#4144cf"}, {35839, "#d59843"}, {35844, "#59a4ea"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35838] = 
{
    ['item_id'] =35838,
    ['name'] ='Golden Basher Kirin Jacket and Hoop',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor_thunder',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "2",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34227, "#7339aa"}, {35833, "#4144cf"}, {35838, "#d59843"}, {35843, "#59a4ea"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35840] = 
{
    ['item_id'] =35840,
    ['name'] ='Golden Basher Kirin Bolts Dual Blade',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon_thunder',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "3",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34228, "#7339aa"}, {35835, "#4144cf"}, {35840, "#d59843"}, {35845, "#59a4ea"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35841] = 
{
    ['item_id'] =35841,
    ['name'] ='Golden Basher Kirin Bolts Dual Blade Offhand',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand_thunder',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "3",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34229, "#7339aa"}, {35836, "#4144cf"}, {35841, "#d59843"}, {35846, "#59a4ea"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},

[35844] = 
{
    ['item_id'] =35844,
    ['name'] ='Prismatic Kirin Horn',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_horn_pigment',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "4",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_head_rainbow.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34226, "#7339aa"}, {35834, "#4144cf"}, {35839, "#d59843"}, {35844, "#59a4ea"}},
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35843] = 
{
    ['item_id'] =35843,
    ['name'] ='Prismatic Kirin Jacket and Hoop',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor_rainbow',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "3",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_armor_rainbow.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34227, "#7339aa"}, {35833, "#4144cf"}, {35838, "#d59843"}, {35843, "#59a4ea"}},
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35845] = 
{
    ['item_id'] =35845,
    ['name'] ='Prismatic Kirin Bolts Dual Blade',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon_rainbow',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "4",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_weapon_rainbow.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34228, "#7339aa"}, {35835, "#4144cf"}, {35840, "#d59843"}, {35845, "#59a4ea"}},
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
[35846] = 
{
    ['item_id'] =35846,
    ['name'] ='Prismatic Kirin Bolts Dual Blade Offhand',
    ['icon'] ='econ/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand_rainbow',
    ['price'] = 1,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroupItem'] = "4",
    ['ItemModel'] ='models/items/antimage_female/mh_antimage_kirin/mh_antimage_kirin_offhand_rainbow.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 1,
    ['OtherItemsBundle'] = {{34229, "#7339aa"}, {35836, "#4144cf"}, {35841, "#d59843"}, {35846, "#59a4ea"}},
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'antimage_persona_kirin',
},
}