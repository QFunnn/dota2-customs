--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


MVPController = MVPController or {}

require("game/mvp/declarations")

function MVPController:Init()
	-- list of mvp players and categories per MVP type
	MVPController._results = {}

	-- list of mvp types per player id
	MVPController._statuses = {}

	-- list of ranks per category
	MVPController._category_results = {}
	MVPController._category_winners = {}

	for _, category in pairs(MVP_EXCLUDED_CATEGORIES_PER_MAP[GetMapName()] or {}) do
		table.remove_item(MVP_CATEGORY, category)
	end
end

function MVPController:GetMVPData()
	return MVPController._results
end

function MVPController:FinalizeStats(winner_team)
	print("MVP for winner team:", winner_team, type(winner_team))
	MVPController._results = {}

	MVPController:CalculateCategoryPoints()

	local points = MVPController:GetTotalPoints()

	-- seek highest points on WINNER team
	local points_winning = table.filter(points, function(player_id, _, _)
		return PlayerResource:GetTeam(player_id) == winner_team and MVPController:AnyCategoryWon(player_id)
	end)
	-- no player in the winning team has any category won - fallback to raw points
	if table.count(points_winning) == 0 then
		print("[MVPController] winner team doesn't have any players with won categories - fallback!")
		points_winning = table.filter(points, function(player_id, _, _)
			return PlayerResource:GetTeam(player_id) == winner_team
		end)
	end

	local mvp_player_id, _ = table.max_value(points_winning)

	-- seek highest that is not MVP (calculated previously)
	local points_for_first_runner_up = table.filter(points, function(player_id, _, _)
		return player_id ~= mvp_player_id and MVPController:AnyCategoryWon(player_id)
	end)
	local first_runner_up, _ = table.max_value(points_for_first_runner_up)

	local first_runner_up_team = first_runner_up and PlayerResource:GetTeam(first_runner_up) or 2

	-- seek highest that is not MVP and not on first runner up team
	local points_for_second_runner_up = table.filter(points, function(player_id, _, _)
		return player_id ~= mvp_player_id
			and PlayerResource:GetTeam(player_id) ~= first_runner_up_team
			and MVPController:AnyCategoryWon(player_id)
	end)
	local second_runner_up, _ = table.max_value(points_for_second_runner_up)

	-- store them to use later
	MVPController._statuses = {}
	MVPController._results = {}

	if mvp_player_id then
		MVPController._statuses[mvp_player_id] = MVP_TYPE.WINNER
		MVPController._results[MVP_TYPE.WINNER] = {
			player_id = mvp_player_id,
			categories = MVPController:GetPlayerMVPCategories(mvp_player_id),
			rewards = MVPController:GetMVPReward(MVP_TYPE.WINNER),
		}
	end

	if first_runner_up then
		MVPController._statuses[first_runner_up] = MVP_TYPE.RUNNER_UP_1
		MVPController._results[MVP_TYPE.RUNNER_UP_1] = {
			player_id = first_runner_up,
			categories = MVPController:GetPlayerMVPCategories(first_runner_up),
			rewards = MVPController:GetMVPReward(MVP_TYPE.RUNNER_UP_1),
		}
	end

	if second_runner_up then
		MVPController._statuses[second_runner_up] = MVP_TYPE.RUNNER_UP_2
		MVPController._results[MVP_TYPE.RUNNER_UP_2] = {
			player_id = second_runner_up,
			categories = MVPController:GetPlayerMVPCategories(second_runner_up),
			rewards = MVPController:GetMVPReward(MVP_TYPE.RUNNER_UP_2),
		}
	end

	print("[MVPController] total MVP points:")
	for player_id, value in pairs(points) do
		print(
			string.format(
				"%-5d %-30s = %-4.1f %d",
				player_id,
				PlayerResource:GetSelectedHeroName(player_id),
				value,
				MVPController._statuses[player_id] or 0
			)
		)
	end

	print("[MVPController] finished calculating MVP results:")
	DeepPrintTable(MVPController._results)
end

function MVPController:AnyCategoryWon(player_id)
	return table.count(MVPController._category_winners[player_id] or {}) > 0
end

