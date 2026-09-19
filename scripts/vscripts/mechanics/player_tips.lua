--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if PlayerTips == nil then
	PlayerTips = class({}) ---@class PlayerTips
end

---@alias PlayerID integer

local TIP_COST = 50
local TIP_COOLDOWN_SECONDS = 15

function PlayerTips:Init()
	self.cooldowns = self.cooldowns or {} ---@type table<PlayerID, number>

	GameListener:SubscribeProtected("player_tip_request", function(event)
		self:OnTipRequest(event)
	end)
end

---@param playerId PlayerID
---@param message string
---@param cooldownRemaining number|nil
function PlayerTips:SendDenied(playerId, message, cooldownRemaining)
	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "player_tip_denied", {
		message = message,
		cooldown_remaining = cooldownRemaining or 0,
	})
end

---@param event {PlayerID: PlayerID, target_player_id: PlayerID}
function PlayerTips:OnTipRequest(event)
	local tipperPlayerId = tonumber(event.PlayerID)
	local targetPlayerId = tonumber(event.target_player_id)

	if tipperPlayerId == nil or targetPlayerId == nil then
		return
	end

	tipperPlayerId = math.floor(tipperPlayerId)
	targetPlayerId = math.floor(targetPlayerId)

	if
		tipperPlayerId == targetPlayerId
		or not PlayerResource:IsValidPlayer(tipperPlayerId)
		or not PlayerResource:IsValidPlayer(targetPlayerId)
	then
		return
	end

	local now = GameRulesCustom:GetGameTime()
	local cooldownEnd = self.cooldowns[tipperPlayerId] or 0
	if cooldownEnd > now then
		self:SendDenied(tipperPlayerId, "dota_hud_error_tip_cooldown", math.ceil(cooldownEnd - now))
		return
	end

	if not Shop or not Shop.SpendCoins or not Shop:SpendCoins(tipperPlayerId, TIP_COST) then
		self:SendDenied(tipperPlayerId, "dota_hud_error_not_enough_coins", 0)
		return
	end

	self.cooldowns[tipperPlayerId] = now + TIP_COOLDOWN_SECONDS

	CustomGameEventManager:Send_ServerToAllClients("player_tip_toast", {
		tipper_player_id = tipperPlayerId,
		target_player_id = targetPlayerId,
		cost = TIP_COST,
	})
end