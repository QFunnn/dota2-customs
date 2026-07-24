--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [14964] = 
    {
        ['item_id'] =14964,
        ['name'] ='Origin of the Unmaking',
        ['icon'] ='econ/items/bane/bane_fall20_immortal_head/bane_fall20_immortal_head',
        ['price'] = 2500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/bane_fall20_immortal_head/bane_fall20_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bane_immortal_head",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/bane_fall20_immortal/bane_fall20_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/bane/bane_fall20_immortal/bane_fall20_immortal_grip.vpcf"
        }
    },
    [7692] = 
    {
        ['item_id'] =7692,
        ['name'] ='Slumbering Terror',
        ['icon'] ='econ/items/bane/slumbering_terror/slumbering_terror',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/slumbering_terror/slumbering_terror.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bane_immortal_shoulder",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/slumbering_terror/bane_slumbering_terror_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_r"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_l"
                    },
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/bane/slumbering_terror/bane_slumber_nightmare.vpcf"
        }
    },

    [12712] = 
    {
        ['item_id'] =12712,
        ['name'] ='Cover of the Sleepless Sect',
        ['icon'] ='econ/items/bane/frostivus_2018_bane_beast_nightmare_shoulder/frostivus_2018_bane_beast_nightmare_shoulder',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/frostivus_2018_bane_beast_nightmare_shoulder/frostivus_2018_bane_beast_nightmare_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sleepless_sect',
    },
    [12713] = 
    {
        ['item_id'] =12713,
        ['name'] ='Garb of the Sleepless Sect',
        ['icon'] ='econ/items/bane/frostivus_2018_bane_beast_of_the_nightmare_back/frostivus_2018_bane_beast_of_the_nightmare_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/frostivus_2018_bane_beast_of_the_nightmare_back/frostivus_2018_bane_beast_of_the_nightmare_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sleepless_sect',
    },
    [12714] = 
    {
        ['item_id'] =12714,
        ['name'] ='Arms of the Sleepless Sect',
        ['icon'] ='econ/items/bane/frostivus_2018_bane_beast_of_the_nightmare_arms/frostivus_2018_bane_beast_of_the_nightmare_arms',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/frostivus_2018_bane_beast_of_the_nightmare_arms/frostivus_2018_bane_beast_of_the_nightmare_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sleepless_sect',
    },
    [12715] = 
    {
        ['item_id'] =12715,
        ['name'] ='Visage of the Sleepless Sect',
        ['icon'] ='econ/items/bane/frostivus_2018_bane_beast_of_the_nightmare_head/frostivus_2018_bane_beast_of_the_nightmare_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/frostivus_2018_bane_beast_of_the_nightmare_head/frostivus_2018_bane_beast_of_the_nightmare_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'sleepless_sect',
    },
    [28436] = 
    {
        ['item_id'] =28436,
        ['name'] ='Tome of Infinite Terror - Head',
        ['icon'] ='econ/items/bane/bane_nightmare_demon_mage_head/bane_nightmare_demon_mage_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/bane_nightmare_demon_mage_head/bane_nightmare_demon_mage_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'infinite_terror',
    },
    [28435] = 
    {
        ['item_id'] =28435,
        ['name'] ='Tome of Infinite Terror - Back',
        ['icon'] ='econ/items/bane/bane_nightmare_demon_mage_back/bane_nightmare_demon_mage_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/bane_nightmare_demon_mage_back/bane_nightmare_demon_mage_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'infinite_terror',
    },
    [28434] = 
    {
        ['item_id'] =28434,
        ['name'] ='Tome of Infinite Terror - Arms',
        ['icon'] ='econ/items/bane/bane_nightmare_demon_mage_arms/bane_nightmare_demon_mage_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/bane_nightmare_demon_mage_arms/bane_nightmare_demon_mage_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'infinite_terror',
    },
    [28387] = 
    {
        ['item_id'] =28387,
        ['name'] ='Tome of Infinite Terror - Shoulder',
        ['icon'] ='econ/items/bane/bane_nightmare_demon_mage_shoulder/bane_nightmare_demon_mage_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/bane/bane_nightmare_demon_mage_shoulder/bane_nightmare_demon_mage_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'infinite_terror',
    },
    [8547] = 
    {
        ['item_id'] =8547,
        ['name'] ='Hood of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_head/bane_gear_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/bane/bane_gear_head/bane_gear_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8547, "#bb8436"}, {85471, "#9b37b5"}, {23217, "#93152d"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [8548] = 
    {
        ['item_id'] =8548,
        ['name'] ='Cloth of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_back/bane_gear_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/bane/bane_gear_back/bane_gear_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8548, "#bb8436"}, {85481, "#9b37b5"}, {23216, "#93152d"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_back_infused.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_01"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_02"
                    },
                }
            },
        },
    },
    [8549] = 
    {
        ['item_id'] =8549,
        ['name'] ='Sleeves of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_arms/bane_gear_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/bane/bane_gear_arms/bane_gear_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8549, "#bb8436"}, {85491, "#9b37b5"}, {23215, "#93152d"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [8550] = 
    {
        ['item_id'] =8550,
        ['name'] ='Eyes of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_shoulder/bane_gear_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/bane/bane_gear_shoulder/bane_gear_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8550, "#bb8436"}, {85501, "#9b37b5"}, {23214, "#93152d"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [85471] = 
    {
        ["dota_id"] = 8547,
        ["ItemStyle"] = "1",
        ['item_id'] =85471,
        ['name'] ='Hood of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_head/bane_gear_head_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/bane/bane_gear_head/bane_gear_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8547, "#bb8436"}, {85471, "#9b37b5"}, {23217, "#93152d"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [85481] = 
    {
        ["dota_id"] = 8548,
        ["ItemStyle"] = "1",
        ['item_id'] =85481,
        ['name'] ='Cloth of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_back/bane_gear_back_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/bane/bane_gear_back/bane_gear_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8548, "#bb8436"}, {85481, "#9b37b5"}, {23216, "#93152d"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_01"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_02"
                    },
                }
            },
        },
    },
    [85491] = 
    {
        ["dota_id"] = 8549,
        ["ItemStyle"] = "1",
        ['item_id'] =85491,
        ['name'] ='Sleeves of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_arms/bane_gear_arms_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/bane/bane_gear_arms/bane_gear_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8549, "#bb8436"}, {85491, "#9b37b5"}, {23215, "#93152d"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [85501] = 
    {
        ["dota_id"] = 8550,
        ["ItemStyle"] = "1",
        ['item_id'] =85501,
        ['name'] ='Eyes of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_shoulder/bane_gear_shoulder_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/bane/bane_gear_shoulder/bane_gear_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8550, "#bb8436"}, {85501, "#9b37b5"}, {23214, "#93152d"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_l_orb"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_r_orb"
                    },
                }
            },
        },
    },
    [23217] = 
    {
        ['item_id'] =23217,
        ['name'] ='Summer Lineage Hood of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_head/bane_gear_head_dpc',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/bane/bane_gear_head/bane_gear_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8547, "#bb8436"}, {85471, "#9b37b5"}, {23217, "#93152d"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [23216] = 
    {
        ['item_id'] =23216,
        ['name'] ='Summer Lineage Cloth of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_back/bane_gear_back2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/bane/bane_gear_back/bane_gear_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8548, "#bb8436"}, {85481, "#9b37b5"}, {23216, "#93152d"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bane/unhallowed_nightmares/bane_unhallowed_nightmares_back_infused_dpc.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_01"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spine_02"
                    },
                }
            },
        },
    },
    [23215] = 
    {
        ['item_id'] =23215,
        ['name'] ='Summer Lineage Sleeves of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_arms/bane_gear_arms2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/bane/bane_gear_arms/bane_gear_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8549, "#bb8436"}, {85491, "#9b37b5"}, {23215, "#93152d"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
    [23214] = 
    {
        ['item_id'] =23214,
        ['name'] ='Summer Lineage Eyes of Lucid Torment',
        ['icon'] ='econ/items/bane/bane_gear_shoulder/bane_gear_shoulder2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/bane/bane_gear_shoulder/bane_gear_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8550, "#bb8436"}, {85501, "#9b37b5"}, {23214, "#93152d"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lucid_torment',
    },
}