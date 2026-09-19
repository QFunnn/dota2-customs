--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if Cases == nil then
	Cases = class({}) ---@class Cases
end

Cases.MaxOpenQuantity = 1
Cases.MaxBuyQuantity = 10

Cases.Rarity = {
	COMMON = "common",
	BLUE = "blue",
	GREEN = "green",
	GOLD = "gold",
	RED = "red",
}

Cases.RarityRank = {
	[Cases.Rarity.COMMON] = 0,
	[Cases.Rarity.BLUE] = 1,
	[Cases.Rarity.GREEN] = 2,
	[Cases.Rarity.GOLD] = 3,
	[Cases.Rarity.RED] = 4,
}

Cases.RarityByRank = {
	[0] = Cases.Rarity.COMMON,
	[1] = Cases.Rarity.BLUE,
	[2] = Cases.Rarity.GREEN,
	[3] = Cases.Rarity.GOLD,
	[4] = Cases.Rarity.RED,
}

Cases.Config = {
	summer_2026 = {
		id = "summer_2026",
		name = "#HUD_Cases_summer_2026_name",
		description = "#HUD_Cases_summer_2026_desc",
		cost = 600,
		rewards = {
			{ item_name = "legend", weight = 1, rarity = Cases.Rarity.RED },
			{ item_name = "templar_assassin_meld_focal_attack", weight = 2, rarity = Cases.Rarity.RED },

			{ item_name = "halloween_pumpkin", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "halloween_pumpkin_2", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "halloween_pumpkin_3", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "halloween_pumpkin_4", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "ti10_aegis", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "summer_2021_emblem", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "fall_2022_emblem", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "fall_2021_emblem", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "ti9_emblem", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "ti8_emblem", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "bane_slumber_nightmare", weight = 5, rarity = Cases.Rarity.GOLD },
			{ item_name = "omni_2021_immortal_buff_ring", weight = 8, rarity = Cases.Rarity.GOLD },
			{ item_name = "silencer_last_word_status_ti6", weight = 5, rarity = Cases.Rarity.GOLD },

			{ item_name = "invoker_kid_base_attack_all", weight = 4, rarity = Cases.Rarity.GOLD },

			{ item_name = "skywrath_aracana_attack", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "skywrath_aracana_v2_attack", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "viper_poison_attack_ti7", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "viper_poison_crimson_attack_ti7", weight = 10, rarity = Cases.Rarity.GREEN },
			{ item_name = "dark_willow_base_attack", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "dark_willow_shadow_attack", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "puck_aproset_attack", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "necrolyte_attack", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "attack_fall_2021", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "ti10_dire_tower_attack", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "ti10_dire_tower_cyan_attack", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "dark_willow_willowisp_base_attack", weight = 12, rarity = Cases.Rarity.GREEN },
			{ item_name = "black_dragon_attack", weight = 16, rarity = Cases.Rarity.GREEN },
			{ item_name = "dragon_knight_elder_dragon_attack_black", weight = 14, rarity = Cases.Rarity.GREEN },
			{ item_name = "oracle_ti10_immortal_purifyingflames", weight = 16, rarity = Cases.Rarity.GREEN },

			{ item_name = "desolation_attack", weight = 26, rarity = Cases.Rarity.BLUE },
			{ item_name = "ice_attack", weight = 26, rarity = Cases.Rarity.BLUE },
			{ item_name = "poison_attack", weight = 20, rarity = Cases.Rarity.BLUE },
			{ item_name = "lion_base_attack", weight = 26, rarity = Cases.Rarity.BLUE },
			{ item_name = "mirana_solar_blessing_attack", weight = 25, rarity = Cases.Rarity.BLUE },
			{ item_name = "lightning_attack", weight = 25, rarity = Cases.Rarity.BLUE },
			{ item_name = "rubick_wandering_attack", weight = 22, rarity = Cases.Rarity.BLUE },
			{ item_name = "dire_tower_2021_attack", weight = 20, rarity = Cases.Rarity.BLUE },
			{ item_name = "dire_tower_2022_attack", weight = 20, rarity = Cases.Rarity.BLUE },
			{ item_name = "radiant_tower_2021_attack", weight = 20, rarity = Cases.Rarity.BLUE },
			{ item_name = "radiant_tower_2022_attack", weight = 20, rarity = Cases.Rarity.BLUE },
			{ item_name = "warlock_base_attack", weight = 22, rarity = Cases.Rarity.BLUE },
			{ item_name = "witch_doctor_ribbitar_ward_attack", weight = 22, rarity = Cases.Rarity.BLUE },
			{ item_name = "newbloom", weight = 22, rarity = Cases.Rarity.BLUE },

			{ item_name = "catapult_attack", weight = 32, rarity = Cases.Rarity.COMMON },
			{ item_name = "chaos_attack", weight = 32, rarity = Cases.Rarity.COMMON },
			{ item_name = "fire_attack", weight = 32, rarity = Cases.Rarity.COMMON },
			{ item_name = "winter_wyvern_arctic_attack", weight = 32, rarity = Cases.Rarity.COMMON },
			{ item_name = "io_calavera_attack", weight = 32, rarity = Cases.Rarity.COMMON },
			{ item_name = "wind_attack", weight = 32, rarity = Cases.Rarity.COMMON },

			{ currency = 8000, weight = 3, rarity = Cases.Rarity.RED },
			{ currency = 2800, weight = 5, rarity = Cases.Rarity.GOLD },
			{ currency = 800, weight = 16, rarity = Cases.Rarity.GREEN },
			{ currency = 320, weight = 22, rarity = Cases.Rarity.BLUE },
			{ currency = 140, weight = 26, rarity = Cases.Rarity.BLUE },
			{ currency = 95, weight = 30, rarity = Cases.Rarity.COMMON },
			{ currency = 50, weight = 34, rarity = Cases.Rarity.COMMON },
		},
	},
}

