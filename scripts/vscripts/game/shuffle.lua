--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


Shuffle = Shuffle or {}
Shuffle.players_to_kick = {}
Shuffle.players_kicked = {}
Shuffle.team_counters = {}
Shuffle.weak_team_id = -100
Shuffle.gold_multiplier = 1
Shuffle._mock_rating = {}
Shuffle._mock_party_id = {
	-- tools mock data
	[0] = 1,
	[1] = 1,
	[2] = 1,

	[3] = 2,
	[4] = 2,
	[5] = 2,

	[7] = 3,
	[8] = 3,
	[9] = 3,

	[10] = 3,
	[11] = 4,
	[12] = 4,

	[13] = 5,
	[14] = 5,
	[15] = 5,
	[16] = 5,
	[17] = 5,
	[18] = 5,
}

WEAK_TEAM_BASE_BONUS = 1.5
WEAK_TEAM_MAX_BONUS = 100
WEAK_TEAM_MIN_DELTA = 50
WEAK_TEAM_STEP_DELTA = 50
WEAK_TEAM_STEP_BONUS = 1.5

WEAK_TEAM_BONUS_GOLD_PCT = 1
WEAK_TEAM_BONUS_EXP_PCT = 0.5

function Shuffle:DoTeamShuffle()
	DebugMessage("[Shuffle] starting!")

	for _, team in pairs(GameLoop.current_layout.teamlist) do
		Shuffle.team_counters[team] = 0
	end

	local max_team_capacity = GameLoop.current_layout.player_count

	local parties = {}

	local max_total_players = max_team_capacity * #GameLoop.current_layout.teamlist

	for player_id = 0, max_total_players - 1 do
		if IsValidPlayerID(player_id) then
			local current_team = PlayerResource:GetTeam(player_id)
			DebugMessage("Player", player_id, "in team", current_team)
			--if current_team ~= DOTA_TEAM_GOODGUYS then
			--	Shuffle.players_to_kick[player_id] = true
			--end

			local party_id = Shuffle:GetPlayerPartyID(player_id) --
			-- we will assume all solo players as being in a party of size 1 with fake ID
			if party_id <= 0 then
				party_id = player_id - 120000
			end

			parties[party_id] = parties[party_id] or {
				players = {},
				rating = 0,
			}
			table.insert(parties[party_id].players, player_id)
			parties[party_id].rating = parties[party_id].rating + Shuffle:GetPlayerRating(player_id)
		end
	end

	Shuffle:UnassignAll()

	print("parties collected:")
	DeepPrintTable(parties)

	-- now we sort all parties by total/average rating descending, and fill teams while maintaining relative parity
	local parties_by_total_rating = Shuffle:SortPartiesByRating(parties, false)
	local parties_by_avg_rating = Shuffle:SortPartiesByRating(parties, true)

	print("parties sorted by total rating")
	DeepPrintTable(parties_by_total_rating)

	print("parties sorted by average rating")
	DeepPrintTable(parties_by_avg_rating)

	-- {delta: number, clean: bool, team_rosters: table}
	-- clean means that no parties were split in this sort
	local sorts = {
		Shuffle:ShuffleTypeA(parties_by_total_rating, max_team_capacity, true),
		Shuffle:ShuffleTypeA(parties_by_total_rating, max_team_capacity, false),
		Shuffle:ShuffleTypeA(parties_by_avg_rating, max_team_capacity, true),
		Shuffle:ShuffleTypeA(parties_by_avg_rating, max_team_capacity, false),
		Shuffle:ShuffleTypeB(parties_by_total_rating, max_team_capacity),
		Shuffle:ShuffleTypeB(parties_by_avg_rating, max_team_capacity),
		Shuffle:ShuffleTypeC(parties_by_total_rating, max_team_capacity, true),
		Shuffle:ShuffleTypeC(parties_by_total_rating, max_team_capacity, false),
		Shuffle:ShuffleTypeC(parties_by_avg_rating, max_team_capacity, true),
		Shuffle:ShuffleTypeC(parties_by_avg_rating, max_team_capacity, false),
	}

	for index, sort in pairs(sorts) do
		DebugMessage(
			"[Shuffle] Sort "
				.. index
				.. " finished "
				.. (sort.clean and "clean" or "unclean")
				.. " with delta of "
				.. sort.delta
		)
	end

	-- Determine which sort was the best
	table.sort(sorts, function(a, b)
		-- If sort wasnt clean, add a very high number to sort all clean sorts ahead of unclean sorts
		local a_delta = a.delta + (a.clean and 0 or 99999)
		local b_delta = b.delta + (b.clean and 0 or 99999)

		return a_delta < b_delta
	end)

	local final_team_rosters = sorts[1].team_rosters

	DebugMessage("[Shuffle] final team rosters:", final_team_rosters)
	DeepPrintTable(final_team_rosters)

	local target_teams = table.shuffle(table.shallowcopy(GameLoop.current_layout.teamlist))

	for team_index, players in pairs(final_team_rosters) do
		local new_team = target_teams[team_index]

		DebugMessage("[Shuffle] team index", team_index, "is set to team ID", new_team)

		DeepPrintTable(players)

		for _, player_id in pairs(players) do
			print(player_id)
			Shuffle:SetPlayerTeam(player_id, new_team)

			-- DebugMessage("[Shuffle] set player", player_id, "[", Shuffle:GetPlayerRating(player_id), Shuffle:GetPlayerPartyID(player_id), "]", "to team ID", new_team)
		end
	end

	Shuffle:CalculateWeakTeamBonus()
