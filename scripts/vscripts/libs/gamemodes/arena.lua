--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


_G.STARTGAME_DURATION_PVE = 35
_G.PVE_CURRENT_WAVE = 1
_G.PVE_WAVES_COMPLETE = 0
_G.LAST_ROUNDS_DURATION = 150
_G.DELAY_WAVES = 2
_G.PVE_AEGIS_COUNT = 2
_G.PVE_RESPAWN_TIME_AEGIS = 5
_G.DELAY_WAVES_TIME_RELAX = 5
_G.WAVE_MULTIPLIER_FROGS = 0

-- Скалирующие переменные волн
_G.PVE_REWARD_EXP_PERCENTAGE_PER_WAVE = 2
_G.PVE_REWARD_GOLD_PERCENTAGE_PER_WAVE = 2
_G.PVE_REWARD_MAXIMUM_STACK_CAP = 60

_G.PVE_BONUS_PER_WAVE_BONUS_DAMAGE = 3
_G.PVE_BONUS_PER_WAVE_BONUS_DAMAGE_PCT = 2.5
_G.PVE_BONUS_PER_WAVE_ARMOR = 0.4
_G.PVE_BONUS_PER_WAVE_ARMOR_PCT = 0.3
_G.PVE_BONUS_PER_WAVE_MAGICAL_RESISTANCE = 0.4
_G.PVE_BONUS_PER_WAVE_HEALTH = 25
_G.PVE_BONUS_PER_WAVE_HEALTH_PCT = 3
_G.PVE_BONUS_PER_WAVE_SPELL_AMPLIFY = 1.5
_G.PVE_BONUS_PER_WAVE_ATTACK_SPEED = 3
_G.PVE_BONUS_PER_WAVE_MOVE_SPEED = 1
_G.PVE_BONUS_PER_WAVE_GLOBAL_DAMAGE = -0.25

_G.PVE_BONUS_PER_WAVE_BOSS_DAMAGE = 4
_G.PVE_BONUS_PER_WAVE_BOSS_HEALTH = 3

_G.PVE_BONUS_PER_WAVE_STATUS_RESISTANCE = 0.20

_G.GOLD_PER_BOSS_AFTER_70_WAVES = 2400
----------------------------------

_G.REMOVE_CREEPS_UGPRADE_TEST = false
_G.CREEPS_ABILITIES = {}

local units_txt = LoadKeyValues("scripts/npc/npc_units_custom.txt")

