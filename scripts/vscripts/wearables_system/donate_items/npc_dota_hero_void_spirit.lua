--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [27126] = 
    {
        ['item_id'] =27126,
        ['name'] ='Hidden Vector - Blade',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_weapon1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "10th_anniversary",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{18363, "#ae1536"}, {27126, "#e4c17f"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_void_spirit_immortal_2_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_ambient_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
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
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_astral_step.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_impact.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_debuff.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_dmg.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_astral_step_travel_strike_blur.vpcf",

        }
    },
    [18363] = 
    {
        ['item_id'] =18363,
        ['name'] ='Hidden Vector - Blade',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_weapon',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{18363, "#ae1536"}, {27126, "#e4c17f"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_void_spirit_immortal_1_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_ambient_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
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
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_impact.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_debuff.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_impact.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_dmg.vpcf",
            "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_astral_step_travel_strike_blur.vpcf",
        }
    },
    [18364] = 
    {
        ['item_id'] =18364,
        ['name'] ='Hidden Vector - Hat',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{18364, "#ae1536"}, {24612, "#e4c17f"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet_gem"
                    },
                }
            },
        },
    },
    [18365] = 
    {
        ['item_id'] =18365,
        ['name'] ='Hidden Vector - Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_armor',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{18365, "#ae1536"}, {27127, "#e4c17f"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_ambient_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                }
            },
        },
    },
    [18366] = 
    {
        ['item_id'] =18366,
        ['name'] ='Hidden Vector - Belt',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_belt',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{18366, "#ae1536"}, {27128, "#e4c17f"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_immortal_2021_ambient_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_belt_fx"
                    },
                }
            },
        },
    },
    [24612] = 
    {
        ['item_id'] =24612,
        ['name'] ='Hidden Vector - Hat',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_head1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "10_years",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{18364, "#ae1536"}, {24612, "#e4c17f"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet_gem"
                    },
                }
            },
        },
    },
    [27127] = 
    {
        ['item_id'] =27127,
        ['name'] ='Hidden Vector - Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_armor1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "10th_anniversary",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{18365, "#ae1536"}, {27127, "#e4c17f"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_ambient_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                }
            },
        },
    },
    [27128] = 
    {
        ['item_id'] =27128,
        ['name'] ='Hidden Vector - Belt',
        ['icon'] ='econ/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_belt1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "10th_anniversary",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_fall20_immortal/void_spirit_fall20_immortal_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{18366, "#ae1536"}, {27128, "#e4c17f"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_hidden_vector',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_immortal_2021/void_spirit_10th_anniversary_ambient_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_belt_fx"
                    },
                }
            },
        },
    },
    [26577] = 
    {
        ['item_id'] =26577,
        ['name'] ='Fascinations of Flight - Weapon',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{26577, "#cfb3c7"}, {29688, "#ca4e77"}, {296881, "#9349d8"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_alt2_weapon_ascetic_guardian_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attachment_normal_align"
                    },
                }
            },
        },
    },
    [29688] = 
    {
        ['item_id'] =29688,
        ['name'] ='Fascinations of Flight - Vector Variant Weapon',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon_alt1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26577, "#cfb3c7"}, {29688, "#ca4e77"}, {296881, "#9349d8"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_alt2_weapon_ascetic_guardian_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attachment_normal_align"
                    },
                }
            },
        },
    },
    [296881] = 
    {
        ["dota_id"] = 29688,
        ["ItemStyle"] = "1",
        ['item_id'] =296881,
        ['name'] ='Fascinations of Flight - Vector Variant Weapon',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon_salt2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_weapon/void_spirit_ascetic_guardian_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26577, "#cfb3c7"}, {29688, "#ca4e77"}, {296881, "#9349d8"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_alt1_weapon_ascetic_guardian_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attachment_normal_align"
                    },
                }
            },
        },
    },
    [26666] = 
    {
        ['item_id'] =26666,
        ['name'] ='Fascinations of Flight - Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{26666, "#cfb3c7"}, {29799, "#ca4e77"}, {297991, "#9349d8"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
    },
    [29799] = 
    {
        ['item_id'] =29799,
        ['name'] ='Fascinations of Flight - Vector Variant Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor_alt1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26666, "#cfb3c7"}, {29799, "#ca4e77"}, {297991, "#9349d8"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_ascetic_guardian_wings_alt1.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx1"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx2"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx3"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx4"
                    },
                }
            },
        },
    },
    [297991] = 
    {
        ["dota_id"] = 29799,
        ["ItemStyle"] = "1",
        ['item_id'] =297991,
        ['name'] ='Fascinations of Flight - Vector Variant Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor_alt2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_armor/void_spirit_ascetic_guardian_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26666, "#cfb3c7"}, {29799, "#ca4e77"}, {297991, "#9349d8"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_ascetic_guardian_wings_alt2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx1"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx2"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx3"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx4"
                    },
                }
            },
        },
    },
    [26665] = 
    {
        ['item_id'] =26665,
        ['name'] ='Fascinations of Flight - Head',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "default",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{26665, "#cfb3c7"}, {29689, "#ca4e77"}, {296891, "#9349d8"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
    },
    [29689] = 
    {
        ['item_id'] =29689,
        ['name'] ='Fascinations of Flight - Vector Variant Head',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head_alt1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26665, "#cfb3c7"}, {29689, "#ca4e77"}, {296891, "#9349d8"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_ascetic_guardian_ambient_head_alt1.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet_gem"
                    },
                }
            },
        },
    },
    [296891] = 
    {
        ["dota_id"] = 29689,
        ["ItemStyle"] = "1",
        ['item_id'] =296891,
        ['name'] ='Fascinations of Flight - Vector Variant Head',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head_alt2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_head/void_spirit_ascetic_guardian_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{26665, "#cfb3c7"}, {29689, "#ca4e77"}, {296891, "#9349d8"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_ascetic_guardian/void_spirit_ascetic_guardian_ambient_head_alt2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet_gem"
                    },
                }
            },
        },
    },
    [26668] = 
    {
        ['item_id'] =26668,
        ['name'] ='Fascinations of Flight - Belt',
        ['icon'] ='econ/items/void_spirit/void_spirit_ascetic_guardian_belt/void_spirit_ascetic_guardian_belt',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/void_spirit_ascetic_guardian_belt/void_spirit_ascetic_guardian_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fascinations_of_flight',
    },
    [26597] = 
    {
        ['item_id'] =26597,
        ['name'] ='Sublime Equilibrium - Weapon',
        ['icon'] ='econ/items/void_spirit/void_spirit_taiji_koi_weapon/void_spirit_taiji_koi_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/void_spirit_taiji_koi_weapon/void_spirit_taiji_koi_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sublime_equilibrium',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_cache_2022/void_spirit_cache_2022_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "top_gem"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bot_gem"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "separation_bot"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "separation_top"
                    },
                }
            },
        },
    },
    [26595] = 
    {
        ['item_id'] =26595,
        ['name'] ='Sublime Equilibrium - Head',
        ['icon'] ='econ/items/void_spirit/void_spirit_taiji_koi_head/void_spirit_taiji_koi_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/void_spirit_taiji_koi_head/void_spirit_taiji_koi_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sublime_equilibrium',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_cache_2022/void_spirit_cache_2022_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [26659] = 
    {
        ['item_id'] =26659,
        ['name'] ='Sublime Equilibrium - Belt',
        ['icon'] ='econ/items/void_spirit/void_spirit_taiji_koi_belt/void_spirit_taiji_koi_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/void_spirit_taiji_koi_belt/void_spirit_taiji_koi_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sublime_equilibrium',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_cache_2022/void_spirit_cache_2022_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "gem_front"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "gem_a"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "gem_b"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "gem_c"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "bottle"
                    },
                }
            },
        },
    },
    [26661] = 
    {
        ['item_id'] =26661,
        ['name'] ='Sublime Equilibrium - Armor',
        ['icon'] ='econ/items/void_spirit/void_spirit_taiji_koi_armor/void_spirit_taiji_koi_armor',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/void_spirit_taiji_koi_armor/void_spirit_taiji_koi_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sublime_equilibrium',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/void_spirit_cache_2022/void_spirit_cache_2022_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "spine1"
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_arm"
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_arm"
                    },
                }
            },
        },
    },
    [686] = 
    {
        ['item_id'] =686,
        ['name'] ='Default weapon',
        ['icon'] ='',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/void_spirit/void_spirit_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_void_spirit/void_spirit_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon", "hero"
                    },
                }
            },
        },
    },
    [34321] = 
    {
        ['item_id'] =34321,
        ['name'] ='Umbral Expanse - Armor',
        ['icon'] ='econ/items/void_spirit/vs_cosmic/vs_cosmic_armor',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/vs_cosmic/vs_cosmic_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_spirit_cosmic',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/vs_cosmic/vs_cosmic_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [34324] = 
    {
        ['item_id'] =34324,
        ['name'] ='Umbral Expanse - Weapon',
        ['icon'] ='econ/items/void_spirit/vs_cosmic/vs_cosmic_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/vs_cosmic/vs_cosmic_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_spirit_cosmic',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/vs_cosmic/vs_cosmic_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [34322] = 
    {
        ['item_id'] =34322,
        ['name'] ='Umbral Expanse - Belt',
        ['icon'] ='econ/items/void_spirit/vs_cosmic/vs_cosmic_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/vs_cosmic/vs_cosmic_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'void_spirit_cosmic',
    },
    [34323] = 
    {
        ['item_id'] =34323,
        ['name'] ='Umbral Expanse - Head',
        ['icon'] ='econ/items/void_spirit/vs_cosmic/vs_cosmic_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/void_spirit/vs_cosmic/vs_cosmic_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ['is_exclusive'] = 1,
        --['Modifier'] = "modifier_void_spirit_cosmic_body_group",
        ['sets'] = 'void_spirit_cosmic',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/void_spirit/vs_cosmic/vs_cosmic_head_ambient.vpcf",
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
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                }
            },
        },
    },
}