--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if NeutralItems == nil then 
    NeutralItems = class({}) 
end

function NeutralItems:Init()
    print('[NeutralItems] Module is active!')
    self.bStarted = true

    self.Players = {}

    CustomGameEventManager:RegisterListener("neutrals_make_craft", function(_, event) self:OnPlayerCraftNeutralItem(event) end)
    CustomGameEventManager:RegisterListener("neutrals_player_want_swap", function(_, event) self:OnPlayerWantSwapNeutralItems(event) end)
    CustomGameEventManager:RegisterListener("neutrals_move_item_to_stash", function(_, event) self:OnPlayerWantMoveItemToStash(event) end)
    CustomGameEventManager:RegisterListener("neutrals_get_item_from_stash", function(_, event) self:OnPlayerWantGetItemFromStash(event) end)
end

function NeutralItems:SetupPlayer(PlayerID)
    if not self.Players[PlayerID] then
        self.Players[PlayerID] = {
            items = {},
            current_tier = -1,
            schedule = {},

            info = {
                next_tier = 1,
                next_round = GIVE_NEUTRALS_ROUNDS[1],
                craft_count = 0,
                current_craft = nil,
            },
        }

        self:IncreaseNeutralTier(PlayerID)

        PlayerTables:SetTableValue("player_"..PlayerID.."_global", "neutrals_list", self.Players[PlayerID].items)
    end
end

function NeutralItems:IncreaseNeutralTier(PlayerID)
    if not self.Players[PlayerID] or self.Players[PlayerID].current_tier == 5 then return end

    self.Players[PlayerID].current_tier = self.Players[PlayerID].current_tier + 1

    if self.Players[PlayerID].current_tier >= 5 then
        self.Players[PlayerID].info.next_round = 0
        self.Players[PlayerID].info.next_tier = 0
    else
        self.Players[PlayerID].info.next_round = GIVE_NEUTRALS_ROUNDS[self.Players[PlayerID].current_tier+1]
        self.Players[PlayerID].info.next_tier = self.Players[PlayerID].current_tier + 1
    end

    PlayerTables:SetTableValue("player_"..PlayerID, "neutral", self.Players[PlayerID].info)
end

function NeutralItems:ClearNeutral(PlayerID)
    if not self.Players[PlayerID] then return false end

    self.Players[PlayerID].info.current_craft = nil

    PlayerTables:SetTableValue("player_"..PlayerID, "neutral", self.Players[PlayerID].info)
end

function NeutralItems:GiveNeutral(PlayerID, Tier, MaxItems, MaxEnchants, ExceptionsItems, ExceptionsEnchants, bExcludePrevTier, bSchedule)
    if not self.Players[PlayerID] then return false end

    local NeutralTier = Tier
    if NeutralTier == nil then
        NeutralTier = self.Players[PlayerID].current_tier
    end
    
    local NeutralMaxItems = MaxItems
    if NeutralMaxItems == nil then
        NeutralMaxItems = NEUTRALS_ITEMS_PER_TIER_DEFAULT
    end

    local NeutralMaxEnchants = MaxEnchants
    if NeutralMaxEnchants == nil then
        NeutralMaxEnchants = NEUTRALS_ENCHANTMENTS_PER_TIER_DEFAULT
    end

    if self.Players[PlayerID].info.current_craft == nil then

        local RandomItems = self:GetRandomItemsForPlayerByTier(PlayerID, NeutralTier, NeutralMaxItems, ExceptionsItems, bExcludePrevTier)
        local RandomEnchants = self:GetRandomEnchantmentsForPlayerByTier(PlayerID, NeutralTier, NeutralMaxEnchants, ExceptionsEnchants)

        self.Players[PlayerID].info.current_craft = {
            tier = NeutralTier,
            items = RandomItems,
            enchants = RandomEnchants,
        }

        PlayerTables:SetTableValue("player_"..PlayerID, "neutral", self.Players[PlayerID].info)

        return true
    elseif bSchedule == true then
        table.insert(self.Players[PlayerID].schedule, {
            tier = NeutralTier,
            max_items = NeutralMaxItems,
            max_enchants = NeutralMaxEnchants,
            exception_items = ExceptionsItems,
            exception_enchants = ExceptionsEnchants,
            exclude_prev_tier = bExcludePrevTier,
        })

        self.Players[PlayerID].info.craft_count = #self.Players[PlayerID].schedule

        PlayerTables:SetTableValue("player_"..PlayerID, "neutral", self.Players[PlayerID].info)
        
        return true
    end

    return false