--КАКИЕ КРИПЫ В КАКОМ ТИРЕ--
WAVES_PVE_MODE =
{

	{"npc_woda_creep6_pve","npc_woda_creep6_pve","npc_woda_creep6_pve","npc_woda_creep6_pve","npc_woda_creep6_pve"},
	{"npc_woda_creep5_pve","npc_woda_creep5_pve","npc_woda_creep5_pve","npc_woda_creep5_pve","npc_woda_creep5_pve"},
	{"npc_woda_creep4_pve","npc_woda_creep4_pve","npc_woda_creep4_pve","npc_woda_creep4_pve","npc_woda_creep4_pve"},
	{"npc_woda_creep8_pve","npc_woda_creep8_pve","npc_woda_creep8_pve","npc_woda_creep8_pve","npc_woda_creep8_pve"},
	{"npc_woda_creep3_pve","npc_woda_creep3_pve","npc_woda_creep3_pve","npc_woda_creep3_pve","npc_woda_creep3_pve"},
	{"npc_woda_creep1_pve","npc_woda_creep1_pve","npc_woda_creep1_pve","npc_woda_creep1_pve","npc_woda_creep1_pve"},
	{"npc_woda_creep2_pve","npc_woda_creep2_pve","npc_woda_creep2_pve","npc_woda_creep2_pve","npc_woda_creep2_pve"},
	{"npc_woda_creep9_pve","npc_woda_creep9_pve","npc_woda_creep9_pve","npc_woda_creep9_pve","npc_woda_creep9_pve"},
	{"npc_woda_creep10_pve","npc_woda_creep10_pve","npc_woda_creep10_pve","npc_woda_creep10_pve","npc_woda_creep10_pve"},
	{"boss_1_pve"},

	{"npc_woda_creep12_pve","npc_woda_creep12_pve","npc_woda_creep12_pve","npc_woda_creep12_pve","npc_woda_creep12_pve"},
	{"npc_woda_creep11_pve","npc_woda_creep11_pve","npc_woda_creep11_pve","npc_woda_creep11_pve","npc_woda_creep11_pve"},
	{"npc_woda_creep7_pve","npc_woda_creep7_pve","npc_woda_creep7_pve","npc_woda_creep7_pve","npc_woda_creep7_pve"},
	{"npc_woda_creep13_pve","npc_woda_creep13_pve","npc_woda_creep13_pve","npc_woda_creep13_pve","npc_woda_creep13_pve"},
	{"npc_woda_creep81_pve","npc_woda_creep81_pve","npc_woda_creep81_pve","npc_woda_creep81_pve","npc_woda_creep81_pve"},
	{"npc_woda_creep15_pve","npc_woda_creep15_pve","npc_woda_creep15_pve","npc_woda_creep14_pve","npc_woda_creep14_pve"},
	{"npc_woda_creep19_pve","npc_woda_creep19_pve","npc_woda_creep19_pve","npc_woda_creep18_pve","npc_woda_creep18_pve"},
	{"npc_woda_creep22_pve","npc_woda_creep22_pve","npc_woda_creep22_pve","npc_woda_creep22_pve","npc_woda_creep22_pve"},
	{"npc_woda_creep23_pve","npc_woda_creep23_pve","npc_woda_creep23_pve","npc_woda_creep23_pve","npc_woda_creep23_pve"},
	{"npc_woda_boss_heal_bear_1"},

	{"npc_woda_creep16_pve","npc_woda_creep16_pve","npc_woda_creep16_pve","npc_woda_creep16_pve","npc_woda_creep16_pve"},
	{"npc_woda_creep17_pve","npc_woda_creep17_pve","npc_woda_creep17_pve","npc_woda_creep17_pve","npc_woda_creep17_pve"},
	{"npc_woda_creep20_pve","npc_woda_creep20_pve","npc_woda_creep20_pve","npc_woda_creep20_pve","npc_woda_creep20_pve"},
	{"npc_woda_creep21_pve","npc_woda_creep21_pve","npc_woda_creep21_pve","npc_woda_creep21_pve","npc_woda_creep21_pve"},
	{"npc_woda_creep24_pve","npc_woda_creep24_pve","npc_woda_creep24_pve","npc_woda_creep24_pve","npc_woda_creep24_pve"},
	{"npc_woda_creep31_pve","npc_woda_creep31_pve","npc_woda_creep31_pve","npc_woda_creep31_pve","npc_woda_creep31_pve"},
	{"npc_woda_creep83_pve","npc_woda_creep83_pve","npc_woda_creep83_pve","npc_woda_creep83_pve","npc_woda_creep83_pve"},
	{"npc_woda_creep39_pve","npc_woda_creep39_pve","npc_woda_creep39_pve","npc_woda_creep39_pve","npc_woda_creep39_pve"},
	{"npc_woda_creep59_pve","npc_woda_creep59_pve","npc_woda_creep59_pve","npc_woda_creep59_pve","npc_woda_creep59_pve"},
	{"boss_2_pve"},

	{"npc_woda_creep26_pve","npc_woda_creep26_pve","npc_woda_creep26_pve","npc_woda_creep25_pve","npc_woda_creep25_pve"},
	{"npc_woda_creep28_pve","npc_woda_creep28_pve","npc_woda_creep28_pve","npc_woda_creep27_pve","npc_woda_creep27_pve"},
	{"npc_woda_creep29_pve","npc_woda_creep29_pve","npc_woda_creep29_pve","npc_woda_creep29_pve","npc_woda_creep29_pve"},
	{"npc_woda_creep30_pve","npc_woda_creep30_pve","npc_woda_creep30_pve","npc_woda_creep30_pve","npc_woda_creep30_pve"},
	{"npc_woda_creep34_pve","npc_woda_creep34_pve","npc_woda_creep34_pve","npc_woda_creep34_pve","npc_woda_creep34_pve"},
	{"npc_woda_creep36_pve","npc_woda_creep36_pve","npc_woda_creep36_pve","npc_woda_creep35_pve","npc_woda_creep35_pve"},
	{"npc_woda_creep41_pve","npc_woda_creep41_pve","npc_woda_creep41_pve","npc_woda_creep41_pve","npc_woda_creep41_pve"},
	{"npc_woda_creep42_pve","npc_woda_creep42_pve","npc_woda_creep42_pve","npc_woda_creep42_pve","npc_woda_creep42_pve"},
	{"npc_woda_creep40_pve","npc_woda_creep40_pve","npc_woda_creep40_pve","npc_woda_creep40_pve","npc_woda_creep40_pve"},
	{"boss_3_pve"},

	{"npc_woda_creep33_pve","npc_woda_creep33_pve","npc_woda_creep33_pve","npc_woda_creep32_pve","npc_woda_creep32_pve"},
	{"npc_woda_creep44_pve","npc_woda_creep44_pve","npc_woda_creep44_pve","npc_woda_creep44_pve","npc_woda_creep44_pve"},
	{"npc_woda_creep43_pve","npc_woda_creep43_pve","npc_woda_creep43_pve","npc_woda_creep43_pve","npc_woda_creep43_pve"},
	{"npc_woda_creep38_pve","npc_woda_creep38_pve","npc_woda_creep38_pve","npc_woda_creep38_pve","npc_woda_creep38_pve"},
	{"npc_woda_creep37_pve","npc_woda_creep37_pve","npc_woda_creep37_pve","npc_woda_creep37_pve","npc_woda_creep37_pve"},
	{"npc_woda_creep45_pve","npc_woda_creep45_pve","npc_woda_creep45_pve","npc_woda_creep45_pve","npc_woda_creep45_pve"},
	{"npc_woda_creep46_pve","npc_woda_creep46_pve","npc_woda_creep46_pve","npc_woda_creep46_pve","npc_woda_creep46_pve"},
	{"npc_woda_creep84_pve","npc_woda_creep84_pve","npc_woda_creep84_pve","npc_woda_creep84_pve","npc_woda_creep84_pve"},
	{"npc_woda_creep85_pve","npc_woda_creep85_pve","npc_woda_creep85_pve","npc_woda_creep85_pve","npc_woda_creep85_pve"},
	{"boss_4_pve"},

	{"npc_woda_creep82_pve","npc_woda_creep82_pve","npc_woda_creep82_pve","npc_woda_creep82_pve","npc_woda_creep82_pve"},
	{"npc_woda_creep48_pve","npc_woda_creep48_pve","npc_woda_creep48_pve","npc_woda_creep47_pve","npc_woda_creep47_pve"},
	{"npc_woda_creep49_pve","npc_woda_creep49_pve","npc_woda_creep49_pve","npc_woda_creep49_pve","npc_woda_creep49_pve"},
	{"npc_woda_creep52_pve","npc_woda_creep52_pve","npc_woda_creep52_pve","npc_woda_creep52_pve","npc_woda_creep52_pve"},
	{"npc_woda_creep53_pve","npc_woda_creep53_pve","npc_woda_creep53_pve","npc_woda_creep50_pve","npc_woda_creep50_pve"},
	{"npc_woda_creep66_pve","npc_woda_creep66_pve","npc_woda_creep66_pve","npc_woda_creep66_pve","npc_woda_creep66_pve"},
	{"npc_woda_creep51_pve","npc_woda_creep51_pve","npc_woda_creep51_pve","npc_woda_creep51_pve","npc_woda_creep51_pve"},
	{"npc_woda_creep61_pve","npc_woda_creep61_pve","npc_woda_creep61_pve","npc_woda_creep61_pve","npc_woda_creep61_pve"},
	{"npc_woda_creep62_pve","npc_woda_creep62_pve","npc_woda_creep62_pve","npc_woda_creep62_pve","npc_woda_creep62_pve"},
	{"boss_5_pve"},

	{"npc_woda_creep56_pve","npc_woda_creep56_pve","npc_woda_creep56_pve","npc_woda_creep56_pve","npc_woda_creep56_pve"},
	{"npc_woda_creep57_pve","npc_woda_creep57_pve","npc_woda_creep57_pve","npc_woda_creep57_pve","npc_woda_creep57_pve"},
	{"npc_woda_creep58_pve","npc_woda_creep58_pve","npc_woda_creep58_pve","npc_woda_creep58_pve","npc_woda_creep58_pve"},
	{"npc_woda_creep55_pve","npc_woda_creep55_pve","npc_woda_creep55_pve","npc_woda_creep54_pve","npc_woda_creep54_pve"},
	{"npc_woda_creep60_pve","npc_woda_creep60_pve","npc_woda_creep60_pve","npc_woda_creep60_pve","npc_woda_creep60_pve"},
	{"npc_woda_creep64_pve","npc_woda_creep64_pve","npc_woda_creep64_pve","npc_woda_creep64_pve","npc_woda_creep64_pve"},
	{"npc_woda_creep70_pve","npc_woda_creep70_pve","npc_woda_creep70_pve","npc_woda_creep70_pve","npc_woda_creep70_pve"},
	{"npc_woda_creep71_pve","npc_woda_creep71_pve","npc_woda_creep71_pve","npc_woda_creep71_pve","npc_woda_creep71_pve"},
	{"npc_woda_creep69_pve","npc_woda_creep69_pve","npc_woda_creep69_pve","npc_woda_creep69_pve","npc_woda_creep69_pve"},
	{"boss_6_pve"},

	{"npc_woda_creep63_pve","npc_woda_creep63_pve","npc_woda_creep63_pve","npc_woda_creep63_pve","npc_woda_creep63_pve"},
	{"npc_woda_creep65_pve","npc_woda_creep65_pve","npc_woda_creep65_pve","npc_woda_creep65_pve","npc_woda_creep65_pve"},
	{"npc_woda_creep73_pve","npc_woda_creep73_pve","npc_woda_creep73_pve","npc_woda_creep72_pve","npc_woda_creep72_pve"},
	{"npc_woda_creep74_pve","npc_woda_creep74_pve","npc_woda_creep74_pve","npc_woda_creep74_pve","npc_woda_creep74_pve"},
	{"npc_woda_creep75_pve","npc_woda_creep75_pve","npc_woda_creep75_pve","npc_woda_creep75_pve","npc_woda_creep75_pve"},
	{"npc_woda_creep79_pve","npc_woda_creep79_pve","npc_woda_creep79_pve","npc_woda_creep79_pve","npc_woda_creep79_pve"},
	{"npc_woda_creep78_pve","npc_woda_creep78_pve","npc_woda_creep78_pve","npc_woda_creep78_pve","npc_woda_creep78_pve"},
	{"npc_woda_creep68_pve","npc_woda_creep68_pve","npc_woda_creep68_pve","npc_woda_creep67_pve","npc_woda_creep67_pve"},
	{"npc_woda_creep80_pve","npc_woda_creep80_pve","npc_woda_creep80_pve","npc_woda_creep80_pve","npc_woda_creep80_pve"},
	{"boss_7_pve"},


	{"npc_woda_creep77_pve","npc_woda_creep77_pve","npc_woda_creep77_pve","npc_woda_creep77_pve","npc_woda_creep77_pve"},
	{"npc_woda_creep76_pve","npc_woda_creep76_pve","npc_woda_creep76_pve","npc_woda_creep76_pve","npc_woda_creep76_pve"},
	{"npc_woda_creep86_pve","npc_woda_creep86_pve","npc_woda_creep86_pve","npc_woda_creep86_pve","npc_woda_creep86_pve"},
	{"npc_woda_creep87_pve","npc_woda_creep87_pve","npc_woda_creep87_pve","npc_woda_creep87_pve","npc_woda_creep87_pve"},
	{"npc_woda_creep88_pve","npc_woda_creep88_pve","npc_woda_creep88_pve","npc_woda_creep88_pve","npc_woda_creep88_pve"},
	{"npc_woda_creep89_pve","npc_woda_creep89_pve","npc_woda_creep89_pve","npc_woda_creep89_pve","npc_woda_creep89_pve"},
	{"npc_woda_creep91_pve","npc_woda_creep91_pve","npc_woda_creep91_pve","npc_woda_creep91_pve","npc_woda_creep91_pve"},
	{"npc_woda_creep92_pve","npc_woda_creep92_pve","npc_woda_creep92_pve","npc_woda_creep90_pve","npc_woda_creep90_pve"},
	{"npc_woda_creep93_pve","npc_woda_creep93_pve","npc_woda_creep93_pve","npc_woda_creep93_pve","npc_woda_creep93_pve"},
	{"boss_9_pve"},
}

