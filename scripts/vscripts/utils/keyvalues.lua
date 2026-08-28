--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


KEYVALUES_VERSION = "1.00"

-- Change to false to skip loading the base files
LOAD_BASE_FILES = true

--[[
    Simple Lua KeyValues library
    Author: Martin Noya // github.com/MNoya
    Installation:
    - require this file inside your code
    Usage:
    - Your npc custom files will be validated on require, error will occur if one is missing or has faulty syntax.
    - This allows to safely grab key-value definitions in npc custom abilities/items/units/heroes
    
        "some_custom_entry"
        {
            "CustomName" "Barbarian"
            "CustomKey"  "1"
            "CustomStat" "100 200"
        }
        With a handle:
            handle:GetKeyValue() -- returns the whole table based on the handles baseclass
            handle:GetKeyValue("CustomName") -- returns "Barbarian"
            handle:GetKeyValue("CustomKey")  -- returns 1 (number)
            handle:GetKeyValue("CustomStat") -- returns "100 200" (string)
            handle:GetKeyValue("CustomStat", 2) -- returns 200 (number)
        
        Same results with strings:
            GetKeyValue("some_custom_entry")
            GetKeyValue("some_custom_entry", "CustomName")
            GetKeyValue("some_custom_entry", "CustomStat")
            GetKeyValue("some_custom_entry", "CustomStat", 2)
    - Ability Special value grabbing:
        "some_custom_ability"
        {
            "AbilitySpecial"
            {
                "01"
                {
                    "var_type"    "FIELD_INTEGER"
                    "some_key"    "-3 -4 -5"
                }
            }
        }
        With a handle:
            ability:GetAbilitySpecial("some_key") -- returns based on the level of the ability/item
        With string:
            GetAbilitySpecial("some_custom_ability", "some_key")    -- returns "-3 -4 -5" (string)
            GetAbilitySpecial("some_custom_ability", "some_key", 2) -- returns -4 (number)
    Notes:
    - In case a key can't be matched, the returned value will be nil
    - Don't identify your custom units/heroes with the same name or it will only grab one of them.
]]

if not KeyValues then
	KeyValues = {}
end

