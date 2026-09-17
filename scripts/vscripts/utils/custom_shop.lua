--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


-- Custom shop recipes, item costs, team stock, and purchases.
require("utils/keyvalues")
local JSON = require("utils/json")

local CustomShop = {}

local SHOP_RECIPE_NET_TABLE = "common"
local SHOP_RECIPE_MANIFEST_KEY = "shop_recipe_manifest"
local SHOP_RECIPE_CHUNK_PREFIX = "shop_recipe_chunk_"
local SHOP_RECIPE_CHUNK_SIZE = 7000
local SHOP_ITEM_COST_MANIFEST_KEY = "shop_item_cost_manifest"
local SHOP_ITEM_COST_CHUNK_PREFIX = "shop_item_cost_chunk_"
local SHOP_CONFIG_MANIFEST_KEY = "shop_config_manifest"
local SHOP_CONFIG_CHUNK_PREFIX = "shop_config_chunk_"
local SHOP_STATE_REQUEST_EVENT = "custom_shop_request_state"
local SHOP_STATE_EVENT = "custom_shop_state"
local SHOP_RESTOCK_TIMER_NAME = "CustomShopRestock"
local SHOP_PURCHASE_EVENT = "custom_shop_purchase_item"
local SHOP_PURCHASE_SUCCESS_EVENT = "custom_shop_purchase_success"
local PHYSICAL_SHOP_TYPES = { 0, 1, 2, 3, 4, 5, 6 }
local AGHANIMS_SCEPTER_ITEM = "item_ultimate_scepter"
local AGHANIMS_BLESSING_RECIPE = "item_recipe_ultimate_scepter_2"
local AGHANIMS_BLESSING_ITEM = "item_ultimate_scepter_2"
local AGHANIMS_BLESSING_RECIPE_COST = 1600

local function trim(value)
	return string.gsub(string.gsub(tostring(value or ""), "^%s+", ""), "%s+$", "")
end

local function copyTable(source)
	local result = {}
	for key, value in pairs(source or {}) do
		result[key] = value
	end
	return result
end

local function getShopTime()
	if GameRules ~= nil and type(GameRules.GetDOTATime) == "function" then
		return math.max(0, tonumber(GameRules:GetDOTATime(false, false)) or 0)
	end
	if GameRules ~= nil and type(GameRules.GetGameTime) == "function" then
		return tonumber(GameRules:GetGameTime()) or 0
	end
	return 0
end

local function isNearPhysicalShop(hero)
	if not IsValid(hero) or type(hero.IsInRangeOfShop) ~= "function" then
		return false
	end
	for _, shopType in ipairs(PHYSICAL_SHOP_TYPES) do
		local succeeded, inRange = pcall(hero.IsInRangeOfShop, hero, shopType, true)
		if succeeded and inRange == true then
			return true
		end
	end
	return false
end

local function isLoneDruidSpiritBear(unit)
	if not IsValid(unit) or type(unit.GetUnitName) ~= "function" then
		return false
	end
	return string.match(unit:GetUnitName(), "^npc_dota_lone_druid_bear%d*$") ~= nil
end

local function resolveShopPurchaseTarget(playerID, hero, eventData)
	local targetEntIndex = eventData.purchase_target_entindex
	if targetEntIndex == nil then
		return hero
	end
	if type(targetEntIndex) ~= "number" or targetEntIndex < 0 or targetEntIndex ~= math.floor(targetEntIndex) then
		return nil
	end
	if targetEntIndex == eventData.hero_entindex then
		return hero
	end

	local succeeded, target = pcall(EntIndexToHScript, targetEntIndex)
	if
		not succeeded
		or not IsValid(target)
		or type(target.GetPlayerOwnerID) ~= "function"
		or target:GetPlayerOwnerID() ~= playerID
		or not isLoneDruidSpiritBear(target)
	then
		return nil
	end
	if type(target.IsIllusion) == "function" and target:IsIllusion() then
		return nil
	end
	return target
end

local function getSortedKeys(source)
	local keys = {}
	for key, _ in pairs(source or {}) do
		table.insert(keys, key)
	end
	table.sort(keys, function(left, right)
		local leftNumber = tonumber(left)
		local rightNumber = tonumber(right)
		if leftNumber ~= nil and rightNumber ~= nil then
			return leftNumber < rightNumber
		end
		return tostring(left) < tostring(right)
	end)
	return keys
end

local function getItemCostFromKV(itemName)
	local itemData = KeyValues.ItemKV and KeyValues.ItemKV[itemName]
	local itemCost = itemData and tonumber(itemData.ItemCost) or nil
	if itemCost == nil and type(GetItemCost) == "function" then
		local succeeded, engineCost = pcall(GetItemCost, itemName)
		if succeeded then
			itemCost = tonumber(engineCost)
		end
	end
	return math.max(0, itemCost or 0)
end

local function parseItemRequirements(requirementString)
	local requirements = {}
	if type(requirementString) ~= "string" then
		return requirements
	end

	for token in string.gmatch(requirementString, "([^;]+)") do
		-- Valve recipes occasionally append '*' metadata to an item name.
		-- It is not part of the actual ability name used to create the item.
		local itemName = trim(string.gsub(token, "%*", ""))
		if string.match(itemName, "^item_[%w_]+$") then
			table.insert(requirements, itemName)
		end
	end
	return requirements