RANDOM_FROG_WAVES = 
{
    {"npc_woda_creep_red_pve","npc_woda_creep_red_pve","npc_woda_creep_red_pve","npc_woda_creep_red_pve"},
	{"npc_woda_creep_orange_pve","npc_woda_creep_orange_pve","npc_woda_creep_orange_pve","npc_woda_creep_orange_pve"},
	{"npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve"},
	{"npc_woda_creep_green_pve","npc_woda_creep_green_pve","npc_woda_creep_green_pve","npc_woda_creep_green_pve"},
	{"npc_woda_creep_blue_pve","npc_woda_creep_blue_pve","npc_woda_creep_blue_pve","npc_woda_creep_blue_pve"},
	{"npc_woda_creep_purple_pve","npc_woda_creep_purple_pve","npc_woda_creep_purple_pve","npc_woda_creep_purple_pve"},

	{"npc_woda_creep_red_pve","npc_woda_creep_red_pve","npc_woda_creep_orange_pve","npc_woda_creep_orange_pve"},
	{"npc_woda_creep_orange_pve","npc_woda_creep_orange_pve","npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve"},
	{"npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve","npc_woda_creep_green_pve","npc_woda_creep_green_pve"},
	{"npc_woda_creep_green_pve","npc_woda_creep_green_pve","npc_woda_creep_blue_pve","npc_woda_creep_blue_pve"},
	{"npc_woda_creep_blue_pve","npc_woda_creep_blue_pve","npc_woda_creep_purple_pve","npc_woda_creep_purple_pve"},
	{"npc_woda_creep_purple_pve","npc_woda_creep_purple_pve","npc_woda_creep_red_pve","npc_woda_creep_red_pve"},

	{"npc_woda_creep_red_pve","npc_woda_creep_red_pve","npc_woda_creep_orange_pve","npc_woda_creep_yellow_pve"},
	{"npc_woda_creep_green_pve","npc_woda_creep_green_pve","npc_woda_creep_blue_pve","npc_woda_creep_purple_pve"},
	{"npc_woda_creep_orange_pve","npc_woda_creep_orange_pve","npc_woda_creep_yellow_pve","npc_woda_creep_green_pve"},
	{"npc_woda_creep_yellow_pve","npc_woda_creep_yellow_pve","npc_woda_creep_green_pve","npc_woda_creep_blue_pve"},
	{"npc_woda_creep_blue_pve","npc_woda_creep_blue_pve","npc_woda_creep_purple_pve","npc_woda_creep_red_pve"},
	{"npc_woda_creep_purple_pve","npc_woda_creep_purple_pve","npc_woda_creep_red_pve","npc_woda_creep_orange_pve"},
}

