--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


MatchStateService = MatchStateService or {} ---@class MatchStateService

---@class StateAbilityInfo
---@field name string
---@field level integer
---@field cooldown number

---@class StateItemInfo
---@field name string
---@field slot integer
---@field charges integer
---@field cooldown number

---@class StateExtenderStashItemInfo
---@field name string
---@field slot string
---@field charges integer
---@field cooldown number

---@class StateModifierInfo
---@field name string
---@field casterName string?
---@field abilityName string?
---@field count integer
---@field duration number

---@class StateDuelStats
---@field win integer
---@field lose integer

---@alias StateBookStats table<string, integer>

---@class StatePlayerInfo
---@field uid string
---@field heroName string
---@field xp integer
---@field level integer
---@field gold integer
---@field abilities StateAbilityInfo[]
---@field items StateItemInfo[]
---@field modifiers StateModifierInfo[]
---@field duelStats StateDuelStats
---@field bookStats StateBookStats?

---@class MatchState
---@field players StatePlayerInfo[]
---@field round integer
---@field bannedAbilities string[]
---@field bannedHeroes string[]
---@field metrics string

---@param hero CDOTA_BaseNPC_Hero
---@return StateItemInfo[]
local function GetItems(hero)
    ---@type StateItemInfo[]
    local items = {}

    for slot = 0, 16 do
        local item = hero:GetItemInSlot(slot)
        if IsValid(item) then ---@cast item CDOTA_Item -- todo Перенос чар нейтралки 
            table.insert(items, {
                name = item:GetAbilityName(),
                slot = slot,
                charges = item:GetCurrentCharges(),
                cooldown = item:GetCooldownTimeRemaining()
            })
        end
    end

    return items
end

---@param hero CDOTA_BaseNPC_Hero
---@return StateExtenderStashItemInfo[]
local function GetExtenderStashItems(hero)
    local extenderStashData = ExtenderStash.Players[hero:GetPlayerID()]
    local extenderStashItems = extenderStashData and extenderStashData.items
    local items = {}

    for slot, itemInfo in pairs(extenderStashItems or {}) do --вынести в отдельное поле
        local item = itemInfo and itemInfo.item and EntIndexToHScript(itemInfo.item) ---@type CDOTA_Item?
        if IsValid(item) then ---@cast item CDOTA_Item
            table.insert(items, {
                name = item:GetAbilityName(),
                slot = slot,
                charges = item:GetCurrentCharges(),
                cooldown = item:GetCooldownTimeRemaining()
            })
        end
    end
    return items
end

---@param hero CDOTA_BaseNPC_Hero
---@return StateAbilityInfo[]
local function GetAbilities(hero)
    ---@type StateAbilityInfo[]
    local abilities = {}

    for i = 0, hero:GetAbilityCount() - 1 do
        local ability = hero:GetAbilityByIndex(i)
        if ability then
            table.insert(abilities, {
                name = ability:GetAbilityName(),
                level = ability:GetLevel(),
                cooldown = ability:GetCooldownTimeRemaining()
            })
        end
    end

    return abilities
end

---@param hero CDOTA_BaseNPC_Hero
---@return StateModifierInfo[]
local function GetModifiers(hero)
    ---@type StateModifierInfo[]
    local modifiers = {}

    for modifierIndex = 0, hero:GetModifierCount() - 1 do
        local modifierName = hero:GetModifierNameByIndex(modifierIndex)
        local modifier = hero:FindModifierByName(modifierName)

        if IsValid(modifier) then ---@cast modifier CDOTA_Modifier_Lua
            local caster = modifier:GetCaster()
            local ability = modifier:GetAbility()

            table.insert(modifiers, {
                name = modifier:GetName(),
                casterName = caster and caster:GetUnitName() or nil,
                abilityName = ability and ability:GetName() or nil,
                count = modifier:GetStackCount(),
                duration = modifier:GetDuration()
            })
        end
    end

    return modifiers
end

---@param playerId PlayerID
---@return StateDuelStats
local function GetDuelStats(playerId)
    local record = PvpModule.PvpRecord[playerId]
    return {
        win = record.win,
        lose = record.lose
    }
end

---@param playerId PlayerID
---@return StateBookStats?
local function GetRelearnBookStats(playerId)
    local bookStats = GameMode.playerCountBookMap[playerId]

    ---@type StateBookStats
    local stats = {}
    local hasAny = false

    for bookName, count in pairs(bookStats or {}) do
        stats[bookName] = count
        hasAny = true
    end

    if not hasAny then
        return nil
    end

    return stats
end

