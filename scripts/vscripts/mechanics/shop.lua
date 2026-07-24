--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
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
---@field ItemsCatalog table<ItemName, any>

---@class ShopEventBase
---@field PlayerID integer|string

---@class ShopBuyItemEvent: ShopEventBase
---@field name ItemName

---@class ShopEquipItemEvent: ShopEventBase
---@field name ItemName
---@field slot_name ItemSlotName|nil

---@class ShopActivatePromoCodeEvent: ShopEventBase
---@field code string



function Shop:Init()
    self.Loaded = true

    self.PlayerInventories = self.PlayerInventories or {} ---@type table<PlayerID, PlayerInventory>
    self.PlayerCoins = self.PlayerCoins or {} ---@type table<PlayerID, integer>

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
            cost = CHAT_ITEM_INFO.cost
        }
    end

    self.ItemsCatalog = itemsCatalog ---@type table<ItemName, any>
    CustomNetTables:SetTableValue("items", "list", itemsCatalog)

    -- GameListener:SubscribeProtected("server_buy_item", function(event)
    --     self:OnBuyItem(event)
    -- end)
    -- GameListener:SubscribeProtected("server_equip_item", function(event)
    --     self:OnEquipItem(event)
    -- end)
    -- GameListener:SubscribeProtected("server_unequip_item", function(event)
    --     self:OnUnequipItem(event)
    -- end)
    -- GameListener:SubscribeProtected("server_activate_promo_code", function(event)
    --     self:OnActivatePromoCode(event)
    -- end)

    if IsInToolsMode() then
        self:GiveTestDataToPlayer(0)
    end
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
        slots = {}
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
    self:SyncPlayerCoins(playerId)
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

---@param rawCode any
---@return string
function Shop:NormalizePromoCode(rawCode)
    if type(rawCode) ~= "string" then
        return ""
    end

    local code = string.upper(rawCode)
    code = string.gsub(code, "^%s+", "")
    code = string.gsub(code, "%s+$", "")
    code = string.gsub(code, "%s+", "")
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
                item_name = itemName
            })
        end
    end

    CustomNetTables:SetTableValue("players", self:GetPlayerCosmeticKey(playerId), {
        owned = owned,
        slots = inv.slots
    })
end

---@param event ShopBuyItemEvent
function Shop:OnBuyItem(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
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
    self:AddOwnedItem(playerId, itemName)
    self:SyncPlayerCoins(playerId)
    self:SyncPlayerInventory(playerId)
end

---@param event ShopEquipItemEvent
function Shop:OnEquipItem(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
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
end

---@param event ShopEquipItemEvent
function Shop:OnUnequipItem(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
        return
    end

    local inv = self:GetOrCreatePlayerInventory(playerId)
    local slotName = event.slot_name

    if type(slotName) == "string" and slotName ~= "" then
        inv.slots[slotName] = ""
        self:SyncPlayerInventory(playerId)
        return
    end

    local itemName = event.name
    if type(itemName) ~= "string" or itemName == "" then
        return
    end

    for slot, equipped in pairs(inv.slots) do
        if equipped == itemName then
            inv.slots[slot] = ""
        end
    end
    self:SyncPlayerInventory(playerId)
end

---@param event ShopActivatePromoCodeEvent
function Shop:OnActivatePromoCode(event)
    local playerId = tonumber(event.PlayerID)
    if playerId == nil or playerId < 0 then
        return
    end

    local code = self:NormalizePromoCode(event.code)
    if code == "" then
        self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusEmpty", "error", false, "")
        return
    end

    self:SyncPromoState(playerId, "#HUD_Inventory_PromoPending", "pending", true, code)

    local ok, err = pcall(function()
        self:HandlePromoCodeActivation(playerId, code)
    end)

    if not ok then
        logger:LogError("[Shop] Promo activation failed: " .. tostring(err))
        self:SyncPromoState(playerId, "#HUD_Inventory_PromoStatusServerError", "error", false, code)
    end
end

---@param playerId PlayerID
---@param code string
---@param result table<string, any>|nil
function Shop:ApplyPromoActivationResult(playerId, code, result)
    result = result or {}

    local statusText = result.status_text
    if type(statusText) ~= "string" or statusText == "" then
        statusText = "#HUD_Inventory_PromoStatusNotImplemented"
    end

    local statusType = result.status_type
    if type(statusType) ~= "string" or statusType == "" then
        statusType = "error"
    end

    local shouldKeepPending = result.pending == true
    self:SyncPromoState(playerId, statusText, statusType, shouldKeepPending, code)
end

---@param playerId PlayerID
---@param code string
---@param response any
function Shop:HandlePromoActivationResponse(playerId, code, response)
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
    self:AddCoins(playerId, 10000)

    self:AddOwnedItem(playerId, "moderator")
    self:AddOwnedItem(playerId, "moderator_v2")
    self:AddOwnedItem(playerId, "moderator_v3")

    self:SyncPlayerInventory(playerId)
end

if not Shop.Loaded then Shop:Init() end