function arena_system:StartGameArenaPve()
    CreateModifierThinker(nil, nil, "modifier_events_thinker_woda", {}, Vector(0,0,0), DOTA_TEAM_NEUTRALS, false)
    SetCustomTimeOfDay(0.5)
    
	GameRules:ForceGameStart()

	CustomGameEventManager:Send_ServerToAllClients("notification_pve_players_hard", {player = player_system:GetPlayerCountAll()})

	for id, player in pairs(PLAYERS) do 
		if player.hero ~= nil and not player.hero:IsNull() then
			player.hero:RemoveModifierByName("modifier_woda_stunned")
			player.hero:RemoveModifierByName("modifier_wodarelax")
			player.hero:RemoveModifierByName("modifier_wodarelax_invul")
			local aegis = player.hero:AddNewModifier(player.hero, nil, "modifier_aegis_arena_pve", {})
			if aegis then
				aegis:SetStackCount(PVE_AEGIS_COUNT + player_system:GetArenaRuneBonusLife(id))
                CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "aegis_count", player_id = id, data = {aegis = PVE_AEGIS_COUNT + player_system:GetArenaRuneBonusLife(id)}})
			end
		end
	end

	if player_system.data_base_connected == false then
		CustomGameEventManager:Send_ServerToAllClients("notification_no_data_server", {server = "true"})
	elseif player_system:GetPlayerCountAll() < arena_system:GetMaxPlayersMode() then
		
	end

	Timers:CreateTimer(7, function()
		CustomGameEventManager:Send_ServerToAllClients("event_new_area_gamemode", {})
	end)

	self:StartRune()

	local time = STARTGAME_DURATION_PVE
	self:PrepareToNewArenaPve(STARTGAME_DURATION_PVE, true)
end

