--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:OnGameRulesStateChange()
    xpcall(function()
        local state = GameRulesCustom:State_Get()
        -- logger:Log("Current game state = ", state)
        -- logger:Log("Current GameTime = ", GameRulesCustom:GetGameTime())

        if state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
            logger:Log("OnCustomGameSetup started.")
            self:OnCustomGameSetup()
            logger:Log("OnCustomGameSetup ended.")
        elseif state == DOTA_GAMERULES_STATE_HERO_SELECTION then
            logger:Log("OnHeroSelection started.")
            self:OnHeroSelection()
            logger:Log("OnHeroSelection ended.")
        elseif state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
            logger:Log("OnStrategyTime started.")
            self:OnStrategyTime()
            logger:Log("OnStrategyTime ended.")
        elseif state == DOTA_GAMERULES_STATE_PRE_GAME then
            logger:Log("OnPreGame started.")
            self:OnPreGame()
            logger:Log("OnPreGame ended.")
        elseif state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
            logger:Log("OnGameInProgress started.")
            self:OnGameInProgress()
            logger:Log("OnGameInProgress ended.")
        elseif state == DOTA_GAMERULES_STATE_DISCONNECT then
            logger:Log("OnGameRulesStateChange: DISCONNECT state reached")
            if HeartbeatService:IsStarted() then
                HeartbeatService:Send()
            end
        end
    end, function(err)
        logger:LogError("[OnGameRulesStateChange] " .. err)
    end)
end

function GameMode:OnCustomGameSetup()
    self.validPlayerCount = 0
    local playerUids = {}

    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        local isValid = PlayerResource:IsValidPlayer(playerID)
        local connState = PlayerResource:GetConnectionState(playerID)
        local isFake = PlayerResource:IsFakeClient(playerID)
        if isValid and connState == DOTA_CONNECTION_STATE_CONNECTED then
            local uid = PlayerResource:GetSteamAccountID(playerID)
            table.insert(playerUids, tostring(uid))
            self.validPlayerCount = self.validPlayerCount + 1
            HeroSelectionService:GenerateHeroSelection(playerID)
        end
    end
    if self.validPlayerCount > 1 then
        if not DevUtils:Check() then
            logger:Log("STarting match test")
            MatchOutboundApi:StartMatch(self:GetMatchID(),{
                playerUids = playerUids,
                matchTypeCode = self:GetMatchType()
            }, function()
                HeartbeatService:Start()
                MatchCommandService:Init()
            end)
        end
    end
end

function GameMode:OnHeroSelection()
    GameRulesCustom:GetGameModeEntity():SetPauseEnabled(false)
    Pass:InitPlayersData()
    self:SetTeamColors()
    self:AssignPlayersToTeams()
    self:StartHeroSelectionTimers()
end

function GameMode:OnStrategyTime()
    HeroSelectionService:InternalSelectHeroForPlayersIfNotLockedIn()
    self:StartStrategyTimer()
    SendToServerConsole("sv_alltalk 1")
    SendToServerConsole("sv_alltalk 0")
end

function GameMode:OnPreGame()
    GameRulesCustom:GetGameModeEntity():SetAnnouncerDisabled(false)
    self:SpawnNeutralUnits()
end

function GameMode:OnGameInProgress()
    self:ValidateTeams()
    self:StartGameRounds()
    self:MonitorConnections()
end