--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


ExtenderStash = ExtenderStash or class({})

---@class PlayerData
---@field items table<string, {item_name: string, item: EntityIndex}?>?

---@class CustomStashEvent
---@field PlayerID integer
---@field slot string
---@field item integer
---@field source integer

---@class CustomStashSellEvent
---@field PlayerID integer
---@field source integer
---@field item integer

function ExtenderStash:Init()
    self.bStarted = true

    self.LogsEnabled = true
    self.Players = {} ---@type table<PlayerID, PlayerData?>

    self:SetupPlayers()

    GameListener:SubscribeProtected("items_move_to_custom_stash", function(event) self:OnPlayerWantMoveToCustomStash(event) end)
    GameListener:SubscribeProtected("items_move_from_custom_stash", function(event) self:OnPlayerWantMoveFromCustomStash(event) end)
    GameListener:SubscribeProtected("items_sell_from_custom_stash", function(event) self:OnPlayerWantSellFromCustomStash(event) end)
end

function ExtenderStash:SetupPlayers()
    for PlayerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if PlayerResource:IsValidPlayerID(PlayerID) then
            if not self.Players[PlayerID] then
                self.Players[PlayerID] = {
                    items = {},
                }
            end

            CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_bonus_stash_items", self.Players[PlayerID].items)
        end
    end
end

---@param playerId integer
function ExtenderStash:SpawnStorageUnit(playerId)
    local existingUnit = self.Players[playerId] and self.Players[playerId].storageUnit
    if existingUnit and not existingUnit:IsNull() then
        return
    end

    local hero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hero == nil then
        self:Log("Cannot spawn storage unit: hero is nil for player " .. playerId)
        return
    end

    local team = PlayerResource:GetTeam(playerId)
    local spawnPos = Vector(0, 0, -2048)
    local unit = CreateUnitByName("npc_chc_stash_holder", spawnPos, false, hero, hero:GetPlayerOwner(), team)
    if unit == nil or unit:IsNull() then
        self:Log("Failed to spawn storage unit for player " .. playerId)
        return
    end

    unit:AddNoDraw()
    unit:SetControllableByPlayer(playerId, true)
    unit:SetOwner(hero)
    unit:AddNewModifier(unit, nil, "modifier_invulnerable", {})

    self.Players[playerId].storageUnit = unit
end

---@param playerId integer
---@param item CDOTA_Item
function ExtenderStash:PlaceInStorage(playerId, item)
    if item == nil or item:IsNull() then return end

    local playerData = self.Players[playerId]
    if playerData == nil then return end

    local storage = playerData.storageUnit
    if storage == nil or storage:IsNull() then
        self:SpawnStorageUnit(playerId)
        storage = playerData.storageUnit
    end

    if storage == nil or storage:IsNull() then return end

    storage:AddItem(item)
end

---@param playerId integer
---@param item CDOTA_Item
function ExtenderStash:RemoveFromStorage(playerId, item)
    if item == nil or item:IsNull() then return end

    local playerData = self.Players[playerId]
    if playerData == nil then return end

    local storage = playerData.storageUnit
    if storage == nil or storage:IsNull() then return end

    storage:TakeItem(item)
end

---@param event CustomStashEvent
---@return CDOTA_BaseNPC_Hero|nil
function ExtenderStash:ResolveEventSourceUnit(event)
    local source = nil

    if event and type(event.source) == "number" and event.source ~= -1 then
        source = EntIndexToHScript(event.source)
    end

    if source == nil or source:IsNull() then
        source = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
    end

    if source == nil or source:IsNull() then
        self:Log("Source is nil")
        return nil
    end

    if source.GetPlayerOwnerID and source:GetPlayerOwnerID() ~= event.PlayerID then
        self:Log("Source owner mismatch")
        return nil
    end

    return source
end

---@param unit CDOTA_BaseNPC
---@return boolean
function ExtenderStash:IsRestrictedSourceUnitForCustomStash(unit)
    if unit == nil or unit:IsNull() then
        return false
    end

    if unit.IsTempestDouble and unit:IsTempestDouble() then
        return true
    end

    if unit:HasModifier("modifier_arc_warden_tempest_double_lua") or unit:HasModifier("modifier_arc_warden_tempest_double_lua_illusion") then
        return true
    end

    return false