function MVPController:CalculateCategoryPoints()
	print("[MVPController] calculating points for all categories")
	for category_name, category in pairs(MVP_CATEGORY) do
		local category_points = MVPController:GetCategoryPoints(category)

		MVPController._category_results[category] = category_points

		local winner_player_id = table.max_value(category_points)

		if winner_player_id then
			print("[MVPController] category", category, "won by", winner_player_id)

			MVPController._category_winners[winner_player_id] = MVPController._category_winners[winner_player_id] or {}

			table.insert(MVPController._category_winners[winner_player_id], category)

			-- multiply winner points
			MVPController._category_results[category][winner_player_id] = (
				MVPController._category_results[category][winner_player_id] or 0
			) * MVP_LEADER_MULTIPLIER
		else
			ErrorTracking.Collect(
				"Category "
					.. category_name
					.. " is missing winner player id: "
					.. tostring(winner_player_id)
					.. " | "
					.. table.count(category_points)
			)
		end
	end
end

--- Returns table of player IDs and their combined MVP points across all categories
function MVPController:GetTotalPoints()
	local points = {}

	-- for every category, get a list of points received (basically get a top players in every category)
	-- and sum them up
	for category_name, category in pairs(MVP_CATEGORY) do
		local category_points = MVPController._category_results[category]

		print("MVP CATEGORY: ", category_name)
		DeepPrintTable(category_points)

		for player_id, score in pairs(category_points) do
			points[player_id] = (points[player_id] or 0) + score
		end
	end

	return points
end

--- Returns all players ranked by points in desired category
---@param category MVP_CATEGORY
function MVPController:GetCategoryPoints(category)
	local accessor = MVP_ACCESSOR[category]
	if not accessor then
		error("[MVPController] no accessor for a given category - " .. category)
		return {}
	end

	-- get a list of category values (i.e. damage dealt) of all players
	local category_values = {}
	for player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		local has_abandoned = GameMode:HasAbandoned(player_id)
		if has_abandoned then
			DebugMessage(
				player_id,
				"excluded from mvp - abandoned",
				PlayerResource:GetConnectionState(player_id),
				has_abandoned
			)
		-- elseif Votekick:IsPlayerKicked(player_id) then
		-- 	DebugMessage(player_id, "excluded from mvp - kicked")
		elseif WebPlayer:GetPunishmentLevel(player_id) == 10 then
			DebugMessage(player_id, "excluded from mvp - punishment 10")
		else
			category_values[player_id] = accessor(player_id)
			print("[MVP] category", category, "for", player_id, "value is", category_values[player_id])
		end
	end

	local order = MVP_RANK_ORDER[category] or MVP_ASCENDING
	local weight = MVP_WEIGHT_OVERRIDE[category] or 1

	local ranks = table.rank(category_values, order)

	if weight ~= 1 then
		for player_id, rank in pairs(ranks or {}) do
			ranks[player_id] = rank * weight
		end
	end

	return ranks
end

--- Returns a table of categories player is MVP, and values for said categories
--- I.e. would return {[MVP_CATEGORY.DAMAGE_DEALT] = 122012} for a player with highest damage dealt
---@param player_id any
function MVPController:GetPlayerMVPCategories(player_id)
	local player_categories = {}

	print("[MVPController] fetching MVP categories for player", player_id)

	for _, category in pairs(MVPController._category_winners[player_id] or {}) do
		local value = MVP_ACCESSOR[category](player_id)
		-- value should be greater than 0, for all descending categories
		if value > 0 or MVP_RANK_ORDER[category] == MVP_DESCENDING then
			player_categories[category] = value
		end
	end

	return player_categories
end

--- Returns type of MVP for desired player, specifically for backend
--- For backend purposes we do not care which runner up is player - both fall under same type
---@param player_id number
function MVPController:GetAftermatchMVPType(player_id)
	local status = MVPController._statuses[player_id]

	if status == MVP_TYPE.WINNER then
		return MVP_TYPE.WINNER
	end
	if status == MVP_TYPE.RUNNER_UP_1 or status == MVP_TYPE.RUNNER_UP_2 then
		return MVP_TYPE.RUNNER_UP_1
	end

	return MVP_TYPE.NONE
end

function MVPController:GetMVPType(player_id)
	return MVPController._statuses[player_id] or MVP_TYPE.NONE
end

--- Returns rewards for desired mvp type, if any
--- WARNING: takes into account conditions of MVP eligibility - game duration and player counts, and will return empty table if game is ineligible
---@param mvp_type MVP_TYPE
function MVPController:GetMVPReward(mvp_type)
	if not mvp_type or mvp_type == MVP_TYPE.NONE then
		return {}
	end

	-- game has to be at least 10 minutes long and have all players in to qualify
	if GameRules:GetGameTime() < 10 * 60 or GetMapName() == "dota_tournament" then
		DebugMessage("[MVPController] declined MVP rewards - ineligible match")
		return {}
	end

	return MVP_REWARDS[mvp_type] or {}
end

MVPController:Init()