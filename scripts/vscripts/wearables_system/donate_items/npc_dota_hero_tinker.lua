--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [6224] = 
    {
        ['item_id'] =6224,
        ['name'] ='Mecha Boots of Travel Mk III',
        ['icon'] ='econ/items/tinker/boots_of_travel',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/boots_of_travel.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_tinker_boots_of_travel_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/boots_of_travel/tinker_bots_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_r_out"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_l_out"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_r_front"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_l_front"},
                    [4] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_r_back"},
                    [5] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_boot_l_back"},
                }
            },
        },
    },
    [7143] = 
    {
        ['item_id'] =7143,
        ['name'] ='Rollermawster',
        ['icon'] ='econ/items/tinker/roller_mawster/roller_mawster',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/roller_mawster/roller_mawster.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_tinker_roller_mawster_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermawster_ambient_ears.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "fx_left_ear"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermawster_ambient_pipe.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "fx_pipesmoke"},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermawster_ambient_ears_other.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "fx_right_ear"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermaw.vpcf",
            "particles/econ/items/tinker/tinker_motm_rollermaw/tinker_rollermaw_motm.vpcf",
        }
    },
    [13777] = 
    {
        ['item_id'] =13777,
        ['name'] ='Arcanic Resonance Beam',
        ['icon'] ='econ/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_laser',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_laser.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_tinker_ti10_immortal_laser_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_dome"},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_laser.vpcf"
        }
    },
    [26839] = 
    {
        ['item_id'] =26839,
        ['name'] ='Twitcher - Back',
        ['icon'] ='econ/items/tinker/tinker_soul_camera_back/tinker_soul_camera_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_soul_camera_back/tinker_soul_camera_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_twitcher',
    },
    [26841] = 
    {
        ['item_id'] =26841,
        ['name'] ='Twitcher - Offhand Weapon',
        ['icon'] ='econ/items/tinker/tinker_soul_camera_offhand_weapon/tinker_soul_camera_offhand_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_soul_camera_offhand_weapon/tinker_soul_camera_offhand_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_twitcher',
    },
    [26842] = 
    {
        ['item_id'] =26842,
        ['name'] ='Twitcher - Shoulder',
        ['icon'] ='econ/items/tinker/tinker_soul_camera_shoulder/tinker_soul_camera_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_soul_camera_shoulder/tinker_soul_camera_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_twitcher',
    },
    [26843] = 
    {
        ['item_id'] =26843,
        ['name'] ='Twitcher - Weapon',
        ['icon'] ='econ/items/tinker/tinker_soul_camera_weapon/tinker_soul_camera_weapon',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_soul_camera_weapon/tinker_soul_camera_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_twitcher',
    },
    [26840] = 
    {
        ['item_id'] =26840,
        ['name'] ='Twitcher - Head',
        ['icon'] ='econ/items/tinker/tinker_soul_camera_head/tinker_soul_camera_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_soul_camera_head/tinker_soul_camera_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_twitcher',
    },
    [7970] = 
    {
        ['item_id'] =7970,
        ['name'] ='Cannon of the Fortified Fabricator',
        ['icon'] ='econ/items/tinker/artillery_of_the_fortified_fabricator_weapon_alt/artillery_of_the_fortified_fabricator_weapon_alt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/artillery_of_the_fortified_fabricator_weapon_alt/artillery_of_the_fortified_fabricator_weapon_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_fabricator',
    },
    [7972] = 
    {
        ['item_id'] =7972,
        ['name'] ='Controls of the Fortified Fabricator',
        ['icon'] ='econ/items/tinker/artillery_of_the_fortified_fabricator_back_alt/artillery_of_the_fortified_fabricator_back_alt',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/artillery_of_the_fortified_fabricator_back_alt/artillery_of_the_fortified_fabricator_back_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_fabricator',
    },
    [7969] = 
    {
        ['item_id'] =7969,
        ['name'] ='Shoulders of the Fortified Fabricator',
        ['icon'] ='econ/items/tinker/artillery_of_the_fortified_fabricator_shoulder_alt/artillery_of_the_fortified_fabricator_shoulder_alt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/artillery_of_the_fortified_fabricator_shoulder_alt/artillery_of_the_fortified_fabricator_shoulder_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_fabricator',
    },
    [7968] = 
    {
        ['item_id'] =7968,
        ['name'] ='Ballista of the Fortified Fabricator',
        ['icon'] ='econ/items/tinker/artillery_of_the_fortified_fabricator_off_hand_alt/artillery_of_the_fortified_fabricator_off_hand_alt',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/artillery_of_the_fortified_fabricator_off_hand_alt/artillery_of_the_fortified_fabricator_off_hand_alt.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_fabricator',
    },
    [7967] = 
    {
        ['item_id'] =7967,
        ['name'] ='Helmet of the Fortified Fabricator',
        ['icon'] ='econ/items/tinker/artillery_of_the_fortified_fabricator_head/artillery_of_the_fortified_fabricator_head',
        ['price'] = 300,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/artillery_of_the_fortified_fabricator_head/artillery_of_the_fortified_fabricator_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_fabricator',
    },
    [9264] = 
    {
        ['item_id'] =9264,
        ['name'] ='Submerged Hazard Launcher',
        ['icon'] ='econ/items/tinker/deep_sea_robot_off_hand/deep_sea_robot_off_hand',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/deep_sea_robot_off_hand/deep_sea_robot_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_hazard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_deepsea/tinker_deepsea_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_barrel1"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_barrel2"},
                    [3] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_barrel3"},
                }
            },
        },
    },
    [9265] = 
    {
        ['item_id'] =9265,
        ['name'] ='Submerged Hazard Mask',
        ['icon'] ='econ/items/tinker/deep_sea_robot_head/deep_sea_robot_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/deep_sea_robot_head/deep_sea_robot_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_hazard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_deepsea/tinker_deepsea_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_airhole_r"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_airhole_r"},
                    [2] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_airhole_l"},
                }
            },
        },
    },
    [9266] = 
    {
        ['item_id'] =9266,
        ['name'] ='Submerged Hazard Hull',
        ['icon'] ='econ/items/tinker/deep_sea_robot_shoulder/deep_sea_robot_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/deep_sea_robot_shoulder/deep_sea_robot_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_hazard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_deepsea/tinker_deepsea_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_nozzle"},
                }
            },
        },
    },
    [9267] = 
    {
        ['item_id'] =9267,
        ['name'] ='Submerged Hazard Laser',
        ['icon'] ='econ/items/tinker/deep_sea_robot_weapon/deep_sea_robot_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/deep_sea_robot_weapon/deep_sea_robot_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_hazard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_deepsea/tinker_deepsea_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_weapon"},
                }
            },
        },
    },
    [9268] = 
    {
        ['item_id'] =9268,
        ['name'] ='Submerged Hazard Propeller',
        ['icon'] ='econ/items/tinker/deep_sea_robot_back/deep_sea_robot_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/deep_sea_robot_back/deep_sea_robot_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_hazard',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_deepsea/tinker_deepsea_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_bacck"},
                    [1] = {'SetParticleControlEnt', PATTACH_POINT_FOLLOW, "attach_bacck"},
                }
            },
        },
    },
    [14065] = 
    {
        ['item_id'] =14065,
        ['name'] ='Blackshield Protodrone Armor',
        ['icon'] ='econ/items/tinker/mecha_hornet_shoulder/mecha_hornet_shoulder',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/mecha_hornet_shoulder/mecha_hornet_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blackshield_protodrone',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_mecha_hornet/tinker_mecha_hornet_shoulder.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_chest_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_gem_fx"
                    },
                }
            }
        },
    },
    [14066] = 
    {
        ['item_id'] =14066,
        ['name'] ='Blackshield Protodrone Missile Launcher',
        ['icon'] ='econ/items/tinker/mecha_hornet_off_hand/mecha_hornet_off_hand',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/mecha_hornet_off_hand/mecha_hornet_off_hand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blackshield_protodrone',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_mecha_hornet/tinker_mecha_hornet_offhand.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_rocket_fx_01"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_rocket_fx_02"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_rocket_fx_03"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bind_fx_01"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bind_fx_02"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_rear_fx"
                    },
                }
            }
        },
    },
    [14067] = 
    {
        ['item_id'] =14067,
        ['name'] ='Blackshield Protodrone Helm',
        ['icon'] ='econ/items/tinker/mecha_hornet_head/mecha_hornet_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/mecha_hornet_head/mecha_hornet_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blackshield_protodrone',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_mecha_hornet/tinker_mecha_hornet_head.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_antenna_l_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_antenna_r_fx"
                    },
                }
            }
        },
    },
    [14063] = 
    {
        ['item_id'] =14063,
        ['name'] ='Blackshield Protodrone Stinger',
        ['icon'] ='econ/items/tinker/mecha_hornet_back/mecha_hornet_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/mecha_hornet_back/mecha_hornet_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blackshield_protodrone',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_mecha_hornet/tinker_mecha_hornet_back.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail_tip_fx"
                    },
                }
            }
        },
    },
    [14064] = 
    {
        ['item_id'] =14064,
        ['name'] ='Blackshield Protodrone Laser',
        ['icon'] ='econ/items/tinker/mecha_hornet_weapon/mecha_hornet_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/mecha_hornet_weapon/mecha_hornet_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'blackshield_protodrone',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_mecha_hornet/tinker_mecha_hornet_laser.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_laser_core_fx"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_laser_fx_01"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_laser_fx_02"
                    },
                    [4] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_laser_fx_03"
                    },
                    [5] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bind_fx_01"
                    },
                    [6] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_bind_fx_02"
                    },
                    [7] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_rear_fx"
                    },
                }
            }
        },
    },
    [34370] = 
    {
        ['item_id'] =34370,
        ['name'] ='Interstellar Astrarium - Weapon',
        ['icon'] ='econ/items/tinker/tinker_cosmic/tinker_cosmic_weapon',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_cosmic/tinker_cosmic_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_cosmic',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_cosmic/tinker_cosmic_weapon_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_light_r"
                    },
                }
            }
        },
    },
    [34369] = 
    {
        ['item_id'] =34369,
        ['name'] ='Interstellar Astrarium - Back',
        ['icon'] ='econ/items/tinker/tinker_cosmic/tinker_cosmic_back',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_cosmic/tinker_cosmic_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_cosmic',
    },
    [34367] = 
    {
        ['item_id'] =34367,
        ['name'] ='Interstellar Astrarium - Head',
        ['icon'] ='econ/items/tinker/tinker_cosmic/tinker_cosmic_head',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_cosmic/tinker_cosmic_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_tinker_cosmic_head",
        ['sets'] = 'rare',
        ["ParticlesSkills"] =
        {
            "particles/econ/items/tinker/tinker_cosmic/tinker_cosmic_mom.vpcf",
        }
    },
    [34368] = 
    {
        ['item_id'] =34368,
        ['name'] ='Interstellar Astrarium - Shoulder',
        ['icon'] ='econ/items/tinker/tinker_cosmic/tinker_cosmic_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_cosmic/tinker_cosmic_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_cosmic',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_cosmic/tinker_cosmic_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_r"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hand_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ambient"
                    },
                    [3] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_ambient"
                    },
                }
            }
        },
    },
    [34371] = 
    {
        ['item_id'] =34371,
        ['name'] ='Interstellar Astrarium - Offhand',
        ['icon'] ='econ/items/tinker/tinker_cosmic/tinker_cosmic_offhand',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/tinker/tinker_cosmic/tinker_cosmic_offhand.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'offhand_weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'tinker_cosmic',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/tinker/tinker_cosmic/tinker_cosmic_offhand_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_light_l"
                    },
                }
            }
        },
    },
}