end

---@param event CustomStashSellEvent
---@return boolean
function ExtenderStash:OnPlayerWantSellFromCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return false
    end

    local Item = EntIndexToHScript(event.item) ---@cast Item CDOTA_Item

    if not self.Players[event.PlayerID] then
        self:Log("Player is nil")
        return false
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
    if Hero == nil then
        self:Log("Hero is nil")
        return false
    end

    if not Hero:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
        self:Log("Hero is out of shop")
        return false
    end


    local itemSlot, slotType = self:GetItemSlot(event.PlayerID, Item)
    if itemSlot and slotType == "CUSTOM" then
        self.Players[event.PlayerID].items[itemSlot] = nil

        local lastStashItem = Hero:GetItemInSlot(DOTA_STASH_SLOT_6)
        if lastStashItem then
            Hero:TakeItem(lastStashItem)
        end

        self:RemoveFromStorage(event.PlayerID, Item)
        Hero:AddItem(Item)
        Hero:SellItem(Item)
        if lastStashItem then
            Hero:AddItem(lastStashItem)

            self:DOTASwapItems(Hero, lastStashItem, DOTA_STASH_SLOT_6)
        end

        self:UpdatePlayerNetTable(event.PlayerID)
    end

    return true
end

---@param event CustomStashEvent
---@return boolean
function ExtenderStash:OnPlayerWantMoveToCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return false
    end

    local item = EntIndexToHScript(event.item) ---@cast item CDOTA_Item

    if not self.Players[event.PlayerID] then
        self.Players[event.PlayerID] = { items = {} }
    end

    local Hero = self:ResolveEventSourceUnit(event)
    if Hero == nil then
        self:Log("Source is nil")
        return false
    end

    if self:IsRestrictedSourceUnitForCustomStash(Hero) then
        self:Log("Tempest double cannot move items to custom stash")
        return false
    end

    if not Hero:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
        self:Log("Hero is out of shop")
        return false
    end

    if item:IsActiveNeutral() then
        self:Log("Target item is neutral")
        return false
    end

    if not self:IsThisItemAllowed(item:GetName()) then
        self:Log("Item is not allowed")
        return false
    end

    return self:SwapItems(event.PlayerID, item, event.slot, Hero)
end

---@param event CustomStashEvent
---@return boolean
function ExtenderStash:OnPlayerWantMoveFromCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return false
    end

    local Item = EntIndexToHScript(event.item)

    if not self.Players[event.PlayerID] then
        self:Log("Player is nil")
        return false
    end

    local Hero = self:ResolveEventSourceUnit(event)
    if Hero == nil then
        self:Log("Source is nil")
        return false
    end

    if self:IsRestrictedSourceUnitForCustomStash(Hero) then
        self:Log("Tempest double cannot move items from custom stash")
        return false
    end

    if not Hero:IsInRangeOfShop(DOTA_SHOP_HOME, true) then
        self:Log("Hero is out of shop")
        return false
    end

    return self:SwapItems(event.PlayerID, Item, event.slot, Hero)
end

---@param PlayerID integer
function ExtenderStash:UpdatePlayerNetTable(PlayerID)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return
    end

    CustomNetTables:SetTableValue("players", "player_".. PlayerID .."_bonus_stash_items", self.Players[PlayerID].items)
end

