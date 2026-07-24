--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


HeartbeatService = HeartbeatService or {} ---@class HeartbeatService

local HEARTBEAT_INTERVAL = 45

function HeartbeatService:Send()
    local connectedPlayers = 0
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidPlayer(playerID) and
           PlayerResource:GetConnectionState(playerID) == DOTA_CONNECTION_STATE_CONNECTED then
            connectedPlayers = connectedPlayers + 1
        end
    end

    MatchOutboundApi:Heartbeat(GameMode:GetMatchID(), {
        connectedPlayers = connectedPlayers,
        logs = logger:GetAndClear()
    }, nil)
end

function HeartbeatService:Start()
    if self.started then
        return
    end
    self.started = true

    self:Send()

    -- useGameTime=false: хартбит идёт по реальному времени. Иначе на паузе GetGameTime
    -- замирает, healthcheck не уходит и бэкенд считает матч мёртвым.
    Timers:CreateTimer({
        useGameTime = false,
        endTime = HEARTBEAT_INTERVAL,
        callback = function()
            local state = GameRulesCustom:State_Get()
            if state == DOTA_GAMERULES_STATE_POST_GAME or state == DOTA_GAMERULES_STATE_DISCONNECT then
                return nil
            end

            self:Send()
            return HEARTBEAT_INTERVAL
        end
    })
end

function HeartbeatService:IsStarted()
    return self.started == true
end