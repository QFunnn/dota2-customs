--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "settings"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__New
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["25"] = 16,
		["26"] = 17,
		["27"] = 18,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 22,
		["32"] = 23,
		["33"] = 24,
		["35"] = 26,
		["37"] = 28,
		["38"] = 34,
		["39"] = 35,
		["40"] = 36,
		["41"] = 37,
		["42"] = 38,
		["43"] = 39,
		["44"] = 40,
		["46"] = 43,
		["47"] = 44,
		["48"] = 45,
		["49"] = 47,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 51,
		["54"] = 52,
		["55"] = 53,
		["56"] = 54,
		["57"] = 55,
		["58"] = 56,
		["59"] = 57,
		["60"] = 58,
		["61"] = 59,
		["62"] = 60,
		["63"] = 61,
		["64"] = 62,
		["65"] = 63,
		["66"] = 64,
		["67"] = 65,
		["68"] = 66,
		["69"] = 67,
		["70"] = 68,
		["71"] = 69,
		["72"] = 70,
		["73"] = 71,
		["74"] = 72,
		["75"] = 73,
		["76"] = 74,
		["77"] = 75,
		["78"] = 76,
		["79"] = 78,
		["80"] = 79,
		["81"] = 80,
		["82"] = 81,
		["83"] = 82,
		["84"] = 83,
		["85"] = 84,
		["86"] = 85,
		["87"] = 86,
		["88"] = 87,
		["89"] = 88,
		["90"] = 89,
		["91"] = 90,
		["92"] = 91,
		["93"] = 103,
		["94"] = 104,
		["95"] = 105,
		["96"] = 106,
		["97"] = 107,
		["98"] = 108,
		["99"] = 109,
		["101"] = 111,
		["104"] = 114,
		["105"] = 115,
		["106"] = 116,
		["107"] = 117,
		["108"] = 118,
		["109"] = 119,
		["111"] = 121,
		["114"] = 124,
		["115"] = 126,
		["116"] = 126,
		["117"] = 126,
		["118"] = 126,
		["119"] = 126,
		["120"] = 126,
		["121"] = 126,
		["122"] = 126,
		["123"] = 126,
		["124"] = 126,
		["125"] = 126,
		["126"] = 126,
		["127"] = 126,
		["128"] = 136,
		["129"] = 137,
		["131"] = 5,
		["132"] = 3,
		["133"] = 145,
		["134"] = 146,
	}
)
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "CSettings"
d(k, CModule)
function k.prototype.init(self, l)
	if IsServer() then
		local m = GameRules:GetGameModeEntity()
		m:SetInnateMeleeDamageBlockAmount(0)
		m:SetInnateMeleeDamageBlockPerLevelAmount(0)
		m:SetInnateMeleeDamageBlockPercent(0)
		m:SetFogOfWarDisabled(true)
		m:SetUnseenFogOfWarEnabled(false)
		GameRules:SetHeroRespawnEnabled(false)
		GameRules:SetSafeToLeave(true)
		m:SetFixedRespawnTime(8)
		GameRules:SetCustomGameAllowBattleMusic(false)
		GameRules:SetCustomGameAllowHeroPickMusic(false)
		GameRules:SetCustomGameAllowMusicAtGameStart(true)
		if IsGroupMode(nil) then
			GameRules:SetCustomGameTeamMaxPlayers(PLAYER_TEAM, 0)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, 2)
		else
			GameRules:SetCustomGameTeamMaxPlayers(PLAYER_TEAM, MAX_PLAYERS)
		end
		GameRules:SetCustomGameTeamMaxPlayers(ENEMY_TEAM, 0)
		if IsCompetitionMode(nil) then
			GameRules:SetCustomGameTeamMaxPlayers(SPECTATOR_TEAM, MAX_SPECTATORS)
			GameRules:SetCustomGameTeamMaxPlayers(PLAYER_TEAM, MAX_PLAYERS)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_2, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_3, 2)
			GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_4, 2)
		end
		GameRules:SetFirstBloodActive(false)
		GameRules:SetGoldPerTick(0)
		GameRules:SetGoldTickTime(99999)
		m:SetCustomGameForceHero("npc_dota_hero_custom_courier")
		GameRules:SetHeroSelectionTime(99999)
		GameRules:SetHeroSelectPenaltyTime(0)
		GameRules:SetHideKillMessageHeaders(true)
		GameRules:SetPostGameTime(3000)
		GameRules:SetPreGameTime(PRE_GAME_TIME)
		GameRules:SetSameHeroSelectionEnabled(true)
		GameRules:SetShowcaseTime(0)
		GameRules:SetStartingGold(IsTurboMode(nil) and PLAYER_START_GOLD_TURBO or PLAYER_START_GOLD)
		GameRules:SetStrategyTime(0)
		GameRules:SetTimeOfDay(0.26)
		GameRules:SetUseBaseGoldBountyOnHeroes(false)
		GameRules:SetUseCustomHeroXPValues(true)
		m:DisableHudFlip(true)
		m:SetAlwaysShowPlayerNames(false)
		m:SetAnnouncerDisabled(true)
		m:SetCameraZRange(0, 90000)
		m:SetCustomBackpackCooldownPercent(1)
		m:SetCustomBackpackSwapCooldown(0)
		m:SetCustomBuybackCooldownEnabled(true)
		m:SetCustomBuybackCostEnabled(true)
		m:SetBuybackEnabled(false)
		m:SetUseCustomHeroLevels(true)
		m:SetCustomHeroMaxLevel(HERO_MAX_LEVEL)
		m:SetCustomXPRequiredToReachNextLevel(HERO_XP_PER_LEVEL_TABLE)
		m:SetDaynightCycleDisabled(true)
		m:SetDeathOverlayDisabled(true)
		m:SetGoldSoundDisabled(false)
		m:SetSendToStashEnabled(false)
		m:SetCanSellAnywhere(true)
		m:SetHudCombatEventsDisabled(true)
		m:SetKillingSpreeAnnouncerDisabled(true)
		m:SetLoseGoldOnDeath(false)
		m:SetMaximumAttackSpeed(MAXIMUM_ATTACK_SPEED)
		m:SetMinimumAttackSpeed(MINIMUM_ATTACK_SPEED)
		m:SetPauseEnabled(false)
		m:SetRecommendedItemsDisabled(true)
		m:SetSelectionGoldPenaltyEnabled(false)
		m:SetStashPurchasingDisabled(true)
		m:SetStickyItemDisabled(true)
		m:SetTPScrollSlotItemOverride("item_back")
		m:SetGiveFreeTPOnDeath(false)
		m:SetWeatherEffectsDisabled(true)
		m:SetForcedHUDSkin("default")
		m:SetGoldSoundDisabled(true)
		if IsInToolsMode() then
			GameRules:SetCustomGameSetupAutoLaunchDelay(3)
			GameRules:LockCustomGameSetupTeamAssignment(false)
			GameRules:EnableCustomGameSetupAutoLaunch(true)
			if IsCompetitionMode(nil) or IsGroupMode(nil) then
				GameRules:SetCustomGameSetupAutoLaunchDelay(30)
			else
				GameRules:SetCustomGameSetupAutoLaunchDelay(10)
			end
		else
			GameRules:SetCustomGameSetupAutoLaunchDelay(3)
			GameRules:LockCustomGameSetupTeamAssignment(false)
			GameRules:EnableCustomGameSetupAutoLaunch(true)
			m:SetBuybackEnabled(false)
			if IsCompetitionMode(nil) or IsGroupMode(nil) then
				GameRules:SetCustomGameSetupAutoLaunchDelay(30)
			else
				GameRules:SetCustomGameSetupAutoLaunchDelay(0)
			end
		end
		GameRules:SetUseUniversalShopMode(true)
		CustomNetTables:SetTableValue(
			"common",
			"settings",
			{
				is_local_host = not IsDedicatedServer(),
				is_in_tools_mode = IsInToolsMode(),
				is_cheat_mode = GameRules:IsCheatMode(),
				HERO_MAX_LEVEL = HERO_MAX_LEVEL,
				HERO_XP_PER_LEVEL_TABLE = HERO_XP_PER_LEVEL_TABLE,
				MAX_DIFFICULTY = MAX_DIFFICULTY,
				SECT_ABILITY_LEVEL = SECT_ABILITY_LEVEL,
			}
		)
		SendToServerConsole("dota_max_physical_items_purchase_limit 99999")
		Convars:SetBool("dota_all_vision", true)
	end
end
k = e({ j }, k)
if _G.Settings == nil then
	_G.Settings = f(k)
end
return h