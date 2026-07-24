--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
    [59571] = 
    {
        ['item_id'] =59571,
        ['name'] ='Prismatic Gems',
        ['icon'] ='econ/tools/crownfall_screeauk_treasure_3',
        ['price'] = 1,
        ['chest_id'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
    },

    [5957] = 
    {
        ['item_id'] =5957,
        ['name'] ='Fractal Horns of Inner Abysm',
        ['icon'] ='econ/heroes/terrorblade/arcana_terrorblade',
        ['price'] = 10000,
        ['sale'] = 0,
        ['sale_price'] = 0,
        ['HeroModel'] = "models/heroes/terrorblade/terrorblade_arcana.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/terrorblade/horns_arcana.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ["is_exclusive"] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_eyes_arcana_horns.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
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
                        "attach_head"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_mouth"
                    },
                    [15] = {'SetParticleControl', {255, 60, 40}},
                    [16] = {'SetParticleControl', {1, 1, 1}},
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_body_arcana_horns.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ['IsHero'] = 1,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_hitloc"
                    },
                    [15] = {'SetParticleControl', {255, 60, 40}},
                    [16] = {'SetParticleControl', {1, 1, 1}},
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf",
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf",
        }
    },

    [59572] = 
    {
        ['item_id'] =59572,
        ['name'] ='Midas Gold',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_2",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf",
        }
    },

    [59573] = 
    {
        ['item_id'] =59573,
        ['name'] ='Blue',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_3",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf",
        }
    },

    [59574] = 
    {
        ['item_id'] =59574,
        ['name'] ='Ships in the night',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_4",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf",
        }
    },

    [59575] = 
    {
        ['item_id'] =59575,
        ['name'] ='Purple',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_5",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf",
        }
    },

    [59576] = 
    {
        ['item_id'] =59576,
        ['name'] ='Diretide Orange',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_6",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf",
        }
    },

    [59577] = 
    {
        ['item_id'] =59577,
        ['name'] ='Champion Green',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_7",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf",
        }
    },

    [59578] = 
    {
        ['item_id'] =59578,
        ['name'] ='Sea Green',
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_8",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf",
        }
    },

    [59579] = 
    {
        ['item_id'] =59579,
        ['name'] ='Creator Light',        
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_9",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf",
        }
    },

    [59580] = 
    {
        ['item_id'] =59580,
        ['name'] ='Rubline',        
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_10",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf",
        }
    },

    [59581] = 
    {
        ['item_id'] =59581,
        ['name'] ='Cursed Black',        
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_11",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf",
        }
    },

    [59582] = 
    {
        ['item_id'] =59582,
        ['name'] ='Brusque Britches Beige',        
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_12",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf",
        }
    },

    [59583] = 
    {
        ['item_id'] =59583,
        ['name'] ='Plushy Shag',        
        ['icon'] ='econ/sockets/gem_color',
        ['price'] = 0,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] = nil,
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'terrorblade_gem',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_arcana_custom_13",
        ['sets'] = 'terrorblade_arcana',
        ['ParticlesHero'] = nil,
        ["ParticlesSkills"] =
        {
            "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf",
            "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf",
        }
    },

    ---------------------------
    ---------------------------
    ---------------------------

    [9497] = 
    {
        ['item_id'] =9497,
        ['name'] ='Armor of the Foulfell Corruptor',
        ['icon'] ='econ/items/terrorblade/knight_of_foulfell_terrorblade_armor/knight_of_foulfell_terrorblade_armor',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/knight_of_foulfell_terrorblade_armor/knight_of_foulfell_terrorblade_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_foulfell',
    },
    [9498] = 
    {
        ['item_id'] =9498,
        ['name'] ='Helm of the Foulfell Corruptor',
        ['icon'] ='econ/items/terrorblade/knight_of_foulfell_terrorblade_head/knight_of_foulfell_terrorblade_head',
        ['price'] = 800,
        ['HeroModel'] = "models/heroes/terrorblade/terrorblade.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/knight_of_foulfell_terrorblade_head/knight_of_foulfell_terrorblade_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_foulfell',
    },
    [9499] = 
    {
        ['item_id'] =9499,
        ['name'] ='Wings of the Foulfell Corruptor',
        ['icon'] ='econ/items/terrorblade/knight_of_foulfell_terrorblade_back/knight_of_foulfell_terrorblade_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/knight_of_foulfell_terrorblade_back/knight_of_foulfell_terrorblade_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_foulfell',
    },
    
    [14340] = 
    {
        ['item_id'] =14340,
        ['name'] ='Chasm of the Broken Code Helm',
        ['icon'] ='econ/items/terrorblade/tb_samurai_head/tb_samurai_head',
        ['price'] = 250,
        ['HeroModel'] = "models/heroes/terrorblade/terrorblade.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/tb_samurai_head/tb_samurai_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_chasm',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/tb_samura_head/tb_samurai_head_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [9] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "mouth"
                    },
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_l"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "eye_r"
                    },
                }
            },
        },
    },
    [14341] = 
    {
        ['item_id'] =14341,
        ['name'] ='Chasm of the Broken Code Wings',
        ['icon'] ='econ/items/terrorblade/tb_samurai_back/tb_samurai_back',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/tb_samurai_back/tb_samurai_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_chasm',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/tb_samurai_back/tb_samurai_back_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                }
            },
        },
    },
    [14342] = 
    {
        ['item_id'] =14342,
        ['name'] ='Chasm of the Broken Code Armor',
        ['icon'] ='econ/items/terrorblade/tb_samurai_armor/tb_samurai_armor',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/tb_samurai_armor/tb_samurai_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_chasm',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/tb_samurai_armor/tb_samurai_armor_ambient.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [11] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "arm_r"
                    },
                    [12] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "arm_l"
                    },
                }
            },
        },
    },
    [26447] = 
    {
        ['item_id'] =26447,
        ['name'] ='Forgotten Station - Head',
        ['icon'] ='econ/items/terrorblade/terrorblade_ultimate_depravity_head/terrorblade_ultimate_depravity_head',
        ['price'] = 1000,
        ['HeroModel'] = "models/heroes/terrorblade/terrorblade.vmdl",
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/terrorblade_ultimate_depravity_head/terrorblade_ultimate_depravity_head.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'head',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_forgotten',
    },
    [26449] = 
    {
        ['item_id'] =26449,
        ['name'] ='Forgotten Station - Back',
        ['icon'] ='econ/items/terrorblade/terrorblade_ultimate_depravity_back/terrorblade_ultimate_depravity_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/terrorblade_ultimate_depravity_back/terrorblade_ultimate_depravity_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_forgotten',
    },
    [26445] = 
    {
        ['item_id'] =26445,
        ['name'] ='Forgotten Station - Armor',
        ['icon'] ='econ/items/terrorblade/terrorblade_ultimate_depravity_armor/terrorblade_ultimate_depravity_armor',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/terrorblade_ultimate_depravity_armor/terrorblade_ultimate_depravity_armor.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'armor',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_forgotten',
    },
    [7404] = 
    {
        ["item_id"] = 7404,
        ["name"] = "Form of the Baleful Hollow",
        ["icon"] = "econ/items/terrorblade/corrupted_form/corrupted_form",
        ["price"] = 500,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_1",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/corrupted_form.vmdl"
        }
    },
    [9501] = 
    {
        ["item_id"] = 9501,
        ["name"] = "Demon Form of the Foulfell Corruptor",
        ["icon"] = "econ/items/terrorblade/knight_of_foulfell_demon/knight_of_foulfell_demon",
        ["price"] = 3000,
        ["HeroModel"] = nil,
        ["ArcanaAnim"] = nil,
        ["MaterialGroup"] = nil,
        ["ItemModel"] = "",
        ["ParticlesItems"] = nil,
        ["ParticlesHero"] = nil,
        ["SetItems"] = nil,
        ["hide"] = 0,
        ["OtherItemsBundle"] = nil,
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_2",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/knight_of_foulfell_demon.vmdl"
        }
    },
    [14339] = 
    {
        ["item_id"] = 14339,
        ["name"] = "Chasm of the Broken Code Demon",
        ["icon"] = "econ/items/terrorblade/tb_samurai_samurai_demon/tb_samurai_samurai_demon",
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
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_3",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/tb_samurai_samurai_demon.vmdl"
        }
    },
    [7033] = 
    {
        ["item_id"] = 7033,
        ["name"] = "Marauder's Demon Form",
        ["icon"] = "econ/items/terrorblade/marauders_demon/marauders_demon",
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
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_4",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/marauders_demon.vmdl"
        }
    },
    [8276] = 
    {
        ["item_id"] = 8276,
        ["name"] = "Form of Eternal Purgatory",
        ["icon"] = "econ/items/terrorblade/endless_purgatory_demon/endless_purgatory_demon",
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
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_5",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/endless_purgatory_demon.vmdl"
        } 
    },
    [26446] = 
    {
        ["item_id"] = 26446,
        ["name"] = "Forgotten Station - Demon",
        ["icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_ability/terrorblade_ultimate_depravity_ability",
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
        ["SlotType"] = "terrorblade_form",
        ["RemoveDefaultItemsList"] = {},
        ["Modifier"] = "modifier_terrorblade_demon_custom_6",
        ['sets'] = "terrorblade_forms",
        ["OtherModelsPrecache"] =
        {
            "models/terrorblade_custom/terrorblade_ultimate_depravity_ability.vmdl"
        }
    },
    
    [12917] = 
    {
        ['item_id'] =12917,
        ['name'] ='Scythes of Sorrow',
        ['icon'] ='econ/items/terrorblade/tb_ti9_immortal_weapon/tb_ti9_immortal_weapon',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/tb_ti9_immortal_weapon/tb_ti9_immortal_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_immortal_weapon_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_weapon.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_left"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_right"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_left"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_weapon_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_left"
                    },
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_right"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_fx_left"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_metamorphosis_base_attack.vpcf",
        }
    },
    [26448] = 
    {
        ['item_id'] =26448,
        ['name'] ='Forgotten Station - Weapon',
        ['icon'] ='econ/items/terrorblade/terrorblade_ultimate_depravity_weapon/terrorblade_ultimate_depravity_weapon',
        ['price'] = 800,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/terrorblade_ultimate_depravity_weapon/terrorblade_ultimate_depravity_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_forgotten',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/terrorblade_custom/ultimate_right.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/terrorblade_custom/ultimate_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [9500] = 
    {
        ['item_id'] =9500,
        ['name'] ='Blades of the Foulfell Corruptor',
        ['icon'] ='econ/items/terrorblade/knight_of_foulfell_terrorblade_weapon/knight_of_foulfell_terrorblade_weapon',
        ['price'] = 1500,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/knight_of_foulfell_terrorblade_weapon/knight_of_foulfell_terrorblade_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_foulfell',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/terrorblade_custom/knight_right.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/terrorblade_custom/knight_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [8179] = 
    {
        ['item_id'] =8179,
        ['name'] ='Curse of Eternal Purgatory',
        ['icon'] ='econ/items/terrorblade/endless_purgatory_weapon/endless_purgatory_weapon',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/endless_purgatory_weapon/endless_purgatory_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'weapon',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/terrorblade_custom/endless_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/terrorblade_custom/endless_right.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
        },
    },
    [7406] = 
    {
        ['item_id'] =7406,
        ['name'] ='Blades of the Baleful Hollow',
        ['icon'] ='econ/items/terrorblade/corrupted_weapons/corrupted_weapons',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/corrupted_weapons/corrupted_weapons.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'weapon',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_l.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_r.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted_2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [307] = 
    {
        ['item_id'] =307,
        ['name'] ='Terrorblades Weapons',
        ['icon'] ='econ/heroes/terrorblade/weapon',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/heroes/terrorblade/weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'weapon',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
            {
                ["ParticleName"] = "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },
    [7035] = 
    {
        ['item_id'] =7035,
        ['name'] ='Marauders Blades',
        ['icon'] ='econ/items/terrorblade/marauders_weapon/marauders_weapon',
        ['price'] = 1,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/marauders_weapon/marauders_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 1,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'weapon',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/terrorblade_custom/mara_right.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/terrorblade_custom/mara_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },

            {
                ["ParticleName"] = "particles/terrorblade_custom/mara_blade.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/terrorblade_custom/mara_blade_2.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_l", "hero"
                    },
                }
            },
        },
    },


    [14338] = 
    {
        ['item_id'] =14338,
        ['name'] ='Chasm of the Broken Code Weapon',
        ['icon'] ='econ/items/terrorblade/tb_samurai_weapon/tb_samurai_weapon',
        ['price'] = 250,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/tb_samurai_weapon/tb_samurai_weapon.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'weapon',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = nil,
        ['sets'] = 'terror_chasm',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/terrorblade_custom/samurai_right.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
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
                ["ParticleName"] = "particles/terrorblade_custom/samurai_left.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_weapon_r", "hero"
                    },
                }
            },
        },
    },

    [9750] = 
    {
        ['item_id'] =9750,
        ['name'] ='Span of Sorrow',
        ['icon'] ='econ/items/terrorblade/terrorblade_ti8_immortal_back/terrorblade_ti8_immortal_back',
        ['price'] = 1000,
        ['HeroModel'] = nil,
        ['ArcanaAnim'] = nil,
        ['MaterialGroup'] = nil,
        ['ItemModel'] ='models/items/terrorblade/terrorblade_ti8_immortal_back/terrorblade_ti8_immortal_back.vmdl',
        ['SetItems'] = nil,
        ['hide'] = 0,
        ['OtherItemsBundle'] = nil,
        ['SlotType'] = 'back',
        ['RemoveDefaultItemsList'] = nil,
        --['Modifier'] = "modifier_terrorblade_immortal_back_custom",
        ['sets'] = 'rare',
        ['ParticlesItems'] = 
        {
            {
                ["ParticleName"] = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_back_ambient_ti8.vpcf",
                ["DefaultPattch"] = PATTACH_ABSORIGIN_FOLLOW,
                ["ControllPoints"] = 
                {
                    [0] = {"SetParticleControl", "default"},
                    [1] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_l"
                    },
                    [2] = 
                    {
                        'SetParticleControlEnt', PATTACH_POINT_FOLLOW,
                        "attach_wing_r"
                    },
                }
            },
        },
        ["ParticlesSkills"] =
        {
            "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8.vpcf"
        }
    },
}




