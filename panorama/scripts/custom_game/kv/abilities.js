--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().abilities = {
	"phantom_assassin_1": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/phantom_assassin/phantom_assassin_1",
		"AbilityTextureName": "bounty_hunter_shuriken_toss",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PHYSICAL",
		"AbilityCastPoint": 0.2,
		"AbilityCooldown": 1,
		"AbilityManaCost": 2,
		"AbilityCastAnimation": "ACT_DOTA_ATTACK_EVENT",
		"AbilityValues": {
			"damage": {
				"value": 10,
				"_attack_damage": 0.3
			},
			"suriken_count": 1,
			"distance": 600,
			"width": 125,
			"out_duration": 0.3,
			"return_duration": 0.2,
			"angle_per_suriken": 15,
			"reduce_move_speed": 200,
			"reduce_duration": 0.5,
			"delay": 0.3
		}
	},
	"phantom_assassin_2": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/phantom_assassin/phantom_assassin_2",
		"AbilityTextureName": "phantom_assassin_phantom_strike",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_IMMEDIATE",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityCooldown": 1,
		"AbilityManaCost": 1,
		"AbilityValues": {
			"distance": 350,
			"duration": 0.35,
			"height": 50
		}
	},
	"phantom_assassin_3": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/phantom_assassin/phantom_assassin_3",
		"AbilityTextureName": "phantom_assassin/pa_fall20_immortal_ability_icon/pa_fall20_immortal_blur",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_IMMEDIATE",
		"AbilityCooldown": 3,
		"AbilityManaCost": 2,
		"AbilityValues": {
			"duration": 0.5,
			"movespeed": 150,
			"movespeed_duration": 1
		}
	},
	"phantom_assassin_4": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/phantom_assassin/phantom_assassin_4",
		"AbilityTextureName": "phantom_assassin_fan_of_knives",
		"MaxLevel": 1,
		"AbilityType": "DOTA_ABILITY_TYPE_ULTIMATE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PHYSICAL",
		"AbilityCastPoint": 0.12,
		"AbilityCooldown": 12,
		"AbilityManaCost": 5,
		"AbilityValues": {
			"suriken_count": 12,
			"delay": 1
		}
	},
	"phantom_assassin_2_1": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/phantom_assassin/phantom_assassin_2_1",
		"AbilityTextureName": "phantom_assassin_phantom_strike",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_IMMEDIATE | DOTA_ABILITY_BEHAVIOR_HIDDEN",
		"AbilityValues": {
			"distance": 350,
			"speed": 1000,
			"height": 50
		}
	},
	"windrunner_1": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/windrunner/windrunner_1",
		"AbilityTextureName": "windrunner_powershot_arcana",
		"MaxLevel": 1,
		"CustomAbilityType": "CUSTOM_TYPE_SPLIT",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_CHANNELLED | DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PHYSICAL",
		"AbilityChannelTime": 1,
		"AbilityCooldown": 2,
		"AbilityManaCost": 2,
		"AbilityCastAnimation": "ACT_DOTA_CAST_ABILITY_2",
		"AbilityValues": {
			"damage": {
				"value": 60,
				"_attack_damage": 0.8
			},
			"arrow_count": 1,
			"distance": 1000,
			"width": 125,
			"speed": 2500,
			"angle_per_arrow": 20,
			"min_factor": 0.1,
			"channel_duration": 1,
			"bounce_count": 0
		}
	},
	"windrunner_2": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/windrunner/windrunner_2",
		"AbilityTextureName": "pangolier_gyroshell_stop",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_IMMEDIATE",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityCooldown": 1,
		"AbilityManaCost": 1,
		"AbilityValues": {
			"distance": 400,
			"duration": 0.35,
			"speed": 1200
		}
	},
	"windrunner_3": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/windrunner/windrunner_3",
		"AbilityTextureName": "windrunner_windrun_arcana",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_IMMEDIATE",
		"AbilityCooldown": 5,
		"AbilityManaCost": 2,
		"AbilityValues": {
			"movespeed": 180,
			"duration": 2
		}
	},
	"windrunner_4": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/windrunner/windrunner_4",
		"AbilityTextureName": "windrunner_focusfire_arcana",
		"MaxLevel": 1,
		"AbilityType": "DOTA_ABILITY_TYPE_ULTIMATE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PHYSICAL",
		"AbilityCastPoint": 0.54,
		"AbilityCooldown": 9,
		"AbilityManaCost": 4,
		"AbilityCastAnimation": "ACT_DOTA_VICTORY",
		"AbilityValues": {
			"damage": {
				"value": 10,
				"_attack_damage": 0.3
			},
			"damage_radius": 200,
			"radius": 600,
			"duration": 2,
			"delay": 0.5,
			"interval": 0.05
		}
	},
	"necrolyte_1": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/necrolyte/necrolyte_1",
		"AbilityTextureName": "necrolyte_death_pulse",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_MAGICAL",
		"AbilityCooldown": 3,
		"AbilityManaCost": 3,
		"AbilityValues": {
			"damage": {
				"value": 60,
				"_attack_damage": 0.2
			},
			"speed": 400,
			"pulse_count": 3,
			"width": 125,
			"angular_velocity": 30,
			"bounce_count": 0
		}
	},
	"necrolyte_2": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/necrolyte/necrolyte_2",
		"AbilityTextureName": "necrolyte_sadist",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityCooldown": 6,
		"AbilityManaCost": 3,
		"AbilityValues": {
			"duration": 2,
			"movespeed": 300,
			"radius": 750
		}
	},
	"necrolyte_3": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/necrolyte/necrolyte_3",
		"AbilityTextureName": "necrolyte_heartstopper_aura",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PURE",
		"AbilityValues": {
			"damage": 10,
			"aura_radius": 900,
			"interval": 0.2,
			"bonus_health": 1
		}
	},
	"necrolyte_4": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/necrolyte/necrolyte_4",
		"AbilityTextureName": "necrolyte_reapers_scythe",
		"MaxLevel": 1,
		"AbilityType": "DOTA_ABILITY_TYPE_ULTIMATE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_MAGICAL",
		"AbilityCastRange": 1200,
		"AbilityCastPoint": 0.6,
		"AbilityCooldown": 10,
		"AbilityManaCost": 5,
		"AbilityCastAnimation": "ACT_DOTA_CAST_ABILITY_4",
		"AbilityValues": {
			"damage": {
				"value": 120,
				"_attack_damage": 1.2
			},
			"radius": 300,
			"cast_point": 0.6,
			"delay": 1.5
		}
	},
	"sniper_1": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/sniper/sniper_1",
		"AbilityTextureName": "sniper_shrapnel_muh_keen_gun",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_PHYSICAL",
		"AbilityCastRange": 1200,
		"AbilityCooldown": 8,
		"AbilityManaCost": 6,
		"AbilityCastAnimation": "ACT_DOTA_CAST_ABILITY_1",
		"AbilityValues": {
			"damage": {
				"value": 40,
				"_attack_damage": 0.3
			},
			"count": 1,
			"bullet_damage": 15,
			"radius": 600,
			"speed": 800
		}
	},
	"sniper_2": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/sniper/sniper_2",
		"AbilityTextureName": "brewmaster_primal_split",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityCooldown": 4,
		"AbilityValues": {
			"chance_fire": 25,
			"damage_bonus": 10,
			"damage_fire_pers": 5,
			"armor_reduce": 2,
			"duration_fire": 4,
			"chance_ice": 25,
			"movespeed_pct": 35,
			"income_damage_bonus": 20,
			"duration_ice": 4,
			"chance_thunder": 25,
			"damage_thunder": 15
		}
	},
	"sniper_3": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/sniper/sniper_3",
		"AbilityTextureName": "sniper_concussive_grenade",
		"MaxLevel": 1,
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityCooldown": 3,
		"AbilityManaCost": 1,
		"AbilityCastAnimation": "ACT_DOTA_CAST_ABILITY_3",
		"AbilityValues": {
			"duration": 0.8,
			"range": 400,
			"atk_radius": 800,
			"damage": 5
		}
	},
	"sniper_4": {
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/heroes/sniper/sniper_4",
		"AbilityTextureName": "sniper_fall20_assassinate",
		"MaxLevel": 1,
		"AbilityType": "DOTA_ABILITY_TYPE_ULTIMATE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT",
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_ENEMY",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_BUILDING|DOTA_UNIT_TARGET_HEROES_AND_CREEPS",
		"AbilityUnitDamageType": "DAMAGE_TYPE_MAGICAL",
		"AbilityCastRange": 900,
		"AbilityCooldown": 12,
		"AbilityManaCost": 10,
		"AbilityValues": {
			"duration": 4,
			"base_damage": {
				"value": 15,
				"_attack_damage": 0.5
			},
			"radius": 400,
			"interval": 1,
			"damage_bonus": 3,
			"bonus_max": 30,
			"mana_pers": 2
		}
	}
};