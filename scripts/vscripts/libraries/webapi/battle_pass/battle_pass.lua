--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


BattlePass = BattlePass or {}

require("libraries/webapi/battle_pass/rewards")

function BattlePass:Init()
	EventStream:Listen("BattlePass:get_rewards_data", BattlePass.SendRewardsData, BattlePass)
	EventStream:Listen("BattlePass:get_player_data", BattlePass.SendPlayerData, BattlePass)
	EventStream:Listen("BattlePass:redeem", BattlePass.RedeemRewardsEvent, BattlePass)

	BattlePass.rewards_data = {}
	BattlePass.players_data = {}

	BattlePass._redeem_in_progress = {}

	BattlePass:ProcessRewardsData()

	EventDriver:Listen("GameLoop:hero_init_finished", BattlePass.OnHeroInitFinished, BattlePass)
end

function BattlePass:SetExtraData(data)
	if not data then
		return
	end

	BattlePass.start_date = data.start_date
	BattlePass.end_date = data.end_date
	BattlePass.end_date_redeem_only = data.end_date_redeem_only
	BattlePass.current_level_from_date = data.current_level_from_date
	BattlePass.is_expired = data.is_expired

	for player_id, _ in pairs(BattlePass.players_data or {}) do
		BattlePass:ApplyItemFilters(player_id)
	end
end

function BattlePass:ApplyItemFilters(player_id)
	if not BattlePass.is_expired then
		return
	end

	print("Applying filters to player", player_id)

	for _, item_name in pairs(EXPIRED_ITEMS) do
		WebInventory:SetItemCount(player_id, item_name, 0)
	end
end

function BattlePass:ProcessRewardsData()
	-- remap rewards with extra details from item definitions and such

	for tier, rewards in pairs(BATTLE_PASS_REWARDS or {}) do
		BattlePass.rewards_data[tier] = {}

		for level, reward_data in pairs(rewards or {}) do
			BattlePass.rewards_data[tier][level] = {}

			if reward_data.item_name then
				local definition = WebInventory:GetItemDefinition(reward_data.item_name)
				if definition then
					BattlePass.rewards_data[tier][level] = {
						item_name = reward_data.item_name,
						count = reward_data.count,
						-- HINT: client might want extra data from definition for item
						--slot = definition.slot,
						--type = definition.type,
						--rarity = definition.rarity,
						-- for particles / models preview, this will go here
					}
				end
			end
			if reward_data.currency then
				BattlePass.rewards_data[tier][level].currency = reward_data.currency
			end
			if reward_data.items then
				BattlePass.rewards_data[tier][level].items = reward_data.items
			end
		end
	end
end

function BattlePass:SetPlayerData(player_id, data)
	BattlePass.players_data[player_id] = data

	print("[BattlePass] set player data for player", player_id)
	DeepPrintTable(data)

	BattlePass:UpdateClient(player_id)
end

function BattlePass:SendRewardsData(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then
		return
	end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "BattlePass:set_rewards_data", {
		bp_rewards_data = BattlePass.rewards_data or {},
	})
end

function BattlePass:SendPlayerData(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then
		return
	end

	BattlePass:UpdateClient(player_id)
end

function BattlePass:RedeemRewardsEvent(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then
		return
	end

	if BattlePass._redeem_in_progress[player_id] then
		DisplayError(player_id, "#dota_hud_error_webapi_request_in_progress")
		return
	end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))

	local currency = 0
	local redeemed_levels = {}
	local _temp_stacked_items = {}
	local has_redeemed_data = false
	local tiers_checks = {
		["0"] = true,
		["1"] = WebInventory:HasItem(player_id, "battle_pass_tier_2"),
	}

	local old_redeemed_levels = WebPlayer:GetBattlepassData(player_id)
		and WebPlayer:GetBattlepassData(player_id).redeemed_levels

	for tier, levels_data in pairs(event.redeemed_levels or {}) do
		if tiers_checks[tier] then
			redeemed_levels[tier] = {}
			for _, level in pairs(levels_data or {}) do
				local b_level_already_owned = old_redeemed_levels
					and old_redeemed_levels[tier]
					and old_redeemed_levels[tier][level]

				if tiers_checks[tier] and not b_level_already_owned and level <= BattlePass:GetLevelFromDate() then
					has_redeemed_data = true
					table.insert(redeemed_levels[tier], level)
					local reward = BATTLE_PASS_REWARDS[tier] and BATTLE_PASS_REWARDS[tier][level]

					if reward.currency then
						currency = currency + reward.currency
					end

					if reward and reward.item_name then
						_temp_stacked_items[reward.item_name] = (_temp_stacked_items[reward.item_name] or 0)
							+ (reward.count or 1)
					end
					if reward.items then
						for _, _item_data in pairs(reward.items) do
							if _item_data.item_name then
								_temp_stacked_items[_item_data.item_name] = (
									_temp_stacked_items[_item_data.item_name] or 0
								) + (_item_data.count or 1)
							end
						end
					end
				end
			end
		end
	end
	if not has_redeemed_data then
		return
	end

	local items = {}
	for item_name, count in pairs(_temp_stacked_items) do
		table.insert(items, {
			name = item_name,
			count = count,
		})
	end

	BattlePass._redeem_in_progress[player_id] = true

	WebApi:Send("api/lua/battle_pass/redeem", {
		steam_id = steam_id,
		redeemed_levels = redeemed_levels,
		currency = currency,
		items = items,
	}, function(response)
		BattlePass._redeem_in_progress[player_id] = nil
		BattlePass.players_data[player_id].redeemed_levels = response.redeemed_levels
		BattlePass:UpdateClient(player_id)

		print("[Battle Pass] successfully redeemed levels", player_id)
		DeepPrintTable(response)

		if response.currency then
			WebPlayer:SetCurrency(player_id, response.currency)
			WebPlayer:UpdateClient(player_id)
		end

		if response.new_items then
			for _, item in pairs(response.new_items) do
				WebInventory:AddItem(player_id, item)
			end
			WebInventory:UpdateClient(player_id)
		end
	end, function(err)
		BattlePass._redeem_in_progress[player_id] = nil
		print("[Battle Pass] failed to redeem levels", player_id)
	end)