--[[


[8176] = {
['item_id'] =8176,
['name'] ='Collar of Eternal Purgatory',
['icon'] ='econ/items/terrorblade/endless_purgatory_armor/endless_purgatory_armor',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/endless_purgatory_armor/endless_purgatory_armor.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'armor',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'armor',
},
[8177] = {
['item_id'] =8177,
['name'] ='Wings of Eternal Purgatory',
['icon'] ='econ/items/terrorblade/endless_purgatory_back/endless_purgatory_back',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/endless_purgatory_back/endless_purgatory_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'back',
},
[8178] = {
['item_id'] =8178,
['name'] ='Horns of Eternal Purgatory',
['icon'] ='econ/items/terrorblade/endless_purgatory_head/endless_purgatory_head',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/endless_purgatory_head/endless_purgatory_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'head',
},

[7405] = {
['item_id'] =7405,
['name'] ='Horns of the Baleful Hollow',
['icon'] ='econ/items/terrorblade/corrupted_horns/corrupted_horns',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/corrupted_horns/corrupted_horns.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'head',
},


[476] = {
['item_id'] =476,
['name'] ='Terrorblade's Armor',
['icon'] ='econ/heroes/terrorblade/armor',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/heroes/terrorblade/armor.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'armor',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'armor',
},
[478] = {
['item_id'] =478,
['name'] ='Terrorblade's Head',
['icon'] ='econ/heroes/terrorblade/horns',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/heroes/terrorblade/horns.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'head',
},
[306] = {
['item_id'] =306,
['name'] ='Terrorblade's Wings',
['icon'] ='econ/heroes/terrorblade/wings',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/heroes/terrorblade/wings.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'back',
},

[7032] = {
['item_id'] =7032,
['name'] ='Marauder's Armor',
['icon'] ='econ/items/terrorblade/marauders_armor/marauders_armor',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/marauders_armor/marauders_armor.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'armor',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'armor',
},


[7036] = {
['item_id'] =7036,
['name'] ='Marauder's Wings',
['icon'] ='econ/items/terrorblade/marauders_back/marauders_back',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/marauders_back/marauders_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'back',
},
[8106] = {
['item_id'] =8106,
['name'] ='Wings of the Baleful Hollow',
['icon'] ='econ/items/terrorblade/bts_corrupted_lord_back/bts_corrupted_lord_back',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/bts_corrupted_lord_back/bts_corrupted_lord_back.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'back',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'back',
},

[7034] = {
['item_id'] =7034,
['name'] ='Marauder's Crown',
['icon'] ='econ/items/terrorblade/marauders_head/marauders_head',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/marauders_head/marauders_head.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'head',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'head',
},

[8105] = {
['item_id'] =8105,
['name'] ='Plate of the Baleful Hollow',
['icon'] ='econ/items/terrorblade/bts_corrupted_lord_armor/bts_corrupted_lord_armor',
['price'] = 1,
['HeroModel'] = nil,
['ArcanaAnim'] = nil,
['MaterialGroup'] = nil,
['ItemModel'] ='models/items/terrorblade/bts_corrupted_lord_armor/bts_corrupted_lord_armor.vmdl',
['SetItems'] = nil,
['hide'] = 0,
['OtherItemsBundle'] = nil,
['SlotType'] = 'armor',
['RemoveDefaultItemsList'] = nil,
--['Modifier'] = nil,
['sets'] = 'armor',
},




]]