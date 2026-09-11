--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
function ____exports.EvaluateMatchRoster(self, players, resource_count, tools)
	local participants = __TS__ArrayFilter(players, function(____, player)
		return player.participant and (tools or not player.fake)
	end)
	local ids = __TS__ArrayMap(participants, function(____, player)
		return player.player_id
	end)
	local distinct = {}
	local duplicate = false
	for ____, player in ipairs(participants) do
		if player.steam_account_id > 0 then
			if distinct[player.steam_account_id] then
				duplicate = true
			end
			distinct[player.steam_account_id] = true
		end
	end
	local unresolved = #players < resource_count
		or __TS__ArraySome(players, function(____, player)
			return player.unassigned and (tools or not player.fake)
		end)
	local invalid_count = not tools
		and (
			duplicate
			or #participants > 10
			or resource_count > 0 and resource_count < 10
			or __TS__ArraySome(participants, function(____, player)
				return player.unavailable
			end)
			or not unresolved and resource_count > 0 and #participants ~= 10
		)
	local waiting = resource_count == 0
		or unresolved
		or __TS__ArraySome(participants, function(____, player)
			return not player.ready or not tools and player.steam_account_id <= 0
		end)
	local readyAccounts = {}
	local actual_players = 0
	for ____, player in ipairs(participants) do
		if player.ready and (tools or player.steam_account_id > 0 and not readyAccounts[player.steam_account_id]) then
			actual_players = actual_players + 1
			readyAccounts[player.steam_account_id] = true
		end
	end
	return { player_ids = ids, waiting = waiting, invalid_count = invalid_count, actual_players = actual_players }
end
return ____exports