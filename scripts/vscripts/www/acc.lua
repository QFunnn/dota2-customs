--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


if acc == nil then
	_G.acc = class({})
end

function acc:init()
	CustomGameEventManager:RegisterListener("get_account_progress", Dynamic_Wrap(acc, "get_account_progress"))
	CustomGameEventManager:RegisterListener("buy_account_progress", Dynamic_Wrap(acc, "buy_account_progress"))
	CustomGameEventManager:RegisterListener("reset_account_progress", Dynamic_Wrap(acc, "reset_account_progress"))
	CustomGameEventManager:RegisterListener("select_skill_lua", Dynamic_Wrap(acc, "select_skill_lua"))
end

talents_data = {
	{ x = 2000, y = 1800, size = 50, id = 2, color = "gold", requires = {}, alternative = {}, bonus = "int_1" },
	{ x = 1820, y = 1900, size = 50, id = 3, color = "gold", requires = {}, alternative = {}, bonus = "spell_damage_1" },
	{ x = 2180, y = 1900, size = 50, id = 4, color = "gold", requires = {}, alternative = {}, bonus = "damage_1" },
	{ x = 2180, y = 2100, size = 50, id = 5, color = "gold", requires = {}, alternative = {}, bonus = "agi_1" },
	{ x = 2000, y = 2200, size = 50, id = 7, color = "gold", requires = {}, alternative = {}, bonus = "hp_1" },
	{ x = 1820, y = 2100, size = 50, id = 8, color = "gold", requires = {}, alternative = {}, bonus = "str_1" },
	{ x = 1170, y = 2000, size = 100, id = 55, color = "purple", requires = { 13 }, alternative = {}, bonus = "bonus_int_2" },
	{
		x = 970,
		y = 2000,
		size = 100,
		id = 56,
		color = "purple",
		requires = { 37, 38, 39, 18, 19, 20 },
		alternative = {},
		bonus = "bonus_int_7",
	},
	{ x = 770, y = 2000, size = 100, id = 57, color = "purple", requires = { 56 }, alternative = {}, bonus = "bonus_int_5" },
	{
		x = 400,
		y = 2000,
		size = 100,
		id = 58,
		color = "purple",
		requires = { 31, 33, 32, 50, 51, 49 },
		alternative = {},
		bonus = "bonus_int_10",
	},
	{ x = 210, y = 2460, size = 100, id = 59, color = "purple", requires = { 36 }, alternative = {}, bonus = "bonus_int_11" },
	{ x = 210, y = 1540, size = 100, id = 60, color = "purple", requires = { 54 }, alternative = {}, bonus = "bonus_int_12" },
	{
		x = 730,
		y = 1400,
		size = 100,
		id = 61,
		color = "purple",
		requires = { 43, 47, 45, 44, 46, 48 },
		alternative = {},
		bonus = "bonus_int_8",
	},
	{
		x = 730,
		y = 2600,
		size = 100,
		id = 62,
		color = "purple",
		requires = { 24, 28, 26, 25, 27, 29 },
		alternative = {},
		bonus = "bonus_int_9",
	},
	{ x = 1650, y = 2000, size = 50, id = 9, color = "yellow", requires = { 3, 8 }, alternative = {}, bonus = "int_1" },
	{
		x = 1470,
		y = 2000,
		size = 50,
		id = 10,
		color = "yellow",
		requires = { 11, 12 },
		alternative = {},
		bonus = "spell_damage_1",
	},
	{ x = 1560, y = 1950, size = 50, id = 11, color = "yellow", requires = { 9 }, alternative = {}, bonus = "exp_1" },
	{ x = 1560, y = 2050, size = 50, id = 12, color = "yellow", requires = { 9 }, alternative = {}, bonus = "mana_1" },
	{ x = 1340, y = 2000, size = 50, id = 13, color = "yellow", requires = { 10 }, alternative = {}, bonus = "int_1" },
	{ x = 1320, y = 1890, size = 50, id = 14, color = "yellow", requires = { 13 }, alternative = {}, bonus = "mana_1" },
	{ x = 1250, y = 1800, size = 50, id = 15, color = "yellow", requires = { 14 }, alternative = {}, bonus = "cd_1" },
	{ x = 1320, y = 2110, size = 50, id = 16, color = "yellow", requires = { 13 }, alternative = {}, bonus = "regen_mana_1" },
	{ x = 1250, y = 2200, size = 50, id = 17, color = "yellow", requires = { 16 }, alternative = {}, bonus = "exp_1" },
	{ x = 1075, y = 2155, size = 50, id = 18, color = "yellow", requires = { 55 }, alternative = {}, bonus = "mana_2" },
	{ x = 975, y = 2205, size = 50, id = 19, color = "yellow", requires = { 18 }, alternative = {}, bonus = "cd_2" },
	{ x = 875, y = 2155, size = 50, id = 20, color = "yellow", requires = { 19 }, alternative = {}, bonus = "int_2" },
	{ x = 730, y = 2110, size = 50, id = 21, color = "yellow", requires = { 57 }, alternative = {}, bonus = "spell_damage_2" },
	{ x = 730, y = 2240, size = 50, id = 22, color = "yellow", requires = { 21 }, alternative = {}, bonus = "mana_2" },
	{ x = 730, y = 2370, size = 50, id = 23, color = "yellow", requires = { 22 }, alternative = {}, bonus = "exp_2" },
	{ x = 730, y = 2490, size = 50, id = 24, color = "yellow", requires = { 23 }, alternative = {}, bonus = "int_2" },
	{ x = 730, y = 2720, size = 50, id = 25, color = "yellow", requires = { 27 }, alternative = { 26 }, bonus = "spell_damage_2" },
	{ x = 630, y = 2660, size = 50, id = 26, color = "yellow", requires = { 28 }, alternative = { 25 }, bonus = "exp_2" },
	{ x = 830, y = 2660, size = 50, id = 27, color = "yellow", requires = { 29 }, alternative = { 25 }, bonus = "int_2" },
	{ x = 630, y = 2550, size = 50, id = 28, color = "yellow", requires = { 24 }, alternative = { 26 }, bonus = "mana_2" },
	{ x = 830, y = 2550, size = 50, id = 29, color = "yellow", requires = { 24 }, alternative = { 27 }, bonus = "regen_mana_2" },
	{ x = 600, y = 2000, size = 50, id = 30, color = "yellow", requires = { 57 }, alternative = {}, bonus = "cd_2" },
	{ x = 495, y = 2055, size = 50, id = 31, color = "yellow", requires = { 30 }, alternative = { 33 }, bonus = "int_3" },
	{ x = 300, y = 2055, size = 50, id = 32, color = "yellow", requires = { 33 }, alternative = { 50 }, bonus = "exp_3" },
	{ x = 395, y = 2110, size = 50, id = 33, color = "yellow", requires = { 31 }, alternative = { 32 }, bonus = "cd_3" },
	{ x = 415, y = 2215, size = 50, id = 34, color = "yellow", requires = { 33 }, alternative = {}, bonus = "mana_3" },
	{ x = 375, y = 2325, size = 50, id = 35, color = "yellow", requires = { 34 }, alternative = {}, bonus = "spell_damage_3" },
	{ x = 315, y = 2415, size = 50, id = 36, color = "yellow", requires = { 35 }, alternative = {}, bonus = "exp_3" },
	{ x = 1075, y = 1845, size = 50, id = 37, color = "yellow", requires = { 55 }, alternative = {}, bonus = "spell_damage_2" },
	{ x = 975, y = 1795, size = 50, id = 38, color = "yellow", requires = { 37 }, alternative = {}, bonus = "regen_mana_2" },
	{ x = 875, y = 1845, size = 50, id = 39, color = "yellow", requires = { 38 }, alternative = {}, bonus = "exp_2" },
	{ x = 730, y = 1890, size = 50, id = 40, color = "yellow", requires = { 57 }, alternative = {}, bonus = "regen_mana_2" },
	{ x = 730, y = 1760, size = 50, id = 41, color = "yellow", requires = { 40 }, alternative = {}, bonus = "exp_2" },
	{ x = 730, y = 1630, size = 50, id = 42, color = "yellow", requires = { 41 }, alternative = {}, bonus = "cd_2" },
	{ x = 730, y = 1510, size = 50, id = 43, color = "yellow", requires = { 42 }, alternative = {}, bonus = "int_2" },
	{ x = 730, y = 1280, size = 50, id = 44, color = "yellow", requires = { 46 }, alternative = { 45 }, bonus = "exp_2" },
	{ x = 630, y = 1340, size = 50, id = 45, color = "yellow", requires = { 44 }, alternative = { 47 }, bonus = "spell_damage_2" },
	{ x = 830, y = 1340, size = 50, id = 46, color = "yellow", requires = { 44 }, alternative = { 48 }, bonus = "cd_2" },
	{ x = 630, y = 1450, size = 50, id = 47, color = "yellow", requires = { 43 }, alternative = { 45 }, bonus = "regen_mana_2" },
	{ x = 830, y = 1450, size = 50, id = 48, color = "yellow", requires = { 46 }, alternative = { 43 }, bonus = "mana_2" },
	{ x = 495, y = 1945, size = 50, id = 49, color = "yellow", requires = { 30 }, alternative = { 51 }, bonus = "spell_damage_3" },
	{ x = 300, y = 1945, size = 50, id = 50, color = "yellow", requires = { 51 }, alternative = { 32 }, bonus = "regen_mana_3" },
	{ x = 395, y = 1890, size = 50, id = 51, color = "yellow", requires = { 49 }, alternative = { 50 }, bonus = "mana_3" },
	{ x = 415, y = 1785, size = 50, id = 52, color = "yellow", requires = { 51 }, alternative = {}, bonus = "regen_mana_3" },
	{ x = 375, y = 1675, size = 50, id = 53, color = "yellow", requires = { 52 }, alternative = {}, bonus = "int_3" },
	{ x = 315, y = 1585, size = 50, id = 54, color = "yellow", requires = { 53 }, alternative = {}, bonus = "cd_3" },
	{
		x = 2515,
		y = 2000,
		size = 100,
		id = 63,
		color = "purple",
		requires = { 70, 72, 74, 90, 92, 94 },
		alternative = {},
		bonus = "bonus_agi_5",
	},
	{
		x = 2915,
		y = 2000,
		size = 100,
		id = 64,
		color = "purple",
		requires = { 76, 78, 77, 96, 98, 97 },
		alternative = {},
		bonus = "bonus_agi_14",
	},
	{
		x = 3450,
		y = 2000,
		size = 100,
		id = 65,
		color = "purple",
		requires = { 84, 86, 85, 103, 102, 104 },
		alternative = {},
		bonus = "bonus_agi_3",
	},
	{ x = 3640, y = 2460, size = 100, id = 66, color = "purple", requires = { 107 }, alternative = {}, bonus = "bonus_agi_15" },
	{ x = 3640, y = 1540, size = 100, id = 67, color = "purple", requires = { 89 }, alternative = {}, bonus = "bonus_agi_12" },
	{ x = 2730, y = 1540, size = 100, id = 68, color = "purple", requires = { 81 }, alternative = {}, bonus = "bonus_agi_13" },
	{ x = 2730, y = 2460, size = 100, id = 69, color = "purple", requires = { 101 }, alternative = {}, bonus = "bonus_agi_4" },
	{ x = 2420, y = 1945, size = 50, id = 70, color = "yellow", requires = { 4 }, alternative = {}, bonus = "lifesteal_1" },
	{ x = 2420, y = 1845, size = 50, id = 71, color = "yellow", requires = { 4 }, alternative = { 73 }, bonus = "attack_speed_1" },
	{ x = 2515, y = 1890, size = 50, id = 72, color = "yellow", requires = { 70 }, alternative = {}, bonus = "move_speed_1" },
	{ x = 2515, y = 1790, size = 50, id = 73, color = "yellow", requires = { 71 }, alternative = { 75 }, bonus = "evasion_1" },
	{ x = 2610, y = 1945, size = 50, id = 74, color = "yellow", requires = { 72 }, alternative = {}, bonus = "evasion_1" },
	{ x = 2610, y = 1845, size = 50, id = 75, color = "yellow", requires = { 73 }, alternative = { 76 }, bonus = "lifesteal_1" },
	{ x = 2820, y = 1945, size = 50, id = 76, color = "yellow", requires = { 75 }, alternative = { 96 }, bonus = "damage_1" },
	{ x = 3010, y = 1945, size = 50, id = 77, color = "yellow", requires = { 78 }, alternative = { 97 }, bonus = "agi_1" },
	{ x = 2910, y = 1890, size = 50, id = 78, color = "yellow", requires = { 76 }, alternative = { 77 }, bonus = "evasion_1" },
	{ x = 2930, y = 1790, size = 50, id = 79, color = "yellow", requires = { 78 }, alternative = {}, bonus = "lifesteal_1" },
	{ x = 2890, y = 1680, size = 50, id = 80, color = "yellow", requires = { 79 }, alternative = {}, bonus = "damage_1" },
	{ x = 2830, y = 1585, size = 50, id = 81, color = "yellow", requires = { 80 }, alternative = {}, bonus = "move_speed_1" },
	{ x = 3120, y = 2000, size = 50, id = 82, color = "yellow", requires = { 77, 97 }, alternative = {}, bonus = "lifesteal_1" },
	{ x = 3245, y = 2000, size = 50, id = 83, color = "yellow", requires = { 82 }, alternative = {}, bonus = "agi_2" },
	{ x = 3350, y = 1945, size = 50, id = 84, color = "yellow", requires = { 83 }, alternative = {}, bonus = "damage_3" },
	{ x = 3545, y = 1945, size = 50, id = 85, color = "yellow", requires = { 86 }, alternative = { 103 }, bonus = "lifesteal_3" },
	{ x = 3445, y = 1890, size = 50, id = 86, color = "yellow", requires = { 84 }, alternative = { 85 }, bonus = "move_speed_3" },
	{ x = 3430, y = 1790, size = 50, id = 87, color = "yellow", requires = { 86 }, alternative = {}, bonus = "attack_speed_3" },
	{ x = 3470, y = 1680, size = 50, id = 88, color = "yellow", requires = { 87 }, alternative = {}, bonus = "lifesteal_3" },
	{ x = 3530, y = 1585, size = 50, id = 89, color = "yellow", requires = { 88 }, alternative = {}, bonus = "damage_3" },
	{ x = 2420, y = 2055, size = 50, id = 90, color = "yellow", requires = { 5 }, alternative = {}, bonus = "evasion_1" },
	{ x = 2420, y = 2155, size = 50, id = 91, color = "yellow", requires = { 5 }, alternative = { 93 }, bonus = "move_speed_1" },
	{ x = 2515, y = 2110, size = 50, id = 92, color = "yellow", requires = { 90 }, alternative = {}, bonus = "attack_speed_1" },
	{ x = 2515, y = 2210, size = 50, id = 93, color = "yellow", requires = { 91 }, alternative = { 95 }, bonus = "damage_1" },
	{ x = 2610, y = 2055, size = 50, id = 94, color = "yellow", requires = { 92 }, alternative = {}, bonus = "damage_1" },
	{ x = 2610, y = 2155, size = 50, id = 95, color = "yellow", requires = { 93 }, alternative = { 96 }, bonus = "agi_1" },
	{ x = 2820, y = 2055, size = 50, id = 96, color = "yellow", requires = { 95 }, alternative = { 76 }, bonus = "agi_1" },
	{ x = 3010, y = 2055, size = 50, id = 97, color = "yellow", requires = { 98 }, alternative = { 77 }, bonus = "attack_speed_1" },
	{ x = 2910, y = 2110, size = 50, id = 98, color = "yellow", requires = { 96 }, alternative = { 97 }, bonus = "move_speed_1" },
	{ x = 2930, y = 2210, size = 50, id = 99, color = "yellow", requires = { 98 }, alternative = {}, bonus = "damage_1" },
	{ x = 2890, y = 2320, size = 50, id = 100, color = "yellow", requires = { 99 }, alternative = {}, bonus = "attack_speed_1" },
	{ x = 2830, y = 2415, size = 50, id = 101, color = "yellow", requires = { 100 }, alternative = {}, bonus = "evasion_1" },
	{ x = 3350, y = 2055, size = 50, id = 102, color = "yellow", requires = { 83 }, alternative = {}, bonus = "attack_speed_3" },
	{ x = 3545, y = 2055, size = 50, id = 103, color = "yellow", requires = { 85 }, alternative = { 104 }, bonus = "move_speed_3" },
	{ x = 3445, y = 2110, size = 50, id = 104, color = "yellow", requires = { 103 }, alternative = { 102 }, bonus = "evasion_3" },
	{ x = 3430, y = 2210, size = 50, id = 105, color = "yellow", requires = { 104 }, alternative = {}, bonus = "evasion_3" },
	{ x = 3470, y = 2320, size = 50, id = 106, color = "yellow", requires = { 105 }, alternative = {}, bonus = "lifesteal_3" },
	{ x = 3530, y = 2415, size = 50, id = 107, color = "yellow", requires = { 106 }, alternative = {}, bonus = "agi_3" },
	{
		x = 1740,
		y = 1555,
		size = 100,
		id = 108,
		color = "purple",
		requires = { 117, 118, 120, 121, 123, 124 },
		alternative = {},
		bonus = "bonus_int_13",
	},
	{ x = 1240, y = 1600, size = 100, id = 109, color = "purple", requires = { 127 }, alternative = {}, bonus = "bonus_int_1" },
	{
		x = 1540,
		y = 1210,
		size = 100,
		id = 110,
		color = "purple",
		requires = { 130, 131, 132, 133, 134, 135 },
		alternative = {},
		bonus = "bonus_int_3",
	},
	{ x = 2030, y = 1145, size = 100, id = 111, color = "purple", requires = { 138 }, alternative = {}, bonus = "bonus_int_4" },
	{ x = 785, y = 810, size = 100, id = 112, color = "purple", requires = { 152 }, alternative = {}, bonus = "bonus_int_14" },
	{
		x = 1275,
		y = 745,
		size = 100,
		id = 113,
		color = "purple",
		requires = { 141, 142, 147, 148, 149, 146 },
		alternative = {},
		bonus = "bonus_int_6",
	},
	{ x = 1575, y = 355, size = 100, id = 114, color = "purple", requires = { 145 }, alternative = {}, bonus = "bonus_int_15" },
	{ x = 1925, y = 1560, size = 50, id = 115, color = "yellow", requires = { 2 }, alternative = {}, bonus = "mana_1" },
	{ x = 1925, y = 1450, size = 50, id = 116, color = "yellow", requires = { 115 }, alternative = {}, bonus = "spell_damage_1" },
	{ x = 1840, y = 1610, size = 50, id = 117, color = "yellow", requires = { 2 }, alternative = {}, bonus = "regen_mana_1" },
	{ x = 1840, y = 1500, size = 50, id = 118, color = "yellow", requires = { 117 }, alternative = {}, bonus = "cd_1" },
	{ x = 1830, y = 1390, size = 50, id = 119, color = "yellow", requires = { 116 }, alternative = {}, bonus = "regen_mana_1" },
	{ x = 1740, y = 1440, size = 50, id = 120, color = "yellow", requires = { 118 }, alternative = {}, bonus = "exp_1" },
	{ x = 1740, y = 1665, size = 50, id = 121, color = "yellow", requires = { 3 }, alternative = {}, bonus = "cd_1" },
	{ x = 1655, y = 1715, size = 50, id = 122, color = "yellow", requires = { 3 }, alternative = {}, bonus = "exp_1" },
	{ x = 1645, y = 1610, size = 50, id = 123, color = "yellow", requires = { 121 }, alternative = {}, bonus = "mana_1" },
	{ x = 1645, y = 1500, size = 50, id = 124, color = "yellow", requires = { 123 }, alternative = {}, bonus = "exp_1" },
	{ x = 1560, y = 1550, size = 50, id = 125, color = "yellow", requires = { 126 }, alternative = {}, bonus = "int_1" },
	{ x = 1560, y = 1660, size = 50, id = 126, color = "yellow", requires = { 122 }, alternative = {}, bonus = "regen_mana_1" },
	{ x = 1225, y = 1490, size = 50, id = 127, color = "yellow", requires = { 128 }, alternative = {}, bonus = "int_1" },
	{ x = 1275, y = 1385, size = 50, id = 128, color = "yellow", requires = { 129 }, alternative = {}, bonus = "spell_damage_1" },
	{ x = 1350, y = 1300, size = 50, id = 129, color = "yellow", requires = { 130 }, alternative = {}, bonus = "cd_1" },
	{ x = 1445, y = 1260, size = 50, id = 130, color = "yellow", requires = { 131 }, alternative = { 135 }, bonus = "mana_1" },
	{
		x = 1545,
		y = 1320,
		size = 50,
		id = 131,
		color = "yellow",
		requires = { 125 },
		alternative = { 130 },
		bonus = "spell_damage_1",
	},
	{ x = 1640, y = 1260, size = 50, id = 132, color = "yellow", requires = { 119 }, alternative = { 133 }, bonus = "cd_1" },
	{ x = 1640, y = 1150, size = 50, id = 133, color = "yellow", requires = { 132 }, alternative = { 134 }, bonus = "int_1" },
	{ x = 1545, y = 1095, size = 50, id = 134, color = "yellow", requires = { 133 }, alternative = { 135 }, bonus = "mana_1" },
	{
		x = 1445,
		y = 1150,
		size = 50,
		id = 135,
		color = "yellow",
		requires = { 134 },
		alternative = { 130 },
		bonus = "regen_mana_1",
	},
	{ x = 1720, y = 1085, size = 50, id = 136, color = "yellow", requires = { 133 }, alternative = {}, bonus = "regen_mana_1" },
	{ x = 1835, y = 1065, size = 50, id = 137, color = "yellow", requires = { 136 }, alternative = {}, bonus = "cd_1" },
	{ x = 1945, y = 1070, size = 50, id = 138, color = "yellow", requires = { 137 }, alternative = {}, bonus = "spell_damage_1" },
	{ x = 1440, y = 1030, size = 50, id = 139, color = "yellow", requires = { 134, 135 }, alternative = {}, bonus = "exp_1" },
	{ x = 1380, y = 920, size = 50, id = 140, color = "yellow", requires = { 139 }, alternative = {}, bonus = "int_2" },
	{ x = 1375, y = 800, size = 50, id = 141, color = "yellow", requires = { 140 }, alternative = {}, bonus = "spell_damage_2" },
	{ x = 1370, y = 690, size = 50, id = 142, color = "yellow", requires = { 141 }, alternative = { 146 }, bonus = "regen_mana_2" },
	{ x = 1470, y = 650, size = 50, id = 143, color = "yellow", requires = { 142 }, alternative = {}, bonus = "regen_mana_3" },
	{ x = 1545, y = 565, size = 50, id = 144, color = "yellow", requires = { 143 }, alternative = {}, bonus = "cd_3" },
	{ x = 1595, y = 465, size = 50, id = 145, color = "yellow", requires = { 144 }, alternative = {}, bonus = "int_3" },
	{ x = 1275, y = 635, size = 50, id = 146, color = "yellow", requires = { 142 }, alternative = { 149 }, bonus = "int_2" },
	{ x = 1275, y = 855, size = 50, id = 147, color = "yellow", requires = { 140 }, alternative = {}, bonus = "mana_2" },
	{ x = 1180, y = 800, size = 50, id = 148, color = "yellow", requires = { 147 }, alternative = { 149 }, bonus = "cd_2" },
	{ x = 1180, y = 690, size = 50, id = 149, color = "yellow", requires = { 146 }, alternative = { 148 }, bonus = "int_2" },
	{ x = 1100, y = 865, size = 50, id = 150, color = "yellow", requires = { 148 }, alternative = {}, bonus = "mana_3" },
	{ x = 990, y = 885, size = 50, id = 151, color = "yellow", requires = { 150 }, alternative = {}, bonus = "exp_3" },
	{ x = 875, y = 880, size = 50, id = 152, color = "yellow", requires = { 151 }, alternative = {}, bonus = "spell_damage_3" },
	{ x = 2410, y = 1280, size = 100, id = 153, color = "purple", requires = { 165 }, alternative = {}, bonus = "bonus_agi_6" },
	{
		x = 2510,
		y = 1110,
		size = 100,
		id = 154,
		color = "purple",
		requires = { 170, 171, 172, 173, 174, 175 },
		alternative = {},
		bonus = "bonus_agi_2",
	},
	{ x = 2610, y = 940, size = 100, id = 155, color = "purple", requires = { 154 }, alternative = {}, bonus = "bonus_agi_1" },
	{
		x = 2800,
		y = 610,
		size = 100,
		id = 156,
		color = "purple",
		requires = { 195, 196, 200, 201, 202, 203 },
		alternative = {},
		bonus = "bonus_agi_7",
	},
	{
		x = 2110,
		y = 600,
		size = 100,
		id = 157,
		color = "purple",
		requires = { 179, 180, 181, 182, 183, 184 },
		alternative = {},
		bonus = "bonus_agi_8",
	},
	{ x = 2500, y = 220, size = 100, id = 158, color = "purple", requires = { 199 }, alternative = {}, bonus = "bonus_agi_9" },
	{ x = 3290, y = 675, size = 100, id = 159, color = "purple", requires = { 206 }, alternative = {}, bonus = "bonus_agi_10" },
	{
		x = 3160,
		y = 1205,
		size = 100,
		id = 160,
		color = "purple",
		requires = { 188, 189, 190, 191, 192, 193 },
		alternative = {},
		bonus = "bonus_agi_11",
	},
	{ x = 2175, y = 1700, size = 50, id = 161, color = "yellow", requires = { 2, 4 }, alternative = {}, bonus = "agi_1" },
	{
		x = 2175,
		y = 1600,
		size = 50,
		id = 162,
		color = "yellow",
		requires = { 161 },
		alternative = { 163 },
		bonus = "attack_speed_2",
	},
	{
		x = 2255,
		y = 1550,
		size = 50,
		id = 163,
		color = "yellow",
		requires = { 162, 164 },
		alternative = {},
		bonus = "move_speed_1",
	},
	{ x = 2255, y = 1650, size = 50, id = 164, color = "yellow", requires = { 163 }, alternative = { 161 }, bonus = "lifesteal_1" },
	{ x = 2330, y = 1430, size = 50, id = 165, color = "yellow", requires = { 163 }, alternative = {}, bonus = "attack_speed_1" },
	{ x = 2240, y = 1360, size = 50, id = 166, color = "yellow", requires = { 165 }, alternative = {}, bonus = "move_speed_1" },
	{ x = 2200, y = 1255, size = 50, id = 167, color = "yellow", requires = { 166 }, alternative = {}, bonus = "lifesteal_1" },
	{ x = 2435, y = 1470, size = 50, id = 168, color = "yellow", requires = { 165 }, alternative = {}, bonus = "evasion_1" },
	{ x = 2545, y = 1450, size = 50, id = 169, color = "yellow", requires = { 168 }, alternative = {}, bonus = "agi_1" },
	{ x = 2595, y = 1270, size = 50, id = 170, color = "yellow", requires = { 153 }, alternative = {}, bonus = "attack_speed_2" },
	{ x = 2685, y = 1210, size = 50, id = 171, color = "yellow", requires = { 170 }, alternative = {}, bonus = "evasion_2" },
	{ x = 2695, y = 1100, size = 50, id = 172, color = "yellow", requires = { 171 }, alternative = {}, bonus = "agi_2" },
	{ x = 2330, y = 1120, size = 50, id = 173, color = "yellow", requires = { 153 }, alternative = {}, bonus = "damage_2" },
	{ x = 2335, y = 1005, size = 50, id = 174, color = "yellow", requires = { 173 }, alternative = {}, bonus = "move_speed_2" },
	{ x = 2430, y = 945, size = 50, id = 175, color = "yellow", requires = { 174 }, alternative = {}, bonus = "lifesteal_2" },
	{ x = 2535, y = 845, size = 50, id = 176, color = "yellow", requires = { 155 }, alternative = {}, bonus = "damage_2" },
	{ x = 2425, y = 780, size = 50, id = 177, color = "yellow", requires = { 176 }, alternative = {}, bonus = "lifesteal_2" },
	{ x = 2315, y = 715, size = 50, id = 178, color = "yellow", requires = { 177 }, alternative = {}, bonus = "evasion_2" },
	{ x = 2205, y = 655, size = 50, id = 179, color = "yellow", requires = { 178 }, alternative = {}, bonus = "attack_speed_2" },
	{ x = 2205, y = 545, size = 50, id = 180, color = "yellow", requires = { 179 }, alternative = { 181 }, bonus = "evasion_2" },
	{ x = 2110, y = 485, size = 50, id = 181, color = "yellow", requires = { 180 }, alternative = { 184 }, bonus = "damage_2" },
	{ x = 2110, y = 710, size = 50, id = 182, color = "yellow", requires = { 179 }, alternative = { 183 }, bonus = "agi_2" },
	{ x = 2010, y = 655, size = 50, id = 183, color = "yellow", requires = { 182 }, alternative = { 184 }, bonus = "move_speed_2" },
	{
		x = 2010,
		y = 545,
		size = 50,
		id = 184,
		color = "yellow",
		requires = { 181 },
		alternative = { 183 },
		bonus = "attack_speed_2",
	},
	{ x = 2730, y = 955, size = 50, id = 185, color = "yellow", requires = { 155 }, alternative = {}, bonus = "attack_speed_2" },
	{ x = 2840, y = 1020, size = 50, id = 186, color = "yellow", requires = { 185 }, alternative = {}, bonus = "move_speed_2" },
	{ x = 2950, y = 1085, size = 50, id = 187, color = "yellow", requires = { 186 }, alternative = {}, bonus = "agi_2" },
	{ x = 3060, y = 1145, size = 50, id = 188, color = "yellow", requires = { 187 }, alternative = {}, bonus = "move_speed_2" },
	{ x = 3060, y = 1260, size = 50, id = 189, color = "yellow", requires = { 188 }, alternative = { 191 }, bonus = "lifesteal_2" },
	{
		x = 3160,
		y = 1090,
		size = 50,
		id = 190,
		color = "yellow",
		requires = { 188 },
		alternative = { 192 },
		bonus = "attack_speed_2",
	},
	{ x = 3160, y = 1315, size = 50, id = 191, color = "yellow", requires = { 189 }, alternative = { 193 }, bonus = "agi_2" },
	{ x = 3250, y = 1145, size = 50, id = 192, color = "yellow", requires = { 190 }, alternative = { 193 }, bonus = "evasion_2" },
	{ x = 3250, y = 1260, size = 50, id = 193, color = "yellow", requires = { 191 }, alternative = { 192 }, bonus = "lifesteal_2" },
	{ x = 2700, y = 790, size = 50, id = 194, color = "yellow", requires = { 155 }, alternative = {}, bonus = "damage_2" },
	{ x = 2700, y = 670, size = 50, id = 195, color = "yellow", requires = { 194 }, alternative = {}, bonus = "move_speed_2" },
	{ x = 2700, y = 555, size = 50, id = 196, color = "yellow", requires = { 195 }, alternative = { 200 }, bonus = "lifesteal_2" },
	{ x = 2605, y = 520, size = 50, id = 197, color = "yellow", requires = { 196 }, alternative = {}, bonus = "agi_2" },
	{ x = 2530, y = 430, size = 50, id = 198, color = "yellow", requires = { 197 }, alternative = {}, bonus = "evasion_3" },
	{ x = 2480, y = 330, size = 50, id = 199, color = "yellow", requires = { 198 }, alternative = {}, bonus = "damage_3" },
	{ x = 2800, y = 500, size = 50, id = 200, color = "yellow", requires = { 196 }, alternative = { 203 }, bonus = "agi_2" },
	{ x = 2800, y = 725, size = 50, id = 201, color = "yellow", requires = { 194 }, alternative = {}, bonus = "evasion_2" },
	{ x = 2895, y = 665, size = 50, id = 202, color = "yellow", requires = { 201 }, alternative = { 203 }, bonus = "damage_2" },
	{ x = 2895, y = 555, size = 50, id = 203, color = "yellow", requires = { 200 }, alternative = { 202 }, bonus = "agi_2" },
	{ x = 2975, y = 730, size = 50, id = 204, color = "yellow", requires = { 202 }, alternative = {}, bonus = "agi_3" },
	{ x = 3090, y = 755, size = 50, id = 205, color = "yellow", requires = { 204 }, alternative = {}, bonus = "move_speed_3" },
	{ x = 3200, y = 745, size = 50, id = 206, color = "yellow", requires = { 205 }, alternative = {}, bonus = "attack_speed_3" },
	{
		x = 1740,
		y = 2445,
		size = 100,
		id = 207,
		color = "purple",
		requires = { 216, 217, 219, 220, 222, 223 },
		alternative = {},
		bonus = "bonus_str_1",
	},
	{ x = 1240, y = 2400, size = 100, id = 208, color = "purple", requires = { 226 }, alternative = {}, bonus = "bonus_str_6" },
	{
		x = 1540,
		y = 2790,
		size = 100,
		id = 209,
		color = "purple",
		requires = { 230, 229, 234, 233, 232, 231 },
		alternative = {},
		bonus = "bonus_str_3",
	},
	{ x = 2030, y = 2855, size = 100, id = 210, color = "purple", requires = { 237 }, alternative = {}, bonus = "bonus_str_10" },
	{ x = 785, y = 3190, size = 100, id = 211, color = "purple", requires = { 251 }, alternative = {}, bonus = "bonus_str_7" },
	{
		x = 1275,
		y = 3255,
		size = 100,
		id = 212,
		color = "purple",
		requires = { 246, 247, 248, 245, 241, 240 },
		alternative = {},
		bonus = "bonus_str_14",
	},
	{ x = 1575, y = 3645, size = 100, id = 213, color = "purple", requires = { 244 }, alternative = {}, bonus = "bonus_str_9" },
	{ x = 1925, y = 2440, size = 50, id = 214, color = "yellow", requires = { 7 }, alternative = {}, bonus = "hp_reg_1" },
	{ x = 1925, y = 2550, size = 50, id = 215, color = "yellow", requires = { 214 }, alternative = {}, bonus = "status_1" },
	{ x = 1840, y = 2390, size = 50, id = 216, color = "yellow", requires = { 7 }, alternative = {}, bonus = "status_1" },
	{ x = 1840, y = 2500, size = 50, id = 217, color = "yellow", requires = { 216 }, alternative = {}, bonus = "mr_1" },
	{ x = 1830, y = 2610, size = 50, id = 218, color = "yellow", requires = { 215 }, alternative = {}, bonus = "hp_reg_1" },
	{ x = 1740, y = 2560, size = 50, id = 219, color = "yellow", requires = { 217 }, alternative = {}, bonus = "mr_1" },
	{ x = 1740, y = 2335, size = 50, id = 220, color = "yellow", requires = { 8 }, alternative = {}, bonus = "mr_1" },
	{ x = 1655, y = 2285, size = 50, id = 221, color = "yellow", requires = { 8 }, alternative = {}, bonus = "armor_1" },
	{ x = 1645, y = 2390, size = 50, id = 222, color = "yellow", requires = { 220 }, alternative = {}, bonus = "armor_1" },
	{ x = 1645, y = 2500, size = 50, id = 223, color = "yellow", requires = { 222 }, alternative = {}, bonus = "armor_1" },
	{ x = 1560, y = 2450, size = 50, id = 224, color = "yellow", requires = { 225 }, alternative = {}, bonus = "hp_1" },
	{ x = 1560, y = 2340, size = 50, id = 225, color = "yellow", requires = { 221 }, alternative = {}, bonus = "hp_1" },
	{ x = 1225, y = 2510, size = 50, id = 226, color = "yellow", requires = { 227 }, alternative = {}, bonus = "armor_1" },
	{ x = 1275, y = 2615, size = 50, id = 227, color = "yellow", requires = { 228 }, alternative = {}, bonus = "str_1" },
	{ x = 1350, y = 2700, size = 50, id = 228, color = "yellow", requires = { 229 }, alternative = {}, bonus = "hp_1" },
	{ x = 1445, y = 2740, size = 50, id = 229, color = "yellow", requires = { 230 }, alternative = { 234 }, bonus = "mr_1" },
	{ x = 1545, y = 2680, size = 50, id = 230, color = "yellow", requires = { 224 }, alternative = { 231 }, bonus = "str_1" },
	{ x = 1640, y = 2740, size = 50, id = 231, color = "yellow", requires = { 218 }, alternative = { 230 }, bonus = "hp_1" },
	{ x = 1640, y = 2850, size = 50, id = 232, color = "yellow", requires = { 231 }, alternative = { 233 }, bonus = "status_1" },
	{ x = 1545, y = 2905, size = 50, id = 233, color = "yellow", requires = { 232 }, alternative = { 234 }, bonus = "hp_reg_1" },
	{ x = 1445, y = 2850, size = 50, id = 234, color = "yellow", requires = { 229 }, alternative = { 233 }, bonus = "status_1" },
	{ x = 1720, y = 2915, size = 50, id = 235, color = "yellow", requires = { 232 }, alternative = {}, bonus = "armor_1" },
	{ x = 1835, y = 2935, size = 50, id = 236, color = "yellow", requires = { 235 }, alternative = {}, bonus = "hp_1" },
	{ x = 1945, y = 2930, size = 50, id = 237, color = "yellow", requires = { 236 }, alternative = {}, bonus = "mr_1" },
	{ x = 1440, y = 2970, size = 50, id = 238, color = "yellow", requires = { 234, 233 }, alternative = {}, bonus = "str_2" },
	{ x = 1380, y = 3080, size = 50, id = 239, color = "yellow", requires = { 238 }, alternative = {}, bonus = "mr_2" },
	{ x = 1375, y = 3200, size = 50, id = 240, color = "yellow", requires = { 239 }, alternative = {}, bonus = "mr_2" },
	{ x = 1370, y = 3310, size = 50, id = 241, color = "yellow", requires = { 240 }, alternative = { 245 }, bonus = "hp_2" },
	{ x = 1470, y = 3350, size = 50, id = 242, color = "yellow", requires = { 241 }, alternative = {}, bonus = "hp_reg_2" },
	{ x = 1545, y = 3435, size = 50, id = 243, color = "yellow", requires = { 242 }, alternative = {}, bonus = "hp_2" },
	{ x = 1595, y = 3535, size = 50, id = 244, color = "yellow", requires = { 243 }, alternative = {}, bonus = "str_3" },
	{ x = 1275, y = 3365, size = 50, id = 245, color = "yellow", requires = { 241 }, alternative = { 248 }, bonus = "hp_reg_2" },
	{ x = 1275, y = 3145, size = 50, id = 246, color = "yellow", requires = { 239 }, alternative = {}, bonus = "armor_2" },
	{ x = 1180, y = 3200, size = 50, id = 247, color = "yellow", requires = { 246 }, alternative = { 248 }, bonus = "str_2" },
	{ x = 1180, y = 3310, size = 50, id = 248, color = "yellow", requires = { 247 }, alternative = { 245 }, bonus = "status_2" },
	{ x = 1100, y = 3135, size = 50, id = 249, color = "yellow", requires = { 247 }, alternative = {}, bonus = "status_2" },
	{ x = 990, y = 3115, size = 50, id = 250, color = "yellow", requires = { 249 }, alternative = {}, bonus = "str_2" },
	{ x = 875, y = 3120, size = 50, id = 251, color = "yellow", requires = { 250 }, alternative = {}, bonus = "str_3" },
	{ x = 2410, y = 2720, size = 100, id = 252, color = "purple", requires = { 264 }, alternative = {}, bonus = "bonus_str_2" },
	{
		x = 2510,
		y = 2890,
		size = 100,
		id = 253,
		color = "purple",
		requires = { 269, 270, 271, 272, 273, 274 },
		alternative = {},
		bonus = "bonus_str_4",
	},
	{ x = 2610, y = 3060, size = 100, id = 254, color = "purple", requires = { 253 }, alternative = {}, bonus = "bonus_str_5" },
	{
		x = 2800,
		y = 3390,
		size = 100,
		id = 255,
		color = "purple",
		requires = { 294, 295, 299, 302, 301, 300 },
		alternative = {},
		bonus = "bonus_str_8",
	},
	{
		x = 2110,
		y = 3400,
		size = 100,
		id = 256,
		color = "purple",
		requires = { 278, 279, 280, 281, 282, 283 },
		alternative = {},
		bonus = "bonus_str_11",
	},
	{ x = 2500, y = 3780, size = 100, id = 257, color = "purple", requires = { 298 }, alternative = {}, bonus = "bonus_str_13" },
	{ x = 3290, y = 3325, size = 100, id = 258, color = "purple", requires = { 305 }, alternative = {}, bonus = "bonus_str_15" },
	{
		x = 3160,
		y = 2795,
		size = 100,
		id = 259,
		color = "purple",
		requires = { 288, 287, 289, 290, 291, 292 },
		alternative = {},
		bonus = "bonus_str_12",
	},
	{ x = 2175, y = 2300, size = 50, id = 260, color = "yellow", requires = { 5, 7 }, alternative = {}, bonus = "str_1" },
	{ x = 2175, y = 2400, size = 50, id = 261, color = "yellow", requires = { 260 }, alternative = { 262 }, bonus = "hp_reg_1" },
	{ x = 2255, y = 2450, size = 50, id = 262, color = "yellow", requires = { 261, 263 }, alternative = {}, bonus = "status_1" },
	{ x = 2255, y = 2350, size = 50, id = 263, color = "yellow", requires = { 260 }, alternative = { 262 }, bonus = "str_1" },
	{ x = 2330, y = 2570, size = 50, id = 264, color = "yellow", requires = { 262 }, alternative = {}, bonus = "armor_1" },
	{ x = 2240, y = 2640, size = 50, id = 265, color = "yellow", requires = { 264 }, alternative = {}, bonus = "hp_reg_1" },
	{ x = 2200, y = 2745, size = 50, id = 266, color = "yellow", requires = { 265 }, alternative = {}, bonus = "mr_1" },
	{ x = 2435, y = 2530, size = 50, id = 267, color = "yellow", requires = { 264 }, alternative = {}, bonus = "str_1" },
	{ x = 2545, y = 2550, size = 50, id = 268, color = "yellow", requires = { 267 }, alternative = {}, bonus = "status_1" },
	{ x = 2595, y = 2730, size = 50, id = 269, color = "yellow", requires = { 252 }, alternative = {}, bonus = "hp_2" },
	{ x = 2685, y = 2790, size = 50, id = 270, color = "yellow", requires = { 269 }, alternative = {}, bonus = "hp_reg_2" },
	{ x = 2695, y = 2900, size = 50, id = 271, color = "yellow", requires = { 270 }, alternative = {}, bonus = "hp_2" },
	{ x = 2330, y = 2880, size = 50, id = 272, color = "yellow", requires = { 252 }, alternative = {}, bonus = "armor_2" },
	{ x = 2335, y = 2995, size = 50, id = 273, color = "yellow", requires = { 272 }, alternative = {}, bonus = "status_2" },
	{ x = 2430, y = 3055, size = 50, id = 274, color = "yellow", requires = { 273 }, alternative = {}, bonus = "str_2" },
	{ x = 2535, y = 3155, size = 50, id = 275, color = "yellow", requires = { 254 }, alternative = {}, bonus = "status_2" },
	{ x = 2425, y = 3220, size = 50, id = 276, color = "yellow", requires = { 275 }, alternative = {}, bonus = "armor_2" },
	{ x = 2315, y = 3285, size = 50, id = 277, color = "yellow", requires = { 276 }, alternative = {}, bonus = "str_2" },
	{ x = 2205, y = 3345, size = 50, id = 278, color = "yellow", requires = { 277 }, alternative = {}, bonus = "armor_2" },
	{ x = 2205, y = 3455, size = 50, id = 279, color = "yellow", requires = { 278 }, alternative = { 280 }, bonus = "mr_2" },
	{ x = 2110, y = 3515, size = 50, id = 280, color = "yellow", requires = { 279 }, alternative = { 283 }, bonus = "hp_reg_3" },
	{ x = 2110, y = 3280, size = 50, id = 281, color = "yellow", requires = { 278 }, alternative = { 282 }, bonus = "armor_2" },
	{ x = 2010, y = 3345, size = 50, id = 282, color = "yellow", requires = { 281 }, alternative = { 283 }, bonus = "status_3" },
	{ x = 2010, y = 3455, size = 50, id = 283, color = "yellow", requires = { 282 }, alternative = { 280 }, bonus = "str_2" },
	{ x = 2730, y = 3045, size = 50, id = 284, color = "yellow", requires = { 254 }, alternative = {}, bonus = "hp_reg_2" },
	{ x = 2840, y = 2980, size = 50, id = 285, color = "yellow", requires = { 284 }, alternative = {}, bonus = "mr_2" },
	{ x = 2950, y = 2915, size = 50, id = 286, color = "yellow", requires = { 285 }, alternative = {}, bonus = "hp_2" },
	{ x = 3060, y = 2855, size = 50, id = 287, color = "yellow", requires = { 286 }, alternative = {}, bonus = "mr_2" },
	{ x = 3060, y = 2740, size = 50, id = 288, color = "yellow", requires = { 287 }, alternative = { 290 }, bonus = "status_2" },
	{ x = 3160, y = 2910, size = 50, id = 289, color = "yellow", requires = { 287 }, alternative = { 291 }, bonus = "hp_reg_2" },
	{ x = 3160, y = 2685, size = 50, id = 290, color = "yellow", requires = { 288 }, alternative = { 292 }, bonus = "armor_3" },
	{ x = 3250, y = 2855, size = 50, id = 291, color = "yellow", requires = { 289 }, alternative = { 292 }, bonus = "mr_3" },
	{ x = 3250, y = 2740, size = 50, id = 292, color = "yellow", requires = { 290 }, alternative = { 291 }, bonus = "str_2" },
	{ x = 2700, y = 3210, size = 50, id = 293, color = "yellow", requires = { 254 }, alternative = {}, bonus = "str_2" },
	{ x = 2700, y = 3330, size = 50, id = 294, color = "yellow", requires = { 293 }, alternative = {}, bonus = "mr_3" },
	{ x = 2700, y = 3445, size = 50, id = 295, color = "yellow", requires = { 294 }, alternative = { 299 }, bonus = "hp_reg_3" },
	{ x = 2605, y = 3480, size = 50, id = 296, color = "yellow", requires = { 295 }, alternative = {}, bonus = "mr_3" },
	{ x = 2530, y = 3570, size = 50, id = 297, color = "yellow", requires = { 296 }, alternative = {}, bonus = "hp_reg_3" },
	{ x = 2480, y = 3670, size = 50, id = 298, color = "yellow", requires = { 297 }, alternative = {}, bonus = "str_3" },
	{ x = 2800, y = 3500, size = 50, id = 299, color = "yellow", requires = { 295 }, alternative = { 302 }, bonus = "hp_3" },
	{ x = 2800, y = 3275, size = 50, id = 300, color = "yellow", requires = { 293 }, alternative = {}, bonus = "status_3" },
	{ x = 2895, y = 3335, size = 50, id = 301, color = "yellow", requires = { 300 }, alternative = { 302 }, bonus = "str_3" },
	{ x = 2895, y = 3445, size = 50, id = 302, color = "yellow", requires = { 299 }, alternative = { 301 }, bonus = "armor_3" },
	{ x = 2975, y = 3270, size = 50, id = 303, color = "yellow", requires = { 301 }, alternative = {}, bonus = "status_3" },
	{ x = 3090, y = 3245, size = 50, id = 304, color = "yellow", requires = { 303 }, alternative = {}, bonus = "str_3" },
	{ x = 3200, y = 3255, size = 50, id = 305, color = "yellow", requires = { 304 }, alternative = {}, bonus = "hp_3" },
}

