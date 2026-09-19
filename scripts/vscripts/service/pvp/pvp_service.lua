--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class PvpService
if PvpService == nil then
	PvpService = class({})
end

require("service.pvp.pvp_record_book")
require("service.pvp.pvp_matchmaker")
require("service.pvp.bet_service")
require("service.pvp.pvp_compensate")
require("service.pvp.pvp_end")
require("service.pvp.pvp_prepare")
require("service.pvp.pvp_punish_loser")
require("service.pvp.pvp_utils")
require("service.pvp.pvp_winner_effects")
require("service.pvp.pvp_winner_sounds")

function PvpService:Init()
	self.CurrentSinglePvpPair = {}
	self.AllPvpPairLog = {}
	self.ReportActorTime = {} ---@type table<integer, integer>

	self.MuteMap = {} ---@type table<integer, table<integer, boolean>>
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		self.ReportActorTime[playerId] = 0
		self.MuteMap[playerId] = {}
	end

	PvpRecordBook:Reset()
	PvpMatchmaker:Reset()
	BetService:Reset()

	GameListener:SubscribeProtected("ConfirmBet", function(event)
		BetService:ConfirmBet(event)
	end)
	GameListener:SubscribeProtected("set_mute_player", function(event)
		self:ToggleMute(event)
	end)

	ListenToGameEvent("entity_killed", self.OnEntityKilled, self)
end

---Активная дуэль текущего раунда (или nil вне раунда).
---@return Pvp?
function PvpService:GetDuel()
	local round = GameMode:GetMatch():GetCurrentRound()
	return round and round:GetPvp()
end

---@return boolean
function PvpService:IsDuelEnded()
	local duel = self:GetDuel()
	return duel == nil or duel:IsEnded()
end

---@return DOTATeam_t[]
function PvpService:GetPair()
	local duel = self:GetDuel()
	return duel and duel:GetPair() or {}
end

---@return boolean
function PvpService:HasActivePair()
	local duel = self:GetDuel()
	return duel ~= nil and duel:HasActivePair()
end

---@return integer?
function PvpService:GetHomeTeamId()
	local duel = self:GetDuel()
	return duel and duel:GetHomeTeamId()
end

---@return Vector?
function PvpService:GetHomeCenter()
	local duel = self:GetDuel()
	return duel and duel:GetHomeCenter()
end

function PvpService:ResetPair()
	local duel = self:GetDuel()
	if duel then
		duel:ResetPair()
	end
end

---@param killedTeamId integer
function PvpService:ResolvePvpDeath(killedTeamId)
	local duel = self:GetDuel()
	if not duel then
		return
	end
	local outcome = duel:ResolveDeath(killedTeamId, GameMode:GetMatchType() == MATCH_TYPE_SOLO)
	if outcome then
		self:EndPvp(outcome.winner, outcome.loser)
	end
end

---@param event OnEnitityKilledEvent
function PvpService:OnEntityKilled(event)
	logger:Log("OnEntityKilled test123")
	xpcall(function()
		local killedUnit = nil
		local killer = nil
		local killerPlayerId = -1

		if event.entindex_attacker ~= nil then
			killer = EntIndexToHScript(event.entindex_attacker)
		end

		if event.entindex_killed ~= nil then
			killedUnit = EntIndexToHScript(event.entindex_killed)
		end

		if IsValid(killer) then ---@cast killer CDOTA_BaseNPC_Hero
			if killer.GetPlayerOwnerID ~= nil then
				killerPlayerId = killer:GetPlayerOwnerID()
			end
		end
		if not IsValid(killedUnit) then
			return
		end
		---@cast killedUnit CDOTA_BaseNPC_Hero
		if ReincarnationService:IsReincarnationWork(killedUnit) then
			return
		end
		local currentRound = GameMode:GetMatch():GetCurrentRound()
		if currentRound and currentRound:GetTimeLimit() == nil then
			return
		end
		if
			not killedUnit:IsRealHero()
			or killedUnit:IsTempestDouble()
			or killedUnit ~= PlayerResource:GetSelectedHeroEntity(killedUnit:GetPlayerOwnerID())
		then
			return
		end

		local killedPlayerId = killedUnit:GetPlayerOwnerID()
		local killedTeamId = PlayerResource:GetTeam(killedPlayerId)

		logger:Log(
			string.format(
				"OnEntityKilled called. KillerUnitName = %s, killedUnitName = %s (teamId = %d)",
				IsValid(killer) and killer:GetUnitName() or "<none>",
				killedUnit:GetUnitName(),
				killedTeamId
			)
		)

		self:ResolvePvpDeath(killedTeamId)

		local killedByEnemyPlayer = killerPlayerId ~= -1 and killerPlayerId ~= killedPlayerId
		local killedByCreep = IsValid(killer) and killer ~= killedUnit and killerPlayerId == -1

		if killedByEnemyPlayer then
			CustomGameEventManager:Send_ServerToAllClients("PlayerLosePvP", {
				player_id2 = killedPlayerId,
				message = "KillNotify",
				player_id = killerPlayerId,
			})
			return nil
		end

		if killedByCreep and not killedUnit:IsReincarnating() then
			CustomGameEventManager:Send_ServerToAllClients("PlayerLosePvE", {
				string_killer_creature = killer:GetUnitName(),
				message = "PvELoseNotify",
				player_id = killedPlayerId,
			})
		end
	end, function(e)
		logger:LogError(e)
	end)
end