end

function Shuffle:GetPlayerPartyID(player_id)
	if IsInToolsMode() then
		-- use predefined party data when applicable
		if Shuffle._mock_party_id[player_id] then
			return Shuffle._mock_party_id[player_id]
		end
	end

	return tonumber(tostring(PlayerResource:GetPartyID(player_id)))
end

function Shuffle:GetPlayerRating(player_id)
	-- in tools, fake rating to test shuffle
	if IsInToolsMode() then
		if Shuffle._mock_rating[player_id] then
			return Shuffle._mock_rating[player_id]
		end
		Shuffle._mock_rating[player_id] = RandomInt(250, 6500)
		return Shuffle._mock_rating[player_id]
	end

	return WebPlayer:GetRating(player_id)
end

function Shuffle:SetPlayerTeam(player_id, new_team)
	if not IsValidPlayerID(player_id) then
		return
	end

	local counter = Shuffle.team_counters[new_team]

	PlayerResource:UpdateTeamSlot(player_id, new_team, counter + 1)
	PlayerResource:SetCustomTeamAssignment(player_id, new_team)

	Shuffle.team_counters[new_team] = Shuffle.team_counters[new_team] + 1
	DebugMessage(
		"[Shuffle] assigned player",
		player_id,
		"to team",
		new_team,
		"at slot",
		Shuffle.team_counters[new_team]
	)

	-- there is a chance that this is a bad idea
	-- local player = PlayerResource:GetPlayer(player_id)
	-- if IsValidEntity(player) then
	-- 	player:SetTeam(new_team)
	-- end
end

function Shuffle:UnassignAll()
	for i = 0, 24 do
		if IsValidPlayerID(i) then
			PlayerResource:UpdateTeamSlot(i, DOTA_TEAM_NOTEAM, i)
			PlayerResource:SetCustomTeamAssignment(i, DOTA_TEAM_NOTEAM)
		end
	end
end

function Shuffle:SortPartiesByRating(parties, average)
	local parties_by_rating = {}

	for party_id, party_data in pairs(parties) do
		table.insert(parties_by_rating, { party_id, party_data })
	end

	if average then
		table.sort(parties_by_rating, function(a, b)
			local a_rating = a[2].rating / #a[2].players
			local b_rating = b[2].rating / #b[2].players

			if a_rating == b_rating then
				return a[1] < b[1]
			end

			return a_rating > b_rating
		end)
	else
		table.sort(parties_by_rating, function(a, b)
			if a[2].rating == b[2].rating then
				return a[1] < b[1]
			end

			return a[2].rating > b[2].rating
		end)
	end

	return parties_by_rating
end

function Shuffle:KickRemainingPlayers()
	for player_id, _ in pairs(Shuffle.players_to_kick) do
		if not Shuffle.players_kicked[player_id] then
			DebugMessage("Player", player_id, "is in kick list, but wasn't kicked before, randomed?")

			-- Shuffle:OnHeroSelected(player_id)
		end
	end
end

