--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [8005] = 
    {
        ['item_id'] =8005,
        ['name'] ='Latticean Shards',
        ['icon'] ='econ/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{8005, "#79c3f7"}, {8032, "#b22e2e"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_ti6_immortal_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_immortal_ambient_ti6.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6.vpcf",
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_hit_ti6.vpcf",
        }
    },
    [8021] = 
    {
        ['item_id'] =8021,
        ['name'] ='Golden Latticean Shards',
        ['icon'] ='econ/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model1',
        ['price'] = 4000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_ti6_immortal_custom_2",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_assassin_ti6_gold/nyx_assassin_immortal_ambient_ti6_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_ti6_gold.vpcf",
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_hit_ti6_gold.vpcf",
        }
    },
    [8032] = 
    {
        ['item_id'] =8032,
        ['name'] ='Latticean Shards of the Crimson Witness',
        ['icon'] ='econ/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "witness",
        ['ItemModel'] ='models/items/nerubian_assassin/ti6_immortal/mesh/ti6_immortal_nyx_weapon_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{8005, "#79c3f7"}, {8032, "#b22e2e"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_ti6_immortal_custom_3",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_immortal_witness_ambient_ti6.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_claw_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6_witness/nyx_assassin_impale_ti6_witness.vpcf",
            "particles/econ/items/nyx_assassin/nyx_assassin_ti6/nyx_assassin_impale_hit_ti6.vpcf",
        }
    },
    [12957] = 
    {
        ['item_id'] =12957,
        ['name'] ='Latticean Hierarchy',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti9_immortal_back/nyx_ti9_immortal_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti9_immortal_back/nyx_ti9_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_ti9_immortal_back_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_l_outer"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_r_outer"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_carapace.vpcf",
            "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_carapace_hit.vpcf",
        },
    },
    [13574] = 
    {
        ['item_id'] =13574,
        ['name'] ='Crimson Latticean Hierarchy',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti9_immortal_back/nyx_ti9_immortal_back1',
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti9_immortal_back/nyx_ti9_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_ti9_immortal_back_custom_2",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_crimson_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_l_outer"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crystal_r_outer"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_crimson_carapace.vpcf",
            "particles/econ/items/nyx_assassin/nyx_ti9_immortal/nyx_ti9_carapace_crimson_hit.vpcf",
        },
    },
    [5345] = 
    {
        ['item_id'] =5345,
        ['name'] ='Nyx Assassins Dagon',
        ['icon'] ='econ/items/nerubian_assassin/nyx_dagon',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_dagon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_nyx_assassin_dagon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_assassin_dagon_ambient/nyx_assassin_dagon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem"
                    },
                }
            },
        },
    },
    [13754] = 
    {
        ['item_id'] =13754,
        ['name'] ='Carapace of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{13754, "#d9813b"}, {137541, "#7ec3f3"}, {137542, "#3d5bcc"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_sand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        }
    },
    [13751] = 
    {
        ['item_id'] =13751,
        ['name'] ='Strike of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{13751, "#d9813b"}, {137511, "#7ec3f3"}, {137512, "#3d5bcc"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_l_fx"
                    },
                }
            },
        },
    },
    [13752] = 
    {
        ['item_id'] =13752,
        ['name'] ='Crown of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{13752, "#d9813b"}, {137521, "#7ec3f3"}, {137522, "#3d5bcc"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
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
                        "attach_head_fx"
                    },
                }
            },
        },
    },
    [13753] = 
    {
        ['item_id'] =13753,
        ['name'] ='Armor of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{13753, "#d9813b"}, {137531, "#7ec3f3"}, {137532, "#3d5bcc"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_misc.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [137541] = 
    {
        ["dota_id"] = 13754,
        ["ItemStyle"] = "1",
        ['item_id'] =137541,
        ['name'] ='Carapace of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13754, "#d9813b"}, {137541, "#7ec3f3"}, {137542, "#3d5bcc"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_2ndstyle_sand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        }
    },
    [137511] = 
    {
        ['item_id'] =137511,
        ['name'] ='Strike of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13751, "#d9813b"}, {137511, "#7ec3f3"}, {137512, "#3d5bcc"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_weapon_2ndstyle.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_l_fx"
                    },
                }
            },
        },
    },
    [137521] = 
    {
        ["dota_id"] = 13752,
        ["ItemStyle"] = "1",
        ['item_id'] =137521,
        ['name'] ='Crown of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13752, "#d9813b"}, {137521, "#7ec3f3"}, {137522, "#3d5bcc"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_2ndstyle_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
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
                        "attach_head_fx"
                    },
                }
            },
        },
    },
    [137531] = 
    {
        ["dota_id"] = 13753,
        ["ItemStyle"] = "1",
        ['item_id'] =137531,
        ['name'] ='Armor of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc_style1',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13753, "#d9813b"}, {137531, "#7ec3f3"}, {137532, "#3d5bcc"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_style2_misc.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [137542] = 
    {
        ["dota_id"] = 13754,
        ["ItemStyle"] = "2",
        ['item_id'] =137542,
        ['name'] ='Carapace of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_back/nyx_ti10_cavern_crawl_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13754, "#d9813b"}, {137541, "#7ec3f3"}, {137542, "#3d5bcc"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_sand_style3.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
            },
        }
    },
    [137512] = 
    {
        ["dota_id"] = 13751,
        ["ItemStyle"] = "2",
        ['item_id'] =137512,
        ['name'] ='Strike of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_weapon/nyx_ti10_cavern_crawl_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13751, "#d9813b"}, {137511, "#7ec3f3"}, {137512, "#3d5bcc"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_weapon_style3.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_r_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_l_fx"
                    },
                }
            },
        },
    },
    [137522] = 
    {
        ["dota_id"] = 13752,
        ["ItemStyle"] = "2",
        ['item_id'] =137522,
        ['name'] ='Crown of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_head/nyx_ti10_cavern_crawl_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13752, "#d9813b"}, {137521, "#7ec3f3"}, {137522, "#3d5bcc"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_head_style3.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
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
                        "attach_head_fx"
                    },
                }
            },
        },
    },
    [137532] = 
    {
        ["dota_id"] = 13753,
        ["ItemStyle"] = "2",
        ['item_id'] =137532,
        ['name'] ='Armor of Gilded Worship',
        ['icon'] ='econ/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc_style2',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/nyx_ti10_cavern_crawl_misc/nyx_ti10_cavern_crawl_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13753, "#d9813b"}, {137531, "#7ec3f3"}, {137532, "#3d5bcc"}},
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'gilded_worship',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/nyx_ti10_cavern_crawl/nyx_ti10_misc_style3.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            },
        },
    },
    [9440] = 
    {
        ['item_id'] =9440,
        ['name'] ='Tail of the Chitinous Stalker',
        ['icon'] ='econ/items/nerubian_assassin/reef_stalker_exoskeleton_misc/reef_stalker_exoskeleton_misc',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/reef_stalker_exoskeleton_misc/reef_stalker_exoskeleton_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'chitinous_stalker',
    },
    [9441] = 
    {
        ['item_id'] =9441,
        ['name'] ='Oculi of the Chitinous Stalker',
        ['icon'] ='econ/items/nerubian_assassin/reef_stalker_exoskeleton_head/reef_stalker_exoskeleton_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/reef_stalker_exoskeleton_head/reef_stalker_exoskeleton_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'chitinous_stalker',
    },
    [9447] = 
    {
        ['item_id'] =9447,
        ['name'] ='Pincers of the Chitinous Stalker',
        ['icon'] ='econ/items/nerubian_assassin/reef_stalker_exoskeleton_weapon/reef_stalker_exoskeleton_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/reef_stalker_exoskeleton_weapon/reef_stalker_exoskeleton_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'chitinous_stalker',
    },
    [9448] = 
    {
        ['item_id'] =9448,
        ['name'] ='Armor of the Chitinous Stalker',
        ['icon'] ='econ/items/nerubian_assassin/reef_stalker_exoskeleton_back/reef_stalker_exoskeleton_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/reef_stalker_exoskeleton_back/reef_stalker_exoskeleton_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'chitinous_stalker',
    },
    [28304] = 
    {
        ['item_id'] =28304,
        ['name'] ='Mecha Nyx - Back',
        ['icon'] ='econ/items/nerubian_assassin/2023the_one_back/2023the_one_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/2023the_one_back/2023the_one_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mecha_nyx',
    },
    [28306] = 
    {
        ['item_id'] =28306,
        ['name'] ='Mecha Nyx - Misc',
        ['icon'] ='econ/items/nerubian_assassin/2023the_one_misc/2023the_one_misc',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/2023the_one_misc/2023the_one_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mecha_nyx',
    },

    [28305] = 
    {
        ['item_id'] =28305,
        ['name'] ='Mecha Nyx - Head',
        ['icon'] ='econ/items/nerubian_assassin/2023the_one_head/2023the_one_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/2023the_one_head/2023the_one_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mecha_nyx',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/nyx_assassin/the_one/the_one_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye"
                    },
                }
            },
        },
    },
    [28307] = 
    {
        ['item_id'] =28307,
        ['name'] ='Mecha Nyx - Weapon',
        ['icon'] ='econ/items/nerubian_assassin/2023the_one_weapon/2023the_one_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/2023the_one_weapon/2023the_one_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'mecha_nyx',
    },
    [17963] = 
    {
        ['item_id'] =17963,
        ['name'] ='Bottomfeeder Piercers',
        ['icon'] ='econ/items/nerubian_assassin/crawler_from_the_deep_weapon/crawler_from_the_deep_weapon',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/crawler_from_the_deep_weapon/crawler_from_the_deep_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bottomfeeder_nyx',
    },
    [17964] = 
    {
        ['item_id'] =17964,
        ['name'] ='Bottomfeeder Jaws',
        ['icon'] ='econ/items/nerubian_assassin/crawler_from_the_deep_head/crawler_from_the_deep_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/crawler_from_the_deep_head/crawler_from_the_deep_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bottomfeeder_nyx',
    },
    [17965] = 
    {
        ['item_id'] =17965,
        ['name'] ='Bottomfeeder Carapace',
        ['icon'] ='econ/items/nerubian_assassin/crawler_from_the_deep_back/crawler_from_the_deep_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/crawler_from_the_deep_back/crawler_from_the_deep_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bottomfeeder_nyx',
    },
    [17966] = 
    {
        ['item_id'] =17966,
        ['name'] ='Bottomfeeder Abdomen',
        ['icon'] ='econ/items/nerubian_assassin/crawler_from_the_deep_misc/crawler_from_the_deep_misc',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/crawler_from_the_deep_misc/crawler_from_the_deep_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'bottomfeeder_nyx',
    },
    [9079] = 
    {
        ['item_id'] =9079,
        ['name'] ='Claws of Kaktos',
        ['icon'] ='econ/items/nerubian_assassin/burnichus_sicarius_weapon/burnichus_sicarius_weapon',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/burnichus_sicarius_weapon/burnichus_sicarius_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'kaktos_nyx',
    },
    [9080] = 
    {
        ['item_id'] =9080,
        ['name'] ='Shell of Kaktos',
        ['icon'] ='econ/items/nerubian_assassin/burnichus_sicarius_misc/burnichus_sicarius_misc',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/burnichus_sicarius_misc/burnichus_sicarius_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'kaktos_nyx',
    },
    [9081] = 
    {
        ['item_id'] =9081,
        ['name'] ='Jaw of Kaktos',
        ['icon'] ='econ/items/nerubian_assassin/burnichus_sicarius_head/burnichus_sicarius_head',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/burnichus_sicarius_head/burnichus_sicarius_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'kaktos_nyx',
    },
    [9082] = 
    {
        ['item_id'] =9082,
        ['name'] ='Carapace of Kaktos',
        ['icon'] ='econ/items/nerubian_assassin/burnichus_sicarius_back/burnichus_sicarius_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/nerubian_assassin/burnichus_sicarius_back/burnichus_sicarius_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'kaktos_nyx',
    },

    [26004] = {
    ['item_id'] =26004,
    ['name'] ='The Hivestalkers',
    ['icon'] ='econ/items/nerubian_assassin/nyx_amber_assassin_back/nyx_amber_assassin_back',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/nerubian_assassin/nyx_amber_assassin_back/nyx_amber_assassin_back.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'back',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'amber_apis',
    },
    [26005] = {
    ['item_id'] =26005,
    ['name'] ='The Forgeless Blade',
    ['icon'] ='econ/items/nerubian_assassin/nyx_amber_assassin_head/nyx_amber_assassin_head',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/nerubian_assassin/nyx_amber_assassin_head/nyx_amber_assassin_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'amber_apis',
    },
    [26036] = {
    ['item_id'] =26036,
    ['name'] ='The Queens Carcanet',
    ['icon'] ='econ/items/nerubian_assassin/nyx_amber_assassin_misc/nyx_amber_assassin_misc',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/nerubian_assassin/nyx_amber_assassin_misc/nyx_amber_assassin_misc.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'misc',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'amber_apis',
    },
    [26037] = {
    ['item_id'] =26037,
    ['name'] ='The Amber Unguis',
    ['icon'] ='econ/items/nerubian_assassin/nyx_amber_assassin_weapon/nyx_amber_assassin_weapon',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/nerubian_assassin/nyx_amber_assassin_weapon/nyx_amber_assassin_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'amber_apis',
    },
}