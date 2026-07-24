--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


HeroChallenges = HeroChallenges or {}

require("game/hero_challenges/declarations")
require("game/hero_challenges/hero_challenge_types")

HeroChallenges.preset_winrates = require("game/hero_challenges/preset_winrates")


function HeroChallenges:Init()
	-- list of heroes and weights to roll challenges
	HeroChallenges._hero_pool = {}

	-- table of all challenges of players
	---@type table<number, Challenge[]>
	HeroChallenges.challenges = {}

	-- table of newly created challenges, waiting to be submitted to backend
	---@type table<number, Challenge[]>
	HeroChallenges.pending_challenges = {}

	-- currently active challege for a player (if any)
	-- heroes for challenges are unique, so only 1 can be active at a time
	---@type table<number, Challenge>
	HeroChallenges.active_challenges = {}

	EventStream:Listen("HeroChallenges:get_challenges", HeroChallenges.SendCurrentChallengesEvent, HeroChallenges)
	EventStream:Listen("HeroChallenges:ping_progress", HeroChallenges.PingProgress, HeroChallenges)

	EventDriver:Listen("GameLoop:hero_init_finished", HeroChallenges.OnHeroInitFinished, HeroChallenges)

	Timers:CreateTimer("challenges_core_update", {
		useGameTime = false,
		endTime = CHALLENGES_UPDATE_INTERVAL,
		callback = HeroChallenges.UpdateWrap
	})
end


function HeroChallenges:SendCurrentChallengesEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	HeroChallenges:SetClientChallenges(player_id)
end


function HeroChallenges:UpdateWrap()
	if GameLoop.game_over then
		DebugMessage("[Hero Challenges] stopping Update loop - game ended")
		return
	end

	-- DebugMessage("[Hero Challenges] update tick")
	HeroChallenges:Update()

	return CHALLENGES_UPDATE_INTERVAL
end


--- For most challenges it's generally easier to just check on stat values occasionally, rather then listening to them constantly
--- That way we can also skip update stagger - since updates are already happen occasionally
function HeroChallenges:Update()
	for player_id, challenge in pairs(HeroChallenges.active_challenges) do
		local accessor = CHALLENGE_ACCESSOR[challenge.challenge_type]

		local progress_value = accessor(player_id)

		if not challenge.completed and challenge.progress < progress_value then
			-- challenge.progress = math.min(challenge.progress, challenge.target)
			HeroChallenges:SubmitChallegeProgress(player_id, challenge, progress_value)
		end
	end
end


--- Parse retrieved winrates list to prepare weighted pool of heroes to roll challenges from
---@param winrates table
function HeroChallenges:PreparePoolFromWinrates(winrates)
	-- winrates comes in as a {hero_name, winrate} table
	local current_weight = CHALLENGES_WINRATE_WEIGHT_STEP
	local bracket_counter = 0

	local weighted_pool = {}

	table.sort(winrates, function(a, b) return a[2] > b[2] end)

	for index, row in pairs(winrates) do
		weighted_pool[row[1]] = current_weight
		bracket_counter = bracket_counter + 1

		if bracket_counter >= CHALLENGES_WINRATE_BRACKET_SIZE then
			bracket_counter = 0
			current_weight = current_weight + CHALLENGES_WINRATE_WEIGHT_STEP
		end
	end

	HeroChallenges._hero_pool = weighted_pool

	-- print("[Hero Challenges] processed hero pool:")
	-- DeepPrintTable(HeroChallenges._hero_pool)
end


--- Iterate over challenges retrieved from before-match and roll missing challenges - for sub level changes and first games of a day
---@param player_id number
---@param challenges table
function HeroChallenges:ProcessPlayerChallenges(player_id, challenges)
	local subscription_tier = WebPlayer:GetSubscriptionTier(player_id) or 0
	local expected_count = CHALLENGES_COUNT[subscription_tier]

	HeroChallenges.challenges[player_id] = {}

	local valid_index = 1
	for index, challenge in pairs(challenges or {}) do
		-- make sure challenge is valid, and within applicable count (if subscription expires)
		local validate_status = HeroChallenges:ValidateChallenge(challenge)
		if validate_status and valid_index <= expected_count then
			table.insert(HeroChallenges.challenges[player_id], HeroChallenges:BuildHeroChallenge(challenge))
			valid_index = valid_index + 1
		end
		if not validate_status then DebugMessage("INVALID CHALLENGE", challenge.hero_id, challenge.challenge_type) end
	end

	-- print("[Hero Challenges] processed incoming challenges of", player_id)
	-- DeepPrintTable(HeroChallenges.challenges[player_id])

	local present_count = table.count(HeroChallenges.challenges[player_id] or {})

	-- roll missing challenges
	local missing_count = expected_count - present_count
	local new_challenges = HeroChallenges:RollChallengesForPlayer(player_id, missing_count)

	-- save new challenges as pending for backend submission
	HeroChallenges.pending_challenges[player_id] = new_challenges