end

function NeutralItems:OnPlayerCraftNeutralItem(event)
    local PlayerID = event.PlayerID

    if not self.Players[PlayerID] then return end

    local ItemName = event.item
    local EnchantName = event.enchant

    if ItemName ~= "" and ItemName ~= nil and EnchantName ~= "" and EnchantName ~= nil and self.Players[PlayerID].info.current_craft ~= nil then
        local Tier = self.Players[PlayerID].info.current_craft.tier
        local EnchantInfo = KeyValues:GetEnchantInfo(Tier, EnchantName)
        if EnchantInfo then

            local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
            if Hero then
                local OldNeutralItem = Hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_ACTIVE_SLOT)
                if OldNeutralItem then
                    self:OnPlayerWantMoveItemToStash({PlayerID = PlayerID, entindex=OldNeutralItem:entindex()})
                end
            end

            local FreeSlot = self:GetFreeSlotForNeutralItem(Hero, PlayerID)
            if FreeSlot and Hero then
                local Item = Hero:AddItemByName(ItemName)
                -- if FreeSlot == DOTA_ITEM_NEUTRAL_ACTIVE_SLOT then
                --     local PassiveItem = Hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
                --     if PassiveItem then
                --         UTIL_Remove(PassiveItem)
                --     end
                -- end
                Item:SetContextThink(DoUniqueString("Swap"), function(ent)
                    if Hero and not Hero:IsNull() and FreeSlot and Item:GetItemSlot() ~= FreeSlot then
                        Hero:SwapItems(Item:GetItemSlot(), FreeSlot)

                        NeutralItems:FixEnchant(PlayerID)
                    end
                    -- if FreeSlot == DOTA_ITEM_NEUTRAL_ACTIVE_SLOT then
                    --     local Enchant = Hero:AddItemByName(EnchantName)
                    --     if Enchant then
                    --         Enchant:SetLevel(EnchantInfo.level)
                    --         Enchant:RefreshIntrinsicModifier()

                    --         local ModifName = Enchant:GetIntrinsicModifierName()
                    --         if ModifName then
                    --             local Modif = Hero:FindModifierByName(ModifName)
                    --             if Modif then
                    --                 Modif:ForceRefresh()
                    --                 Modif:SendBuffRefreshToClients()
                    --             end
                    --         end

                    --         Hero:CalculateGenericBonuses()
                    --         Hero:CalculateStatBonus(true)
                    --     end
                    -- end
                end, 0)

                self.Players[PlayerID].items[Item:entindex()] = {
                    item_name = ItemName,
                    enchant = EnchantName,
                    level = EnchantInfo.level,
                    tier = KeyValues:GetNeutralItemTier(ItemName),
                    craft_time = GameRules:GetGameTime(),
                    craft_tier = Tier,
                    place = "INVENTORY"
                }

                self.Players[PlayerID].info.current_craft = nil

                PlayerTables:SetTableValue("player_"..PlayerID, "neutral", self.Players[PlayerID].info)
                PlayerTables:SetTableValue("player_"..PlayerID.."_global", "neutrals_list", self.Players[PlayerID].items)

                local Next = self.Players[PlayerID].schedule[1]
                if Next ~= nil then
                    table.remove(self.Players[PlayerID].schedule, 1)

                    self.Players[PlayerID].info.craft_count = #self.Players[PlayerID].schedule

                    self:GiveNeutral(PlayerID, Next.tier, Next.max_items, Next.max_enchants, Next.exception_items, Next.exception_enchants, Next.exclude_prev_tier)
                end
            else
                local player = PlayerResource:GetPlayer(PlayerID)
                if player then
                    CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_full_slots"})
                end

                return
            end
        end
    end
end

