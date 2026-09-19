--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


require("mechanics.shop_items_config")

if Shop == nil then
	Shop = class({}) ---@class Shop
end

---@alias PlayerID integer
---@alias ItemName string
---@alias ItemSlotName string

---@class OwnedItem
---@field item_name ItemName

---@class PlayerInventory
---@field ownedMap table<ItemName, boolean> -- item_name -> has item
---@field slots table<ItemSlotName, ItemName|"" > -- equipped items by slot

---@class Shop
---@field Loaded boolean
---@field PlayerInventories table<PlayerID, PlayerInventory>
---@field PlayerCoins table<PlayerID, integer>
---@field PlayerBalanceChanges table<PlayerID, integer>
---@field ItemsCatalog table<ItemName, any>
---@field PromoCooldowns table<PlayerID, number>
---@field PromoRequestTokens table<PlayerID, string>
---@field PromoRequestStartedAt table<PlayerID, number>
---@field BackendLoginTokens table<PlayerID, string>
---@field PendingInventorySaves table<string, { inventory: table<string, any>, balanceChange: integer }>
---@field InventorySaveTimers table<string, any>

---@class ShopEventBase
---@field PlayerID integer|string

---@class ShopBuyItemEvent: ShopEventBase
---@field name ItemName

---@class ShopEquipItemEvent: ShopEventBase
---@field name ItemName
---@field slot_name ItemSlotName|nil

---@class ShopActivatePromoCodeEvent: ShopEventBase
---@field code string

local SUBSCRIPTION_PREVIEW_ACTIVE = false
local PROMO_ACTIVATION_COOLDOWN_SEC = 30
local PROMO_REQUEST_TIMEOUT_SEC = 7
local INVENTORY_SAVE_DEBOUNCE_SEC = 5.0

local ITEM_TYPE_NAME_BY_VALUE = {
	[ITEMS_TYPES.CHAT_WHEEL] = "CHAT_WHEEL",
	[ITEMS_TYPES.TITLE] = "TITLE",
	[ITEMS_TYPES.FX_HERO] = "FX_HERO",
	[ITEMS_TYPES.FX_ATTACK] = "FX_ATTACK",
}

local ITEM_TYPE_VALUE_BY_NAME = {
	CHAT_WHEEL = ITEMS_TYPES.CHAT_WHEEL,
	TITLE = ITEMS_TYPES.TITLE,
	FX_HERO = ITEMS_TYPES.FX_HERO,
	FX_ATTACK = ITEMS_TYPES.FX_ATTACK,
}

function Shop:Init()
	self.Loaded = true

	self.PlayerInventories = self.PlayerInventories or {} ---@type table<PlayerID, PlayerInventory>
	self.PlayerCoins = self.PlayerCoins or {} ---@type table<PlayerID, integer>
	self.PlayerBalanceChanges = self.PlayerBalanceChanges or {} ---@type table<PlayerID, integer>
	self.PromoCooldowns = self.PromoCooldowns or {} ---@type table<PlayerID, number>
	self.PromoRequestTokens = self.PromoRequestTokens or {} ---@type table<PlayerID, string>
	self.PromoRequestStartedAt = self.PromoRequestStartedAt or {} ---@type table<PlayerID, number>
	self.BackendLoginTokens = self.BackendLoginTokens or {} ---@type table<PlayerID, string>
	self.PendingInventorySaves = self.PendingInventorySaves or {}
	self.InventorySaveTimers = self.InventorySaveTimers or {}

	local itemsCatalog = {} ---@type table<ItemName, any>
	for key, value in pairs(ITEMS_LIST) do
		itemsCatalog[key] = value
	end
	for CHAT_ITEM_NAME, CHAT_ITEM_INFO in pairs(CHAT_WHEEL_LIST) do
		itemsCatalog[CHAT_ITEM_NAME] = {
			slot_type = ITEMS_TYPES.CHAT_WHEEL,
			slot_name = "chat_wheel_item",
			preview_type = ITEMS_PREVIEW_TYPES.CHAT_WHEEL,
			preview_value = CHAT_ITEM_NAME,
			game_value = CHAT_ITEM_NAME,

			buyable = CHAT_ITEM_INFO.buyable,
			free = CHAT_ITEM_INFO.free,
			cost = CHAT_ITEM_INFO.cost,
		}
	end

	self.ItemsCatalog = itemsCatalog ---@type table<ItemName, any>
	CustomNetTables:SetTableValue("items", "list", itemsCatalog)

	GameListener:SubscribeProtected("server_buy_item", function(event)
		self:OnBuyItem(event)
	end)
	GameListener:SubscribeProtected("server_equip_item", function(event)
		self:OnEquipItem(event)
	end)
	GameListener:SubscribeProtected("server_unequip_item", function(event)
		self:OnUnequipItem(event)
	end)
	GameListener:SubscribeProtected("server_activate_promo_code", function(event)
		self:OnActivatePromoCode(event)
	end)
