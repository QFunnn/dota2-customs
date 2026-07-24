--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebPlayerStats = WebPlayerStats or {}


function WebPlayerStats:Init()
	EventStream:Listen("WebPlayerStats:get_map_stats", WebPlayerStats.GetMapStatsEvent, WebPlayerStats)
	EventStream:Listen("WebPlayerStats:get_match_data", WebPlayerStats.GetMatchDataEvent, WebPlayerStats)

	WebPlayerStats.__fetched_map_stats = {}
	WebPlayerStats.__fetched_match_data = {}
end


function WebPlayerStats:GetStats(player_id)
	return WebPlayer.players_data[player_id].stats
end


function WebPlayerStats:SendMapStats(player_id, map_name, stats)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local stats = WebPlayerStats.__fetched_map_stats[player_id][map_name]
	stats.map_name = map_name

	CustomGameEventManager:Send_ServerToPlayer(player, "WebPlayerStats:map_stats_fetched", stats)
end


function WebPlayerStats:GetMapStatsEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local map_name = event.map_name
	if not map_name then return end

	local already_fetched = (WebPlayerStats.__fetched_map_stats[player_id] or {})[map_name]
	if already_fetched then
		WebPlayerStats:SendMapStats(player_id, map_name, already_fetched)
		return
	end

	WebApi:Send(
		"api/player/get_map_stats_with_recent_matches",
		{
			steam_id = tostring(PlayerResource:GetSteamID(player_id)),
			target_map_name = map_name
		},
		function(responce)
			if not responce.matches or not responce.stats then return end

			WebPlayerStats.__fetched_map_stats[player_id] = WebPlayerStats.__fetched_map_stats[player_id] or {}
			WebPlayerStats.__fetched_map_stats[player_id][map_name] = responce

			WebPlayerStats:SendMapStats(player_id, map_name, responce.matches, responce.stats)
			print("[WebPlayerStats] Fetched map stats", player_id)
			DeepPrintTable(responce)
		end,
		function(error)
			print("FAILED TO MAP STATS FOR", player_id)
		end
	)
end


function WebPlayerStats:SendMatchData(player_id, match_id, match_data)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebPlayerStats:match_data_fetched", {
		match = match_data,
		match_id = match_id,
	})
end


function WebPlayerStats:GetMatchDataEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local match_id = event.match_id
	if not match_id then return end

	local already_fetched = WebPlayerStats.__fetched_match_data[match_id]
	if already_fetched then
		WebPlayerStats:SendMatchData(player_id, match_id, already_fetched)
		return
	end

	WebApi:Send(
		"api/lua/match/get_stats",
		{
			target_match_id = match_id
		},
		function(responce)
			if not responce.match then return end

			WebPlayerStats.__fetched_match_data[match_id] = responce.match

			WebPlayerStats:SendMatchData(player_id, match_id, responce.match)
			print("[WebPlayerStats] Fetched match data", player_id)
			DeepPrintTable(responce.match)
		end,
		function(error)
			print("FAILED TO FETCH MATCH DATA", match_id)
		end
	)
end


WebPlayerStats:Init()