ListenToGameEvent("npc_spawned", function(data)
	local unit = EntIndexToHScript(data.entindex)

	if not unit then
		return
	end
	if not unit.IsBaseNPC or not unit:IsBaseNPC() then
		return
	end
	if not unit:IsRealHero() then
		return
	end

	local talentsCalculated = unit.__talentsCalculated

	if not talentsCalculated then
		return
	end

	unit.__talentsCalculated = nil

	if unit:HasModifier("modifier_talents") then --- проблема с OnRefresh() поэтому так
		unit:RemoveModifierByName("modifier_talents")
		unit:AddNewModifier(unit, nil, "modifier_talents", talentsCalculated)
	else
		unit:AddNewModifier(unit, nil, "modifier_talents", talentsCalculated)
	end
end, nil)

function acc:update_talents(pid, talents)
	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	local talents_calculated = {}

	local talent_lookup = {}
	for _, id in ipairs(talents) do
		talent_lookup[id] = true
	end

	for _, talent in ipairs(talents_data) do
		if talent_lookup[talent.id] then
			talents_calculated[talent.bonus] = (talents_calculated[talent.bonus] or 0) + 1
		end
	end

	if hero:IsAlive() then
		if hero:HasModifier("modifier_talents") then --- проблема с OnRefresh() поэтому так
			hero:RemoveModifierByName("modifier_talents")
			hero:AddNewModifier(hero, nil, "modifier_talents", talents_calculated)
		else
			hero:AddNewModifier(hero, nil, "modifier_talents", talents_calculated)
		end
	else
		hero.__talentsCalculated = talents_calculated
	end
