--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if GamePauseManager == nil then
	GamePauseManager = class({}) ---@class GamePauseManager
end

local MAX_PAUSES_PER_PLAYER = 2
if IsInToolsMode() then
	MAX_PAUSES_PER_PLAYER = 100
end
local OWNER_EXCLUSIVE_SECONDS = 60
local TOGGLE_DEBOUNCE_SECONDS = 0.75

function GamePauseManager:Init()
	self.started = true

	---@type table<PlayerID, number>
	self.pauseCountByPlayer = {}
	self.pauseOwnerId = -1
	self.pauseStartRealTime = 0
	self.countdownTimer = nil
	---@type table<PlayerID, number>
	self.lastToggleRealTime = {}

	GameListener:SubscribeProtected("toggle_game_pause", function(event)
		self:OnTogglePauseRequest(event)
	end)
end

---@param event { PlayerID: PlayerID }
function GamePauseManager:OnTogglePauseRequest(event)
	local playerId = event.PlayerID

	local gameState = GameRulesCustom:State_Get()
	if gameState < DOTA_GAMERULES_STATE_PRE_GAME or gameState >= DOTA_GAMERULES_STATE_POST_GAME then
		self:SendPauseNotAllowed(playerId)
		return
	end

	if PlayerResource:GetTeam(playerId) == DOTA_TEAM_NOTEAM then
		self:SendPauseNotAllowed(playerId)
		return
	end

	local now = Time()
	if now - (self.lastToggleRealTime[playerId] or 0) < TOGGLE_DEBOUNCE_SECONDS then
		return
	end
	self.lastToggleRealTime[playerId] = now

	-- по своему состоянию, не IsGamePaused(): лаг постановки паузы → двойной расход
	if self.pauseOwnerId ~= -1 or GameRulesCustom:IsGamePaused() then
		self:TryUnpause(playerId)
	else
		self:TryPause(playerId)
	end
end

---@param playerId PlayerID
function GamePauseManager:SendPauseNotAllowed(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	if player == nil then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "pause_not_allowed", {})
end

---@param playerId PlayerID
function GamePauseManager:TryPause(playerId)
	if self.pauseOwnerId ~= -1 or GameRulesCustom:IsGamePaused() then
		return
	end

	local usedPauses = self.pauseCountByPlayer[playerId] or 0
	if usedPauses >= MAX_PAUSES_PER_PLAYER and not Pass:HasStreamerPlus(playerId) then
		self:SendPauseLimitReached(playerId)
		return
	end

	self.pauseCountByPlayer[playerId] = usedPauses + 1
	self.pauseOwnerId = playerId
	self.pauseStartRealTime = Time()

	PauseGame(true)

	CustomGameEventManager:Send_ServerToAllClients("pause_started", {
		ownerId = playerId,
		windowSeconds = OWNER_EXCLUSIVE_SECONDS,
	})

	self:StartCountdownBroadcast()
end

function GamePauseManager:StartCountdownBroadcast()
	self:StopCountdownBroadcast()

	self.countdownTimer = Timers:CreateTimer({
		useGameTime = false,
		endTime = 0,
		callback = function()
			if self.pauseOwnerId == -1 then
				return nil
			end

			local remaining = self:GetOwnerWindowRemaining()
			CustomGameEventManager:Send_ServerToAllClients("pause_countdown", {
				remainingSeconds = remaining,
			})

			if remaining <= 0 then
				return nil
			end
			return 1.0
		end,
	})
end

function GamePauseManager:StopCountdownBroadcast()
	if self.countdownTimer ~= nil then
		Timers:RemoveTimer(self.countdownTimer)
		self.countdownTimer = nil
	end
end

---@param playerId PlayerID
function GamePauseManager:SendPauseLimitReached(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	if player == nil then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "pause_limit_reached", {
		maxPauses = MAX_PAUSES_PER_PLAYER,
	})
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
		remainingSeconds = remainingSeconds,
	})
end

function GamePauseManager:Unpause()
	if not GameRulesCustom:IsGamePaused() then
		return
	end

	PauseGame(false)

	self.pauseOwnerId = -1
	self.pauseStartRealTime = 0

	self:StopCountdownBroadcast()

	CustomGameEventManager:Send_ServerToAllClients("pause_ended", {})
end

if not GamePauseManager.started then
	GamePauseManager:Init()
end