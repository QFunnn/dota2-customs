--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [9090] = 
    {
        ['item_id'] =9090,
        ['name'] ="Lycosidae's Brood",
        ['icon'] ="econ/items/broodmother/lycosidae_back/lycosidae_back",
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/lycosidae_back/lycosidae_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_broodmother_immortal_1",
        ['sets'] ="rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_lycosidaes/bm_lycosidaes_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/broodmother/bm_lycosidaes/bm_lycosidaes_spiderlings_debuff.vpcf",
            "particles/econ/items/broodmother/bm_lycosidaes/bm_lycosidaes_web_cast.vpcf",
        },
    },
    [9091] = 
    {
        ["item_id"] = 9091,
        ["name"] = "Lycosidae's Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 1,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_spiderling_immortal_icon",
        ['sets'] = "rare",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl"
        },
    },
    [23344] = 
    {
        ['item_id'] =23344,
        ['name'] ="Limbs of Lycosidae",
        ['icon'] ="econ/items/broodmother/bm_2022_immortal_legs/bm_2022_immortal_legs",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/bm_2022_immortal_legs/bm_2022_immortal_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_broodmother_immortal_2",
        ['sets'] ="rare",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/broodmother_2022_immortal/broodmother_2022_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/broodmother/broodmother_2022_immortal/broodmother_2022_immortal_web.vpcf",
            "particles/econ/items/broodmother/broodmother_2022_immortal/broodmother_2022_immortal_web_spin_cast.vpcf",
        },
    },


    [19776] = 
    {
        ['item_id'] =19776,
        ['name'] ="Widow of the Undermount Gloom - Anterior",
        ['icon'] ="econ/items/broodmother/strangling_gloom_misc/strangling_gloom_misc",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/strangling_gloom_misc/strangling_gloom_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="widow_undermount",
    },
    [19777] = 
    {
        ['item_id'] =19777,
        ['name'] ="Widow of the Undermount Gloom - Legs",
        ['icon'] ="econ/items/broodmother/strangling_gloom_legs/strangling_gloom_legs",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/strangling_gloom_legs/strangling_gloom_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="widow_undermount",
    },
    [19779] = 
    {
        ['item_id'] =19779,
        ['name'] ="Widow of the Undermount Gloom - Head",
        ['icon'] ="econ/items/broodmother/strangling_gloom_head/strangling_gloom_head",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/strangling_gloom_head/strangling_gloom_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="widow_undermount",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_cc_2022_head/bm_cc_2022_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [19780] = 
    {
        ['item_id'] =19780,
        ['name'] ="Widow of the Undermount Gloom - Back",
        ['icon'] ="econ/items/broodmother/strangling_gloom_back/strangling_gloom_back",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/strangling_gloom_back/strangling_gloom_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="widow_undermount",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_cc_2022_back/bm_cc_2022_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },



    [13273] = 
    {
        ['item_id'] =13273,
        ['name'] ="Automaton Antiquity Back",
        ['icon'] ="econ/items/broodmother/ti9_cache_brood_mother_of_thousands_back/ti9_cache_brood_mother_of_thousands_back",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/ti9_cache_brood_mother_of_thousands_back/ti9_cache_brood_mother_of_thousands_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="automaton_antiquity",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/brood_ti9/brood_ti9_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [13270] = 
    {
        ['item_id'] =13270,
        ['name'] ="Automaton Antiquity Overgrowth",
        ['icon'] ="econ/items/broodmother/ti9_cache_brood_mother_of_thousands_misc/ti9_cache_brood_mother_of_thousands_misc",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/ti9_cache_brood_mother_of_thousands_misc/ti9_cache_brood_mother_of_thousands_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="automaton_antiquity",
    },
    [13271] = 
    {
        ['item_id'] =13271,
        ['name'] ="Automaton Antiquity Legs",
        ['icon'] ="econ/items/broodmother/ti9_cache_brood_mother_of_thousands_legs/ti9_cache_brood_mother_of_thousands_legs",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/ti9_cache_brood_mother_of_thousands_legs/ti9_cache_brood_mother_of_thousands_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="automaton_antiquity",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/brood_ti9/brood_ti9_legs_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [13272] = 
    {
        ['item_id'] =13272,
        ['name'] ="Automaton Antiquity Head",
        ['icon'] ="econ/items/broodmother/ti9_cache_brood_mother_of_thousands_head/ti9_cache_brood_mother_of_thousands_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/ti9_cache_brood_mother_of_thousands_head/ti9_cache_brood_mother_of_thousands_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="automaton_antiquity",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/brood_ti9/brood_ti9_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },

    [33378] = 
    {
        ['item_id'] =33378,
        ['name'] ="The White Widow - Head",
        ['icon'] ="econ/items/broodmother/bride_of_the_web_head/bride_of_the_web_head",
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/bride_of_the_web_head/bride_of_the_web_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="white_widow",
    },
    [33377] = 
    {
        ['item_id'] =33377,
        ['name'] ="The White Widow - Back",
        ['icon'] ="econ/items/broodmother/bride_of_the_web_back/bride_of_the_web_back",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/bride_of_the_web_back/bride_of_the_web_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="white_widow",
    },
    [33379] = 
    {
        ['item_id'] =33379,
        ['name'] ="The White Widow - Legs",
        ['icon'] ="econ/items/broodmother/bride_of_the_web_legs/bride_of_the_web_legs",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/bride_of_the_web_legs/bride_of_the_web_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="white_widow",
    },
    [33380] = 
    {
        ['item_id'] =33380,
        ['name'] ="The White Widow - Body",
        ['icon'] ="econ/items/broodmother/bride_of_the_web_misc/bride_of_the_web_misc",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/bride_of_the_web_misc/bride_of_the_web_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="white_widow",
    },

    [17915] = 
    {
        ['item_id'] =17915,
        ['name'] ="Arcane Infestation Head",
        ['icon'] ="econ/items/broodmother/witchs_grasp_head/witchs_grasp_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/witchs_grasp_head/witchs_grasp_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="arcane_infestation",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_fall20_witches_grasp/bm_fall20_witches_grasp_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_candle"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_center_head"},
                }
            },
        },
    },
    [17918] = 
    {
        ['item_id'] =17918,
        ['name'] ="Arcane Infestation Back",
        ['icon'] ="econ/items/broodmother/witchs_grasp_back/witchs_grasp_back",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/witchs_grasp_back/witchs_grasp_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="arcane_infestation",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_fall20_witches_grasp/bm_fall20_witches_grasp_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_center"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_mid"},
                }
            },
        },
    },
    [17919] = 
    {
        ['item_id'] =17919,
        ['name'] ="Arcane Infestation Candles",
        ['icon'] ="econ/items/broodmother/witchs_grasp_misc/witchs_grasp_misc",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/witchs_grasp_misc/witchs_grasp_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="arcane_infestation",
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/broodmother/bm_fall20_witches_grasp/bm_fall20_witches_grasp_misc_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_candle_01"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_candle_02"},
                }
            },
        },
    },
    [17916] = 
    {
        ['item_id'] =17916,
        ['name'] ="Arcane Infestation Legs",
        ['icon'] ="econ/items/broodmother/witchs_grasp_legs/witchs_grasp_legs",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/witchs_grasp_legs/witchs_grasp_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="arcane_infestation",
    },

    [9424] = 
    {
        ['item_id'] =9424,
        ['name'] ="Legs of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_legs/the_glacial_creeper_legs",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_legs/the_glacial_creeper_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9424, "#3a94e1"}, {22803, "#681c1c"}},
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [9425] = 
    {
        ['item_id'] =9425,
        ['name'] ="Anterior of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_misc/the_glacial_creeper_misc",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_misc/the_glacial_creeper_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9425, "#3a94e1"}, {22804, "#681c1c"}},
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [9426] = 
    {
        ['item_id'] =9426,
        ['name'] ="Abdomen of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_back/the_glacial_creeper_back",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_back/the_glacial_creeper_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9426, "#3a94e1"}, {22805, "#681c1c"}},
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [9427] = 
    {
        ['item_id'] =9427,
        ['name'] ="Eyes of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_head/the_glacial_creeper_head",
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_head/the_glacial_creeper_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{9427, "#3a94e1"}, {22827, "#681c1c"}},
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },

    [22803] = 
    {
        ['item_id'] =22803,
        ['name'] ="Winter Lineage Legs of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_legs/the_glacial_creeper_legs1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_legs/the_glacial_creeper_legs.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9424, "#3a94e1"}, {22803, "#681c1c"}},
        ['SlotType'] ="legs",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [22804] = 
    {
        ['item_id'] =22804,
        ['name'] ="Winter Lineage Anterior of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_misc/the_glacial_creeper_misc1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_misc/the_glacial_creeper_misc.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9425, "#3a94e1"}, {22804, "#681c1c"}},
        ['SlotType'] ="misc",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [22805] = 
    {
        ['item_id'] =22805,
        ['name'] ="Winter Lineage Abdomen of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_back/the_glacial_creeper_back1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_back/the_glacial_creeper_back.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9426, "#3a94e1"}, {22805, "#681c1c"}},
        ['SlotType'] ="back",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [22827] = 
    {
        ['item_id'] =22827,
        ['name'] ="Winter Lineage Eyes of the Abysm",
        ['icon'] ="econ/items/broodmother/the_glacial_creeper_head/the_glacial_creeper_head1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ="models/items/broodmother/the_glacial_creeper_head/the_glacial_creeper_head.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{9427, "#3a94e1"}, {22827, "#681c1c"}},
        ['SlotType'] ="head",
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] ="brood_abysm",
    },
    [8862] = 
    {
        ["item_id"] = 8862,
        ["name"] = "Amber Queen's Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/amber_queen_spiderling_2/amber_queen_spiderling_2_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/amber_queen_spiderling_2/amber_queen_spiderling_2.vmdl"
        },
    },
    [8288] = 
    {
        ["item_id"] = 8288,
        ["name"] = "Arachnarok Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/araknarok_broodmother_araknarok_spiderling/araknarok_broodmother_araknarok_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/araknarok_broodmother_araknarok_spiderling/araknarok_broodmother_araknarok_spiderling.vmdl"
        },
    },
    [33381] = 
    {
        ["item_id"] = 33381,
        ["name"] = "The White Widow - Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/bride_of_the_web_spiderling/bride_of_the_web_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/bride_of_the_web_spiderling/bride_of_the_web_spiderling.vmdl"
        },
    },
    [13182] = 
    {
        ["item_id"] = 13182,
        ["name"] = "Malevolent Mother Malevoling",
        ["icon"] = "econ/items/broodmother/spiderling/dplus_malevolent_mother_malevoling/dplus_malevolent_mother_malevoling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/dplus_malevolent_mother_malevoling/dplus_malevolent_mother_malevoling.vmdl"
        },
    },
    [7939] = 
    {
        ["item_id"] = 7939,
        ["name"] = "Spidering of the Glutton's Larder",
        ["icon"] = "econ/items/broodmother/spiderling/elder_blood_heir_of_elder_blood/elder_blood_heir_of_elder_blood_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/elder_blood_heir_of_elder_blood/elder_blood_heir_of_elder_blood.vmdl"
        },
    },
    [23459] = 
    {
        ["item_id"] = 23459,
        ["name"] = "Volcanic Sanctuary - Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/firemother_spiderling/firemother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/firemother_firemother_spiderling_ti8_3_styles/firemother_firemother_spiderling_ti8_3_styles.vmdl"
        },
    },
    [9091] = 
    {
        ["item_id"] = 9091,
        ["name"] = "Lycosidae's Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 1000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        --["Modifier"] = "modifier_spiderling_immortal_icon",
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/lycosidae_spiderling/lycosidae_spiderling.vmdl"
        },
    },
    [5900] = 
    {
        ["item_id"] = 5900,
        ["name"] = "Perceptive Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/perceptive_spiderling/perceptive_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/perceptive_spiderling/perceptive_spiderling.vmdl"
        },
    },
    [27519] = 
    {
        ["item_id"] = 27519,
        ["name"] = "Ruby-ridged Recluse - Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/petrified_terror_spiderling/petrified_terror_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/petrified_terror_spiderling/petrified_terror_spiderling.vmdl"
        },
    },
    [6030] = 
    {
        ["item_id"] = 6030,
        ["name"] = "Skittering Lotus",
        ["icon"] = "econ/items/broodmother/spiderling/spiderling_dlotus_red/spiderling_dlotus_red_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/spiderling_dlotus_red/spiderling_dlotus_red.vmdl"
        },
    },
    [19775] = 
    {
        ["item_id"] = 19775,
        ["name"] = "Widow of the Undermount Gloom - Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/strangling_gloom_spiderling/strangling_gloom_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/strangling_gloom_spiderling/strangling_gloom_spiderling.vmdl"
        },
    },
    [22802] = 
    {
        ["item_id"] = 22802,
        ["name"] = "Winter Lineage Creepling of the Abysm",
        ["icon"] = "econ/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling_dpc_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling.vmdl"
        },
    },
    [22802] = 
    {
        ["item_id"] = 22802,
        ["name"] = "Winter Lineage Creepling of the Abysm",
        ["icon"] = "econ/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling_dpc_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/the_glacial_creeper_creepling/the_glacial_creeper_creepling_dpc.vmdl"
        },
    },
    [7241] = 
    {
        ["item_id"] = 7241,
        ["name"] = "Thistle Crawler",
        ["icon"] = "econ/items/broodmother/spiderling/thistle_crawler/thistle_crawler_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/thistle_crawler/thistle_crawler.vmdl"
        },
    },
    [9808] = 
    {
        ["item_id"] = 9808,
        ["name"] = "Spiderling of the Silken Queen",
        ["icon"] = "econ/items/broodmother/spiderling/ti8_brood_the_great_arachne_spiderling/ti8_brood_the_great_arachne_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/ti8_brood_the_great_arachne_spiderling/ti8_brood_the_great_arachne_spiderling.vmdl"
        },
    },
    [13269] = 
    {
        ["item_id"] = 13269,
        ["name"] = "Automaton Antiquity Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/ti9_cache_brood_mother_of_thousands_spiderling/ti9_cache_brood_mother_of_thousands_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/ti9_cache_brood_mother_of_thousands_spiderling/ti9_cache_brood_mother_of_thousands_spiderling.vmdl"
        },
    },
    [13385] = 
    {
        ["item_id"] = 13385,
        ["name"] = "TI9 Cache Brood Venomous Caressin Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/venomous_caressin_spiderling/venomous_caressin_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/venomous_caressin_spiderling/venomous_caressin_spiderling.vmdl"
        },
    },
    [7619] = 
    {
        ["item_id"] = 7619,
        ["name"] = "Virulent Matriarch's Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/virulent_matriarchs_spiderling/virulent_matriarchs_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/virulent_matriarchs_spiderling/virulent_matriarchs_spiderling.vmdl"
        },
    },
    [17920] = 
    {
        ["item_id"] = 17920,
        ["name"] = "Arcane Infestation Spiderling",
        ["icon"] = "econ/items/broodmother/spiderling/witchs_grasp_spiderling/witchs_grasp_spiderling_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/witchs_grasp_spiderling/witchs_grasp_spiderling.vmdl"
        },
    },
    [34296] = 
    {
        ["item_id"] = 34296,
        ["name"] = "The Skittering Plague",
        ["icon"] = "econ/items/broodmother/spiderling/broodmother_spiderling_01/broodmother_spiderling_01_npc_dota_broodmother_spiderling",
        ["price"] = 800,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "brood_spider",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = nil,
        ['sets'] = "spiderlings",
        ["OtherModelsPrecache"] =
        {
            "models/items/broodmother/spiderling/broodmother_spiderling_01/broodmother_spiderling_01.vmdl"
        },
    },

    [34307] = {
    ['item_id'] =34307,
    ['name'] ='The Mournless Mask',
    ['icon'] ='econ/items/broodmother/broodmother_head_01/broodmother_head_01',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/broodmother/purgatory_queen/brood_purgatory_queen_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'golden_orbweaver',
    },
    [36239] = {
    ['item_id'] =36239,
    ['name'] ='The Living Ingot',
    ['icon'] ='econ/items/broodmother/broodmother_abdomen_02/broodmother_abdomen_02',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/broodmother/purgatory_queen/brood_purgatory_queen_back.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'back',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'golden_orbweaver',
    },
    [36242] = {
    ['item_id'] =36242,
    ['name'] ='The Gilded Tarsi',
    ['icon'] ='econ/items/broodmother/broodmother_legs_01/broodmother_legs_01',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/broodmother/purgatory_queen/brood_purgatory_queen_legs.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'legs',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'golden_orbweaver',
    },
    [36241] = {
    ['item_id'] =36241,
    ['name'] ='The Captives Crown',
    ['icon'] ='econ/items/broodmother/broodmother_misc_01/broodmother_misc_01',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/broodmother/purgatory_queen/brood_purgatory_queen_misc.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'misc',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'golden_orbweaver',
    },
}