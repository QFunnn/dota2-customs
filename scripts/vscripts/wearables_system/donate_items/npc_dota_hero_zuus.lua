--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [9052] = 
    {
        ['item_id'] =9052,
        ['name'] ='Symbol of the King Restored',
        ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_head/the_return_of_the_king_of_gods_head',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_head/the_return_of_the_king_of_gods_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9052, "#b27ae3"}, {90521, "#86b3f6"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'return_of_the_king',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_zeus/zeus_return_king_of_gods_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet"
                    },
                }
            },
        },
    },
    [90521] = 
    {
        ["dota_id"] = 9052,
        ["ItemStyle"] = "1",
        ['item_id'] =90521,
        ['name'] ='Symbol of the King Restored',
        ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_head/the_return_of_the_king_of_gods_head_style1',
        ['price'] = 700,
        ['HeroModel'] = "models/heroes/zeus/zeus.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_head/the_return_of_the_king_of_gods_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9052, "#b27ae3"}, {90521, "#86b3f6"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'return_of_the_king',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_zeus/zeus_return_king_of_gods_head_style1_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_helmet"
                    },
                }
            },
        },
    },
    [9037] = 
    {
            ['item_id'] =9037,
            ['name'] ='Markings of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_back/the_return_of_the_king_of_gods_back',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_back/the_return_of_the_king_of_gods_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9037, "#b27ae3"}, {90371, "#86b3f6"}},
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [90371] = 
    {
        ["dota_id"] = 9037,
        ["ItemStyle"] = "1",
            ['item_id'] =90371,
            ['name'] ='Markings of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_back/the_return_of_the_king_of_gods_back_style1',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['MaterialGroupItem'] = "1",
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_back/the_return_of_the_king_of_gods_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9037, "#b27ae3"}, {90371, "#86b3f6"}},
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [9038] = 
            {
            ['item_id'] =9038,
            ['name'] ='Armlets of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_arms/the_return_of_the_king_of_gods_arms',
            ['price'] = 500,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_arms/the_return_of_the_king_of_gods_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9038, "#b27ae3"}, {90381, "#86b3f6"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [90381] = 
            {
                 ["dota_id"] = 9038,
        ["ItemStyle"] = "1",
            ['item_id'] =90381,
            ['name'] ='Armlets of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_arms/the_return_of_the_king_of_gods_arms_style1',
            ['price'] = 700,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['MaterialGroupItem'] = "1",
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_arms/the_return_of_the_king_of_gods_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9038, "#b27ae3"}, {90381, "#86b3f6"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [9039] = 
    {
            ['item_id'] =9039,
            ['name'] ='Belt of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_belt/the_return_of_the_king_of_gods_belt',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_belt/the_return_of_the_king_of_gods_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9039, "#b27ae3"}, {90391, "#86b3f6"}},
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [90391] = 
    {
        ["dota_id"] = 9039,
        ["ItemStyle"] = "1",
            ['item_id'] =90391,
            ['name'] ='Belt of the King Restored',
            ['icon'] ='econ/items/zuus/the_return_of_the_king_of_gods_belt/the_return_of_the_king_of_gods_belt_style1',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['MaterialGroupItem'] = "1",
            ['ItemModel'] ='models/items/zuus/the_return_of_the_king_of_gods_belt/the_return_of_the_king_of_gods_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9039, "#b27ae3"}, {90391, "#86b3f6"}},
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'return_of_the_king',
    },
    [7954] = 
    {
            ['item_id'] =7954,
            ['name'] ='Helm of the Wartorn Heavens',
            ['icon'] ='econ/items/zuus/lord_of_heaven_head/lord_of_heaven_head',
            ['price'] = 250,
            ['HeroModel'] = "models/heroes/zeus/zeus.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/lord_of_heaven_head/lord_of_heaven_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'wastorn_heavens',
    },
    [7953] = 
    {
            ['item_id'] =7953,
            ['name'] ='Belt of the Wartorn Heavens',
            ['icon'] ='econ/items/zuus/lord_of_heaven_belt/lord_of_heaven_belt',
            ['price'] = 250,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/lord_of_heaven_belt/lord_of_heaven_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'wastorn_heavens',
    },
    [7952] = 
    {
            ['item_id'] =7952,
            ['name'] ='Pauldrons of the Wartorn Heavens',
            ['icon'] ='econ/items/zuus/lord_of_heaven_back/lord_of_heaven_back',
            ['price'] = 250,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/lord_of_heaven_back/lord_of_heaven_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'wastorn_heavens',
    },
    [7951] = 
    {
            ['item_id'] =7951,
            ['name'] ='Bracers of the Wartorn Heavens',
            ['icon'] ='econ/items/zuus/lord_of_heaven_arms/lord_of_heaven_arms',
            ['price'] = 250,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/zuus/lord_of_heaven_arms/lord_of_heaven_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'wastorn_heavens',
    },
    [5412] = 
    {
        ['item_id'] =5412,
        ['name'] ='Righteous Thunderbolt',
        ['icon'] = 'zeus/zeus_weapon',
        ['local_icon'] = 1,
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/lightning_weapon/mesh/zeus_lightning_weapon_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_lightning_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/lightning_weapon_fx/zues_immortal_lightning_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {   
            "particles/econ/items/zeus/lightning_weapon_fx/zuus_lightning_bolt_immortal_lightning.vpcf",
            "particles/econ/items/zeus/lightning_weapon_fx/zuus_lb_cfx_il.vpcf",
        }
    },
    [12323] = 
    {
        ['item_id'] =12323,
        ['name'] ='Tempest Revelation',
        ['icon'] = 'zeus/zeus_shield',
        ['local_icon'] = 1,
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_ti8_arms_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shield"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arc_head.vpcf",
            "particles/econ/items/zeus/zeus_ti8_immortal_arms/zeus_ti8_immortal_arc.vpcf",
        }
    },
    [24680] = 
    {
        ['item_id'] =24680,
        ['name'] ='Immortal Pantheon of the Crimson Witness',
        ['icon'] = 'zeus/zeus_shoulders_red',
        ['local_icon'] = 1,
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/zeus/zeus_2021_immortal/zeus_2021_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_2021_immortal_custom_witness",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_ambient_crimson.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_02"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_02"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_03"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_03"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_04"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_04"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_05"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_05"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_crimson_shard_static_field.vpcf",
            "particles/units/heroes/hero_zuus/zuus_shard_crimson_slow.vpcf",
        }
    },
    [19112] = 
    {
        ['item_id'] =19112,
        ['name'] ='Immortal Pantheon',
        ['icon'] = 'zeus/zeus_shoulders',
        ['local_icon'] = 1,
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/zeus/zeus_2021_immortal/zeus_2021_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_2021_immortal_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_02"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_02"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_03"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_03"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_04"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_04"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_05"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_05"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_shard_static_field.vpcf",
            "particles/units/heroes/hero_zuus/zuus_shard_slow.vpcf",
        }
    },
    [18563] = 
    {
        ['item_id'] =18563,
        ['name'] ='Golden Immortal Pantheon',
        ['icon'] = 'zeus/zeus_shoulders_gold',
        ['local_icon'] = 1,
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/zeus/zeus_2021_immortal/zeus_2021_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_2021_immortal_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_conduit_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_02"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_02"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_03"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_03"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_04"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_04"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_r_fx_05"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cape_l_fx_05"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_gold_shard_static_field.vpcf",
            "particles/econ/items/zeus/zeus_immortal_2021/zeus_immortal_2021_shard_gold_slow.vpcf",
        }
    },

    [6914] = 
    {
        ['item_id'] = 6914,
        ['name'] = 'Tempest Helm of the Thundergod',
        ['icon'] = 'zeus/zeus_arcana',
        ['local_icon'] = 1,
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/zeus/zeus_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/zeus/zeus_hair_arcana.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_zuus_arcana_custom",
        ['sets'] = 'rare',
        ['ParticlesHero'] = 
        {
            {
                ['ParticleName'] = 'particles/econ/items/zeus/arcana_chariot/zeus_arcana_chariot.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = 
                {

                }
            },
            {
                ['ParticleName'] = 'particles/econ/items/zeus/arcana_chariot/zeus_ambient_arcana_eyes.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath.vpcf",
            "particles/zeus/arcana_ulti.vpcf",
            "particles/econ/items/zeus/arcana_chariot/zeus_arcana_thundergods_wrath_start.vpcf",
        }
    },
    [34325] = 
    {
        ['item_id'] =34325,
        ['name'] ='Photonic Father - Arms',
        ['icon'] ='econ/items/zeus/zeus_cosmic/zeus_cosmic_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/zeus_cosmic/zeus_cosmic_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'zuus_photonic_father',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_cosmic/zeus_cosmic_arms_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_l"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_r"
                    },
                }
            },
        },
    },
    [34328] = 
    {
        ['item_id'] =34328,
        ['name'] ='Photonic Father - Back',
        ['icon'] ='econ/items/zeus/zeus_cosmic/zeus_cosmic_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/zeus_cosmic/zeus_cosmic_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'zuus_photonic_father',
    },
    [34327] = 
    {
        ['item_id'] =34327,
        ['name'] ='Photonic Father - Belt',
        ['icon'] ='econ/items/zeus/zeus_cosmic/zeus_cosmic_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/zeus_cosmic/zeus_cosmic_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'zuus_photonic_father',
    },
    [34326] = 
    {
        ['item_id'] =34326,
        ['name'] ='Photonic Father - Head',
        ['icon'] ='econ/items/zeus/zeus_cosmic/zeus_cosmic_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/zeus/zeus_cosmic/zeus_cosmic_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'zuus_photonic_father',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/zeus/zeus_cosmic/zeus_cosmic_head_ambient.vpcf",
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
}