end

local function getRequirementsCost(requirements, recipeCost)
	local totalCost = recipeCost or 0
	for _, itemName in ipairs(requirements or {}) do
		totalCost = totalCost + getItemCostFromKV(itemName)
	end
	return totalCost
end

local function encodeRequirements(requirements)
	local counts = {}
	local order = {}
	for _, itemName in ipairs(requirements or {}) do
		if counts[itemName] == nil then
			counts[itemName] = 0
			table.insert(order, itemName)
		end
		counts[itemName] = counts[itemName] + 1
	end

	local encoded = {}
	for _, itemName in ipairs(order) do
		local count = counts[itemName]
		table.insert(encoded, count > 1 and (itemName .. "*" .. tostring(count)) or itemName)
	end
	return table.concat(encoded, ",")
end

local function getShopConfig()
	local config = LoadKeyValues("scripts/npc/kv/custom_shop_items.kv") or {}
	return config.CustomShopItems or config
end

local function getActiveShopProfile(config)
	local profiles = config and config.profiles or {}
	local mapName = type(GetMapName) == "function" and GetMapName() or ""
	local candidates = {
		mapName,
		string.gsub(mapName, "^custom_chaos_", ""),
		string.gsub(mapName, "_v%d+$", ""),
	}

	for _, candidate in ipairs(candidates) do
		if profiles[candidate] ~= nil then
			return profiles[candidate]
		end
	end
	for profileName, profile in pairs(profiles) do
		if string.sub(mapName, -string.len(profileName)) == profileName then
			return profile
		end
	end
	return profiles[tostring(config.default_profile or "")] or {}
end

local function collectProfileItems(profile)
	local result = {}
	for _, category in pairs(profile or {}) do
		if type(category) == "table" then
			for _, itemName in pairs(category) do
				if type(itemName) == "string" and string.match(itemName, "^item_[%w_]+$") then
					result[itemName] = true
				end
			end
		end
	end
	return result
end

local function isPurchasableItem(itemName)
	local itemData = KeyValues.ItemKV and KeyValues.ItemKV[itemName]
	if type(itemData) ~= "table" then
		return itemName == AGHANIMS_BLESSING_RECIPE or itemName == AGHANIMS_BLESSING_ITEM
	end
	return tonumber(itemData.ItemPurchasable or 1) ~= 0
end

