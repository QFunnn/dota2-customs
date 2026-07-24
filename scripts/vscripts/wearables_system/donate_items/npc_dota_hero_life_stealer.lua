--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [13787] = 
    {
        ['item_id'] =13787,
        ['name'] ='Dark Maw Inhibitor',
        ['icon'] ='econ/items/lifestealer/ls_ti10_immortal_head/ls_ti10_immortal_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/ls_ti10_immortal_head/ls_ti10_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ls_ti10_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_head.vpcf",
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest_icon_glow.vpcf",
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest.vpcf",
        },
    },
    [13818] = 
    {
        ['item_id'] =13818,
        ['name'] ='Golden Dark Maw Inhibitor',
        ['icon'] ='econ/items/lifestealer/ls_ti10_immortal_head/ls_ti10_immortal_head_gold',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/ls_ti10_immortal_head/ls_ti10_immortal_head_gold.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ls_ti10_custom_golden",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_head_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_head_gold.vpcf",
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest_icon_gold_glow.vpcf",
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest.vpcf",
            "particles/econ/items/lifestealer/ls_ti10_immortal/ls_ti10_immortal_infest_gold.vpcf",
        },
    },
    [9199] = 
    {
        ['item_id'] =9199,
        ['name'] ='Profane Union',
        ['icon'] ='econ/items/lifestealer/immortal_back/lifestealer_immortal_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/immortal_back/lifestealer_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lifestealer_immortal_back_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_heart"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_ambient.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone/status_effect_life_stealer_immortal_rage.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone/lifestealer_immortal_backbone_rage_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/lifestealer/immortal_back/lifestealer_immortal_back_rage.vmdl",
        },
    },
    [9215] = 
    {
        ['item_id'] =9215,
        ['name'] ='Golden Profane Union',
        ['icon'] ='econ/items/lifestealer/immortal_back/lifestealer_immortal_back_golden',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/immortal_back/lifestealer_immortal_back_golden.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lifestealer_immortal_back_custom_golden",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_gold_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_heart"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_gold_ambient.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/status_effect_life_stealer_immortal_rage_gold.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_gold_rage.vpcf",
            "particles/econ/items/lifestealer/lifestealer_immortal_backbone_gold/lifestealer_immortal_backbone_rage_ambient_gold.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/lifestealer/immortal_back/lifestealer_immortal_back_rage_golden.vmdl",
        },
    },
    [12934] = 
    {
        ['item_id'] =12934,
        ['name'] ='Dread Requisition',
        ['icon'] ='econ/items/lifestealer/ls_ti9_immortal_arms/ls_ti9_immortal_arms',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/ls_ti9_immortal_arms/ls_ti9_immortal_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lifestealer_immortal_arms_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_l"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_immortal_ambient_gold.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal/status_effect_ls_ti9_open_wounds.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_open_wounds_impact.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_immortal_ambient_gold.vpcf"
        },
    },
    [12998] = 
    {
        ['item_id'] =12998,
        ['name'] ='Golden Dread Requisition',
        ['icon'] ='econ/items/lifestealer/ls_ti9_immortal_arms/ls_ti9_immortal_arms1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/ls_ti9_immortal_arms/ls_ti9_immortal_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_lifestealer_immortal_arms_custom_golden",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_immortal_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_l"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_elbow_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/ls_ti9_immortal/ls_ti9_immortal_ambient.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/status_effect_ls_ti9_open_wounds_gold.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_open_wounds_gold.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_open_wounds_gold_impact.vpcf",
            "particles/econ/items/lifestealer/ls_ti9_immortal_gold/ls_ti9_immortal_ambient_gold.vpcf",
        },
    },
    [9108] = 
    {
        ['item_id'] =9108,
        ['name'] ='Belt of the Chainbreaker',
        ['icon'] ='econ/items/lifestealer/mad_naix_of_the_fury_dungeon_belt/mad_naix_of_the_fury_dungeon_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/mad_naix_of_the_fury_dungeon_belt/mad_naix_of_the_fury_dungeon_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lifestealer_chainbreaker',
    },
    [9107] = 
    {
        ['item_id'] =9107,
        ['name'] ='Armor of the Chainbreaker',
        ['icon'] ='econ/items/lifestealer/mad_naix_of_the_fury_dungeon_back/mad_naix_of_the_fury_dungeon_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/mad_naix_of_the_fury_dungeon_back/mad_naix_of_the_fury_dungeon_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lifestealer_chainbreaker',
    },
    [9105] = 
    {
        ['item_id'] = 9105,
        ['name'] ='Mask of the Chainbreaker',
        ['icon'] ='econ/items/lifestealer/mad_naix_of_the_fury_dungeon_head/mad_naix_of_the_fury_dungeon_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/mad_naix_of_the_fury_dungeon_head/mad_naix_of_the_fury_dungeon_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lifestealer_chainbreaker',
    },
    [9106] = 
    {
        ['item_id'] =9106,
        ['name'] ='Claws of the Chainbreaker',
        ['icon'] ='econ/items/lifestealer/mad_naix_of_the_fury_dungeon_arms/mad_naix_of_the_fury_dungeon_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/mad_naix_of_the_fury_dungeon_arms/mad_naix_of_the_fury_dungeon_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lifestealer_chainbreaker',
    },
    [7395] = 
    {
        ['item_id'] =7395,
        ['name'] ='Mask of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/bloody_ripper_head/bloody_ripper_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/bloody_ripper_head/bloody_ripper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7395, "#ad7f49"}, {7475, "#740c0c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ls_bloody_ripper_head_1",
        ['sets'] = 'bloody_ripper',
    },
    [7393] = 
    {
        ['item_id'] =7393,
        ['name'] ='Blades of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/bloody_ripper_back/bloody_ripper_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/bloody_ripper_back/bloody_ripper_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7393, "#ad7f49"}, {7473, "#740c0c"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7392] = 
    {
        ['item_id'] =7392,
        ['name'] ='Wraps of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/bloody_ripper_arms/bloody_ripper_arms',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/bloody_ripper_arms/bloody_ripper_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7392, "#ad7f49"}, {7471, "#740c0c"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7394] = 
    {
        ['item_id'] =7394,
        ['name'] ='Belt of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/bloody_ripper_belt/bloody_ripper_belt',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/bloody_ripper_belt/bloody_ripper_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7394, "#ad7f49"}, {7474, "#740c0c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7471] = 
    {
        ['item_id'] =7471,
        ['name'] ='Compendium Wraps of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/promo_bloody_ripper_arms/promo_bloody_ripper_arms',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/promo_bloody_ripper_arms/promo_bloody_ripper_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7392, "#ad7f49"}, {7471, "#740c0c"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7473] = 
    {
        ['item_id'] =7473,
        ['name'] ='Compendium Blades of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/promo_bloody_ripper_back/promo_bloody_ripper_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/promo_bloody_ripper_back/promo_bloody_ripper_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7393, "#ad7f49"}, {7473, "#740c0c"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7474] = 
    {
        ['item_id'] =7474,
        ['name'] ='Compendium Belt of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/promo_bloody_ripper_belt/promo_bloody_ripper_belt',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/promo_bloody_ripper_belt/promo_bloody_ripper_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7394, "#ad7f49"}, {7474, "#740c0c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bloody_ripper',
    },
    [7475] = 
    {
        ['item_id'] =7475,
        ['name'] ='Compendium Mask of the Bloody Ripper',
        ['icon'] ='econ/items/lifestealer/promo_bloody_ripper_head/promo_bloody_ripper_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/promo_bloody_ripper_head/promo_bloody_ripper_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7395, "#ad7f49"}, {7475, "#740c0c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_ls_bloody_ripper_head_2",
        ['sets'] = 'bloody_ripper',
    },
    [23452] = 
    {
        ['item_id'] =23452,
        ['name'] ='Obsidian Atrocity - Back',
        ['icon'] ='econ/items/lifestealer/lavastealer_back/lavastealer_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_back/lavastealer_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23452, "#ed761f"}, {234521, "#42a4e2"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/lifestealer/lifestealer_2022_themed/lifestealer_2022_themed_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/lifestealer/lifestealer_2022_themed/lifestealer_2022_themed_back_ambient.vpcf",
        },
    },
    [23451] = 
    {
        ['item_id'] =23451,
        ['name'] ='Obsidian Atrocity - Head',
        ['icon'] ='econ/items/lifestealer/lavastealer_head/lavastealer_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_head/lavastealer_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23451, "#ed761f"}, {234511, "#42a4e2"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
    },
    [23453] = 
    {
        ['item_id'] =23453,
        ['name'] ='Obsidian Atrocity - Arms',
        ['icon'] ='econ/items/lifestealer/lavastealer_arms/lavastealer_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_arms/lavastealer_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23453, "#ed761f"}, {234531, "#42a4e2"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
    },
    [23454] = 
    {
        ['item_id'] =23454,
        ['name'] ='Obsidian Atrocity - Belt',
        ['icon'] ='econ/items/lifestealer/lavastealer_belt/lavastealer_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_belt/lavastealer_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{23454, "#ed761f"}, {234541, "#42a4e2"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
    },

    [234521] = 
    {
        ["dota_id"] = 23452,
        ["ItemStyle"] = "1",
        ['item_id'] =234521,
        ['name'] ='Obsidian Atrocity - Back',
        ['icon'] ='econ/items/lifestealer/icestealer_back/icestealer_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_back/lavastealer_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23452, "#ed761f"}, {234521, "#42a4e2"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
        ['MaterialGroupItem'] = "1",
    },
    [234511] = 
    {
        ["dota_id"] = 23451,
        ["ItemStyle"] = "1",
        ['item_id'] =234511,
        ['name'] ='Obsidian Atrocity - Head',
        ['icon'] ='econ/items/lifestealer/icestealer_head/icestealer_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_head/lavastealer_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23451, "#ed761f"}, {234511, "#42a4e2"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
        ['MaterialGroupItem'] = "1",
    },
    [234531] = 
    {
        ["dota_id"] = 23453,
        ["ItemStyle"] = "1",
        ['item_id'] =234531,
        ['name'] ='Obsidian Atrocity - Arms',
        ['icon'] ='econ/items/lifestealer/icestealer_arms/icestealer_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_arms/lavastealer_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23453, "#ed761f"}, {234531, "#42a4e2"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
        ['MaterialGroupItem'] = "1",
    },
    [234541] = 
    {
        ["dota_id"] = 23454,
        ["ItemStyle"] = "1",
        ['item_id'] =234541,
        ['name'] ='Obsidian Atrocity - Belt',
        ['icon'] ='econ/items/lifestealer/icestealer_belt/icestealer_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/lifestealer/lavastealer_belt/lavastealer_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{23454, "#ed761f"}, {234541, "#42a4e2"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'obsidian_atrocity',
        ['MaterialGroupItem'] = "1",
    },
}