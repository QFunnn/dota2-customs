--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


return
{
	["306"] = {
	["item_id"] = 306,
	["item_name"] = "Terrorblade's Wings",
	["item_icon"] = "econ/heroes/terrorblade/wings",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/heroes/terrorblade/wings.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["307"] = {
	["item_id"] = 307,
	["item_name"] = "Terrorblade's Weapons",
	["item_icon"] = "econ/heroes/terrorblade/weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/heroes/terrorblade/weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["476"] = {
	["item_id"] = 476,
	["item_name"] = "Terrorblade's Armor",
	["item_icon"] = "econ/heroes/terrorblade/armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/heroes/terrorblade/armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["478"] = {
	["item_id"] = 478,
	["item_name"] = "Terrorblade's Head",
	["item_icon"] = "econ/heroes/terrorblade/horns",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/heroes/terrorblade/horns.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["540"] = {
	["item_id"] = 540,
	["item_name"] = "Terrorblade's Ambient Effects",
	["item_icon"] = "econ/testitem_slot_empty",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ambient_effects",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/terrorblade_custom/terrorblade_feet_effects.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["5957"] = {
	["item_id"] = 5957,
	["item_name"] = "Fractal Horns of Inner Abysm",
	["item_icon"] = "econ/heroes/terrorblade/arcana_terrorblade",
	["item_cost"] = 1,
	["item_hero_model"] = "models/heroes/terrorblade/terrorblade_arcana.vmdl",
	["activity_list"] = {
		"abysm",
	},
	["item_material_group"] = nil,
	["item_model"] = "models/heroes/terrorblade/horns_arcana.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "arcana",
	["Modifier"] = "modifier_terrorblade_arcana_custom",
	["visuals_list"] = {
		["ability_icons"] = {
			["default"] = {
				["terrorblade_sunder"] = "terrorblade_sunder_alt1",
				["terrorblade_metamorphosis"] = "terrorblade_metamorphosis_alt1",
				["terrorblade_conjure_image"] = "terrorblade_conjure_image_alt1",
				["terrorblade_reflection"] = "terrorblade_reflection_alt1",
			},
		},
		["particles_list"] = {
			["default"] = {
				"particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_body_arcana_horns.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
			["default"] = {
				["valve_dota_001.stinger.respawn"] = "terrorblade_arcana.stinger.respawn",
				["valve_dota_001.music.killed"] = "terrorblade_arcana.music.killed",
				["valve_dota_001.stinger.buy_back"] = "terrorblade_arcana.stinger.buy_back",
				["valve_dota_001.stinger.buy_back_player"] = "terrorblade_arcana.stinger.buy_back_player",
			},
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf"] = "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_ambient_eyes_arcana_horns.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf",
                ["particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom.vpcf"] = "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom.vpcf",
                ["particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom_pop.vpcf"] = "particles/econ/items/terrorblade/terrorblade_horns_arcana/terrorblade_arcana_enemy_death_custom_pop.vpcf",
			},
		},
	},
	},
	["7032"] = {
	["item_id"] = 7032,
	["item_name"] = "Marauder's Armor",
	["item_icon"] = "econ/items/terrorblade/marauders_armor/marauders_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/marauders_armor/marauders_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "common",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7033"] = {
	["item_id"] = 7033,
	["item_name"] = "Marauder's Demon Form",
	["item_icon"] = "econ/items/terrorblade/marauders_demon/marauders_demon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "rare",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/marauders_demon.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7034"] = {
	["item_id"] = 7034,
	["item_name"] = "Marauder's Crown",
	["item_icon"] = "econ/items/terrorblade/marauders_head/marauders_head",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/marauders_head/marauders_head.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "common",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7035"] = {
	["item_id"] = 7035,
	["item_name"] = "Marauder's Blades",
	["item_icon"] = "econ/items/terrorblade/marauders_weapon/marauders_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/marauders_weapon/marauders_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/terrorblade_custom/mara_blade.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/terrorblade_custom/mara_blade_2.vpcf",
			},
		},
	},
	},
	["7036"] = {
	["item_id"] = 7036,
	["item_name"] = "Marauder's Wings",
	["item_icon"] = "econ/items/terrorblade/marauders_back/marauders_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/marauders_back/marauders_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "rare",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7404"] = {
	["item_id"] = 7404,
	["item_name"] = "Form of the Baleful Hollow",
	["item_icon"] = "econ/items/terrorblade/corrupted_form/corrupted_form",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "rare",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/corrupted_form.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7405"] = {
	["item_id"] = 7405,
	["item_name"] = "Horns of the Baleful Hollow",
	["item_icon"] = "econ/items/terrorblade/corrupted_horns/corrupted_horns",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/corrupted_horns/corrupted_horns.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["7406"] = {
	["item_id"] = 7406,
	["item_name"] = "Blades of the Baleful Hollow",
	["item_icon"] = "econ/items/terrorblade/corrupted_weapons/corrupted_weapons",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/corrupted_weapons/corrupted_weapons.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "rare",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_l.vpcf",
				"particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted.vpcf",
				"particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_corrupted_r.vpcf",
				"particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/econ/items/terrorblade/terrorblade_corrupted_blades/terrorblade_ambient_sword_blade_corrupted.vpcf",
			},
		},
	},
	},
	["8105"] = {
	["item_id"] = 8105,
	["item_name"] = "Plate of the Baleful Hollow",
	["item_icon"] = "econ/items/terrorblade/bts_corrupted_lord_armor/bts_corrupted_lord_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/bts_corrupted_lord_armor/bts_corrupted_lord_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8106"] = {
	["item_id"] = 8106,
	["item_name"] = "Wings of the Baleful Hollow",
	["item_icon"] = "econ/items/terrorblade/bts_corrupted_lord_back/bts_corrupted_lord_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/bts_corrupted_lord_back/bts_corrupted_lord_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8176"] = {
	["item_id"] = 8176,
	["item_name"] = "Collar of Eternal Purgatory",
	["item_icon"] = "econ/items/terrorblade/endless_purgatory_armor/endless_purgatory_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/endless_purgatory_armor/endless_purgatory_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8177"] = {
	["item_id"] = 8177,
	["item_name"] = "Wings of Eternal Purgatory",
	["item_icon"] = "econ/items/terrorblade/endless_purgatory_back/endless_purgatory_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/endless_purgatory_back/endless_purgatory_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8178"] = {
	["item_id"] = 8178,
	["item_name"] = "Horns of Eternal Purgatory",
	["item_icon"] = "econ/items/terrorblade/endless_purgatory_head/endless_purgatory_head",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/endless_purgatory_head/endless_purgatory_head.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "uncommon",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8179"] = {
	["item_id"] = 8179,
	["item_name"] = "Curse of Eternal Purgatory",
	["item_icon"] = "econ/items/terrorblade/endless_purgatory_weapon/endless_purgatory_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/endless_purgatory_weapon/endless_purgatory_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "common",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/terrorblade_custom/endless_right.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/terrorblade_custom/endless_left.vpcf",
			},
		},
	},
	},
	["8276"] = {
	["item_id"] = 8276,
	["item_name"] = "Form of Eternal Purgatory",
	["item_icon"] = "econ/items/terrorblade/endless_purgatory_demon/endless_purgatory_demon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "rare",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/endless_purgatory_demon.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["8650"] = {
	["item_id"] = 8650,
	["item_name"] = "Terrorblade's Demon Form",
	["item_icon"] = "econ/heroes/terrorblade/demon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "common",
	["IsDefaultItem"] = true,
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["9497"] = {
	["item_id"] = 9497,
	["item_name"] = "Armor of the Foulfell Corruptor",
	["item_icon"] = "econ/items/terrorblade/knight_of_foulfell_terrorblade_armor/knight_of_foulfell_terrorblade_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/knight_of_foulfell_terrorblade_armor/knight_of_foulfell_terrorblade_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["9498"] = {
	["item_id"] = 9498,
	["item_name"] = "Helm of the Foulfell Corruptor",
	["item_icon"] = "econ/items/terrorblade/knight_of_foulfell_terrorblade_head/knight_of_foulfell_terrorblade_head",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/knight_of_foulfell_terrorblade_head/knight_of_foulfell_terrorblade_head.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["9499"] = {
	["item_id"] = 9499,
	["item_name"] = "Wings of the Foulfell Corruptor",
	["item_icon"] = "econ/items/terrorblade/knight_of_foulfell_terrorblade_back/knight_of_foulfell_terrorblade_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/knight_of_foulfell_terrorblade_back/knight_of_foulfell_terrorblade_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["9500"] = {
	["item_id"] = 9500,
	["item_name"] = "Blades of the Foulfell Corruptor",
	["item_icon"] = "econ/items/terrorblade/knight_of_foulfell_terrorblade_weapon/knight_of_foulfell_terrorblade_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/knight_of_foulfell_terrorblade_weapon/knight_of_foulfell_terrorblade_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/terrorblade_custom/knight_right.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/terrorblade_custom/knight_left.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf"] = "particles/error/null.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf"] = "particles/error/null.vpcf",
			},
		},
	},
	},
	["9501"] = {
	["item_id"] = 9501,
	["item_name"] = "Demon Form of the Foulfell Corruptor",
	["item_icon"] = "econ/items/terrorblade/knight_of_foulfell_demon/knight_of_foulfell_demon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/knight_of_foulfell_demon.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["9750"] = {
	["item_id"] = 9750,
	["item_name"] = "Span of Sorrow",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ti8_immortal_back/terrorblade_ti8_immortal_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/terrorblade_ti8_immortal_back/terrorblade_ti8_immortal_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "immortal",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
			["0"] = {
				["terrorblade_sunder"] = "terrorblade/ti8_immortal_back/terrorblade_sunder_immortal",
			},
		},
		["particles_list"] = {
			["0"] = {
				"particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_back_ambient_ti8.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_sunder.vpcf"] = "particles/econ/items/terrorblade/terrorblade_back_ti8/terrorblade_sunder_ti8.vpcf",
			},
		},
	},
	},
	["12917"] = {
	["item_id"] = 12917,
	["item_name"] = "Scythes of Sorrow",
	["item_icon"] = "econ/items/terrorblade/tb_ti9_immortal_weapon/tb_ti9_immortal_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/tb_ti9_immortal_weapon/tb_ti9_immortal_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "immortal",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_weapon.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_weapon_left.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf"] = "particles/error/null.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf"] = "particles/error/null.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_base_attack.vpcf"] = "particles/econ/items/terrorblade/terrorblade_ti9_immortal/terrorblade_ti9_immortal_metamorphosis_base_attack.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_13.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_13.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_12.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_12.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_11.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_11.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_10.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_10.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_9.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_9.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_8.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_8.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_7.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_7.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_6.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_6.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_5.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_5.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_4.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_4.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_3.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_3.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_2.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_2.vpcf",
                ["particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_ti9_immortal_metamorphosis_base_attack_1.vpcf",
                ["particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf"] = "particles/terrorblade_custom/terrorblade_metamorphosis_base_attack_1.vpcf",
			},
		},
	},
	},
	["14338"] = {
	["item_id"] = 14338,
	["item_name"] = "Chasm of the Broken Code Weapon",
	["item_icon"] = "econ/items/terrorblade/tb_samurai_weapon/tb_samurai_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/tb_samurai_weapon/tb_samurai_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/terrorblade_custom/samurai_right.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/terrorblade_custom/samurai_left.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf"] = "particles/error/null.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf"] = "particles/error/null.vpcf",
			},
		},
	},
	},
	["14339"] = {
	["item_id"] = 14339,
	["item_name"] = "Chasm of the Broken Code Demon",
	["item_icon"] = "econ/items/terrorblade/tb_samurai_samurai_demon/tb_samurai_samurai_demon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/tb_samurai_samurai_demon.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["14340"] = {
	["item_id"] = 14340,
	["item_name"] = "Chasm of the Broken Code Helm",
	["item_icon"] = "econ/items/terrorblade/tb_samurai_head/tb_samurai_head",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/tb_samurai_head/tb_samurai_head.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/econ/items/terrorblade/tb_samura_head/tb_samurai_head_ambient.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["14341"] = {
	["item_id"] = 14341,
	["item_name"] = "Chasm of the Broken Code Wings",
	["item_icon"] = "econ/items/terrorblade/tb_samurai_back/tb_samurai_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/tb_samurai_back/tb_samurai_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/econ/items/terrorblade/tb_samurai_back/tb_samurai_back_ambient.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["14342"] = {
	["item_id"] = 14342,
	["item_name"] = "Chasm of the Broken Code Armor",
	["item_icon"] = "econ/items/terrorblade/tb_samurai_armor/tb_samurai_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/tb_samurai_armor/tb_samurai_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/econ/items/terrorblade/tb_samurai_armor/tb_samurai_armor_ambient.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["26445"] = {
	["item_id"] = 26445,
	["item_name"] = "Forgotten Station - Armor",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_armor/terrorblade_ultimate_depravity_armor",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/terrorblade_ultimate_depravity_armor/terrorblade_ultimate_depravity_armor.vmdl",
	["item_slot"] = "armor",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["26446"] = {
	["item_id"] = 26446,
	["item_name"] = "Forgotten Station - Demon",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_ability/terrorblade_ultimate_depravity_ability",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "",
	["item_slot"] = "ability3",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_metamorphosis_head.vpcf",
			},
		},
		["models"] = {
            ["default"] =
            {
                ["terrorblade_form"] = "models/terrorblade_custom/terrorblade_ultimate_depravity_ability.vmdl"
            }
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["26447"] = {
	["item_id"] = 26447,
	["item_name"] = "Forgotten Station - Head",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_head/terrorblade_ultimate_depravity_head",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/terrorblade_ultimate_depravity_head/terrorblade_ultimate_depravity_head.vmdl",
	["item_slot"] = "head",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_eyes.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
	["26448"] = {
	["item_id"] = 26448,
	["item_name"] = "Forgotten Station - Weapon",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_weapon/terrorblade_ultimate_depravity_weapon",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/terrorblade_ultimate_depravity_weapon/terrorblade_ultimate_depravity_weapon.vmdl",
	["item_slot"] = "weapon",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
			["default"] = {
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf",
				"particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf",
			},
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
			["default"] = {
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade.vpcf"] = "particles/terrorblade_custom/ultimate_right.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_blade_2.vpcf"] = "particles/terrorblade_custom/ultimate_left.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_l.vpcf"] = "particles/error/null.vpcf",
				["particles/units/heroes/hero_terrorblade/terrorblade_ambient_sword_r.vpcf"] = "particles/error/null.vpcf",
			},
		},
	},
	},
	["26449"] = {
	["item_id"] = 26449,
	["item_name"] = "Forgotten Station - Back",
	["item_icon"] = "econ/items/terrorblade/terrorblade_ultimate_depravity_back/terrorblade_ultimate_depravity_back",
	["item_cost"] = 1,
	["item_hero_model"] = nil,
	["activity_list"] = nil,
	["item_material_group"] = nil,
	["item_model"] = "models/items/terrorblade/terrorblade_ultimate_depravity_back/terrorblade_ultimate_depravity_back.vmdl",
	["item_slot"] = "back",
	["item_rarity"] = "mythical",
	["Modifier"] = nil,
	["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
	},
    ["59572"] = 
    {
        ["item_id"] = 59572,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59573"] = 
    {
        ["item_id"] = 59573,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59574"] = 
    {
        ["item_id"] = 59574,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59575"] = 
    {
        ["item_id"] = 59575,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59576"] = 
    {
        ["item_id"] = 59576,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59577"] = 
    {
        ["item_id"] = 59577,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59578"] = 
    {
        ["item_id"] = 59578,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59579"] = 
    {
        ["item_id"] = 59579,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59580"] = 
    {
        ["item_id"] = 59580,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59581"] = 
    {
        ["item_id"] = 59581,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59582"] = 
    {
        ["item_id"] = 59582,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
    ["59583"] = 
    {
        ["item_id"] = 59583,
        ["item_slot"] = "terrorblade_gem",
        ["item_model"] = "",
        ["visuals_list"] = {
		["ability_icons"] = {
		},
		["particles_list"] = {
		},
		["particles_list_loadout"] = {
		},
		["models"] = {
		},
		["models_refit"] = {
		},
		["sound_replace"] = {
		},
		["particles_abilities"] = {
		},
	},
    },
}