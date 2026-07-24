--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [12945] = 
    {
        ['item_id'] = 12945,
        ['name'] = "Infernal Menace",
        ['icon'] = "econ/items/centaur/centaur_ti9_immortal_weapon/centaur_ti9_immortal_weapon",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/centaur_ti9_immortal_weapon/centaur_ti9_immortal_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_1",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_ti9/centaur_ti9_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon_rear"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon_orb"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_spike_A"},
                    [4] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_spike_B"},
                    [5] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_spike_C"},
                    [6] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_spike_D"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_ti9/centaur_double_edge_ti9.vpcf",
            "particles/econ/items/centaur/centaur_ti9/centaur_double_edge_body_ti9.vpcf",
            "particles/econ/items/centaur/centaur_ti9/centaur_double_edge_phase_ti9.vpcf",
        },
    },
    [8008] = 
    {
        ['item_id'] = 8008,
        ['name'] = "Infernal Chieftain",
        ['icon'] = "econ/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model",
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_2",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_head"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_l"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_r"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
        },
    },
    [8039] = 
    {
        ['item_id'] = 8039,
        ['name'] = "Golden Infernal Chieftain",
        ['icon'] = "econ/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model1",
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "gold",
        ['ItemModel'] = "models/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_3",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_head"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_l"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_r"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_ti6_gold/centaur_ti6_warstomp_gold.vpcf",
        },
    },
    [8036] = 
    {
        ['item_id'] = 8036,
        ['name'] = "Infernal Chieftain of the Crimson Witness",
        ['icon'] = "econ/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model2",
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "witness",
        ['ItemModel'] = "models/items/centaur/centaur_ti6_immortal/mesh/centaur_ti6_immortal_model.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_4",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_ti6/centaur_ti6_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_head"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_l"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_r"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_ti6/centaur_ti6_warstomp.vpcf",
        },
    },
    [23127] = 
    {
        ['item_id'] = 23127,
        ['name'] = "Infernal Cavalcade",
        ['icon'] = "econ/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_5",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_overhead.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_cast.vpcf",
        },
    },
    [23837] = 
    {
        ['item_id'] = 23837,
        ['name'] = "Golden Infernal Cavalcade",
        ['icon'] = "econ/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn1",
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_6",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_gold.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_gold_overhead.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_cast_gold.vpcf",
        },
    },
    [29572] = 
    {
        ['item_id'] = 29572,
        ['name'] = "Infernal Cavalcade of the Crimson Witness",
        ['icon'] = "econ/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn2",
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "2",
        ['ItemModel'] = "models/items/centaur/cent_2022_immortal_horn/cent_2022_immortal_horn.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_7",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_ambient_crimson.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_crimson.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_crimson_overhead.vpcf",
            "particles/econ/items/centaur/centaur_2022_immortal/centaur_2022_immortal_stampede_cast_crimson.vpcf",
        },
    },
    [29651] = 
    {
        ['item_id'] = 29651,
        ['name'] = "Graxx's Strap",
        ['icon'] = "econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_style1.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{29651, "#15a566"}, {29668, "#bd8e22"}},
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_8",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_retaliate.vpcf",
        },
    },
    [29668] = 
    {
        ["dota_id"] = 29651,
        ["ItemStyle"] = "1",
        ['item_id'] = 29668,
        ['name'] = "Graxx's Strap",
        ['icon'] = "econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_style2.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{29651, "#15a566"}, {29668, "#bd8e22"}},
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_centaur_immortal_custom_9",
        ['sets'] = "rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn_fx"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/centaur/centaur_crownfall_belt/centaur_crownfall_belt_retaliate.vpcf",
        },
    },
    [8753] = 
    {
        ['item_id'] = 8753,
        ['name'] = "Mohawk of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_head/armor_of_unstoppable_force_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_head/armor_of_unstoppable_force_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_head_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_r"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_eye_l"},
                }
            },
        },
    },
    [8754] = 
    {
        ['item_id'] = 8754,
        ['name'] = "Tail of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_tail/armor_of_unstoppable_force_tail",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_tail/armor_of_unstoppable_force_tail.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "tail",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
    },
    [8755] = 
    {
        ['item_id'] = 8755,
        ['name'] = "Axe of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_weapon/armor_of_unstoppable_force_weapon_style1",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_weapon/armor_of_unstoppable_force_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_axe_eyes.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "axe_eyes"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/centaur/battle_dress_of_the_proven/centaur_proven_axe_edge.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [8756] = 
    {
        ['item_id'] = 8756,
        ['name'] = "Armor of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_shoulder/armor_of_unstoppable_force_shoulder",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_shoulder/armor_of_unstoppable_force_shoulder.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
    },
    [8757] = 
    {
        ['item_id'] = 8757,
        ['name'] = "Belt of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_belt/armor_of_unstoppable_force_belt",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_belt/armor_of_unstoppable_force_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
    },
    [8758] = 
    {
        ['item_id'] = 8758,
        ['name'] = "Barding of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_back/armor_of_unstoppable_force_back",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_back/armor_of_unstoppable_force_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
    },
    [8759] = 
    {
        ['item_id'] = 8759,
        ['name'] = "Bracers of the Proven",
        ['icon'] = "econ/items/centaur/armor_of_unstoppable_force_arms/armor_of_unstoppable_force_arms",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/armor_of_unstoppable_force_arms/armor_of_unstoppable_force_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "battle_dress_proven",
    },
    [23201] = 
    {
        ['item_id'] = 23201,
        ['name'] = "Barding of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_back/warbringer_back1",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_back/warbringer_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23204] = 
    {
        ['item_id'] = 23204,
        ['name'] = "Relentless Warbringer's Decapitator",
        ['icon'] = "econ/items/centaur/warbringer_weapon/warbringer_weapon1",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_weapon/warbringer_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23205] = 
    {
        ['item_id'] = 23205,
        ['name'] = "Tail of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_tail/warbringer_tail1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_tail/warbringer_tail.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "tail",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23203] = 
    {
        ['item_id'] = 23203,
        ['name'] = "Helm of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_helmet/warbringer_helmet1",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_helmet/warbringer_helmet.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23202] = 
    {
        ['item_id'] = 23202,
        ['name'] = "Belt of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_belt/warbringer_belt1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_belt/warbringer_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23200] = 
    {
        ['item_id'] = 23200,
        ['name'] = "Armor of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_shoulders/warbringer_shoulders1",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_shoulders/warbringer_shoulders.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [23199] = 
    {
        ['item_id'] = 23199,
        ['name'] = "Armguard of the Warbringer",
        ['icon'] = "econ/items/centaur/warbringer_arms/warbringer_arms1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/warbringer_arms/warbringer_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "summer_lineage_warbinger",
    },
    [12730] = 
    {
        ['item_id'] = 12730,
        ['name'] = "Iceplain Ravager Helm",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_head/frostivus2018_cent_icehhoof_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_head/frostivus2018_cent_icehhoof_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
    },
    [12724] = 
    {
        ['item_id'] = 12724,
        ['name'] = "Iceplain Ravager Tail",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_tail/frostivus2018_cent_icehhoof_tail",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_tail/frostivus2018_cent_icehhoof_tail.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "tail",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
    },
    [12725] = 
    {
        ['item_id'] = 12725,
        ['name'] = "Iceplain Ravager Armor",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_shoulder/frostivus2018_cent_icehhoof_shoulder",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_shoulder/frostivus2018_cent_icehhoof_shoulder.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
    },
    [12726] = 
    {
        ['item_id'] = 12726,
        ['name'] = "Iceplain Ravager Shield",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_arms/frostivus2018_cent_icehhoof_arms",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_arms/frostivus2018_cent_icehhoof_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
    },
    [12728] = 
    {
        ['item_id'] = 12728,
        ['name'] = "Iceplain Ravager Horn",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_back/frostivus2018_cent_icehhoof_back",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_back/frostivus2018_cent_icehhoof_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/cent_icehoof/cent_icehoof_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_horn"},
                }
            },
        },
    },
    [12731] = 
    {
        ['item_id'] = 12731,
        ['name'] = "Iceplain Ravager Axe",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_weapon/frostivus2018_cent_icehhoof_weapon",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_weapon/frostivus2018_cent_icehhoof_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/cent_icehoof/cent_icehoof_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_core"},
                }
            },
        },
    },
    [12729] = 
    {
        ['item_id'] = 12729,
        ['name'] = "Iceplain Ravager Belt",
        ['icon'] = "econ/items/centaur/frostivus2018_cent_icehhoof_belt/frostivus2018_cent_icehhoof_belt",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/frostivus2018_cent_icehhoof_belt/frostivus2018_cent_icehhoof_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "iceplain_ravager",
    },
    [8478] = 
    {
        ['item_id'] = 8478,
        ['name'] = "Eternal Tail of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_tail/chaos_champion_for_centaur_tail1",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_tail/chaos_champion_for_centaur_tail.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "tail",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8479] = 
    {
        ['item_id'] = 8479,
        ['name'] = "Eternal Armor of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_shoulder/chaos_champion_for_centaur_shoulder1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_shoulder/chaos_champion_for_centaur_shoulder.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8481] = 
    {
        ['item_id'] = 8481,
        ['name'] = "Eternal Helm of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_head/chaos_champion_for_centaur_head1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_head/chaos_champion_for_centaur_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8483] = 
    {
        ['item_id'] = 8483,
        ['name'] = "Eternal Belt of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_belt/chaos_champion_for_centaur_belt1",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_belt/chaos_champion_for_centaur_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8485] = 
    {
        ['item_id'] = 8485,
        ['name'] = "Eternal Axe of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_weapon/chaos_champion_for_centaur_weapon1",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_weapon/chaos_champion_for_centaur_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8491] = 
    {
        ['item_id'] = 8491,
        ['name'] = "Eternal Barding of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_back/chaos_champion_for_centaur_back1",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_back/chaos_champion_for_centaur_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [8493] = 
    {
        ['item_id'] = 8493,
        ['name'] = "Eternal Bracers of the Chaos Chosen",
        ['icon'] = "econ/items/centaur/chaos_champion_for_centaur_arms/chaos_champion_for_centaur_arms1",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = "models/items/centaur/chaos_champion_for_centaur_arms/chaos_champion_for_centaur_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "eternal_chaos_chosen",
    },
    [9754] = 
    {
        ['item_id'] = 9754,
        ['name'] = "Tail of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_tail/off_centaur_tail",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_tail/off_centaur_tail.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "tail",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
    },
    [12606] = 
    {
        ['item_id'] = 12606,
        ['name'] = "Hide of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_back/off_centaur_back",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_back/off_centaur_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
    },
    [12607] = 
    {
        ['item_id'] = 12607,
        ['name'] = "Belt of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_belt/off_centaur_belt",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_belt/off_centaur_belt.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "belt",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_plus_2018/centaur_plus_2018_ambient_belt_trace.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [12609] = 
    {
        ['item_id'] = 12609,
        ['name'] = "Bracer of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_arms/off_centaur_arms",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_arms/off_centaur_arms.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "arms",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_plus_2018/centaur_plus_2018_ambient_arm_trace.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [12610] = 
    {
        ['item_id'] = 12610,
        ['name'] = "Horns of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_head/off_centaur_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_head/off_centaur_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_plus_2018/centaur_plus_2018_ambient_head_trace.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [9753] = 
    {
        ['item_id'] = 9753,
        ['name'] = "Harness of Contested Fate",
        ['icon'] = "econ/items/centaur/off_centaur_shoulder/off_centaur_shoulder",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_shoulder/off_centaur_shoulder.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "shoulder",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_plus_2018/centaur_plus_2018_ambient_shoulder_trace.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [12608] = 
    {
        ['item_id'] = 12608,
        ['name'] = "The Uncontested",
        ['icon'] = "econ/items/centaur/off_centaur_weapon/off_centaur_weapon",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = "models/items/centaur/off_centaur_weapon/off_centaur_weapon.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = "weapon",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "contested_fate",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/centaur/centaur_plus_2018/centaur_plus_2018_ambient_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon"},
                }
            },
        },
    },

    [32701] = 
    {
        ['item_id'] =32701,
        ['name'] ='Cunning Counterfeit - Harmless Scepter',
        ['icon'] ='econ/items/centaur/supercourier_weapon/supercourier_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_weapon/supercourier_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32642] = 
    {
        ['item_id'] =32642,
        ['name'] ='Cunning Counterfeit - Donkey Arms',
        ['icon'] ='econ/items/centaur/supercourier_arms/supercourier_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_arms/supercourier_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32643] = 
    {
        ['item_id'] =32643,
        ['name'] ='Cunning Counterfeit - Saddle Packs',
        ['icon'] ='econ/items/centaur/supercourier_back/supercourier_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_back/supercourier_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32645] = 
    {
        ['item_id'] =32645,
        ['name'] ='Cunning Counterfeit - Convincing Visage',
        ['icon'] ='econ/items/centaur/supercourier_head/supercourier_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_head/supercourier_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32646] = 
    {
        ['item_id'] =32646,
        ['name'] ='Cunning Counterfeit - Natural Hide',
        ['icon'] ='econ/items/centaur/supercourier_shoulders/supercourier_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_shoulders/supercourier_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32647] = 
    {
        ['item_id'] =32647,
        ['name'] ='Cunning Counterfeit - Luxuriant Tail',
        ['icon'] ='econ/items/centaur/supercourier_tail/supercourier_tail',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_tail/supercourier_tail.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'tail',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
    [32644] = 
    {
        ['item_id'] =32644,
        ['name'] ='Cunning Counterfeit - Decorative Belt',
        ['icon'] ='econ/items/centaur/supercourier_belt/supercourier_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/centaur/supercourier_belt/supercourier_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cunning_counterfeit',
    },
}