function Cases:Init()
	if self.bStarted then
		return
	end

	self.bStarted = true
	self.enabled = true
	self.playerCases = {} ---@type table<PlayerID, table<string, integer>>
	self.pendingRewards = {} ---@type table<PlayerID, table<integer, any>>
	self.nextRewardId = 0

	GameListener:SubscribeProtected("cases_buy", function(event)
		self:OnBuyCase(event)
	end)
	GameListener:SubscribeProtected("cases_open", function(event)
		self:OnOpenCase(event)
	end)
	GameListener:SubscribeProtected("cases_claim_reward", function(event)
		self:OnClaimReward(event)
	end)
	GameListener:SubscribeProtected("cases_dust_reward", function(event)
		self:OnDustReward(event)
	end)

	self:SyncState()
end

function Cases:GetItemInfo(itemName)
	return Shop and Shop.ItemsCatalog and Shop.ItemsCatalog[itemName] or ITEMS_LIST[itemName]
end

function Cases:GetDustCost(itemName)
	local itemInfo = self:GetItemInfo(itemName)
	return math.max(0, math.floor(tonumber(itemInfo and itemInfo.dust_cost) or 0))
end

function Cases:GetRewardRarity(reward)
	local rawRarity = reward and reward.rarity
	local rarity = type(rawRarity) == "string" and string.lower(rawRarity) or nil
	local rank = self.RarityRank[rarity]
	if rank == nil then
		local itemLabel = reward and (reward.item_name or tostring(reward.currency)) or "unknown"
		print(
			string.format(
				"[Cases] Invalid or missing rarity for reward '%s', fallback to rarity_rank/common",
				tostring(itemLabel)
			)
		)
		rank = math.floor(tonumber(reward and reward.rarity_rank) or 0)
	end
	rank = math.max(0, math.min(4, rank))

	return self.RarityByRank[rank] or "common", rank
end

function Cases:GetPlayerCaseCount(playerId, caseId)
	return self.playerCases[playerId] and self.playerCases[playerId][caseId] or 0
end

function Cases:NormalizeCaseCount(value)
	local count = math.floor(tonumber(value) or 0)
	return math.max(0, count)
end

function Cases:SetPlayerCases(playerId, casesById)
	self.playerCases[playerId] = {}

	if type(casesById) ~= "table" then
		self:SyncState()
		return
	end

	for caseId, count in pairs(casesById) do
		if type(caseId) == "string" and self.Config[caseId] ~= nil then
			self.playerCases[playerId][caseId] = self:NormalizeCaseCount(count)
		end
	end

	self:SyncState()
end

function Cases:BuildBackendSnapshot(playerId)
	local snapshot = {}
	for caseId, _ in pairs(self.Config or {}) do
		snapshot[caseId] = self:GetPlayerCaseCount(playerId, caseId)
	end
	return snapshot