function CustomShop:BuildShopRecipeData(shopConfig)
	self.ShopRecipesByResult = {}
	self.ShopUpgradeResultsByComponent = {}

	for recipeName, itemData in pairs(KeyValues.ItemKV or {}) do
		if type(itemData) == "table" and tonumber(itemData.ItemRecipe) == 1 then
			local resultName = itemData.ItemResult
			if type(resultName) ~= "string" and string.match(recipeName, "^item_recipe_") then
				resultName = "item_" .. string.sub(recipeName, string.len("item_recipe_") + 1)
			end

			if type(resultName) == "string" and string.match(resultName, "^item_[%w_]+$") then
				local requirements = {}
				if type(itemData.ItemRequirements) == "table" then
					for _, requirementKey in ipairs(getSortedKeys(itemData.ItemRequirements)) do
						local requirementSet = parseItemRequirements(itemData.ItemRequirements[requirementKey])
						if #requirementSet > 0 then
							table.insert(requirements, requirementSet)
						end
					end
				elseif type(itemData.ItemRequirements) == "string" then
					local requirementSet = parseItemRequirements(itemData.ItemRequirements)
					if #requirementSet > 0 then
						table.insert(requirements, requirementSet)
					end
				end

				local recipeCost = math.max(0, tonumber(itemData.ItemCost) or 0)
				if #requirements > 0 then
					local minimumRequirements = requirements[1]
					local minimumCost = getRequirementsCost(minimumRequirements, recipeCost)
					for requirementIndex = 2, #requirements do
						local candidate = requirements[requirementIndex]
						local candidateCost = getRequirementsCost(candidate, recipeCost)
						if candidateCost < minimumCost then
							minimumRequirements = candidate
							minimumCost = candidateCost
						end
					end

					local recipe = {
						recipeName = recipeName,
						resultName = resultName,
						cost = recipeCost,
						requirements = requirements,
						minimumRequirements = minimumRequirements,
						totalCost = minimumCost,
					}
					self.ShopRecipesByResult[resultName] = self.ShopRecipesByResult[resultName] or {}
					table.insert(self.ShopRecipesByResult[resultName], recipe)
				end
			end
		end
	end

	local blessingRecipes = self.ShopRecipesByResult[AGHANIMS_BLESSING_ITEM] or {}
	local blessingRecipe = nil
	for _, recipe in ipairs(blessingRecipes) do
		if recipe.recipeName == AGHANIMS_BLESSING_RECIPE then
			blessingRecipe = recipe
			break
		end
	end
	if blessingRecipe == nil then
		local minimumRequirements = { AGHANIMS_SCEPTER_ITEM }
		local recipeCost = getItemCostFromKV(AGHANIMS_BLESSING_RECIPE)
		if recipeCost <= 0 then
			recipeCost = AGHANIMS_BLESSING_RECIPE_COST
		end
		blessingRecipe = {
			recipeName = AGHANIMS_BLESSING_RECIPE,
			resultName = AGHANIMS_BLESSING_ITEM,
			cost = recipeCost,
			requirements = { minimumRequirements },
			minimumRequirements = minimumRequirements,
			totalCost = getRequirementsCost(minimumRequirements, recipeCost),
			upgradeLevel = 2,
		}
		self.ShopRecipesByResult[AGHANIMS_BLESSING_ITEM] = blessingRecipes
		table.insert(blessingRecipes, blessingRecipe)
	else
		blessingRecipe.upgradeLevel = math.max(2, tonumber(blessingRecipe.upgradeLevel) or 0)
	end

	local scepterUpgrades = self.ShopUpgradeResultsByComponent[AGHANIMS_SCEPTER_ITEM] or {}
	local hasBlessingUpgrade = false
	for _, resultName in ipairs(scepterUpgrades) do
		if resultName == AGHANIMS_BLESSING_ITEM then
			hasBlessingUpgrade = true
			break
		end
	end
	if not hasBlessingUpgrade then
		table.insert(scepterUpgrades, AGHANIMS_BLESSING_ITEM)
	end
	self.ShopUpgradeResultsByComponent[AGHANIMS_SCEPTER_ITEM] = scepterUpgrades

	-- Multi-level items such as Dagon do not define a separate ItemRecipe for
	-- every level. Their KV instead links consecutive ItemBaseLevel entries
	-- through UpgradeRecipe, so expose those links as normal shop recipes.
	local upgradeGroups = {}
	for itemName, itemData in pairs(KeyValues.ItemKV or {}) do
		if type(itemData) == "table" then
			local itemLevel = tonumber(itemData.ItemBaseLevel)
			local maxUpgradeLevel = tonumber(itemData.MaxUpgradeLevel)
			if itemLevel ~= nil and itemLevel >= 1 and maxUpgradeLevel ~= nil and maxUpgradeLevel > 1 then
				local baseName = itemName
				if itemLevel > 1 then
					local levelSuffix = "_" .. tostring(itemLevel)
					if string.sub(itemName, -string.len(levelSuffix)) == levelSuffix then
						baseName = string.sub(itemName, 1, string.len(itemName) - string.len(levelSuffix))
					else
						baseName = nil
					end
				end

				if baseName ~= nil then
					local group = upgradeGroups[baseName]
					if group == nil then
						group = { maxLevel = maxUpgradeLevel, levels = {} }
						upgradeGroups[baseName] = group
					end
					if group.maxLevel == maxUpgradeLevel then
						group.levels[itemLevel] = { name = itemName, data = itemData }
					end
				end
			end
		end
	end

	for baseName, group in pairs(upgradeGroups) do
		local baseEntry = group.levels[1]
		if baseEntry ~= nil and baseEntry.name == baseName then
			for itemLevel = 2, group.maxLevel do
				local previousEntry = group.levels[itemLevel - 1]
				local currentEntry = group.levels[itemLevel]
				if previousEntry ~= nil and currentEntry ~= nil and isPurchasableItem(currentEntry.name) then
					local recipeName = previousEntry.data.UpgradeRecipe or baseEntry.data.UpgradeRecipe
					local recipeData = type(recipeName) == "string" and KeyValues.ItemKV[recipeName] or nil
					if
						type(recipeData) == "table"
						and tonumber(recipeData.ItemRecipe) == 1
						and isPurchasableItem(recipeName)
					then
						local recipeCost = math.max(0, tonumber(recipeData.ItemCost) or 0)
						local minimumRequirements = { previousEntry.name }
						local recipe = {
							recipeName = recipeName,
							resultName = currentEntry.name,
							cost = recipeCost,
							requirements = { minimumRequirements },
							minimumRequirements = minimumRequirements,
							totalCost = getRequirementsCost(minimumRequirements, recipeCost),
							upgradeLevel = itemLevel,
						}
						self.ShopRecipesByResult[currentEntry.name] = self.ShopRecipesByResult[currentEntry.name] or {}
						table.insert(self.ShopRecipesByResult[currentEntry.name], recipe)
						self.ShopUpgradeResultsByComponent[previousEntry.name] = self.ShopUpgradeResultsByComponent[previousEntry.name]
							or {}
						table.insert(self.ShopUpgradeResultsByComponent[previousEntry.name], currentEntry.name)
					end
				end
			end
		end
	end

	local networkRecipes = {}
	for resultName, recipes in pairs(self.ShopRecipesByResult) do
		table.sort(recipes, function(left, right)
			if left.totalCost ~= right.totalCost then
				return left.totalCost < right.totalCost
			end
			return left.recipeName < right.recipeName
		end)
		local recipe = recipes[1]
		table.insert(networkRecipes, {
			resultName = resultName,
			recipeName = recipe.recipeName,
			cost = recipe.cost,
			requirements = recipe.minimumRequirements,
			upgradeLevel = recipe.upgradeLevel or 0,
		})
	end
	table.sort(networkRecipes, function(left, right)
		return left.resultName < right.resultName
	end)

	shopConfig = shopConfig or getShopConfig()
	self.ShopAllowedItems = collectProfileItems(getActiveShopProfile(shopConfig))
	local function includeRecipeItems(itemName, visiting)
		if visiting[itemName] then
			return
		end
		visiting[itemName] = true
		for _, recipe in ipairs(self.ShopRecipesByResult[itemName] or {}) do
			if recipe.cost > 0 and isPurchasableItem(recipe.recipeName) then
				self.ShopAllowedItems[recipe.recipeName] = true
			end
			for _, requirementSet in ipairs(recipe.requirements) do
				for _, componentName in ipairs(requirementSet) do
					if isPurchasableItem(componentName) then
						self.ShopAllowedItems[componentName] = true
						includeRecipeItems(componentName, visiting)
					end
				end
			end
		end
		for _, resultName in ipairs(self.ShopUpgradeResultsByComponent[itemName] or {}) do
			if isPurchasableItem(resultName) then
				self.ShopAllowedItems[resultName] = true
				includeRecipeItems(resultName, visiting)
			end
		end
		visiting[itemName] = nil
	end
	for itemName, _ in pairs(copyTable(self.ShopAllowedItems)) do
		includeRecipeItems(itemName, {})
	end

	self.ShopNetworkRecipes = networkRecipes
	return networkRecipes
