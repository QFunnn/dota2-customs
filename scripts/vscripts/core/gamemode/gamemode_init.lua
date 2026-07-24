--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:InitGlobals()
    self.teamPlayerMap = self.teamPlayerMap or {} ---@type table<integer, table<integer, integer>>
    self.aliveTeamMap = self.aliveTeamMap or {} ---@type table<integer, boolean>
    self.teamLocationMap = self.teamLocationMap or {} ---@type table<integer, Vector>
    self.teamAbandonMap = {}
    self.teamStartLocationMap = self.teamStartLocationMap or {} ---@type table<integer, Vector>
    self.playerCountBookMap = self.playerCountBookMap or {} ---@type table<PlayerID, table<string, int>>

    if IsInToolsMode() then
        self.MatchID = RandomInt(1, 999999999)
    else
        self.MatchID = GameRulesCustom:Script_GetMatchID()
    end
end

function GameMode:InitSystems()
    Security:Init()
    HeroBuilder:Init()
    Debugger:Init()
    PvpModule:Init()
    Pass:Init()
    Illusion:Init()
    ExtraCreature:Init()
    WereableSystem:Init()
    DataManager:Init()
    ExtenderStash:Init()
    DebugTool:Init()
end

function GameMode:SetupAutoLaunchTimer()
    Timers:CreateTimer(0.5, function()
        if GameRulesCustom:State_Get() > DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
            return nil
        end

        if GameRulesCustom:GetStateTransitionTime() - GameRulesCustom:GetGameTime() > 10 then
            GameRulesCustom:SetCustomGameSetupRemainingTime(GAMESETUP_PHASE_TIME)
        end

        return 0.5
    end)
end

--- Устанавливает цвета для всех команд и игроков.
function GameMode:SetTeamColors()
    local colors = {
        [DOTA_TEAM_GOODGUYS] = { 61, 210, 150 },
        [DOTA_TEAM_BADGUYS] = { 243, 201, 9 },
        [DOTA_TEAM_CUSTOM_1] = { 197, 77, 168 },
        [DOTA_TEAM_CUSTOM_2] = { 255, 108, 0 },
        [DOTA_TEAM_CUSTOM_3] = { 52, 85, 255 },
        [DOTA_TEAM_CUSTOM_4] = { 101, 212, 19 },
        [DOTA_TEAM_CUSTOM_5] = { 129, 83, 54 },
        [DOTA_TEAM_CUSTOM_6] = { 27, 192, 216 },
        [DOTA_TEAM_CUSTOM_7] = { 199, 228, 13 },
        [DOTA_TEAM_CUSTOM_8] = { 140, 42, 244 }
    }

    for playerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
        local team = PlayerResource:GetTeam(playerID)
        local color = colors[team]
        if color then
            SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
            PlayerResource:SetCustomPlayerColor(playerID, color[1], color[2], color[3])
        end
    end
end

--- Распределяет игроков по командам и подготавливает PvP-таблицы.
function GameMode:AssignPlayersToTeams()
    for playerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
        local team = PlayerResource:GetTeam(playerID)
        local isValid = PlayerResource:IsValidPlayer(playerID)
        local isFake = PlayerResource:IsFakeClient(playerID)
        local connState = PlayerResource:GetConnectionState(playerID)
        self.teamPlayerMap[team] = self.teamPlayerMap[team] or {}
        table.insert(self.teamPlayerMap[team], playerID)

        if not self.aliveTeamMap[team] then
            self.aliveTeamMap[team] = true
            self.place = self.place + 1
            self.validTeamNumber = self.validTeamNumber + 1

            CustomNetTables:SetTableValue("team_rank", tostring(team), {
                rank = 0,
                defeat_round = 0
            })
        end

        CustomNetTables:SetTableValue("pvp_record", tostring(playerID), {
            win = 0,
            lose = 0,
            total_bet_reward = 0
        })
    end

    GameRulesCustom:GetGameModeEntity():SetAnnouncerDisabled(true)
end

--- Запускает таймеры фаз банов и выбора героев.
function GameMode:StartHeroSelectionTimers()
    Timers:CreateTimer(0, function()
        if GameRulesCustom:State_Get() > DOTA_GAMERULES_STATE_HERO_SELECTION then
            return nil
        end
        local phase, time = 1, BAN_PHASE_TIME_REMAIN

        if BAN_PHASE_TIME_REMAIN >= 0 then
            if time == BAN_PHASE_TIME then
                EmitAnnouncerSound("announcer_announcer_ban_yr")
            end
            if time == 10 then
                EmitAnnouncerSound("announcer_announcer_count_pick_10")
            end
            if time == 5 then
                EmitAnnouncerSound("announcer_announcer_count_pick_5")
            end

            CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime", {
                time = time,
                phase = 1
            })
            BAN_PHASE_TIME_REMAIN = BAN_PHASE_TIME_REMAIN - 1
        elseif SELECT_PHASE_TIME_REMAIN >= 0 then
            local phase = 2
            local time = SELECT_PHASE_TIME_REMAIN
            if time == SELECT_PHASE_TIME then
                EmitAnnouncerSound("announcer_announcer_choose_hero")
            end
            if time == 10 then
                EmitAnnouncerSound("announcer_announcer_count_pick_10")
            end
            if time == 5 then
                EmitAnnouncerSound("announcer_announcer_count_pick_5")
            end

            CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime", {
                time = time,
                phase = phase
            })
            SELECT_PHASE_TIME_REMAIN = SELECT_PHASE_TIME_REMAIN - 1
        else
            CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime", {
                time = -1,
                phase = 0
            })
        end

        if SELECT_PHASE_TIME_REMAIN < 0 then
            return nil
        else
            return 1
        end
    end)
end

--- Таймер для отсчёта стадии стратегии.
function GameMode:StartStrategyTimer()
    Timers:CreateTimer(0, function()
        if GameRulesCustom:State_Get() > DOTA_GAMERULES_STATE_STRATEGY_TIME then
            return nil
        end
        if STRATEGY_PHASE_TIME_REMAIN >= 0 then
            CustomGameEventManager:Send_ServerToAllClients("UpdatePhaseTime", {
                time = STRATEGY_PHASE_TIME_REMAIN,
                phase = 3
            })
            STRATEGY_PHASE_TIME_REMAIN = STRATEGY_PHASE_TIME_REMAIN - 1
        end
        return STRATEGY_PHASE_TIME_REMAIN >= 0 and 1 or nil
    end)
end