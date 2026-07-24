--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if BaseGameMode == nil then
	_G.BaseGameMode = class({})
end

-- Encryption bootstrap
require("tools/aeslua/aeslua")
require("utils/encryption")

-- Utils
require("utils/timers")
require("utils/table")
require("utils/server_functions")
require("utils/custom_tables")
Precache = require("utils/precache")

-- Config
require("config/stages")
require("config/infinity_mode")
require("config/difficulty")
require("config/creeps_data")
require("config/elite_creeps")
require("config/heroes_data")
require("config/cards_list")
require("config/challengers")
require("config/abyss_trials")
require("config/passive_artefacts_list")
require("config/ultimate_list")
require("config/boss_abilities_list")
require("config/assistants")
require("config/services/item_database")
require("config/services/services_data")
require("config/aghanim_bosses")
require("config/boss_ui_data")
require("config/afk_mode")
require("config/neutral_items_data")

-- Server
require("server/server")
require("server/debug_panel")

-- Libs
require("libs/health_system")
require("libs/summon_aura_system")
require("libs/custom_twin_gate")
require("libs/game_events")
require("libs/game_filters")
require("libs/player_data")
require("libs/infinity_mode_stats")
require("libs/tutorial_system")
require("libs/panorama_events")
require("libs/wave_manager")
require("libs/afk_mode_system")
require("libs/card_system")
require("libs/hero_card_system")
require("libs/level_upgrades")
require("libs/passive_artefacts_system")
require("libs/challenger_spawn_system")
require("libs/elite_spawn_system")
require("libs/abyss_trial_system")
require("libs/boss_ability_system")
require("libs/neutral_ai_system")
require("libs/neutral_camp_system")
require("libs/neutral_roshan_system")
require("libs/match_result_system")
require("libs/post_stage_activity_system")
require("libs/boss_rush_activity")
require("libs/assistant_manager")
require("libs/game_stats")
require("libs/black_store")
require("libs/services/service_core")
require("libs/neutral_items_system")
require("abilities/modifier_set_bruiser")
require("abilities/modifier_set_ghost")

local LEVEL_UP_CUSTOM_XP_TABLE = {
    0,
    297,
    796,
    1446,
    2201,
    3062,
    4027,
    5050,
    6205,
    7492,
    9326,
    11360,
    13671,
    16276,
    19191,
    22433,
    26017,
    29959,
    34273,
    38976,
    43869,
    49175,
    55024,
    61436,
    68433,
    76852,
    87255,
    99737,
    114388,
    130696,
    146847,
    163695,
    181252,
    199524,
    218519,
    238246,
    258712,
    279924,
    301891,
    324618,
    347379,
    370828,
    394970,
    419809,
    445350,
    471596,
    498552,
    526221,
    554607,
    583713,
}

function Activate()
    SendToServerConsole("dota_clientside_wearables false")
	BaseGameMode:InitGameMode()
    SendToServerConsole("tv_delay 0")
end

function BaseGameMode:InitGameMode()
    GameRules:SetTimeOfDay(0.5)
    GameRules:SetStrategyTime(0)
    GameRules:SetShowcaseTime(0)
    GameRules:SetHeroSelectionTime(0)
    GameRules:SetStartingGold(0)
    GameRules:SetPreGameTime(0)
    GameRules:SetCustomGameSetupAutoLaunchDelay(-1)
	GameRules:SetCustomGameSetupTimeout(-1)
    -- Dev-only: если 1, игра стартует даже когда данные игрока не загрузились с веб-сервера
    -- (для локальной разработки без запущенного веб-сервера). По умолчанию 0 - блокируем старт.
    if Convars and Convars.RegisterConvar then
        Convars:RegisterConvar("dota_levelup_setup_ignore_errors", "0",
            "Allow the game to start even if a player's web-server data failed to load (dev only)", 0)
    end
    GameRules:GetGameModeEntity():SetForcedHUDSkin( "reborn" )
    GameRules:GetGameModeEntity():SetCustomGameForceHero("npc_dota_hero_sniper")

    GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
    GameRules:GetGameModeEntity():SetFriendlyBuildingMoveToEnabled(true)
	GameRules:GetGameModeEntity():SetSelectionGoldPenaltyEnabled(false)
	GameRules:GetGameModeEntity():SetInnateMeleeDamageBlockPerLevelAmount(0)
	GameRules:GetGameModeEntity():SetSendToStashEnabled(false)
    GameRules:GetGameModeEntity():SetDeathTipsDisabled(true)
    GameRules:GetGameModeEntity():SetDaynightCycleDisabled(true)
    GameRules:GetGameModeEntity():SetHudCombatEventsDisabled(true)
    GameRules:SetHeroRespawnEnabled(true)
    GameRules:GetGameModeEntity():SetFixedRespawnTime(5)
    GameRules:GetGameModeEntity():SetBuybackEnabled(false)
    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    GameRules:GetGameModeEntity():SetCustomHeroMaxLevel(50)
    GameRules:GetGameModeEntity():SetUseCustomHeroLevels(true)
    GameRules:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(LEVEL_UP_CUSTOM_XP_TABLE)

    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_DAMAGE, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_STRENGTH_HP_REGEN, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_DAMAGE, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ARMOR, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ATTACK_SPEED, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_DAMAGE, 0)
    GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA, 0)
	GameRules:GetGameModeEntity():SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA_REGEN, 0)

    GameRules:SetCustomGameAllowMusicAtGameStart(false)
    GameRules:SetCustomGameAllowHeroPickMusic(false)
    GameRules:SetCustomGameAllowBattleMusic(false)
    GameRules:GetGameModeEntity():SetAnnouncerGameModeAnnounceDisabled(true)
    GameRules:GetGameModeEntity():SetKillingSpreeAnnouncerDisabled(true)
    GameRules:GetGameModeEntity():SetAnnouncerDisabled(true)

    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_BADGUYS , 0)
    GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_GOODGUYS, 4)

    GameRules:GetGameModeEntity():SetWeatherEffectsDisabled(true)
    GameRules:GetGameModeEntity():SetDeathOverlayDisabled(true)
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
    GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled(false)

    GameRules:SetCreepMinimapIconScale(0.5)
    GameRules:SetHeroMinimapIconScale(0.5)

    SendToServerConsole("dota_max_physical_items_purchase_limit 9999")
    GameRules:SetCreepSpawningEnabled(false)
    LimitPathingSearchDepth(0.1)

    BaseGameMode:InitEvents()
    BaseGameMode:InitFilters()
    player_data:Init()
    challenger_spawn_system:Init()
    elite_spawn_system:Init()
    abyss_trial_system:Init()
    neutral_ai_system:Init()
    neutral_camp_system:Init()
    neutral_roshan_system:Init()
    match_result_system:Init()
    post_stage_activity_system:Init()
    afk_mode_system:Init()
    summon_aura_system:Init()
    AssistantManager:Init()
    DebugPanel:Init()
    BaseGameMode:InitPanoramaEvents()
    
    if neutral_items_system then
        neutral_items_system:Init()
    end
end