---@param hero CDOTA_BaseNPC_Hero
---@return StatePlayerInfo
local function GetPlayerInfo(hero)
    local playerId = hero:GetPlayerID()

    return {
        uid = GetSteamID(playerId),
        heroName = hero:GetUnitName(),
        xp = hero:GetCurrentXP(),
        level = hero:GetLevel(),
        gold = PlayerResource:GetGold(playerId),
        abilities = GetAbilities(hero),
        items = GetItems(hero),
        extenderStashItems = GetExtenderStashItems(hero),
        modifiers = GetModifiers(hero),
        duelStats = GetDuelStats(playerId),
        bookStats = GetRelearnBookStats(playerId)
    }
end

local function Save()
    local banAbilitiesList = {}
    local banHeroesList = {}
    for key, _ in pairs(Pass.banAbilitiesMap) do
        table.insert(banAbilitiesList, key)
    end
    for key, _ in pairs(Pass.banHeroMap) do
        table.insert(banHeroesList, key)
    end
    ---@type MatchState
    local matchState = {
        players = {},
        round = GameMode.currentRound.roundNumber,
        bannedAbilities = banAbilitiesList, --TODO нужно ли мапа по игрокам
        bannedHeroes = banHeroesList,
		metrics = MemoryTracker:GetMemoryUsageMessage()
    }

    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidPlayerID(playerId) and PlayerResource:HasSelectedHero(playerId) then
            local hero = PlayerResource:GetSelectedHeroEntity(playerId)
            if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
                table.insert(matchState.players, GetPlayerInfo(hero))
            end
        end
    end

    MatchOutboundApi:SaveMatchState(GameMode:GetMatchID(), matchState, nil)
end

-- todo Проверить с мертвыми
function MatchStateService:Save()
    xpcall(Save, function(e)
        logger:LogError(e)
    end)
end

-- function SnapshotService:Load()
--     ---@type MatchSnapshot
--     local snapshot = {} -- todo
--     DebugTool:ChangeCurrentRound({
--         str = snapshot.round
--     })
--     logger:LogTable(snapshot)
--     for _, playerInfo in ipairs(snapshot.players) do
--         self:SwitchHero(playerInfo)
--     end
-- end

-- ---@param playerInfo SnapshotPlayerInfo
-- function SnapshotService:SwitchHero(playerInfo)
--     -- local playerID = GetPlayerIDBySteamId(playerInfo.uid)
--     local playerID = 0 -- todo
--     if playerID == nil then
--         return
--     end
--
--     local currentHero = PlayerResource:GetSelectedHeroEntity(playerID)
--     if not IsValid(currentHero) then
--         return
--     end
--     ---@cast currentHero CDOTA_BaseNPC_Hero
--
--     PrecacheUnitByNameAsync(playerInfo.heroName, function()
--         local newHero = PlayerResource:ReplaceHeroWith(playerID, playerInfo.heroName, playerInfo.gold, playerInfo.xp)
--         self:RecreateModifiers(newHero, playerInfo.modifiers)
--         self:RecreateItems(newHero, playerInfo.items)
--         self:RecreateAbilities(newHero, playerInfo.abilities)
--         HeroBuilder:InitPlayerHeroDebug(newHero)
--     end)
-- end

-- ---@param hero CDOTA_BaseNPC_Hero
-- ---@param items SnapshotItemInfo[]
-- function SnapshotService:RecreateItems(hero, items) -- todo extenderStashItems
--     for _, itemInfo in ipairs(items) do
--         local item = CreateItem(itemInfo.name, hero, hero)
--         ---@cast item CDOTA_Item
--         item:SetCurrentCharges(itemInfo.charges)
--     end
-- end

-- ---@param hero CDOTA_BaseNPC_Hero
-- ---@param abilities SnapshotAbilityInfo[]
-- function SnapshotService:RecreateAbilities(hero, abilities)
--     for _, abilityInfo in ipairs(abilities) do
--         if not hero:HasAbility(abilityInfo.name) then
--             HeroBuilder:AddAbility(hero:GetPlayerID(), abilityInfo.name, abilityInfo.level, abilityInfo.cooldown, hero)
--         end
--     end
-- end

-- ---@param hero CDOTA_BaseNPC_Hero
-- ---@param modifiers SnapshotModifierInfo[]
-- function SnapshotService:RecreateModifiers(hero, modifiers)
--     for _, modifierInfo in ipairs(modifiers) do
--         local modifier = hero:FindModifierByName(modifierInfo.name)
--         if not IsValid(modifier) then
--             modifier = hero:AddNewModifier(modifierInfo.casterName, modifierInfo.abilityName, modifierInfo.name, {})
--         end
--         ---@cast modifier CDOTA_Buff
--         modifier:SetDuration(modifierInfo.duration, true)
--         modifier:SetStackCount(modifierInfo.count)
--     end
-- end