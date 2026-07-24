--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [7627] = 
    {
        ['item_id'] =7627,
        ['name'] ='Eternal Radiance Blades',
        ['icon'] ='econ/items/alchemist/eternal_radiance_blades/eternal_radiance_blades',
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/twin_blades_aurelian/twin_blades_aurelian.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_alchemist_radiance_item_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_ambient_aurelian_l.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_ambient_aurelian_r.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["IsHero"] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            }
        },
        ['ParticlesSkills'] =
        {
            "particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_chemical_rage_aurelian.vpcf",
        }
        -- "asset"		"particles/units/heroes/hero_alchemist/alchemist_chemical_rage.vpcf"
		-- "modifier"	"particles/econ/items/alchemist/alchemist_aurelian_weapon/alchemist_chemical_rage_aurelian.vpcf"
    },
    [9568] = 
    {
        ['item_id'] =9568,
        ['name'] ='Razzils Midas Knuckles',
        ['icon'] ='econ/items/alchemist/razzils_midas_knuckles/razzils_midas_knuckles',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/midasknuckles/midasknuckles.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_alchemist_item_midas_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_ambient_knuckles.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
        ['ParticlesSkills'] =
        {
            "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf",
            "particles/econ/items/alchemist/alchemist_midas_knuckles/alch_hand_of_midas.vpcf",
        }
        -- "asset"		"particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf"
		-- "modifier"		"particles/econ/items/alchemist/alchemist_midas_knuckles/alch_knuckles_lasthit_coins.vpcf"

        -- "asset"		"alchemist_goblins_greed"
	    -- "modifier"		"alchemist/midas_knuckles/alchemist_goblins_greed"

        -- "asset"		"particles/items2_fx/hand_of_midas.vpcf"
		-- "modifier"		"particles/econ/items/alchemist/alchemist_midas_knuckles/alch_hand_of_midas.vpcf"
    },


    [5495] = 
    {
        ['item_id'] =5495,
        ['name'] ='Formed Alloy Apron',
        ['icon'] ='econ/items/alchemist/body/body',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/body/body.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },
    [5496] = 
    {
        ['item_id'] =5496,
        ['name'] ='Formed Alloy Wristplates',
        ['icon'] ='econ/items/alchemist/bracer/bracer',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/bracer/bracer.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },
    [5497] = 
    {
        ['item_id'] =5497,
        ['name'] ='Formed Alloy Flask',
        ['icon'] ='econ/items/alchemist/flask/flask',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/flask/flask.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },
    [5498] = 
    {
        ['item_id'] =5498,
        ['name'] ='Formed Alloy Goggles',
        ['icon'] ='econ/items/alchemist/goggles/goggles',
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/goggles/goggles.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },
    [5104] = 
    {
        ['item_id'] =5104,
        ['name'] ='Formed Alloy Pauldrons',
        ['icon'] ='econ/items/alchemist/armor/armor',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/armor/armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },
    [5571] = 
    {
        ['item_id'] =5571,
        ['name'] ='Formed Alloy Blades',
        ['icon'] ='econ/items/alchemist/swords/swords',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/swords/swords.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'formed_alloy',
    },



    [8528] = 
    {
        ['item_id'] =8528,
        ['name'] ='Molotov Cocktail of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_off_hand/smooth_criminal_off_hand',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_off_hand/smooth_criminal_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_alchemist_concoction_darkbrew_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bottle_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cloth"
                    },
                }
            }
        },
        ['ParticlesSkills'] =
        {
            "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_unstable_concoction_projectile.vpcf",
            "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_unstable_concoction_explosion.vpcf",
            "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_unstableconc_bottles.vpcf",
        }

        -- "asset"		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile.vpcf"
		-- "modifier"		"particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_unstable_concoction_projectile.vpcf"

        -- "asset"		"particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_explosion.vpcf"
		-- "modifier"		"particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_unstable_concoction_explosion.vpcf"

        -- "asset"		"particles/units/heroes/hero_alchemist/alchemist_unstableconc_bottles.vpcf"
		-- "modifier"		"particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_unstableconc_bottles.vpcf"
    },
    [8529] = 
    {
        ['item_id'] =8529,
        ['name'] ='Shotgun Blade of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_weapon/smooth_criminal_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_weapon/smooth_criminal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
    },
    [8530] = 
    {
        ['item_id'] =8530,
        ['name'] ='Garb of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_back/smooth_criminal_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_back/smooth_criminal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
    },
    [8531] = 
    {
        ['item_id'] =8531,
        ['name'] ='Shotgun Sling of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_shoulder/smooth_criminal_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_shoulder/smooth_criminal_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_shoulder"
                    },
                }
            }
        },
    },
    [8532] = 
    {
        ['item_id'] =8532,
        ['name'] ='Suit of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_armor/smooth_criminal_armor',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_armor/smooth_criminal_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
    },
    [8533] = 
    {
        ['item_id'] =8533,
        ['name'] ='Top Hat of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_neck/smooth_criminal_neck',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_neck/smooth_criminal_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_neck_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_cigar"
                    },
                }
            }
        },
    },
    [8518] = 
    {
        ['item_id'] =8518,
        ['name'] ='Armguards of the Darkbrew Enforcer',
        ['icon'] ='econ/items/alchemist/smooth_criminal_arms/smooth_criminal_arms',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/smooth_criminal_arms/smooth_criminal_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_enforcer',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_smooth_criminal/alchemist_smooth_criminal_arms_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_knuckle_index"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_knuckle_middle"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_knuckle_pinky"
                    },
                }
            }
        },
    },



    [24894] = 
    {
        ['item_id'] =24894,
        ['name'] ='Lumpo and Rupertus - Weapon',
        ['icon'] ='econ/items/alchemist/new_years_gift_weapon/new_years_gift_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_weapon/new_years_gift_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30365] = 
    {
        ['item_id'] =30365,
        ['name'] ='Lumpo and Rupertus - Back',
        ['icon'] ='econ/items/alchemist/new_years_gift_body/new_years_gift_body',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_body/new_years_gift_body.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30367] = 
    {
        ['item_id'] =30367,
        ['name'] ='Lumpo and Rupertus - Arms',
        ['icon'] ='econ/items/alchemist/new_years_gift_arms/new_years_gift_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_arms/new_years_gift_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30368] = 
    {
        ['item_id'] =30368,
        ['name'] ='Lumpo and Rupertus - Armor',
        ['icon'] ='econ/items/alchemist/new_years_gift_armor/new_years_gift_armor',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_armor/new_years_gift_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30370] = 
    {
        ['item_id'] =30370,
        ['name'] ='Lumpo and Rupertus - Shoulder',
        ['icon'] ='econ/items/alchemist/new_years_gift_shoudler/new_years_gift_shoudler',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_shoudler/new_years_gift_shoudler.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30369] = 
    {
        ['item_id'] =30369,
        ['name'] ='Lumpo and Rupertus - Offhand',
        ['icon'] ='econ/items/alchemist/new_years_gift_gift/new_years_gift_gift',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_gift/new_years_gift_gift.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },
    [30366] = 
    {
        ['item_id'] =30366,
        ['name'] ='Lumpo and Rupertus - Head',
        ['icon'] ='econ/items/alchemist/new_years_gift_head/new_years_gift_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/new_years_gift_head/new_years_gift_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'lumpo_and_rupertus',
    },



    [14168] = 
    {
        ['item_id'] =14168,
        ['name'] ='Cosmic Concoctioneers - Armor',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_armor/spacefrog_hunter_armor',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_armor/spacefrog_hunter_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2022_cc_armor/alch_2022_cc_armor.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_booster"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_booster"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_wing"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_wing"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "main_bubbles"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_bubbles"
                    },
                }
            }
        },
    },
    [14169] = 
    {
        ['item_id'] =14169,
        ['name'] ='Cosmic Concoctioneers - Arms',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_arms/spacefrog_hunter_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_arms/spacefrog_hunter_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
    },
    [14170] = 
    {
        ['item_id'] =14170,
        ['name'] ='Cosmic Concoctioneers - Back',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_back/spacefrog_hunter_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_back/spacefrog_hunter_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2022_cc_back/alch_2022_cc_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "head1"
                    },
                }
            }
        },
    },
    [14171] = 
    {
        ['item_id'] =14171,
        ['name'] ='Cosmic Concoctioneers - Off-Hand',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_off_hand/spacefrog_hunter_off_hand',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_off_hand/spacefrog_hunter_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
    },
    [14193] = 
    {
        ['item_id'] =14193,
        ['name'] ='Cosmic Concoctioneers - Shoulder',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_shoulder/spacefrog_hunter_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_shoulder/spacefrog_hunter_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2022_cc_shoulder/alch_2022_cc_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_thruster"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_thruster"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "right_thruster"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "left_thruster"
                    },
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "main_bubbles"
                    },
                }
            }
        },
    },
    [14194] = 
    {
        ['item_id'] =14194,
        ['name'] ='Cosmic Concoctioneers - Weapon',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_weapon/spacefrog_hunter_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_weapon/spacefrog_hunter_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
    },
    [14192] = 
    {
        ['item_id'] =14192,
        ['name'] ='Cosmic Concoctioneers - Neck',
        ['icon'] ='econ/items/alchemist/spacefrog_hunter_neck/spacefrog_hunter_neck',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/spacefrog_hunter_neck/spacefrog_hunter_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'cosmic_concoction',
    },



    [17934] = 
    {
        ['item_id'] =17934,
        ['name'] ='Darkbrews Transgression - Off-Hand',
        ['icon'] ='econ/items/alchemist/crazy_experiment_off_hand/crazy_experiment_off_hand',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_off_hand/crazy_experiment_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
    },
    [17935] = 
    {
        ['item_id'] =17935,
        ['name'] ='Darkbrews Transgression - Back',
        ['icon'] ='econ/items/alchemist/crazy_experiment_back/crazy_experiment_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_back/crazy_experiment_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
    },
    [17936] = 
    {
        ['item_id'] =17936,
        ['name'] ='Darkbrews Transgression - Arms',
        ['icon'] ='econ/items/alchemist/crazy_experiment_arms/crazy_experiment_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_arms/crazy_experiment_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_crazy_experiment/alchemist_crazy_experiment_arms_steam.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wrist_fx"
                    },
                }
            }
        },
    },
    [17937] = 
    {
        ['item_id'] =17937,
        ['name'] ='Darkbrews Transgression - Shoulder',
        ['icon'] ='econ/items/alchemist/crazy_experiment_shoulder/crazy_experiment_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_shoulder/crazy_experiment_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_crazy_experiment/alchemist_crazy_experiment_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_r_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_r_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_l_fx"
                    },
                }
            }
        },
    },
    [17938] = 
    {
        ['item_id'] =17938,
        ['name'] ='Darkbrews Transgression - Neck',
        ['icon'] ='econ/items/alchemist/crazy_experiment_neck/crazy_experiment_neck',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_neck/crazy_experiment_neck.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_crazy_experiment/alchemist_crazy_experiment_neck_lightcone.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_light_fx"
                    },
                }
            }
        },
    },
    [17939] = 
    {
        ['item_id'] =17939,
        ['name'] ='Darkbrews Transgression - Armor',
        ['icon'] ='econ/items/alchemist/crazy_experiment_armor/crazy_experiment_armor',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_armor/crazy_experiment_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_crazy_experiment/alchemist_crazy_experiment_armor.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_l_fx"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_r_fx"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_r_fx"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_coil_l_fx"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_fx"
                    },
                    [8] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_mouth_fx_02"
                    },
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_mouth_fx_01"
                    },
                }
            }
        },
    },
    [17940] = 
    {
        ['item_id'] =17940,
        ['name'] ='Darkbrews Transgression - Weapon',
        ['icon'] ='econ/items/alchemist/crazy_experiment_weapon/crazy_experiment_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/crazy_experiment_weapon/crazy_experiment_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'darkbrew_transgression',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alchemist_crazy_experiment/alchemist_crazy_experiment_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_right_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_left_fx"
                    },
                }
            }
        },
    },



    [25604] = 
    {
        ['item_id'] =25604,
        ['name'] ='Taur Rider Head',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_head_regal/alchemist_minotaur_champion_head_regal',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_head_regal/alchemist_minotaur_champion_head_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'neck',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
    },
    [25611] = 
    {
        ['item_id'] =25611,
        ['name'] ='Taur Rider Weapons',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_weapon_regal/alchemist_minotaur_champion_weapon_regal',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_weapon_regal/alchemist_minotaur_champion_weapon_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
    },
    [25607] = 
    {
        ['item_id'] =25607,
        ['name'] ='Taur Rider Shoulders',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_shoulders_crimson_2/alchemist_minotaur_champion_shoulders_crimson_2',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_shoulders_crimson_2/alchemist_minotaur_champion_shoulders_crimson_2.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2023_cc/alch_2023_cc_shoulders.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "clavicle_L"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "clavicle_R"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "stomach"
                    },
                }
            }
        },
    },
    [25602] = 
    {
        ['item_id'] =25602,
        ['name'] ='Taur Rider Offhand',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_offhand_regal/alchemist_minotaur_champion_offhand_regal',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_offhand_regal/alchemist_minotaur_champion_offhand_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
    },
    [25600] =
    {
        ['item_id'] =25600,
        ['name'] ='Taur Rider Back',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_back_regal/alchemist_minotaur_champion_back_regal',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_back_regal/alchemist_minotaur_champion_back_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
    },
    [25595] = 
    {
        ['item_id'] =25595,
        ['name'] ='Taur Rider Armor',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_armor_regal/alchemist_minotaur_champion_armor_regal',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_armor_regal/alchemist_minotaur_champion_armor_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2023_cc/alch_2023_cc_armor.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_L"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_R"
                    },
                }
            }
        },
    },
    [25598] = 
    {
        ['item_id'] =25598,
        ['name'] ='Taur Rider Arms',
        ['icon'] ='econ/items/alchemist/alchemist_minotaur_champion_arms_regal/alchemist_minotaur_champion_arms_regal',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/alchemist/alchemist_minotaur_champion_arms_regal/alchemist_minotaur_champion_arms_regal.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'taur_rider',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/alchemist/alch_2023_cc/alch_2023_cc_arms.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [10] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_R"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "elbow_L"
                    },
                }
            }
        },
    },
}