function Shuffle:CalculateWeakTeamBonus()
	-- recalculate average ratings, delta between them and see if any team is considerably lower
	local ratings = {}

	local max_total_players = GameLoop.current_layout.player_count * #GameLoop.current_layout.teamlist

	for player_id = 0, max_total_players - 1 do
		if IsValidPlayerID(player_id) then
			local current_team = PlayerResource:GetTeam(player_id)
			ratings[current_team] = (ratings[current_team] or 0) + Shuffle:GetPlayerRating(player_id)
		end
	end

	ratings[DOTA_TEAM_GOODGUYS] = (ratings[DOTA_TEAM_GOODGUYS] or 0) / 12.0
	ratings[DOTA_TEAM_BADGUYS] = (ratings[DOTA_TEAM_BADGUYS] or 0) / 12.0

	-- if delta is positive, then average rating of radiant is higher, therefore dire is weak
	-- and vice-versa
	local delta = ratings[DOTA_TEAM_GOODGUYS] - ratings[DOTA_TEAM_BADGUYS]

	if math.abs(delta) < WEAK_TEAM_MIN_DELTA then
		DebugMessage("[Shuffle] weak team calc skipped - delta insufficient", delta)
		return
	end

	Shuffle.weak_team_id = delta > 0 and DOTA_TEAM_BADGUYS or DOTA_TEAM_GOODGUYS

	DebugMessage(
		"[Shuffle] calculating weak team bonus:",
		ratings[DOTA_TEAM_GOODGUYS],
		ratings[DOTA_TEAM_BADGUYS],
		delta,
		Shuffle.weak_team_id
	)

	Shuffle.weak_team_bonus_pct = math.min(
		WEAK_TEAM_BASE_BONUS
			+ math.floor((math.abs(delta) - WEAK_TEAM_MIN_DELTA) / WEAK_TEAM_STEP_DELTA) * WEAK_TEAM_STEP_BONUS,
		WEAK_TEAM_MAX_BONUS
	)
	Shuffle.gold_multiplier = 1 + Shuffle.weak_team_bonus_pct * WEAK_TEAM_BONUS_GOLD_PCT * 0.01
	Shuffle.xp_multiplier = Shuffle.weak_team_bonus_pct * WEAK_TEAM_BONUS_EXP_PCT
	Shuffle.delta = delta

	DebugMessage(
		"[Shuffle] calculated multipliers:",
		Shuffle.weak_team_bonus_pct,
		Shuffle.gold_multiplier,
		Shuffle.xp_multiplier
	)
end

function Shuffle:AnnounceWeakTeam()
	if Shuffle.weak_team_id < 0 then
		return
	end
	CustomGameEventManager:Send_ServerToTeam(
		Shuffle.weak_team_id,
		"WeakTeamNotification",
		{ gold_multiplier = Shuffle.gold_multiplier, xp_multiplier = Shuffle.xp_multiplier, mmrDiff = Shuffle.delta }
	)
end

function Shuffle:GiveBonusToHero(hero)
	DebugMessage("[Shuffle] giving weak bonus to hero", hero:GetUnitName())
	hero:AddNewModifier(
		hero,
		nil,
		"modifier_weak_team_bonus",
		{ duration = -1, weak_team_bonus_pct = self.xp_multiplier }
	)
end

-- Shuffle algorithms

