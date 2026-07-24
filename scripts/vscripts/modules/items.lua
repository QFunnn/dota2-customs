--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


Items = Items or class({})

RESERVED_BOOK_SLOTS = {
    ["SLOT_0"] = "item_relearn_torn_page_lua",
    ["SLOT_1"] = "item_relearn_book_lua",
}

function Items:Init()
    print("[Items] Module loaded!")
    self.bStarted = false

    self.LogsEnabled = false
    self.Players = {}

    CustomGameEventManager:RegisterListener("items_move_to_custom_stash", function(_, event) self:OnPlayerWantMoveToCustomStash(event) end)
    CustomGameEventManager:RegisterListener("items_move_from_custom_stash", function(_, event) self:OnPlayerWantMoveFromCustomStash(event) end)
    CustomGameEventManager:RegisterListener("items_sell_from_custom_stash", function(_, event) self:OnPlayerWantSellFromCustomStash(event) end)
    CustomGameEventManager:RegisterListener("items_move_neutral_from_custom_stash", function(_, event) self:OnPlayerWantMoveNeutralFromCustomStash(event) end)
end

function Items:SetupPlayer(PlayerID)
    if not self.Players[PlayerID] then
        self.Players[PlayerID] = {
            items = {},
        }

        PlayerTables:SetTableValue("player_"..PlayerID, "bonus_stash_items", self.Players[PlayerID].items)
    end
end

function Items:OnPlayerWantSellFromCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return
    end

    local Item = EntIndexToHScript(event.item)

    if not self.Players[event.PlayerID] then
        self:Log("Player is nil")
        return false
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
    if Hero == nil then
        self:Log("Hero is nil")
        return false
    end

    local ItemSlot, SlotType = self:GetItemSlot(event.PlayerID, Item)
    if SlotType == "CUSTOM" then
        -- [#38] Книга/страница-награда из бонус-тайника — use-only, продавать нельзя.
        -- (Магазинные версии продаются нативно из инвентаря и этого блока не касаются.)
        local sRewardName = Item.GetAbilityName and Item:GetAbilityName() or ""
        if Item.IsSellable and not Item:IsSellable() then
            self:Log("item not sellable (ItemSellable 0)")
            return false
        end
        self.Players[event.PlayerID].items[ItemSlot] = nil

        local PlayerID = event.PlayerID
        local ItemCost = Item:GetCost() or 0
        local ItemCharges = (Item:IsStackable() and Item:GetCurrentCharges() or 1)
        if ItemCharges < 1 then ItemCharges = 1 end

        -- [NP-17] Продажа из бонус-тайника всегда даёт детерминированные 50% (по числу зарядов):
        -- считаем золото сами и уничтожаем сущность, БЕЗ нативного Hero:SellItem.
        -- Почему: при Hero:AddItem свежесозданного reward-предмета движок проставлял ему время
        -- покупки = «сейчас» → нативная продажа попадала в grace-окно полного возврата, отсюда был
        -- разнобой «первая страница за 1000, остальные за 500». Теперь сумма стабильная.
        -- ВАЖНО: магазинные страницы лежат в обычном инвентаре и продаются НАТИВНО (этот хендлер
        -- их не касается) — они сохраняют полный возврат в grace-окне для отмены случайной покупки.
        local sellGold = math.floor(ItemCost * ItemCharges * 0.5)

        if Item:GetItemSlot() and Item:GetItemSlot() >= 0 then
            Hero:TakeItem(Item)
        end
        UTIL_Remove(Item)

        if sellGold > 0 then
            PlayerResource:ModifyGold(PlayerID, sellGold, true, DOTA_ModifyGold_SellItem)
        end

        self:UpdatePlayerNetTable(PlayerID)
    end
end

function Items:OnPlayerWantMoveNeutralFromCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return
    end

    local Item = EntIndexToHScript(event.item)

    if not self.Players[event.PlayerID] then
        self:Log("Player is nil")
        return false
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)
    if Hero == nil then 
        self:Log("Hero is nil")
        return false
    end

    local ItemSlot, SlotType = self:GetItemSlot(event.PlayerID, Item)
    if SlotType == "CUSTOM" then
        self.Players[event.PlayerID].items[ItemSlot] = nil

        self:UpdatePlayerNetTable(event.PlayerID)
    end
end

function Items:OnPlayerWantMoveToCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return
    end

    local Item = EntIndexToHScript(event.item)

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

    if not self:IsThisItemAllowed(Item:GetName()) then
        self:Log("Item is not allowed")
        return
    end

    if event.slot and RESERVED_BOOK_SLOTS[event.slot] and Item:GetName() ~= RESERVED_BOOK_SLOTS[event.slot] then
        self:Log("Slot is reserved for books")
        local player = PlayerResource:GetPlayer(event.PlayerID)
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="error_stash_reserved_slot"})
        end
        return
    end

    self:SwapItems(event.PlayerID, Item, event.slot)
