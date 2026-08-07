--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().ConsumablesKv = {
	"consumables_1": {
		"Id": 9300001,
		"Note": "砸雪球",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_1",
		"AbilityTextureName": 9300001,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_UNIT_TARGET | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0,
		"AbilityCastPoint": 0,
		"AbilityCastRange": 1800,
		"AbilityValues": {
			"speed": 1000,
			"slow": 10,
			"duration": 2,
		},
	},
	"consumables_2": {
		"Id": 9300002,
		"Note": "放烟花",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_2",
		"AbilityTextureName": 9300002,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_IMMEDIATE | DOTA_ABILITY_BEHAVIOR_AOE | DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0.5,
		"AbilityCastPoint": 0,
		"AbilityCastRange": 1800,
		"AbilityValues": {
			"speed": 2250,
		},
	},
	"consumables_3": {
		"Id": 9300003,
		"Note": "踢足球",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_3",
		"AbilityTextureName": 9300003,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_UNIT_TARGET | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0,
		"AbilityCastPoint": 0,
		"AbilityCastRange": 1800,
		"AbilityValues": {
			"speed": 1000,
			"slow": 10,
			"duration": 2,
		},
	},
	"consumables_4": {
		"Id": 9300004,
		"Note": "点爆竹",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_4",
		"AbilityTextureName": 9300004,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_IMMEDIATE | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0,
		"AbilityCastPoint": 0,
		"AbilityValues": {
			"duration": 2,
		},
	},
	"consumables_5": {
		"Id": 9300005,
		"Note": "泡泡",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_5",
		"AbilityTextureName": 9300005,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_NO_TARGET | DOTA_ABILITY_BEHAVIOR_IMMEDIATE | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0,
		"AbilityCastPoint": 0,
		"AbilityValues": {
			"duration": 3,
			"radius": 450,
			"bubble_duration": 3,
			"angle": 90,
		},
	},
	"consumables_6": {
		"Id": 9300006,
		"Note": "新年烟花",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/consumables/consumables_6",
		"AbilityTextureName": 9300006,
		"AbilityUnitTargetTeam": "DOTA_UNIT_TARGET_TEAM_BOTH",
		"AbilityUnitTargetType": "DOTA_UNIT_TARGET_HERO | DOTA_UNIT_TARGET_BASIC",
		"AbilityUnitTargetFlags": "DOTA_UNIT_TARGET_FLAG_INVULNERABLE",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_POINT | DOTA_ABILITY_BEHAVIOR_AOE | DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE | DOTA_ABILITY_BEHAVIOR_ITEM",
		"AbilityTypeAbilityCooldown": 0.2,
		"AbilityCastPoint": 0,
		"AbilityCastRange": 500,
		"AbilityValues": {
			"knock_distance": 300,
		},
	},
};