---@param playerId integer
---@param slot1 any
---@param slot2 any
---@param sourceUnit CDOTA_BaseNPC_Hero|nil
---@return CDOTA_BaseNPC_Hero|nil, table|nil, table|nil
function ExtenderStash:ResolveSwapEndpoints(playerId, slot1, slot2, sourceUnit)
    if slot1 == nil and slot2 == nil then
        self:Log("Slot is nil")
        return nil
    end

    if slot1 == nil then
        slot1 = self:FindClearItemSlot(playerId)
    end

    if slot2 == nil then
        slot2 = self:FindClearItemSlot(playerId)
    end

    if not self.Players[playerId] then
        self:Log("Player is nil")
        return nil
    end

    local hero = sourceUnit or PlayerResource:GetSelectedHeroEntity(playerId)
    if hero == nil then
        self:Log("Hero is nil")
        return nil
    end

    local slot1Item, slot1Type, slot1Resolved = self:GetSlot(playerId, slot1, hero)
    local slot2Item, slot2Type, slot2Resolved = self:GetSlot(playerId, slot2, hero)

    if slot1Type == "NONE" or slot2Type == "NONE" or (slot1Item == nil and slot2Item == nil) then
        self:Log("Slot is nil")
        return nil
    end

    local slot1Info = { item = slot1Item, type = slot1Type, slot = slot1Resolved }
    local slot2Info = { item = slot2Item, type = slot2Type, slot = slot2Resolved }

    return hero, slot1Info, slot2Info
end

---@param hero CDOTA_BaseNPC_Hero
---@param slot1Info table
---@param slot2Info table
function ExtenderStash:HandleDotaToDotaSwap(hero, slot1Info, slot2Info)
    if slot1Info.slot ~= -1 and slot2Info.slot ~= -1 then
        self:DOTASwapItems(hero, slot1Info.slot, slot2Info.slot)
    end
end

---@param playerId integer
---@param slot1Info table
---@param slot2Info table
function ExtenderStash:HandleCustomToCustomSwap(playerId, slot1Info, slot2Info)
    self.Players[playerId].items[slot1Info.slot] = slot2Info.item
    self.Players[playerId].items[slot2Info.slot] = slot1Info.item
end

---@param playerId integer
---@param hero CDOTA_BaseNPC_Hero
---@param dotaItem CDOTA_Item
---@param dotaSlot number
---@param slotName string
function ExtenderStash:PlaceDotaInEmptyCustomSlot(playerId, hero, dotaItem, dotaSlot, slotName)
    self.Players[playerId].items[slotName] = {
        item = dotaItem:entindex(),
        item_name = dotaItem:GetName(),
    }

    if dotaSlot ~= -1 then
        hero:TakeItem(dotaItem)
        self:PlaceInStorage(playerId, dotaItem)
        self:BindItemToHero(dotaItem, hero, playerId)
    end
end

---@param playerId integer
---@param hero CDOTA_BaseNPC_Hero
---@param dotaItem CDOTA_Item
---@param targetItem CDOTA_Item
---@param slotName string
---@param customSlot string
function ExtenderStash:TryMergeStackable(playerId, hero, dotaItem, targetItem, slotName, customSlot)
    if targetItem then
        local isItemNotMergedFully = self:MergeStackable(targetItem, dotaItem)
        if isItemNotMergedFully then
            local NewSlot = customSlot
            if NewSlot == slotName then
                NewSlot = self:FindClearItemSlot(playerId)
            end
            if NewSlot ~= nil then
                self:SwapItems(playerId, dotaItem, NewSlot, hero)
            end
        end
    end
end

---@param playerId integer
---@param hero CDOTA_BaseNPC_Hero
---@param dotaItem CDOTA_Item
---@param dotaSlot number
---@param targetItem CDOTA_Item
---@param slotName string
function ExtenderStash:SwapDotaAndCustomItems(playerId, hero, dotaItem, dotaSlot, targetItem, slotName)
    if dotaSlot ~= -1 then
        hero:TakeItem(dotaItem)
        self:PlaceInStorage(playerId, dotaItem)

        if targetItem then
            self:RemoveFromStorage(playerId, targetItem)
            hero:AddItem(targetItem)

            self:DOTASwapItems(hero, targetItem, dotaSlot)
        end

        self:BindItemToHero(dotaItem, hero, playerId)
        self.Players[playerId].items[slotName] = {
            item = dotaItem:entindex(),
            item_name = dotaItem:GetName(),
        }
    else
        local ClearSlot = self:FindClearItemSlot(playerId)
        if ClearSlot ~= nil then
            self:BindItemToHero(dotaItem, hero, playerId)
            self.Players[playerId].items[ClearSlot] = {
                item = dotaItem:entindex(),
                item_name = dotaItem:GetName(),
            }
        else
            CreateItemOnPositionSync(hero:GetAbsOrigin(), dotaItem)
        end
    end