end


--- Rolls hero name for a new challenge, in a weighted manner, excluding already rolled heroes
---@param excluded_challenges table<string, CHALLENGE_TYPE>
function HeroChallenges:_RollHeroNameWeighted(excluded_challenges)
	local weight_pool = {}
	local total_weight = 0

	for hero_name, weight in pairs(HeroChallenges._hero_pool or {}) do
		if not excluded_challenges[hero_name] then
			weight_pool[hero_name] = weight
			total_weight = total_weight + weight
		end
	end


	local rolled_value = RandomInt(0, total_weight)

	-- print("[Hero Challenges] rolling hero name", total_weight, rolled_value)

	for hero_name, weight in pairs(weight_pool) do
		rolled_value = rolled_value - weight
		if rolled_value <= 0 then
			return hero_name
		end
	end
end


--- Rolls challenge type for a hero name, from a pool of compatible challenges
---@param hero_name string
---@return CHALLENGE_TYPE
function HeroChallenges:_RollChallengeTypeForHero(hero_name, present_challenges)
	-- base roll guarantees that all heroes in challenges are unique
	-- so we don't have to filter challenge types, duplicates cannot exist
	local challenges_definitions = HERO_CHALLENGE_TYPES[hero_name]

	if not challenges_definitions then error("[Hero Challenges] missing challenge definition for " .. hero_name) end

	-- record which types are already rolled
	local present_challenge_types = table.make_value_table(present_challenges or {})

	-- and find ones we haven't rolled
	local unrolled_challenge_types = table.array_difference(challenges_definitions.types, present_challenge_types)

	-- if there's no types available - fall back to hero types pool
	if not unrolled_challenge_types or #unrolled_challenge_types <= 0 then unrolled_challenge_types = challenges_definitions.types end

	return table.random(unrolled_challenge_types)
end


--- Rolls difficulty of a challenge in a weighted
function HeroChallenges:_RollDifficulty()
	local rolled_difficulty = table.random_weighted(CHALLENGE_DIFFICULTY_ROLL_CHANCE) or CHALLENGE_DIFFICULTY.COMMON
	return rolled_difficulty
end


--- Fetches a complete target for a challenge (using base target, difficulty and hero configurations)
---@param hero_name string
---@param challenge_type CHALLENGE_TYPE
---@param difficulty CHALLENGE_DIFFICULTY
---@return number @ target
function HeroChallenges:GetTarget(hero_name, challenge_type, difficulty)
	local challenges_definitions = HERO_CHALLENGE_TYPES[hero_name]

	if not challenges_definitions then error("[Hero Challenges] missing challenge definition for " .. hero_name) end

	local map_index = CHALLENGE_MAP_INDEX[GetMapName()]
	local base_target = (CHALLENGE_TARGETS[challenge_type] or {})[map_index] or 99999

	local difficulty_multiplier = CHALLENGE_DIFFICULTY_MULTIPLIER[difficulty] or 1

	-- override difficulty multiplier for challenges relating to hero kills
	if challenge_type == CHALLENGE_TYPE.KILL or challenge_type == CHALLENGE_TYPE.ASSIST then
		difficulty_multiplier = CHALLENGE_DIFFICULTY_MULTIPLIER_KILLS_OVERRIDE[difficulty] or difficulty_multiplier
	end

	-- hero-wide target multiplier
	local target_bias = challenges_definitions.target_bias or 1

	if challenges_definitions.types_override then
		local challenge_override = challenges_definitions.types_override[challenge_type]
		if challenge_override then
			if challenge_override.target then base_target = challenge_override.target end
			if challenge_override.target_bias then target_bias = challenge_override.target_bias end
		end
	end

	return math.ceil(base_target * target_bias * difficulty_multiplier)
end


