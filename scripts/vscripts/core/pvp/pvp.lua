--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if PvpModule == nil then
    PvpModule = class({}) ---@class PvpModule
end

require("core.pvp.pvp_bet")
require("core.pvp.pvp_bot_bet")
require("core.pvp.pvp_compensate")
require("core.pvp.pvp_end")
require("core.pvp.pvp_get_pair")
require("core.pvp.pvp_prepare")
require("core.pvp.pvp_punish_loser")
require("core.pvp.pvp_record")
require("core.pvp.pvp_utils")
require("core.pvp.pvp_winner_effects")
require("core.pvp.pvp_winner_sounds")

function PvpModule:Init()
    self.IsPvpEnd = true
    self.IsPvpBetClose = true
    self.PvpPairs = {} ---@type table<integer, PvpPair>
    self.PvpRoundInterval = 1
    self.currentPvpPair = {} ---@type DOTATeam_t[]
    self.CurrentSinglePvpPair = {}
    self.LastPvpRoundNumber = 1

    if IsInToolsMode() then
        self.LastPvpRoundNumber = 0
    end
    self.TotalBetSum = {}
    self.BetHistory = {} ---@type table<integer, Bet>
    self.betMap = {} ---@type table<integer, table<any, any>>
    self.BaseBetBonus = 150 ---@type integer
    self.AllPvpPairLog = {}
    self.ReportActorTime = {} ---@type table<integer, integer>

    self.PvpRecord = {} ---@type table<integer, {bet_history: Bet, total_bet_reward: integer, win: integer, lose: integer}>
    self.MuteMap = {} ---@type table<integer, table<integer, boolean>>
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.TotalBetSum[playerId] = 0
        self.ReportActorTime[playerId] = 0
        self.MuteMap[playerId] = {}
        self.PvpRecord[playerId] = {
            bet_history = {},
            total_bet_reward = 0,
            win = 0,
            lose = 0,
        }
    end

    GameListener:SubscribeProtected("ConfirmBet", function(event) self:ConfirmBet(event) end)
    GameListener:SubscribeProtected("set_mute_player", function(event) self:ToggleMute(event) end)

    ListenToGameEvent("entity_killed", self.OnEntityKilled, self)
end

---Развязывает PvP-дуэль по факту смерти игрока команды killedTeamId:
---в SOLO проигрывает добитая команда, в командных режимах — когда вся команда мертва.
---@param killedTeamId integer
function PvpModule:ResolvePvpDeath(killedTeamId)
    if GameMode:GetMatchType() == MATCH_TYPE_SOLO then
        if self.currentPvpPair and self.currentPvpPair[1] and self.currentPvpPair[2] then
            if killedTeamId == self.currentPvpPair[1] then
                self:EndPvp(self.currentPvpPair[2], self.currentPvpPair[1])
            elseif killedTeamId == self.currentPvpPair[2] then
                self:EndPvp(self.currentPvpPair[1], self.currentPvpPair[2])
            end
        end
    else
        for i, teamId in ipairs(self.currentPvpPair) do
            if killedTeamId == teamId and self:IsTeamAllDead(teamId) then
                self:EndPvp(self.currentPvpPair[3 - i], killedTeamId)
            end
        end
    end
end

---@param event OnEnitityKilledEvent
function PvpModule:OnEntityKilled(event)
    logger:Log("OnEntityKilled test123")
    xpcall(
        function()
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
            if Util:IsReincarnationWork(killedUnit) then
                return
            end
            if GameMode.currentRound and GameMode.currentRound.roundTimeLimit == nil then
                return
            end
            if not killedUnit:IsRealHero() or killedUnit:IsTempestDouble() or killedUnit ~= PlayerResource:GetSelectedHeroEntity(killedUnit:GetPlayerOwnerID()) then
                return
            end

            local killedPlayerId = killedUnit:GetPlayerOwnerID()
            local killedTeamId = PlayerResource:GetTeam(killedPlayerId)

            logger:Log(string.format(
                "OnEntityKilled called. KillerUnitName = %s, killedUnitName = %s (teamId = %d)",
                IsValid(killer) and killer:GetUnitName() or "<none>",
                killedUnit:GetUnitName(),
                killedTeamId
            ))

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
        end,
        function(e)
            logger:LogError(e)
        end)
end