end

function CustomShop:BuildShopStockDefinitions()
	self.ShopStockDefinitions = {}
	self.ShopStockEpoch = self.ShopStockEpoch or 0
	self.ShopStockByTeam = self.ShopStockByTeam or {}
	self.ShopStockVersions = self.ShopStockVersions or {}
	self.ShopStockDirty = self.ShopStockDirty or {}

	for itemName, _ in pairs(self.ShopAllowedItems or {}) do
		local itemData = KeyValues.ItemKV and KeyValues.ItemKV[itemName]
		local stockMax = type(itemData) == "table" and tonumber(itemData.ItemStockMax) or nil
		if stockMax ~= nil and stockMax > 0 then
			stockMax = math.max(1, math.floor(stockMax))
			local stockInitial = tonumber(itemData.ItemStockInitial)
			if stockInitial == nil then
				stockInitial = stockMax
			end
			stockInitial = math.max(0, math.min(stockMax, math.floor(stockInitial)))

			local stockTime = math.max(0, tonumber(itemData.ItemStockTime) or 0)
			local initialStockTime = tonumber(itemData.ItemInitialStockTime)
			if initialStockTime == nil or initialStockTime <= 0 then
				initialStockTime = stockTime
			end
			self.ShopStockDefinitions[itemName] = {
				max = stockMax,
				initial = stockInitial,
				stockTime = stockTime,
				initialStockTime = math.max(0, initialStockTime),
			}
		end
	end
end

function CustomShop:BuildShopItemCostData()
	local itemCosts = {}
	for itemName, _ in pairs(self.ShopAllowedItems or {}) do
		table.insert(itemCosts, {
			itemName = itemName,
			cost = getItemCostFromKV(itemName),
		})
	end
	table.sort(itemCosts, function(left, right)
		return left.itemName < right.itemName
	end)
	self.ShopNetworkItemCosts = itemCosts
	return itemCosts
end

local function createShopStockItemState(definition, stockEpoch)
	local state = {
		count = definition.initial,
		nextRestockAt = nil,
	}
	if state.count < definition.max and definition.initialStockTime > 0 then
		state.nextRestockAt = stockEpoch + definition.initialStockTime
	end
	return state
end

local function refreshShopStockItemState(state, definition, now)
	local previousCount = state.count
	local previousRestockAt = state.nextRestockAt
	state.count = math.max(0, math.min(definition.max, math.floor(tonumber(state.count) or definition.initial)))
	if state.count >= definition.max then
		state.nextRestockAt = nil
	end

	while state.count < definition.max and state.nextRestockAt ~= nil and state.nextRestockAt <= now do
		state.count = state.count + 1
		if state.count < definition.max and definition.stockTime > 0 then
			state.nextRestockAt = state.nextRestockAt + definition.stockTime
		else
			state.nextRestockAt = nil
		end
	end
	return state.count ~= previousCount or state.nextRestockAt ~= previousRestockAt
end

function CustomShop:EnsureTeamShopStock(teamNumber)
	teamNumber = tonumber(teamNumber)
	if teamNumber == nil or teamNumber < 2 then
		return nil
	end

	local teamState = self.ShopStockByTeam[teamNumber]
	if teamState == nil then
		teamState = {}
		self.ShopStockByTeam[teamNumber] = teamState
	end
	local dirty = self.ShopStockDirty[teamNumber] or {}
	self.ShopStockDirty[teamNumber] = dirty

	for itemName, _ in pairs(teamState) do
		if self.ShopStockDefinitions[itemName] == nil then
			teamState[itemName] = nil
			dirty[itemName] = true
		end
	end

	local now = getShopTime()
	for itemName, definition in pairs(self.ShopStockDefinitions or {}) do
		local itemState = teamState[itemName]
		if itemState == nil then
			itemState = createShopStockItemState(definition, self.ShopStockEpoch or now)
			teamState[itemName] = itemState
			dirty[itemName] = true
		end
		if refreshShopStockItemState(itemState, definition, now) then
			dirty[itemName] = true
		end
	end
	return teamState
end

local function encodeShopStockItem(itemState)
	-- A negative count removes an obsolete stock definition after a KV reload.
	return { c = itemState and itemState.count or -1, n = itemState and itemState.nextRestockAt or -1 }