end

function Items:OnPlayerWantMoveFromCustomStash(event)
    if event.item == nil or EntIndexToHScript(event.item) == nil then
        self:Log("Item is nil")
        return
    end

    local Item = EntIndexToHScript(event.item)

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

    self:SwapItems(event.PlayerID, Item, event.slot)
end

function Items:UpdatePlayerNetTable(PlayerID)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    -- Подтягиваем актуальные чарджи прямо перед отправкой — иначе клиент
    -- не знает количество (книги/страницы в стэше показывают пусто пока
    -- не пересоздать entity через свап с обычным инвентарём).
    for _, itemInfo in pairs(self.Players[PlayerID].items) do
        if itemInfo and itemInfo.item then
            local hItem = EntIndexToHScript(itemInfo.item)
            if hItem and not hItem:IsNull() then
                itemInfo.charges = hItem:GetCurrentCharges() or 0
            end
        end
    end

    PlayerTables:SetTableValue("player_"..PlayerID, "bonus_stash_items", self.Players[PlayerID].items)
end

function Items:SwapItems(PlayerID, slot1, slot2)
    if slot1 == nil and slot2 == nil then
        self:Log("Slot is nil")
        return false
    end

    if slot1 == nil then
        slot1 = self:FindClearItemSlot(PlayerID)
    end

    if slot2 == nil then
        slot2 = self:FindClearItemSlot(PlayerID)
    end

    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return false
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if Hero == nil then 
        self:Log("Hero is nil")
        return false
    end

    local Slot1_Item, Slot1_Type, Slot1 = self:GetSlot(PlayerID, slot1)
    local Slot2_Item, Slot2_Type, Slot2 = self:GetSlot(PlayerID, slot2)

    -- print("========================================")
    -- print(Slot1_Item, Slot1_Type, Slot1)
    -- if type(Slot1_Item) == "table" then
    --     DeepPrintTable(Slot1_Item)
    -- end
    -- print(Slot2_Item, Slot2_Type, Slot2)
    -- if type(Slot2_Item) == "table" then
    --     DeepPrintTable(Slot2_Item)
    -- end

    if Slot1_Type == "NONE" or Slot2_Type == "NONE" or (Slot1_Item == nil and Slot2_Item == nil) then
        self:Log("Slot is nil")
        return false
    end

    if Slot1_Type == "DOTA" and Slot1_Type == Slot2_Type and Slot1 ~= -1 and Slot2 ~= -1 then
        -- print("Swap doto")
        self:_DOTASwapItems(Hero, Slot1, Slot2)
    end

    if Slot1_Type == "CUSTOM" and Slot1_Type == Slot2_Type then
        -- Если бросаем одинаковый предмет на одинаковый — объединяем стак в
        -- слот-назначение (Slot2), а исходный (Slot1) очищаем. Иначе обычный
        -- свап. Применимо к книгам/страницам которые приходят в бонусный тайник
        -- каждые 10 волн — игрок ожидает merge, а не swap.
        if Slot1_Item and Slot2_Item and Slot1_Item.item_name == Slot2_Item.item_name and Slot1 ~= Slot2 then
            local h1 = EntIndexToHScript(Slot1_Item.item)
            local h2 = EntIndexToHScript(Slot2_Item.item)
            if h1 and not h1:IsNull() and h2 and not h2:IsNull() then
                local sum = (h1:GetCurrentCharges() or 0) + (h2:GetCurrentCharges() or 0)
                h2:SetCurrentCharges(sum)
                UTIL_Remove(h1)
                self.Players[PlayerID].items[Slot1] = nil
                self:UpdatePlayerNetTable(PlayerID)
                return true
            end
        end
        -- print("Swap in custom")
        self.Players[PlayerID].items[Slot1] = Slot2_Item
        self.Players[PlayerID].items[Slot2] = Slot1_Item
    end

    local MakeDotaToCustomSwap = function()
        local DotaItem = Slot1_Item
        if Slot2_Type == "DOTA" then
            DotaItem = Slot2_Item
        end
        local CustomItem = Slot2_Item
        if Slot1_Type == "CUSTOM" then
            CustomItem = Slot1_Item
        end

        local DotaSlot = Slot1
        if Slot2_Type == "DOTA" then
            DotaSlot = Slot2
        end
        local CustomSlot = Slot2
        if Slot1_Type == "CUSTOM" then
            CustomSlot = Slot1
        end

        -- print("DOTA", DotaItem, DotaSlot)
        -- print("CUSTOM", CustomItem, CustomSlot)

        if DotaItem ~= nil then
            local BestSlotName = self:FindBestSlotForItem(PlayerID, DotaItem, CustomSlot)
            if BestSlotName == nil then
                self:Log("Slot is nil")
                return false
            end

            local BestSlot = self.Players[PlayerID].items[BestSlotName]

            if BestSlot == nil then
                self.Players[PlayerID].items[BestSlotName] = {
                    item = DotaItem:entindex(),
                    item_name = DotaItem:GetName(),
                }

                if DotaSlot ~= -1 then
                    Hero:TakeItem(DotaItem)

                    self:FixEnchant(PlayerID, Hero, DotaItem)
                end
            else
                local BestSlot_Item = EntIndexToHScript(BestSlot.item)
                if DotaSlot == 16 and BestSlot_Item and not KeyValues:IsNeutralItem(BestSlot_Item:GetName()) or (KeyValues:IsNeutralItem(BestSlot_Item:GetName()) and DotaSlot <= 5) then
                    self:Log("Item is not for this slot")
                    return false
                end

                if self:IsItemCanBeMerged(PlayerID, DotaItem) then
                    if BestSlot_Item then
                        local bItemNotMergedFully = self:MergeStackable(BestSlot_Item, DotaItem)
                        if bItemNotMergedFully then
                            local NewSlot = CustomSlot
                            if NewSlot == BestSlotName then
                                NewSlot = self:FindClearItemSlot(PlayerID)
                            end
                            if NewSlot ~= nil then
                                self:SwapItems(PlayerID, DotaItem, NewSlot)
                            end
                        end
                    end
                else
                    if DotaSlot ~= -1 then
                        Hero:TakeItem(DotaItem)

                        if BestSlot_Item then
                            Hero:AddItem(BestSlot_Item)

                            self:_DOTASwapItems(Hero, BestSlot_Item, DotaSlot)
                        end

                        self.Players[PlayerID].items[BestSlotName] = {
                            item = DotaItem:entindex(),
                            item_name = DotaItem:GetName(),
                        }

                        self:FixEnchant(PlayerID, Hero, DotaItem)
                    else
                        local ClearSlot = self:FindClearItemSlot(PlayerID)
                        if ClearSlot ~= nil then
                            self.Players[PlayerID].items[ClearSlot] = {
                                item = DotaItem:entindex(),
                                item_name = DotaItem:GetName(),
                            }
                        else
                            CreateItemOnPositionSync(Hero:GetAbsOrigin(), DotaItem)
                        end
                    end
                end
            end
        elseif CustomItem ~= nil then
            local CustomItem_Item = EntIndexToHScript(CustomItem.item)
            if CustomItem_Item then

                if (DotaSlot == 16 and not KeyValues:IsNeutralItem(CustomItem_Item:GetName())) or (KeyValues:IsNeutralItem(CustomItem_Item:GetName()) and DotaSlot <= 5) then
                    self:Log("Item is not for this slot")
                    return false
                end

                -- Fix: движок Dota 2 не позволяет иметь два отдельных стака
                -- одного стакаемого TP-override предмета — AddItem всегда мерджит.
                -- Поэтому смок из кастом-стэша всегда идёт в TP-слот (мердж чарджей).
                if CustomItem_Item:GetName() == "item_smoke_of_deceit_custom" then
                    local tpSmoke = Hero:GetItemInSlot(15)
                    if tpSmoke and not tpSmoke:IsNull() and tpSmoke:GetName() == "item_smoke_of_deceit_custom" then
                        -- TP-смок есть: просто добавляем чарджи
                        local customCharges = CustomItem_Item:GetCurrentCharges()
                        tpSmoke:SetCurrentCharges(tpSmoke:GetCurrentCharges() + customCharges)
                        UTIL_Remove(CustomItem_Item)
                    else
                        -- Нет TP-смока: AddItem поставит в слот 15
                        Hero:AddItem(CustomItem_Item)
                    end
                else
                    Hero:AddItem(CustomItem_Item)

                    self:_DOTASwapItems(Hero, CustomItem_Item, DotaSlot)

                    self:FixEnchant(PlayerID, Hero, CustomItem_Item)
                end
            end

            self.Players[PlayerID].items[CustomSlot] = nil
        end
    end

    if (Slot1_Type == "DOTA" and Slot2_Type == "CUSTOM") or (Slot1_Type == "CUSTOM" and Slot2_Type == "DOTA") then
        if MakeDotaToCustomSwap() == false then
            return false
        end
    end

    self:UpdatePlayerNetTable(PlayerID)

    return true