function NeutralItems:OnPlayerWantSwapNeutralItems(event)
    local PlayerID = event.PlayerID

    if not self.Players[PlayerID] then return end

    local iDragItem = event.dragging
    local iDropItem = event.drop

    local DragItem = EntIndexToHScript(iDragItem)
    local DropItem = EntIndexToHScript(iDropItem)

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if DragItem and DropItem and DragItem:GetItemSlot() == DOTA_ITEM_NEUTRAL_ACTIVE_SLOT and Hero and DropItem:GetItemSlot() > 5 and KeyValues:IsNeutralItem(DropItem:GetName()) then
        Hero:SwapItems(DragItem:GetItemSlot(), DropItem:GetItemSlot())
        Hero:SetContextThink(DoUniqueString("Swap"), function(ent)
            if Hero and not Hero:IsNull() then
                NeutralItems:FixEnchant(PlayerID)
            end
        end, 0)
    end
end

function NeutralItems:OnPlayerWantMoveItemToStash(event)
    local PlayerID = event.PlayerID

    if not self.Players[PlayerID] then return end

    local iItem = event.entindex

    if iItem == nil then return end

    local hItem = EntIndexToHScript(iItem)

    if hItem == nil then return end

    if self.Players[PlayerID].items[iItem] == nil or self.Players[PlayerID].items[iItem].place == "STASH" then return end

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)

    if Hero == nil then return end

    self.Players[PlayerID].items[iItem].place = "STASH"

    Hero:TakeItem(hItem)

    Hero:SetContextThink(DoUniqueString("Stash"), function(ent)
        if Hero and not Hero:IsNull() then
            NeutralItems:FixEnchant(PlayerID)
        end
    end, 0)

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "neutrals_list", self.Players[PlayerID].items)
end

function NeutralItems:OnPlayerWantGetItemFromStash(event)
    local PlayerID = event.PlayerID

    if not self.Players[PlayerID] then return end

    local iUnit = event.unit
    local iItem = tonumber(event.item)

    if iUnit == nil or iItem == nil then return end

    local hUnit = EntIndexToHScript(iUnit)
    local hItem = EntIndexToHScript(iItem)

    if hUnit == nil or hItem == nil then return end

    if self.Players[PlayerID].items[iItem] == nil or self.Players[PlayerID].items[iItem].place == "INVENTORY" then return end

    if not hUnit:HasInventory() or not hUnit:IsRealHero() then return end

    -- SECURITY: класть нейтралку из своего тайника можно только в СВОЕГО героя.
    -- event.unit — клиентский entindex; без этой проверки можно было запихнуть свой
    -- итем в инвентарь чужого героя (грифинг). Владелец героя — server-authoritative.
    if hUnit:GetPlayerOwnerID() ~= PlayerID then return end

    -- Бан: забирать нейтралки из тайника можно только когда игрок на базе (MAIN).
    -- Раньше можно было свапать нейтралки прямо во время дефа крипов — слишком
    -- сильный лайв-свап. Теперь блокируем когда герой не на главной арене.
    local PlayerInfo = Players:GetPlayer(PlayerID)
    if PlayerInfo and PlayerInfo.arena ~= "MAIN" then
        local player = PlayerResource:GetPlayer(PlayerID)
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="error_stash_only_on_base"})
        end
        return
    end

    local FreeSlot = self:GetFreeSlotForNeutralItem(hUnit, PlayerID)
    if FreeSlot then
        hUnit:AddItem(hItem)
        hItem:SetContextThink(DoUniqueString("Swap"), function(ent)
            if hUnit and not hUnit:IsNull() and FreeSlot and hItem:GetItemSlot() ~= FreeSlot then
                hUnit:SwapItems(hItem:GetItemSlot(), FreeSlot)

                NeutralItems:FixEnchant(PlayerID)
            end
        end, 0)

        self.Players[PlayerID].items[iItem].place = "INVENTORY"

        PlayerTables:SetTableValue("player_"..PlayerID.."_global", "neutrals_list", self.Players[PlayerID].items)
    else
        local player = PlayerResource:GetPlayer(PlayerID)
        if player then
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {message="dota_hud_error_full_slots"})
        end

        return
    end
end