end

function CustomShop:ScheduleShopRestock()
	local nextRestockAt = nil
	-- Shop time stays at zero before the horn. Arm the timer from the game
	-- state event so a long pregame never becomes a stock polling loop.
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		for _, teamState in pairs(self.ShopStockByTeam) do
			for _, itemState in pairs(teamState) do
				local deadline = itemState.nextRestockAt
				if deadline ~= nil and (nextRestockAt == nil or deadline < nextRestockAt) then
					nextRestockAt = deadline
				end
			end
		end
	end
	if nextRestockAt == self.ShopRestockAt then
		return
	end
	self.ShopRestockAt = nextRestockAt
	if self.ShopRestockInCallback then
		return
	end
	local gameMode = GameRules:GetGameModeEntity()
	gameMode:StopTimer(SHOP_RESTOCK_TIMER_NAME)
	if nextRestockAt == nil then
		return
	end
	local previousDeadline = nextRestockAt
	gameMode:GameTimer(SHOP_RESTOCK_TIMER_NAME, math.max(0, nextRestockAt - getShopTime()), function()
		self.ShopRestockInCallback = true
		self:RefreshConnectedShopStocks()
		self.ShopRestockInCallback = false
		if self.ShopRestockAt ~= nil then
			-- Rearm the existing think at the next actual stock deadline.
			local delay = math.max(0, self.ShopRestockAt - previousDeadline)
			previousDeadline = self.ShopRestockAt
			return delay
		end
	end)
end

function CustomShop:PublishTeamShopStock(teamNumber)
	teamNumber = tonumber(teamNumber)
	local teamState = self:EnsureTeamShopStock(teamNumber)
	if teamState == nil then
		return nil
	end
	local dirty = self.ShopStockDirty[teamNumber]
	local items = {}
	for itemName, _ in pairs(dirty) do
		items[itemName] = encodeShopStockItem(teamState[itemName])
	end
	if next(items) ~= nil then
		self.ShopStockDirty[teamNumber] = {}
		self.ShopStockVersions[teamNumber] = (self.ShopStockVersions[teamNumber] or 0) + 1
		local payload = { team = teamNumber, v = self.ShopStockVersions[teamNumber], full = 0, items = items }
		local maxPlayers = (_G.DOTA_MAX_PLAYERS or _G.DOTA_MAX_TEAM_PLAYERS or 24) - 1
		for playerID = 0, maxPlayers do
			if PlayerResource:IsValidPlayerID(playerID) and PlayerResource:GetTeam(playerID) == teamNumber then
				local player = PlayerResource:GetPlayer(playerID)
				if player ~= nil then
					CustomGameEventManager:Send_ServerToPlayer(player, SHOP_STATE_EVENT, payload)
				end
			end
		end
	end
	self:ScheduleShopRestock()
	return teamState
end

function CustomShop:RefreshConnectedShopStocks()
	local teams = {}
	for teamNumber, _ in pairs(self.ShopStockByTeam or {}) do
		teams[teamNumber] = true
	end

	local maxPlayers = (_G.DOTA_MAX_PLAYERS or _G.DOTA_MAX_TEAM_PLAYERS or 24) - 1
	for playerID = 0, maxPlayers do
		if PlayerResource:IsValidPlayerID(playerID) then
			local teamNumber = PlayerResource:GetTeam(playerID)
			if type(teamNumber) == "number" and teamNumber >= 2 then
				teams[teamNumber] = true
			end
		end
	end
	for teamNumber, _ in pairs(teams) do
		self:PublishTeamShopStock(teamNumber)
	end
end

function CustomShop:SendShopState(eventData)
	-- The engine supplies PlayerID; never accept a client-selected player/team.
	-- A snapshot does not require a hero, which may not exist during UI startup.
	local playerID = GetClientEventPlayerID(eventData)
	if playerID == nil then
		return
	end
	local player = PlayerResource:GetPlayer(playerID)
	local teamNumber = PlayerResource:GetTeam(playerID)
	if player == nil or type(teamNumber) ~= "number" or teamNumber < 2 then
		return
	end
	local teamState = self:PublishTeamShopStock(teamNumber)
	local items = {}
	for itemName, itemState in pairs(teamState) do
		items[itemName] = encodeShopStockItem(itemState)
	end
	CustomGameEventManager:Send_ServerToPlayer(player, SHOP_STATE_EVENT, {
		team = teamNumber,
		v = self.ShopStockVersions[teamNumber] or 0,
		full = 1,
		items = items,
	})
end

function CustomShop:GetPurchaseStockRequirements(purchasePlan, itemName)
	local requirements = {}
	for _, entry in ipairs(purchasePlan.items or {}) do
		if self.ShopStockDefinitions[entry.name] ~= nil then
			requirements[entry.name] = (requirements[entry.name] or 0) + 1
		end
	end
	if self.ShopStockDefinitions[itemName] ~= nil and requirements[itemName] == nil then
		requirements[itemName] = 1
	end
	return requirements
end

function CustomShop:HasPurchaseStock(teamNumber, requirements)
	local teamState = self:PublishTeamShopStock(teamNumber)
	if teamState == nil then
		return false
	end
	for itemName, requiredCount in pairs(requirements or {}) do
		local itemState = teamState[itemName]
		if itemState == nil or (itemState.count or 0) < requiredCount then
			return false
		end
	end
	return true