end

function acc:get_account_progress(t)
	print("get_account_progress")
	acc:GetTalentsRequest(t.PlayerID)
end

function acc:GetTalentsRequest(pid, callback)
	arr = {
		sid = tostring(PlayerResource:GetSteamID(pid)),
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_get_account_progress/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local talents = json.decode(res.Body)
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(pid),
				"init_account",
				{ player_talents = talents, talents_data = talents_data, talents_stats = _G.talents_stats }
			)
			local tal = talents.talents or {}
			acc:update_talents(pid, tal)

			if callback then
				callback(pid, tal)
			end
		else
			print(res.StatusCode)
		end
	end)
end

function acc:buy_account_progress(t)
	acc:GetTalentsRequest(t.PlayerID, function(_, talents)
		local talent_lookup = {}
		for _, id in ipairs(talents) do
			talent_lookup[id] = true
		end

		local talentIdToLearn = t.id
		local talentDataToLearn

		for _, talent in ipairs(talents_data) do
			if talent.id == talentIdToLearn then
				talentDataToLearn = talent
				break
			end
		end
		if not talentDataToLearn then
			return
		end

		local requiredCheckPassed = true
		for _, requiredTalent in ipairs(talentDataToLearn.requires) do
			if not talent_lookup[requiredTalent] then
				requiredCheckPassed = false
				break
			end
		end

		local alternativeCheckPassed = false
		if talentDataToLearn.alternative and #talentDataToLearn.alternative > 0 then
			for _, alternativeTalent in ipairs(talentDataToLearn.alternative) do
				if talent_lookup[alternativeTalent] then
					alternativeCheckPassed = true
					break
				end
			end
		end

		if not requiredCheckPassed and not alternativeCheckPassed then
			return
		end

		arr = {
			sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
			id = talentIdToLearn,
		}

		arr = json.encode(arr)
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_buy_account_talent1/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", arr)
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			if res.StatusCode == 200 and res.Body ~= nil then
				local talents = json.decode(res.Body)
				if talents.status then
					EmitAnnouncerSoundForPlayer("ui.trophy_levelup", t.PlayerID)
				end
				CustomGameEventManager:Send_ServerToPlayer(
					PlayerResource:GetPlayer(t.PlayerID),
					"init_account",
					{ player_talents = talents, talents_data = talents_data, talents_stats = _G.talents_stats }
				)
				local tal = talents.talents or {}
				acc:update_talents(t.PlayerID, tal)
			else
				print(res.StatusCode)
			end
		end)
	end)
