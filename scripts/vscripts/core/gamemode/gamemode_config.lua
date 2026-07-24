--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MAX_ABILITY_INDEX = 19
DOTA_ITEM_NEUTRAL_SLOT = 16
BAN_PHASE_TIME = 45
SELECT_PHASE_TIME = 30
STRATEGY_PHASE_TIME = 10
GAMESETUP_PHASE_TIME = 10

if IsInToolsMode() then
    BAN_PHASE_TIME = 15
    SELECT_PHASE_TIME = 10
    STRATEGY_PHASE_TIME = 10
    GAMESETUP_PHASE_TIME = 5
end

SELECT_PHASE_TIME_REMAIN = SELECT_PHASE_TIME
BAN_PHASE_TIME_REMAIN = BAN_PHASE_TIME
STRATEGY_PHASE_TIME_REMAIN = STRATEGY_PHASE_TIME

if GameMode:GetMatchType() == MATCH_TYPE_DUO then
    CHC_MAX_PLAYER_COUNT = 12
else
    CHC_MAX_PLAYER_COUNT = 8
end

CHC_HERO_LOAD_COUNT = CHC_MAX_PLAYER_COUNT * 7

function GameMode:ConfigureGameRules()
    local gmEntity = GameRulesCustom:GetGameModeEntity()
    LimitPathingSearchDepth(0.1)

    GameRulesCustom:SetSameHeroSelectionEnabled(true)
    GameRulesCustom:SetHeroSelectionTime(BAN_PHASE_TIME + SELECT_PHASE_TIME + 1)
    GameRulesCustom:SetHeroSelectPenaltyTime(0)
    GameRulesCustom:SetShowcaseTime(0)
    GameRulesCustom:SetStrategyTime(STRATEGY_PHASE_TIME)
    GameRulesCustom:SetSafeToLeave(true)
    GameRulesCustom:SetPreGameTime(10)
    GameRulesCustom:SetStartingGold(600)
    GameRulesCustom:SetHeroRespawnEnabled(false)
    GameRulesCustom:SetUseUniversalShopMode(true)
    GameRulesCustom:SetCustomGameSetupAutoLaunchDelay(300)
    GameRulesCustom:EnableCustomGameSetupAutoLaunch(true)
    GameRulesCustom:LockCustomGameSetupTeamAssignment(false)

    gmEntity:SetUseCustomHeroLevels(true)
    gmEntity:SetCustomHeroMaxLevel(999)
    gmEntity:SetFixedRespawnTime(99990000)
    gmEntity:SetFogOfWarDisabled(true)

    self:SetTeam()
    self:ReadRoundConfigurations()

    if GameRulesCustom:IsCheatMode() then
        SendToServerConsole("sv_cheats 1")
    end

    SendToServerConsole("tv_delay 0")
    SendToServerConsole("dota_max_physical_items_purchase_limit 9999")
end

function GameMode:ConfigureXPTable()
    local xpTable = {}
    xpTable[0] = 0
    local xpValues = {
        230,
        600,
        1080,
        1660,
        2260,
        2980,
        3730,
        4510,
        5320,
        6160,
        7030,
        7930,
        9155,
        10405,
        11680,
        12980,
        14305,
        15805,
        17395,
        18995,
        20845,
        22945,
        25295,
        27895
    }

    for i = 1, #xpValues do
        xpTable[i] = xpValues[i]
    end
    for level = 25, 1000 do
        xpTable[level] = xpTable[level - 1] + (level - 24) * 1000 + 2500
    end

    GameRulesCustom.xpTable = xpTable ---@type table<integer, integer>
    GameRulesCustom:GetGameModeEntity():SetCustomXPRequiredToReachNextLevel(xpTable)
end