end

function CustomShop:ConsumeShopStock(teamNumber, itemName, count)
	local definition = self.ShopStockDefinitions[itemName]
	if definition == nil then
		return
	end
	local teamState = self:EnsureTeamShopStock(teamNumber)
	local itemState = teamState and teamState[itemName]
	if itemState == nil then
		return
	end

	local previousCount = itemState.count
	local previousRestockAt = itemState.nextRestockAt
	itemState.count = math.max(0, itemState.count - math.max(0, tonumber(count) or 0))
	if itemState.count < definition.max and itemState.nextRestockAt == nil and definition.stockTime > 0 then
		itemState.nextRestockAt = getShopTime() + definition.stockTime
	end
	if itemState.count ~= previousCount or itemState.nextRestockAt ~= previousRestockAt then
		self.ShopStockDirty[teamNumber][itemName] = true
	end
end

function CustomShop:PublishShopConfigData(shopConfig)
	local categories = JSON:newArray()
	local profile = {}
	local activeProfile = getActiveShopProfile(shopConfig)
	for categoryID, category in pairs(shopConfig.categories or {}) do
		local items = activeProfile[categoryID]
		if type(items) == "table" then
			local orderedItems = JSON:newArray()
			for _, itemKey in ipairs(getSortedKeys(items)) do
				table.insert(orderedItems, items[itemKey])
			end
			profile[categoryID] = orderedItems
			table.insert(categories, {
				id = categoryID,
				title = category.title or "#DOTA_Shop_Category_Shop",
				tab = category.tab or "basic",
				order = tonumber(category.order) or 0,
			})
		end
	end
	table.sort(categories, function(left, right)
		if left.order ~= right.order then
			return left.order < right.order
		end
		return left.id < right.id
	end)
	local itemIDs = {}
	for itemName, itemID in pairs(shopConfig.item_ids or {}) do
		itemIDs[itemName] = tonumber(itemID)
	end
	local data = JSON:encode({
		categories = categories,
		profile = profile,
		itemIds = itemIDs,
		stockDefinitions = self.ShopStockDefinitions,
	})
	local oldManifest = CustomNetTables:GetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_CONFIG_MANIFEST_KEY) or {}
	local version = (tonumber(oldManifest.v) or 0) + 1
	local chunkCount = 0
	local offset = 1
	while offset <= string.len(data) do
		local lastByte = math.min(offset + SHOP_RECIPE_CHUNK_SIZE - 1, string.len(data))
		-- Each net-table string must remain valid UTF-8 on its own.
		while lastByte < string.len(data) do
			local nextByte = string.byte(data, lastByte + 1)
			if nextByte < 128 or nextByte >= 192 then
				break
			end
			lastByte = lastByte - 1
		end
		chunkCount = chunkCount + 1
		CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_CONFIG_CHUNK_PREFIX .. tostring(chunkCount), {
			v = version,
			d = string.sub(data, offset, lastByte),
		})
		offset = lastByte + 1
	end
	for chunkIndex = chunkCount + 1, tonumber(oldManifest.c) or 0 do
		CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_CONFIG_CHUNK_PREFIX .. tostring(chunkIndex), nil)
	end
	CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_CONFIG_MANIFEST_KEY, { v = version, c = chunkCount })
end

function CustomShop:PublishShopRecipeData(recipes)
	local oldManifest = CustomNetTables:GetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_RECIPE_MANIFEST_KEY) or {}
	local oldChunkCount = tonumber(oldManifest.c) or 0
	local chunks = {}
	local currentLines = {}
	local currentLength = 0

	for _, recipe in ipairs(recipes or {}) do
		local line = table.concat({
			recipe.resultName,
			recipe.recipeName,
			tostring(recipe.cost),
			encodeRequirements(recipe.requirements),
			tostring(recipe.upgradeLevel or 0),
		}, "#")
		local addedLength = string.len(line) + (#currentLines > 0 and 1 or 0)
		if currentLength > 0 and currentLength + addedLength > SHOP_RECIPE_CHUNK_SIZE then
			table.insert(chunks, table.concat(currentLines, "\n"))
			currentLines = {}
			currentLength = 0
			addedLength = string.len(line)
		end
		table.insert(currentLines, line)
		currentLength = currentLength + addedLength
	end
	if #currentLines > 0 then
		table.insert(chunks, table.concat(currentLines, "\n"))
	end

	local payloadBytes = 0
	for chunkIndex, chunk in ipairs(chunks) do
		payloadBytes = payloadBytes + string.len(chunk)
		CustomNetTables:SetTableValue(
			SHOP_RECIPE_NET_TABLE,
			SHOP_RECIPE_CHUNK_PREFIX .. tostring(chunkIndex),
			{ d = chunk }
		)
	end
	for chunkIndex = #chunks + 1, oldChunkCount do
		CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_RECIPE_CHUNK_PREFIX .. tostring(chunkIndex), nil)
	end

	CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_RECIPE_MANIFEST_KEY, {
		v = (tonumber(oldManifest.v) or 0) + 1,
		c = #chunks,
		r = #(recipes or {}),
	})
	print(
		string.format(
			"[CustomShop] Published %d recipes in %d chunks (%d bytes)",
			#(recipes or {}),
			#chunks,
			payloadBytes
		)
	)