end

function acc:reset_account_progress(t)
	arr = {
		sid = tostring(PlayerResource:GetSteamID(t.PlayerID)),
	}
	arr = json.encode(arr)
	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_reset_account_talents/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			local talents = json.decode(res.Body)
			if talents.status then
				EmitAnnouncerSoundForPlayer("ui.trophy_levelup", t.PlayerID)
			end
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(t.PlayerID),
				"init_account",
				{ player_talents = talents, talents_data = talents_data, talents_stats = _G.talents_stats }
			)
			local tal = talents.talents or {}
			acc:update_talents(t.PlayerID, tal)
		else
			print(res.StatusCode)
		end
	end)
end

------------------------------------------------------ BOSS REWARDS -------------------------------------------------

local boss_reward_modifiers = {
	"modifier_agi_10",
	"modifier_armor_5",
	"modifier_as_30",
	"modifier_attack_range_50",
	"modifier_cd_5",
	"modifier_damage_40",
	"modifier_evasion_10",
	"modifier_exp_3",
	"modifier_hp_regen_10",
	"modifier_int_10",
	"modifier_mg_resist_5",
	"modifier_mp_regen_10",
	"modifier_ms_30",
	"modifier_spell_10",
	"modifier_str_10",
}

-- Белый список наград за босса
local boss_reward_lookup = {}
for _, name in ipairs(boss_reward_modifiers) do
	boss_reward_lookup[name] = true
