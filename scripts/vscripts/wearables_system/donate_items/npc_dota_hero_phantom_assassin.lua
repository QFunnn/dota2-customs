--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [3347] = {
        ["dota_id"] = 19177,
        ['item_id'] = 3347,
        ['name'] = 'Bane of the Deathstalkers - Back',
        ['icon'] = 'econ/items/phantom_assassin/athena_pa_back/athena_pa_back',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/athena_pa_back/athena_pa_back.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_2022_cc/pa_2022_cc_back.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {'SetParticleControl', "default"}
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "athena",
    },
    [3357] = {
        ["dota_id"] = 9757,
        ['item_id'] = 3357,
        ['name'] = 'Codicil of the Veiled Ones',
        ['icon'] = 'econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_head',
        ['price'] = 3500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_1"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_2"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_3"
                    },
                    [3] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_sml_1"
                    },
                    [4] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_4"
                    },
                    [5] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_core"
                    },
                    [7] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_front"
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
        --['Modifier'] = "modifier_pa_immortal_helmet_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] = 
        {
            "particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_dagger_debuff.vpcf",
            "particles/econ/items/phantom_assassin/pa_ti8_immortal_head/pa_ti8_immortal_stifling_dagger.vpcf",
        }
    },
    [3362] = {
        ["dota_id"] = 9843,
        ['item_id'] = 3362,
        ['name'] = 'Helm of the Lifted Veil',
        ['icon'] = 'econ/items/phantom_assassin/ti8_pathe_gloomy_veil_head/ti8_pathe_gloomy_veil_head',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/ti8_pathe_gloomy_veil_head/ti8_pathe_gloomy_veil_head.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil
    },
    [3367] = {
        ["dota_id"] = 19176,
        ['item_id'] = 3367,
        ['name'] = 'Bane of the Deathstalkers - Head',
        ['icon'] = 'econ/items/phantom_assassin/athena_pa_head/athena_pa_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/athena_pa_head/athena_pa_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_2022_cc/pa_2022_cc_head.vpcf',
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
        --['Modifier'] = nil,
        ['sets'] = "athena",
    },
    [3369] = {
        ["dota_id"] = 19179,
        ['item_id'] = 3369,
        ['name'] = 'Bane of the Deathstalkers - Shoulder',
        ['icon'] = 'econ/items/phantom_assassin/athena_pa_shoulder/athena_pa_shoulder',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/athena_pa_shoulder/athena_pa_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "athena",
    },
    [3379] = {
        ["dota_id"] = 14948,
        ['item_id'] = 3379,
        ['name'] = 'Avowance of the Veiled Ones',
        ['icon'] = 'econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_immortal_shoulders',
        ['price'] = 3500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_immortal_shoulders.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_immortal_shoulder_ambient.vpcf',
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
        --['Modifier'] = "modifier_pa_shoulder_immortal_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_ambient.vpcf",
            "particles/econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_blur_start.vpcf",
        }
    },
    [3383] = {
        ["dota_id"] = 9847,
        ['item_id'] = 3383,
        ['name'] = 'Armor of the Lifted Veil',
        ['icon'] = 'econ/items/phantom_assassin/ti8_pathe_gloomy_veil_shoulder/ti8_pathe_gloomy_veil_shoulder',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/ti8_pathe_gloomy_veil_shoulder/ti8_pathe_gloomy_veil_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil
    },
    [3384] = {
        ["dota_id"] = 22268,
        ['item_id'] = 3384,
        ['name'] = 'Avowance of the Crimson Witness',
        ['icon'] = 'econ/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_immortal_shoulders1',
        ['price'] = 5000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroupItem'] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/pa_fall20_immortal_shoulders/pa_fall20_immortal_shoulders.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_crimson_witness_2021/pa_crimson_witness_immortal_shoulder_ambient.vpcf',
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
        --['Modifier'] = "modifier_pa_shoulder_immortal_red_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/phantom_assassin/pa_crimson_witness_2021/pa_crimson_witness_blur_ambient.vpcf",
            "particles/econ/items/phantom_assassin/pa_crimson_witness_2021/pa_crimson_witness_blur_start.vpcf",
        }
    },
    [4236] = {
        ["dota_id"] = 9844,
        ['item_id'] = 4236,
        ['name'] = 'Blade of the Lifted Veil',
        ['icon'] = 'econ/items/phantom_assassin/ti8_pathe_gloomy_veil_weapon/ti8_pathe_gloomy_veil_weapon',
        ['price'] = 1,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/ti8_pathe_gloomy_veil_weapon/ti8_pathe_gloomy_veil_weapon.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil
    },
    [4239] = {
        ["dota_id"] = 7247,
        ['item_id'] = 4239,
        ['name'] = 'Manifold Paradox',
        ['icon'] = 'econ/items/phantom_assassin/manifold_paradox/arcana_pa',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/phantom_assassin/pa_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['is_exclusive'] = 1,
        ['ItemModel'] = 'models/heroes/phantom_assassin/pa_arcana_weapons.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    }
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    }
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_l.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    }
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_r.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    }
                }
            }
        },
        ['ParticlesHero'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_r"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_l"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_r"
                    },
                    [3] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_l"
                    }

                }
            }
        },
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = {
            {4239, "#30D5C8"}, {4560, "#d92645"}, {4561, "#FFB02E"}
        },
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_arcana_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_b.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_c.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_debuff_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_debuff_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
        }
    },
    [4560] = {
        ["dota_id"] = 7247,
        ['item_id'] = 4560,
        ['name'] = 'Manifold Paradox',
        ['icon'] = 'econ/items/phantom_assassin/manifold_paradox/arcana_pa_style1',
        ['price'] = 10000,
        ['HeroModel'] = "models/heroes/phantom_assassin/pa_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "0",
        ['ItemModel'] = 'models/heroes/phantom_assassin/pa_arcana_weapons.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                    [26] = {'SetParticleControl', {40, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [26] = {'SetParticleControl', {40, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_l.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [26] = {'SetParticleControl', {40, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_r.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                    [26] = {'SetParticleControl', {40, 0, 0}}
                }
            }
        },
        ['ParticlesHero'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_r"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_l"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_r"
                    },
                    [3] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_l"
                    },
                    [26] = {'SetParticleControl', {40, 0, 0}}
                }
            }
        },
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {
            {4239, "#30D5C8"}, {4560, "#d92645"}, {4561, "#FFB02E"}
        },
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_arcana_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_b.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_c.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_debuff_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
        }
    },
    [4561] = {
        ["dota_id"] = 7247,
        ['item_id'] = 4561,
        ['name'] = 'Manifold Paradox',
        ['icon'] = 'econ/items/phantom_assassin/manifold_paradox/arcana_pa_style2',
        ['price'] = 10000,
        ['HeroModel'] = "models/heroes/phantom_assassin/pa_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/heroes/phantom_assassin/pa_arcana_weapons.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_a.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    },
                    [26] = {'SetParticleControl', {100, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_blade_ambient_b.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack2", "hero"
                    },
                    [26] = {'SetParticleControl', {100, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_l.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_l", "hero"
                    },
                    [26] = {'SetParticleControl', {100, 0, 0}}
                }
            }, {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_eyes_r.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_eye_r", "hero"
                    },
                    [26] = {'SetParticleControl', {100, 0, 0}}
                }
            }
        },
        ['ParticlesHero'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_elder_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_r"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_leg_l"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_r"
                    },
                    [3] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_l"
                    },
                    [26] = {'SetParticleControl', {100, 0, 0}}
                }
            }
        },
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = {
            {4239, "#30D5C8"}, {4560, "#d92645"}, {4561, "#FFB02E"}
        },
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_arcana_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_b.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_event_glitch.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur_c.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_arcana_attack_blur.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_attack_crit.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_stifling_dagger_debuff_arcana.vpcf",
            "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/pa_arcana_phantom_strike_start.vpcf",
        }
    },
    [4243] = {
        ["dota_id"] = 19180,
        ['item_id'] = 4243,
        ['name'] = 'Bane of the Deathstalkers - Weapon',
        ['icon'] = 'econ/items/phantom_assassin/athena_pa_weapon/athena_pa_weapon',
        ['price'] = 800,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['ItemModel'] = 'models/items/phantom_assassin/athena_pa_weapon/athena_pa_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_2022_cc/pa_2022_cc_weapon.vpcf',
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
        ['sets'] = "athena",
    },
    [4248] = {
        ["dota_id"] = 5658,
        ['item_id'] = 4248,
        ['name'] = 'Gleaming Seal',
        ['icon'] = 'econ/items/phantom_assassin/lodas_pa_set__weapon/lodas_pa_set__weapon',
        ['price'] = 400,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['ItemModel'] = 'models/items/phantom_assassin/lodas_pa_set__weapon/lodas_pa_set__weapon.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_gleaming_seal_custom",
        ['sets'] = "lodas",
    },
    [4249] = {
        ["dota_id"] = 7397,
        ['item_id'] = 4249,
        ['name'] = 'Hells Usher',
        ['icon'] = 'econ/items/phantom_assassin/hells_usher/hells_usher_new',
        ['price'] = 1,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['ItemModel'] = 'models/items/phantom_assassin/hells_guide/hells_guide.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/phantom_assassin_weapon_hells_usher/phantom_assassin_hells_usher_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_attack1", "hero"
                    }
                }
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "rare",
    },
    [4258] = {
        ["dota_id"] = 13476,
        ['item_id'] = 4258,
        ['name'] = 'Gothic Whisper Blade',
        ['icon'] = 'econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_weapon/ti9_cache_pa_gothic_hunter_weapon',
        ['price'] = 800,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['ItemModel'] = 'models/items/phantom_assassin/ti9_cache_pa_gothic_hunter_weapon/ti9_cache_pa_gothic_hunter_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_weapon/ti9_cache_pa_gothic_weapon_ambient.vpcf',
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
        ['sets'] = "gothic",
    },
    [3340] = {
        ["dota_id"] = 9846,
        ['item_id'] = 3340,
        ['name'] = 'Cape of the Lifted Veil',
        ['icon'] = 'econ/items/phantom_assassin/ti8_pathe_gloomy_veil_back/ti8_pathe_gloomy_veil_back',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/ti8_pathe_gloomy_veil_back/ti8_pathe_gloomy_veil_back.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil
    },
    [4456] = {
        ["dota_id"] = 19178,
        ['item_id'] = 4456,
        ['name'] = 'Bane of the Deathstalkers - Belt',
        ['icon'] = 'econ/items/phantom_assassin/athena_pa_belt/athena_pa_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/athena_pa_belt/athena_pa_belt.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/pa_2022_cc/pa_2022_cc_belt.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControl', 'default'}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "athena",
    },
    [4480] = {
        ["dota_id"] = 22723,
        ["item_id"] = 4480,
        ["name"] = "Exile Unveiled",
        ["is_persona_item"] = 1,
        ["icon"] = "econ/heroes/phantom_assassin_persona/phantom_assassin_persona",
        ["price"] = 15000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ["HeroModel"] = "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl",
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = nil,
        ["ParticlesItems"] = {
            {
                ["ParticleName"] = "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade_top"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade_bot"
                    }
                }
            }
        },
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "persona_selector",
        ["RemoveDefaultItemsList"] = nil,
        ["Modifier"] = "modifier_phantom_assassin_persona_custom",
        ['sets'] = "rare",
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_twirl_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_spin_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_backhand_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_swing_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_active_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_crit_impact.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_end.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/heroes/phantom_assassin_persona/phantom_assassin_persona_weapon.vmdl",
            "models/heroes/phantom_assassin_persona/phantom_assassin_persona_head.vmdl",
            "models/heroes/phantom_assassin_persona/phantom_assassin_persona_legs.vmdl",
            "models/heroes/phantom_assassin_persona/phantom_assassin_persona_armor.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana_1.vmdl",
        }
    },
    [31081] = 
    {
        ["item_id"] = 31081,
        ["name"] = "Phantoms Facade",
        ["icon"] = "econ/sets/DOTA_Item_Phantoms_Facade",
        ["price"] = 1000,
        ["HeroModel"] = "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl",
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = nil,
        ["ParticlesItems"] = {
            {
                ["ParticleName"] = "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade"
                    },
                }
            }
        },
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 1,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "weapon",
        ["RemoveDefaultItemsList"] = nil,
        ["Modifier"] = "modifier_phantom_assassin_persona_custom_2",
        ['sets'] = "phantom_persona",
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_twirl_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_spin_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_backhand_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_swing_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_active_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_crit_impact.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_head_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_legs_ambient.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/phantom_assassin/head_dark_carnival/head_dark_carnival.vmdl",
            "models/items/phantom_assassin/armor_dark_carnival/armor_dark_carnival.vmdl",
            "models/items/phantom_assassin/legs_dark_carnival/legs_dark_carnival.vmdl",
            "models/items/phantom_assassin/weapon_dark_carnival/weapon_dark_carnival.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana_1.vmdl",
        }
    },
    [4486] = 
    {
        ["dota_id"] = 5654,
        ['item_id'] = 4486,
        ['name'] = 'Belt of the Gleaming Seal',
        ['icon'] = "econ/items/phantom_assassin/lodas_pa_set__belt/lodas_pa_set__belt",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lodas_pa_set__belt/lodas_pa_set__belt.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "lodas",
    },
    [7575] = 
    {
        ["dota_id"] = 5655,
        ['item_id'] = 7575,
        ['name'] = 'Cape of the Gleaming Seal',
        ['icon'] = "econ/items/phantom_assassin/lodas_pa_set__cape/lodas_pa_set__cape",
        ['price'] = 100,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lodas_pa_set__cape/lodas_pa_set__cape.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "lodas",
    },
    [4487] = 
    {
        ["dota_id"] = 5656,
        ['item_id'] = 4487,
        ['name'] = 'Brooch of the Gleaming Seal',
        ['icon'] = "econ/items/phantom_assassin/lodas_pa_set__head/lodas_pa_set__head",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/lodas_pa_set__head/lodas_pa_set__head.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "lodas",
    },
    [4488] = 
    {
        ["dota_id"] = 5657,
        ['item_id'] = 4488,
        ['name'] = 'Ornaments of the Gleaming Seal',
        ['icon'] = "econ/items/phantom_assassin/lodas_pa_set__shoulders/lodas_pa_set__shoulders",
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lodas_pa_set__shoulders/lodas_pa_set__shoulders.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "lodas",
    },
    [4489] = 
    {
        ["dota_id"] = 13480,
        ['item_id'] = 4489,
        ['name'] = 'Gothic Whisper Cape',
        ['icon'] = "econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_back/ti9_cache_pa_gothic_hunter_back",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/ti9_cache_pa_gothic_hunter_back/ti9_cache_pa_gothic_hunter_back.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_back/ti9_cache_pa_gothic_back_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_cape_1"}, [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_cape_2"}, [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_cape_3"}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "gothic",
    },
    [4490] = 
    {
        ["dota_id"] = 13479,
        ['item_id'] = 4490,
        ['name'] = 'Gothic Whisper Belt',
        ['icon'] = "econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_belt/ti9_cache_pa_gothic_hunter_belt",
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/ti9_cache_pa_gothic_hunter_belt/ti9_cache_pa_gothic_hunter_belt.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_belt/ti9_cache_pa_gothic_belt_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_lamp_1"}, [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_lamp_2"}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "gothic",
    },
    [4491] = 
    {
        ["dota_id"] = 13478,
        ['item_id'] = 4491,
        ['name'] = 'Gothic Whisper Mask',
        ['icon'] = "econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_head/ti9_cache_pa_gothic_hunter_head",
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "default",
        ['ItemModel'] = 'models/items/phantom_assassin/ti9_cache_pa_gothic_hunter_head/ti9_cache_pa_gothic_hunter_head.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_head/ti9_cache_pa_gothic_head_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_ribbon"}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "gothic",
    },
    [4492] = 
    {
        ["dota_id"] = 13477,
        ['item_id'] = 4492,
        ['name'] = 'Gothic Whisper Armor',
        ['icon'] = "econ/items/phantom_assassin/ti9_cache_pa_gothic_hunter_shoulder/ti9_cache_pa_gothic_hunter_shoulder",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/ti9_cache_pa_gothic_hunter_shoulder/ti9_cache_pa_gothic_hunter_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "gothic",
    },

    [28170] = 
    {
        ["dota_id"] = 28170,
        ['item_id'] = 28170,
        ['name'] = 'Song of the Shadow Dragon - Belt',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_belt",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_belt.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = 
        {
            {28170, "#d3853c"}, {281701, "#4d7090"}
        },
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },
    [28171] = 
    {
        ["dota_id"] = 28171,
        ['item_id'] = 28171,
        ['name'] = 'Song of the Shadow Dragon - Head',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_head",
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['is_exclusive'] = 1,
        ['MaterialGroup'] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_head.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = 
        {
            {28171, "#d3853c"}, {281711, "#4d7090"}
        },
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_dragon_head_custom",
        ['sets'] = "song_shadow_dragon",
    },
    [28172] = 
    {
        ["dota_id"] = 28172,
        ['item_id'] = 28172,
        ['name'] = 'Song of the Shadow Dragon - Shoulders',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_shoulder",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = 
        {
            {28172, "#d3853c"}, {281721, "#4d7090"}
        },
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },
    [28238] = 
    {
        ["dota_id"] = 28238,
        ['item_id'] = 28238,
        ['name'] = 'Song of the Shadow Dragon - Back',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back",
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['is_exclusive'] = 1,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = 
        {
            {28238, "#d3853c"}, {282381, "#4d7090"}
        },
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_dragon_back_custom",
        ['sets'] = "song_shadow_dragon",
    },
    [28239] = 
    {
        ["dota_id"] = 28239,
        ['item_id'] = 28239,
        ['name'] = 'Song of the Shadow Dragon - Blade',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon",
        ['price'] = 800,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_blade_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {"SetParticleControl", "default"}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = 
        {
            {28239, "#d3853c"}, {282391, "#4d7090"}
        },
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },

    [281701] = 
    {
        ["dota_id"] = 28170,
        ['item_id'] = 281701,
        ['name'] = 'Song of the Shadow Dragon - Belt',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_belt_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_belt.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = 
        {
            {28170, "#d3853c"}, {281701, "#4d7090"}
        },
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },
    [281711] = 
    {
        ["dota_id"] = 28171,
        ['item_id'] = 281711,
        ['name'] = 'Song of the Shadow Dragon - Head',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_head_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = "1",
        ['is_exclusive'] = 1,
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_head.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = 
        {
            {28171, "#d3853c"}, {281711, "#4d7090"}
        },
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_dragon_head_custom",
        ['sets'] = "song_shadow_dragon",
    },
    [281721] = 
    {
        ["dota_id"] = 28172,
        ['item_id'] = 281721,
        ['name'] = 'Song of the Shadow Dragon - Shoulders',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_shoulder_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_shoulder.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = 
        {
            {28172, "#d3853c"}, {281721, "#4d7090"}
        },
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },
    [282381] = 
    {
        ["dota_id"] = 28238,
        ['item_id'] = 282381,
        ['name'] = 'Song of the Shadow Dragon - Back',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_style1",
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['is_exclusive'] = 1,
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl',
        ['ParticlesItems'] = nil,
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = 
        {
            {28238, "#d3853c"}, {282381, "#4d7090"}
        },
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_pa_dragon_back_custom",
        ['sets'] = "song_shadow_dragon",
    },
    [282391] = 
    {
        ["dota_id"] = 28239,
        ['item_id'] = 282391,
        ['name'] = 'Song of the Shadow Dragon - Blade',
        ['icon'] = "econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_style1",
        ['price'] = 1,
        ['HeroModel'] = 'models/heroes/phantom_assassin/phantom_assassin.vmdl',
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = 'default',
        ['MaterialGroupItem'] = "1",
        ["ItemStyle"] = "1",
        ['ItemModel'] = 'models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon.vmdl',
        ['ParticlesItems'] = {
            {
                ['ParticleName'] = 'particles/econ/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_blade_ambient.vpcf',
                ['DefaultPattch'] = PATTACH_ABSORIGIN_FOLLOW,
                ['ControllPoints'] = {[0] = {"SetParticleControl", "default"}}
            }
        },
        ['ParticlesHero'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = 
        {
            {28239, "#d3853c"}, {282391, "#4d7090"}
        },
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = "song_shadow_dragon",
    },
    [28647] = 
    {
        ["dota_id"] = 28647,
        ['item_id'] =28647,
        ['name'] ='Onikage Disciple - Back',
        ['icon'] ='econ/items/phantom_assassin/phantom_assassin_emerald_kunoichi_back/phantom_assassin_emerald_kunoichi_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_emerald_kunoichi_back/phantom_assassin_emerald_kunoichi_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'onikage_disciple',
    },
    [28648] = 
    {
        ["dota_id"] = 28648,
        ['item_id'] =28648,
        ['name'] ='Onikage Disciple - Weapon',
        ['icon'] ='econ/items/phantom_assassin/phantom_assassin_emerald_kunoichi_weapon/phantom_assassin_emerald_kunoichi_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_emerald_kunoichi_weapon/phantom_assassin_emerald_kunoichi_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'onikage_disciple',
    },
    [28646] = 
    {
        ["dota_id"] = 28646,
        ['item_id'] =28646,
        ['name'] ='Onikage Disciple - Belt',
        ['icon'] ='econ/items/phantom_assassin/phantom_assassin_emerald_kunoichi_belt/phantom_assassin_emerald_kunoichi_belt',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_emerald_kunoichi_belt/phantom_assassin_emerald_kunoichi_belt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'belt',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'onikage_disciple',
    },
    [28645] = 
    {
        ["dota_id"] = 28645,
        ['item_id'] =28645,
        ['name'] ='Onikage Disciple - Shoulder',
        ['icon'] ='econ/items/phantom_assassin/phantom_assassin_emerald_kunoichi_shoulder/phantom_assassin_emerald_kunoichi_shoulder',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_emerald_kunoichi_shoulder/phantom_assassin_emerald_kunoichi_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'onikage_disciple',
    },
    [28637] = 
    {
        ["dota_id"] = 28637,
        ['item_id'] =28637,
        ['name'] ='Onikage Disciple - Head',
        ['icon'] ='econ/items/phantom_assassin/phantom_assassin_emerald_kunoichi_head/phantom_assassin_emerald_kunoichi_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_emerald_kunoichi_head/phantom_assassin_emerald_kunoichi_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'onikage_disciple',
    },
    [28320] = 
    {
        ["item_id"] = 28320,
        ["name"] = "Shadow Stalker",
        ["icon"] = "econ/loading_screens/2023panther_shadow_loading",
        ["price"] = 1000,
        ["HeroModel"] = "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl",
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "models/items/phantom_assassin/2023panther_shadow_weapon/2023panther_shadow_weapon.vmdl",
        ["ParticlesItems"] = 
        {
            
        },
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 1,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "weapon",
        ["RemoveDefaultItemsList"] = nil,
        ["Modifier"] = "modifier_phantom_assassin_persona_custom_3",
        ['sets'] = "shadow_stalker",
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_twirl_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_spin_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_backhand_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_swing_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_active_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_crit_impact.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_head_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_legs_ambient.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf",
            "particles/econ/items/phantom_assassin_persona/panther_shadow/panther_shadow_weapon_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/panther_shadow/panther_shadow_belt_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/phantom_assassin/2023panther_shadow_armor/2023panther_shadow_armor.vmdl",
            "models/items/phantom_assassin/2023panther_shadow_hair/2023panther_shadow_hair.vmdl",
            "models/items/phantom_assassin/2023panther_shadow_belt/2023panther_shadow_belt.vmdl",
            "models/items/phantom_assassin/2023panther_shadow_weapon/2023panther_shadow_weapon.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana_1.vmdl",
        }
    },
    [32985] = 
    {
        ["item_id"] = 32985,
        ["name"] = "Reaper of the Waning Veil",
        ["icon"] = "econ/sets/DOTA_Item_Reaper_of_the_Waning_Veil",
        ["price"] = 1000,
        ["HeroModel"] = "models/heroes/phantom_assassin_persona/phantom_assassin_persona.vmdl",
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 1,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "weapon",
        ["RemoveDefaultItemsList"] = nil,
        ["Modifier"] = "modifier_phantom_assassin_persona_custom_4",
        ['sets'] = "phantom_persona",
        ["ParticlesSkills"] =
        {
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_twirl_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_spin_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_attack_backhand_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_attack_blur_crit_swing_fx.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_blur_active_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_crit_impact.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_start.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_phantom_strike_end.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_head_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/dark_carnival/dark_carnival_legs_ambient.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger.vpcf",
            "particles/units/heroes/hero_phantom_assassin_persona/pa_persona_stifling_dagger_debuff.vpcf",
            "particles/econ/items/phantom_assassin_persona/panther_shadow/panther_shadow_weapon_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/panther_shadow/panther_shadow_belt_ambient.vpcf",
            "particles/econ/items/phantom_assassin_persona/veilstrider/veilstrider_weapon_ambient.vpcf",
        },
        ["OtherModelsPrecache"] =
        {
            "models/items/phantom_assassin/veilstrider_armor/veilstrider_armor.vmdl",
            "models/items/phantom_assassin/veilstrider_head/veilstrider_head.vmdl",
            "models/items/phantom_assassin/veilstrider_legs/veilstrider_legs.vmdl",
            "models/items/phantom_assassin/veilstrider_weapon/veilstrider_weapon.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_back_arcana_refit_1.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana.vmdl",
            "models/items/phantom_assassin/lunar_dragon_pa/lunar_dragon_pa_weapon_arcana_1.vmdl",
        }
    },

    [28324] = 
    {
        ["dota_id"] = 28320,
        ["item_id"] = 28324,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Shadow Stalker - Armor",
        ["icon"] = "econ/items/phantom_assassin/2023panther_shadow_armor/2023panther_shadow_armor",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/2023panther_shadow_armor/2023panther_shadow_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "shadow_stalker",
    },
    [28321] = 
    {
        ["dota_id"] = 28321,
        ["item_id"] = 28321,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Shadow Stalker - Head",
        ["icon"] = "econ/items/phantom_assassin/2023panther_shadow_hair/2023panther_shadow_hair",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/2023panther_shadow_hair/2023panther_shadow_hair.vmdl",
        ["hide"] = 0,
        ["sets"] = "shadow_stalker",
    },
    [28322] = 
    {
        ["dota_id"] = 28322,
        ["item_id"] = 28322,
        ["SlotType"] = "legs_persona_1",
        ["name"] = "Shadow Stalker - Legs",
        ["icon"] = "econ/items/phantom_assassin/2023panther_shadow_belt/2023panther_shadow_belt",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/2023panther_shadow_belt/2023panther_shadow_belt.vmdl",
        ["hide"] = 0,
        ["sets"] = "shadow_stalker",
    },
    [28323] = 
    {
        ["dota_id"] = 28323,
        ["item_id"] = 28323,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Shadow Stalker - Weapon",
        ["icon"] = "econ/items/phantom_assassin/2023panther_shadow_weapon/2023panther_shadow_weapon",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/2023panther_shadow_weapon/2023panther_shadow_weapon.vmdl",
        ["hide"] = 0,
        ["sets"] = "shadow_stalker",
    },

    [31004] = 
    {
        ["dota_id"] = 31004,
        ["item_id"] = 31004,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Phantom's Facade - Armor",
        ["icon"] = "econ/items/phantom_assassin/armor_dark_carnival/armor_dark_carnival",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/armor_dark_carnival/armor_dark_carnival.vmdl",
        ["hide"] = 0,
        ["sets"] = "phantom_facade",
    },
    [31005] = 
    {
        ["dota_id"] = 31005,
        ["item_id"] = 31005,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Phantom's Facade - Head",
        ["icon"] = "econ/items/phantom_assassin/head_dark_carnival/head_dark_carnival",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/head_dark_carnival/head_dark_carnival.vmdl",
        ["hide"] = 0,
        ["sets"] = "phantom_facade",
    },
    [31006] = 
    {
        ["dota_id"] = 31006,
        ["item_id"] = 31006,
        ["SlotType"] = "legs_persona_1",
        ["name"] = "Phantom's Facade - Legs",
        ["icon"] = "econ/items/phantom_assassin/legs_dark_carnival/legs_dark_carnival",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/legs_dark_carnival/legs_dark_carnival.vmdl",
        ["hide"] = 0,
        ["sets"] = "phantom_facade",
    },
    [31007] = 
    {
        ["dota_id"] = 31007,
        ["item_id"] = 31007,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Phantom's Facade - Weapon",
        ["icon"] = "econ/items/phantom_assassin/weapon_dark_carnival/weapon_dark_carnival",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/weapon_dark_carnival/weapon_dark_carnival.vmdl",
        ["hide"] = 0,
        ["sets"] = "phantom_facade",
    },

    [32981] = 
    {
        ["dota_id"] = 32981,
        ["item_id"] = 32981,
        ["SlotType"] = "armor_persona_1",
        ["name"] = "Reaper of the Waning Veil - Armor",
        ["icon"] = "econ/items/phantom_assassin/veilstrider_armor/veilstrider_armor",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/veilstrider_armor/veilstrider_armor.vmdl",
        ["hide"] = 0,
        ["sets"] = "reaper_waning_veil",
    },
    [32982] = 
    {
        ["dota_id"] = 32982,
        ["item_id"] = 32982,
        ["SlotType"] = "head_persona_1",
        ["name"] = "Reaper of the Waning Veil - Head",
        ["icon"] = "econ/items/phantom_assassin/veilstrider_head/veilstrider_head",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/veilstrider_head/veilstrider_head.vmdl",
        ["hide"] = 0,
        ["sets"] = "reaper_waning_veil",
    },
    [32983] = 
    {
        ["dota_id"] = 32983,
        ["item_id"] = 32983,
        ["SlotType"] = "legs_persona_1",
        ["name"] = "Reaper of the Waning Veil - Legs",
        ["icon"] = "econ/items/phantom_assassin/veilstrider_legs/veilstrider_legs",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/veilstrider_legs/veilstrider_legs.vmdl",
        ["hide"] = 0,
        ["sets"] = "reaper_waning_veil",
    },
    [32984] = 
    {
        ["dota_id"] = 32984,
        ["item_id"] = 32984,
        ["SlotType"] = "weapon_persona_1",
        ["name"] = "Reaper of the Waning Veil - Weapon",
        ["icon"] = "econ/items/phantom_assassin/veilstrider_weapon/veilstrider_weapon",
        ["price"] = 250,
        ["ItemModel"] = "models/items/phantom_assassin/veilstrider_weapon/veilstrider_weapon.vmdl",
        ["hide"] = 0,
        ["sets"] = "reaper_waning_veil",
    },



    [36069] = {
['item_id'] =36069,
['name'] ='The Last Laugh - Weapon',
['icon'] ='econ/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_weapon',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_weapon.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'weapon',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'last_laugh',
},
[36070] = {
['item_id'] =36070,
['name'] ='The Last Laugh - Head',
['icon'] ='econ/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_head',
['price'] = 800,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'last_laugh',
},
[36071] = {
['item_id'] =36071,
['name'] ='The Last Laugh - Shoulder',
['icon'] ='econ/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_shoulders',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_shoulders.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'shoulder',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'last_laugh',
},
[36072] = {
['item_id'] =36072,
['name'] ='The Last Laugh - Back',
['icon'] ='econ/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_back',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'last_laugh',
},
[36073] = {
['item_id'] =36073,
['name'] ='The Last Laugh - Belt',
['icon'] ='econ/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_belt',
['price'] = 600,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/phantom_assassin/phantom_assassin_dark_carnival/phantom_assassin_dark_carnival_belt.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'belt',
['RemoveDefaultItemsList'] = nil,
['Modifier'] = nil,
['sets'] = 'last_laugh',
},
}