end

function CustomShop:PublishShopItemCostData(itemCosts)
	local oldManifest = CustomNetTables:GetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_ITEM_COST_MANIFEST_KEY) or {}
	local oldChunkCount = tonumber(oldManifest.c) or 0
	local chunks = {}
	local currentLines = {}
	local currentLength = 0

	for _, itemCost in ipairs(itemCosts or {}) do
		local line = table.concat({
			itemCost.itemName,
			tostring(itemCost.cost),
		}, "#")
		local addedLength = string.len(line) + (#currentLines > 0 and 1 or 0)
		if currentLength > 0 and currentLength + addedLength > SHOP_RECIPE_CHUNK_SIZE then
			table.insert(chunks, table.concat(currentLines, "\n"))
			currentLines = {}
			currentLength = 0
			addedLength = string.len(line)
		end
		table.insert(currentLines, line)
		currentLength = currentLength + addedLength
	end
	if #currentLines > 0 then
		table.insert(chunks, table.concat(currentLines, "\n"))
	end

	local payloadBytes = 0
	for chunkIndex, chunk in ipairs(chunks) do
		payloadBytes = payloadBytes + string.len(chunk)
		CustomNetTables:SetTableValue(
			SHOP_RECIPE_NET_TABLE,
			SHOP_ITEM_COST_CHUNK_PREFIX .. tostring(chunkIndex),
			{ d = chunk }
		)
	end
	for chunkIndex = #chunks + 1, oldChunkCount do
		CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_ITEM_COST_CHUNK_PREFIX .. tostring(chunkIndex), nil)
	end

	CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_ITEM_COST_MANIFEST_KEY, {
		v = (tonumber(oldManifest.v) or 0) + 1,
		c = #chunks,
		r = #(itemCosts or {}),
	})
	print(
		string.format(
			"[CustomShop] Published %d item costs in %d chunks (%d bytes)",
			#(itemCosts or {}),
			#chunks,
			payloadBytes
		)
	)
end

local function getOwnedItemCounts(hero)
	local counts = {}
	local lastSlot = _G.DOTA_STASH_SLOT_6 or 14
	for slot = 0, lastSlot do
		local item = hero:GetItemInSlot(slot)
		if IsValid(item) and type(item.GetAbilityName) == "function" then
			local combineLocked = false
			if type(item.IsCombineLocked) == "function" then
				local succeeded, locked = pcall(item.IsCombineLocked, item)
				combineLocked = succeeded and locked == true
			end
			if not combineLocked then
				local itemName = item:GetAbilityName()
				counts[itemName] = (counts[itemName] or 0) + 1
			end
		end
	end
	return counts
end

local function copyPlan(plan)
	local result = {}
	for _, entry in ipairs(plan or {}) do
		table.insert(result, entry)
	end
	return result
end