end

-- [pid] = список предложенных наград; nil означает, что у игрока нет открытой панели выбора
_G.offered_boss_rewards = _G.offered_boss_rewards or {}

function acc:skillsPreparation(t)
	local result = {}
	while #result < 3 do
		local skill = boss_reward_modifiers[RandomInt(1, #boss_reward_modifiers)]
		local exists = false
		for i = 1, #result do
			if result[i] == skill then
				exists = true
				break
			end
		end
		if not exists then
			table.insert(result, skill)
		end
	end
	return result
end

function acc:show(t)
	-- Если панель у игрока уже открыта, клиент новый набор игнорирует (reward.js), поэтому не переролливаем:
	-- иначе сервер ждёт один набор, а игрок видит другой
	local skills = _G.offered_boss_rewards[t.PlayerID]
	if not skills then
		skills = acc:skillsPreparation(t)
		_G.offered_boss_rewards[t.PlayerID] = skills
	end

	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "show_skills_js", skills)
end

function acc:select_skill_lua(t)
	if not _G.RewardPoints[t.PlayerID] or _G.RewardPoints[t.PlayerID] < 1 then
		return
	end

	local modifierCount = 0
	local ability_name = nil
	for k, v in pairs(t) do
		if type(v) == "string" and string.sub(v, 0, 8) == "modifier" then
			modifierCount = modifierCount + 1
			ability_name = v
		end
	end

	if modifierCount > 1 then
		rules:BanPlayers({ t.PlayerID }, "exploit: multiple_boss_reward")
		return
	end

	if modifierCount == 0 then
		return
	end

	-- Модификатор не из наград за босса честный клиент прислать не может
	if not boss_reward_lookup[ability_name] then
		rules:BanPlayers({ t.PlayerID }, "exploit: unknown_boss_reward")
		return
	end

	local offered = _G.offered_boss_rewards[t.PlayerID]
	if not offered then
		-- Набор игроку не выдавался (рассинхрон / перезагрузка скриптов) — роллим заново
		acc:show({ PlayerID = t.PlayerID })
		return
	end

	local isOffered = false
	for _, name in ipairs(offered) do
		if name == ability_name then
			isOffered = true
			break
		end
	end

	-- Подмена одного из предложенных вариантов: поинт не тратим и новый набор не роллим
	if not isOffered then
		return
	end

	_G.offered_boss_rewards[t.PlayerID] = nil
	_G.RewardPoints[t.PlayerID] = _G.RewardPoints[t.PlayerID] - 1

	local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)
	LinkLuaModifier(ability_name, "modifiers/boss_reward/" .. ability_name, LUA_MODIFIER_MOTION_NONE)
	hero:AddNewModifier(hero, nil, ability_name, {})

	local guildMod = hero:FindModifierByName("modifier_guild")
	if guildMod and guildMod.doubleBuffChance > RandomInt(0, 100) then
		hero:AddNewModifier(hero, nil, ability_name, {})
	end

	EmitSoundOn("hud.equip.agh_shard", hero)

	if _G.RewardPoints[t.PlayerID] > 0 then
		acc:show({ PlayerID = t.PlayerID })
	end
end

acc:init()