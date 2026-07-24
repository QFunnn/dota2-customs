--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


EarlyConsumables = EarlyConsumables or {}

EXTRA_SCORE_VOTE_TYPE = {
	DEFAULT = 1,
	TOKEN = 2
}

function EarlyConsumables:Init()
	self.extra_score_voted_players = {}
	self.double_mmr_tokens = {}
	self.early_consumables_closed_ui = {}

	EventStream:Listen("early_consumables:get_state", function(event) EarlyConsumables:SendEarlyConsumablesState(event.PlayerID) end)
	EventStream:Listen("early_consumables:vote_additional_kl_goal", function(event) EarlyConsumables:PlayerVoteAdditionalGoal(event.PlayerID) end)
	EventStream:Listen("early_consumables:close_ui", function(event) EarlyConsumables:CloseEarlyConsumablesMenu(event.PlayerID) end)
end

function EarlyConsumables:RegisterScoreVoteForPlayer(player_id, type)
	self.extra_score_voted_players[player_id] = type
end

function EarlyConsumables:HavePlayerUsedDoubleMMRToken(player_id)
	return self.double_mmr_tokens[player_id] ~= nil
end

function EarlyConsumables:IsPlayerVotedForExtraGoal(player_id)
	return self.extra_score_voted_players[player_id] ~= nil
end

function EarlyConsumables:SendEarlyConsumablesState(player_id)
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end
	if GameRules:GetDOTATime(false, false) >= GAME_DURATION_OPTIONAL_EARLY_CONSUMABLES_TIME then return end
	if self.early_consumables_closed_ui[player_id] then return end


	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(player_id), "early_consumables:update_state", {
		player_vote_kl = self.extra_score_voted_players[player_id] or 0,
		is_player_used_double_mmr = EarlyConsumables:HavePlayerUsedDoubleMMRToken(player_id),
		time_limit = GAME_DURATION_OPTIONAL_EARLY_CONSUMABLES_TIME,
	})
end

function EarlyConsumables:PlayerVoteAdditionalGoal(player_id)
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	if GameRules:GetDOTATime(false, false) < GAME_DURATION_OPTIONAL_EARLY_CONSUMABLES_TIME then
		if EarlyConsumables:IsPlayerVotedForExtraGoal(player_id) then return end

		GameLoop:IncreaseScoreByVote(player_id)
		EarlyConsumables:SendEarlyConsumablesState(player_id)
	end
end

function EarlyConsumables:UseDoubleMMRToken(player_id)
	self.double_mmr_tokens[player_id] = true
end

function EarlyConsumables:CloseEarlyConsumablesMenu(player_id)
	self.early_consumables_closed_ui[player_id] = true
end

EarlyConsumables:Init()