end

---@param playerId PlayerID
---@return string
function Shop:GetPlayerCosmeticKey(playerId)
	return "player_" .. tostring(playerId) .. "_cosmetic_info"
end

---@param playerId PlayerID
---@return PlayerInventory
function Shop:GetOrCreatePlayerInventory(playerId)
	if self.PlayerInventories[playerId] then
		return self.PlayerInventories[playerId]
	end

	self.PlayerInventories[playerId] = {
		ownedMap = {},
		slots = {},
	}

	return self.PlayerInventories[playerId]
end

---@param playerId PlayerID
---@param amount integer
function Shop:AddCoins(playerId, amount)
	if amount <= 0 then
		return
	end

	self.PlayerCoins[playerId] = (self.PlayerCoins[playerId] or 0) + amount
	self:QueueBalanceChange(playerId, amount)
	self:SyncPlayerCoins(playerId)
end

---@param playerId PlayerID
---@param amount integer
function Shop:AddBackendGrantedCoins(playerId, amount)
	local coins = math.floor(tonumber(amount) or 0)
	if coins <= 0 then
		return
	end

	self.PlayerCoins[playerId] = (self.PlayerCoins[playerId] or 0) + coins
	self:SyncPlayerCoins(playerId)
end

---@param playerId PlayerID
---@return integer
function Shop:GetCoins(playerId)
	return self.PlayerCoins[playerId] or 0
end

---@param playerId PlayerID
---@param amount integer
---@return boolean
function Shop:SpendCoins(playerId, amount)
	local coins = self.PlayerCoins[playerId] or 0
	if amount <= 0 or coins < amount then
		return false
	end

	self.PlayerCoins[playerId] = coins - amount
	self:QueueBalanceChange(playerId, -amount)
	self:SyncPlayerCoins(playerId)
	return true
end

---@param playerId PlayerID
---@param amount integer
function Shop:QueueBalanceChange(playerId, amount)
	local change = math.floor(tonumber(amount) or 0)
	if change == 0 then
		return
	end

	self.PlayerBalanceChanges[playerId] = (self.PlayerBalanceChanges[playerId] or 0) + change
end

---@param playerId PlayerID
---@return integer
function Shop:ConsumeBalanceChange(playerId)
	local change = math.floor(tonumber(self.PlayerBalanceChanges[playerId]) or 0)
	self.PlayerBalanceChanges[playerId] = 0
	return change
end

---@param playerId PlayerID
function Shop:SyncPlayerCoins(playerId)
	local info = CustomNetTables:GetTableValue("player_info_shop", tostring(playerId)) or {}
	info.gold = self.PlayerCoins[playerId] or 0
	CustomNetTables:SetTableValue("player_info_shop", tostring(playerId), info)
end

---@param playerId PlayerID
---@param patch table<string, any>
function Shop:SyncPlayerShopInfo(playerId, patch)
	local info = CustomNetTables:GetTableValue("player_info_shop", tostring(playerId)) or {}
	for key, value in pairs(patch) do
		info[key] = value
	end
	CustomNetTables:SetTableValue("player_info_shop", tostring(playerId), info)
end

---@param playerId PlayerID
---@param available boolean
---@param status string
function Shop:SetShopAvailability(playerId, available, status)
	self:SyncPlayerShopInfo(playerId, {
		shop_available = available == true and 1 or 0,
		shop_status = status or (available == true and "available" or "unavailable"),
	})