end

function Cases:AddPlayerCases(playerId, caseId, quantity)
	self.playerCases[playerId] = self.playerCases[playerId] or {}
	self.playerCases[playerId][caseId] = self:GetPlayerCaseCount(playerId, caseId) + quantity
end

function Cases:SpendPlayerCases(playerId, caseId, quantity)
	local current = self:GetPlayerCaseCount(playerId, caseId)
	if quantity <= 0 or current < quantity then
		return false
	end

	self.playerCases[playerId][caseId] = self:NormalizeCaseCount(current - quantity)
	return true
end

function Cases:BuildRewardsForNetTable(caseInfo)
	local rewards = {}
	local totalWeight = 0
	for _, reward in ipairs(caseInfo.rewards or {}) do
		totalWeight = totalWeight + math.max(0, tonumber(reward.weight) or 0)
	end

	for _, reward in ipairs(caseInfo.rewards or {}) do
		local itemInfo = self:GetItemInfo(reward.item_name) or {}
		local weight = math.max(0, tonumber(reward.weight) or 0)
		local rarity, rarityRank = self:GetRewardRarity(reward)
		table.insert(rewards, {
			item_name = reward.item_name or "",
			currency = math.floor(tonumber(reward.currency) or 0),
			weight = weight,
			rarity = rarity,
			rarity_rank = rarityRank,
			dust_cost = reward.item_name and self:GetDustCost(reward.item_name) or 0,
			case_exclusive = (itemInfo.case_exclusive == true or itemInfo.case_exclusive == 1) and 1 or 0,
		})
	end

	return rewards
end

function Cases:SyncState()
	local cases = {}
	local playerCases = {}
	for playerId, casesById in pairs(self.playerCases or {}) do
		playerCases[tostring(playerId)] = casesById
	end

	for caseId, caseInfo in pairs(self.Config or {}) do
		table.insert(cases, {
			id = caseId,
			name = caseInfo.name,
			description = caseInfo.description,
			cost = caseInfo.cost,
			rewards = self:BuildRewardsForNetTable(caseInfo),
		})
	end

	CustomNetTables:SetTableValue("cases", "state", {
		enabled = self.enabled and 1 or 0,
		cases = cases,
		player_cases = playerCases,
	})
end