end

function Items:_DOTASwapItems(Hero, slot1, slot2)
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

            if (Hero:GetItemInSlot(Slot1) and KeyValues:IsNeutralItem(Hero:GetItemInSlot(Slot1):GetName())) or (Hero:GetItemInSlot(Slot2) and KeyValues:IsNeutralItem(Hero:GetItemInSlot(Slot2):GetName())) or
                (type(slot1) == "table" and slot1.IsItem ~= nil and KeyValues:IsNeutralItem(slot1:GetName())) or (type(slot2) == "table" and slot2.IsItem ~= nil and KeyValues:IsNeutralItem(slot2:GetName())) then
                NeutralItems:FixEnchant(PlayerID)
            end
        end
    end, 0)
end

function Items:UpdateItemBySlot(Unit, Item)
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

function Items:FindBestSlotForItem(PlayerID, Item, slot)
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
            if RESERVED_BOOK_SLOTS[Name] == nil and self.Players[PlayerID].items[Name] == nil then
                return Name
            end
        end
    end

    -- Если переданный slot зарезервирован под книгу/страницу, а наш Item — не
    -- та зарезервированная книга — отклоняем всю операцию (возвращаем nil) и
    -- шлём клиенту ошибку. Без этого свап книги из стэша на предмет в инвентаре
    -- запихивал чужой предмет в книжный слот, либо тихо его сваповал в свободный
    -- слот — пользователю непонятно что произошло.
    if slot ~= nil and RESERVED_BOOK_SLOTS[slot] ~= nil and RESERVED_BOOK_SLOTS[slot] ~= Item:GetName() then
        local player = PlayerResource:GetPlayer(PlayerID)
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="error_stash_reserved_slot"})
        end
        return nil
    end

    return slot