function Shuffle:ShuffleTypeA(parties, max_team_capacity, average_during_sort)
	local rating = { [1] = 0, [2] = 0 }
	local clean = true -- Whether or not all parties are preserved in the final sort
	local teams = { [1] = {}, [2] = {} } -- list of player id's in each team

	-- Sorting type A: Add highest remaining party to lower team until out of parties
	for _, party in pairs(parties) do
		local party_rating = party[2].rating
		local party_players = party[2].players
		local delta = 0

		if average_during_sort then
			-- Avoid divide by 0
			delta = delta + (#teams[1] ~= 0 and (rating[1] / #teams[1]) or 0)
			delta = delta - (#teams[2] ~= 0 and (rating[2] / #teams[2]) or 0)
		else
			delta = rating[1] - rating[2]
		end

		local index = delta < 0 and 1 or 2

		-- Check if this team has space for this party
		if #teams[index] + #party_players <= max_team_capacity then
			table.extend(teams[index], party_players)

			rating[index] = rating[index] + party_rating

		-- Check if other team has space for this party
		elseif #teams[index == 1 and 2 or 1] + #party_players <= max_team_capacity then
			index = index == 1 and 2 or 1

			table.extend(teams[index], party_players)

			rating[index] = rating[index] + party_rating

		-- Neither team has space for this party
		else
			-- Add each player from this party to teams individually
			index = #teams[1] <= #teams[2] and 1 or 2
			for _, player_id in pairs(party_players) do
				if #teams[index] >= max_team_capacity then
					index = index == 1 and 2 or 1
				end

				table.insert(teams[index], player_id)

				rating[index] = rating[index] + Shuffle:GetPlayerRating(player_id)
			end

			-- Indicate that this sort failed to assign all parties to the same team
			clean = false
		end
	end

	return { delta = math.abs(rating[1] - rating[2]), clean = clean, team_rosters = teams }
end

function Shuffle:ShuffleTypeB(parties, max_team_capacity)
	local rating = { [1] = 0, [2] = 0 }
	local clean = true -- Whether or not all parties are preserved in the final sort
	local teams = { [1] = {}, [2] = {} } -- list of player id's in each team

	-- Sorting type B: Add highest and lowest to first team, second highest/lowest to second team, repeat until out of parties
	for iter = 1, math.floor(#parties / 2) do
		local party_high = parties[iter]
		local party_low = parties[#parties - iter + 1]
		local index = iter % 2 + 1

		for _, party in pairs({ party_high, party_low }) do
			local party_rating = party[2].rating
			local party_players = party[2].players

			-- Check team has enough space for this party
			if #teams[index] + #party_players <= max_team_capacity then
				table.extend(teams[index], party_players)

				rating[index] = rating[index] + party_rating

			-- Check if other team has space for this party
			elseif #teams[index == 1 and 2 or 1] + #party_players <= max_team_capacity then
				index = index == 1 and 2 or 1
				table.extend(teams[index], party_players)

				rating[index] = rating[index] + party_rating

			-- Neither team has space for this party
			else
				-- Add each player from this party to teams individually
				index = #teams[1] <= #teams[2] and 1 or 2
				for _, player_id in pairs(party_players) do
					if #teams[index] >= max_team_capacity then
						index = index == 1 and 2 or 1
					end

					table.insert(teams[index], player_id)

					rating[index] = rating[index] + Shuffle:GetPlayerRating(player_id)
				end

				clean = false
			end
		end
	end

	-- Add the final party to a team (if there is one)
	if #parties % 2 == 1 then
		local party = parties[math.ceil(#parties / 2)]
		local index = #teams[1] <= #teams[2] and 1 or 2

		for _, player_id in pairs(party[2].players) do
			if #teams[index] >= max_team_capacity then
				index = index == 1 and 2 or 1

				clean = false
			end

			table.insert(teams[index], player_id)

			rating[index] = rating[index] + Shuffle:GetPlayerRating(player_id)
		end
	end

	return { delta = math.abs(rating[1] - rating[2]), clean = clean, team_rosters = teams }
end

function Shuffle:ShuffleTypeC(parties, max_team_capacity, average_during_sort)
	local rating = { [1] = 0, [2] = 0 }
	local clean = true -- Whether or not all parties are preserved in the final sort
	local teams = { [1] = {}, [2] = {} } -- list of player id's in each team

	-- Sorting type C: Add highest party to each team then add from top end to lower team and bottom end to higher team

	-- Add the highest 2 parties to different teams
	local first_teams = { parties[1], parties[2] }
	local index = 1

	for _, party in pairs(first_teams) do
		index = index == 1 and 2 or 1

		table.extend(teams[index], party[2].players)

		rating[index] = rating[index] + party[2].rating
	end

	-- Do the rest of the parties
	for iter = 1, math.floor(#parties / 2) - 1 do
		local party_high = parties[iter + 2]
		local party_low = parties[#parties - iter + 1]

		if average_during_sort then
			index = rating[1] / #teams[1] < rating[2] / #teams[2] and 2 or 1
		else
			index = rating[1] < rating[2] and 2 or 1
		end

		for _, party in pairs({ party_high, party_low }) do
			local party_rating = party[2].rating
			local party_players = party[2].players

			index = index == 1 and 2 or 1

			-- Check team has enough space for this party
			if #teams[index] + #party_players <= max_team_capacity then
				table.extend(teams[index], party_players)

				rating[index] = rating[index] + party_rating

			-- Check if other team has space for this party
			elseif #teams[index == 1 and 2 or 1] + #party_players <= max_team_capacity then
				index = index == 1 and 2 or 1
				table.extend(teams[index], party_players)

				rating[index] = rating[index] + party_rating

			-- Neither team has space for this party
			else
				-- Add each player from this party to teams individually
				index = #teams[1] <= #teams[2] and 1 or 2
				for _, player_id in pairs(party_players) do
					if #teams[index] >= max_team_capacity then
						index = index == 1 and 2 or 1
					end

					table.insert(teams[index], player_id)

					rating[index] = rating[index] + Shuffle:GetPlayerRating(player_id)
				end

				clean = false
			end
		end
	end

	-- Add the final party to a team (if there is one)
	if #parties % 2 == 1 and #parties > 2 then
		local party = parties[math.ceil(#parties / 2) + 1]

		local index = #teams[1] <= #teams[2] and 1 or 2

		for _, player_id in pairs(party[2].players) do
			if #teams[index] >= max_team_capacity then
				index = index == 1 and 2 or 1

				clean = false
			end

			table.insert(teams[index], player_id)

			rating[index] = rating[index] + Shuffle:GetPlayerRating(player_id)
		end
	end

	return { delta = math.abs(rating[1] - rating[2]), clean = clean, team_rosters = teams }
end