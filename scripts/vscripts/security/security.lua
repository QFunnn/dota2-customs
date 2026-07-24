--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Security == nil then Security = class({}) end ---@class Security

function Security:Init()
    self.securityKeys = {} ---@type table<integer, string>
    self.securityKeyConfirmed = {} ---@type table<integer, boolean>
    self.securityKeySenders = {} ---@type table<integer, boolean>

    GameListener:SubscribeProtected("security_key_confirmed", function(event)
        self:SecurityKeyConfirmed(event)
    end)

    if IsInToolsMode() then
        CustomGameEventManager:RegisterListener("request_security_key_reissue", function(_, event)
            local playerId = event and event.PlayerID
            if type(playerId) ~= "number" or not PlayerResource:IsValidPlayer(playerId) then
                return
            end
            self:ReissueSecurityKey(playerId)
        end)
    end

    self:GenerateSecurityKeys()
end

---@param playerId PlayerID
function Security:ReissueSecurityKey(playerId)
    self.securityKeyConfirmed[playerId] = false
    self.securityKeySenders[playerId] = nil
    CustomNetTables:SetTableValue("security", tostring(playerId), {
        confirmed = false
    })
    self:StartSendingSecurityKeyToPlayer(playerId)
end

---@param playerId PlayerID
---@return string|nil
function Security:GetSecurityKey(playerId)
    return self.securityKeys[playerId]
end

function Security:GenerateSecurityKeys()
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        local key = self:CreateSecurityKey()
        self:UpdateSecurityPlayerKey(playerId, key)
    end
end

---@param playerId PlayerID
---@param newSecKey string
function Security:UpdateSecurityPlayerKey(playerId, newSecKey)
    self.securityKeys[playerId] = newSecKey
    self.securityKeyConfirmed[playerId] = false
end

---@return string
function Security:CreateSecurityKey()
    local key

    if IsInToolsMode() then
        key = tostring(CreateSecretKey())
    else
        key = GetDedicatedServerKeyV2(tostring(CreateSecretKey()))
    end

    return key
end

function Security:SecurityKeyConfirmed(event)
    local playerId = event.PlayerID
    local expectedSecurityKey = self:GetSecurityKey(playerId)

    if expectedSecurityKey ~= nil and expectedSecurityKey == event.security_key then
        self.securityKeyConfirmed[playerId] = true

        CustomNetTables:SetTableValue("security", tostring(playerId), {
            confirmed = true
        })
    else
        CustomNetTables:SetTableValue("security", tostring(playerId), {
            confirmed = false
        })
    end
end

---@param playerId PlayerID
function Security:StartSendingSecurityKeyToPlayer(playerId)
    if self.securityKeySenders[playerId] then
        return
    end

    self.securityKeySenders[playerId] = true
    self.securityKeyConfirmed[playerId] = false

    Timers.CreateTimer(0, function()
        if self.securityKeyConfirmed[playerId] then
            self.securityKeySenders[playerId] = nil
            return nil
        end

        local player = PlayerResource:GetPlayer(playerId)
        if not player then
            return 0.5
        end

        local securityKey = self.securityKeys[playerId]
        if securityKey == nil then
            return 0.5
        end

        CustomGameEventManager:Send_ServerToPlayer(player, "set_security_key", {
            security_key = securityKey,
        })

        return 0.5
    end)
end

---@param playerId PlayerID
---@param securityKey string
---@return boolean
function Security:IsSecurityPlayerKeyValid(playerId, securityKey)
    return self.securityKeys[playerId] ~= nil and self.securityKeys[playerId] == securityKey
end