function NeutralItems:FixEnchant(PlayerID)
    if not self.Players[PlayerID] then return end
     
    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    if Hero == nil then return end

    local ItemInActive = Hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_ACTIVE_SLOT)
    if ItemInActive then
        local ItemName = ItemInActive:GetName()
        local NeedEnchant = nil
        local NeedLevel = 1

        if self.Players[PlayerID].items[ItemInActive:entindex()] then
            NeedEnchant = self.Players[PlayerID].items[ItemInActive:entindex()].enchant
            NeedLevel = self.Players[PlayerID].items[ItemInActive:entindex()].level
        end
        

        local ItemInPassive = Hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
        -- print(ItemName, NeedEnchant, NeedLevel)
        if ItemInPassive == nil and NeedEnchant ~= nil then
            local Enchant = Hero:AddItemByName(NeedEnchant)
            Enchant:SetLevel(NeedLevel)
            Enchant:RefreshIntrinsicModifier()

            local ModifName = Enchant:GetIntrinsicModifierName()
            if ModifName then
                local Modif = Hero:FindModifierByName(ModifName)
                if Modif then
                    Modif:ForceRefresh()
                    Modif:SendBuffRefreshToClients()
                end
            end
            Hero:CalculateGenericBonuses()
            Hero:CalculateStatBonus(true)
        elseif ItemInPassive ~= nil and NeedEnchant == nil then
            UTIL_Remove(ItemInPassive)
        elseif ItemInPassive ~= nil and NeedEnchant ~= nil and ItemInPassive:GetName() ~= NeedEnchant then
            UTIL_Remove(ItemInPassive)
            Hero:SetContextThink(DoUniqueString("Swap"), function(ent)
                if Hero and not Hero:IsNull() then
                    local Enchant = Hero:AddItemByName(NeedEnchant)
                    if Enchant then
                        Enchant:SetLevel(NeedLevel)

                        Enchant:RefreshIntrinsicModifier()

                        local ModifName = Enchant:GetIntrinsicModifierName()
                        if ModifName then
                            local Modif = Hero:FindModifierByName(ModifName)
                            if Modif then
                                Modif:ForceRefresh()
                                Modif:SendBuffRefreshToClients()
                            end
                        end

                        Hero:CalculateGenericBonuses()
                        Hero:CalculateStatBonus(true)
                    end
                end
            end, 0)
        elseif ItemInPassive ~= nil and NeedEnchant ~= nil and ItemInPassive:GetName() == NeedEnchant and ItemInPassive:GetLevel() ~= NeedLevel then
            ItemInPassive:SetLevel(NeedLevel)
            
            ItemInPassive:RefreshIntrinsicModifier()

            local ModifName = ItemInPassive:GetIntrinsicModifierName()
            if ModifName then
                local Modif = Hero:FindModifierByName(ModifName)
                if Modif then
                    Modif:ForceRefresh()
                    Modif:SendBuffRefreshToClients()
                end
            end

            Hero:CalculateGenericBonuses()
            Hero:CalculateStatBonus(true)
        end
    else
        local ItemInPassive = Hero:GetItemInSlot(DOTA_ITEM_NEUTRAL_PASSIVE_SLOT)
        if ItemInPassive then
            UTIL_Remove(ItemInPassive)
        end
    end
end

function NeutralItems:GetGettedItemsByTier(PlayerID, Tier)
    local Items = {}
    if not self.Players[PlayerID] then return Items end

    for ItemEnt, ItemInfo in pairs(self.Players[PlayerID].items) do
        if ItemInfo.tier == Tier then
            table.insert(Items, ItemInfo.item_name)
        end
    end

    return Items
end

function NeutralItems:GetGettedItemsByTierSortedByTime(PlayerID, Tier)
    local Items = {}
    if not self.Players[PlayerID] then return Items end

    local data = {}

    for ItemEnt, ItemInfo in pairs(self.Players[PlayerID].items) do
        if ItemInfo.craft_tier == Tier then
            table.insert(data, {craft_time = ItemInfo.craft_time, item_name = ItemInfo.item_name})
        end
    end

    table.sort(data, function(a, b) return a.craft_time > b.craft_time end)

    for _, ItemInfo in ipairs(data) do
        table.insert(Items, ItemInfo.item_name)
    end

    return Items
end