end

---@param playerId PlayerID
function Shop:ApplyLocalDevelopmentState(playerId)
	self:SetShopAvailability(playerId, true, "local")
	self:SetCoins(playerId, math.max(self:GetCoins(playerId), 999999))
	self:SyncMatchesTodayFromLogin(playerId, 8)
	self:SyncSubscriptionState(playerId, {
		active = false,
		status = "inactive",
		source = "local",
	})
	self:SyncPlayerInventory(playerId)
end

---@param playerId PlayerID
---@return boolean
function Shop:IsShopAvailable(playerId)
	local info = CustomNetTables:GetTableValue("player_info_shop", tostring(playerId)) or {}
	return tonumber(info.shop_available or 0) == 1
end

---@param playerId PlayerID
---@param amount any
function Shop:SetCoins(playerId, amount)
	local coins = tonumber(amount)
	if coins == nil or coins < 0 then
		return
	end

	self.PlayerCoins[playerId] = math.floor(coins)
	self:SyncPlayerCoins(playerId)
end

---@param playerId PlayerID
---@param matchesToday any
---@return boolean
function Shop:SyncMatchesTodayFromLogin(playerId, matchesToday)
	-- local matches = tonumber(matchesToday)
	local matches = 8
	if matches == nil then
		return false
	end

	matches = math.floor(matches)
	if matches < 0 then
		matches = 0
	end

	self:SyncPlayerShopInfo(playerId, {
		matchesToday = matches,
	})

	return true
end

---@param itemName ItemName
---@return string|nil
function Shop:GetBackendItemType(itemName)
	if CHAT_WHEEL_LIST[itemName] ~= nil then
		return "CHAT_WHEEL"
	end

	local itemInfo = self.ItemsCatalog and self.ItemsCatalog[itemName] or ITEMS_LIST[itemName]
	if not itemInfo then
		return nil
	end

	return ITEM_TYPE_NAME_BY_VALUE[itemInfo.slot_type]
end

---@param itemName ItemName
---@param rawType any
---@return string|nil
function Shop:NormalizeBackendItemType(itemName, rawType)
	if type(rawType) == "string" then
		local upperType = string.upper(rawType)
		if ITEM_TYPE_VALUE_BY_NAME[upperType] then
			return upperType
		end
	end

	return self:GetBackendItemType(itemName)
end

---@param slot any
---@return integer|nil
function Shop:NormalizeChatWheelSlot(slot)
	local lineId = tonumber(slot)
	if lineId == nil then
		return nil
	end

	lineId = math.floor(lineId)
	if lineId < 1 or lineId > 8 then
		return nil
	end

	return lineId
end

---@param playerId PlayerID
---@return table<integer, ItemName>
function Shop:GetPlayerChatWheelTable(playerId)
	if ChatWheel and ChatWheel.Players and ChatWheel.Players[playerId] and ChatWheel.Players[playerId].ChatWheel then
		return ChatWheel.Players[playerId].ChatWheel
	end

	return CustomNetTables:GetTableValue("chat_wheel", tostring(playerId)) or {}
end

---@param inventoryPayload table<string, any>|nil
---@param loginResponse table<string, any>
---@return table<string, integer>|nil
function Shop:GetCasesPayloadFromLogin(inventoryPayload, loginResponse)
	if type(inventoryPayload) == "table" then
		local inventoryCases = inventoryPayload.cases
			or inventoryPayload.caseCounts
			or inventoryPayload.case_counts
			or inventoryPayload.player_cases
		if type(inventoryCases) == "table" then
			return inventoryCases
		end
	end

	local loginCases = loginResponse.cases
		or loginResponse.caseCounts
		or loginResponse.case_counts
		or loginResponse.player_cases
	if type(loginCases) == "table" then
		return loginCases
	end

	return nil
end