end

function Items:IsItemCanBeMerged(PlayerID, Item)
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

function Items:FindClearItemSlot(PlayerID)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    for i = 0, 11 do
        local Name = "SLOT_"..i
        if RESERVED_BOOK_SLOTS[Name] == nil and self.Players[PlayerID].items[Name] == nil then
            return Name
        end
    end

    return nil
end

function Items:GetItemSlot(PlayerID, Item)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil
    end

    if not Item or Item:IsNull() then
        self:Log("Item is nil")
        return nil
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if Hero == nil then 
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
        local SlotItem = Hero:GetItemInSlot(SLOT)
        if SlotItem and SlotItem:entindex() == Item:entindex() then
            return SLOT, "DOTA"
        end
    end

    for SLOT_NAME, ItemInfo in pairs(self.Players[PlayerID].items) do
        if ItemInfo.item == Item:entindex() then
            return SLOT_NAME, "CUSTOM"
        end
    end

    return nil
end

function Items:AddItemToCustomStash(PlayerID, hItem, slotName)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return false
    end

    if not hItem or hItem:IsNull() then
        self:Log("Item is nil")
        return false
    end

    if slotName == nil then
        slotName = self:FindClearItemSlot(PlayerID)
    end

    if slotName == nil then
        return false
    end

    self.Players[PlayerID].items[slotName] = {
        item = hItem:entindex(),
        item_name = hItem:GetName(),
    }

    self:UpdatePlayerNetTable(PlayerID)
    return true
end

function Items:IsThisItemAllowed(item_name)
    -- if table.contains(CUSTOM_INVENTORY_ALLOWED_ITEMS, item_name) then
    --     return true
    -- end
    -- return false
    return true
end

function Items:GetMaxStacks(ItemName)
    local KV = GetAbilityKeyValuesByName(ItemName)
    if KV and tonumber(KV["ItemStackableMax"]) ~= nil then
        return tonumber(KV["ItemStackableMax"])
    end

    return -1
end

function Items:FixEnchant(PlayerID, Hero, Item)
    if Hero == nil then
        self:Log("Hero is nil")
        return
    end

    if not Item or Item:IsNull() then
        self:Log("Item is nil")
        return nil
    end
    
    if not KeyValues:IsNeutralItem(Item:GetName()) then return end

    Hero:SetContextThink(DoUniqueString("Swap"), function(ent)
        NeutralItems:FixEnchant(PlayerID)
    end, 0)
end

function Items:MergeStackable(targetItem, sourceItem)
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

function Items:GetSlot(PlayerID, slot)
    if not self.Players[PlayerID] then
        self:Log("Player is nil")
        return nil, "NONE", -1
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
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
        local ItemSlot, ItemSlotType = self:GetItemSlot(PlayerID, slot)
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

function Items:Log(string)
    if not self.LogsEnabled then return end

    print("[ITEMS] Module: "..string)
    -- print(string.format("Вызвана из %d", debug.getinfo(2, "l").currentline))
end

if not Items.bStarted then Items:Init() end