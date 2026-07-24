--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if GamePauseManager == nil then
    GamePauseManager = class({}) ---@class GamePauseManager
end

local MAX_PAUSES_PER_PLAYER = 2
local OWNER_EXCLUSIVE_SECONDS = 60

function GamePauseManager:Init()
    self.started = true

    ---@type table<PlayerID, number>
    self.pauseCountByPlayer = {}
    self.pauseOwnerId = -1
    self.pauseStartRealTime = 0

    GameListener:SubscribeProtected("toggle_game_pause", function(event)
        self:OnTogglePauseRequest(event)
    end)
end

---@param event { PlayerID: PlayerID }
function GamePauseManager:OnTogglePauseRequest(event)
    local playerId = event.PlayerID

    local gameState = GameRulesCustom:State_Get()
    if gameState < DOTA_GAMERULES_STATE_PRE_GAME or gameState >= DOTA_GAMERULES_STATE_POST_GAME then
        return
    end

    if PlayerResource:GetTeam(playerId) == DOTA_TEAM_NOTEAM then
        return
    end

    if GameRulesCustom:IsGamePaused() then
        self:TryUnpause(playerId)
    else
        self:TryPause(playerId)
    end
end

---@param playerId PlayerID
function GamePauseManager:TryPause(playerId)
    local usedPauses = self.pauseCountByPlayer[playerId] or 0
    if usedPauses >= MAX_PAUSES_PER_PLAYER then
        return
    end

    self.pauseCountByPlayer[playerId] = usedPauses + 1
    self.pauseOwnerId = playerId
    self.pauseStartRealTime = Time()

    PauseGame(true)
end

---@param playerId PlayerID
function GamePauseManager:TryUnpause(playerId)
    local ownerWindowRemaining = self:GetOwnerWindowRemaining()
    local isOwner = playerId == self.pauseOwnerId
    if not isOwner and ownerWindowRemaining > 0 then
        self:SendUnpauseDenied(playerId, ownerWindowRemaining)
        return
    end

    self:Unpause()
end

---@return number seconds
function GamePauseManager:GetOwnerWindowRemaining()
    local elapsed = Time() - self.pauseStartRealTime
    return math.max(0, math.ceil(OWNER_EXCLUSIVE_SECONDS - elapsed))
end

---@param playerId PlayerID
---@param remainingSeconds number
function GamePauseManager:SendUnpauseDenied(playerId, remainingSeconds)
    local player = PlayerResource:GetPlayer(playerId)
    if player == nil then
        return
    end

    CustomGameEventManager:Send_ServerToPlayer(player, "pause_unpause_denied", {
        remainingSeconds = remainingSeconds
    })
end

function GamePauseManager:Unpause()
    if not GameRulesCustom:IsGamePaused() then
        return
    end

    PauseGame(false)

    self.pauseOwnerId = -1
    self.pauseStartRealTime = 0
end

if not GamePauseManager.started then GamePauseManager:Init() end