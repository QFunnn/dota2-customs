--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
[28502] = 
{
    ['item_id'] =28502,
    ['name'] ='Bootblack Brawler - Head',
    ['icon'] ='econ/items/axe/axe_dressed_to_cull_head/axe_dressed_to_cull_head',
    ['price'] = 1200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/axe/axe_dressed_to_cull_head/axe_dressed_to_cull_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bootblack_brawler',
    ["ParticlesItems"] = 
    {
        {
            ["ParticleName"] = "particles/econ/items/axe/axe_cc_2024_hat/axe_cc_2024_hat.vpcf",
            ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            ["ControllPoints"] = 
            {
                [0] = {"SetParticleControl", "default"},
                [1] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "cigar"
                },
                [2] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "hat"
                },
            }
        }
    },
},
[28500] = 
{
    ['item_id'] =28500,
    ['name'] ='Bootblack Brawler - Armor',
    ['icon'] ='econ/items/axe/axe_dressed_to_cull_armor/axe_dressed_to_cull_armor',
    ['price'] = 1200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/axe/axe_dressed_to_cull_armor/axe_dressed_to_cull_armor.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bootblack_brawler',
},
[28453] = 
{
    ['item_id'] =28453,
    ['name'] ='Bootblack Brawler - Misc',
    ['icon'] ='econ/items/axe/axe_dressed_to_cull_misc/axe_dressed_to_cull_misc',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/axe/axe_dressed_to_cull_misc/axe_dressed_to_cull_misc.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'misc',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bootblack_brawler',
    ["ParticlesItems"] = 
    {
        {
            ["ParticleName"] = "particles/econ/items/axe/axe_cc_2024_arms/axe_cc_2024_arms.vpcf",
            ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            ["ControllPoints"] = 
            {
                [0] = {"SetParticleControl", "default"},
                [2] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "elbow"
                },
            }
        }
    },
},
[28498] = 
{
    ['item_id'] =28498,
    ['name'] ='Bootblack Brawler - Belt',
    ['icon'] ='econ/items/axe/axe_dressed_to_cull_belt/axe_dressed_to_cull_belt',
    ['price'] = 800,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/axe/axe_dressed_to_cull_belt/axe_dressed_to_cull_belt.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'belt',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bootblack_brawler',
},
[28499] = 
{
    ['item_id'] =28499,
    ['name'] ='Bootblack Brawler - Weapon',
    ['icon'] ='econ/items/axe/axe_dressed_to_cull_weapon/axe_dressed_to_cull_weapon',
    ['price'] = 1200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/axe/axe_dressed_to_cull_weapon/axe_dressed_to_cull_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bootblack_brawler',
    ["ParticlesItems"] = 
    {
        {
            ["ParticleName"] = "particles/econ/items/axe/axe_cc_2024_weapon/axe_cc_2024_weapon.vpcf",
            ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            ["ControllPoints"] = 
            {
                [0] = {"SetParticleControl", "default"},
                [11] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "weapon_end"
                },
            }
        }
    },
},
    [12964] = 
    {
        ['item_id'] = 12964,
        ['name'] = "Fists of Axe Unleashed",
        ['icon'] = "econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_weapon",
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/axe/ti9_jungle_axe/axe_bare.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/development/invisiblebox.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_persona_custom",
        ['sets'] = 'axe_persona',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_misc_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hitloc", "hero",
                    },
                }
            },
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_attack_blur_counterhelix.vpcf",
            "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_cullingblade_sprint_axe.vpcf",
            "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_sprint.vpcf",
            "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_culling_blade_kill.vpcf"
        }
    },
    [12968] = 
    {
        ['item_id'] = 12968,
        ['name'] = "Hair of Axe Unleashed",
        ['icon'] = "econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_hair",
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/axe/ti9_jungle_axe/ti9_jungle_axe_hair.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_persona',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                }
            }
        },
    },
    [12965] = 
    {
        ['item_id'] = 12965,
        ['name'] = "Torso of Axe Unleashed",
        ['icon'] = "econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_armor",
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/development/invisiblebox.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_persona',
    },
    [12966] = 
    {
        ['item_id'] = 12966,
        ['name'] = "Belt of Axe Unleashed",
        ['icon'] = "econ/items/axe/ti9_jungle_axe/ti9_jungle_axe_belt",
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/axe/ti9_jungle_axe/ti9_jungle_axe_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_persona',
    },
    [7214] = 
    {
        ['item_id'] =7214,
        ['name'] ='Molten Claw',
        ['icon'] ='econ/items/axe/molten_claw/molten_claw',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/molten_claw/molten_claw.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_molten_claw_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_armor_molten_claw/axe_molten_claw_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [6605] = 
    {
        ['item_id'] =6605,
        ['name'] ='Rampant Outrage',
        ['icon'] ='econ/items/axe/shout_mask/shout_mask',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/shout_mask/shout_mask.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_shout_mask_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_helm_shoutmask/axe_shout_mask_ambient.vpcf",
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
                        "attach_mouth"
                    },
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/axe_helm_shoutmask/axe_beserkers_call_owner_shoutmask.vpcf",
        }
    },
    [12954] = 
    {
        ['item_id'] =12954,
        ['name'] ='Crucible of Rile',
        ['icon'] ='econ/items/axe/axe_ti9_immortal_head/axe_ti9_immortal_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_ti9_immortal_head/axe_ti9_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_item_ti9_head_immortal",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_immortal_ambient.vpcf",
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
                        "attach_jet_top_left"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_mid_left"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_bot_left"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_top_right"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_mid_right"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_bot_right"
                    },
                }
            }
        },
    },
    [13543] = 
    {
        ['item_id'] =13543,
        ['name'] ='Golden Crucible of Rile',
        ['icon'] ='econ/items/axe/axe_ti9_immortal_head/axe_ti9_immortal_head1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/axe_ti9_immortal_head/axe_ti9_immortal_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_item_ti9_head_immortal_gold",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_gold_immortal_ambient.vpcf",
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
                        "attach_jet_top_left"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_mid_left"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_bot_left"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_top_right"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_mid_right"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_jet_bot_right"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_head"
                    },
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/axe_ti9_immortal/axe_ti9_gold_call.vpcf",
        }
    },
    [8468] = 
    {
        ['item_id'] =8468,
        ['name'] ='Mantle of the Cinder Baron',
        ['icon'] ='econ/items/axe/axe_mantle_of_the_cinder_baron/axe_mantle_of_the_cinder_baron',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_cape/axe_cape.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8468, "#f2550c"}, {84681, "#0cb5f2"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_mantle_baron_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_cinder/axe_cinder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger.vpcf",
        },
    },
    [84681] = 
    {
        ["dota_id"] = 8468,
        ["ItemStyle"] = "1",
        ['item_id'] =84681,
        ['name'] ='Mantle of the Cinder Baron',
        ['icon'] ='econ/items/axe/axe_mantle_of_the_cinder_baron_alt/axe_mantle_of_the_cinder_baron_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_cape/axe_cape.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8468, "#f2550c"}, {84681, "#0cb5f2"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_axe_mantle_baron_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_cinder/axe_cinder_ambient_alt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Thumb_plc1_R"
                    },
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger.vpcf",
        }
    },
    [4008] = 
    {
        ['item_id'] =4008,
        ['name'] ='Demon Blood Helm',
        ['icon'] ='econ/items/axe/demon_blood_helm',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/demon_blood_helm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demon_blood_axe',
    },
    [4009] = 
    {
        ['item_id'] =4009,
        ['name'] ='Demon Blood Armor',
        ['icon'] ='econ/items/axe/demon_blood_armor',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/demon_blood_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demon_blood_axe',
    },
    [4010] = 
    {
        ['item_id'] =4010,
        ['name'] ='Demon Blood Guard',
        ['icon'] ='econ/items/axe/demon_blood_belt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/demon_blood_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'demon_blood_axe',
    },
    [4004] = 
    {
        ['item_id'] =4004,
        ['name'] ='Blood Chaser',
        ['icon'] ='econ/items/axe/blood_chaser',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/axe/axe.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/demon_blood/demon_blood_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_blood_chaser_axe_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_weapon_bloodchaser/axe_drag_sparks.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf"
        }
    },
    [13928] = 
    {
        ['item_id'] =13928,
        ['name'] ='Days of the Demon - Armor',
        ['icon'] ='econ/items/axe/oni_of_the_red_mist_armor/oni_of_the_red_mist_armor',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oni_of_the_red_mist_armor/oni_of_the_red_mist_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'daysofthedemon',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_oni_of_the_red_mist/axe_oni_red_mist_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_l"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder_r"
                    },
                }
            }
        },
    },
    [13930] = 
    {
        ['item_id'] =13930,
        ['name'] ='Days of the Demon - Head',
        ['icon'] ='econ/items/axe/oni_of_the_red_mist_head/oni_of_the_red_mist_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oni_of_the_red_mist_head/oni_of_the_red_mist_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'daysofthedemon',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_oni_of_the_red_mist/axe_oni_red_mist_head_ambient.vpcf",
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
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_face_1_l"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_face_2_l"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_face_1_r"
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_face_2_r"
                    },
                }
            }
        },
    },
    [13927] = 
    {
        ['item_id'] =13927,
        ['name'] ='Days of the Demon - Weapon',
        ['icon'] ='econ/items/axe/oni_of_the_red_mist_weapon/oni_of_the_red_mist_weapon',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/axe/axe.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oni_of_the_red_mist_weapon/oni_of_the_red_mist_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'daysofthedemon',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_oni_of_the_red_mist/axe_oni_red_mist_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_dragon"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_a_l"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_b_l"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_c_l"
                    },
                    [14] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_a_r"
                    },
                    [15] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_b_r"
                    },
                    [16] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_scale_c_r"
                    },
                }
            }
        },
    },
    [13872] = 
    {
        ['item_id'] =13872,
        ['name'] ='Days of the Demon - Misc',
        ['icon'] ='econ/items/axe/oni_of_the_red_mist_misc/oni_of_the_red_mist_misc',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oni_of_the_red_mist_misc/oni_of_the_red_mist_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'daysofthedemon',
    },
    [13929] = 
    {
        ['item_id'] =13929,
        ['name'] ='Days of the Demon - Belt',
        ['icon'] ='econ/items/axe/oni_of_the_red_mist_belt/oni_of_the_red_mist_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oni_of_the_red_mist_belt/oni_of_the_red_mist_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'daysofthedemon',
    },
    [8469] = 
    {
        ['dota_id'] =8382,
        ['item_id'] =8469,
        ['name'] ='Supreme Pauldrons of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_armor/oglodi_big_boss_armor',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_armor/oglodi_big_boss_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8469, "#f0230c"}, {84691, "#f2bd0c"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [8470] = 
    {
        ['dota_id'] =8384,
        ['item_id'] =8470,
        ['name'] ='Supreme Belt of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_belt/oglodi_big_boss_belt',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_belt/oglodi_big_boss_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8470, "#f0230c"}, {84701, "#f2bd0c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [8471] = 
    {
        ['dota_id'] =8386,
        ['item_id'] =8471,
        ['name'] ='Supreme Mask of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_head/oglodi_big_boss_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_head/oglodi_big_boss_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8471, "#f0230c"}, {84711, "#f2bd0c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [8473] = 
    {
        ['dota_id'] =8389,
        ['item_id'] =8473,
        ['name'] ='Supreme Axe of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_weapon/oglodi_big_boss_weapon',
        ['price'] = 200,
        ['HeroModel'] = "models/heroes/axe/axe.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_weapon/oglodi_big_boss_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8473, "#f0230c"}, {84731, "#f2bd0c"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [8472] = 
    {
        ['dota_id'] =8388,
        ['item_id'] =8472,
        ['name'] ='Supreme Bracers of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_misc/oglodi_big_boss_misc',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_misc/oglodi_big_boss_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8472, "#f0230c"}, {84721, "#f2bd0c"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [84691] = 
    {
        ["dota_id"] = 8469,
        ["ItemStyle"] = "1",
        ['item_id'] =84691,
        ['name'] ='Supreme Pauldrons of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_armor/oglodi_big_boss_armor1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_armor/oglodi_big_boss_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8469, "#f0230c"}, {84691, "#f2bd0c"}},
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [84701] = 
    {
        ["dota_id"] = 8470,
        ["ItemStyle"] = "1",
        ['item_id'] =84701,
        ['name'] ='Supreme Belt of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_belt/oglodi_big_boss_belt1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_belt/oglodi_big_boss_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8470, "#f0230c"}, {84701, "#f2bd0c"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [84711] = 
    {
        ["dota_id"] = 8471,
        ["ItemStyle"] = "1",
        ['item_id'] =84711,
        ['name'] ='Supreme Mask of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_head/oglodi_big_boss_head1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_head/oglodi_big_boss_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8471, "#f0230c"}, {84711, "#f2bd0c"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [84731] = 
    {
        ["dota_id"] = 8473,
        ["ItemStyle"] = "1",
        ['item_id'] =84731,
        ['name'] ='Supreme Axe of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_weapon/oglodi_big_boss_weapon1',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/axe/axe.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_weapon/oglodi_big_boss_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8473, "#f0230c"}, {84731, "#f2bd0c"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [84721] = 
    {
        ["dota_id"] = 8472,
        ["ItemStyle"] = "1",
        ['item_id'] =84721,
        ['name'] ='Supreme Bracers of the Warboss',
        ['icon'] ='econ/items/axe/oglodi_big_boss_misc/oglodi_big_boss_misc1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/axe/oglodi_big_boss_misc/oglodi_big_boss_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8472, "#f0230c"}, {84721, "#f2bd0c"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'supreme_black_orc',
    },
    [25824] = 
    {
        ['item_id'] =25824,
        ['name'] ='The Molten Fist - Armor',
        ['icon'] ='econ/items/axe/axe_lava_legion_commander_armor/axe_lava_legion_commander_armor',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_lava_legion_commander_armor/axe_lava_legion_commander_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_molten_fist',
    },
    [25826] = 
    {
        ['item_id'] =25826,
        ['name'] ='The Molten Fist - Head',
        ['icon'] ='econ/items/axe/axe_lava_legion_commander_head/axe_lava_legion_commander_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_lava_legion_commander_head/axe_lava_legion_commander_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_molten_fist',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/lava_legion/lava_legion_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_visor",
                    },
                }
            },
        },
    },
    [25825] = 
    {
        ['item_id'] =25825,
        ['name'] ='The Molten Fist - Belt',
        ['icon'] ='econ/items/axe/axe_lava_legion_commander_belt/axe_lava_legion_commander_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_lava_legion_commander_belt/axe_lava_legion_commander_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_molten_fist',
    },
    [25827] = 
    {
        ['item_id'] =25827,
        ['name'] ='The Molten Fist - Misc',
        ['icon'] ='econ/items/axe/axe_lava_legion_commander_misc/axe_lava_legion_commander_misc',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_lava_legion_commander_misc/axe_lava_legion_commander_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_molten_fist',
    },
    [25828] = 
    {
        ['item_id'] =25828,
        ['name'] ='The Molten Fist - Weapon',
        ['icon'] ='econ/items/axe/axe_lava_legion_commander_weapon/axe_lava_legion_commander_weapon',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_lava_legion_commander_weapon/axe_lava_legion_commander_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'axe_molten_fist',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/lava_legion/lava_legion_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "Thumb_plc1_R",
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon",
                    },
                }
            },
        },
    },


    [36153] = 
    {
        ['item_id'] =36153,
        ['name'] ='Gilded Fang',
        ['icon'] ='econ/items/axe/axe_winter_2025_weapon_alt/axe_winter_2025_weapon_alt',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_winter_2025_weapon_alt/axe_winter_2025_weapon_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_tyrant',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_winter_2025/axe_winter_2025_weapon_alt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [36151] = 
    {
        ['item_id'] =36151,
        ['name'] ='Golden Armor',
        ['icon'] ='econ/items/axe/axe_winter_2025_armor_alt/axe_winter_2025_armor_alt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_winter_2025_armor_alt/axe_winter_2025_armor_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_tyrant',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_winter_2025/axe_winter_2025_armor_alt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [36149] = 
    {
        ['item_id'] =36149,
        ['name'] ='Golden Warkilt',
        ['icon'] ='econ/items/axe/axe_winter_2025_belt_alt/axe_winter_2025_belt_alt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_winter_2025_belt_alt/axe_winter_2025_belt_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_tyrant',
    },
    [36150] = 
    {
        ['item_id'] =36150,
        ['name'] ='Golden Mane',
        ['icon'] ='econ/items/axe/axe_winter_2025_head_alt/axe_winter_2025_head_alt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_winter_2025_head_alt/axe_winter_2025_head_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_tyrant',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_winter_2025/axe_winter_2025_head_alt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [36152] = 
    {
        ['item_id'] =36152,
        ['name'] ='Golden Sigil',
        ['icon'] ='econ/items/axe/axe_winter_2025_misc_alt/axe_winter_2025_misc_alt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/axe/axe_winter_2025_misc_alt/axe_winter_2025_misc_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_tyrant',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/axe/axe_winter_2025/axe_winter_2025_misc_alt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [31367] = 
    {
        ["dota_id"] = 31367,
        ['item_id'] = 31367,
        ['name'] = "Axe Automaton Persona",
        ['icon'] = "econ/heroes/axe_automaton/axe_automaton",
        ['price'] = 8000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/axe/axe_carnival/axe_carnival_base.vmdl",
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
        ["ParticlesSkills"] =
        {
            "particles/econ/items/axe/axe_carnival/axe_carnival_battle_hunger.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/axe/axe_carnival/axe_carnival_weapon.vmdl",
            "models/items/axe/axe_carnival/axe_carnival_back.vmdl",
        },
    },
}