---@param playerId PlayerID
---@param loginResponse table<string, any>|nil
---@return boolean
function Shop:ApplyInventoryFromLogin(playerId, loginResponse)
	if type(loginResponse) ~= "table" then
		return false
	end

	self:SetCoins(playerId, loginResponse.balance)
	self.PlayerBalanceChanges[playerId] = 0
	self:SyncMatchesTodayFromLogin(playerId, loginResponse.matchesToday)

	local inventoryPayload = loginResponse.inventory
	if type(inventoryPayload) ~= "table" then
		if Cases and Cases.SetPlayerCases then
			Cases:SetPlayerCases(playerId, self:GetCasesPayloadFromLogin(nil, loginResponse))
		end
		self:SyncPlayerInventory(playerId)
		return false
	end

	if Cases and Cases.SetPlayerCases then
		Cases:SetPlayerCases(playerId, self:GetCasesPayloadFromLogin(inventoryPayload, loginResponse))
	end

	local items = inventoryPayload.items
	if type(items) ~= "table" then
		self:SyncPlayerInventory(playerId)
		return false
	end

	self.PlayerInventories[playerId] = {
		ownedMap = {},
		slots = {},
	}

	local inv = self:GetOrCreatePlayerInventory(playerId)
	local chatWheelTable = {}

	for _, backendItem in pairs(items) do
		if type(backendItem) == "table" and type(backendItem.name) == "string" and backendItem.name ~= "" then
			local itemName = backendItem.name
			local itemType = self:NormalizeBackendItemType(itemName, backendItem.type)

			if itemType == "CHAT_WHEEL" and CHAT_WHEEL_LIST[itemName] ~= nil then
				inv.ownedMap[itemName] = true

				if self:ToBoolean(backendItem.equipped) or self:ToBoolean(backendItem.equiped) then
					local lineId = self:NormalizeChatWheelSlot(backendItem.slot)
					if lineId ~= nil then
						chatWheelTable[lineId] = itemName
					end
				end
			elseif itemType ~= nil then
				local itemInfo = ITEMS_LIST[itemName]
				if itemInfo and ITEM_TYPE_NAME_BY_VALUE[itemInfo.slot_type] == itemType then
					inv.ownedMap[itemName] = true

					if
						(self:ToBoolean(backendItem.equipped) or self:ToBoolean(backendItem.equiped))
						and type(itemInfo.slot_name) == "string"
					then
						inv.slots[itemInfo.slot_name] = itemName
					end
				end
			end
		end
	end

	self:SyncPlayerInventory(playerId)
	if WereableSystem and WereableSystem.RequestPlayerRefresh then
		WereableSystem:RequestPlayerRefresh(playerId)
	elseif WereableSystem and WereableSystem.RefreshPlayer then
		WereableSystem:RefreshPlayer(playerId)
	end
	if ChatWheel and ChatWheel.LoadPlayer then
		ChatWheel:LoadPlayer(playerId, chatWheelTable)
	else
		CustomNetTables:SetTableValue("chat_wheel", tostring(playerId), chatWheelTable)
	end

	return true
end

---@param playerId PlayerID
---@return table<string, any>
function Shop:BuildBackendInventorySnapshot(playerId)
	local inv = self:GetOrCreatePlayerInventory(playerId)
	local items = {}
	local selectedChatWheelItems = {}

	local chatWheelTable = self:GetPlayerChatWheelTable(playerId)
	for lineId, itemName in pairs(chatWheelTable) do
		local normalizedLineId = self:NormalizeChatWheelSlot(lineId)
		if
			normalizedLineId ~= nil
			and type(itemName) == "string"
			and itemName ~= ""
			and CHAT_WHEEL_LIST[itemName] ~= nil
		then
			table.insert(items, {
				name = itemName,
				type = "CHAT_WHEEL",
				slot = normalizedLineId,
				equipped = true,
			})
			selectedChatWheelItems[itemName] = true
		end
	end

	for itemName, hasItem in pairs(inv.ownedMap) do
		if hasItem == true then
			local itemType = self:GetBackendItemType(itemName)
			if itemType == "CHAT_WHEEL" then
				if selectedChatWheelItems[itemName] ~= true then
					table.insert(items, {
						name = itemName,
						type = "CHAT_WHEEL",
						equipped = false,
					})
				end
			elseif itemType ~= nil then
				local equipped = false
				for _, equippedItemName in pairs(inv.slots) do
					if equippedItemName == itemName then
						equipped = true
						break
					end
				end

				table.insert(items, {
					name = itemName,
					type = itemType,
					equipped = equipped,
				})
			end
		end
	end

	return {
		items = items,
		cases = Cases and Cases.BuildBackendSnapshot and Cases:BuildBackendSnapshot(playerId) or {},
	}
