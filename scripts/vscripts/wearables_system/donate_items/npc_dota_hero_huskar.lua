--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [5872] = {
        ["dota_id"] = 26830,
        ['item_id'] = 5872,
        ['name'] = 'Sacred Chamber Guardian Head',
        ['icon'] = 'econ/items/huskar/huskar_pharaohs_guard_head/huskar_pharaohs_guard_head',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_pharaohs_guard_head/huskar_pharaohs_guard_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_cache/huskar_2022_cache_head.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "pharaohs",
    },
    [2385] = {
        ["dota_id"] = 26829,
        ['item_id'] = 2385,
        ['name'] = 'Sacred Chamber Guardian Arms',
        ['icon'] = 'econ/items/huskar/huskar_pharaohs_guard_arms/huskar_pharaohs_guard_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_pharaohs_guard_arms/huskar_pharaohs_guard_arms.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "pharaohs",
    },
    [2388] = {
        ["dota_id"] = 13322,
        ['item_id'] = 2388,
        ['name'] = 'Bracers of the Ember Demons',
        ['icon'] = 'econ/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_arms/ti9_cache_huskar_baptism_of_melting_fire_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_arms/ti9_cache_huskar_baptism_of_melting_fire_arms.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "baptism",
    },
    [2376] = {
        ["dota_id"] = 14478,
        ['item_id'] = 2376,
        ['name'] = 'Flashpoint Proselyte Arms',
        ['icon'] = 'econ/items/huskar/huskar_explosive_maniac_arms/huskar_explosive_maniac_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_explosive_maniac_arms/huskar_explosive_maniac_arms.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "maniac",
    },
    [2389] = {
        ["dota_id"] = 14476,
        ['item_id'] = 2389,
        ['name'] = 'Flashpoint Proselyte Off-Hand',
        ['icon'] = 'econ/items/huskar/huskar_explosive_maniac_off_hand/huskar_explosive_maniac_off_hand',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_explosive_maniac_off_hand/huskar_explosive_maniac_off_hand.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_explosive_maniac/explosive_maniac_offhand/explosive_maniac_offhand.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "maniac",
    },
    [2398] = {
        ["dota_id"] = 26831,
        ['item_id'] = 2398,
        ['name'] = 'Sacred Chamber Guardian Off-Hand',
        ['icon'] = 'econ/items/huskar/huskar_pharaohs_guard_offhand_weapon/huskar_pharaohs_guard_offhand_weapon',
        ['price'] = 700,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_pharaohs_guard_offhand_weapon/huskar_pharaohs_guard_offhand_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_cache/huskar_2022_cache_offhand.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "pharaohs",
    },
    [2401] = {
        ["dota_id"] = 13318,
        ['item_id'] = 2401,
        ['name'] = 'Buckler of the Ember Demons',
        ['icon'] = 'econ/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_off_hand/ti9_cache_huskar_baptism_of_melting_fire_off_hand',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_off_hand/ti9_cache_huskar_baptism_of_melting_fire_off_hand.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/ti9_cache_huskar_baptism_off_hand/ti9_cache_huskar_baptism_off_hand_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "baptism",
    },
    [2402] = {
        ["dota_id"] = 14477,
        ['item_id'] = 2402,
        ['name'] = 'Flashpoint Proselyte Head',
        ['icon'] = 'econ/items/huskar/huskar_explosive_maniac_head/huskar_explosive_maniac_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_explosive_maniac_head/huskar_explosive_maniac_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_explosive_maniac/explosive_maniac_head/explosive_maniac_head.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_R_eye"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_L_eye"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "maniac",
    },
    [2404] = {
        ["dota_id"] = 22716,
        ['item_id'] = 2404,
        ['name'] = 'Draca Mane',
        ['icon'] = 'econ/items/huskar/husk_2022_immortal/husk_2022_immortal',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/husk_2022_immortal/husk_2022_immortal.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {'SetParticleControl', 'default'},
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_fx"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_fx"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_draca_mane_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break.vpcf",
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break_cast.vpcf",
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break_spellstart.vpcf"
        }
    },
    [2414] = {
        ["dota_id"] = 8188,
        ['item_id'] = 2414,
        ['name'] = 'Searing Dominator',
        ['icon'] = 'econ/items/huskar/searing_dominator/searing_dominator',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/searing_dominator/searing_dominator.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_dominator_eyes.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_eyes_l"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "fx_eyes_r"
                    }
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_dominator_backhair.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "fx_tuft"
                    }
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_searing_dominator/huskar_searingdom_ambient_glows.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_dominator_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_lifebreak_cast.vpcf",
            "particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_lifebreak_spellstart.vpcf",
            "particles/econ/items/huskar/huskar_searing_dominator/huskar_searing_life_break.vpcf"
        }
    },
    [2417] = {
        ["dota_id"] = 13321,
        ['item_id'] = 2417,
        ['name'] = 'Helm of the Ember Demons',
        ['icon'] = 'econ/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_head/ti9_cache_huskar_baptism_of_melting_fire_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_head/ti9_cache_huskar_baptism_of_melting_fire_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/ti9_cache_huskar_baptism_head/ti9_cache_huskar_baptism_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "baptism",
    },
    [2426] = {
        ["dota_id"] = 26832,
        ['item_id'] = 2426,
        ['name'] = 'Sacred Chamber Guardian Shoulder',
        ['icon'] = 'econ/items/huskar/huskar_pharaohs_guard_shoulder/huskar_pharaohs_guard_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_pharaohs_guard_shoulder/huskar_pharaohs_guard_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "pharaohs",
    },
    [2428] = {
        ["dota_id"] = 9793,
        ['item_id'] = 2428,
        ['name'] = 'The Spoils of Dezun',
        ['icon'] = 'econ/items/huskar/huskar_ti8_immortal_shoulders/huskar_ti8_immortal_shoulders',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_ti8_immortal_shoulders/huskar_ti8_immortal_shoulders.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_ti8/huskar_ti8_shoulder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_shoulder_immortal",
        ['sets'] = "rare",
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/huskar/huskar_ti8/huskar_ti8_shoulder_berserk_heal.vpcf"
        }
    },
    [2429] = {
        ["dota_id"] = 14475,
        ['item_id'] = 2429,
        ['name'] = 'Flashpoint Proselyte Shoulder',
        ['icon'] = 'econ/items/huskar/huskar_explosive_maniac_shoulder/huskar_explosive_maniac_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_explosive_maniac_shoulder/huskar_explosive_maniac_shoulder.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_explosive_maniac/explosive_maniac_shoulders/explosive_maniac_shoulders.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "maniac",
    },
    [2431] = {
        ["dota_id"] = 13319,
        ['item_id'] = 2431,
        ['name'] = 'Armor of the Ember Demons',
        ['icon'] = 'econ/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_shoulder/ti9_cache_huskar_baptism_of_melting_fire_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_shoulder/ti9_cache_huskar_baptism_of_melting_fire_shoulder.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/ti9_cache_huskar_baptism_shoulder/ti9_cache_huskar_baptism_shoulder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "baptism",
    },
    [4005] = {
        ["dota_id"] = 26833,
        ['item_id'] = 4005,
        ['name'] = 'Sacred Chamber Guardian Weapon',
        ['icon'] = 'econ/items/huskar/huskar_pharaohs_guard_weapon/huskar_pharaohs_guard_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_pharaohs_guard_weapon/huskar_pharaohs_guard_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_cache/huskar_2022_cache_spear.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "pharaohs",
    },
    [4013] = {
        ["dota_id"] = 18616,
        ['item_id'] = 4013,
        ['name'] = 'Draca Maw',
        ['icon'] = 'econ/items/huskar/husk_2021_immortal/husk_2021_immortal',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/husk_2021_immortal/husk_2021_immortal.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2021_immortal/huskar_2021_immortal_spear.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_2021_weapon_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/huskar/huskar_2021_immortal/huskar_2021_immortal_burning_spear_debuff.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/huskar/husk_2021_immortal/husk_2021_immortal_arm_model.vmdl",
        }
    },
    [4019] = {
        ["dota_id"] = 18564,
        ['item_id'] = 4019,
        ['name'] = 'Golden Draca Maw',
        ['icon'] = 'econ/items/huskar/husk_2021_immortal/husk_2021_immortal1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = 'models/items/huskar/husk_2021_immortal/husk_2021_immortal.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2021_immortal/huskar_2021_immortal_spear_gold.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_2021_weapon_golden_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/huskar/huskar_2021_immortal/huskar_2021_immortal_burning_spear_debuff_gold.vpcf"
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/huskar/husk_2021_immortal/husk_2021_immortal_arm_model.vmdl",
        }
    },
    [4018] = {
        ["dota_id"] = 13320,
        ['item_id'] = 4018,
        ['name'] = 'Spear of the Ember Demons',
        ['icon'] = 'econ/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_weapon/ti9_cache_huskar_baptism_of_melting_fire_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/ti9_cache_huskar_baptism_of_melting_fire_weapon/ti9_cache_huskar_baptism_of_melting_fire_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/ti9_cache_huskar_baptism_weapon/ti9_cache_huskar_baptism_weapon_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "baptism",
    },
    [4493] = 
    {
        ["dota_id"] = 22708,
        ['item_id'] = 4493,
        ['name'] = 'Hides of Hostility Weapon',
        ['icon'] = "econ/items/huskar/the_ironbound_hunter_weapon/the_ironbound_hunter_weapon",
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/the_ironbound_hunter_weapon/the_ironbound_hunter_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_themed/huskar_2022_themed_weapon_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "ironbound",
    },
    [4494] = 
    {
        ["dota_id"] = 22709,
        ['item_id'] = 4494,
        ['name'] = 'Hides of Hostility Head',
        ['icon'] = "econ/items/huskar/the_ironbound_hunter_head/the_ironbound_hunter_head",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/the_ironbound_hunter_head/the_ironbound_hunter_head.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "ironbound",
    },
    [4495] = 
    {
        ["dota_id"] = 22710,
        ['item_id'] = 4495,
        ['name'] = 'Hides of Hostility Shoulder',
        ['icon'] = "econ/items/huskar/the_ironbound_hunter_shoulder/the_ironbound_hunter_shoulder",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/the_ironbound_hunter_shoulder/the_ironbound_hunter_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "ironbound",
    },
    [4496] = 
    {
        ["dota_id"] = 23281,
        ['item_id'] = 4496,
        ['name'] = 'Hides of Hostility Off-Hand',
        ['icon'] = "econ/items/huskar/the_ironbound_hunter_off_hand/the_ironbound_hunter_off_hand",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/the_ironbound_hunter_off_hand/the_ironbound_hunter_off_hand.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_themed/huskar_2022_themed_off_hand_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "ironbound",
    },
    [4497] = 
    {
        ["dota_id"] = 23282,
        ['item_id'] = 4497,
        ['name'] = 'Hides of Hostility Arms',
        ['icon'] = "econ/items/huskar/the_ironbound_hunter_arms/the_ironbound_hunter_arms",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/the_ironbound_hunter_arms/the_ironbound_hunter_arms.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "ironbound",
    },
    [4498] = 
    {
        ["dota_id"] = 14474,
        ['item_id'] = 4498,
        ['name'] = 'Flashpoint Proselyte Weapon',
        ['icon'] = "econ/items/huskar/huskar_explosive_maniac_weapon/huskar_explosive_maniac_weapon",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/huskar/huskar_explosive_maniac_weapon/huskar_explosive_maniac_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_explosive_maniac/explosive_maniac_weapon/explosive_maniac_weapon.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "maniac",
    },

    [22404] = {
        ["dota_id"] = 24877,
        ['item_id'] = 22404,
        ['name'] = 'Golden Draca Mane',
        ['icon'] = 'econ/items/huskar/husk_2022_immortal/husk_2022_immortal1',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = 'models/items/huskar/husk_2022_immortal/husk_2022_immortal.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_head_gold_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {'SetParticleControl', 'default'},
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l_fx"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r_fx"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        ----['Modifier'] = "modifier_huskar_draca_mane_custom_golden",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break_gold.vpcf",
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break_cast.vpcf",
            "particles/econ/items/huskar/huskar_2022_immortal/huskar_2022_immortal_life_break_gold_spellstart.vpcf",
        }
    },
