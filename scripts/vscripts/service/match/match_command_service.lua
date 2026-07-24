--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MatchCommandService = MatchCommandService or {} ---@class MatchCommandService

local handlers = {}

---@param eventType string
---@param payload any
---@param initiatorName string?
local function Dispatch(eventType, payload, initiatorName)
    local handler = handlers[eventType]
    if not handler then
        logger:Logf("Dispatch: неизвестный тип команды '%s'", tostring(eventType))
        return
    end

    local ok, err = xpcall(function()
        handler(payload, initiatorName)
    end, function(e)
        return e
    end)

    if not ok then
        logger:LogError(string.format("Dispatch: ошибка при обработке '%s': %s", tostring(eventType), tostring(err)))
    end
end

function MatchCommandService:Register(eventType, fn)
    handlers[eventType] = fn
end

function MatchCommandService:Init()
    if self.started then
        return
    end
    local matchId = tostring(GameMode:GetMatchID())
    self.started = true

    Timers:CreateTimer(0, function()
        local state = GameRulesCustom:State_Get()
        if state == DOTA_GAMERULES_STATE_POST_GAME or state == DOTA_GAMERULES_STATE_DISCONNECT then
            return nil
        end
        if state ~= DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
            return 10
        end

        MatchOutboundApi:GetMatchCommand(matchId, function(res)
            if not res or not res.Body or res.Body == "" then
                return
            end

            local ok, body = pcall(json.decode, res.Body)
            if not ok or not body or not body.type or body.type == "" then
                return
            end

            Dispatch(body.type, body.payload, body.initiatorName)
        end)

        return 10
    end)
end

function MatchCommandService:Notify(initiatorName, text)
    GameRules:SendCustomMessage(string.format("<font color='#b81c1c'>[%s]</font>: %s", tostring(initiatorName or "ADMIN"), tostring(text)), 0, 0)
end

require("service.match.handlers.message")
require("service.match.handlers.kill_player")