end

---@param playerId PlayerID
function Shop:ScheduleInventorySave(playerId)
	if DevUtils and DevUtils:Check() then
		return
	end
	if not (ShopOutboundApi and ShopOutboundApi.UpdateInventory) then
		return
	end

	local uid = GetSteamID(playerId)
	if type(uid) ~= "string" or uid == "" then
		return
	end

	local balanceChange = self:ConsumeBalanceChange(playerId)
	local pending = self.PendingInventorySaves[uid]
	if pending then
		balanceChange = (tonumber(pending.balanceChange) or 0) + balanceChange
	end

	self.PendingInventorySaves[uid] = {
		inventory = self:BuildBackendInventorySnapshot(playerId),
		balanceChange = balanceChange,
	}

	if self.InventorySaveTimers[uid] then
		Timers:RemoveTimer(self.InventorySaveTimers[uid])
	end

	self.InventorySaveTimers[uid] = Timers:CreateTimer(INVENTORY_SAVE_DEBOUNCE_SEC, function()
		self:FlushInventorySave(uid)
		return nil
	end)
end

---@param uid string
function Shop:FlushInventorySave(uid)
	if not (ShopOutboundApi and ShopOutboundApi.UpdateInventory) then
		return
	end

	local pending = self.PendingInventorySaves and self.PendingInventorySaves[uid] or nil
	if not pending then
		return
	end

	self.PendingInventorySaves[uid] = nil
	self.InventorySaveTimers[uid] = nil

	ShopOutboundApi:UpdateInventory(uid, pending.inventory, pending.balanceChange)
end

---@param playerId PlayerID
---@param statusText string
---@param statusType "success"|"error"|"pending"|string
---@param pending boolean|nil
---@param lastCode string|nil
function Shop:SyncPromoState(playerId, statusText, statusType, pending, lastCode)
	self:SyncPlayerShopInfo(playerId, {
		promo_status_text = statusText or "",
		promo_status_type = statusType or "",
		promo_pending = pending == true and 1 or 0,
		promo_last_code = lastCode or "",
	})
end

---@param value any
---@return boolean
function Shop:ToBoolean(value)
	if value == true or value == 1 or value == "1" then
		return true
	end

	if type(value) == "string" then
		local lower = string.lower(value)
		return lower == "true" or lower == "active" or lower == "subscribed"
	end

	return false
end

---@param playerId PlayerID
---@param state table<string, any>
function Shop:SyncSubscriptionState(playerId, state)
	local status = state.status
	if type(status) ~= "string" or status == "" then
		status = state.active == true and "active" or "inactive"
	end

	self:SyncPlayerShopInfo(playerId, {
		subscription_active = state.active == true and 1 or 0,
		subscription_status = status,
		subscription_status_text = type(state.statusText) == "string" and state.statusText or "",
		subscription_until = type(state.untilDate) == "string" and state.untilDate or "",
		subscription_source = type(state.source) == "string" and state.source or "backend",
	})
end

---@param playerId PlayerID
function Shop:SyncSubscriptionPreviewState(playerId)
	if SUBSCRIPTION_PREVIEW_ACTIVE ~= true then
		return
	end

	self:SyncSubscriptionState(playerId, {
		active = true,
		status = "active",
		source = "preview",
	})
end