--- Calculates reward for passed difficulty
---@param difficulty CHALLENGE_DIFFICULTY
function HeroChallenges:GetReward(hero_name, difficulty)
	local base_reward = table.deepcopy(CHALLENGE_BASE_REWARD)

	local multiplier = CHALLENGE_DIFFICULTY_MULTIPLIER[difficulty] or 1

	local pool_weight = HeroChallenges._hero_pool[hero_name] or 0
	local bracket = math.max(pool_weight / CHALLENGES_WINRATE_WEIGHT_STEP - 1, 0)
	local winrate_bonus = CHALLENGE_REWARD_BONUS_FROM_BRACKET * bracket

	multiplier = multiplier + winrate_bonus

	base_reward.currency = math.ceil(base_reward.currency * multiplier / CURRENCY_REWARD_BOUNDARY) * CURRENCY_REWARD_BOUNDARY
	for item_name, count in pairs(base_reward.items or {}) do
		base_reward.items[item_name] = math.floor(count * multiplier)
	end

	return base_reward
end


--- Roll new challenges for a player
---@param player_id number
---@param count number
function HeroChallenges:RollChallengesForPlayer(player_id, count)
	-- record which challenges are in-use to avoid duplicates
	local current_challenge_combos = {}

	for _, challenge in pairs(HeroChallenges.challenges[player_id] or {}) do
		current_challenge_combos[challenge.hero_name] = challenge.challenge_type
	end

	local new_challenges = {}

	for i = 1, count do
		local hero_name = HeroChallenges:_RollHeroNameWeighted(current_challenge_combos)

		if hero_name then
			local challenge_type = HeroChallenges:_RollChallengeTypeForHero(hero_name, current_challenge_combos) -- roll appropriate challenge type for hero name
			local difficulty = HeroChallenges:_RollDifficulty(player_id) -- roll difficulty
			local target = HeroChallenges:GetTarget(hero_name, challenge_type, difficulty) -- fetch target from difficulty with per-hero bias/override

			table.insert(new_challenges, {
				id = -1,
				hero_name = hero_name,
				challenge_type = challenge_type,
				difficulty = difficulty,
				progress = 0,
				target = target,
				rewards = HeroChallenges:GetReward(hero_name, difficulty),
				completed = false,
			})

			-- record newly rolled challenge so subsequent new rolls won't be able to roll it too
			current_challenge_combos[hero_name] = challenge_type
		else
			DebugMessage("[Hero Challenges] failed to roll hero name for player", player_id)
		end
	end

	return new_challenges
end


--- Validate/sanitize challenge config
--- Make sure challenge type is valid, goal is valid, hero is valid etc etc
--- Invalid challenges are discarded - not tracked, not sent to client
---@param challenge BackendChallenge
---@return boolean
function HeroChallenges:ValidateChallenge(challenge)
	if not challenge.challenge_type or not challenge.hero_id then return false end

	local hero_name = GetHeroNameByID(challenge.hero_id)

	-- validate hero ID
	if not hero_name then return false end

	-- validate challenge type existance
	if not CHALLENGE_TYPE_LOOKUP[challenge.challenge_type] then return false end

	-- validate difficulty
	if not CHALLENGE_DIFFICULTY_LOOKUP[challenge.difficulty] then return false end

	-- validate if challenge type compatible with hero
	local challenges_definition = HERO_CHALLENGE_TYPES[hero_name]
	if not challenges_definition or not table.contains(challenges_definition.types, challenge.challenge_type) then return false end

	return true
end


--- Build hero challenge from base backend data and local definitions
---@param challenge BackendChallenge
---@return Challenge
function HeroChallenges:BuildHeroChallenge(challenge)
	local new_challenge = table.shallowcopy(challenge)

	new_challenge.hero_name = GetHeroNameByID(challenge.hero_id)
	new_challenge.progress = 0
	new_challenge.target = HeroChallenges:GetTarget(new_challenge.hero_name, challenge.challenge_type, challenge.difficulty)
	new_challenge.rewards = HeroChallenges:GetReward(new_challenge.hero_name, challenge.difficulty)

	return new_challenge
end


