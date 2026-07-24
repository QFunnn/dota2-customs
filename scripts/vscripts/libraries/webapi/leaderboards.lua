--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebLeaderboards = WebLeaderboards or {}


function WebLeaderboards:Init()
	EventStream:Listen("WebLeaderboards:get_leaderboard", WebLeaderboards.SendLeaderboard, WebLeaderboards)

	WebLeaderboards.fetched_leaderboards = {}
	WebLeaderboards.fetched_ratings = {}
end


--- Returns rating of a player on a given map
--- Useful when you need to access rating of other maps
--- However, doesn't fetch them by itself, other maps ratings are fetched as a part of other maps leaderboards
--- Relying on this method is not recommended
---@param player_id number
---@param map_name string
---@return number
function WebLeaderboards:GetRatingForPlayerOnMap(player_id, map_name)
	-- current map rating is accessible from player interface
	if map_name == GetMapName() then return WebPlayer:GetRating(player_id) end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	if WebLeaderboards.fetched_ratings and WebLeaderboards.fetched_ratings[map_name] then
		return WebLeaderboards.fetched_ratings[map_name][steam_id] or 1500
	end

	return 1500
end


function WebLeaderboards:SendLeaderboard(event)
	if not event.map_name then return end

	local map_name = event.map_name

	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	if WebLeaderboards.fetched_leaderboards[map_name] then
		print("[WebLeaderboards] using already fetched leaderboard for map", map_name)
		CustomGameEventManager:Send_ServerToPlayer(player, "WebLeaderboards:set_leaderboard", {
			leaderboard = WebLeaderboards.fetched_leaderboards[map_name],
			requester_rating = WebLeaderboards:GetRatingForPlayerOnMap(player_id, map_name),
			map_name = map_name
		})
		return
	end

	WebApi:Send(
		"api/lua/match/get_leaderboard",
		{
			target_map_name = map_name,
			players = WebApi:GetPlayersSteamIDs() or {}
		},
		function(response)
			print("[WebLeaderboards] successfully fetched leaderboard for map", map_name)
			DeepPrintTable(response)

			WebLeaderboards.fetched_leaderboards[map_name] = response.leaderboard or {}
			WebLeaderboards.fetched_ratings[map_name] = response.players_rating or {}

			CustomGameEventManager:Send_ServerToPlayer(player, "WebLeaderboards:set_leaderboard", {
				leaderboard = WebLeaderboards.fetched_leaderboards[map_name],
				requester_rating = WebLeaderboards:GetRatingForPlayerOnMap(player_id, map_name),
				map_name = map_name
			})
		end,
		function(error)
			print("[WebLeaderboards] failed to fetch leaderboard for map", map_name)
		end
	)
end


WebLeaderboards:Init()