---@param payload any
---@return table<string, any>|nil
function Shop:NormalizeSubscriptionPayload(payload)
	if payload == nil then
		return nil
	end

	if type(payload) == "boolean" or type(payload) == "number" or type(payload) == "string" then
		local active = self:ToBoolean(payload)
		return {
			active = active,
			status = active and "active" or "inactive",
			source = "backend",
		}
	end

	if type(payload) ~= "table" then
		return nil
	end

	local rawStatus = payload.status or payload.state or payload.subscriptionStatus
	local status = type(rawStatus) == "string" and string.lower(rawStatus) or nil
	local active = self:ToBoolean(payload.active)
		or self:ToBoolean(payload.isActive)
		or self:ToBoolean(payload.subscribed)
		or self:ToBoolean(payload.hasSubscription)
		or status == "active"
		or status == "subscribed"

	if status ~= "loading" and status ~= "error" then
		status = active and "active" or "inactive"
	end

	return {
		active = active,
		status = status,
		statusText = payload.status_text or payload.statusText or payload.title,
		untilDate = payload["until"]
			or payload.untilDate
			or payload.activeUntil
			or payload.expiresAt
			or payload.expires_at,
		source = "backend",
	}
end

---@param playerId PlayerID
---@param loginResponse table<string, any>|nil
---@return boolean
function Shop:ApplySubscriptionFromLogin(playerId, loginResponse)
	if type(loginResponse) ~= "table" then
		return false
	end

	local payload = loginResponse.subscription
		or loginResponse.subscriptionStatus
		or loginResponse.supportSubscription
		or loginResponse.developerSubscription

	local state = self:NormalizeSubscriptionPayload(payload)
	if state == nil then
		return false
	end

	self:SyncSubscriptionState(playerId, state)
	return true
end

---@param rawCode any
---@return string
function Shop:NormalizePromoCode(rawCode)
	if type(rawCode) ~= "string" then
		return ""
	end

	local code = rawCode
	code = string.gsub(code, "^%s+", "")
	code = string.gsub(code, "%s+$", "")
	return code
end

---@param playerId PlayerID
---@param itemName ItemName
function Shop:AddOwnedItem(playerId, itemName)
	if not (self.ItemsCatalog and self.ItemsCatalog[itemName]) and not ITEMS_LIST[itemName] then
		logger:Log(string.format("Attempted to add unknown item '%s' to player %d", itemName, playerId))
		return
	end

	local inv = self:GetOrCreatePlayerInventory(playerId)
	inv.ownedMap[itemName] = true
end

---@param playerId PlayerID
---@param itemName ItemName
---@return boolean
function Shop:PlayerHasItem(playerId, itemName)
	return self:GetOrCreatePlayerInventory(playerId).ownedMap[itemName] == true
end

---@param itemName ItemName
---@return boolean
function Shop:IsItemBuyable(itemName)
	local itemInfo = self.ItemsCatalog and self.ItemsCatalog[itemName] or ITEMS_LIST[itemName]
	if not itemInfo then
		return false
	end

	return itemInfo.buyable == true or itemInfo.buyable == 1
end

---@param itemName ItemName
---@return boolean
function Shop:IsChatWheelItemFree(itemName)
	local chatInfo = CHAT_WHEEL_LIST[itemName]
	if not chatInfo then
		return false
	end

	return chatInfo.free == true or chatInfo.free == 1
end

---@param playerId PlayerID
---@param itemName ItemName
---@return boolean
function Shop:CanPlayerUseChatWheelItem(playerId, itemName)
	if CHAT_WHEEL_LIST[itemName] == nil then
		return false
	end

	if self:IsChatWheelItemFree(itemName) then
		return true
	end

	return self:PlayerHasItem(playerId, itemName)
end

---@param playerId PlayerID
---@param slotName ItemSlotName
---@return ItemName|nil
function Shop:GetEquippedItemInSlot(playerId, slotName)
	local inv = self:GetOrCreatePlayerInventory(playerId)
	local itemName = inv.slots[slotName]
	if type(itemName) == "string" and itemName ~= "" then
		return itemName
	end
	return nil
end

---@param playerId PlayerID
function Shop:SyncPlayerInventory(playerId)
	local inv = self:GetOrCreatePlayerInventory(playerId)

	local owned = {} ---@type OwnedItem[]
	for itemName, hasItem in pairs(inv.ownedMap) do
		if hasItem == true then
			table.insert(owned, {
				item_name = itemName,
			})
		end
	end

	CustomNetTables:SetTableValue("players", self:GetPlayerCosmeticKey(playerId), {
		owned = owned,
		slots = inv.slots,
	})