end

---@param playerId integer
---@param hero CDOTA_BaseNPC_Hero
---@param customItemEntry table
---@param dotaSlot number
---@param customSlot string
function ExtenderStash:MoveCustomItemToDotaSlot(playerId, hero, customItemEntry, dotaSlot, customSlot)
    local customItemItem = EntIndexToHScript(customItemEntry.item)
    if customItemItem then
        if (dotaSlot == 16 and not customItemItem:IsActiveNeutral()) or (customItemItem:IsActiveNeutral() and dotaSlot <= 5) then
            self:Log("Item is not for this slot")
            return false
        end

        self:RemoveFromStorage(playerId, customItemItem)
        hero:AddItem(customItemItem)

        self:DOTASwapItems(hero, customItemItem, dotaSlot)
    end

    self.Players[playerId].items[customSlot] = nil
    return true
end

---@param playerId integer
---@param hero CDOTA_BaseNPC_Hero
---@param slot1Info table
---@param slot2Info table
---@return boolean
function ExtenderStash:HandleDotaToCustomSwap(playerId, hero, slot1Info, slot2Info)
    local dotaItem = slot1Info.item
    local dotaSlot = slot1Info.slot
    local customItem = slot2Info.item
    local customSlot = slot2Info.slot

    if slot2Info.type == "DOTA" then
        dotaItem = slot2Info.item
        dotaSlot = slot2Info.slot
        customItem = slot1Info.item
        customSlot = slot1Info.slot
    end

    if dotaItem ~= nil then
        local bestSlotName = self:FindBestSlotForItem(playerId, dotaItem, customSlot)
        if bestSlotName == nil then
            self:Log("Slot is nil")
            return false
        end

        local bestSlot = self.Players[playerId].items[bestSlotName]

        if bestSlot == nil then
            self:PlaceDotaInEmptyCustomSlot(playerId, hero, dotaItem, dotaSlot, bestSlotName)
        else
            local bestSlotItem = EntIndexToHScript(bestSlot.item) ---@cast bestSlotItem CDOTA_Item
            if dotaSlot == 16 and bestSlotItem and not bestSlotItem:IsActiveNeutral() or (bestSlotItem:IsActiveNeutral() and dotaSlot <= 5) then
                self:Log("Item is not for this slot")
                return false
            end

            if self:IsItemCanBeMerged(playerId, dotaItem) then
                self:TryMergeStackable(playerId, hero, dotaItem, bestSlotItem, bestSlotName, customSlot)
            else
                self:SwapDotaAndCustomItems(playerId, hero, dotaItem, dotaSlot, bestSlotItem, bestSlotName)
            end
        end
    elseif customItem ~= nil then
        if self:MoveCustomItemToDotaSlot(playerId, hero, customItem, dotaSlot, customSlot) == false then
            return false
        end
    end

    return true
end

---@param playerId integer
---@param slot1 any
---@param slot2 any
---@param sourceUnit CDOTA_BaseNPC_Hero|nil
---@return boolean
function ExtenderStash:SwapItems(playerId, slot1, slot2, sourceUnit)
    local hero, slot1Info, slot2Info = self:ResolveSwapEndpoints(playerId, slot1, slot2, sourceUnit)
    if hero == nil then return false end

    if slot1Info.type == "DOTA" and slot2Info.type == "DOTA" then
        self:HandleDotaToDotaSwap(hero, slot1Info, slot2Info)
    elseif slot1Info.type == "CUSTOM" and slot2Info.type == "CUSTOM" then
        self:HandleCustomToCustomSwap(playerId, slot1Info, slot2Info)
    elseif (slot1Info.type == "DOTA" and slot2Info.type == "CUSTOM") or (slot1Info.type == "CUSTOM" and slot2Info.type == "DOTA") then
        if self:HandleDotaToCustomSwap(playerId, hero, slot1Info, slot2Info) == false then
            return false
        end
    end

    self:UpdatePlayerNetTable(playerId)
    return true
