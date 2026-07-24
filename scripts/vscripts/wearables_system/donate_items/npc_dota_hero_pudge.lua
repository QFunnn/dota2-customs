--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [13508] = 
    {
            ['item_id'] =13508,
            ['name'] ='Dapper Disguise Umbrella',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_weapon/pudge_dapper_disguise_weapon',
            ['price'] = 1200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_weapon/pudge_dapper_disguise_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_ti9_cache/pudge_ti9_cache_weapon_ambient.vpcf",
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
                    }
                },
            },
    },
    [13509] = 
    {
        ['item_id'] =13509,
        ['name'] ='Dapper Disguise Cleaver',
        ['icon'] ='econ/items/pudge/pudge_dapper_disguise_off_hand/pudge_dapper_disguise_off_hand',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_off_hand/pudge_dapper_disguise_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_dapper_disguise',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_ti9_cache/pudge_ti9_cache_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [13510] = 
    {
            ['item_id'] =13510,
            ['name'] ='Dapper Disguise Belt',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_belt/pudge_dapper_disguise_belt',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_belt/pudge_dapper_disguise_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
    },
    [13511] = 
    {
            ['item_id'] =13511,
            ['name'] ='Dapper Disguise Jacket',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_back/pudge_dapper_disguise_back',
            ['price'] = 800,
            ['HeroModel'] = "models/heroes/pudge/pudge.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "0",
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_back/pudge_dapper_disguise_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
    },
    [13513] = 
    {
            ['item_id'] =13513,
            ['name'] ='Dapper Disguise Hat',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_head/pudge_dapper_disguise_head',
            ['price'] = 1200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_head/pudge_dapper_disguise_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_ti9_cache/pudge_ti9_cache_head_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                        [1] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_hat"
                        },
                    }
                },
            },
    },
    [13515] = 
    {
            ['item_id'] =13515,
            ['name'] ='Dapper Disguise Shoulder',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_shoulder/pudge_dapper_disguise_shoulder',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_shoulder/pudge_dapper_disguise_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
    },
    [13514] = 
    {
            ['item_id'] =13514,
            ['name'] ='Dapper Disguise Arms',
            ['icon'] ='econ/items/pudge/pudge_dapper_disguise_arms/pudge_dapper_disguise_arms',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_dapper_disguise_arms/pudge_dapper_disguise_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_dapper_disguise',
    },

    [6007] = 
    {
            ['item_id'] =6007,
            ['name'] ='Murder Mask',
            ['icon'] ='econ/items/pudge/ftp_dendi_head/ftp_dendi_head',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_head/ftp_dendi_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6204] = 
    {
            ['item_id'] =6204,
            ['name'] ='Dendi Doll',
            ['icon'] ='econ/items/pudge/ftp_dendi_belt/ftp_dendi_belt',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_belt/ftp_dendi_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6202] = 
    {
            ['item_id'] =6202,
            ['name'] ='Gauntlet of Dark Feathers',
            ['icon'] ='econ/items/pudge/ftp_dendi_arm/ftp_dendi_arm',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_arm/ftp_dendi_arm.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6203] = 
    {
            ['item_id'] =6203,
            ['name'] ='Armor of the Black Bird',
            ['icon'] ='econ/items/pudge/ftp_dendi_shoulder/ftp_dendi_shoulder',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_shoulder/ftp_dendi_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6212] = 
    {
            ['item_id'] =6212,
            ['name'] ='The Crow Eater',
            ['icon'] ='econ/items/pudge/ftp_dendi_offhand/ftp_dendi_offhand',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_offhand/ftp_dendi_offhand.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'offhand_weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6116] = 
    {
            ['item_id'] =6116,
            ['name'] ='Talon Edge',
            ['icon'] ='econ/items/pudge/ftp_dendi_weapon/ftp_dendi_weapon',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/ftp_dendi_weapon/ftp_dendi_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
    },
    [6115] = 
    {
            ['item_id'] =6115,
            ['name'] ='Pauldron Perch',
            ['icon'] ='econ/items/pudge/ftp_dendi_back/ftp_dendi_back',
            ['price'] = 600,
            ['HeroModel'] = "models/heroes/pudge/pudge.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "0",
            ['ItemModel'] ='models/items/pudge/ftp_dendi_back/ftp_dendi_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'ftp_dendi',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_ftp_crow/pudge_ftp_back_crow.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_shoulder"
                        },
                    }
                },
            },
    },
    [26083] = 
    {
            ['item_id'] =26083,
            ['name'] ='Cursed Cryptbreaker - Belt',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_belt/pudge_forbidden_regrowth_belt',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_belt/pudge_forbidden_regrowth_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
    },
    [26087] = 
    {
            ['item_id'] =26087,
            ['name'] ='Cursed Cryptbreaker - Shoulder',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_shoulder/pudge_forbidden_regrowth_shoulder',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_shoulder/pudge_forbidden_regrowth_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
    },
    [26086] = 
    {
            ['item_id'] =26086,
            ['name'] ='Cursed Cryptbreaker - Off-Hand Weapon',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_offhand_weapon/pudge_forbidden_regrowth_offhand_weapon',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_offhand_weapon/pudge_forbidden_regrowth_offhand_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'offhand_weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
    },
    [26085] = 
    {
            ['item_id'] =26085,
            ['name'] ='Cursed Cryptbreaker - Weapon',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_weapon/pudge_forbidden_regrowth_weapon',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_weapon/pudge_forbidden_regrowth_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
    },
    [26084] = {
            ['item_id'] =26084,
            ['name'] ='Cursed Cryptbreaker - Head',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_head/pudge_forbidden_regrowth_head',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_head/pudge_forbidden_regrowth_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_2022_forbidden_head/pudge_2022_forbidden_head_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                        [5] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "head_gem"
                        },
                        [6] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "head_gem"
                        },
                        [7] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "eye"
                        },
                    }
                },
            },
    },
    [26082] = 
    {
            ['item_id'] =26082,
            ['name'] ='Cursed Cryptbreaker - Back',
            ['icon'] ='econ/items/pudge/pudge_forbidden_regrowth_back/pudge_forbidden_regrowth_back',
            ['price'] = 600,
            ['HeroModel'] = "models/heroes/pudge/pudge.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "0",
            ['ItemModel'] ='models/items/pudge/pudge_forbidden_regrowth_back/pudge_forbidden_regrowth_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'pudge_forbidden',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_2022_forbidden_back/pudge_2022_forbidden_back_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [7311] = 
    {
            ['item_id'] =7311,
            ['name'] ='Doomsday Ripper Arms',
            ['icon'] ='econ/items/pudge/doomsday_ripper_arms/doomsday_ripper_arms',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_arms/doomsday_ripper_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7945] =
    {
            ['item_id'] =7945,
            ['name'] ='Doomsday Ripper Weapon',
            ['icon'] ='econ/items/pudge/doomsday_ripper_weapon/doomsday_ripper_weapon',
            ['price'] = 200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_weapon/doomsday_ripper_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7371] = 
    {
            ['item_id'] =7371,
            ['name'] ='Doomsday Ripper Off-Hand',
            ['icon'] ='econ/items/pudge/doomsday_ripper_off_hand/doomsday_ripper_off_hand',
            ['price'] = 200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_off_hand/doomsday_ripper_off_hand.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'offhand_weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7376] = 
    {
            ['item_id'] =7376,
            ['name'] ='Doomsday Ripper Shoulder',
            ['icon'] ='econ/items/pudge/doomsday_ripper_shoulder/doomsday_ripper_shoulder',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_shoulder/doomsday_ripper_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7320] = 
    {
            ['item_id'] =7320,
            ['name'] ='Doomsday Ripper Back',
            ['icon'] ='econ/items/pudge/doomsday_ripper_back/doomsday_ripper_back',
            ['price'] = 100,
            ['HeroModel'] = "models/heroes/pudge/pudge.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "0",
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_back/doomsday_ripper_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7362] = 
    {
            ['item_id'] =7362,
            ['name'] ='Doomsday Ripper Belt',
            ['icon'] ='econ/items/pudge/doomsday_ripper_belt/doomsday_ripper_belt',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_belt/doomsday_ripper_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [7363] = 
    {
            ['item_id'] =7363,
            ['name'] ='Doomsday Ripper Head',
            ['icon'] ='econ/items/pudge/doomsday_ripper_head/doomsday_ripper_head',
            ['price'] = 200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/doomsday_ripper_head/doomsday_ripper_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'doomsday_ripper',
    },
    [14033] = 
    {
            ['item_id'] =14033,
            ['name'] ='Mindless Slaughter - Hook',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_weapon/nightmare_scarecrow_weapon',
            ['price'] = 1200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_weapon/nightmare_scarecrow_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_nightmare_scarecrow/pudge_nightmare_scarecrow_weapon.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [14034] = 
    {
            ['item_id'] =14034,
            ['name'] ='Mindless Slaughter - Shoulder',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_shoulder/nightmare_scarecrow_shoulder',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_shoulder/nightmare_scarecrow_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
    },
    [14035] = 
    {
            ['item_id'] =14035,
            ['name'] ='Mindless Slaughter - Off-Hand',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_off_hand/nightmare_scarecrow_off_hand',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_off_hand/nightmare_scarecrow_off_hand.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'offhand_weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_nightmare_scarecrow/pudge_nightmare_scarecrow_offhand.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },  
    },
    [14036] = 
    {
            ['item_id'] =14036,
            ['name'] ='Mindless Slaughter - Mask',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_head/nightmare_scarecrow_head',
            ['price'] = 1200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_head/nightmare_scarecrow_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_nightmare_scarecrow/pudge_nightmare_scarecrow_head.vpcf",
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
                    }
                },
            },
    },
    [14038] = 
    {
            ['item_id'] =14038,
            ['name'] ='Mindless Slaughter - Back',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_back/nightmare_scarecrow_back',
            ['price'] = 800,
            ['HeroModel'] = "models/heroes/pudge/pudge.vmdl",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "0",
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_back/nightmare_scarecrow_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',   
    },
    [14039] = 
    {
            ['item_id'] =14039,
            ['name'] ='Mindless Slaughter - Arms',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_arms/nightmare_scarecrow_arms',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_arms/nightmare_scarecrow_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
    },
    [14037] = 
    {
            ['item_id'] =14037,
            ['name'] ='Mindless Slaughter - Belt',
            ['icon'] ='econ/items/pudge/nightmare_scarecrow_belt/nightmare_scarecrow_belt',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/nightmare_scarecrow_belt/nightmare_scarecrow_belt.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'belt',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'mindless_slaughter',
            ['ParticlesItems'] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/pudge/pudge_nightmare_scarecrow/pudge_nightmare_scarecrow_belt.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            }, 
    },
    [4007] = 
    {
            ['item_id'] =4007,
            ['name'] ='Dragonclaw Hook',
            ['icon'] ='econ/items/pudge/pudge_skeleton_hook_body',
            ['price'] = 5000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/pudge/pudge_skeleton_hook_body.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = "modifier_dragonclaw_hook_custom",
            ['sets'] = 'rare',
            ["ParticlesSkills"] =
            {
                "particles/econ/items/pudge/pudge_dragonclaw/pudge_meathook_dragonclaw.vpcf"
            }
    },
    [13788] = 
    {
        ['item_id'] =13788,
        ['name'] ='The Abscesserator',
        ['icon'] ='econ/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_hook',
        ['price'] = 2500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_hook.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{13788, "#c82434"}, {137881, "#7bdf3b"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_hook_ti10_claws_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_ti10_immortal/pudge_ti10_immortal_claw_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_1"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_2"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_3"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_forearm"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_ti10_immortal/pudge_ti10_immortal_meathook.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_bracer_model.vmdl",
        }
    },
    [137881] = 
    {
        ["dota_id"] = 13788,
        ["ItemStyle"] = "1",
        ['item_id'] =137881,
        ['name'] ='The Abscesserator',
        ['icon'] ='econ/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_hook_style1',
        ['price'] = 2500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_hook.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{13788, "#c82434"}, {137881, "#7bdf3b"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_hook_ti10_claws_custom_green",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_ti10_immortal/pudge_ti10_immortal_claw_ambient_arcana_green.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_1"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_2"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_claw_3"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_forearm"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_ti10_immortal/pudge_ti10_immortal_meathook_arcana_green.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge/ti10_immortal_armhook/pudge_ti10_immortal_arm_bracer_model.vmdl",
        }
    },
    [6458] = 
    {
        ['item_id'] =6458,
        ['name'] ='Scorching Talon',
        ['icon'] ='econ/items/pudge/scorching_talon/scorching_talon',
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/scorching_talon/scorching_talon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_scorching_talon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_scorching_talon/pudge_scorching_talon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hook", "hero",
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_scorching_talon/pudge_scorching_talon_meathook.vpcf"
        }
    },
    [9231] = 
    {
        ['item_id'] =9231,
        ['name'] ='Scavenging Guttleslug',
        ['icon'] ='econ/items/pudge/immortal_arm/immortal_arm',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/immortal_arm/immortal_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_immortal_arm_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [7742] = 
    {
        ['item_id'] =7742,
        ['name'] ='Golden Scavenging Guttleslug',
        ['icon'] ='econ/items/pudge/immortal_arm/immortal_arm1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] ='models/items/pudge/immortal_arm/immortal_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_immortal_arm_custom_golden",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_ambient_gold.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_immortal_arm/pudge_immortal_arm_rot_gold.vpcf"
        }
    },
    [7756] = 
    {
        ['item_id'] =7756,
        ['name'] ='Feast of Abscession',
        ['icon'] ='econ/items/pudge/arcana/pudge_arcana',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/pudge/arcana/pudge_arcana_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['MaterialGroupItem'] = nil,
        ['ItemModel'] = "models/development/invisiblebox.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7756, "#c82434"}, {77561, "#7bdf3b"}},
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_arcana_custom",
        ['sets'] = 'pudge_arcana',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
        }
    },
    [77561] = 
    {
        ["dota_id"] = 7756,
        ["ItemStyle"] = "1",
        ['item_id'] =77561,
        ['name'] ='Feast of Abscession',
        ['icon'] ='econ/items/pudge/arcana/pudge_arcana_style1',
        ['price'] = 10000,
        ['HeroModel'] = "models/items/pudge/arcana/pudge_arcana_base.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['MaterialGroupItem'] = nil,
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] = "models/development/invisiblebox.vmdl",
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7756, "#c82434"}, {77561, "#7bdf3b"}},
        ['SlotType'] = 'hero_base',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_arcana_custom_green",
        ['sets'] = 'pudge_arcana',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/pudge_arcana/pudge_arcana_dismember_default.vpcf"
        }
    },
    [29687] = 
    {
        ['item_id'] =29687,
        ['name'] ='Feast of Abscession',
        ['icon'] ='econ/items/pudge/arcana/pudge_arcana_back',
        ['price'] = 0,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "0",
        ['ItemModel'] ='models/items/pudge/arcana/pudge_arcana_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        --['OtherItemsBundle'] = {{29687, "#c82434"}, {296871, "#7bdf3b"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_red_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hook_l", "hero",
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hook_r", "hero",
                    },
                }
            },
        },
    },
    [296871] = 
    {
        ["dota_id"] = 29687,
        ["ItemStyle"] = "1",
        ['item_id'] =296871,
        ['name'] ='Feast of Abscession',
        ['icon'] ='econ/items/pudge/arcana/pudge_arcana_back',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ['BodyGroup'] = "arcana",
        ['BodyGroupStyle'] = 2,
        ['ItemModel'] ='models/items/pudge/arcana/pudge_arcana_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        --['OtherItemsBundle'] = {{29687, "#c82434"}, {296871, "#7bdf3b"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_arcana',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_arcana/pudge_arcana_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hook_l", "hero",
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hook_r", "hero",
                    },
                }
            },
        },
    },
    [999251] = 
    {
        ["dota_id"] = 13786,
        ['item_id'] =999251,
        ['name'] ='The Toy Butcher',
        ['icon'] ='econ/heroes/pudge_cute/pudge_cute',
        ['price'] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/pudge_cute/pudge_cute.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ["is_persona_item"] = 1,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_persona_custom",
        ['sets'] = 'rare',
        ['persona'] = 1,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_pudge_cute/pudge_cute_meathook.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/heroes/pudge_cute/pudge_cute_offhand.vmdl",
            "models/heroes/pudge_cute/pudge_cute_hair.vmdl",
            "models/heroes/pudge_cute/pudge_cute_costume.vmdl",
            "models/heroes/pudge_cute/pudge_cute_arms.vmdl",
            "models/heroes/pudge_cute/pudge_cute_weapon.vmdl",
        },
    },
    [999252] = 
    {
        ['item_id'] =999252,
        ['name'] ='Doll of the Dead',
        ['icon'] ='econ/sets/dota_item_doll_of_the_dead',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/pudge_cute/pudge_cute.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_persona_custom_1",
        ['sets'] = 'pudge_persona',
        ['persona'] = 2,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_pudge_cute/pudge_cute_calavera_meathook.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_offhand.vmdl",
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_hair.vmdl",
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_arms.vmdl",
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_costume.vmdl",
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_weapon.vmdl",
            "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_handle.vmdl",
        },
    },
    [999253] = 
    {
        ['item_id'] =999253,
        ['name'] ='Frosty the Sew-Man',
        ['icon'] ='econ/loading_screens/frostivus2023_toypudge',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/pudge_cute/pudge_cute.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_persona_custom_2",
        ['sets'] = 'pudge_persona',
        ['persona'] = 3,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_pudge_cute/pudge_cute_frostivus_meathook.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hair.vmdl",
            "models/heroes/pudge_cute/pudge_cute_offhand.vmdl",
            "models/heroes/pudge_cute/pudge_cute_costume.vmdl",
            "models/heroes/pudge_cute/pudge_cute_arms.vmdl",
            "models/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hook.vmdl",
        },
    },
    [30385] = 
    {
        ['item_id'] =30385,
        ['name'] ='Velveteen Vanquisher',
        ['icon'] ='econ/sets/DOTA_Item_Velveteen_Vanquisher',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/pudge_cute/pudge_cute.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_persona_custom_3",
        ['sets'] = 'pudge_persona',
        ['persona'] = 4,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge_cute/little_knight/pudge_cute_meathook_little_knight.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge_cute/little_knight_weapon/little_knight_weapon.vmdl",
            "models/items/pudge_cute/little_knight_armor/little_knight_armor.vmdl",
            "models/items/pudge_cute/little_knight_arms/little_knight_arms.vmdl",
            "models/items/pudge_cute/little_knight_head/little_knight_head.vmdl",
            "models/items/pudge_cute/little_knight_offhand/little_knight_offhand.vmdl",
        },
    },
    [32876] = 
    {
        ['item_id'] =32876,
        ['name'] ='Glutton of Punishment',
        ['icon'] ='econ/sets/DOTA_Item_Glutton_of_Punishment',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/pudge_cute/pudge_cute.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'persona_selector',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_persona_custom_4",
        ['sets'] = 'pudge_persona',
        ['persona'] = 4,
        ['is_exclusive'] = 1,
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_pudge_cute/pudge_cute_meathook.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/pudge_cute/glutton_ghoul_head/glutton_ghoul_head.vmdl",
            "models/items/pudge_cute/glutton_ghoul_offhand/glutton_ghoul_offhand.vmdl",
            "models/items/pudge_cute/glutton_ghoul_weapon/glutton_ghoul_weapon.vmdl",
            "models/items/pudge_cute/glutton_ghoul_arms/glutton_ghoul_arms.vmdl",
            "models/items/pudge_cute/glutton_ghoul_armor/glutton_ghoul_armor.vmdl",
        },
    },
    [4734] = 
    {
        ['item_id'] =4734,
        ['name'] ='Rotten Stache',
        ['icon'] ='econ/items/pudge/combover/combover',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/combover/combover.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
    },
    [6226] = 
    {
        ['item_id'] =6226,
        ['name'] ='Insatiable Bonesaw',
        ['icon'] ='econ/items/pudge/insatiable_bonesaw/insatiable_bonesaw',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/insatiable_bonesaw/insatiable_bonesaw.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/pudge/pudge_insatiable_bonesaw/pudge_insatiable_bonesaw.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_L", "hero",
                    },
                }
            },
        },
    },
    [27452] = 
    {
        ['item_id'] =27452,
        ['name'] ='Aberrant Observer - Hook',
        ['icon'] ='econ/items/pudge/aberrant_observer_hook/aberrant_observer_hook',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_hook/aberrant_observer_hook.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
        ['ParticlesItems'] = 
        { 
            {
                ['ParticleName'] = 'particles/econ/items/pudge/aberrant/default/aberrant_default_hook_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "ArbitraryChain2_plc2"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_hook_top"},
                }
            }
        },
    },
    [27477] = 
    {
        ['item_id'] =27477,
        ['name'] ='Aberrant Observer - Offhand',
        ['icon'] ='econ/items/pudge/aberrant_observer_offhand/aberrant_observer_offhand',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_offhand/aberrant_observer_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
    },
    [27479] = 
    {
        ['item_id'] =27479,
        ['name'] ='Aberrant Observer - Right Arm',
        ['icon'] ='econ/items/pudge/aberrant_observer_right_arm/aberrant_observer_right_arm',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_right_arm/aberrant_observer_right_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
    },
    [26782] = 
    {
        ['item_id'] =26782,
        ['name'] ='Aberrant Observer - Back',
        ['icon'] ='econ/items/pudge/aberrant_observer_back/aberrant_observer_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_back/aberrant_observer_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_aberrant_observer_custom",
        ['sets'] = 'abarrant_observer',
    },
    [26784] = 
    {
        ['item_id'] =26784,
        ['name'] ='Aberrant Observer - Head',
        ['icon'] ='econ/items/pudge/aberrant_observer_head/aberrant_observer_head',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_head/aberrant_observer_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
    },
    [27478] = 
    {
        ['item_id'] =27478,
        ['name'] ='Aberrant Observer - Left Arm',
        ['icon'] ='econ/items/pudge/aberrant_observer_left_arm/aberrant_observer_left_arm',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_left_arm/aberrant_observer_left_arm.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
    },
    [26783] = 
    {
        ['item_id'] =26783,
        ['name'] ='Aberrant Observer - Belt',
        ['icon'] ='econ/items/pudge/aberrant_observer_belt/aberrant_observer_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/aberrant_observer_belt/aberrant_observer_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'abarrant_observer',
    },
    [26091] = 
    {
        ['item_id'] =26091,
        ['name'] ='Rotzo the Clown - Head',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_head/pudge_hungry_clown_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_head/pudge_hungry_clown_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_clown',
    },
    [26092] = 
    {
        ['item_id'] =26092,
        ['name'] ='Rotzo the Clown - Weapon',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_weapon/pudge_hungry_clown_weapon',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_weapon/pudge_hungry_clown_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_hungry_clown_weapon",
        ['sets'] = 'pudge_clown',
    },
    [26095] = 
    {
        ['item_id'] =26095,
        ['name'] ='Rotzo the Clown - Arms',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_arms/pudge_hungry_clown_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_arms/pudge_hungry_clown_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_clown',
    },
    [26094] = 
    {
        ['item_id'] =26094,
        ['name'] ='Rotzo the Clown - Back',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_back/pudge_hungry_clown_back',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_back/pudge_hungry_clown_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_clown_back_custom",
        ['sets'] = 'pudge_clown',
    },
    [26093] = 
    {
        ['item_id'] =26093,
        ['name'] ='Rotzo the Clown - Belt',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_belt/pudge_hungry_clown_belt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_belt/pudge_hungry_clown_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_clown',
        ['ParticlesItems'] = 
        { 
            {
                ['ParticleName'] = 'particles/econ/items/pudge/hungry_clown/hungry_clown_belt_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_bubble_ring"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_bubble_glass"},
                }
            }
        },
    },
    [26090] = 
    {
        ['item_id'] =26090,
        ['name'] ='Rotzo the Clown - Offhand Weapon',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_offhand_weapon/pudge_hungry_clown_offhand_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_offhand_weapon/pudge_hungry_clown_offhand_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'pudge_clown',
    },
    [26089] = 
    {
        ['item_id'] =26089,
        ['name'] ='Rotzo the Clown - Shoulder',
        ['icon'] ='econ/items/pudge/pudge_hungry_clown_shoulder/pudge_hungry_clown_shoulder',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/pudge/pudge_hungry_clown_shoulder/pudge_hungry_clown_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pudge_hungry_clown_rot",
        ['sets'] = 'pudge_clown',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/pudge/hungry_clown/hungry_clown_rot.vpcf"
        },
    },


    [27553] = 
    {
        ["dota_id"] = 27553,
        ["item_id"] = 27553,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Doll of the Dead's Hook",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_weapon",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_weapon.vmdl",
        ["hide"] = 0,
        ["sets"] = "doll_of_the_dead",
    },
    [27554] = 
    {
        ["dota_id"] = 27554,
        ["item_id"] = 27554,
        ["SlotType"] = "offhand_weapon_persona_1",
        ["name"] = "Doll of the Dead's Dagger",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_offhand",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_offhand.vmdl",
        ["hide"] = 0,
        ["sets"] = "doll_of_the_dead",
    },
    [27555] = 
    {
        ["dota_id"] = 27555,
        ["item_id"] = 27555,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Doll of the Dead's Head",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_hair",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_hair.vmdl",
        ["hide"] = 0,
        ["sets"] = "doll_of_the_dead",
    },
    [27556] = 
    {
        ["dota_id"] = 27556,
        ["item_id"] = 27556,
        ["SlotType"] = "arms_persona_1",
        ["name"] = "Doll of the Dead's Arms",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_offhand",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_arms.vmdl",
        ["hide"] = 0,
        ["sets"] = "doll_of_the_dead",
    },
    [27557] = 
    {
        ["dota_id"] = 27557,
        ["item_id"] = 27557,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Doll of the Dead's Vest",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_costume",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_calavera/pudge_cute_calavera_costume.vmdl",
        ["hide"] = 0,
        ["sets"] = "doll_of_the_dead",
    },

        [30360] = 
    {
        ["dota_id"] = 30360,
        ["item_id"] = 30360,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Frosty the Sew-Man Head",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hair",
        ["price"] = 500,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hair.vmdl",
        ["hide"] = 0,
        ["sets"] = "frosty_sewman",
    },
    [30362] = 
    {
        ["dota_id"] = 30362,
        ["item_id"] = 30362,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Frosty the Sew-Man's Sugary Shiv",
        ["icon"] = "econ/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hook",
        ["price"] = 500,
        ["ItemModel"] = "models/items/pudge_cute/pudge_cute_frostivus/pudge_cute_frostivus_hook.vmdl",
        ["hide"] = 0,
        ["sets"] = "frosty_sewman",
    },
    [28341] = 
    {
        ["dota_id"] = 28341,
        ["item_id"] = 28341,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Velveteen Vanquisher - Armor",
        ["icon"] = "econ/items/pudge_cute/little_knight_armor/little_knight_armor",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/little_knight_armor/little_knight_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "velveteen_vanquisher",
    },
    [28342] = 
    {
        ["dota_id"] = 28342,
        ["item_id"] = 28342,
        ["SlotType"] = "arms_persona_1",
        ["name"] = "Velveteen Vanquisher - Arms",
        ["icon"] = "econ/items/pudge_cute/little_knight_arms/little_knight_arms",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/little_knight_arms/little_knight_arms.vmdl",
        ["hide"] = 0,
        ["sets"] = "velveteen_vanquisher",
    },
    [28343] = 
    {
        ["dota_id"] = 28343,
        ["item_id"] = 28343,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Velveteen Vanquisher - Head",
        ["icon"] = "econ/items/pudge_cute/little_knight_head/little_knight_head",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/little_knight_head/little_knight_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "velveteen_vanquisher",
    },
    [28344] = 
    {
        ["dota_id"] = 28344,
        ["item_id"] = 28344,
        ["SlotType"] = "offhand_weapon_persona_1",
        ["name"] = "Velveteen Vanquisher - Offhand",
        ["icon"] = "econ/items/pudge_cute/little_knight_offhand/little_knight_offhand",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/little_knight_offhand/little_knight_offhand.vmdl",
        ["hide"] = 0,
        ["sets"] = "velveteen_vanquisher",
    },
    [28345] = 
    {
        ["dota_id"] = 28345,
        ["item_id"] = 28345,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Velveteen Vanquisher - Weapon",
        ["icon"] = "econ/items/pudge_cute/little_knight_weapon/little_knight_weapon",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/little_knight_weapon/little_knight_weapon.vmdl",
        ["hide"] = 0,
        ["sets"] = "velveteen_vanquisher",
    },
    [32871] = 
    {
        ["dota_id"] = 32871,
        ["item_id"] = 32871,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Glutton of Punishment - Head",
        ["icon"] = "econ/items/pudge_cute/glutton_ghoul_head/glutton_ghoul_head",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/glutton_ghoul_head/glutton_ghoul_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "glutton_punishment",
    },
    [32872] = 
    {
        ["dota_id"] = 32872,
        ["item_id"] = 32872,
        ["SlotType"] = "offhand_weapon_persona_1",
        ["name"] = "Glutton of Punishment - Offhand",
        ["icon"] = "econ/items/pudge_cute/glutton_ghoul_offhand/glutton_ghoul_offhand",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/glutton_ghoul_offhand/glutton_ghoul_offhand.vmdl",
        ["hide"] = 0,
        ["sets"] = "glutton_punishment",
    },
    [32873] = 
    {
        ["dota_id"] = 32873,
        ["item_id"] = 32873,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Glutton of Punishment - Weapon",
        ["icon"] = "econ/items/pudge_cute/glutton_ghoul_weapon/glutton_ghoul_weapon",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/glutton_ghoul_weapon/glutton_ghoul_weapon.vmdl",
        ["hide"] = 0,
        ["sets"] = "glutton_punishment",
    },
    [32874] = 
    {
        ["dota_id"] = 32874,
        ["item_id"] = 32874,
        ["SlotType"] = "arms_persona_1",
        ["name"] = "Glutton of Punishment - Arms",
        ["icon"] = "econ/items/pudge_cute/glutton_ghoul_arms/glutton_ghoul_arms",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/glutton_ghoul_arms/glutton_ghoul_arms.vmdl",
        ["hide"] = 0,
        ["sets"] = "glutton_punishment",
    },
    [32875] = 
    {
        ["dota_id"] = 32875,
        ["item_id"] = 32875,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Glutton of Punishment - Armor",
        ["icon"] = "econ/items/pudge_cute/glutton_ghoul_armor/glutton_ghoul_armor",
        ["price"] = 200,
        ["ItemModel"] = "models/items/pudge_cute/glutton_ghoul_armor/glutton_ghoul_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "glutton_punishment",
    },


    [33843] = {

    ['item_id'] =33843,
    ['name'] ='The Woodcutter - Armor',
    ['icon'] ='econ/items/pudge_cute/puppet_armor_v2/puppet_armor_v2',
    ['price'] = 200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/pudge_cute/puppet_armor_v2/puppet_armor_v2.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'armor_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'wood_cutter',
    },
    [33844] = {
    ['item_id'] =33844,
    ['name'] ='The Woodcutter - Arms',
    ['icon'] ='econ/items/pudge_cute/puppet_arms_v2/puppet_arms_v2',
    ['price'] = 200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/pudge_cute/puppet_arms_v2/puppet_arms_v2.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'arms_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'wood_cutter',
    },
    [33845] = {
    ['item_id'] =33845,
    ['name'] ='The Woodcutter - Head',
    ['icon'] ='econ/items/pudge_cute/puppet_head_v2/puppet_head_v2',
    ['price'] = 200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/pudge_cute/puppet_head_v2/puppet_head_v2.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'wood_cutter',
    },
    [33847] = {
    ['item_id'] =33847,
    ['name'] ='The Woodcutter - Weapon',
    ['icon'] ='econ/items/pudge_cute/puppet_weapon_v2/puppet_weapon_v2',
    ['price'] = 200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/pudge_cute/puppet_weapon_v2/puppet_weapon_v2.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'wood_cutter',
    },
    [33846] = {
    ['item_id'] =33846,
    ['name'] ='The Woodcutter - Offhand',
    ['icon'] ='econ/items/pudge_cute/puppet_offhand_v2/puppet_offhand_v2',
    ['price'] = 200,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/pudge_cute/puppet_offhand_v2/puppet_offhand_v2.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon_persona_1',
    ['RemoveDefaultItemsList'] = nil,
    ['Modifier'] = nil,
    ['sets'] = 'wood_cutter',
    },
}