end

---@param event ShopBuyItemEvent
function Shop:OnBuyItem(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self:IsShopAvailable(playerId) then
		return
	end

	local itemName = event.name
	if type(itemName) ~= "string" or itemName == "" then
		return
	end

	local itemInfo = self.ItemsCatalog and self.ItemsCatalog[itemName] or ITEMS_LIST[itemName]
	if not itemInfo then
		return
	end

	if not self:IsItemBuyable(itemName) then
		return
	end

	if self:PlayerHasItem(playerId, itemName) then
		return
	end

	local cost = tonumber(itemInfo.cost) or 0
	local coins = self.PlayerCoins[playerId] or 0
	if coins < cost then
		return
	end

	self.PlayerCoins[playerId] = coins - cost
	if cost > 0 then
		self:QueueBalanceChange(playerId, -cost)
	end
	self:AddOwnedItem(playerId, itemName)
	self:SyncPlayerCoins(playerId)
	self:SyncPlayerInventory(playerId)
	self:ScheduleInventorySave(playerId)
end

---@param event ShopEquipItemEvent
function Shop:OnEquipItem(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self:IsShopAvailable(playerId) then
		return
	end

	local itemName = event.name
	if type(itemName) ~= "string" or itemName == "" then
		return
	end
	if not self:PlayerHasItem(playerId, itemName) then
		return
	end

	local itemInfo = ITEMS_LIST[itemName]
	if not itemInfo or type(itemInfo.slot_name) ~= "string" then
		return
	end

	local inv = self:GetOrCreatePlayerInventory(playerId)
	inv.slots[itemInfo.slot_name] = itemName
	self:SyncPlayerInventory(playerId)
	if WereableSystem and WereableSystem.RefreshPlayerSlot then
		WereableSystem:RefreshPlayerSlot(playerId, itemInfo.slot_name)
	end
	self:ScheduleInventorySave(playerId)
end

---@param event ShopEquipItemEvent
function Shop:OnUnequipItem(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self:IsShopAvailable(playerId) then
		return
	end

	local inv = self:GetOrCreatePlayerInventory(playerId)
	local slotName = event.slot_name

	if type(slotName) == "string" and slotName ~= "" then
		inv.slots[slotName] = ""
		self:SyncPlayerInventory(playerId)
		if WereableSystem and WereableSystem.RefreshPlayerSlot then
			WereableSystem:RefreshPlayerSlot(playerId, slotName)
		end
		self:ScheduleInventorySave(playerId)
		return
	end

	local itemName = event.name
	if type(itemName) ~= "string" or itemName == "" then
		return
	end

	for slot, equipped in pairs(inv.slots) do
		if equipped == itemName then
			inv.slots[slot] = ""
			if WereableSystem and WereableSystem.RefreshPlayerSlot then
				WereableSystem:RefreshPlayerSlot(playerId, slot)
			end
		end
	end
	self:SyncPlayerInventory(playerId)
	self:ScheduleInventorySave(playerId)
end

---@param event ShopActivatePromoCodeEvent
function Shop:OnActivatePromoCode(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or playerId < 0 then
		return
	end
	if not self:IsShopAvailable(playerId) then
		self:SyncPromoState(playerId, "#HUD_Inventory_ShopUnavailable_Title", "error", false, "")
		return
	end

	local code = self:NormalizePromoCode(event.code)
	if code == "" then
		self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusEmpty", "error", false, "")
		return
	end

	local now = GameRules:GetGameTime()
	if self.PromoRequestTokens[playerId] ~= nil then
		local startedAt = self.PromoRequestStartedAt[playerId] or now
		if now - startedAt < PROMO_REQUEST_TIMEOUT_SEC then
			self:SyncPromoState(playerId, "#HUD_Inventory_PromoPending", "pending", true, code)
			return
		end

		self.PromoRequestTokens[playerId] = nil
		self.PromoRequestStartedAt[playerId] = nil
	end

	local cooldownUntil = self.PromoCooldowns[playerId] or 0
	if cooldownUntil > now then
		self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusCooldown", "error", false, code)
		return
	end

	self.PromoCooldowns[playerId] = now + PROMO_ACTIVATION_COOLDOWN_SEC

	self:SyncPromoState(playerId, "#HUD_Inventory_PromoPending", "pending", true, code)
	local requestToken = tostring(code) .. "|" .. tostring(now)
	self.PromoRequestTokens[playerId] = requestToken
	self.PromoRequestStartedAt[playerId] = now
	Timers:CreateTimer(PROMO_REQUEST_TIMEOUT_SEC, function()
		if self.PromoRequestTokens[playerId] == requestToken then
			self.PromoRequestTokens[playerId] = nil
			self.PromoRequestStartedAt[playerId] = nil
			self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusServerError", "error", false, code)
		end
		return nil
	end)

	local ok, err = pcall(function()
		self:HandlePromoCodeActivation(playerId, code)
	end)

	if not ok then
		logger:LogError("[Shop] Promo activation failed: " .. tostring(err))
		self.PromoRequestTokens[playerId] = nil
		self.PromoRequestStartedAt[playerId] = nil
		self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusServerError", "error", false, code)
	end
end

---@param result table<string, any>
---@return integer
function Shop:GetPromoGrantedBalance(result)
	if type(result) ~= "table" then
		return 0
	end

	return math.floor(tonumber(result.grantedBalance or result.granted_balance) or 0)
end

---@param playerId PlayerID
---@param code string
---@param result table<string, any>|nil
function Shop:ApplyPromoActivationResult(playerId, code, result)
	result = result or {}

	local status = type(result.status) == "string" and string.upper(result.status) or ""
	local statusText = "#HUD_Inventory_PromoStatusNotImplemented"
	local statusType = "error"

	if status == "SUCCES" or status == "SUCCESS" then
		statusText = "#HUD_Inventory_PromoStatusSuccess"
		statusType = "success"
		self:AddBackendGrantedCoins(playerId, self:GetPromoGrantedBalance(result))
	elseif status == "EXPIRED" then
		statusText = "#HUD_Inventory_PromoStatusExpired"
	elseif status == "NOT_EXIST" then
		statusText = "#HUD_Inventory_PromoStatusNotExist"
	elseif status == "LIMIT_REACHED" then
		statusText = "#HUD_Inventory_PromoStatusLimitReached"
	elseif status == "ALREADY_ACTIVATED" then
		statusText = "#HUD_Inventory_PromoStatusAlreadyActivated"
	elseif type(result.status_text) == "string" and result.status_text ~= "" then
		statusText = result.status_text
		statusType = type(result.status_type) == "string" and result.status_type or "error"
	end

	local shouldKeepPending = result.pending == true
	self:SyncPromoState(playerId, statusText, statusType, shouldKeepPending, code)
end

---@param playerId PlayerID
---@param code string
---@param response any
function Shop:HandlePromoActivationResponse(playerId, code, response)
	self.PromoRequestTokens[playerId] = nil
	self.PromoRequestStartedAt[playerId] = nil

	local ok, result = pcall(function()
		local body = response and response.Body or nil
		if type(body) ~= "string" or body == "" then
			return {
				status_text = "#HUD_Inventory_PromoStatusServerError",
				status_type = "error",
				pending = false,
			}
		end

		local decoded = json.decode(body)
		logger:LogTable(decoded)

		return decoded
	end)

	if not ok then
		logger:LogError("[Shop] Promo response parse failed: " .. tostring(result))
		self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusServerError", "error", false, code)
		return
	end

	self:ApplyPromoActivationResult(playerId, code, result)
end

---@param playerId PlayerID
---@param code string
function Shop:HandlePromoCodeActivation(playerId, code)
	ShopOutboundApi:ActivatePromo(GetSteamID(playerId), code, function(response)
		self:HandlePromoActivationResponse(playerId, code, response)
	end)
end

---@param playerId PlayerID
function Shop:GiveTestDataToPlayer(playerId)
	self:SyncPlayerInventory(playerId)
end

if not Shop.Loaded then
	Shop:Init()
end