function arena_system:PrepareToNewArenaPve(time_full, start)
	if start == nil then
		if (PVE_CURRENT_WAVE-1) % 10 == 0 and PVE_CURRENT_WAVE > 0 then
			local tier = math.floor((PVE_CURRENT_WAVE-1) / 10)
			neutrals_reward:SpawnRandomNeutrals(tier)
			for id, player_info in pairs(PLAYERS) do
	            if player_info.hero ~= nil then
	            	WodaTalents:AddPoint(id,5)
				end
			end
			if PVE_CURRENT_WAVE >= 70 then
				for id, player_info in pairs(PLAYERS) do
	            	if player_info.hero ~= nil then
                        if not IsArenaAfk(id) then
	            		    player_info.hero:ModifyGold(GOLD_PER_BOSS_AFTER_70_WAVES, false, DOTA_ModifyGold_CreepKill)
	            		    CreateEffectGold(player_info.hero, GOLD_PER_BOSS_AFTER_70_WAVES, player_info.hero)
                        end
	            	end
	            end
			end
		end
		for id, player_info in pairs(PLAYERS) do
            if player_info.hero ~= nil then
				local modifier_pudge_innate_graft_flesh_custom = player_info.hero:FindModifierByName("modifier_pudge_innate_graft_flesh_custom")
				if modifier_pudge_innate_graft_flesh_custom then
				    modifier_pudge_innate_graft_flesh_custom:SetStackCount(modifier_pudge_innate_graft_flesh_custom:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
				local modifier_lion_finger_of_death_custom_passive = player_info.hero:FindModifierByName("modifier_lion_finger_of_death_custom_passive")
				if modifier_lion_finger_of_death_custom_passive then
				    modifier_lion_finger_of_death_custom_passive:SetStackCount(modifier_lion_finger_of_death_custom_passive:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
                local modifier_sniper_assassinate_custom_handler = player_info.hero:FindModifierByName("modifier_sniper_assassinate_custom_handler")
				if modifier_sniper_assassinate_custom_handler then
				    modifier_sniper_assassinate_custom_handler:SetStackCount(modifier_sniper_assassinate_custom_handler:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
				local modifier_vengefulspirit_magic_missile_custom_stack = player_info.hero:FindModifierByName("modifier_vengefulspirit_magic_missile_custom_stack")
				if modifier_vengefulspirit_magic_missile_custom_stack then
				    modifier_vengefulspirit_magic_missile_custom_stack:SetStackCount(modifier_vengefulspirit_magic_missile_custom_stack:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
				local modifier_slark_essence_shift_custom = player_info.hero:FindModifierByName("modifier_slark_essence_shift_custom")
				if modifier_slark_essence_shift_custom then
				    modifier_slark_essence_shift_custom:SetStackCount(modifier_slark_essence_shift_custom:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
                    local modifier_slark_3_fx = player_info.hero:FindModifierByName("modifier_slark_3_fx")
                    if modifier_slark_3_fx then
                        modifier_slark_3_fx:SetStackCount(modifier_slark_essence_shift_custom:GetStackCount())
                    end
				end
				local legion_commander_duel_custom = player_info.hero:FindAbilityByName("legion_commander_duel_custom")
				if legion_commander_duel_custom then
					if legion_commander_duel_custom:GetLevel() > 0 then
						legion_commander_duel_custom:WinArena()
					end
				end
                local modifier_zuus_thundergods_wrath_custom_handler = player_info.hero:FindModifierByName("modifier_zuus_thundergods_wrath_custom_handler")
				if modifier_zuus_thundergods_wrath_custom_handler then
				    modifier_zuus_thundergods_wrath_custom_handler:SetStackCount(modifier_zuus_thundergods_wrath_custom_handler:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end

				local modifier_axe_culling_blade_custom_handler = player_info.hero:FindModifierByName("modifier_axe_culling_blade_custom_handler")
                if modifier_axe_culling_blade_custom_handler then
                    modifier_axe_culling_blade_custom_handler:AddStackCount(1)
                end

                local modifier_rubick_curiosity_from_heroes_tracker = player_info.hero:FindModifierByName("modifier_rubick_curiosity_from_heroes_tracker")
                if modifier_rubick_curiosity_from_heroes_tracker then
                    modifier_rubick_curiosity_from_heroes_tracker:IncrementStackCount()
                elseif player_info.hero:GetUnitName() == "npc_dota_hero_rubick" then
                    local rubick_curiosity = player_info.hero:FindAbilityByName("rubick_curiosity")
                    modifier_rubick_curiosity_from_heroes_tracker = player_info.hero:AddNewModifier(player_info.hero, rubick_curiosity, "modifier_rubick_curiosity_from_heroes_tracker", {})
                    modifier_rubick_curiosity_from_heroes_tracker:IncrementStackCount()
                end
                
                local modifier_muerta_supernatural = player_info.hero:FindModifierByName("modifier_muerta_supernatural")
                if modifier_muerta_supernatural then
                    local ability_modifier_muerta_supernatural = modifier_muerta_supernatural:GetAbility()
                    if ability_modifier_muerta_supernatural and modifier_muerta_supernatural:GetStackCount() < ability_modifier_muerta_supernatural:GetSpecialValueFor("max_stacks_tooltip") then
                        modifier_muerta_supernatural:IncrementStackCount()
                    end
                end

                local modifier_dawnbreaker_3_buff = player_info.hero:FindModifierByName("modifier_dawnbreaker_3_buff")
                if modifier_dawnbreaker_3_buff then
                    player_info.hero.arena_bonus = (player_info.hero.arena_bonus or 0) + 1
                end

                local modifier_tidehunter_leviathans_catch_counter = player_info.hero:FindModifierByName("modifier_tidehunter_leviathans_catch_counter")
                if modifier_tidehunter_leviathans_catch_counter then
                    modifier_tidehunter_leviathans_catch_counter:IncrementStackCount()
                end
                local modifier_tidehunter_leviathans_catch_stacks = player_info.hero:FindModifierByName("modifier_tidehunter_leviathans_catch_stacks")
                if modifier_tidehunter_leviathans_catch_stacks then
                    modifier_tidehunter_leviathans_catch_stacks:IncrementStackCount()
                end

				local modifier_faceless_void_11_buff = player_info.hero:FindModifierByName("modifier_faceless_void_11_buff")
				if modifier_faceless_void_11_buff then
				    modifier_faceless_void_11_buff:SetStackCount(modifier_faceless_void_11_buff:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
                local modifier_visage_10_buff = player_info.hero:FindModifierByName("modifier_visage_10_buff")
				if modifier_visage_10_buff then
				    modifier_visage_10_buff:SetStackCount(modifier_visage_10_buff:GetStackCount() + 1)
				    player_info.hero:CalculateStatBonus(true)
				end
				local modifier_huskar_6_buff = player_info.hero:FindModifierByName("modifier_huskar_6_buff")
				if modifier_huskar_6_buff then
				    modifier_huskar_6_buff:SetStackCount(math.min(modifier_huskar_6_buff:GetStackCount() + 1, modifier_huskar_6_buff.bonus_max[player_info.hero:GetTalentLevel("modifier_huskar_6")]))
				    player_info.hero:CalculateStatBonus(true)
				end
			end
		end
	end

    if WAVES_PVE_MODE[PVE_CURRENT_WAVE] == nil then
        if (PVE_CURRENT_WAVE) % 10 == 0 and PVE_CURRENT_WAVE > 0 then
            WAVES_PVE_MODE[PVE_CURRENT_WAVE] = {"boss_8_pve"}
        else
            WAVES_PVE_MODE[PVE_CURRENT_WAVE] = RANDOM_FROG_WAVES[RandomInt(1, #RANDOM_FROG_WAVES)]
        end
    end

    local bonus_skills = nil

	local time = time_full+1
	local portal_spawn = true
	local portals = {}

    arena_system:GetSkillsWave(WAVES_PVE_MODE[PVE_CURRENT_WAVE])

    if PVE_CURRENT_WAVE >= 91 then

        WAVE_MULTIPLIER_FROGS = WAVE_MULTIPLIER_FROGS + 1

        local has_skills = nil
        local is_boss = nil
        local count_skills = 2

        if CREEPS_ABILITIES ~= nil then
            for old_ab_name, old_ab in pairs(CREEPS_ABILITIES) do
                has_skills = old_ab_name
                break
            end
        end

        if (PVE_CURRENT_WAVE) % 10 == 0 and PVE_CURRENT_WAVE > 0 then
            is_boss = true
            count_skills = 3
        end

        bonus_skills = AddCreepBonusSkill(count_skills, is_boss, has_skills)

        if bonus_skills ~= nil then
            for _, new_skill_wave in pairs(bonus_skills) do
                CREEPS_ABILITIES[tostring(new_skill_wave)] = true
            end
        end
    end

	Timers:CreateTimer(0, function()
		time = time-1
		CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name', { wave = PVE_CURRENT_WAVE, creep = WAVES_PVE_MODE[PVE_CURRENT_WAVE][1], skills = CREEPS_ABILITIES })
		CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name_wave', { wave = PVE_CURRENT_WAVE, creep = WAVES_PVE_MODE[PVE_CURRENT_WAVE][1], skills = CREEPS_ABILITIES })
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer', {time=time, full_time=time_full, relax=true, duel = false })
		if time - 2 <= 0 and portal_spawn then
			portal_spawn = false
			portals = self:CreatePortals()
		end
		if time <= 0 then
			self:StartNewWave(portals, bonus_skills)
			return
		end
        return 1
	end)
end

function arena_system:CreatePortals()
	local points = 
    {
        "endduelspawn1",
        "endduelspawn2",
        "endduelspawn3",
        "endduelspawn4"
    }
	local particles_portal = {}

    if PVE_CURRENT_WAVE % 10 == 0 and PVE_CURRENT_WAVE > 0 then
        local point_spawn = Entities:FindByName(nil, "endduelspawn5")
        if point_spawn then
            local particle_portal = ParticleManager:CreateParticle("particles/pve_portalopen_good.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(particle_portal, 0, GetGroundPosition(point_spawn:GetAbsOrigin(), nil))
            table.insert(particles_portal, particle_portal)
        end
    else
        for _, point_name in pairs(points) do
            local point_spawn = Entities:FindByName(nil, point_name)
            if point_spawn then
                local particle_portal = ParticleManager:CreateParticle("particles/pve_portalopen_good.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager:SetParticleControl(particle_portal, 0, GetGroundPosition(point_spawn:GetAbsOrigin(), nil))
                table.insert(particles_portal, particle_portal)
            end
        end
    end
    EmitGlobalSound("Hero_Underlord.Portal.Spawn")
    return particles_portal
end

function arena_system:StartNewWave(portals, new_skills)
    local points = 
    {
        "endduelspawn1",
        "endduelspawn2",
        "endduelspawn3",
        "endduelspawn4"
    }

    local creeps_table = {}

    Timers:CreateTimer(FrameTime(), function()
        for _, particle_delete in pairs(portals) do
            if particle_delete then
                ParticleManager:DestroyParticle(particle_delete, false)
            end
        end
        StopGlobalSound("Hero_Underlord.Portal.Spawn")
        if PVE_CURRENT_WAVE % 10 == 0 and PVE_CURRENT_WAVE > 0 then
            local point_spawn = Entities:FindByName(nil, "endduelspawn5")
            if point_spawn then
                for _, creep_name in pairs(WAVES_PVE_MODE[PVE_CURRENT_WAVE]) do
                    Timers:CreateTimer(0.1*_, function()
                        local creep = CreateUnitByName(creep_name, point_spawn:GetAbsOrigin(), true, nil, nil, 4)
                        if creep then
                        	creep:AddNewModifier(creep, nil, "modifier_invulnerable", {duration = 1})
                            creep:SetForwardVector(point_spawn:GetForwardVector())
                            creep:SetMinimumGoldBounty(0)
                            creep:SetMaximumGoldBounty(0)
                            creep:SetDeathXP(0)
                            if new_skills ~= nil then
                                for _, new_skill_name in pairs(new_skills) do
                                    local new_ab = creep:AddAbility(new_skill_name)
                                    if new_ab then
                                        new_ab:SetLevel(3)
                                    end
                                end
                            end
                            Timers:CreateTimer(FrameTime()*2, function()
                                Timers:CreateTimer(FrameTime()*2, function()
                                    self:UpgradeCreepPVELastRound(PVE_CURRENT_WAVE, creep, true)
                                    Timers:CreateTimer(FrameTime()*2, function()
                                        local modifier_multiplier = creep:AddNewModifier(creep, nil, "modifier_wodaduel_boss_multiplier", {players = player_system:GetPlayerCountAll()})
                                        if string.find(creep_name, "boss") then
                                            Timers:CreateTimer(FrameTime()*2, function()
                                                creep:AddNewModifier(creep, nil, "modifier_boss_low_health", {stages = math.floor((PVE_CURRENT_WAVE / 10)+0.5)})
                                                creep:AddNewModifier(creep, nil, "modifier_woda_boss_bar_pve", {})
                                            end)
                                        end
                                    end)
                                end)
                            end)
                            FindClearSpaceForUnit(creep, creep:GetAbsOrigin(), true)
                            table.insert(creeps_table, creep)
                        end
                    end)
                end
            end
        else
            for _, point_name in pairs(points) do
                local point_spawn = Entities:FindByName(nil, point_name)
                if point_spawn then
                    for _, creep_name in pairs(WAVES_PVE_MODE[PVE_CURRENT_WAVE]) do
                        Timers:CreateTimer(0.1*_, function()
                        	if RollPercentage(1) then 
								if RollPercentage(CHAMPION_PIG) then 
									creep_name = "npc_woda_pig_pve"
								end
							elseif RollPercentage(1) then 
								if RollPercentage(CHAMPION_FROG) then 
									creep_name = "npc_woda_frog_pve"
								end
							end
                            local creep = CreateUnitByName(creep_name, point_spawn:GetAbsOrigin(), true, nil, nil, 4)
                            if creep then
                            	creep:AddNewModifier(creep, nil, "modifier_invulnerable", {duration = 1})
                                creep:SetForwardVector(point_spawn:GetForwardVector())
                                creep:SetMinimumGoldBounty(0)
                                creep:SetMaximumGoldBounty(0)
                                creep:SetDeathXP(0)
                                if string.find(creep_name, "boss") then
                                    creep:AddNewModifier(creep, nil, "modifier_boss_low_health", {stages = math.floor((PVE_CURRENT_WAVE / 10)+0.5)})
                                end
                                if new_skills ~= nil then
                                    for _, new_skill_name in pairs(new_skills) do
                                        local new_ab = creep:AddAbility(new_skill_name)
                                        if new_ab then
                                            new_ab:SetLevel(3)
                                        end
                                    end
                                end
                                if creep_name ~= "npc_woda_pig_pve" and creep_name ~= "npc_woda_frog_pve" then
	                                Timers:CreateTimer(FrameTime()*2, function()
	                                    Timers:CreateTimer(FrameTime()*2, function()
	                                        self:UpgradeCreepPVELastRound(PVE_CURRENT_WAVE, creep, false)
	                                    end)
	                                end)
	                            end
                                if creep_name == "npc_woda_pig_pve" then 
									creep:AddNewModifier(creep, nil, "modifier_wodapig", {})
									creep.pig = true
								end
								if creep_name == "npc_woda_frog_pve" then 
									creep:AddNewModifier(creep, nil, "modifier_wodafrog", {})
									creep.frog = true
								end
								Timers:CreateTimer(0.5, function()
									if RollPercentage(CHAMPION_CREEPPERSENTAGE_RED) and creep_name ~= "npc_woda_pig_pve" and creep_name ~= "npc_woda_frog_pve" then 
										creep:AddNewModifier(creep, nil, "modifier_wodacreepchampionred", {})
										creep.champion_red = true
									elseif RollPercentage(CHAMPION_CREEPPERSENTAGE_BLUE) and creep_name ~= "npc_woda_pig_pve" and creep_name ~= "npc_woda_frog_pve" then
										creep:AddNewModifier(creep, nil, "modifier_wodacreepchampion", {})
										creep.champion_blue = true
									end
									Timers:CreateTimer(0.1, function()
										local modifier_multiplier = creep:AddNewModifier(creep, nil, "modifier_wodaduel_boss_multiplier", {players = player_system:GetPlayerCountAll()})
										creep:SetMana(creep:GetMaxMana())
									end)
								end)
                                FindClearSpaceForUnit(creep, creep:GetAbsOrigin(), true)
                                table.insert(creeps_table, creep)
                            end
                        end)
                    end
                end
            end
        end

        local round_time_max = LAST_ROUNDS_DURATION + player_system:GetArenaRuneTimeBonus()
        local round_time = round_time_max

        CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name_wave', { wave = PVE_CURRENT_WAVE, creep = WAVES_PVE_MODE[PVE_CURRENT_WAVE][1], skills = CREEPS_ABILITIES })
		CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = round_time, full_time = round_time_max })

        Timers:CreateTimer(1, function()
            for _, update_creep in pairs(creeps_table) do
                if update_creep and not update_creep:IsNull() and update_creep:IsAlive() then
                    local modifier_creature_hellbear_spawn = update_creep:FindModifierByName("modifier_creature_hellbear_spawn")
                    if modifier_creature_hellbear_spawn and not modifier_creature_hellbear_spawn.added and modifier_creature_hellbear_spawn.creep_unit ~= nil then
                        modifier_creature_hellbear_spawn.added = true
                        table.insert(creeps_table, modifier_creature_hellbear_spawn.creep_unit)
                    end
                end
            end
            if self:CheckPveSkipBoss() then
            	for _, creep_t in pairs(creeps_table) do
	                if creep_t and not creep_t:IsNull() and creep_t:IsAlive() then
	                   	creep_t:ForceKill(false)
	                end
	            end
                arena_system:CloseAndEndGamePVE()
                CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = 0, full_time = round_time_max })
                return
            end

            CustomGameEventManager:Send_ServerToAllClients( 'arena_timer_arena_name_wave', { wave = PVE_CURRENT_WAVE, creep = WAVES_PVE_MODE[PVE_CURRENT_WAVE][1], skills = CREEPS_ABILITIES})

            if round_time > 0 then
                round_time = round_time - 1
            else
                for _, creep_t in pairs(creeps_table) do
                    if creep_t and not creep_t:IsNull() and creep_t:IsAlive() then
                        creep_t:AddNewModifier(creep_t, nil, "modifier_woda_pve_creep_timeout", {})
                    end
                end
                for id, player_info in pairs(PLAYERS) do
                    if player_info.hero ~= nil and player_info.hero:IsAlive() then
                    	local hero = player_info.hero
                    	local wave = PVE_CURRENT_WAVE
                    	Timers:CreateTimer(0.1, function()
                    		if not hero:IsAlive() then return 0.1 end
                    		if wave ~= PVE_CURRENT_WAVE then return nil end
                    		hero:AddNewModifier(hero, nil, "modifier_woda_pve_creep_timeout_manacost", {})
                    	end)
                    end
                end
            end

            CustomGameEventManager:Send_ServerToAllClients( 'set_arena_timer_duel', {time = round_time, full_time = round_time_max })



            local next_round = true

            for _, creep_t in pairs(creeps_table) do
                if creep_t and not creep_t:IsNull() and creep_t:IsAlive() then
                    next_round = false
                end
            end

            if next_round then
                PVE_CURRENT_WAVE = PVE_CURRENT_WAVE + 1
                PVE_WAVES_COMPLETE = PVE_WAVES_COMPLETE + 1
                self:RespawnUnitsPVE()
                self:PrepareToNewArenaPve(DELAY_WAVES_TIME_RELAX)
                for id, player_info in pairs(player_system.PLAYERS_GLOBAL_INFORMATION) do
                    if PVE_WAVES_COMPLETE == 100 then
                        player_system:CheckAttributeQuest(id, 7, 29, 51, 73)
                    end
                    if PVE_WAVES_COMPLETE == 140 then
                        player_system:CheckAttributeQuest(id, 8, 30, 52, 74)
                    end
                end
                return
            end

            return 1
        end)
    end)
end

function arena_system:UpgradeCreepPVELastRound(wave, creep, is_boss)
	if REMOVE_CREEPS_UGPRADE_TEST then return end
    wave = wave + WAVE_MULTIPLIER_FROGS
	Timers:CreateTimer(FrameTime(), function()
		if is_boss then
			creep:AddNewModifier(creep, nil, "modifier_woda_pve_creep_upgrade_wave", {wave = wave, pve_bonus_per_wave_bonus_damage = PVE_BONUS_PER_WAVE_BONUS_DAMAGE * PVE_BONUS_PER_WAVE_BOSS_DAMAGE, pve_bonus_per_wave_bonus_damage_pct = PVE_BONUS_PER_WAVE_BONUS_DAMAGE_PCT * PVE_BONUS_PER_WAVE_BOSS_DAMAGE, pve_bonus_per_wave_armor = PVE_BONUS_PER_WAVE_ARMOR, pve_bonus_per_wave_armor_pct = PVE_BONUS_PER_WAVE_ARMOR_PCT, pve_bonus_per_wave_magical_resistance = PVE_BONUS_PER_WAVE_MAGICAL_RESISTANCE, pve_bonus_per_wave_health = PVE_BONUS_PER_WAVE_HEALTH * PVE_BONUS_PER_WAVE_BOSS_HEALTH, pve_bonus_per_wave_health_pct = PVE_BONUS_PER_WAVE_HEALTH_PCT * PVE_BONUS_PER_WAVE_BOSS_HEALTH, pve_bonus_per_wave_spell_amplify = PVE_BONUS_PER_WAVE_SPELL_AMPLIFY, pve_bonus_per_wave_attack_speed = PVE_BONUS_PER_WAVE_ATTACK_SPEED, pve_bonus_per_wave_move_speed = PVE_BONUS_PER_WAVE_MOVE_SPEED, pve_bonus_per_wave_global_damage = PVE_BONUS_PER_WAVE_GLOBAL_DAMAGE, pve_bonus_per_wave_status_resistance = PVE_BONUS_PER_WAVE_STATUS_RESISTANCE})
		else
			creep:AddNewModifier(creep, nil, "modifier_woda_pve_creep_upgrade_wave", {wave = wave, pve_bonus_per_wave_bonus_damage = PVE_BONUS_PER_WAVE_BONUS_DAMAGE, pve_bonus_per_wave_bonus_damage_pct = PVE_BONUS_PER_WAVE_BONUS_DAMAGE_PCT, pve_bonus_per_wave_armor = PVE_BONUS_PER_WAVE_ARMOR, pve_bonus_per_wave_armor_pct = PVE_BONUS_PER_WAVE_ARMOR_PCT, pve_bonus_per_wave_magical_resistance = PVE_BONUS_PER_WAVE_MAGICAL_RESISTANCE, pve_bonus_per_wave_health = PVE_BONUS_PER_WAVE_HEALTH, pve_bonus_per_wave_health_pct = PVE_BONUS_PER_WAVE_HEALTH_PCT, pve_bonus_per_wave_spell_amplify = PVE_BONUS_PER_WAVE_SPELL_AMPLIFY, pve_bonus_per_wave_attack_speed = PVE_BONUS_PER_WAVE_ATTACK_SPEED, pve_bonus_per_wave_move_speed = PVE_BONUS_PER_WAVE_MOVE_SPEED, pve_bonus_per_wave_global_damage = PVE_BONUS_PER_WAVE_GLOBAL_DAMAGE, pve_bonus_per_wave_status_resistance = PVE_BONUS_PER_WAVE_STATUS_RESISTANCE})
		end
	end)
end

function arena_system:RespawnUnitsPVE()
    for id, player_info in pairs(PLAYERS) do
        if player_info.hero ~= nil and not player_system:IsLose(id) then
        	local unrespawn = false
        	if not player_info.hero:IsAlive() then
        		unrespawn = true
        	end
            player_info.hero:SetRespawnsDisabled(false)
            player_info.hero:ResetHealthAndMana()
            player_info.hero:RemoveModifierByName("modifier_woda_pve_creep_timeout_manacost")
            player_info.hero:RemoveModifierByName("modifier_woda_pve_creep_timeout_armor_debuff")
            player_info.hero:ResetCooldown(true)
            local men = player_info.hero
            Timers:CreateTimer({ endTime = 0.5, callback = function()
            	if unrespawn then
                	player_info.hero:SetCamera(men)
                	player_info.hero:SetUnit(men)
                end
                player_info.hero:EmitSound("DOTA_Item.Refresher.Activate")
				local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher.vpcf", PATTACH_ABSORIGIN_FOLLOW, player_info.hero)
    			ParticleManager:SetParticleControlEnt(particle, 0, player_info.hero, PATTACH_POINT_FOLLOW, "attach_hitloc", player_info.hero:GetAbsOrigin(), true)
                if arena_system:GetAegisCount(player_info.hero) <= 0 then
                	player_info.hero:SetRespawnsDisabled(true)
                end
            end})
        end
    end
end

function arena_system:EnrageClear()
	local units = FindUnitsInRadius(2, Vector(0,0,0), nil, -1, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)
	for _, unit in pairs(units) do
		if unit and unit:HasModifier("modifier_woda_pve_creep_timeout") then
			unit:AddNewModifier(unit, nil, "modifier_woda_pve_creep_timeout_cooldown", {duration = 20})
		end
	end
	for id, player_info in pairs(PLAYERS) do
        if player_info.hero ~= nil and not player_system:IsLose(id) then
        	player_info.hero:RemoveModifierByName("modifier_woda_pve_creep_timeout_armor_debuff")
        	local modifier_woda_pve_creep_timeout_manacost = player_info.hero:FindModifierByName("modifier_woda_pve_creep_timeout_manacost")
        	if modifier_woda_pve_creep_timeout_manacost then
        		modifier_woda_pve_creep_timeout_manacost:SetStackCount(0)
        	end
        end
    end
end

function arena_system:CheckPveSkipBoss()
    for id, player_info in pairs(PLAYERS) do
        if player_info.hero ~= nil and (player_info.hero:IsAlive() or player_info.hero:IsReincarnating() or self:GetAegisCount(player_info.hero) > 0) then
            return false
        end
    end
    return true
end

function arena_system:GetAegisCount(hero)
	local aegis = hero:FindModifierByName("modifier_aegis_arena_pve")
	if aegis then
		return aegis:GetStackCount()
	end
	return 0
end

function arena_system:GetPveWavesComplete()
    return PVE_WAVES_COMPLETE
end

function arena_system:CloseAndEndGamePVE()
    if arena_system.IS_GAME_END then return end
    arena_system.IS_GAME_END = true
    for id, info in pairs(PLAYERS) do
        local player_items = {}
        if info.hero ~= nil then
            for i = 0, 18 do
                local item = info.hero:GetItemInSlot(i)
                local name = ""
                if item then
                    name = item:GetName()
                end
                player_items[i] = name
            end
        end
        CustomGameEventManager:Send_ServerToAllClients("event_update_scoreboard_data", {table_name = "end_game_items", player_id = id, data = player_items})
    end
    damage_system:EndGameUpdate()
    Timers:CreateTimer({ endTime = 0.25, callback = function()
        player_system:SendQuestToServer()
        player_system:SendDataToServerPVE()
		player_system:SendDataPlayersHeroStats()
    end})
    Timers:CreateTimer({ endTime = 0.5, callback = function()
        GameRules:SetGameWinner(2)
    end})
end

function arena_system:GetSkillsWave(wave)
    local abilities = {}
    for _, creep in pairs(wave) do
        if units_txt[creep] then
            for ab = 1, 10 do
                if units_txt[creep]["Ability" ..ab] ~= nil and  units_txt[creep]["Ability"..ab] ~= "" and units_txt[creep]["Ability"..ab] ~= "generic_hidden" and units_txt[creep]["Ability"..ab] ~= "creature_hellbear_color" then
                    abilities[tostring(units_txt[creep]["Ability" ..ab])] = true
                end
            end
        end
    end
    CREEPS_ABILITIES = abilities
end