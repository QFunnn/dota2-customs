--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [23096] = 
    {
        ['item_id'] =23096,
        ['name'] ='Voidstorm Asylum Helm',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_head.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_arcana/razor_arcana_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{23096, "#8567e6"}, {2309699, "#69fab4"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [23098] = 
    {
        ['item_id'] =23098,
        ['name'] ='Voidstorm Asylum Bracers',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_arms',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{23098, "#8567e6"}, {2309899, "#69fab4"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [23099] = 
    {
        ['item_id'] =23099,
        ['name'] ='Voidstorm Asylum Belt',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_belt',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{23099, "#8567e6"}, {2309999, "#69fab4"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [23095] = 
    {
        ["dota_id"] = 23095,
        ['item_id'] =23095,
        ['name'] ='Voidstorm Asylum Tormentor',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_weapon',
        ['price'] = 15000,
        ['sale'] = 0,
        ["ItemStyle"] = "0",
        ['sale_price'] = 0,
        ['MaterialGroup'] = "default",
        ["MaterialGroupItem"] = "default",
        ['HeroModel'] = "models/items/razor/razor_arcana/razor_arcana.vmdl",
        
        ['is_exclusive'] = 1,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_weapon.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_shield_ambient.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield_eye_fx"
                    },
                }
            },
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_weapon_ambient_control_points.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_01_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_02_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_03_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_04_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_05_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_06_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_07_fx"
                    },
                }
            },
        },
        ['ParticlesHero'] = 
        {
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_base_ambient_game.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {'SetParticleControl', 'default',},
                    [1] = {'SetParticleControl', 'default',},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield_eye_fx", "attach_hitloc"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_base_end_fx", "hero"
                    },
                }
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23095, "#8567e6"}, {2309599, "#69fab4"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_razor_arcana_custom",
        ['sets'] = 'razor_arcana',
        ["ParticlesSkills"] =
        {
            "particles/razor/razor_arcana_plasma.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_static_link.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_buff.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_unstable_current.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm.vpcf",
        }
    },
    [23097] = 
    {
        ['item_id'] =23097,
        ['name'] ='Voidstorm Asylum Armor',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_armor',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_armor.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_arcana/razor_arcana_shoulder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{23097, "#8567e6"}, {2309799, "#69fab4"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [2309599] = 
    {
        ["dota_id"] = 23095,
        ["ItemStyle"] = "1",
        ['item_id'] =2309599,
        ['name'] ='Voidstorm Asylum Tormentor',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_weapon',
        ['price'] = 15000,
        ['HeroModel'] = "models/items/razor/razor_arcana/razor_arcana.vmdl",
        
        ['MaterialGroup'] = "2",
        ["MaterialGroupItem"] = "2",
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_weapon.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_shield_v2_ambient.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield_eye_fx"
                    },
                }
            },
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_weapon_ambient_control_points_v2.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_01_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_02_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_03_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_04_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_05_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_06_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip_07_fx"
                    },
                }
            },
        },
        ['ParticlesHero'] =
        {
            {
                ['ParticleName'] = "particles/econ/items/razor/razor_arcana/razor_arcana_base_ambient_game_v2.vpcf",
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {
                    [0] = {'SetParticleControl', 'default',},
                    [1] = {'SetParticleControl', 'default',},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield_eye_fx", "attach_hitloc"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_base_end_fx", "hero"
                    },
                }
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23095, "#8567e6"}, {2309599, "#69fab4"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_razor_arcana_v2_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/razor/razor_arcana_plasma_green.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_v2.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_buff_v2.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_static_link_debuff_v2.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_v2_unstable_current.vpcf",
            "particles/econ/items/razor/razor_arcana/razor_arcana_v2_eye_of_the_storm.vpcf", 
            "particles/econ/items/razor/razor_arcana/razor_arcana_eye_of_the_storm_rain_v2.vpcf",
        }
    },
    [2309699] = 
    {
        ["dota_id"] = 23096,
        ['item_id'] =2309699,
        ['name'] ='Voidstorm Asylum Helm',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_head.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_arcana/razor_arcana_head_ambient_v2.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{23096, "#8567e6"}, {2309699, "#69fab4"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [2309899] = 
    {
        ["dota_id"] = 23098,
        ['item_id'] =2309899,
        ['name'] ='Voidstorm Asylum Bracers',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_arms',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ["MaterialGroupItem"] = "1",
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{23098, "#8567e6"}, {2309899, "#69fab4"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [2309999] = 
    {
        ["dota_id"] = 23099,
        ['item_id'] =2309999,
        ['name'] ='Voidstorm Asylum Belt',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_belt',
        ['price'] = 0,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{23099, "#8567e6"}, {2309999, "#69fab4"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [2309799] = 
    {
        ["dota_id"] = 23097,
        ['item_id'] =2309799,
        ['name'] ='Voidstorm Asylum Armor',
        ['icon'] ='econ/items/razor/razor_arcana/razor_arcana_armor',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 3,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_arcana/razor_arcana_armor.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_arcana/razor_arcana_shoulder_ambient_v2.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{23097, "#8567e6"}, {2309799, "#69fab4"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'razor_arcana',
    },
    [6646] = 
    {
        ['item_id'] =6646,
        ['name'] ='Severing Crest',
        ['icon'] ='econ/items/razor/razor_helmet_blade/razor_helmet_blade',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_helmet_blade/razor_helmet_blade.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_punctured_crest/razor_helmet_blade_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_razor_head_immortal_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/razor/razor_punctured_crest/razor_static_link_blade.vpcf",
        }
    },
    [6916] = 
    {
        ['item_id'] =6916,
        ['name'] ='Golden Severing Crest',
        ['icon'] ='econ/items/razor/razor_helmet_blade/razor_helmet_blade1',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/razor_helmet_blade/razor_helmet_blade_gold.vmdl',
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_punctured_crest_golden/razor_helmet_blade_ambient_golden.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_razor_head_immortal_custom_golden",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/razor/razor_punctured_crest_golden/razor_static_link_blade_golden.vpcf",
        }
    },
    [8000] = 
    {
        ['item_id'] = 8000,
        ['name'] ='Severing Lash',
        ['icon'] ='econ/items/razor/severing_lash/mesh/severing_lash',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/razor/razor.vmdl",
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/severing_lash/mesh/severing_lash.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['ParticlesItems'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/razor/razor_ti6/razor_whip_ti6.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip1"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip2"
                    },
                    [3] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip3"
                    },
                    [4] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip4"
                    },
                    [5] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_whip5"
                    },
                }
            },
        },
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_razor_weapon_last_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/razor/razor_ti6/razor_base_attack_ti6.vpcf",
            "particles/razor/razor_plasmafield_ti6.vpcf",
        }
    },

    [14812] = 
    {
        ['item_id'] =14812,
        ['name'] ='Test of the Basilisk Lord - Armor',
        ['icon'] ='econ/items/razor/eight_headed_basilisk_armor/eight_headed_basilisk_armor',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eight_headed_basilisk_armor/eight_headed_basilisk_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'basilisklord',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/razor/razor_eight_basilisk/razor_eight_basilisk_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
},
[14813] = 
{
        ['item_id'] =14813,
        ['name'] ='Test of the Basilisk Lord - Belt',
        ['icon'] ='econ/items/razor/eight_headed_basilisk_belt/eight_headed_basilisk_belt',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eight_headed_basilisk_belt/eight_headed_basilisk_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'basilisklord',
},
[14814] = 
{
        ['item_id'] =14814,
        ['name'] ='Test of the Basilisk Lord - Head',
        ['icon'] ='econ/items/razor/eight_headed_basilisk_head/eight_headed_basilisk_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eight_headed_basilisk_head/eight_headed_basilisk_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'basilisklord',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/razor/razor_eight_basilisk/razor_eight_basilisk_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_L"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_R"
                    },
                }
            },
        },
},
[14759] = 
{
        ['item_id'] =14759,
        ['name'] ='Test of the Basilisk Lord - Arms',
        ['icon'] ='econ/items/razor/eight_headed_basilisk_arms/eight_headed_basilisk_arms',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eight_headed_basilisk_arms/eight_headed_basilisk_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'basilisklord',
},
[14815] = 
{
        ['item_id'] =14815,
        ['name'] ='Test of the Basilisk Lord - Weapon',
        ['icon'] ='econ/items/razor/eight_headed_basilisk_weapon/eight_headed_basilisk_weapon',
        ['price'] = 1000,
        ['HeroModel'] = 'models/heroes/razor/razor.vmdl',
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eight_headed_basilisk_weapon/eight_headed_basilisk_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'basilisklord',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/razor/razor_eight_basilisk/razor_eight_basilisk_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
},

