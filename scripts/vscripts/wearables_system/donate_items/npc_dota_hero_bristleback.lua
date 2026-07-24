--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [9150] = 
    {
        ['item_id'] = 9150,
        ['name'] = "Blastforge Exhaler",
        ['icon'] = "econ/items/bristleback/bristleback_immortal_helmet/bristleback_immortal_helmet",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_immortal_helmet/bristleback_immortal_helmet.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bristleback_immortal_custom_1",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle_r"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle_l"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_head"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_proj.vpcf",
            "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_debuff.vpcf",
        },
    },
    [7994] = 
    {
        ['item_id'] = 7994,
        ['name'] = "Blastforge Exhaler of the Crimson Witness",
        ['icon'] = "econ/items/bristleback/bristleback_immortal_helmet/bristleback_immortal_helmet1",
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/bristleback_immortal_helmet/bristleback_immortal_helmet.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bristleback_immortal_custom_2",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle_r"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle_l"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_head"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_proj.vpcf",
            "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_crimson_nasal_goo_debuff.vpcf",
        },
    },
    [8391] = 
    {
        ['item_id'] = 8391,
        ['name'] = "Piston Impaler",
        ['icon'] = "econ/items/bristleback/spikey_spray/spikey_spray",
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spikey_spray/spikey_spray.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bristleback_immortal_custom_3",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_back"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_grill"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray.vpcf",
            "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_hit.vpcf",
            "particles/econ/items/bristleback/bristle_spikey_spray/bristle_spikey_quill_spray_hit_creep.vpcf",
        },
    },
    [23841] = 
    {
        ['item_id'] = 23841,
        ['name'] = "Blastmitt Boreblade",
        ['icon'] = "econ/items/bristleback/bb_2022_immortal_weapon/bb_2022_immortal_weapon",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bb_2022_immortal_weapon/bb_2022_immortal_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bristleback_immortal_custom_4",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_ambient_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon_spike_fx_left"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon_spike_fx_right"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon_blade_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_warpath.vpcf",
        },
    },
    [23839] = 
    {
        ['item_id'] = 23839,
        ['name'] = "Blastmitt Berserker",
        ['icon'] = "econ/items/bristleback/bb_2022_immortal_arms/bb_2022_immortal_arms",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bb_2022_immortal_arms/bb_2022_immortal_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_bristleback_immortal_custom_5",
        ['sets'] = "blastmitt_berserker",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_arms_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_01"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_02"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_01"},
                    [4] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_02"},
                    [5] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_elbow_l_fx_01"},
                    [6] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_elbow_l_fx_02"},
                    [7] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_spike_r_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_back_dmg.vpcf",
            "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_lrg_dmg.vpcf",
            "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_side_dmg.vpcf",
        },
    },
    [23840] = 
    {
        ['item_id'] = 23840,
        ['name'] = "Savager's Serum",
        ['icon'] = "econ/items/bristleback/bb_2022_immortal_neck/bb_2022_immortal_neck",
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bb_2022_immortal_neck/bb_2022_immortal_neck.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "neck",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "blastmitt_berserker",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_2022_immortal/bristleback_2022_immortal_ambient_neck.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_vial_fx_right"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_vial_fx_left"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_vial_fx_right"},
                    [4] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_vial_fx_left"},
                }
            },
        },
    },
    [18500] = 
    {
        ['item_id'] = 18500,
        ['name'] = "Barbarous Blades Mask",
        ['icon'] = "econ/items/bristleback/spring2021_barbarous_assault_bristleback_head/spring2021_barbarous_assault_bristleback_head",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spring2021_barbarous_assault_bristleback_head/spring2021_barbarous_assault_bristleback_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "barbarous_blades",
    },
    [18501] = 
    {
        ['item_id'] = 18501,
        ['name'] = "Barbarous Blades Neck",
        ['icon'] = "econ/items/bristleback/spring2021_barbarous_assault_bristleback_neck/spring2021_barbarous_assault_bristleback_neck",
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spring2021_barbarous_assault_bristleback_neck/spring2021_barbarous_assault_bristleback_neck.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "neck",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "barbarous_blades",
    },
    [18502] = 
    {
        ['item_id'] = 18502,
        ['name'] = "Barbarous Blades Arms",
        ['icon'] = "econ/items/bristleback/spring2021_barbarous_assault_bristleback_arms/spring2021_barbarous_assault_bristleback_arms",
        ['price'] = 150,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spring2021_barbarous_assault_bristleback_arms/spring2021_barbarous_assault_bristleback_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "barbarous_blades",
    },
    [18503] = 
    {
        ['item_id'] = 18503,
        ['name'] = "Barbarous Blades Back",
        ['icon'] = "econ/items/bristleback/spring2021_barbarous_assault_bristleback_back/spring2021_barbarous_assault_bristleback_back",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spring2021_barbarous_assault_bristleback_back/spring2021_barbarous_assault_bristleback_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "barbarous_blades",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/2021_spring_barbarous/2021_spring_barbarous_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [18504] = 
    {
        ['item_id'] = 18504,
        ['name'] = "Barbarous Blades Weapon",
        ['icon'] = "econ/items/bristleback/spring2021_barbarous_assault_bristleback_weapon/spring2021_barbarous_assault_bristleback_weapon",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/spring2021_barbarous_assault_bristleback_weapon/spring2021_barbarous_assault_bristleback_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "barbarous_blades",
    },
    -- VERSION 1
    [9786] = 
    {
        ['item_id'] = 9786,
        ['name'] = "Crystals of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_armor/ti8_bristleback_armor",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_armor/ti8_bristleback_armor.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9786, "#00f529ff"}, {97861, "#ff0000ff"}},
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristle_quest_ti8/bristle_quest_armor_ti8_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [9787] = 
    {
        ['item_id'] = 9787,
        ['name'] = "Bracers of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_arms/ti8_bristleback_arms",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_arms/ti8_bristleback_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9787, "#00f529ff"}, {97871, "#ff0000ff"}},
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [9788] = 
    {
        ['item_id'] = 9788,
        ['name'] = "Helm of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_head/ti8_bristleback_head",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_head/ti8_bristleback_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9788, "#00f529ff"}, {97881, "#ff0000ff"}},
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [9789] = 
    {
        ['item_id'] = 9789,
        ['name'] = "Lantern of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_neck/ti8_bristleback_neck",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_neck/ti8_bristleback_neck.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9789, "#00f529ff"}, {97891, "#ff0000ff"}},
        ['SlotType'] = "neck",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [9790] = 
    {
        ['item_id'] = 9790,
        ['name'] = "Flail of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_weapon/ti8_bristleback_weapon",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_weapon/ti8_bristleback_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9790, "#00f529ff"}, {97901, "#ff0000ff"}},
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristle_quest_ti8/bristle_quest_weapon_ti8_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    -- Version 2
    [97861] = 
    {
        ["dota_id"] = 9786,
        ["ItemStyle"] = "1",
        ['item_id'] = 97861,
        ['name'] = "Crystals of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_armor/ti8_bristleback_armor_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_armor/ti8_bristleback_armor.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9786, "#00f529ff"}, {97861, "#ff0000ff"}},
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristle_quest_ti8/bristle_quest_armor_ti8_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [97871] = 
    {
        ["dota_id"] = 9787,
        ["ItemStyle"] = "1",
        ['item_id'] = 97871,
        ['name'] = "Bracers of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_arms/ti8_bristleback_arms_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_arms/ti8_bristleback_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9787, "#00f529ff"}, {97871, "#ff0000ff"}},
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [97881] = 
    {
        ["dota_id"] = 9788,
        ["ItemStyle"] = "1",
        ['item_id'] = 97881,
        ['name'] = "Helm of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_head/ti8_bristleback_head_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_head/ti8_bristleback_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9788, "#00f529ff"}, {97881, "#ff0000ff"}},
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [97891] = 
    {
        ["dota_id"] = 9789,
        ["ItemStyle"] = "1",
        ['item_id'] = 97891,
        ['name'] = "Lantern of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_neck/ti8_bristleback_neck_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_neck/ti8_bristleback_neck.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9789, "#00f529ff"}, {97891, "#ff0000ff"}},
        ['SlotType'] = "neck",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
    },
    [97901] = 
    {
        ["dota_id"] = 9790,
        ["ItemStyle"] = "1",
        ['item_id'] = 97901,
        ['name'] = "Flail of the Violent Precipitate",
        ['icon'] = "econ/items/bristleback/ti8_bristleback_weapon/ti8_bristleback_weapon_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/bristleback/ti8_bristleback_weapon/ti8_bristleback_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9790, "#00f529ff"}, {97901, "#ff0000ff"}},
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "violent_precipitate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristle_quest_ti8/bristle_quest_weapon_ti8_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14515] = 
    {
        ['item_id'] = 14515,
        ['name'] = "Beast of the Crimson Ring Helm",
        ['icon'] = "econ/items/bristleback/bristleback_warrior_of_arena_head/bristleback_warrior_of_arena_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_warrior_of_arena_head/bristleback_warrior_of_arena_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "beast_crimson_ring",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_warrior_of_arena/bristleback_warrior_of_arena_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14513] = 
    {
        ['item_id'] = 14513,
        ['name'] = "Beast of the Crimson Ring Bracers",
        ['icon'] = "econ/items/bristleback/bristleback_warrior_of_arena_arms/bristleback_warrior_of_arena_arms",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_warrior_of_arena_arms/bristleback_warrior_of_arena_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "beast_crimson_ring",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_warrior_of_arena/bristleback_warrior_of_arena_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_mouth_l_fx"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_mouth_r_fx"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_01"},
                    [4] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_02"},
                    [5] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_03"},
                    [6] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_04"},
                    [7] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_r_fx_05"},
                    [8] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_01"},
                    [9] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_02"},
                    [10] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_03"},
                    [11] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_04"},
                    [12] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_wrist_l_fx_05"},
                }
            },
        },
    },
    [14514] = 
    {
        ['item_id'] = 14514,
        ['name'] = "Beast of the Crimson Ring Back",
        ['icon'] = "econ/items/bristleback/bristleback_warrior_of_arena_back/bristleback_warrior_of_arena_back",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_warrior_of_arena_back/bristleback_warrior_of_arena_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "beast_crimson_ring",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_warrior_of_arena/bristleback_warrior_of_arena_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14516] = 
    {
        ['item_id'] = 14516,
        ['name'] = "Beast of the Crimson Ring Armor",
        ['icon'] = "econ/items/bristleback/bristleback_warrior_of_arena_neck/bristleback_warrior_of_arena_neck",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_warrior_of_arena_neck/bristleback_warrior_of_arena_neck.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "neck",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "beast_crimson_ring",
    },
    [14517] = 
    {
        ['item_id'] = 14517,
        ['name'] = "Beast of the Crimson Ring Weapon",
        ['icon'] = "econ/items/bristleback/bristleback_warrior_of_arena_weapon/bristleback_warrior_of_arena_weapon",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/bristleback/bristleback_warrior_of_arena_weapon/bristleback_warrior_of_arena_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "beast_crimson_ring",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/bristleback/bristleback_warrior_of_arena/bristleback_warrior_of_arena_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [36214] = 
    {
        ["dota_id"] = 36214,
        ['item_id'] = 36214,
        ['name'] = "Bristleback Automaton Persona",
        ['icon'] = "econ/heroes/bristleback_automaton/bristleback_automaton",
        ['price'] = 8000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/bristleback/bristlebot/bristlebot.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ["is_persona_item"] = 1,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        ['sets'] = 'rare',
        ['persona'] = 1,
        ['is_exclusive'] = 1,
    },
}