--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


GameUI.CustomUIConfig().units = {
	"npc_portal": {
		"Name": "传送门",
		"Enable": 1,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_invulnerable",
		"Model": "models/props_gameplay/team_portal/team_portal.vmdl",
		"ModelScale": 1,
		"Ability1": "faith_zues_1",
		"Ability2": "faith_zues_2",
		"Ability3": "faith_zues_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER"
	},
	"bonus_god_zues": {
		"Name": "雷神雕像",
		"Enable": 1,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_zues",
		"Model": "models/heroes/zeus/zeus_arcana.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_zues_1",
		"Ability2": "faith_zues_2",
		"Ability3": "faith_zues_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER",
		"Creature": {
			"AttachWearables": {
				"1": {
					"ItemDef": 9052
				},
				"2": {
					"ItemDef": 9037
				},
				"3": {
					"ItemDef": 9038
				},
				"4": {
					"ItemDef": 9039
				}
			}
		}
	},
	"bonus_god_ice": {
		"Name": "冰神雕像",
		"Enable": 0,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_ice",
		"Model": "models/heroes/crystal_maiden/crystal_maiden_arcana.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_ice_1",
		"Ability2": "faith_ice_2",
		"Ability3": "faith_ice_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER",
		"Creature": {
			"AttachWearables": {
				"1": {
					"ItemDef": 7385
				},
				"2": {
					"ItemDef": 13532
				},
				"3": {
					"ItemDef": 9205
				},
				"4": {
					"ItemDef": 6686
				}
			}
		}
	},
	"bonus_god_fire": {
		"Name": "火神雕像",
		"Enable": 1,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_fire",
		"Model": "models/heroes/lina/lina.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_fire_1",
		"Ability2": "faith_fire_2",
		"Ability3": "faith_fire_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER",
		"Creature": {
			"AttachWearables": {
				"1": {
					"ItemDef": 14247
				},
				"2": {
					"ItemDef": 14248
				},
				"3": {
					"ItemDef": 14250
				},
				"4": {
					"ItemDef": 14251
				}
			}
		}
	},
	"bonus_god_earth": {
		"Name": "大地神雕像",
		"Enable": 0,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_earth",
		"Model": "models/items/earthshaker/earthshaker_arcana/earthshaker_arcana.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_earth_1",
		"Ability2": "faith_earth_2",
		"Ability3": "faith_earth_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER",
		"Creature": {
			"AttachWearables": {
				"1": {
					"ItemDef": 7293
				},
				"2": {
					"ItemDef": 12969
				},
				"3": {
					"ItemDef": 12692
				}
			}
		}
	},
	"bonus_god_blade": {
		"Name": "剑神雕像",
		"Enable": 1,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_blade",
		"Model": "models/heroes/juggernaut/juggernaut_arcana.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_blade_1",
		"Ability2": "faith_blade_2",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER",
		"Creature": {
			"AttachWearables": {
				"1": {
					"ItemDef": 14955
				},
				"2": {
					"ItemDef": 14956
				},
				"3": {
					"ItemDef": 14957
				},
				"4": {
					"ItemDef": 14958
				},
				"5": {
					"ItemDef": 14959
				}
			}
		}
	},
	"bonus_god_wind": {
		"Name": "风神雕像",
		"Enable": 0,
		"InteractType": "Faith",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_god_wind",
		"Model": "models/items/windrunner/windrunner_arcana/wr_arcana_debut_style1.vmdl",
		"ModelScale": 3,
		"Ability1": "faith_wind_1",
		"Ability2": "faith_wind_2",
		"Ability3": "faith_wind_3",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 2000,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER"
	},
	"bonus_chest_normal": {
		"Name": "普通宝箱",
		"Enable": 1,
		"InteractType": "Chest",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_chest_normal",
		"Model": "models/props_generic/chest_treasure_02.vmdl",
		"ModelScale": 1.5,
		"Ability1": "chest_open",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 2000,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_HUGE"
	},
	"bonus_chest_gold": {
		"Name": "黄金宝箱",
		"skin": 1,
		"Enable": 1,
		"InteractType": "Chest",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_chest_gold",
		"Model": "models/props_generic/chest_treasure_02.vmdl",
		"ModelScale": 2,
		"Ability1": "chest_open",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_HUGE"
	},
	"bonus_outpost": {
		"Name": "哨塔",
		"Enable": 1,
		"InteractType": "Outpost",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_outpost",
		"Model": "models/props_structures/outpost.vmdl",
		"ModelScale": 1,
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER"
	},
	"bonus_book": {
		"Name": "贤者之书",
		"Enable": 1,
		"InteractType": "Book",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_book",
		"Model": "eom/meshs/eom2_rostrum_preset_01.vmdl",
		"ModelScale": 3,
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER"
	},
	"bonus_wishing_pool": {
		"Name": "许愿池",
		"Enable": 1,
		"InteractType": "Pool",
		"InteractTypeCount": 20,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_wishing_pool",
		"Model": "models/wish_pool.vmdl",
		"ModelScale": 1,
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_TOWER"
	},
	"bonus_chest_beetlejaws": {
		"Name": "咬人箱",
		"Enable": 1,
		"InteractType": "Chest",
		"InteractTypeCount": 1,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_chest_beetlejaws",
		"Model": "models/creeps/beetlejaws/mesh/beetlejaws.vmdl",
		"ModelScale": 1,
		"Ability1": "chest_open",
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_REGULAR"
	},
	"bonus_smithy": {
		"Name": "铁匠铺",
		"Enable": 1,
		"InteractType": "Smithy",
		"InteractTypeCount": 5,
		"BaseClass": "npc_dota_creature",
		"SpawnModifier": "modifier_spawn_bonus_smithy",
		"Model": "models/props_gameplay/shopkeeper_fountain/shopkeeper_fountain.vmdl",
		"ModelScale": 1,
		"MovementCapabilities": "DOTA_UNIT_CAP_MOVE_GROUND",
		"StatusHealth": 100,
		"StatusHealthRegen": 0,
		"StatusMana": 100,
		"StatusManaRegen": 0,
		"AttackDamageMin": 0,
		"AttackDamageMax": 0,
		"AttackRate": 1.7,
		"AttackCapabilities": "DOTA_UNIT_CAP_NO_ATTACK",
		"UnitLabel": "faith_statue",
		"BoundsHullName": "DOTA_HULL_SIZE_REGULAR"
	}
};