end

function ExtenderStash:DOTASwapItems(Hero, slot1, slot2)
    if Hero == nil then
        self:Log("Hero is nil")
        return false
    end

    Hero:SetContextThink(DoUniqueString("Swap"), function(ent)
        local Slot1 = slot1
        if type(Slot1) == "table" and Slot1 and Slot1.IsItem ~= nil and not Slot1:IsNull() then
            Slot1 = Slot1:GetItemSlot()
        end

        local Slot2 = slot2
        if type(Slot2) == "table" and Slot2 and Slot2.IsItem ~= nil and not Slot2:IsNull() then
            Slot2 = Slot2:GetItemSlot()
        end
        if Hero and not Hero:IsNull() and type(Slot1) == "number" and type(Slot2) == "number" then
            Hero:SwapItems(Slot1, Slot2)
        end
    end, 0)
end

function ExtenderStash:UpdateItemBySlot(Unit, Item)
    if Item == nil or not Unit:HasAbility("techies_spoons_stash_custom") then return end

    if Item:GetItemSlot() == DOTA_ITEM_SLOT_9 then
        Item:SetItemState(0)

        local ModifName = Item:GetIntrinsicModifierName()
        if ModifName then
            Unit:RemoveModifierByNameAndCaster(ModifName, Item:GetCaster())
        end

        Item._custom_deleted_intrinsic = true
    elseif Item._custom_deleted_intrinsic and (Item:GetItemSlot() < DOTA_STASH_SLOT_1 or Item:GetItemSlot() > DOTA_STASH_SLOT_6) then
        Item:SetItemState(1)
        Item:RefreshIntrinsicModifier()

        local ModifName = Item:GetIntrinsicModifierName()
        if ModifName then
            local Modif = Unit:FindModifierByNameAndCaster(ModifName, Unit)
            if Modif then
                Modif:ForceRefresh()
                Modif:SendBuffRefreshToClients()
            end
        end
        Unit:CalculateGenericBonuses()
        Unit:CalculateStatBonus(true)
    end
end

---@param PlayerID integer
---@param Item CDOTA_Item
---@param slot any
---@return nil
function ExtenderStash:FindBestSlotForItem(PlayerID, Item, slot)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    if not Item or Item:IsNull() then
        self:Log("Item is nil")
        return nil
    end

    if Item:IsStackable() then
        for SLOT_NAME, ItemInfo in pairs(self.Players[PlayerID].items) do
            if ItemInfo.item_name == Item:GetName() and ItemInfo.item ~= Item:entindex() then
                local ItemH = EntIndexToHScript(ItemInfo.item)
                if ItemH and (ItemH:GetCurrentCharges() < self:GetMaxStacks(ItemInfo.item_name) or self:GetMaxStacks(ItemInfo.item_name) <= 0) then
                    return SLOT_NAME
                end
            end
        end
    end

    if slot == nil then
        for i = 0, 11 do
            local Name = "SLOT_"..i
            if self.Players[PlayerID].items[Name] == nil then
                return Name
            end
        end
    end

    return slot
end

function ExtenderStash:IsItemCanBeMerged(PlayerID, Item)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return false
    end

    if not Item or Item:IsNull() then
        self:Log("Item is nil")
        return false
    end

    if Item:IsStackable() then
        for SLOT_NAME, ItemInfo in pairs(self.Players[PlayerID].items) do
            if ItemInfo.item_name == Item:GetName() and ItemInfo.item ~= Item:entindex() then
                local ItemH = EntIndexToHScript(ItemInfo.item)
                if ItemH and (ItemH:GetCurrentCharges() < self:GetMaxStacks(ItemInfo.item_name) or self:GetMaxStacks(ItemInfo.item_name) <= 0) then
                    return true
                end
            end
        end
    end

    return false
