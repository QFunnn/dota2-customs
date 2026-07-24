--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local originalSendServerToPlayer = CustomGameEventManager.Send_ServerToPlayer
local originalSendServerToAllClients = CustomGameEventManager.Send_ServerToAllClients
local originalSendServerToTeam = CustomGameEventManager.Send_ServerToTeam

local function CopyTableShallow(source)
    local result = {}

    if source == nil then
        return result
    end

    for k, v in pairs(source) do
        result[k] = v
    end

    return result
end

local function BuildSecuredPayloadForPlayer(playerId, eventData)
    local payload = CopyTableShallow(eventData)
    local securityKey = Security:GetSecurityKey(playerId)

    if securityKey ~= nil then
        payload.security_key = securityKey
    end

    return payload
end

local function SendServerToPlayerSecured(self, player, eventName, eventData)
    if player == nil then
        return
    end

    local playerId = player:GetPlayerID()
    if playerId == nil or playerId < 0 then
        return
    end

    local payload = BuildSecuredPayloadForPlayer(playerId, eventData)
    return originalSendServerToPlayer(self, player, eventName, payload)
end

CustomGameEventManager.Send_ServerToPlayer = function(self, player, eventName, eventData)
    return SendServerToPlayerSecured(self, player, eventName, eventData)
end

CustomGameEventManager.Send_ServerToAllClients = function(self, eventName, eventData)
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if not PlayerResource:IsValidPlayer(playerId) then
            goto continue
        end

        local player = PlayerResource:GetPlayer(playerId)
        if player == nil then
            goto continue
        end

        SendServerToPlayerSecured(self, player, eventName, eventData)

        ::continue::
    end
end

CustomGameEventManager.Send_ServerToTeam = function(self, team, eventName, eventData)
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if not PlayerResource:IsValidPlayer(playerId) then
            goto continue
        end

        if PlayerResource:GetTeam(playerId) ~= team then
            goto continue
        end

        local player = PlayerResource:GetPlayer(playerId)
        if player == nil then
            goto continue
        end

        SendServerToPlayerSecured(self, player, eventName, eventData)

        ::continue::
    end
end