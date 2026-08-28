--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().GreevilAbilityKV = {
	"greevil_1": {
		"AmbientModifier": "modifier_skin_greevil_1",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/greevil/greevil_1",
		"AbilityTextureName": "greevil_3d_orange",
		"AbilityType": "ABILITY_TYPE_GREEVIL",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"MaxLevel": 3,
		"ModelSkin": 1,
		"AbilityValues": {
			"interval": 2,
			"dice_max": "4 5 6",
			"v_1": 2,
			"v_2": 3,
			"v_3": 4,
			"v_4": 4,
			"v_5": 4,
			"v_6": 6,
		},
	},
	"greevil_2": {
		"AmbientModifier": "modifier_skin_greevil_2",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/greevil/greevil_2",
		"AbilityTextureName": "greevil_3d_blue",
		"AbilityType": "ABILITY_TYPE_GREEVIL",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"MaxLevel": 3,
		"ModelSkin": 2,
		"AbilityValues": {
			"mana": "20 20 25",
			"chance": "12 16 20",
		},
	},
	"greevil_3": {
		"AmbientModifier": "modifier_skin_greevil_3",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/greevil/greevil_3",
		"AbilityTextureName": "greevil_3d_red",
		"AbilityType": "ABILITY_TYPE_GREEVIL",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"MaxLevel": 3,
		"ModelSkin": 3,
		"AbilityValues": {
			"interval": "6 4 2.5",
			"duration": 2,
			"damege_pct": 40,
		},
	},
	"greevil_4": {
		"AmbientModifier": "modifier_skin_greevil_4",
		"BaseClass": "ability_lua",
		"ScriptFile": "abilities/greevil/greevil_4",
		"AbilityTextureName": "greevil_3d_green",
		"AbilityType": "ABILITY_TYPE_GREEVIL",
		"AbilityBehavior": "DOTA_ABILITY_BEHAVIOR_PASSIVE",
		"MaxLevel": 2.5,
		"ModelSkin": 4,
		"AbilityValues": {
			"courier_regen": 18,
			"battle_regen": "8 10 12",
			"interval": 4,
		},
	},
};