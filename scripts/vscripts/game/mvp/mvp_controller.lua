--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MVPController = MVPController or {}


require("game/mvp/declarations")
require("game/mvp/mvp_wards_tracker")


function MVPController:Init()
	MVPController.wards_score = {}
	MVPController.orb_capture_score = {}
	MVPController.deaths_prevented_score = {}
	MVPController.units_summoned_score = {}

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

	MVPWardsTracker:Init()
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
	local points_winning = table.filter(
		points,
		function(player_id, _, _)
			return PlayerResource:GetTeam(player_id) == winner_team and MVPController:AnyCategoryWon(player_id)
		end
	)
	-- no player in the winning team has any category won - fallback to raw points
	if table.count(points_winning) == 0 then
		print("[MVPController] winner team doesn't have any players with won categories - fallback!")
		points_winning = table.filter(
			points,
			function(player_id, _, _)
				return PlayerResource:GetTeam(player_id) == winner_team
			end
		)
	end

	local mvp_player_id, _ = table.max_value(points_winning)

	-- seek highest that is not MVP (calculated previously)
	local points_for_first_runner_up = table.filter(
		points,
		function(player_id, _, _)
			return player_id ~= mvp_player_id and MVPController:AnyCategoryWon(player_id)
		end
	)
	local first_runner_up, _ = table.max_value(points_for_first_runner_up)

	local first_runner_up_team = first_runner_up and PlayerResource:GetTeam(first_runner_up) or 2

	-- seek highest that is not MVP and not on first runner up team
	local points_for_second_runner_up = table.filter(
		points,
		function(player_id, _, _)
			return player_id ~= mvp_player_id and PlayerResource:GetTeam(player_id) ~= first_runner_up_team and MVPController:AnyCategoryWon(player_id)
		end
	)
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
		print(string.format("%-5d %-30s = %-4.1f %d", player_id, PlayerResource:GetSelectedHeroName(player_id), value, MVPController._statuses[player_id] or 0))
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
			MVPController._category_results[category][winner_player_id] = (MVPController._category_results[category][winner_player_id] or 0) * MVP_LEADER_MULTIPLIER
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

		print(string.format("MVP CATEGORY:\t%s [%d]", category_name, category))
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
	if not accessor then error("[MVPController] no accessor for a given category - " .. category) end

	-- get a list of category values (i.e. damage dealt) of all players
	local category_values = {}
	for player_id, hero in pairs(GameLoop.hero_by_player_id or {}) do
		if PlayerResource:IsBotOrPlayerConnected(player_id) then
			category_values[player_id] = accessor(player_id)
		else
			DebugMessage(player_id, "excluded from mvp - abandoned", PlayerResource:GetConnectionState(player_id), PlayerDC.has_abandoned[player_id])
		end
	end

	local order = MVP_RANK_ORDER[category] or MVP_ASCENDING
	local weight = MVP_WEIGHT_OVERRIDE[category] or 1

	local reference_value = 1

	local peak_weight = table.count(GameLoop.hero_by_player_id or {})

	-- for highest values, exclude everything at/below 0 - as entries that did not contribute to this category
	if order == MVP_ASCENDING then
		local filtered = table.filter(category_values, function(k, v, t) return v > 0 end)
		local _, max_value = table.max_value(filtered)

		peak_weight = table.count(filtered)
		reference_value = max_value ~= nil and max_value or 0
		print(string.format("%d category highest value: %s", category, tostring(reference_value)))
	else
		local _, min_value = table.min_value(category_values)
		reference_value = min_value ~= nil and min_value or 0
		print(string.format("%d category lowest value: %s", category, tostring(reference_value)))
	end

	local points = {}

	for player_id, _ in pairs(GameLoop.hero_by_player_id or {}) do
		local value = category_values[player_id]

		if value then
			-- if our referenced value is supposed to be the smallest, then bigger values should give less points
			-- also make sure the value is non-zero in that case
			local contribution = 0

			if order == MVP_ASCENDING then
				contribution = value / math.max(reference_value, 1)
			else
				-- edge case if smallest (i.e. least deaths) is 0 - cause math involving 0 doesn't really work :(
				if reference_value == 0 then
					contribution = (reference_value + 1) / (value + 1)
				else
					contribution = reference_value / value
				end
			end

			points[player_id] = weight * contribution * peak_weight
			-- print(string.format("%d category, %d player - %.2f / %.2f points [%.1f value]", category, player_id, points[player_id], peak_weight * weight, value))
		else
			points[player_id] = 0
		end
	end

	return points
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