function CustomShop:BuildShopPurchasePlan(hero, itemName)
	local ownedCounts = getOwnedItemCounts(hero)

	local function planItem(targetName, availableCounts, useOwnedItem, visiting, depth)
		if depth > 16 then
			return {
				cost = getItemCostFromKV(targetName),
				items = { { name = targetName, cost = getItemCostFromKV(targetName) } },
				counts = availableCounts,
			}
		end

		if useOwnedItem and (availableCounts[targetName] or 0) > 0 then
			local nextCounts = copyTable(availableCounts)
			nextCounts[targetName] = nextCounts[targetName] - 1
			return { cost = 0, items = {}, counts = nextCounts }
		end

		if visiting[targetName] then
			return nil
		end
		local recipes = self.ShopRecipesByResult[targetName]
		if recipes == nil or #recipes == 0 then
			local cost = getItemCostFromKV(targetName)
			return {
				cost = cost,
				items = { { name = targetName, cost = cost } },
				counts = copyTable(availableCounts),
			}
		end

		local nextVisiting = copyTable(visiting)
		nextVisiting[targetName] = true
		local bestPlan = nil
		for _, recipe in ipairs(recipes) do
			for _, requirementSet in ipairs(recipe.requirements) do
				local candidate = {
					cost = 0,
					items = {},
					counts = copyTable(availableCounts),
				}
				local valid = true
				for _, componentName in ipairs(requirementSet) do
					local componentPlan = planItem(componentName, candidate.counts, true, nextVisiting, depth + 1)
					if componentPlan == nil then
						valid = false
						break
					end
					candidate.cost = candidate.cost + componentPlan.cost
					candidate.counts = componentPlan.counts
					for _, entry in ipairs(componentPlan.items) do
						table.insert(candidate.items, entry)
					end
				end

				if valid and recipe.cost > 0 then
					if (candidate.counts[recipe.recipeName] or 0) > 0 then
						candidate.counts[recipe.recipeName] = candidate.counts[recipe.recipeName] - 1
					else
						candidate.cost = candidate.cost + recipe.cost
						table.insert(candidate.items, { name = recipe.recipeName, cost = recipe.cost })
					end
				end

				if
					valid
					and (
						bestPlan == nil
						or candidate.cost < bestPlan.cost
						or (candidate.cost == bestPlan.cost and #candidate.items < #bestPlan.items)
					)
				then
					bestPlan = {
						cost = candidate.cost,
						items = copyPlan(candidate.items),
						counts = copyTable(candidate.counts),
					}
				end
			end
		end
		return bestPlan
	end

	return planItem(itemName, ownedCounts, false, {}, 0)
end

local function sendShopError(playerID, message)
	local player = PlayerResource:GetPlayer(playerID)
	if player ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", { message = message })
	end
end

function CustomShop:PurchaseShopItem(eventData)
	if type(eventData) ~= "table" or type(eventData.item_name) ~= "string" then
		return
	end
	local playerID, hero = VerifyClientEventHeroOwner(eventData)
	if playerID == nil or not IsValid(hero) then
		return
	end
	if not CheckClientEventRateLimit(playerID, SHOP_PURCHASE_EVENT, 0.04) then
		return
	end

	local itemName = eventData.item_name
	if
		string.len(itemName) > 96
		or not string.match(itemName, "^item_[%w_]+$")
		or not self.ShopAllowedItems[itemName]
		or not isPurchasableItem(itemName)
	then
		return
	end
	if hero:IsIllusion() or hero:IsTempestDouble() or not hero:IsRealHero() then
		return
	end
	local purchaseTarget = resolveShopPurchaseTarget(playerID, hero, eventData)
	if not IsValid(purchaseTarget) then
		return
	end
	if not isNearPhysicalShop(purchaseTarget) then
		sendShopError(playerID, "custom_shop_error_too_far")
		return
	end

	local purchasePlan = self:BuildShopPurchasePlan(purchaseTarget, itemName)
	if purchasePlan == nil then
		return
	end

	local teamNumber = purchaseTarget:GetTeamNumber()
	local stockRequirements = self:GetPurchaseStockRequirements(purchasePlan, itemName)
	if not self:HasPurchaseStock(teamNumber, stockRequirements) then
		sendShopError(playerID, "custom_shop_error_out_of_stock")
		return
	end
	if PlayerResource:GetGold(playerID) < purchasePlan.cost then
		sendShopError(playerID, "dota_hud_error_not_enough_gold")
		return
	end

	local consumedStock = {}
	for _, entry in ipairs(purchasePlan.items) do
		local item = CreateItem(entry.name, purchaseTarget, hero)
		if not IsValid(item) then
			if next(consumedStock) ~= nil then
				self:PublishTeamShopStock(teamNumber)
			end
			sendShopError(playerID, "dota_hud_error_inventory_full")
			return
		end
		if type(item.SetPurchaser) == "function" then
			item:SetPurchaser(hero)
		end
		if type(item.SetPurchaseTime) == "function" then
			item:SetPurchaseTime(GameRules:GetGameTime())
		end

		local addedItem = purchaseTarget:AddItem(item)
		if addedItem == nil then
			if IsValid(item) then
				UTIL_Remove(item)
			end
			if next(consumedStock) ~= nil then
				self:PublishTeamShopStock(teamNumber)
			end
			sendShopError(playerID, "dota_hud_error_inventory_full")
			return
		end

		if self.ShopStockDefinitions[entry.name] ~= nil then
			self:ConsumeShopStock(teamNumber, entry.name, 1)
			consumedStock[entry.name] = (consumedStock[entry.name] or 0) + 1
		end

		if entry.cost > 0 then
			hero:SpendGold(entry.cost, DOTA_ModifyGold_PurchaseItem)
		end
		FireGameEvent("dota_item_purchased", {
			PlayerID = playerID,
			itemname = entry.name,
			itemcost = entry.cost,
		})
	end

	if self.ShopStockDefinitions[itemName] ~= nil and consumedStock[itemName] == nil then
		self:ConsumeShopStock(teamNumber, itemName, 1)
		consumedStock[itemName] = 1
	end
	if next(stockRequirements) ~= nil then
		self:PublishTeamShopStock(teamNumber)
	end

	local player = PlayerResource:GetPlayer(playerID)
	if player ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(player, SHOP_PURCHASE_SUCCESS_EVENT, {})
	end
end

function CustomShop:Initialize(reloadKeyValues)
	if reloadKeyValues then
		LoadGameKeyValues()
	end
	local shopConfig = getShopConfig()
	local recipes = self:BuildShopRecipeData(shopConfig)
	local itemCosts = self:BuildShopItemCostData()
	self:BuildShopStockDefinitions()
	self:PublishShopRecipeData(recipes)
	self:PublishShopItemCostData(itemCosts)
	self:PublishShopConfigData(shopConfig)
	GameRules:GetGameModeEntity():StopTimer(SHOP_RESTOCK_TIMER_NAME)
	self.ShopRestockAt = nil
	self.ShopRestockInCallback = false
	table.insert(TimerEventListenerIDs, SHOP_RESTOCK_TIMER_NAME)
	self:RefreshConnectedShopStocks()
	GameEvent("game_rules_state_change", function()
		self:RefreshConnectedShopStocks()
	end)
	CustomUIEvent(SHOP_STATE_REQUEST_EVENT, function(_, eventData)
		self:SendShopState(eventData)
	end)
	CustomUIEvent(SHOP_PURCHASE_EVENT, function(_, eventData)
		self:PurchaseShopItem(eventData)
	end)
end

return CustomShop