[19500] = 
{
        ['item_id'] =19500,
        ['name'] ='Cruel Assemblage Armor',
        ['icon'] ='econ/items/razor/energy_meteorite_armor/energy_meteorite_armor',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/energy_meteorite_armor/energy_meteorite_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cruelassemblage',
},
[19501] = 
{
        ['item_id'] =19501,
        ['name'] ='Cruel Assemblage Arms',
        ['icon'] ='econ/items/razor/energy_meteorite_arms/energy_meteorite_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/energy_meteorite_arms/energy_meteorite_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cruelassemblage',
},
[19502] = 
{
        ['item_id'] =19502,
        ['name'] ='Cruel Assemblage Belt',
        ['icon'] ='econ/items/razor/energy_meteorite_belt/energy_meteorite_belt',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/energy_meteorite_belt/energy_meteorite_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cruelassemblage',
},
[19503] = 
{
        ['item_id'] =19503,
        ['name'] ='Cruel Assemblage Head',
        ['icon'] ='econ/items/razor/energy_meteorite_head/energy_meteorite_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/energy_meteorite_head/energy_meteorite_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cruelassemblage',
},
[19505] = 
{
        ['item_id'] =19505,
        ['name'] ='Cruel Assemblage Weapon',
        ['icon'] ='econ/items/razor/energy_meteorite_weapon/energy_meteorite_weapon',
        ['price'] = 800,
        ['HeroModel'] = 'models/heroes/razor/razor.vmdl',
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/energy_meteorite_weapon/energy_meteorite_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cruelassemblage',
},

