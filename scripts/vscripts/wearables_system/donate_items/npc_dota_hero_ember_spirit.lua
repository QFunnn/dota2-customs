--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [7470] = 
    {
        ['item_id'] =7470,
        ['name'] ='Rapier of the Burning God Offhand',
        ['icon'] ='econ/items/ember_spirit/rapier_burning_god_offhand/rapier_burning_god_offhand',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/rapier_burning_god_offhand/rapier_burning_god_offhand.vmdl',
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
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_burning_god_offhand/ember_spirit_ambient_burning_god_l.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
        },
    },
    [7472] = 
    {
        ['item_id'] =7472,
        ['name'] ='Rapier of the Burning God',
        ['icon'] ='econ/items/ember_spirit/rapier_burning_god_weapon/rapier_burning_god_weapon',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/rapier_burning_god_weapon/rapier_burning_god_weapon.vmdl',
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
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_burning_god_weapon/ember_spirit_ambient_burning_god_r.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [13007] = 
    {
        ['item_id'] =13007,
        ['name'] ='Apogee of the Guardian Flame',
        ['icon'] ='econ/items/ember_spirit/ember_ti9_immortal_shoulder/ember_ti9_immortal_shoulder',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_ti9_immortal_shoulder/ember_ti9_immortal_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_ember_spirit_immortal_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ember_spirit/ember_ti9/ember_ti9_flameguard.vpcf",
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_ti9/ember_ti9_shoulders_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_sun"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scarf_l"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scarf_r"
                    },
                }
            },
        },
    },
    [12260] = 
    {
        ['item_id'] =12260,
        ['name'] ='Sword of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_weapon/magma_spirit_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_weapon/magma_spirit_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/ember_spirit_swords/ember_spirit_ambient_sword_primary_volcanic.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/ember_spirit_swords/ember_spirit_ambient_sword_primary_blade_volcanic.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [12261] = 
    {
        ['item_id'] =12261,
        ['name'] ='Helm of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_head/magma_spirit_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_head/magma_spirit_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [12263] = 
    {
        ['item_id'] =12263,
        ['name'] ='Bracers of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_arms/magma_spirit_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_arms/magma_spirit_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
    },
    [12267] = 
    {
        ['item_id'] =12267,
        ['name'] ='Pauldrons of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_shoulder/magma_spirit_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_shoulder/magma_spirit_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_shoulder_glow.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_glow_r"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_glow_l"
                    },
                }
            },
        },
    },
    [12268] = 
    {
        ['item_id'] =12268,
        ['name'] ='Belt of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_belt/magma_spirit_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_belt/magma_spirit_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
    },
    [12262] = 
    {
        ['item_id'] =12262,
        ['name'] ='Off-hand Weapon of the Volcanic Guard',
        ['icon'] ='econ/items/ember_spirit/magma_spirit_off_hand/magma_spirit_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/magma_spirit_off_hand/magma_spirit_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'volcanic_guard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/ember_spirit_swords/ember_spirit_ambient_sword_offhand_volcanic.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_offhand_blade_volcanic.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
        },
    },
    [13442] = 
    {
        ['item_id'] =13442,
        ['name'] ='Cinder Sensei Bracer',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_arms/ember_sindur_sensei_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_arms/ember_sindur_sensei_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sindur_sensei',
    },
    [13441] = 
    {
        ['item_id'] =13441,
        ['name'] ='Cinder Sensei Belt',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_belt/ember_sindur_sensei_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_belt/ember_sindur_sensei_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sindur_sensei',
    },
    [13383] = 
    {
        ['item_id'] =13383,
        ['name'] ='Cinder Sensei Shoulders',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_shoulder/ember_sindur_sensei_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_shoulder/ember_sindur_sensei_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sindur_sensei',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_shoulder_glow.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_glow_r"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_glow_l"
                    },
                }
            },
        },
    },
    [13440] = 
    {
        ['item_id'] =13440,
        ['name'] ='Cinder Sensei Off-Hand Weapon',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_offhand/ember_sindur_sensei_offhand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_offhand/ember_sindur_sensei_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_weapon_sindur_sensei_offhand_custom",
        ['sets'] = 'sindur_sensei',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_sindur/ember_sindur_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        },
    },
    [13382] = 
    {
        ['item_id'] =13382,
        ['name'] ='Cinder Sensei Weapon',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_weapon/ember_sindur_sensei_weapon',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_weapon/ember_sindur_sensei_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_weapon_sindur_sensei_weapon_custom",
        ['sets'] = 'sindur_sensei',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_sindur/ember_sindur_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        },
    },
    [13381] = 
    {
        ['item_id'] =13381,
        ['name'] ='Cinder Sensei Style',
        ['icon'] ='econ/items/ember_spirit/ember_sindur_sensei_head/ember_sindur_sensei_head',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/ember_sindur_sensei_head/ember_sindur_sensei_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sindur_sensei',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_sindur/ember_sindur_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_goatee"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_lip_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_lip_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_side_l"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_side_r"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_l"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_m"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hair_r"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_brow_l"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_brow_r"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_topknot"
                    },
                }
            },
        },
    },
    [13290] = 
    {
        ['item_id'] =13290,
        ['name'] ='Master of the Searing Path Arms',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_arms/kungfu_master_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_arms/kungfu_master_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
    },
    [13299] = 
    {
        ['item_id'] =13299,
        ['name'] ='Master of the Searing Path Head',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_head/kungfu_master_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_head/kungfu_master_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_ti10_cache/ember_ti10_cache_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [13302] = 
    {
        ['item_id'] =13302,
        ['name'] ='Master of the Searing Path Off-Hand',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_off_hand/kungfu_master_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_off_hand/kungfu_master_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_ti10_cache/ember_ti10_cache_offhand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_core_fx_01",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_core_fx_02",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_01",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_02",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_03",
                    },
                }
            },
        },
    },
    [13301] = 
    {
        ['item_id'] =13301,
        ['name'] ='Master of the Searing Path Shoulder',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_shoulder/kungfu_master_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_shoulder/kungfu_master_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
    },
    [13300] = 
    {
        ['item_id'] =13300,
        ['name'] ='Master of the Searing Path Weapon',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_weapon/kungfu_master_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_weapon/kungfu_master_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_ti10_cache/ember_ti10_cache_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_01",
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_02",
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx_03",
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx_01",
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_core_fx_02",
                    },
                }
            },
        },
    },
    [13361] = 
    {
        ['item_id'] =13361,
        ['name'] ='Master of the Searing Path Belt',
        ['icon'] ='econ/items/ember_spirit/kungfu_master_belt/kungfu_master_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/kungfu_master_belt/kungfu_master_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'searing_path',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_ti10_cache/ember_ti10_cache_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        },
    },
    [8879] = 
    {
        ['item_id'] =8879,
        ['name'] ='Hood of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_head/vanishing_flame_head',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_head/vanishing_flame_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [8880] = 
    {
        ['item_id'] =8880,
        ['name'] ='Tunic of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_belt/vanishing_flame_belt',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_belt/vanishing_flame_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_vanishing_flame/ember_spirit_vanishing_flame_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
            },
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_vanishing_flame/ember_spirit_vanishing_flame_ambient_gem.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_glyph"
                    },
                }
            },
        },
    },
    [8881] = 
    {
        ['item_id'] =8881,
        ['name'] ='Spaulder of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_shoulder/vanishing_flame_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_shoulder/vanishing_flame_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
    },
    [8882] = 
    {
        ['item_id'] =8882,
        ['name'] ='Guard of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_arms/vanishing_flame_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_arms/vanishing_flame_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
    },
    [8883] = 
    {
        ['item_id'] =8883,
        ['name'] ='Off-Hand Blade of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_off_hand/vanishing_flame_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_off_hand/vanishing_flame_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/ember_spirit_swords/ember_spirit_ambient_sword_offhand_wandering.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
        }
    },
    [8884] = 
    {
        ['item_id'] =8884,
        ['name'] ='Blade of the Wandering Flame',
        ['icon'] ='econ/items/ember_spirit/vanishing_flame_weapon/vanishing_flame_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/vanishing_flame_weapon/vanishing_flame_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'wandering_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/ember_spirit_swords/ember_spirit_ambient_sword_primary_wandering.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [12482] = 
    {
        ['item_id'] =12482,
        ['name'] ='Weapon of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_weapon/desert_warrior_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_weapon/desert_warrior_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_primary.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_desert_warrior_weapon/ember_spirit_desert_warrior_weapon_primary_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        },
    },
    [12483] = 
    {
        ['item_id'] =12483,
        ['name'] ='Off-Hand Weapon of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_off_hand/desert_warrior_off_hand',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_off_hand/desert_warrior_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_sword_offhand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/ember_spirit/ember_spirit_desert_warrior_off/ember_spirit_desert_warrior_off_primary_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        }
    },
    [12485] = 
    {
        ['item_id'] =12485,
        ['name'] ='Vetments of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_shoulder/desert_warrior_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_shoulder/desert_warrior_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
    },
    [12487] = 
    {
        ['item_id'] =12487,
        ['name'] ='Bracers of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_arms/desert_warrior_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_arms/desert_warrior_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
    },
    [12486] = 
    {
        ['item_id'] =12486,
        ['name'] ='Hood of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_head/desert_warrior_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_head/desert_warrior_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_ember_spirit/ember_spirit_ambient_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            },
        },
    },
    [12484] = 
    {
        ['item_id'] =12484,
        ['name'] ='Belt of the Forsaken Flame',
        ['icon'] ='econ/items/ember_spirit/desert_warrior_belt/desert_warrior_belt',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ember_spirit/desert_warrior_belt/desert_warrior_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forsaken_flame',
    },
}