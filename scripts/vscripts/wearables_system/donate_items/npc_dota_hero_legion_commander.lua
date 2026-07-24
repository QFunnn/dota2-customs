--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [5810] = 
    {
        ['item_id'] =5810,
        ['name'] ='Blades of Voth Domosh',
        ['icon'] ='econ/items/legion_commander/demon_sword',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['is_exclusive'] = 1,
        ["ParticlesHero"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_weapon_voth_domosh/legion_ambient_arcana.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eyeR"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eyeL"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hitloc"
                    },
                }
            }
        },
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_weapon_voth_domosh/legion_arcana_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_weapon_voth_domosh/legion_arcana_weapon_offhand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                }
            }
        },
        ['ItemModel'] ='models/items/legion_commander/demon_sword.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_legion_commander_arcana_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/legion_custom_odds/legion_duel_ring_arcana.vpcf"
        }
    },
    [7930] = 
    {
        ['item_id'] =7930,
        ['name'] ='Legacy of the Fallen Legion',
        ['icon'] ='econ/items/legion_commander/legacy_of_the_fallen_legion/legacy_of_the_fallen_legion',
        ['price'] = 3000,
        ["ItemStyle"] = "0",
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_fallen/legion_fallen_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/legacy_of_the_fallen_legion/legacy_of_the_fallen_legion.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{7930, "#ffbe1b"}, {7931, "#460a0a"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_legion_commander_wings_fallen_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/legion/legion_fallen/legion_fallen_press_owner.vpcf"
        }
    },
    [7931] = 
    {
        ["dota_id"] = 7930,
        ['item_id'] =7931,
        ['name'] ='Legacy of the Fallen Legion',
        ['icon'] ='econ/items/legion_commander/legacy_of_the_fallen_legion/legacy_of_the_fallen_legion_style1',
        ['price'] = 1,
        ["ItemStyle"] = "1",
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_fallen/legion_fallen_ambient_alt.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            },
        },
        ['MaterialGroupItem'] = "1",
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/legacy_of_the_fallen_legion/legacy_of_the_fallen_legion.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{7930, "#ffbe1b"}, {7931, "#460a0a"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_legion_commander_wings_fallen_custom_2",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/legion/legion_fallen/legion_fallen_press_owner_alt.vpcf"
        }
    },
    [9236] = 
    {
        ['item_id'] =9236,
        ['name'] ='Baneful Devotion',
        ['icon'] ='econ/items/legion_commander/lc_immortal_head_ti7/lc_immortal_head_ti7',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_ambient.vpcf",
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
                        "attach_gem"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spire_l"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_spire_r"
                    },
                }
            },
        },
        ['ItemModel'] ='models/items/legion_commander/lc_immortal_head_ti7/lc_immortal_head_ti7.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_legion_commander_ti7_head_custom",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_buff.vpcf",
            "particles/econ/items/legion/legion_overwhelming_odds_ti7/legion_commander_odds_ti7_creep.vpcf",
            "particles/legion_custom_odds/legion_custom_odds.vpcf",
        }
    },
    [25758] = 
    {
            ['item_id'] =25758,
            ['name'] ='Bird of Prey - Weapon',
            ['icon'] ='econ/items/legion_commander/lc_bird_of_prey_weapon/lc_bird_of_prey_weapon',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "default",
            ['ItemModel'] ='models/items/legion_commander/lc_bird_of_prey_weapon/lc_bird_of_prey_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'birdofpray',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_bird_prey/lc_bird_prey_weapon.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [25759] = 
    {
            ['item_id'] =25759,
            ['name'] ='Bird of Prey - Shoulder',
            ['icon'] ='econ/items/legion_commander/lc_bird_of_prey_shoulder/lc_bird_of_prey_shoulder',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/lc_bird_of_prey_shoulder/lc_bird_of_prey_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'birdofpray',
    },
    [25761] = 
    {
            ['item_id'] =25761,
            ['name'] ='Bird of Prey - Head',
            ['icon'] ='econ/items/legion_commander/lc_bird_of_prey_wearable/lc_bird_of_prey_wearable',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/lc_bird_of_prey_wearable/lc_bird_of_prey_wearable.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'birdofpray',
    },
    [25762] = 
    {
            ['item_id'] =25762,
            ['name'] ='Bird of Prey - Back',
            ['icon'] ='econ/items/legion_commander/lc_bird_of_prey_back/lc_bird_of_prey_back',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/lc_bird_of_prey_back/lc_bird_of_prey_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'birdofpray',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_bird_prey/lc_bird_prey_back.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = {"SetParticleControl", "default"},
                    }
                },
            },
    },
    [25763] = 
    {
            ['item_id'] =25763,
            ['name'] ='Bird of Prey - Arms',
            ['icon'] ='econ/items/legion_commander/lc_bird_of_prey_arms/lc_bird_of_prey_arms',
            ['price'] = 400,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/lc_bird_of_prey_arms/lc_bird_of_prey_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'birdofpray',
    },
    [29256] = 
    {
            ['item_id'] =29256,
            ['name'] ='Triumph of the Imperatrix Shoulder',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_shoulder/legion_commander_triumph_of_centurion_shoulder',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_shoulder/legion_commander_triumph_of_centurion_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [29257] = 
    {
            ['item_id'] =29257,
            ['name'] ='Triumph of the Imperatrix Weapon',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_weapon/legion_commander_triumph_of_centurion_weapon',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "default",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_weapon/legion_commander_triumph_of_centurion_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [29255] = 
    {
            ['item_id'] =29255,
            ['name'] ='Triumph of the Imperatrix Legs',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_legs/legion_commander_triumph_of_centurion_legs',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_legs/legion_commander_triumph_of_centurion_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [29254] = 
    {
            ['item_id'] =29254,
            ['name'] ='Triumph of the Imperatrix Head',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_wearable/legion_commander_triumph_of_centurion_wearable',
            ['price'] = 1200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_wearable/legion_commander_triumph_of_centurion_wearable.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [29253] = 
    {
            ['item_id'] =29253,
            ['name'] ='Triumph of the Imperatrix Back',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_back/legion_commander_triumph_of_centurion_back',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_back/legion_commander_triumph_of_centurion_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [29252] = 
    {
            ['item_id'] =29252,
            ['name'] ='Triumph of the Imperatrix Arms',
            ['icon'] ='econ/items/legion_commander/legion_commander_triumph_of_centurion_arms/legion_commander_triumph_of_centurion_arms',
            ['price'] = 400,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_triumph_of_centurion_arms/legion_commander_triumph_of_centurion_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'triumphimperatrix',
    },
    [13985] = 
    {
            ['item_id'] =13985,
            ['name'] ='Radiant Conqueror Weapon',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_weapon/radiant_conqueror_weapon',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "default",
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_weapon/radiant_conqueror_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'radiantconqueror',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_radiant_conqueror/legion_radiant_conqueror_weapon_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [11] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_01"
                        },
                        [12] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_02"
                        },
                        [13] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_03"
                        },
                        [14] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_04"
                        },
                        [15] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_05"
                        },
                        [16] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "spike_06"
                        },
                        [21] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_01"
                        },
                        [22] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_02"
                        },
                    }
                },
            },
    },
    [13984] = 
    {
            ['item_id'] =13984,
            ['name'] ='Radiant Conqueror Back',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_back/radiant_conqueror_back',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_back/radiant_conqueror_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = "modifier_legion_commander_radiant_conquerror_custom",
            ['sets'] = 'radiantconqueror',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_radiant_conqueror/legion_radiant_conqueror_back_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [11] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_01"
                        },
                        [12] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_02"
                        },
                        [13] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_03"
                        },
                        [14] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_04"
                        },
                        [15] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem_05"
                        },
                        [21] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "ribbon_a"
                        },
                        [22] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "ribbon_b"
                        },
                        [23] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "ribbon_a_r"
                        },
                        [24] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "ribbon_b_r"
                        },
                    }
                },
            },
    },
    [13986] = 
    {
            ['item_id'] =13986,
            ['name'] ='Radiant Conqueror Shoulder',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_shoulder/radiant_conqueror_shoulder',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_shoulder/radiant_conqueror_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'radiantconqueror',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_radiant_conqueror/legion_radiant_conqueror_shoulder_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [11] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_gem"
                        },
                    }
                },
            },
    },
    [13987] = 
    {
            ['item_id'] =13987,
            ['name'] ='Radiant Conqueror Legs',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_legs/radiant_conqueror_legs',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_legs/radiant_conqueror_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'radiantconqueror',
    },
    [13988] = 
    {
            ['item_id'] =13988,
            ['name'] ='Radiant Conqueror Head',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_head/radiant_conqueror_head',
            ['price'] = 1000,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_head/radiant_conqueror_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'radiantconqueror',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/legion_radiant_conqueror/legion_radiant_conqueror_head_ambient.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [1] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_helmet_tip"
                        },
                        [11] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_helmet_tip"
                        },
                    }
                },
            },
    },
    [13989] = 
    {
            ['item_id'] =13989,
            ['name'] ='Radiant Conqueror Arms',
            ['icon'] ='econ/items/legion_commander/radiant_conqueror_arms/radiant_conqueror_arms',
            ['price'] = 400,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/radiant_conqueror_arms/radiant_conqueror_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'radiantconqueror',
    },
    [13048] = 
    {
            ['item_id'] =13048,
            ['name'] ='Pike of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_weapon/ti9_cache_lc_gryphonwing_knight_weapon',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "default",
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_weapon/ti9_cache_lc_gryphonwing_knight_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
    },
    [13051] = 
    {
            ['item_id'] =13051,
            ['name'] ='Bracers of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_arms/ti9_cache_lc_gryphonwing_knight_arms',
            ['price'] = 400,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_arms/ti9_cache_lc_gryphonwing_knight_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
    },
    [13053] = 
    {
            ['item_id'] =13053,
            ['name'] ='Legs of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_legs/ti9_cache_lc_gryphonwing_knight_legs',
            ['price'] = 600,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_legs/ti9_cache_lc_gryphonwing_knight_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
    },
    [13054] = 
    {
            ['item_id'] =13054,
            ['name'] ='Crest of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_back/ti9_cache_lc_gryphonwing_knight_back',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_back/ti9_cache_lc_gryphonwing_knight_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/ti9_cache_lc_gryphonwing_knight/ti9_cache_lc_gryphonwing_knight_banner.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [1] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spear_bot_fx"
                        },
                        [2] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_shield_gem_fx"
                        },
                        [3] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_spear_tip_fx"
                        },
                    }
                },
            },
    },
    [13052] = 
    {
            ['item_id'] =13052,
            ['name'] ='Pauldrons of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_shoulder/ti9_cache_lc_gryphonwing_knight_shoulder',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_shoulder/ti9_cache_lc_gryphonwing_knight_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
    },
    [13050] = 
    {
            ['item_id'] =13050,
            ['name'] ='Helm of the Honored Servant of the Empire',
            ['icon'] ='econ/items/legion_commander/ti9_cache_lc_gryphonwing_knight_head/ti9_cache_lc_gryphonwing_knight_head',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/ti9_cache_lc_gryphonwing_knight_head/ti9_cache_lc_gryphonwing_knight_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'honorservant',
    },
    [8821] = 
    {
            ['item_id'] =8821,
            ['name'] ='Armor of the Daemonfell Flame',
            ['icon'] ='econ/items/legion_commander/athenas_flame_shoulder/athenas_flame_shoulder',
            ['price'] = 700,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/athenas_flame_shoulder/athenas_flame_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'daemonfell',
    },
    [8822] = 
    {
            ['item_id'] =8822,
            ['name'] ='Banner of the Daemonfell Flame',
            ['icon'] ='econ/items/legion_commander/athenas_flame_back/athenas_flame_back',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/athenas_flame_back/athenas_flame_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'daemonfell',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/athenes_flame/athenesflames_back.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_back"
                        },
                    }
                },
            },
    },
    [8823] = 
    {
            ['item_id'] =8823,
            ['name'] ='Spear of the Daemonfell Flame',
            ['icon'] ='econ/items/legion_commander/athenas_flame_weapon/athenas_flame_weapon',
            ['price'] = 800,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = "default",
            ['ItemModel'] ='models/items/legion_commander/athenas_flame_weapon/athenas_flame_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'daemonfell',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/athenes_flame/athenesflames_weapon.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_weapon"
                        },
                    }
                },
            },
    },
    [8824] = 
    {
            ['item_id'] =8824,
            ['name'] ='Helm of the Daemonfell Flame',
            ['icon'] ='econ/items/legion_commander/athenas_flame_head/athenas_flame_head',
            ['price'] = 700,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/athenas_flame_head/athenas_flame_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'daemonfell',
            ["ParticlesItems"] = 
            {
                {
                    ["ParticleName"] = "particles/econ/items/legion/athenes_flame/athenesflames_head.vpcf",
                    ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                    ["ControllPoints"] = 
                    {
                        [0] = 
                        {
                            'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                            "attach_head"
                        },
                    }
                },
            },
    },
    [8820] = 
    {
            ['item_id'] =8820,
            ['name'] ='Bracers of the Daemonfell Flame',
            ['icon'] ='econ/items/legion_commander/athenas_flame_arms/athenas_flame_arms',
            ['price'] = 400,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/athenas_flame_arms/athenas_flame_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = nil,
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'daemonfell',
    },
    [9780] = 
    {
            ["dota_id"] = 9780,
            ['item_id'] =9780,
            ['name'] ='Mantle of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_shoulder',
            ['price'] = 300,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9780, "#d83119"}, {978099, "#146e2d"}, {9780999, "#383538"}},
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9781] = 
    {
        ["dota_id"] = 9781,
            ['item_id'] =9781,
            ['name'] ='Banners of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_back',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9781, "#d83119"}, {978199, "#146e2d"}, {9781999, "#383538"}},
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9782] = 
    {
        ["dota_id"] = 9782,
            ['item_id'] =9782,
            ['name'] ='Lance of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_weapon',
            ['price'] = 200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9782, "#d83119"}, {978299, "#146e2d"}, {9782999, "#383538"}},
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9783] = 
    {
        ["dota_id"] = 9783,
            ['item_id'] =9783,
            ['name'] ='Bracers of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_arms',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9783, "#d83119"}, {978399, "#146e2d"}, {9783999, "#383538"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9784] = 
    {
        ["dota_id"] = 9784,
            ['item_id'] =9784,
            ['name'] ='Helm of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_head',
            ['price'] = 200,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9784, "#d83119"}, {978499, "#146e2d"}, {9784999, "#383538"}},
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9785] = 
    {
        ["dota_id"] = 9785,
            ['item_id'] =9785,
            ['name'] ='Legs of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_legs',
            ['price'] = 100,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 0,
            ['OtherItemsBundle'] = {{9785, "#d83119"}, {978599, "#146e2d"}, {9785999, "#383538"}},
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978099] = 
    {
        ["dota_id"] = 9780,
            ['item_id'] =978099,
            ['name'] ='Mantle of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_shoulder_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["ItemStyle"] = "1",
            ["MaterialGroupItem"] = "1",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9780, "#d83119"}, {978099, "#146e2d"}, {9780999, "#383538"}},
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978199] = 
    {
        ["dota_id"] = 9781,
            ['item_id'] =978199,
            ['name'] ='Banners of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_back_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ["ItemStyle"] = "1",
            ["MaterialGroupItem"] = "1",
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9781, "#d83119"}, {978199, "#146e2d"}, {9781999, "#383538"}},
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978299] = 
    {
        ["dota_id"] = 9782,
            ['item_id'] =978299,
            ['name'] ='Lance of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_weapon_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["ItemStyle"] = "1",
            ["MaterialGroupItem"] = "1",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9782, "#d83119"}, {978299, "#146e2d"}, {9782999, "#383538"}},
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978399] = 
    {
        ["dota_id"] = 9783,
            ['item_id'] =978399,
            ['name'] ='Bracers of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_arms_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ["ItemStyle"] = "1",
            ["MaterialGroupItem"] = "1",
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9783, "#d83119"}, {978399, "#146e2d"}, {9783999, "#383538"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978499] = 
    {
        ["dota_id"] = 9784,
            ['item_id'] =978499,
            ['name'] ='Helm of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_head_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ["ItemStyle"] = "1",
            ["MaterialGroupItem"] = "1",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9784, "#d83119"}, {978499, "#146e2d"}, {9784999, "#383538"}},
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [978599] = 
    {
        ["dota_id"] = 9785,
            ['item_id'] =978599,
            ["ItemStyle"] = "1",
            ['name'] ='Legs of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/legion_commander_ti8_legs_style1',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["MaterialGroupItem"] = "1",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9785, "#d83119"}, {978599, "#146e2d"}, {9785999, "#383538"}},
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },




    [9780999] = 
    {
        ["dota_id"] = 18589,
            ['item_id'] =9780999,
            ['name'] ='Mantle of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_shoulder',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["MaterialGroupItem"] = "2",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_shoulder.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9780, "#d83119"}, {978099, "#146e2d"}, {9780999, "#383538"}},
            ['SlotType'] = 'shoulder',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9781999] = 
    {
        ["dota_id"] = 18590,
            ['item_id'] =9781999,
            ['name'] ='Banners of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_back',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ["MaterialGroupItem"] = "2",
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_back.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9781, "#d83119"}, {978199, "#146e2d"}, {9781999, "#383538"}},
            ['SlotType'] = 'back',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9782999] = 
    {
        ["dota_id"] = 18591,
            ['item_id'] =9782999,
            ['name'] ='Lance of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_weapon',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["MaterialGroupItem"] = "2",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_weapon.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9782, "#d83119"}, {978299, "#146e2d"}, {9782999, "#383538"}},
            ['SlotType'] = 'weapon',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9783999] = 
    {
        ["dota_id"] = 18592,
            ['item_id'] =9783999,
            ['name'] ='Bracers of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_arms',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ["MaterialGroupItem"] = "2",
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_arms.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9783, "#d83119"}, {978399, "#146e2d"}, {9783999, "#383538"}},
            ['SlotType'] = 'arms',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9784999] = 
    {
         ["dota_id"] = 18593,
            ['item_id'] =9784999,
            ['name'] ='Helm of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_head',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ["MaterialGroupItem"] = "2",
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_head.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9784, "#d83119"}, {978499, "#146e2d"}, {9784999, "#383538"}},
            ['SlotType'] = 'head',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [9785999] = 
    {
        ["dota_id"] = 18594,
            ['item_id'] =9785999,
            ['name'] ='Legs of Desolate Conquest',
            ['icon'] ='econ/items/legion_commander/legion_commander_ti8/ti10/legion_commander_ti8_legs',
            ['price'] = 1,
            ['HeroModel'] = nil,
            ['ArcanaAnim'] = nil,
            ['MaterialGroup'] = nil,
            ["MaterialGroupItem"] = "2",
            ['ItemModel'] ='models/items/legion_commander/legion_commander_ti8/legion_commander_ti8_legs.vmdl',
            ['SetItems'] = nil,
            ['hide'] = 1,
            ['OtherItemsBundle'] = {{9785, "#d83119"}, {978599, "#146e2d"}, {9785999, "#383538"}},
            ['SlotType'] = 'legs',
            ['RemoveDefaultItemsList'] = nil,
            --['Modifier'] = nil,
            ['sets'] = 'desolate_conquest',
    },
    [31101] = 
    {
        ['item_id'] =31101,
        ['name'] ='Drakons Deed Lance',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_weapon/apostle_of_war_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_weapon/apostle_of_war_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31101, "#ffbe1b"}, {34336, "#460a0a"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war/apostle_of_war_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_shoulder_gem"
                    },
                }
            }
        },
    },
    [31103] = 
    {
        ['item_id'] =31103,
        ['name'] ='Drakons Deed Gauntlets',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_arms/apostle_of_war_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_arms/apostle_of_war_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31103, "#ffbe1b"}, {34337, "#460a0a"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [31104] = 
    {
        ['item_id'] =31104,
        ['name'] ='Drakons Deed Banners',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_back/apostle_of_war_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_back/apostle_of_war_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31104, "#ffbe1b"}, {34338, "#460a0a"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [31100] = 
    {
        ['item_id'] =31100,
        ['name'] ='Drakons Deed Pauldrons',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_shoulders/apostle_of_war_shoulders',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_shoulders/apostle_of_war_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31100, "#ffbe1b"}, {34335, "#460a0a"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war/apostle_of_war_shoulders_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_shoulder_gem"
                    },
                }
            }
        },
    },
    [31105] = 
    {
        ['item_id'] =31105,
        ['name'] ='Drakons Deed Helm',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_head/apostle_of_war_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_head/apostle_of_war_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31105, "#ffbe1b"}, {34339, "#460a0a"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war/apostle_of_war_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_eye_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_eye_r"
                    },
                }
            }
        },
    },
    [31099] = 
    {
        ['item_id'] =31099,
        ['name'] ='Drakons Deed Tassets',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_legs/apostle_of_war_legs',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_legs/apostle_of_war_legs.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {{31099, "#ffbe1b"}, {34334, "#460a0a"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [34336] = 
    {
        ['item_id'] =34336,
        ['name'] ='Drakons Deed Lance',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_weapon_alt/apostle_of_war_weapon_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_weapon_alt/apostle_of_war_weapon_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31101, "#ffbe1b"}, {34336, "#ca3f31"}},
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war_alt/apostle_of_war_alt_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_shoulder_gem"
                    },
                }
            }
        },
    },
    [34337] = 
    {
        ['item_id'] =34337,
        ['name'] ='Drakons Deed Gauntlets',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_arms_alt/apostle_of_war_arms_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_arms_alt/apostle_of_war_arms_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31103, "#ffbe1b"}, {34337, "#ca3f31"}},
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [34338] = 
    {
        ['item_id'] =34338,
        ['name'] ='Drakons Deed Banners',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_back_alt/apostle_of_war_back_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_back_alt/apostle_of_war_back_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31104, "#ffbe1b"}, {34338, "#ca3f31"}},
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [34335] = 
    {
        ['item_id'] =34335,
        ['name'] ='Drakons Deed Pauldrons',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_shoulders_alt/apostle_of_war_shoulders_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_shoulders_alt/apostle_of_war_shoulders_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31100, "#ffbe1b"}, {34335, "#ca3f31"}},
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war_alt/apostle_of_war_alt_shoulders_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_shoulder_gem"
                    },
                }
            }
        },
    },
    [34339] = 
    {
        ['item_id'] =34339,
        ['name'] ='Drakons Deed Helm',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_head_alt/apostle_of_war_head_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_head_alt/apostle_of_war_head_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31105, "#ffbe1b"}, {34339, "#ca3f31"}},
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/legion/apostle_of_war_alt/apostle_of_war_alt_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_eye_l"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_apostle_eye_r"
                    },
                }
            }
        },
    },
    [34334] = 
    {
        ['item_id'] =34334,
        ['name'] ='Drakons Deed Tassets',
        ['icon'] ='econ/items/legion_commander/apostle_of_war_legs_alt/apostle_of_war_legs_alt',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/legion_commander/apostle_of_war_legs_alt/apostle_of_war_legs_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {{31099, "#ffbe1b"}, {34334, "#ca3f31"}},
        ['SlotType'] = 'legs',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'dracons_deed',
    },
    [36191] = 
    {
        ["dota_id"] = 36191,
        ['item_id'] = 36191,
        ['name'] = "Legion Commander Automaton Persona",
        ['icon'] = "econ/heroes/legion_commander_automaton/legion_commander_automaton",
        ['price'] = 8000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/legion_commander/dark_carnival_legion_commander/dark_carnival_legion_commander_base.vmdl",
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