[18130] = 
{
        ['item_id'] =18130,
        ['name'] ='Head of the Forlorn Maze',
        ['icon'] ='econ/items/razor/eternal_torturer_head/eternal_torturer_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eternal_torturer_head/eternal_torturer_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forlornmaze',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/razor/razor_fall20_eternal_torturer/razor_fall20_eternal_torturer_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                }
            },
        },
},
[18131] = 
{
        ['item_id'] =18131,
        ['name'] ='Belt of the Forlorn Maze',
        ['icon'] ='econ/items/razor/eternal_torturer_belt/eternal_torturer_belt',
        ['price'] = 400,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eternal_torturer_belt/eternal_torturer_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forlornmaze',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/razor/razor_fall20_eternal_torturer/razor_fall20_eternal_torturer_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
},
[18132] = 
{
        ['item_id'] =18132,
        ['name'] ='Armor of the Forlorn Maze',
        ['icon'] ='econ/items/razor/eternal_torturer_armor/eternal_torturer_armor',
        ['price'] = 100,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eternal_torturer_armor/eternal_torturer_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forlornmaze',
},
[18133] = 
{
        ['item_id'] =18133,
        ['name'] ='Arms of the Forlorn Maze',
        ['icon'] ='econ/items/razor/eternal_torturer_arms/eternal_torturer_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eternal_torturer_arms/eternal_torturer_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forlornmaze',
},
[18227] = 
{
        ['item_id'] =18227,
        ['name'] ='Whip of the Forlorn Maze',
        ['icon'] ='econ/items/razor/eternal_torturer_weapon/eternal_torturer_weapon',
        ['price'] = 100,
        ['HeroModel'] = 'models/heroes/razor/razor.vmdl',
        
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/razor/eternal_torturer_weapon/eternal_torturer_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'forlornmaze',
},
}