end

---@param PlayerID integer
---@return string | nil
function ExtenderStash:FindClearItemSlot(PlayerID)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    for i = 0, 11 do
        local Name = "SLOT_"..i
        if self.Players[PlayerID].items[Name] == nil then
            return Name
        end
    end

    return nil
end

function ExtenderStash:GetItemSlot(PlayerID, Item)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    if not Item or Item:IsNull() then
        self:Log("Item is nil")
        return nil
    end

    local hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if hero == nil then
        self:Log("Hero is nil")
        return nil
    end

    local Check = {
        DOTA_ITEM_SLOT_1,
        DOTA_ITEM_SLOT_2,
        DOTA_ITEM_SLOT_3,
        DOTA_ITEM_SLOT_4,
        DOTA_ITEM_SLOT_5,
        DOTA_ITEM_SLOT_6,
        DOTA_ITEM_SLOT_7,
        DOTA_ITEM_SLOT_8,
        DOTA_ITEM_SLOT_9,
        DOTA_STASH_SLOT_1,
        DOTA_STASH_SLOT_2,
        DOTA_STASH_SLOT_3,
        DOTA_STASH_SLOT_4,
        DOTA_STASH_SLOT_5,
        DOTA_STASH_SLOT_6,
        DOTA_ITEM_NEUTRAL_ACTIVE_SLOT,
    }

    for _, SLOT in ipairs(Check) do
        local slotItem = hero:GetItemInSlot(SLOT)
        if slotItem and slotItem:entindex() == Item:entindex() then
            return SLOT, "DOTA"
        end
    end

    for SLOT_NAME, itemInfo in pairs(self.Players[PlayerID].items) do
        if itemInfo.item == Item:entindex() then
            return SLOT_NAME, "CUSTOM"
        end
    end

    return nil
end

---@param PlayerID integer
---@param Item CDOTA_Item
---@param Hero CDOTA_BaseNPC_Hero|nil
---@return number|string|nil, string|nil
function ExtenderStash:GetItemSlotBySource(PlayerID, Item, Hero)
    if not Hero or Hero:IsNull() then
        return self:GetItemSlot(PlayerID, Item)
    end

    local Check = {
        DOTA_ITEM_SLOT_1,
        DOTA_ITEM_SLOT_2,
        DOTA_ITEM_SLOT_3,
        DOTA_ITEM_SLOT_4,
        DOTA_ITEM_SLOT_5,
        DOTA_ITEM_SLOT_6,
        DOTA_ITEM_SLOT_7,
        DOTA_ITEM_SLOT_8,
        DOTA_ITEM_SLOT_9,
        DOTA_STASH_SLOT_1,
        DOTA_STASH_SLOT_2,
        DOTA_STASH_SLOT_3,
        DOTA_STASH_SLOT_4,
        DOTA_STASH_SLOT_5,
        DOTA_STASH_SLOT_6,
        DOTA_ITEM_NEUTRAL_ACTIVE_SLOT,
    }

    for _, SLOT in ipairs(Check) do
        local slotItem = Hero:GetItemInSlot(SLOT)
        if slotItem and slotItem:entindex() == Item:entindex() then
            return SLOT, "DOTA"
        end
    end

    for SLOT_NAME, itemInfo in pairs(self.Players[PlayerID].items) do
        if itemInfo.item == Item:entindex() then
            return SLOT_NAME, "CUSTOM"
        end
    end

    return nil
end

function ExtenderStash:IsThisItemAllowed(item_name)
    -- if table.contains(CUSTOM_INVENTORY_ALLOWED_ITEMS, item_name) then
    --     return true
    -- end
    -- return false
    return true
end

---@param ItemName string
---@return number?
function ExtenderStash:GetMaxStacks(ItemName)
    local KV = GetAbilityKeyValuesByName(ItemName)
    if KV and tonumber(KV["ItemStackableMax"]) ~= nil then
        return tonumber(KV["ItemStackableMax"])
    end

    return -1
end