end

function BattlePass:OnSubTierConsumableUsed(player_id, item_name, item_data, definition)
	local current_sub_tier = WebPlayer:GetSubscriptionTier(player_id)

	if current_sub_tier and current_sub_tier > 0 then
		-- add currency compensation if player already has active subscription
		WebPlayer:AddBackendCurrency(player_id, definition.compensation_value)
		return
	end

	local steam_id = tostring(PlayerResource:GetSteamID(player_id))
	WebApi:Send("api/lua/battle_pass/create_trial_subscription", {
		steam_id = steam_id,
	}, function(response)
		print("[Battle Pass] successfully created trial subscription", player_id)

		WebPlayer:SetSubscriptionStatus(player_id, response.subscription)
		WebPlayer:UpdateClient(player_id)

		Toasts:NewForPlayer(player_id, "sub_trial_started", response.subscription)
	end, function(err)
		print("[Battle Pass] failed to create trial subscription", player_id)
	end)
end

function BattlePass:OnDoubleMMRTokenConsumed(player_id, item_name, item_data, definition)
	EarlyConsumables:UseDoubleMMRToken(player_id)

	CustomChat:MessageToAll(player_id, "double_mmr_token_used", {})
	EarlyConsumables:SendEarlyConsumablesState(player_id)
end

function BattlePass:OnHeroInitFinished(event)
	if not IsValidPlayerID(event.player_id) or not IsValidEntity(event.hero) then
		return
	end

	local player_id = event.player_id
	local hero = event.hero

	-- show notification to players that have trial sub item, while not having ongoing sub - 5 seconds before they can move
	Timers:CreateTimer(PREGAME_TIME - 5, function()
		if not IsValidPlayerID(player_id) then
			return
		end

		if
			not WebInventory:HasItem(player_id, "bp_sub_tier_2_consumable")
			or WebPlayer:GetSubscriptionTier(player_id) > 0
		then
			return
		end

		Toasts:NewForPlayer(player_id, "sub_trial_available", {})
	end)
end

function BattlePass:GetLevelFromDate()
	return BattlePass.current_level_from_date or 0
end

function BattlePass:UpdateClient(player_id)
	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "BattlePass:update", {
		bp_player_data = BattlePass.players_data[player_id] or {},
		b_unlocked_extra_items = WebInventory:HasItem(player_id, "battle_pass_tier_2"),

		start_date = BattlePass.start_date,
		end_date = BattlePass.end_date,
		end_date_redeem_only = BattlePass.end_date_redeem_only,
		current_level_from_date = BattlePass:GetLevelFromDate(),
	})
end

function BattlePass:GetCurrentLevel(player_id)
	return (BattlePass.players_data[player_id] or {}).level or 0
end

function BattlePass:GetCurrentExp(player_id)
	return (BattlePass.players_data[player_id] or {}).current_exp or 0
end

function BattlePass:GetEarnedExp(player_id)
	return (BattlePass.players_data[player_id] or {}).earned_exp or 0
end

function BattlePass:GetRequiredExp(player_id)
	return (BattlePass.players_data[player_id] or {}).required_exp or 10000
end

function BattlePass:GetDailyExpLimit(player_id)
	return CONST_EXP_LIMIT_FROM_SUPPORTER[WebPlayer:GetSubscriptionTier(player_id)] or 0
end

function BattlePass:AddEarnedExp(player_id, added_exp)
	if not BattlePass.players_data[player_id] then
		return
	end

	BattlePass.players_data[player_id].earned_exp = (BattlePass.players_data[player_id].earned_exp or 0) + added_exp
end

function BattlePass:GetGloryLevelReward(current_level)
	return 1000
end

function BattlePass:SetCurrentExpFromValue(player_id, new_exp_value)
	local current_level = BattlePass:GetCurrentLevel(player_id)
	local required_exp = BattlePass:GetRequiredExp(player_id)

	local added_rewards = {
		currency = 0,
	}

	-- We didn't get player data from backend on game start by some reasons
	if not BattlePass.players_data[player_id] then
		return added_rewards
	end

	while new_exp_value >= required_exp do
		DebugMessage("[BP] leveling up", new_exp_value, required_exp, current_level)
		BattlePass.players_data[player_id].current_exp = new_exp_value - required_exp

		BattlePass.players_data[player_id].level = current_level + 1
		current_level = BattlePass.players_data[player_id].level

		new_exp_value = new_exp_value - required_exp
		required_exp = BattlePass:GetRequiredExp(player_id)

		local glory_reward = BattlePass:GetGloryLevelReward(current_level)
		DebugMessage(
			"[BP] new level",
			current_level,
			BattlePass.players_data[player_id].current_exp,
			glory_reward,
			fortune_reward
		)

		added_rewards.currency = added_rewards.currency + glory_reward

		WebPlayer:AddCurrency(player_id, glory_reward)
	end

	BattlePass.players_data[player_id].current_exp = new_exp_value

	BattlePass.players_data[player_id].required_exp = BattlePass:GetRequiredExp(player_id)
	BattlePass:UpdateClient(player_id)

	return added_rewards
end

BattlePass:Init()