--- Submit newly generated challenges to backend - to serve cross-game
function HeroChallenges:SubmitChallengesToBackend()
	local new_challenges = {}

	-- prepare challenges for backend (add steam id)
	for player_id, rolled_challenges in pairs(HeroChallenges.pending_challenges) do
		for _, challenge in pairs(rolled_challenges) do
			table.insert(new_challenges, {
				steam_id = tostring(PlayerResource:GetSteamID(player_id)),
				hero_id = DOTAGameManager:GetHeroIDByName(challenge.hero_name),
				challenge_type = challenge.challenge_type,
				difficulty = challenge.difficulty,
				-- completed is always false for new challenges
			})
		end
	end

	if table.count(new_challenges) <= 0 then return end

	-- print("[Hero Challenges] submitting challenges to backend")
	-- DeepPrintTable(new_challenges)

	WebApi:Send(
		"api/lua/match/add_hero_challenges",
		{
			new_challenges = new_challenges,
		},
		function(data)
			HeroChallenges:EnableSubmittedChallenges(data)
		end,
		function(error)
			DebugMessage("[Hero Challenges] failed to submit backend challenges!", error)
		end
	)
end


--- Add newly rolled challenges to a pool of processed valid challenges
--- And assign IDs from database to submit completion in after-match properly
---@param data any
function HeroChallenges:EnableSubmittedChallenges(data)
	-- print("[Hero Challenges] successfully submitted challenges to backend")
	-- DeepPrintTable(data)

	for player_id, pending_player_challenges in pairs(HeroChallenges.pending_challenges) do
		-- print("[Hero Challenges] assigning IDs for pending challenges", player_id, table.count(pending_player_challenges))
		local steam_id = tostring(PlayerResource:GetSteamID(player_id))

		for index, challenge in pairs(pending_player_challenges) do
			for _, backend_challenge in pairs(data.new_challenges or {}) do
				if steam_id == backend_challenge.steam_id and challenge.hero_name == GetHeroNameByID(backend_challenge.hero_id)
				and challenge.challenge_type == backend_challenge.challenge_type and challenge.difficulty == backend_challenge.difficulty then
					pending_player_challenges[index].id = backend_challenge.id
				end
			end
		end

		table.extend(HeroChallenges.challenges[player_id], pending_player_challenges)
		HeroChallenges:SetClientChallenges(player_id)

		HeroChallenges.pending_challenges[player_id] = nil
	end
end


--- Save challenge progress, check for completion and disable tracking if challenge is done
function HeroChallenges:SubmitChallegeProgress(player_id, challenge, new_progress_value)
	challenge.progress = math.min(new_progress_value, challenge.target)

	if challenge.progress >= challenge.target then
		challenge.completed = true
		print("[Hero Challenges] completed challenge", player_id, challenge.hero_name, challenge.progress)
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "HeroChallenges:update_progress", {
		active_challenge = challenge
	})
end


function HeroChallenges:OnHeroInitFinished(event)
	local player_id = event.player_id
	local hero = event.hero
	if not IsValidEntity(hero) or not IsValidPlayerID(player_id) then return end

	local player_challenges = HeroChallenges.challenges[player_id] or {}
	local selected_hero_name = hero:GetUnitName()

	for _, challenge in pairs(player_challenges) do
		if challenge.hero_name == selected_hero_name and not challenge.completed then
			HeroChallenges.active_challenges[player_id] = challenge
			print("[Hero Challenges] challenge active", player_id, challenge.hero_name, challenge.id)

			HeroChallenges:SetClientChallenges(player_id)
			return
		end
	end

	print("[Hero Challenges] selected hero is not present in challenges or challenge is already completed", player_id, selected_hero_name)
end


function HeroChallenges:SetClientChallenges(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	-- print("[Hero Challenges] challenges client update", player_id)
	-- DeepPrintTable(HeroChallenges.challenges[player_id] or {})

	CustomGameEventManager:Send_ServerToPlayer(player, "HeroChallenges:set_challenges", {
		active_challenge = HeroChallenges.active_challenges[player_id] or {},
		challenges = HeroChallenges.challenges[player_id] or {}
	})
end

function HeroChallenges:PingProgress(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local active_challenge = HeroChallenges.active_challenges[player_id]
	if not active_challenge then return end

	local to_target = active_challenge.target -  math.floor(active_challenge.progress)

	if to_target > 0 then
		CustomChat:MessageToTeam(player_id, PlayerResource:GetTeam(player_id), "hero_challenges_ping_progress", {
			not_localize = {
				value = to_target,
			},
		}, nil, { challenge_type = active_challenge.challenge_type })
	else
		CustomChat:MessageToTeam(player_id, PlayerResource:GetTeam(player_id), "hero_challenges_ping_progress_completed")
	end
end


HeroChallenges:Init()