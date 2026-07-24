--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Shuffle = Shuffle or {}

function Shuffle:DoTeamShuffle()
	-- find all parties and spread them into teams first
	-- then fill the gaps with solo players

	if GetMapName() == "ot3_demo" then
		return
	end

	local current_team_rosters = {}

	for i = 1, #GameLoop.current_layout.teamlist do
		current_team_rosters[i] = {}
	end

	local max_team_capacity = GameLoop.current_layout.player_count

	local parties = {}
	local solo_players = {}

	local max_total_players = max_team_capacity * #GameLoop.current_layout.teamlist

	for player_id = 0, max_total_players - 1 do
		if IsValidPlayerID(player_id) then
			local party_id = tonumber(tostring(PlayerResource:GetPartyID(player_id)))

			if party_id > 0 then
				parties[party_id] = parties[party_id] or {}
				-- size of this party hit the limit of players per team - rest of the players from that party will act as solo players instead
				if #parties[party_id] >= max_team_capacity then
					table.insert(solo_players, player_id)
				else
					table.insert(parties[party_id], player_id)
				end

			else
				table.insert(solo_players, player_id)
			end
		end
	end

	--[[
	if IsInToolsMode() then
		-- some testing data
		parties = {
			-- [1] = {0, 1, 2, 3, 4},
			-- [2] = {5, 6, 7},
			-- [3] = {9, 10},
			-- [4] = {13, 14}
			--
			-- [1] = {0, 1,},
			-- [2] = {2, 3},
			-- [3] = {5, 6, 7},
			-- [4] = {9, 10},
			-- [5] = {13, 14}

			-- [1] = {0, 1, 2, 3},
			-- [2] = {4, 5, 6},
			-- [3] = {7, 8, 9},
			-- [4] = {10, 11, 12},
			-- [5] = {13, 14}
		}
		solo_players = {
			-- 8, 11, 12
			-- 4, 8, 11, 12
		}
	end
	]]


	-- DebugMessage("[Shuffle] scanned for parties", parties)
	-- DeepPrintTable(parties)
	-- DebugMessage("[Shuffle] remaining solo players:", solo_players)
	-- DeepPrintTable(solo_players)

	local parties_by_size = Shuffle:SortPartiesBySize(parties)
	DebugMessage("[Shuffle] parties by size: ", parties_by_size)

	-- Shuffle:DistributePartiesDirectly(parties, parties_by_size, current_team_rosters, max_team_capacity)
	-- Shuffle:DistributePartiesRoundRobin(parties, parties_by_size, current_team_rosters, max_team_capacity)
	Shuffle:DistributePartiesByPartyPlayers(parties, parties_by_size, current_team_rosters, max_team_capacity)

	-- rare edge case - party configuration is such that some party didn't fit
	-- for example - 5 - 4 - 4 - 2 in quintet, and that last party has to be split forcefully
	if table.count(parties) > 0 then
		for party_id, players in pairs(parties) do
			table.extend(solo_players, players)

			DebugMessage("[Shuffle] party", party_id, "didn't fit into teams, moved", players, "into solo pool")
		end

		parties = {}
	end

	-- now that all parties have been distributed, fill the remaining slots with solo players
	for team_index, team_players in pairs(current_team_rosters) do
		local remaining_players = max_team_capacity - #team_players
		for i = 1, remaining_players do
			local player_id = table.remove(solo_players, 1)

			if player_id then
				table.insert(team_players, player_id)
			end
		end
	end

	DebugMessage("[Shuffle] final team rosters:", current_team_rosters)
	-- DeepPrintTable(current_team_rosters)

	local target_teams = table.shuffle(table.shallowcopy(GameLoop.current_layout.teamlist))

	for team_index, players in pairs(current_team_rosters) do
		local new_team = target_teams[team_index]

		DebugMessage("[Shuffle] team index", team_index, "is set to team ID", new_team)

		for _, player_id in pairs(players) do
			Shuffle:SetPlayerTeam(player_id, new_team)

			DebugMessage("[Shuffle] set player", player_id, "to team ID", new_team)
		end
	end
end

function Shuffle:SetPlayerTeam(player_id, new_team)
	if not IsValidPlayerID(player_id) then return end

	PlayerResource:SetCustomTeamAssignment(player_id, new_team)
	PlayerResource:UpdateTeamSlot(player_id, new_team, -1)

	local player = PlayerResource:GetPlayer(player_id)
	if IsValidEntity(player) then
		player:SetTeam(new_team)
	end

end


function Shuffle:SortPartiesBySize(parties)
	local parties_by_size = {}

	for party_id, players in pairs(parties) do
		table.insert(parties_by_size, {party_id, #players})
	end

	table.sort(parties_by_size, function(a, b)
		if a[2] == b[2] then return a[1] < b[1] end

		return a[2] > b[2]
	end)

	return parties_by_size
end


--- Fills teams one by one with parties
--- Easiest direct approach, however will pack parties into one team, potentially leading to disbalance (esp. on larger teams in octet)
function Shuffle:DistributePartiesDirectly(parties, parties_by_size, current_team_rosters, max_team_capacity)
	for _, party_entry in ipairs(parties_by_size) do
		local party_id = party_entry[1]
		local party_size = party_entry[2]

		-- try to fit this party in one of the teams
		for team_index, team_players in pairs(current_team_rosters) do
			if (#team_players + party_size) <= max_team_capacity then
				table.extend(team_players, parties[party_id])
				parties[party_id] = nil
				break
			end
		end
	end
end


--- Atteempts to spread parties around teams evenly by parties count (as long as party fits), not accounting for party size
function Shuffle:DistributePartiesRoundRobin(parties, parties_by_size, current_team_rosters, max_team_capacity)
	local team_cursor = 1
	local team_count = #GameLoop.current_layout.teamlist

	for _, party_entry in ipairs(parties_by_size) do
		local party_id = party_entry[1]
		local party_size = party_entry[2]

		-- wrap cursor around if we tried last team
		if team_cursor > team_count then
			team_cursor = 1
		end

		for i = team_cursor, team_count do
			local team_players = current_team_rosters[i]

			if (#team_players + party_size) <= max_team_capacity then
				table.extend(team_players, parties[party_id])
				parties[party_id] = nil

				team_cursor = team_cursor + 1
				break
			end
		end
	end
end


-- attempts to spread parties around teams event by amount of party players in every team
-- seems to be the most fair on average?
function Shuffle:DistributePartiesByPartyPlayers(parties, parties_by_size, current_team_rosters, max_team_capacity)
	local current_party_players = {}

	for index, _ in pairs(current_team_rosters) do
		table.insert(current_party_players, {index, 0})
	end

	for _, party_entry in ipairs(parties_by_size) do
		local party_id = party_entry[1]
		local party_size = party_entry[2]

		-- sort current party players in ascending order, and try to fit this party from the first entry
		-- which (should) contain least party players, and upwards till we find team that has enough space
		table.sort(current_party_players, function(a, b)
			if a[2] == b[2] then return a[1] < b[1] end

			return a[2] < b[2]
		end)

		for _, current_entry in ipairs(current_party_players) do
			local team_id = current_entry[1]
			local team_players = current_team_rosters[team_id]

			if (#team_players + party_size) <= max_team_capacity then
				table.extend(team_players, parties[party_id])
				current_entry[2] = current_entry[2] + party_size

				parties[party_id] = nil
				break
			end
		end
	end
end