function MVPController:AddWardsRevealTimeScore(player_id, score)
	MVPController.wards_score[player_id] = (MVPController.wards_score[player_id] or 0) + score
end


function MVPController:AddOrbCaptureScore(player_id, score)
	MVPController.orb_capture_score[player_id] = (MVPController.orb_capture_score[player_id] or 0) + score
end


function MVPController:AddDeathPreventedScore(player_id, score)
	MVPController.deaths_prevented_score[player_id] = (MVPController.deaths_prevented_score[player_id] or 0) + score
end


function MVPController:AddUnitSummonedScore(player_id, score)
	MVPController.units_summoned_score[player_id] = (MVPController.units_summoned_score[player_id] or 0) + score
end


--- Returns unique upgrades count by hero upgrades definition - excluding any linked upgrades to make it more fair
---@param player_id number
---@return number
function MVPController:GetUniqueUpgradesCount(player_id)
	local unique_upgrade_count = 0

	-- for fairness, we don't count linked upgrades/abilities
	-- which means we have to iterate original upgrade list of a hero to get just the "base" upgrades

	local hero = GameLoop.hero_by_player_id[player_id]
	if not IsValidEntity(hero) then return 0 end

	local hero_name = hero:GetUnitName()

	local hero_upgrades = Upgrades.upgrades_kv[hero_name] or {}

	for ability_name, upgrades in pairs(hero_upgrades) do
		for upgrade_name, _ in pairs(upgrades) do
			if hero.upgrades and hero.upgrades[ability_name] and hero.upgrades[ability_name][upgrade_name] and hero.upgrades[ability_name][upgrade_name].count > 0 then
				unique_upgrade_count = unique_upgrade_count + 1
			end
		end
	end

	for upgrade_name, _ in pairs(Upgrades.generic_upgrades_kv or {}) do
		if hero.upgrades and hero.upgrades.generic and hero.upgrades.generic[upgrade_name] and hero.upgrades.generic[upgrade_name].count > 0 then
			unique_upgrade_count = unique_upgrade_count + 1
		end
	end

	return unique_upgrade_count
end


function MVPController:GetDeathsPrevented(player_id)
	return MVPController.deaths_prevented_score[player_id] or 0
end


function MVPController:GetUnitsSummonedCount(player_id)
	return MVPController.units_summoned_score[player_id] or 0
end


--- Returns type of MVP for desired player, specifically for backend
--- For backend purposes we do not care which runner up is player - both fall under same type
---@param player_id number
function MVPController:GetAftermatchMVPType(player_id)
	local status = MVPController._statuses[player_id]

	if status == MVP_TYPE.WINNER then return MVP_TYPE.WINNER end
	if status == MVP_TYPE.RUNNER_UP_1 or status == MVP_TYPE.RUNNER_UP_2 then return MVP_TYPE.RUNNER_UP_1 end

	return MVP_TYPE.NONE
end


function MVPController:GetMVPType(player_id)
	return MVPController._statuses[player_id] or MVP_TYPE.NONE
end


--- Returns rewards for desired mvp type, if any
--- WARNING: takes into account conditions of MVP eligibility - game duration and player counts, and will return empty table if game is ineligible
---@param mvp_type MVP_TYPE
function MVPController:GetMVPReward(mvp_type)
	if not mvp_type or mvp_type == MVP_TYPE.NONE then return {} end

	local map_name = GetMapName()

	-- game has to be at least 10 minutes long and have all players in to qualify
	if GameRules:GetGameTime() < 10 * 60 or not GameLoop.is_full_lobby or map_name == "ot3_demo" or HostOptions:GetOption(HOST_OPTION.TOURNAMENT) or not SimulatedEndGame:IsSubmissionAllowed() then
		DebugMessage("[MVPController] declined MVP rewards - ineligible match")
		return {}
	end

	return (MVP_REWARDS[map_name] or {})[mvp_type] or {}
end


MVPController:Init()