[14145] = 
{
    ["dota_id"] = 14145,
    ['item_id'] =14145,
    ['name'] ='Bleeding Edge - Arms',
    ['icon'] ='econ/items/huskar/flame_samurai_arms/flame_samurai_arms',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/flame_samurai_arms/flame_samurai_arms.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'arms',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bleeding_edge',
},
[14146] = 
{
    ["dota_id"] = 14146,
    ['item_id'] =14146,
    ['name'] ='Bleeding Edge - Head',
    ['icon'] ='econ/items/huskar/flame_samurai_head/flame_samurai_head',
    ['price'] = 1000,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/flame_samurai_head/flame_samurai_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bleeding_edge',
    ['ParticlesItems'] = 
    {
        {
            ['ParticleName'] = 'particles/econ/items/huskar/huskar_2024_flame_samurai/huskar_2024_flame_samurai_head_ambient.vpcf',
            ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
            ['ControllPoints'] = 
            {
                [0] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "attach_eye_L"
                },
                [1] = 
                {
                    'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                    "attach_eye_R"
                }
            }
        }
    },
},
[14147] = 
{
    ["dota_id"] = 14147,
    ['item_id'] =14147,
    ['name'] ='Bleeding Edge - Off-Hand',
    ['icon'] ='econ/items/huskar/flame_samurai_off_hand/flame_samurai_off_hand',
    ['price'] = 1000,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/flame_samurai_off_hand/flame_samurai_off_hand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bleeding_edge',
},
[29599] = 
{
    ["dota_id"] = 29599,
    ['item_id'] =29599,
    ['name'] ='Bleeding Edge - Shoulder',
    ['icon'] ='econ/items/huskar/huskar_flame_samurai_shoulders_noflag/huskar_flame_samurai_shoulders_noflag',
    ['price'] = 1000,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/huskar_flame_samurai_shoulders_noflag/huskar_flame_samurai_shoulders_noflag.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'shoulder',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bleeding_edge',
},
[14167] = 
{
    ["dota_id"] = 14167,
    ['item_id'] =14167,
    ['name'] ='Bleeding Edge - Weapon',
    ['icon'] ='econ/items/huskar/flame_samurai_weapon/flame_samurai_weapon',
    ['price'] = 700,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/flame_samurai_weapon/flame_samurai_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'bleeding_edge',
},
[30984] = 
{
    ["dota_id"] = 30984,
    ['item_id'] =30984,
    ['name'] ='The Burning Sentinel - Shoulder',
    ['icon'] ='econ/items/huskar/demon_shoulders/demon_shoulders',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/demon_shoulders/demon_shoulders.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'shoulder',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'burning_sentinel',
},
[30985] = 
{
    ["dota_id"] = 30985,
    ['item_id'] =30985,
    ['name'] ='The Burning Sentinel - Weapon',
    ['icon'] ='econ/items/huskar/demon_weapon/demon_weapon',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/demon_weapon/demon_weapon.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'weapon',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'burning_sentinel',
},
[30983] = 
{
    ["dota_id"] = 30983,
    ['item_id'] =30983,
    ['name'] ='The Burning Sentinel - Offhand',
    ['icon'] ='econ/items/huskar/demon_offhand/demon_offhand',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/demon_offhand/demon_offhand.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'offhand_weapon',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'burning_sentinel',
},
[30982] = 
{
    ["dota_id"] = 30982,
    ['item_id'] =30982,
    ['name'] ='The Burning Sentinel - Head',
    ['icon'] ='econ/items/huskar/demon_head/demon_head',
    ['price'] = 600,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/demon_head/demon_head.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'head',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'burning_sentinel',
},
[30981] = 
{
    ["dota_id"] = 30981,
    ['item_id'] =30981,
    ['name'] ='The Burning Sentinel - Arms',
    ['icon'] ='econ/items/huskar/demon_arms/demon_arms',
    ['price'] = 400,
    ['HeroModel'] = nil,
    ['ArcanaAnim'] = nil,
    ['MaterialGroup'] = nil,
    ['ItemModel'] ='models/items/huskar/demon_arms/demon_arms.vmdl',
    ['SetItems'] = nil,
    ['hide'] = 0,
    ['OtherItemsBundle'] = nil,
    ['SlotType'] = 'arms',
    ['RemoveDefaultItemsList'] = nil,
    --['Modifier'] = nil,
    ['sets'] = 'burning_sentinel',
},

}