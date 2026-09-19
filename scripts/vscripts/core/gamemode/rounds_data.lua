--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@type table<integer, table<string, {unitName: string, spawnInterval: number, unitNumber: integer}[]>>
local ROUNDS_DATA = {
	{
		round_skeleton = {
			{
				unitName = "npc_dota_skeleton",
				unitNumber = 15,
				spawnInterval = 0.3,
			},
		},
		round_kobold = {
			{
				unitName = "npc_dota_kobold",
				unitNumber = 6,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_kobold_tunneler",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_kobold_taskmaster",
				unitNumber = 1,
				spawnInterval = 0.5,
			},
		},
		round_troll = {
			{
				unitName = "npc_dota_forest_troll_berserker",
				unitNumber = 5,
				spawnInterval = 0.3,
			},
			{
				unitName = "npc_dota_forest_troll_high_priest",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_troll_and_kobold = {
			{
				unitName = "npc_dota_forest_troll_berserker",
				unitNumber = 5,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_kobold_taskmaster",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_gnoll_assassin = {
			{
				unitName = "npc_dota_gnoll_assassin",
				unitNumber = 7,
				spawnInterval = 0.4,
			},
		},
		round_ghost = {
			{
				unitName = "npc_dota_fel_beast",
				unitNumber = 5,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_ghost",
				unitNumber = 1,
				spawnInterval = 0.5,
			},
		},
		round_harpy = {
			{
				unitName = "npc_dota_harpy_scout",
				unitNumber = 5,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_harpy_storm",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_crocodilian = {
			{
				unitName = "npc_dota_crocodilian",
				unitNumber = 7,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_crocodilian_ranged",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_chameleon = {
			{
				unitName = "npc_dota_chameleon",
				unitNumber = 7,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_chameleon_ranged",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_greevil = {
			{
				unitName = "npc_dota_greevil",
				unitNumber = 15,
				spawnInterval = 0.2,
			},
		},
	},
	{
		round_centaur = {
			{
				unitName = "npc_dota_centaur_outrunner",
				unitNumber = 5,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_centaur_khan",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_wolf = {
			{
				unitName = "npc_dota_giant_wolf",
				unitNumber = 5,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_alpha_wolf",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_satyr = {
			{
				unitName = "npc_dota_satyr_trickster",
				unitNumber = 6,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_satyr_soulstealer",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_ogre = {
			{
				unitName = "npc_dota_ogre_mauler",
				unitNumber = 7,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_ogre_magi",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_golem = {
			{
				unitName = "npc_dota_mud_golem",
				unitNumber = 7,
				spawnInterval = 0.3,
			},
		},
	},
	{
		round_centaur_big = {
			{
				unitName = "npc_dota_centaur_outrunner",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_centaur_khan",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
		},
		round_satyr_big = {
			{
				unitName = "npc_dota_satyr_trickster",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_satyr_soulstealer",
				unitNumber = 1,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_satyr_hellcaller",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_hellbear = {
			{
				unitName = "npc_dota_polar_furbolg_champion",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
			{
				unitName = "npc_dota_polar_furbolg_ursa_warrior",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_wild = {
			{
				unitName = "npc_dota_wildkin",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_enraged_wildkin",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_dark_troll = {
			{
				unitName = "npc_dota_dark_troll",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_dark_troll_warlord",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_ogreseal = {
			{
				unitName = "npc_dota_ogreseal",
				unitNumber = 6,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_ogreseal_big",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_ogre_warlord = {
			{
				unitName = "npc_dota_ogre_mauler",
				unitNumber = 6,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_ogre_warlord",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_explode_spider = {
			{
				unitName = "npc_dota_explode_spider",
				unitNumber = 11,
				spawnInterval = 0.3,
			},
		},
		round_elf_wolf = {
			{
				unitName = "npc_dota_elf_wolf",
				unitNumber = 10,
				spawnInterval = 0.3,
			},
		},
	},
	{
		round_dragon = {
			{
				unitName = "npc_dota_black_drake",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_black_dragon",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_large_golem = {
			{
				unitName = "npc_dota_rock_golem",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_granite_golem",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_thunder_lizard = {
			{
				unitName = "npc_dota_small_thunder_lizard",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_big_thunder_lizard",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_prowler = {
			{
				unitName = "npc_dota_prowler_acolyte",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_prowler_shaman",
				unitNumber = 2,
				spawnInterval = 0.5,
			},
		},
		round_frostbitten = {
			{
				unitName = "npc_dota_frostbitten_mage",
				unitNumber = 6,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_frostbitten_gaint",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
		},
		round_spider = {
			{
				unitName = "npc_dota_spider_melee",
				unitNumber = 5,
				spawnInterval = 0.4,
			},
			{
				unitName = "npc_dota_spider_range",
				unitNumber = 3,
				spawnInterval = 0.5,
			},
		},
		round_timber_spider = {
			{
				unitName = "npc_dota_timber_spider",
				unitNumber = 10,
				spawnInterval = 0.4,
			},
		},
	},
	{
		round_roshan = {
			{
				unitName = "npc_dota_roshan",
				unitNumber = 1,
				spawnInterval = 0.4,
			},
		},
	},
}

return ROUNDS_DATA