function NeutralItems:GetFreeSlotForNeutralItem(Unit, PlayerID)
    if not self.Players[PlayerID] then return nil end
    if Unit == nil or not Unit:HasInventory() then return nil end

    if Unit:GetItemInSlot(DOTA_ITEM_NEUTRAL_ACTIVE_SLOT) == nil then
        return DOTA_ITEM_NEUTRAL_ACTIVE_SLOT
    end

    local Start = DOTA_ITEM_SLOT_7
    if Unit:HasAbility("techies_spoons_stash_custom") then
        Start = DOTA_ITEM_SLOT_9
    end

    for i = Start, DOTA_STASH_SLOT_6 do
        local Item = Unit:GetItemInSlot(i)
        if Item == nil then
            return i
        end
    end

    return nil
end

function NeutralItems:GetRandomItemsForPlayerByTier(PlayerID, Tier, ItemsCount, Exceptions, bExcludePrevTier)
    if not self.Players[PlayerID] then return false end

    local Items = {}
    local SomeItems = {}
    local PrevTierItem = nil

    local Neutrals = table.shallowcopy(KeyValues:GetNeutralsByTier(Tier))

    if Exceptions then
        for _, ItemName in ipairs(Exceptions) do
            table.remove_item(Neutrals, ItemName)
        end
    end

    local Hero = PlayerResource:GetSelectedHeroEntity(PlayerID)
    local hasFundamentalForging = false
    if Hero then
        if Hero:HasAbility("meepo_sticky_fingers") then
            ItemsCount = ItemsCount + 1
        end

        if Hero:HasAbility("chaos_knight_fundamental_forging") and Tier < 5 then
            if ItemsCount - 1 > 0 then
                local next_tier = table.shallowcopy(KeyValues:GetNeutralsByTier(Tier+1))

                SomeItems = table.random_some(next_tier, 1)

                ItemsCount = ItemsCount - 1
                hasFundamentalForging = true
            end
        end
    end

    -- Fundamental Forging: the next-tier slot takes the place of the
    -- previous-tier "keep your old neutral" slot, so the old neutral
    -- is no longer offered for re-craft when the perk fires.
    if Tier > 0 and not bExcludePrevTier and not hasFundamentalForging then
        local LastGettedNeutral = self:GetGettedItemsByTierSortedByTime(PlayerID, Tier-1)

        if #LastGettedNeutral > 0 then
            LastGettedNeutral = LastGettedNeutral[1]
            if LastGettedNeutral ~= nil then
                PrevTierItem = LastGettedNeutral

                table.remove_item(Neutrals, LastGettedNeutral)

                ItemsCount = ItemsCount - 1
            end
        end
    end

    Items = table.random_some(Neutrals, ItemsCount)

    if PrevTierItem ~= nil then
        Items = table.join(Items, PrevTierItem)
    end

    Items = table.join(Items, SomeItems)

    return Items
end

function NeutralItems:GetRandomEnchantmentsForPlayerByTier(PlayerID, Tier, EnchantsCount, Exceptions)
    if not self.Players[PlayerID] then return false end

    local EnchantsList = {}

    local Enchants = table.shallowcopy(KeyValues:GetEnchantsByTier(Tier))

    if Exceptions then
        for _, ItemName in ipairs(Exceptions) do
            Enchants[ItemName] = nil
        end
    end

    if Tier < 5 and EnchantsCount > 0 then
        if Enchants["item_enhancement_greedy"] ~= nil then
            table.insert(EnchantsList, {
                enchant = "item_enhancement_greedy",
                level = Enchants["item_enhancement_greedy"].level,
                values = Enchants["item_enhancement_greedy"].values
            })
            EnchantsCount = EnchantsCount - 1
            Enchants["item_enhancement_greedy"] = nil
        end
    end

    for i=1, EnchantsCount do
        if table.count(Enchants) > 0 then
            local rEnchant = table.random_key(Enchants)
            if rEnchant ~= nil and Enchants[rEnchant] then
                table.insert(EnchantsList, {
                    enchant = rEnchant,
                    level = Enchants[rEnchant].level,
                    values = Enchants[rEnchant].values
                })

                Enchants[rEnchant] = nil
            end
        end
    end

    return EnchantsList
end


if not NeutralItems.bStarted then NeutralItems:Init() end