--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [35553] = 
    {
        ['item_id'] =35553,
        ['name'] ='Flockhearts Gamble',
        ['icon'] ='econ/items/ogre_magi/ogre_arcana/ogre_magi_arcana_head',
        ['price'] = 0,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['ArcanaAnim'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_arcana/ogre_magi_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = 
        --{
        --    {35553, "#f0ac0e"}, {355531, "#4298cf"}
        --},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ['sets'] = 'arcana_ogre_magi',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_counter.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast_cast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff_explosion.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite.vpcf",
        }
    },
    [355531] = 
    {
        ["dota_id"] = 35553,
        ["ItemStyle"] = "1",
        ['item_id'] =355531,
        ['name'] ='Flockhearts Gamble',
        ['icon'] ='econ/items/ogre_magi/ogre_arcana/ogre_magi_arcana_head',
        ['price'] = 0,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['ArcanaAnim'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_arcana/ogre_magi_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        --['OtherItemsBundle'] = 
        --{
        --    {35553, "#f0ac0e"}, {355531, "#4298cf"}
        --},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ['sets'] = 'arcana_ogre_magi',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_counter.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast_cast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff_explosion.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite.vpcf",
        }
    },
    [13670] = 
    {
        ['item_id'] =13670,
        ['name'] ='Flockhearts Gamble',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_head',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/development/invisiblebox.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {
            {13670, "#f0ac0e"}, {136701, "#4298cf"}
        },
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_arcana_custom",
        ['sets'] = 'arcana_ogre_magi',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
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
                        "attach_horn_left_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_root_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_r_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_r_fx"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_l_fx"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_fx"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frill_l_fx"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frill_r_fx"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_counter.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast_cast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff_explosion.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite.vpcf",
        }
    },
    [136701] = 
    {
        ["dota_id"] = 13670,
        ["ItemStyle"] = "1",
        ['item_id'] =136701,
        ['name'] ='Flockhearts Gamble',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_head_style1',
        ['price'] = 1,
        ['HeroModel'] = "models/items/ogre_magi/ogre_arcana/ogre_magi_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['MaterialGroup'] = "1",
        ['ItemModel'] ='models/development/invisiblebox.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {
            {13670, "#f0ac0e"}, {136701, "#4298cf"}
        },
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_arcana_custom_2",
        ['sets'] = 'arcana_ogre_magi',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_secondstyle_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
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
                        "attach_horn_left_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_root_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_r_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head_r_fx"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_l_fx"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_fx"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frill_l_fx"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_frill_r_fx"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_counter.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_fireblast_cast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_unrefined_fireblast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff_explosion.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite_debuff.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_ignite.vpcf",
        }
    },
    [12318] = 
    {
        ['item_id'] =12318,
        ['name'] ='Gimlek Decanter',
        ['icon'] ='econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_weapon',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_immortal_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bottle"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_ti8_immortal_weapon/ogre_ti8_immortal_bloodlust_buff.vpcf"
        }
    },
    [7910] = 
    {
        ['item_id'] =7910,
        ['name'] ='Auspice of the Whyrlegyge',
        ['icon'] ='econ/items/ogre_magi/auspice_of_the_whyrlegyge/mesh/auspice_of_the_whyrlegyge_model',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/auspice_of_the_whyrlegyge/mesh/auspice_of_the_whyrlegyge_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {
            {7910, "#f0c70e"}, {79101, "#f03f0e"}
        },
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_immortal_back_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wheel"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_multicast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_style.vpcf"
        }
    },
    [79101] = 
    {
        ["dota_id"] = 7910,
        ["ItemStyle"] = "1",
        ['item_id'] =79101,
        ['name'] ='Auspice of the Whyrlegyge',
        ['icon'] ='econ/items/ogre_magi/auspice_of_the_whyrlegyge/mesh/auspice_of_the_whyrlegyge_model_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/auspice_of_the_whyrlegyge/ogre_arcana_immortal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {
            {7910, "#f0c70e"}, {79101, "#f03f0e"}
        },
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_immortal_back_custom_arcana",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wheel"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_multicast.vpcf",
            "particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_multicast_style.vpcf"
        }
    },


    [9226] = 
    {
        ['item_id'] =9226,
        ['name'] ='Back Buoy of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_back/ogre_magi_set_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_back/ogre_magi_set_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9226, "#f0c70e"}, {92261, "#4298cf"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_ti7_set/ogre_ti7_set_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_r"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_l"
                    },
                }
            },
        },
    },
    [92261] = 
    {
        ["dota_id"] = 9226,
        ["ItemStyle"] = "1",
        ['item_id'] =92261,
        ['name'] ='Back Buoy of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_back/ogre_magi_set_back_style1',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_back/ogre_magi_set_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9226, "#f0c70e"}, {92261, "#4298cf"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_ti7_set/ogre_ti7_set_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_r"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_flower_l"
                    },
                }
            },
        },
    },
    [9229] = 
    {
        ['item_id'] =9229,
        ['name'] ='Headgear of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_head/ogre_magi_set_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_head/ogre_magi_set_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9229, "#f0c70e"}, {92291, "#4298cf"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_ti7_set/ogre_ti7_set_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_snorkel"
                    },
                }
            },
        },
    },
    [92291] = 
    {
        ["dota_id"] = 9229,
        ["ItemStyle"] = "1",
        ['item_id'] =92291,
        ['name'] ='Headgear of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_head/ogre_magi_set_head_style1',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_head/ogre_magi_set_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['MaterialGroup'] = "0",
        ['OtherItemsBundle'] = {{9229, "#f0c70e"}, {92291, "#4298cf"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_ti7_set/ogre_ti7_set_style_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_snorkel"
                    },
                }
            },
        },
    },
    [9227] = 
    {
        ['item_id'] =9227,
        ['name'] ='Floathide Belt of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_belt/ogre_magi_set_belt',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_belt/ogre_magi_set_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9227, "#f0c70e"}, {92271, "#4298cf"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [92271] = 
    {
        ["dota_id"] = 9227,
        ["ItemStyle"] = "1",
        ['item_id'] =92271,
        ['name'] ='Floathide Belt of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_belt/ogre_magi_set_belt_style1',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_belt/ogre_magi_set_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9227, "#f0c70e"}, {92271, "#4298cf"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [9224] = 
    {
        ['item_id'] =9224,
        ['name'] ='Shovel of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_weapon/ogre_magi_set_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_weapon/ogre_magi_set_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9224, "#f0c70e"}, {92241, "#4298cf"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [92241] = 
    {
        ["dota_id"] = 9224,
        ["ItemStyle"] = "1",
        ['item_id'] =92241,
        ['name'] ='Shovel of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_weapon/ogre_magi_set_weapon_style1',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_weapon/ogre_magi_set_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9224, "#f0c70e"}, {92241, "#4298cf"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [9225] = 
    {
        ['item_id'] =9225,
        ['name'] ='Floathide Bands of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_arms/ogre_magi_set_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_arms/ogre_magi_set_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9225, "#f0c70e"}, {92251, "#4298cf"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [92251] = 
    {
        ["dota_id"] = 9225,
        ["ItemStyle"] = "1",
        ['item_id'] =92251,
        ['name'] ='Floathide Bands of the Shoreline Sapper',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_set_arms/ogre_magi_set_arms_style1',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_set_arms/ogre_magi_set_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9225, "#f0c70e"}, {92251, "#4298cf"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_shoreline',
    },
    [18098] = 
    {
        ['item_id'] =18098,
        ['name'] ='Pyrexae Polymorph Perfected - Head',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_enter_the_dragon_head/ogre_magi_enter_the_dragon_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_enter_the_dragon_head/ogre_magi_enter_the_dragon_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_pyrexae',
    },
    [18099] = 
    {
        ['item_id'] =18099,
        ['name'] ='Pyrexae Polymorph Perfected - Belt',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_enter_the_dragon_belt/ogre_magi_enter_the_dragon_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_enter_the_dragon_belt/ogre_magi_enter_the_dragon_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_pyrexae',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc/ogre_2022_cc_belt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_fx_left"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_fx_right"
                    },
                }
            },
        },
    },
    [18100] = 
    {
        ['item_id'] =18100,
        ['name'] ='Pyrexae Polymorph Perfected - Back',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_enter_the_dragon_back/ogre_magi_enter_the_dragon_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_enter_the_dragon_back/ogre_magi_enter_the_dragon_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_pyrexae',
    },
    [18101] = 
    {
        ['item_id'] =18101,
        ['name'] ='Pyrexae Polymorph Perfected - Arms',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_enter_the_dragon_arms/ogre_magi_enter_the_dragon_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_enter_the_dragon_arms/ogre_magi_enter_the_dragon_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_pyrexae',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc/ogre_2022_cc_arm_stuffing.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [18097] = 
    {
        ['item_id'] =18097,
        ['name'] ='Pyrexae Polymorph Perfected - Weapon',
        ['icon'] ='econ/items/ogre_magi/ogre_magi_enter_the_dragon_weapon/ogre_magi_enter_the_dragon_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_magi_enter_the_dragon_weapon/ogre_magi_enter_the_dragon_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_pyrexae',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc/ogre_2022_cc_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_fx"
                    },
                }
            },
        },
    },
    [19370] = 
    {
        ['item_id'] =19370,
        ['name'] ='Freeboot Fortunes - Arms',
        ['icon'] ='econ/items/ogre_magi/adventurers_of_fortune_arms/adventurers_of_fortune_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/adventurers_of_fortune_arms/adventurers_of_fortune_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_freebot',
    },
    [19372] = 
    {
        ['item_id'] =19372,
        ['name'] ='Freeboot Fortunes - Belt',
        ['icon'] ='econ/items/ogre_magi/adventurers_of_fortune_belt/adventurers_of_fortune_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/adventurers_of_fortune_belt/adventurers_of_fortune_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_freebot',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc_fortune/ogre_2022_cc_fortune_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19373] = 
    {
        ['item_id'] =19373,
        ['name'] ='Freeboot Fortunes - Head',
        ['icon'] ='econ/items/ogre_magi/adventurers_of_fortune_head/adventurers_of_fortune_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/adventurers_of_fortune_head/adventurers_of_fortune_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_freebot',
    },
    [19374] = 
    {
        ['item_id'] =19374,
        ['name'] ='Freeboot Fortunes - Weapon',
        ['icon'] ='econ/items/ogre_magi/adventurers_of_fortune_weapon/adventurers_of_fortune_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/ogre_magi/adventurers_of_fortune_weapon/adventurers_of_fortune_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_freebot',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc_fortune/ogre_2022_cc_fortune_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19371] = 
    {
        ['item_id'] =19371,
        ['name'] ='Freeboot Fortunes - Back',
        ['icon'] ='econ/items/ogre_magi/adventurers_of_fortune_back/adventurers_of_fortune_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/adventurers_of_fortune_back/adventurers_of_fortune_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_freebot',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_2022_cc_fortune/ogre_2022_cc_fortune_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_loot_fx"
                    },
                }
            },
        },
    },
    [35997] = 
    {
        ['item_id'] =35997,
        ['name'] ='Pisces Gemini - Arms',
        ['icon'] ='econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_cosmic/ogre_cosmic_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_magi_pisces_gemini',
    },
    [35999] = 
    {
        ['item_id'] =35999,
        ['name'] ='Pisces Gemini - Back',
        ['icon'] ='econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_cosmic/ogre_cosmic_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_magi_pisces_gemini',
    },
    [35998] = 
    {
        ['item_id'] =35998,
        ['name'] ='Pisces Gemini - Belt',
        ['icon'] ='econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_cosmic/ogre_cosmic_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_magi_pisces_gemini',
    },
    [31207] = 
    {
        ['item_id'] =31207,
        ['name'] ='Pisces Gemini - Head',
        ['icon'] ='econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_cosmic/ogre_cosmic_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ogre_magi_cosmic_head",
        ['sets'] = 'ogre_magi_pisces_gemini',
        ["OtherModelsPrecache"] =
        {
            "models/items/ogre_magi/ogre_cosmic/ogre_cosmic_head_arcana_refit.vmdl",
        }
    },
    [36000] = 
    {
        ['item_id'] = 36000,
        ['name'] ='Pisces Gemini - Weapon',
        ['icon'] ='econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/ogre_magi/ogre_cosmic/ogre_cosmic_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'ogre_magi_pisces_gemini',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/ogre_magi/ogre_cosmic/ogre_cosmic_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_mouth"
                    },
                }
            },
        },
    },
}