function ExtenderStash:MergeStackable(targetItem, sourceItem)
    if not targetItem or targetItem:IsNull() or not sourceItem or sourceItem:IsNull() then
        return nil
    end

    if not targetItem:IsStackable() or targetItem:GetName() ~= sourceItem:GetName() then
        return true
    end

    local maxStacks = self:GetMaxStacks(targetItem:GetName())
    local targetCharges = targetItem:GetCurrentCharges()
    local sourceCharges = sourceItem:GetCurrentCharges()

    if maxStacks <= 0 then
        targetItem:SetCurrentCharges(targetCharges + sourceCharges)
        UTIL_Remove(sourceItem)
        return false
    end

    local total = targetCharges + sourceCharges
    if total <= maxStacks then
        targetItem:SetCurrentCharges(total)
        UTIL_Remove(sourceItem)
        return false
    else
        local diff = total - maxStacks
        targetItem:SetCurrentCharges(maxStacks)
        sourceItem:SetCurrentCharges(diff)
        return true
    end
end

---@param Hero CDOTA_BaseNPC_Hero
---@param slots number[]
---@return number|nil
function ExtenderStash:FindFirstEmptyHeroSlot(Hero, slots)
    for _, slot in ipairs(slots) do
        if Hero:GetItemInSlot(slot) == nil then
            return slot
        end
    end

    return nil
end

---@param hero CDOTA_BaseNPC_Hero
---@param Item CDOTA_Item
---@param slots number[]
---@return boolean
function ExtenderStash:TryPutItemInHeroSlots(hero, Item, slots)
    local emptySlot = self:FindFirstEmptyHeroSlot(hero, slots)
    if emptySlot == nil then
        return false
    end

    hero:AddItem(Item)

    local currentSlot = Item:GetItemSlot()
    if currentSlot == -1 then
        return false
    end

    if currentSlot ~= emptySlot then
        self:DOTASwapItems(hero, Item, emptySlot)
    end

    return true
end

---@param item CDOTA_Item
---@param hero CDOTA_BaseNPC_Hero
---@param playerId integer
function ExtenderStash:BindItemToHero(item, hero, playerId)
    if item == nil or item:IsNull() or hero == nil or hero:IsNull() then
        return false
    end

    item.iPlayerID = playerId
    item.hBoundHero = hero

    if item.SetPurchaser ~= nil then
        pcall(function()
            item:SetPurchaser(hero)
        end)
    end

    return true
end

---@param playerId integer
---@param item CDOTA_Item
---@return boolean
function ExtenderStash:TryPutItemInCustomStash(playerId, item)
    local hero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hero == nil then
        return false
    end

    if not self.Players[playerId] then
        self.Players[playerId] = { items = {} }
    end

    local bestSlotName = self:FindBestSlotForItem(playerId, item, nil)
    if bestSlotName == nil then
        return false
    end

    local slotData = self.Players[playerId].items[bestSlotName]
    if slotData == nil then
        self.Players[playerId].items[bestSlotName] = {
            item = item:entindex(),
            item_name = item:GetName(),
        }
        self:PlaceInStorage(playerId, item)
        self:BindItemToHero(item, hero, playerId)
        self:UpdatePlayerNetTable(playerId)
        return true
    end

    local targetItem = EntIndexToHScript(slotData.item)
    if targetItem and self:IsItemCanBeMerged(playerId, item) then
        local notMergedFully = self:MergeStackable(targetItem, item)
        if notMergedFully == false then
            self:UpdatePlayerNetTable(playerId)
            return true
        end
    end

    local clearSlot = self:FindClearItemSlot(playerId)
    if clearSlot == nil then
        return false
    end

    self.Players[playerId].items[clearSlot] = {
        item = item:entindex(),
        item_name = item:GetName(),
    }
    self:PlaceInStorage(playerId, item)
    self:BindItemToHero(item, hero, playerId)
    self:UpdatePlayerNetTable(playerId)
    return true
end

