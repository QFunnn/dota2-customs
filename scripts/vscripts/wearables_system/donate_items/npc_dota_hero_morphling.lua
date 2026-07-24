--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return 
{
    [7603] = 
    {
        ['item_id'] =7603,
        ['name'] ='Crown of Tears',
        ['icon'] ='econ/items/morphling/crown_of_tears/mesh/crown_of_tears_model',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/crown_of_tears/mesh/crown_of_tears_model.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_morphling_crown_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_head"
                    },
                    [1] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_crown"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform.vpcf",
            "particles/econ/items/morphling/morphling_crown_of_tears/morphling_crown_waveform_dmg.vpcf",
            "particles/morphling/waveform_target_immortal.vpcf",
        }
    },
    [6833] = 
    {
        ['item_id'] =6833,
        ['name'] ='Blade of Tears',
        ['icon'] ='econ/items/morphling/ethereal_blade/ethereal_blade',
        ['price'] = 3000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/ethereal_blade/ethereal_blade.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_morphling_blade_tears_custom",
        ['sets'] = 'rare',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morphling_ethereal/morphling_ethereal_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade_r"
                    },
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_blade_l"
                    },
                }
            }
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/morphling/morphling_ethereal/morphling_adaptive_strike_ethereal.vpcf",
            "particles/morphling/adaptive_aoe_immortal.vpcf",
        }
    },
    [7558] = 
    {
        ['item_id'] =7558,
        ['name'] ='Grip of the Lost Star',
        ['icon'] ='econ/items/morphling/skadi_rising_misc/skadi_rising_misc',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/skadi_rising_misc/skadi_rising_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_lost_star',
    },
    [7559] = 
    {
        ['item_id'] =7559,
        ['name'] ='Eye of the Lost Star',
        ['icon'] ='econ/items/morphling/skadi_rising_back/skadi_rising_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/skadi_rising_back/skadi_rising_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_lost_star',
    },
    [7560] = 
    {
        ['item_id'] =7560,
        ['name'] ='Scowl of the Lost Star',
        ['icon'] ='econ/items/morphling/skadi_rising_head/skadi_rising_head',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/skadi_rising_head/skadi_rising_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_lost_star',
    },
    [7561] = 
    {
        ['item_id'] =7561,
        ['name'] ='Spines of the Lost Star',
        ['icon'] ='econ/items/morphling/skadi_rising_shoulders/skadi_rising_shoulders',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/skadi_rising_shoulders/skadi_rising_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_lost_star',
    },
    [7562] = 
    {
        ['item_id'] =7562,
        ['name'] ='Bracers of the Lost Star',
        ['icon'] ='econ/items/morphling/skadi_rising_arms/skadi_rising_arms',
        ['price'] = 400,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/skadi_rising_arms/skadi_rising_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_lost_star',
    },
    [19163] = 
    {
        ['item_id'] =19163,
        ['name'] ='Darktrench Stalker - Back',
        ['icon'] ='econ/items/morphling/abyss_overlord_back/abyss_overlord_back',
        ['price'] = 2000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/abyss_overlord_back/abyss_overlord_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_darktrench',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morph_abyss_overlord/morph_abyss_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                    [2] = {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_tail"
                    },
                }
            }
        },
    },
    [19164] = 
    {
        ['item_id'] =19164,
        ['name'] ='Darktrench Stalker - Head',
        ['icon'] ='econ/items/morphling/abyss_overlord_head/abyss_overlord_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/abyss_overlord_head/abyss_overlord_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_darktrench',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morph_abyss_overlord/morph_abyss_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [19166] = 
    {
        ['item_id'] =19166,
        ['name'] ='Darktrench Stalker - Arms',
        ['icon'] ='econ/items/morphling/abyss_overlord_arms/abyss_overlord_arms',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/abyss_overlord_arms/abyss_overlord_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_darktrench',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morph_abyss_overlord/morph_abyss_arms_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [19167] = 
    {
        ['item_id'] =19167,
        ['name'] ='Darktrench Stalker - Misc',
        ['icon'] ='econ/items/morphling/abyss_overlord_misc/abyss_overlord_misc',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/abyss_overlord_misc/abyss_overlord_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_darktrench',
    },
    [19168] = 
    {
        ['item_id'] =19168,
        ['name'] ='Darktrench Stalker - Shoulder',
        ['icon'] ='econ/items/morphling/abyss_overlord_shoulder/abyss_overlord_shoulder',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/abyss_overlord_shoulder/abyss_overlord_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_darktrench',
        ["ParticlesItems"] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/morph_abyss_overlord/morph_abyss_shoulder_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = {
                    [0] = {"SetParticleControl", "default"},
                }
            }
        },
    },
    [8806] = 
    {
        ['item_id'] =8806,
        ['name'] ='Crown of the Protean Emperor',
        ['icon'] ='econ/items/morphling/emperor_of_the_sea_head/emperor_of_the_sea_head',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/emperor_of_the_sea_head/emperor_of_the_sea_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_protean_emperor',
    },
    [8807] = 
    {
        ['item_id'] =8807,
        ['name'] ='Ornaments of the Protean Emperor',
        ['icon'] ='econ/items/morphling/emperor_of_the_sea_misc/emperor_of_the_sea_misc',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/emperor_of_the_sea_misc/emperor_of_the_sea_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_protean_emperor',
    },
    [8810] = 
    {
        ['item_id'] =8810,
        ['name'] ='Spikes of the Protean Emperor',
        ['icon'] ='econ/items/morphling/emperor_of_the_sea_back/emperor_of_the_sea_back',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/emperor_of_the_sea_back/emperor_of_the_sea_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_protean_emperor',
    },
    [8808] = 
    {
        ['item_id'] =8808,
        ['name'] ='Pauldrons of the Protean Emperor',
        ['icon'] ='econ/items/morphling/emperor_of_the_sea_shoulder/emperor_of_the_sea_shoulder',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/emperor_of_the_sea_shoulder/emperor_of_the_sea_shoulder.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_protean_emperor',
    },
    [8809] = 
    {
        ['item_id'] =8809,
        ['name'] ='Bracers of the Protean Emperor',
        ['icon'] ='econ/items/morphling/emperor_of_the_sea_arms/emperor_of_the_sea_arms',
        ['price'] = 200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/emperor_of_the_sea_arms/emperor_of_the_sea_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'morph_protean_emperor',
    },

    [33035] = 
    {
        ['item_id'] =33035,
        ['name'] ='Fluid Frenzy - Head',
        ['icon'] ='econ/items/morphling/tritons_revenge_head/tritons_revenge_head',
        ['price'] = 1200,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/tritons_revenge_head/tritons_revenge_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fluid_frenzy',
    },
    [33037] = 
    {
        ['item_id'] =33037,
        ['name'] ='Fluid Frenzy - Misc',
        ['icon'] ='econ/items/morphling/tritons_revenge_misc/tritons_revenge_misc',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/tritons_revenge_misc/tritons_revenge_misc.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'misc',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fluid_frenzy',
    },
    [33039] = 
    {
        ['item_id'] =33039,
        ['name'] ='Fluid Frenzy - Shoulders',
        ['icon'] ='econ/items/morphling/tritons_revenge_shoulders/tritons_revenge_shoulders',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/tritons_revenge_shoulders/tritons_revenge_shoulders.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'shoulder',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_morphing_fluid_frenzy",
        ['sets'] = 'fluid_frenzy',
        ["OtherModelsPrecache"] =
        {
            "models/items/morphling/tritons_revenge_shoulders/tritons_revenge_shoulders_water.vmdl"
        },
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/morphling/tritons_revenge/tritons_revenge_shoulders_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [33038] = 
    {
        ['item_id'] =33038,
        ['name'] ='Fluid Frenzy - Back',
        ['icon'] ='econ/items/morphling/tritons_revenge_back/tritons_revenge_back',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/tritons_revenge_back/tritons_revenge_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fluid_frenzy',
    },
    [33036] = 
    {
        ['item_id'] =33036,
        ['name'] ='Fluid Frenzy - Arms',
        ['icon'] ='econ/items/morphling/tritons_revenge_arms/tritons_revenge_arms',
        ['price'] = 600,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/morphling/tritons_revenge_arms/tritons_revenge_arms.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'arms',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'fluid_frenzy',
    },
    [36193] = 
    {
        ["dota_id"] = 36193,
        ['item_id'] = 36193,
        ['name'] = "Morphling Automaton Persona",
        ['icon'] = "econ/heroes/morphling_automaton/morphling_automaton",
        ['price'] = 8000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/items/morphling/morphling_automaton/morphling_automaton.vmdl",
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