local split = function(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	i = 1
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

local SHOP_RECIPE_NET_TABLE = "common"
local SHOP_RECIPE_MANIFEST_KEY = "shop_recipe_manifest"
local SHOP_RECIPE_CHUNK_PREFIX = "shop_recipe_chunk_"
local SHOP_RECIPE_CHUNK_SIZE = 7000
local SHOP_ITEM_COST_MANIFEST_KEY = "shop_item_cost_manifest"
local SHOP_ITEM_COST_CHUNK_PREFIX = "shop_item_cost_chunk_"
local SHOP_STOCK_KEY_PREFIX = "shop_stock_"
local SHOP_STOCK_UPDATE_INTERVAL = 0.5
local SHOP_PURCHASE_EVENT = "custom_shop_purchase_item"
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

-- Load all the necessary key value files
function LoadGameKeyValues()
	local scriptPath = "scripts/npc/"
	local override = LoadKeyValues(scriptPath .. "npc_abilities_override.txt")
	local files = {
		AbilityKV = { base = "npc_abilities", custom = "npc_abilities_custom" },
		ItemKV = { base = "items", custom = "npc_items_custom" },
		UnitKV = { base = "npc_units", custom = "npc_units_custom" },
		HeroKV = { base = "npc_heroes", custom = "npc_heroes_custom" },
	}

	-- Load and validate the files
	for k, v in pairs(files) do
		local file = {}
		if LOAD_BASE_FILES then
			file = LoadKeyValues(scriptPath .. v.base .. ".txt")
		end

		-- Replace main game keys by any match on the override file
		for k, v in pairs(override) do
			if file[k] then
				file[k] = v
			end
		end

		local custom_file = LoadKeyValues(scriptPath .. v.custom .. ".txt")
		if custom_file then
			for k, v in pairs(custom_file) do
				file[k] = v
			end
		else
			print("[KeyValues] Critical Error on " .. v.custom .. ".txt")
			return
		end

		GameRules[k] = file --backwards compatibility
		KeyValues[k] = file
	end

	-- Merge All KVs
	KeyValues.All = {}
	for name, path in pairs(files) do
		for key, value in pairs(KeyValues[name]) do
			if not KeyValues.All[key] then
				KeyValues.All[key] = value
			end
		end
	end

	-- Merge units and heroes (due to them sharing the same class CDOTA_BaseNPC)
	for key, value in pairs(KeyValues.HeroKV) do
		if not KeyValues.UnitKV[key] then
			KeyValues.UnitKV[key] = value
		else
			if type(KeyValues.All[key]) == "table" then
				print("[KeyValues] Warning: Duplicated unit/hero entry for " .. key)
			end
		end
	end
end

local function isPurchasableItem(itemName)
	local itemData = KeyValues.ItemKV and KeyValues.ItemKV[itemName]
	if type(itemData) ~= "table" then
		return itemName == AGHANIMS_BLESSING_RECIPE or itemName == AGHANIMS_BLESSING_ITEM
	end
	return tonumber(itemData.ItemPurchasable or 1) ~= 0
end

function KeyValues:BuildShopRecipeData()
	self.ShopRecipesByResult = {}
	self.ShopUpgradeResultsByComponent = {}

	for recipeName, itemData in pairs(self.ItemKV or {}) do
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
	for itemName, itemData in pairs(self.ItemKV or {}) do
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
					local recipeData = type(recipeName) == "string" and self.ItemKV[recipeName] or nil
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

	local shopConfig = getShopConfig()
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

function KeyValues:BuildShopStockDefinitions()
	self.ShopStockDefinitions = {}
	self.ShopStockEpoch = self.ShopStockEpoch or 0
	self.ShopStockByTeam = self.ShopStockByTeam or {}
	self.ShopStockVersions = self.ShopStockVersions or {}
	self.ShopStockPublished = self.ShopStockPublished or {}

	for itemName, _ in pairs(self.ShopAllowedItems or {}) do
		local itemData = self.ItemKV and self.ItemKV[itemName]
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

function KeyValues:BuildShopItemCostData()
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
	local changed = false
	state.count = math.max(0, math.min(definition.max, math.floor(tonumber(state.count) or definition.initial)))

	while state.count < definition.max and state.nextRestockAt ~= nil and state.nextRestockAt <= now do
		state.count = state.count + 1
		changed = true
		if state.count < definition.max and definition.stockTime > 0 then
			state.nextRestockAt = state.nextRestockAt + definition.stockTime
		else
			state.nextRestockAt = nil
		end
	end
	return changed
end

function KeyValues:EnsureTeamShopStock(teamNumber)
	teamNumber = tonumber(teamNumber)
	if teamNumber == nil then
		return nil, false
	end

	local teamState = self.ShopStockByTeam[teamNumber]
	local changed = false
	if teamState == nil then
		teamState = {}
		self.ShopStockByTeam[teamNumber] = teamState
		changed = true
	end

	local now = getShopTime()
	for itemName, definition in pairs(self.ShopStockDefinitions or {}) do
		local itemState = teamState[itemName]
		if itemState == nil then
			itemState = createShopStockItemState(definition, self.ShopStockEpoch or now)
			teamState[itemName] = itemState
			changed = true
		end
		if refreshShopStockItemState(itemState, definition, now) then
			changed = true
		end
	end
	return teamState, changed
end

function KeyValues:PublishTeamShopStock(teamNumber, force)
	teamNumber = tonumber(teamNumber)
	if teamNumber == nil then
		return
	end
	local teamState, changed = self:EnsureTeamShopStock(teamNumber)
	if teamState == nil or (not force and not changed and self.ShopStockPublished[teamNumber]) then
		return
	end

	self.ShopStockVersions[teamNumber] = (self.ShopStockVersions[teamNumber] or 0) + 1
	local items = {}
	for itemName, definition in pairs(self.ShopStockDefinitions or {}) do
		local itemState = teamState[itemName]
		items[itemName] = {
			c = itemState.count,
			m = definition.max,
			n = itemState.nextRestockAt or -1,
		}
	end
	CustomNetTables:SetTableValue(SHOP_RECIPE_NET_TABLE, SHOP_STOCK_KEY_PREFIX .. tostring(teamNumber), {
		v = self.ShopStockVersions[teamNumber],
		t = getShopTime(),
		items = items,
	})
	self.ShopStockPublished[teamNumber] = true
end

function KeyValues:RefreshConnectedShopStocks(force)
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
		self:PublishTeamShopStock(teamNumber, force)
	end
end

function KeyValues:GetPurchaseStockRequirements(purchasePlan, itemName)
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

function KeyValues:HasPurchaseStock(teamNumber, requirements)
	local teamState = self:EnsureTeamShopStock(teamNumber)
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

function KeyValues:ConsumeShopStock(teamNumber, itemName, count)
	local definition = self.ShopStockDefinitions[itemName]
	if definition == nil then
		return
	end
	local teamState = self:EnsureTeamShopStock(teamNumber)
	local itemState = teamState and teamState[itemName]
	if itemState == nil then
		return
	end

	itemState.count = math.max(0, itemState.count - math.max(0, tonumber(count) or 0))
	if itemState.count < definition.max and itemState.nextRestockAt == nil and definition.stockTime > 0 then
		itemState.nextRestockAt = getShopTime() + definition.stockTime
	end
end

function KeyValues:PublishShopRecipeData(recipes)
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

function KeyValues:PublishShopItemCostData(itemCosts)
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

function KeyValues:BuildShopPurchasePlan(hero, itemName)
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

function KeyValues:PurchaseShopItem(eventData)
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
		self:PublishTeamShopStock(teamNumber, true)
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
				self:PublishTeamShopStock(teamNumber, true)
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
				self:PublishTeamShopStock(teamNumber, true)
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
		self:PublishTeamShopStock(teamNumber, true)
	end
end

function KeyValues:InitializeCustomShop(reloadKeyValues)
	if reloadKeyValues then
		LoadGameKeyValues()
	end
	local recipes = self:BuildShopRecipeData()
	local itemCosts = self:BuildShopItemCostData()
	self:BuildShopStockDefinitions()
	self:PublishShopRecipeData(recipes)
	self:PublishShopItemCostData(itemCosts)
	self:RefreshConnectedShopStocks(true)
	GameTimerEvent(SHOP_STOCK_UPDATE_INTERVAL, function()
		self:RefreshConnectedShopStocks(false)
		return SHOP_STOCK_UPDATE_INTERVAL
	end)
	CustomUIEvent(SHOP_PURCHASE_EVENT, function(_, eventData)
		self:PurchaseShopItem(eventData)
	end)
end

-- Works for heroes and units on the same table due to merging both tables on game init
function CDOTA_BaseNPC:GetKeyValue(key, level)
	if level then
		return GetUnitKV(self:GetUnitName(), key, level)
	else
		return GetUnitKV(self:GetUnitName(), key)
	end
end

-- Dynamic version of CDOTABaseAbility:GetAbilityKeyValues()
function CDOTABaseAbility:GetKeyValue(key, level)
	if level then
		return GetAbilityKV(self:GetAbilityName(), key, level)
	else
		return GetAbilityKV(self:GetAbilityName(), key)
	end
end

-- Item version
function CDOTA_Item:GetKeyValue(key, level)
	if level then
		return GetItemKV(self:GetAbilityName(), key, level)
	else
		return GetItemKV(self:GetAbilityName(), key)
	end
end

function CDOTABaseAbility:GetAbilitySpecial(key)
	return GetAbilitySpecial(self:GetAbilityName(), key, self:GetLevel())
end

-- Global functions
-- Key is optional, returns the whole table by omission
-- Level is optional, returns the whole value by omission
function GetKeyValue(name, key, level, tbl)
	local t = tbl or KeyValues.All[name]
	if key and t then
		if t[key] and level then
			local s = split(t[key])
			if s[level] then
				return tonumber(s[level]) or s[level] -- Try to cast to number
			else
				return tonumber(s[#s]) or s[#s]
			end
		else
			return t[key]
		end
	else
		return t
	end
end

function GetUnitKV(unitName, key, level)
	return GetKeyValue(unitName, key, level, KeyValues.UnitKV[unitName])
end

function GetAbilityKV(abilityName, key, level)
	return GetKeyValue(abilityName, key, level, KeyValues.AbilityKV[abilityName])
end

function GetItemKV(itemName, key, level)
	return GetKeyValue(itemName, key, level, KeyValues.ItemKV[itemName])
end

function GetAbilitySpecial(name, key, level)
	local t = KeyValues.All[name]
	if key and t then
		local tspecial = t["AbilitySpecial"]
		if tspecial then
			-- Find the key we are looking for
			for _, values in pairs(tspecial) do
				if values[key] then
					if not level then
						return values[key]
					else
						local s = split(values[key])
						if s[level] then
							return tonumber(s[level]) -- If we match the level, return that one
						else
							return tonumber(s[#s])
						end -- Otherwise, return the max
					end
					break
				end
			end
		end
	else
		return t
	end
end

if not KeyValues.All then
	LoadGameKeyValues()
end