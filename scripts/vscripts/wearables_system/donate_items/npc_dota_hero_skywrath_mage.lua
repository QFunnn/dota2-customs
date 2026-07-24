--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [420] = 
    {
        ['item_id'] =420,
        ['name'] ='Skywrath Mages Weapon',
        ['icon'] ='econ/heroes/skywrath_mage/skywrath_mage_staff',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/skywrath_mage/skywrath_mage_staff.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'weapon',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_staff_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff"
                    },
                }
            },
        },
    },

    [6892] = 
    {
        ['item_id'] =6892,
        ['name'] ='Empyrean',
        ['icon'] ='econ/items/skywrath_mage/empyrean',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/empyrean.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_empyrean_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_weapon_empyrean/skywrath_mage_staff_ambient_empyrean.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_generic", "hero"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/skywrath/flare_immortal.vpcf"
        }
    },
    [6919] = 
    {
        ['item_id'] =6919,
        ['name'] ='Golden Empyrean',
        ['icon'] ='econ/items/skywrath_mage/empyrean1',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/empyrean.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_empyrean_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_weapon_empyrean/skywrath_mage_staff_ambient_empyrean.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_staff_generic", "hero"
                    },
                    [25] = {'SetParticleControl', {255, 145, 42}},
                    [26] = {'SetParticleControl', {1, 1, 1}},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/skywrath/flare_immortal_gold.vpcf"
        }
    },
    [12926] = 
    {
        ['item_id'] =12926,
        ['name'] ='Flight of Epiphany',
        ['icon'] ='econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_fligh_immortal",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_l_01"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_r_01"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [17] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_a"
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_a"
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_b"
                    },
                    [23] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_b"
                    },
                    [24] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_c"
                    },
                    [25] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_c"
                    },
                    [26] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_d"
                    },
                    [27] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_d"
                    },
                    [28] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_e"
                    },
                    [29] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_e"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_arcane_bolt.vpcf"
        }
    },
    [12993] = 
    {
        ['item_id'] =12993,
        ['name'] ='Golden Flight of Epiphany',
        ['icon'] ='econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back1',
        ['price'] = 2000,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = '0',
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_fligh_immortal_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_golden_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_l_01"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_r_01"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [17] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_a"
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_a"
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_b"
                    },
                    [23] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_b"
                    },
                    [24] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_c"
                    },
                    [25] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_c"
                    },
                    [26] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_d"
                    },
                    [27] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_d"
                    },
                    [28] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_e"
                    },
                    [29] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_e"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_arcane_bolt_golden.vpcf"
        }
    },
    [13568] = 
    {
        ['item_id'] =13568,
        ['name'] ='Crimson Flight of Epiphany',
        ['icon'] ='econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back2',
        ['price'] = 5000,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_ti9_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_fligh_immortal_crimson",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_crimson_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_l_01"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_r_01"
                    },
                    [13] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [17] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_back"
                    },
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_a"
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_a"
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_b"
                    },
                    [23] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_b"
                    },
                    [24] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_c"
                    },
                    [25] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_c"
                    },
                    [26] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_d"
                    },
                    [27] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_d"
                    },
                    [28] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_l_e"
                    },
                    [29] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_feathers_r_e"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/skywrath_mage/skywrath_ti9_immortal_back/skywrath_mage_ti9_arcane_bolt_crimson.vpcf"
        }
    },
    
    
    -- Sets
    [6733] = 
    {
        ['item_id'] =6733,
        ['name'] ='Complete Bracers of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_arms/manticore_of_the_eyrie_arms',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_arms/manticore_of_the_eyrie_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
    },
    [6734] = 
    {
        ['item_id'] =6734,
        ['name'] ='Complete Belt of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_belt/manticore_of_the_eyrie_belt',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_belt/manticore_of_the_eyrie_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
    },
    [6972] = 
    {
        ['item_id'] =6972,
        ['name'] ='Complete Staff of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_staff/manticore_of_the_eyrie_staff',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_staff/manticore_of_the_eyrie_staff.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/manticore/manticore_staff.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_staff"
                    },
                }
            },
        },
    },
    [6973] = 
    {
        ['item_id'] =6973,
        ['name'] ='Complete Helm of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_head/manticore_of_the_eyrie_head',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_head/manticore_of_the_eyrie_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
    },
    [6974] = 
    {
        ['item_id'] =6974,
        ['name'] ='Complete Armor of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_shoulder/manticore_of_the_eyrie_shoulder',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_shoulder/manticore_of_the_eyrie_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
    },
    [6975] = 
    {
        ['item_id'] =6975,
        ['name'] ='Complete Wings of the Manticore',
        ['icon'] ='econ/items/skywrath_mage/manticore_of_the_eyrie_wings/manticore_of_the_eyrie_wings',
        ['price'] = 400,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/manticore_of_the_eyrie_wings/manticore_of_the_eyrie_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'complete_vigilance',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/manticore/wings_of_the_manticore_ambientfx.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14913] = 
    {
        ['item_id'] =14913,
        ['name'] ='Eyriebound Imperator - Belt',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_belt/skywrath_mage_corrosion_of_regret_heart_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_belt/skywrath_mage_corrosion_of_regret_heart_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
    },
    [14919] = 
    {
        ['item_id'] =14919,
        ['name'] ='Eyriebound Imperator - Shoulder',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_shoulder/skywrath_mage_corrosion_of_regret_heart_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_shoulder/skywrath_mage_corrosion_of_regret_heart_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_shoulder/skywrath_mage_corrosion_of_regret_heart_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "clavicle_R"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "clavicle_L"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "spine3"
                    },
                }
            },
        },
    },
    [14920] = 
    {
        ['item_id'] =14920,
        ['name'] ='Eyriebound Imperator - Head',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_head/skywrath_mage_corrosion_of_regret_heart_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_head/skywrath_mage_corrosion_of_regret_heart_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_head/skywrath_mage_corrosion_of_regret_heart_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_l"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_r"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "gem"
                    },
                }
            },
        },
    },
    [14921] = 
    {
        ['item_id'] =14921,
        ['name'] ='Eyriebound Imperator - Arms',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_arms/skywrath_mage_corrosion_of_regret_heart_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_arms/skywrath_mage_corrosion_of_regret_heart_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
    },
    [14922] = 
    {
        ['item_id'] =14922,
        ['name'] ='Eyriebound Imperator - Weapon',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_weapon/skywrath_mage_corrosion_of_regret_heart_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_weapon/skywrath_mage_corrosion_of_regret_heart_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_weapon/sw_corrosion_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "staff"
                    },
                }
            },
        },
    },
    [14923] = 
    {
        ['item_id'] =14923,
        ['name'] ='Eyriebound Imperator - Back',
        ['icon'] ='econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_back/skywrath_mage_corrosion_of_regret_heart_back',
        ['price'] = 800,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_back/skywrath_mage_corrosion_of_regret_heart_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'eyribound_imperator',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_mage_corrosion_of_regret_heart_back/sm_corrosion_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [20] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_wing_a"
                    },
                    [21] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_wing_b"
                    },
                    [22] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_wing_a"
                    },
                    [23] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_wing_b"
                    },
                }
            },
        },
    },

    [13931] = 
    {
        ['item_id'] =13931,
        ['name'] ='Secrets of the Celestial Arms',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_arms/seraph_celestial_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_arms/seraph_celestial_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
    },

    [13932] = 
    {
        ['item_id'] =13932,
        ['name'] ='Secrets of the Celestial Back',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_back/seraph_celestial_back',
        ['price'] = 1200,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_back/seraph_celestial_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/seraph_celestial/seraph_celestial_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [20] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_wing_l_01"
                    },
                    [21] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_wing_r_01"
                    },
                    [22] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_wing_l_02"
                    },
                    [23] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_wing_r_02"
                    },
                }
            },
        },
    },

    [13933] = 
    {
        ['item_id'] =13933,
        ['name'] ='Secrets of the Celestial Weapon',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_weapon/seraph_celestial_weapon',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_weapon/seraph_celestial_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/seraph_celestial/seraph_celestial_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [2] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_shpere"
                    },
                }
            },
        },
    },

    [13936] = 
    {
        ['item_id'] =13936,
        ['name'] ='Secrets of the Celestial Head',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_head/seraph_celestial_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_head/seraph_celestial_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/seraph_celestial/seraph_celestial_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_horn"
                    },
                    [11] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spike_01"
                    },
                    [12] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spike_02"
                    },
                    [13] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spike_03"
                    },
                    [14] = 
                    {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spike_04"
                    },
                }
            },
        },
    },

    [13937] = 
    {
        ['item_id'] =13937,
        ['name'] ='Secrets of the Celestial Belt',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_belt/seraph_celestial_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_belt/seraph_celestial_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/seraph_celestial/seraph_celestial_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },

    [13934] = 
    {
        ['item_id'] =13934,
        ['name'] ='Secrets of the Celestial Shoulder',
        ['icon'] ='econ/items/skywrath_mage/seraph_celestial_shoulder/seraph_celestial_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/seraph_celestial_shoulder/seraph_celestial_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'secrets_celestial',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/seraph_celestial/seraph_celestial_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    
    [9774] = 
    {
        ['item_id'] =9774,
        ['name'] ='Helm of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9774, "#4d99cb"}, {97741, "#69fab4"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/ti8_set/skywrath_ti8_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_headfire"
                    },
                }
            },
        },
    },
    [9775] = 
    {
        ['item_id'] =9775,
        ['name'] ='Wings of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_wings',
        ['price'] = 300,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9775, "#4d99cb"}, {97751, "#69fab4"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [9776] =
    {
        ['item_id'] =9776,
        ['name'] ='Arms of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_arms',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9776, "#4d99cb"}, {97761, "#69fab4"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [9777] = 
    {
        ['item_id'] =9777,
        ['name'] ='Belt of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9777, "#4d99cb"}, {97771, "#69fab4"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [9778] = 
    {
        ['item_id'] =9778,
        ['name'] ='Pauldron of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9778, "#4d99cb"}, {97781, "#69fab4"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [9779] = 
    {
        ['item_id'] =9779,
        ['name'] ='Flame of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_set/skywrath_ti8_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9779, "#4d99cb"}, {97791, "#69fab4"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/ti8_set/skywrath_ti8_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_candle"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_candle"
                    },
                }
            },
        },
    },

    [97741] = 
    {
        ["dota_id"] = 9774,
        ["ItemStyle"] = "1",
        ['item_id'] =97741,
        ['name'] ='Helm of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_head/ti8_skywrath_mage_head_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9774, "#4d99cb"}, {97741, "#69fab4"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/ti8_set/skywrath_ti8_head_alternate_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_headfire"
                    },
                }
            },
        },
    },
    [97751] = 
    {
        ["dota_id"] = 9775,
        ["ItemStyle"] = "1",
        ['item_id'] =97751,
        ['name'] ='Wings of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_back/ti8_skywrath_mage_back_style1',
        ['price'] = 1,
        ['HeroModel'] = "models/heroes/skywrath_mage/skywrath_mage.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9775, "#4d99cb"}, {97751, "#69fab4"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [97761] =
    {
        ["dota_id"] = 9776,
        ["ItemStyle"] = "1",
        ['item_id'] =97761,
        ['name'] ='Arms of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_arms/ti8_skywrath_mage_arms_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9776, "#4d99cb"}, {97761, "#69fab4"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [97771] = 
    {
        ["dota_id"] = 9777,
        ["ItemStyle"] = "1",
        ['item_id'] =97771,
        ['name'] ='Belt of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_belt/ti8_skywrath_mage_belt_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9777, "#4d99cb"}, {97771, "#69fab4"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [97781] = 
    {
        ["dota_id"] = 9778,
        ["ItemStyle"] = "1",
        ['item_id'] =97781,
        ['name'] ='Pauldron of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_shoulder/ti8_skywrath_mage_shoulder_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9778, "#4d99cb"}, {97781, "#69fab4"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
    },
    [97791] = 
    {
        ["dota_id"] = 9779,
        ["ItemStyle"] = "1",
        ['item_id'] =97791,
        ['name'] ='Flame of the Penitent Scholar',
        ['icon'] ='econ/items/skywrath_mage/ti8_skywrath_mage_weapon/ti8_skywrath_mage_weapon_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/ti8_set/skywrath_ti8_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9779, "#4d99cb"}, {97791, "#69fab4"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'vigil_penitent',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/ti8_set/skywrath_ti8_weapon_alternative_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_candle"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_candle"
                    },
                }
            },
        },
    },
    -- Skywrath Mage Arcana
    [18539] = 
    {
        ['item_id'] =18539,
        ['name'] ='The Devotions of Dragonus - Wings',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_npc_dota_hero_skywrath_mage',
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['is_exclusive'] = 1,
        ['HeroModel'] = "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{18539, "#57b3ee"}, {185391, "#f0d354"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_arcana_style_1_custom",
        ['sets'] = 'skywrath_arcana',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ambient_wings.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ambient_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx", "hero"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx", "hero"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_bolt.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ancient_seal_debuff.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_cast.vpcf", 
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_failure.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_slow_debuff.vpcf",
            "particles/skywrath/flare_arcana.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_hit_ambient.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack.vpcf",
        }
    },
    [18540] = 
    {
        ['item_id'] =18540,
        ['name'] ='The Devotions of Dragonus - Weapon',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_weapon',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{18540, "#57b3ee"}, {185401, "#f0d354"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_tip_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_source_fx"
                    },
                }
            },
        },
    },
    [18542] = 
    {
        ['item_id'] =18542,
        ['name'] ='The Devotions of Dragonus - Belt',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_belt',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_belt_refit.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{18542, "#57b3ee"}, {185421, "#f0d354"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [18543] = 
    {
        ['item_id'] =18543,
        ['name'] ='The Devotions of Dragonus - Shoulder',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_shoulder',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{18543, "#57b3ee"}, {185431, "#f0d354"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [18544] = 
    {
        ['item_id'] =18544,
        ['name'] ='The Devotions of Dragonus - Arms',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_arms',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{18544, "#57b3ee"}, {185441, "#f0d354"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [18541] = 
    {
        ['item_id'] =18541,
        ['name'] ='The Devotions of Dragonus - Head',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{18541, "#57b3ee"}, {185411, "#f0d354"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [185391] = 
    {
        ["dota_id"] = 18539,
        ["ItemStyle"] = "1",
        ['item_id'] =185391,
        ['name'] ='The Devotions of Dragonus - Wings',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_npc_dota_hero_skywrath_mage_style1',
        ['price'] = 15000,
        ['is_exclusive'] = 1,
        ['HeroModel'] = "models/items/skywrath_mage/skywrath_arcana/skywrath_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_wings.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{18539, "#57b3ee"}, {185391, "#f0d354"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_skywrath_mage_arcana_style_2_custom",
        ['sets'] = 'skywrath_arcana',
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ambient_wings_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ambient_v2_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_left_fx", "hero"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_right_fx", "hero"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_bolt_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_ancient_seal_v2_debuff.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_cast_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_failure_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_concussive_shot_slow_debuff_v2.vpcf",
            "particles/skywrath/flare_arcana_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_hit_ambient_v2.vpcf",
            "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_base_attack_v2.vpcf",
        }
    },
    [185401] = 
    {
        ["dota_id"] = 18540,
        ["ItemStyle"] = "1",
        ['item_id'] =185401,
        ['name'] ='The Devotions of Dragonus - Weapon',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_weapon',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        --['OtherItemsBundle'] = {{18540, "#57b3ee"}, {185401, "#f0d354"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_weapon_ambient_v2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_tip_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_source_fx"
                    },
                }
            },
        },
    },
    [185421] = 
    {
        ["dota_id"] = 18542,
        ["ItemStyle"] = "1",
        ['item_id'] =185421,
        ['name'] ='The Devotions of Dragonus - Belt',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_belt',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_belt_refit.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{18542, "#57b3ee"}, {185421, "#f0d354"}},
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [185431] = 
    {
        ["dota_id"] = 18543,
        ["ItemStyle"] = "1",
        ['item_id'] =185431,
        ['name'] ='The Devotions of Dragonus - Shoulder',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_shoulder',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{18543, "#57b3ee"}, {185431, "#f0d354"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [185441] = 
    {
        ["dota_id"] = 18544,
        ["ItemStyle"] = "1",
        ['item_id'] =185441,
        ['name'] ='The Devotions of Dragonus - Arms',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_arms',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{18544, "#57b3ee"}, {185441, "#f0d354"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
    [185411] = 
    {
        ["dota_id"] = 18541,
        ["ItemStyle"] = "1",
        ['item_id'] =185411,
        ['name'] ='The Devotions of Dragonus - Head',
        ['icon'] ='econ/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_head',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/skywrath_mage/skywrath_arcana/skywrath_mage_arcana_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{18541, "#57b3ee"}, {185411, "#f0d354"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'skywrath_arcana',
    },
}