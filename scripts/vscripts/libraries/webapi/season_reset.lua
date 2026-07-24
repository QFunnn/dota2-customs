--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SeasonReset = SeasonReset or {}


function SeasonReset:Init()
	SeasonReset.player_reset_rewards = {}
	SeasonReset.current_season = 1

	EventStream:Listen("SeasonReset:get_status", SeasonReset.SendStatus, SeasonReset)
end


function SeasonReset:SetResetRewards(player_id, status)
	SeasonReset.player_reset_rewards[player_id] = status
end


function SeasonReset:SetSeasonDetails(season, next_season_timestamp)
	SeasonReset.current_season = season
	SeasonReset.next_season_timestamp = next_season_timestamp
end


function SeasonReset:SendStatus(event)
	print("[SeasonReset] status requested")
	local player_id = event.PlayerID
	if not player_id or not IsValidPlayerID(player_id) then print(1) return end

	local player = PlayerResource:GetPlayer(player_id)
	if not player or player:IsNull() then print(2) return end

	CustomGameEventManager:Send_ServerToPlayer(player, "SeasonReset:set_status", {
		player_reset_rewards = SeasonReset.player_reset_rewards[player_id] or {},
		season = SeasonReset.current_season,
		new_rating = WebPlayer:GetRating(player_id),
		next_season_timestamp = SeasonReset.next_season_timestamp or 0
	})
end


SeasonReset:Init()