---@param playerId integer
---@param itemName string
---@return CDOTA_Item|nil
function ExtenderStash:GiveItemToPlayerStashInventoryOrDrop(playerId, itemName)
    if not PlayerResource:IsValidPlayerID(playerId) then
        self:Log("Player is nil")
        return nil
    end

    local hero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hero == nil then
        self:Log("Hero is nil")
        return nil
    end

    if type(itemName) ~= "string" or itemName == "" then
        self:Log("Item name is nil")
        return nil
    end

    local item = CreateItem(itemName, hero:GetPlayerOwner(), hero:GetPlayerOwner())
    if item == nil then
        self:Log("Item is nil")
        return nil
    end

    self:BindItemToHero(item, hero, playerId)

    if self:TryPutItemInCustomStash(playerId, item) then
        return item
    end

    local stashSlots = {
        DOTA_STASH_SLOT_1,
        DOTA_STASH_SLOT_2,
        DOTA_STASH_SLOT_3,
        DOTA_STASH_SLOT_4,
        DOTA_STASH_SLOT_5,
        DOTA_STASH_SLOT_6,
    }

    if self:TryPutItemInHeroSlots(hero, item, stashSlots) then
        return item
    end

    local inventorySlots = {
        DOTA_ITEM_SLOT_1,
        DOTA_ITEM_SLOT_2,
        DOTA_ITEM_SLOT_3,
        DOTA_ITEM_SLOT_4,
        DOTA_ITEM_SLOT_5,
        DOTA_ITEM_SLOT_6,
    }

    if self:TryPutItemInHeroSlots(hero, item, inventorySlots) then
        return item
    end

    CreateItemOnPositionSync(hero:GetAbsOrigin(), item)
    return item
end

function ExtenderStash:GetSlot(PlayerID, slot, Hero)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil, "NONE", -1
    end

    local Hero = Hero or PlayerResource:GetSelectedHeroEntity(PlayerID)
    if Hero == nil then
        self:Log("Hero is nil")
        return nil, "NONE", -1
    end

    if type(slot) == "string" then
        if self.Players[PlayerID].items[slot] ~= nil then
            return self.Players[PlayerID].items[slot], "CUSTOM", slot
        else
            return nil, "CUSTOM", slot
        end
    end

    if type(slot) == "number" then
        local Item = Hero:GetItemInSlot(slot)
        if Item then
            return Item, "DOTA", slot
        else
            return nil, "DOTA", slot
        end
    end

    if type(slot) == "table" and slot.IsItem ~= nil then
        local ItemSlot, ItemSlotType = self:GetItemSlotBySource(PlayerID, slot, Hero)
        if ItemSlot ~= nil then
            if ItemSlotType == "CUSTOM" then
                return self.Players[PlayerID].items[ItemSlot], ItemSlotType, ItemSlot
            end

            return slot, ItemSlotType, ItemSlot
        end

        return slot, "DOTA", slot:GetItemSlot()
    end

    return nil, "NONE", -1
end

---Сбросывает перезарядку предметов, хранящихся в кастомном стеше игрока.
---Используется при общем рефреше героя (конец PVP, аегис, debug tool),
---чтобы предметы в extender_stash вели себя так же, как предметы в инвентаре героя.
---@param playerId integer
---@param exceptions table | nil       -- {item_name = true}, чтобы пропустить отдельные предметы
function ExtenderStash:RefreshItemsCooldown(playerId, exceptions)
    if exceptions == nil then exceptions = {} end

    local playerData = self.Players[playerId]
    if playerData == nil or playerData.items == nil then return end

    for _, slotData in pairs(playerData.items) do
        if slotData and slotData.item then
            local item = EntIndexToHScript(slotData.item)
            if item and not item:IsNull() and item.EndCooldown then
                local itemName = item:GetName()
                if exceptions[itemName] == nil then
                    item:EndCooldown()
                    if itemName == "item_hand_of_midas_lua" then
                        item:SetCurrentCharges(2) --todo поправить костыль, синхронно с Util:RefreshAbilityAndItem
                    end
                end
            end
        end
    end
end

function ExtenderStash:Log(...)
    if not self.LogsEnabled then return end

    logger:Log(...)
end