function Cases:RollReward(caseInfo)
	local totalWeight = 0
	for _, reward in ipairs(caseInfo.rewards or {}) do
		totalWeight = totalWeight + math.max(0, tonumber(reward.weight) or 0)
	end

	if totalWeight <= 0 then
		return nil
	end

	local roll = RandomFloat(0, totalWeight)
	local cursor = 0
	for _, reward in ipairs(caseInfo.rewards or {}) do
		cursor = cursor + math.max(0, tonumber(reward.weight) or 0)
		if roll <= cursor then
			return reward
		end
	end

	return caseInfo.rewards[#caseInfo.rewards]
end

function Cases:CreatePendingReward(playerId, reward)
	self.nextRewardId = (self.nextRewardId or 0) + 1
	local rarity, rarityRank = self:GetRewardRarity(reward)
	self.pendingRewards[playerId] = self.pendingRewards[playerId] or {}
	self.pendingRewards[playerId][self.nextRewardId] = {
		reward_id = self.nextRewardId,
		item_name = reward.item_name,
		currency = math.floor(tonumber(reward.currency) or 0),
		rarity = rarity,
		rarity_rank = rarityRank,
	}
	return self.nextRewardId
end

function Cases:OnBuyCase(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self.enabled or not Shop or not Shop.IsShopAvailable or not Shop:IsShopAvailable(playerId) then
		return
	end

	local caseId = event.case_id
	local caseInfo = type(caseId) == "string" and self.Config[caseId] or nil
	if not caseInfo then
		return
	end

	local quantity = math.floor(tonumber(event.quantity) or 1)
	quantity = math.max(1, math.min(self.MaxBuyQuantity, quantity))

	local totalCost = (tonumber(caseInfo.cost) or 0) * quantity
	if not Shop:SpendCoins(playerId, totalCost) then
		return
	end

	self:AddPlayerCases(playerId, caseId, quantity)
	self:SyncState()

	if Shop.ScheduleInventorySave then
		Shop:ScheduleInventorySave(playerId)
	end
end

function Cases:OnOpenCase(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self.enabled or not Shop or not Shop.IsShopAvailable or not Shop:IsShopAvailable(playerId) then
		return
	end

	local caseId = event.case_id
	local caseInfo = type(caseId) == "string" and self.Config[caseId] or nil
	if not caseInfo then
		return
	end

	local quantity = 1
	if not self:SpendPlayerCases(playerId, caseId, quantity) then
		return
	end

	local resultRewards = {}
	local projectedOwned = {}
	for _ = 1, quantity do
		local reward = self:RollReward(caseInfo)
		local itemInfo = reward and reward.item_name and self:GetItemInfo(reward.item_name) or nil
		if reward and (reward.currency or itemInfo) then
			local rewardId = self:CreatePendingReward(playerId, reward)
			local canClaim = reward.item_name ~= nil
				and not Shop:PlayerHasItem(playerId, reward.item_name)
				and projectedOwned[reward.item_name] ~= true
			if canClaim then
				projectedOwned[reward.item_name] = true
			end
			table.insert(resultRewards, {
				reward_id = rewardId,
				item_name = reward.item_name or "",
				currency = math.floor(tonumber(reward.currency) or 0),
				rarity = self.pendingRewards[playerId][rewardId].rarity,
				rarity_rank = self.pendingRewards[playerId][rewardId].rarity_rank,
				dust_cost = reward.item_name and self:GetDustCost(reward.item_name) or 0,
				case_exclusive = itemInfo and (itemInfo.case_exclusive == true or itemInfo.case_exclusive == 1) and 1
					or 0,
				can_claim = canClaim and 1 or 0,
			})
		end
	end

	self:SyncState()

	if Shop.ScheduleInventorySave then
		Shop:ScheduleInventorySave(playerId)
	end

	local player = PlayerResource:GetPlayer(playerId)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "cases_open_result", {
			case_id = caseId,
			rewards = resultRewards,
		})
	end
end

function Cases:ResolvePendingReward(playerId, rewardId)
	local pending = self.pendingRewards[playerId]
	if not pending then
		return nil
	end

	local reward = pending[rewardId]
	if reward then
		pending[rewardId] = nil
	end
	return reward
end

function Cases:OnClaimReward(event)
	local playerId = tonumber(event.PlayerID)
	local rewardId = math.floor(tonumber(event.reward_id) or 0)
	if playerId == nil or playerId < 0 or rewardId <= 0 then
		return
	end
	if not Shop or not Shop.IsShopAvailable or not Shop:IsShopAvailable(playerId) then
		return
	end

	local reward = self.pendingRewards[playerId] and self.pendingRewards[playerId][rewardId]
	if not reward then
		return
	end

	local currency = math.floor(tonumber(reward.currency) or 0)
	if currency > 0 then
		self:ResolvePendingReward(playerId, rewardId)
		Shop:AddCoins(playerId, currency)
	else
		if
			type(reward.item_name) ~= "string"
			or reward.item_name == ""
			or Shop:PlayerHasItem(playerId, reward.item_name)
		then
			return
		end
		self:ResolvePendingReward(playerId, rewardId)
		Shop:AddOwnedItem(playerId, reward.item_name)
		Shop:SyncPlayerInventory(playerId)
	end

	if Shop.ScheduleInventorySave then
		Shop:ScheduleInventorySave(playerId)
	end
end

function Cases:OnDustReward(event)
	local playerId = tonumber(event.PlayerID)
	local rewardId = math.floor(tonumber(event.reward_id) or 0)
	if playerId == nil or playerId < 0 or rewardId <= 0 then
		return
	end
	if not Shop or not Shop.IsShopAvailable or not Shop:IsShopAvailable(playerId) then
		return
	end

	local reward = self:ResolvePendingReward(playerId, rewardId)
	if not reward then
		return
	end

	local currency = math.floor(tonumber(reward.currency) or 0)
	if currency > 0 then
		Shop:AddCoins(playerId, currency)
	else
		local dustCost = self:GetDustCost(reward.item_name)
		if dustCost > 0 then
			Shop:AddCoins(playerId, dustCost)
		end
	end
	if Shop.ScheduleInventorySave then
		Shop:ScheduleInventorySave(playerId)
	end
end