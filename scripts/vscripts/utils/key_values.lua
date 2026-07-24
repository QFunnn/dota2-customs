--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if KeyValues == nil then
    KeyValues = class({})
end

-- Ручные правки списка изменённых способностей для подсветки в выборе
-- (на случай если автоматический скан что-то промахнул)
MODIFIED_ABILITIES_INCLUDE = {
    -- ["ability_name"] = true,
}
MODIFIED_ABILITIES_EXCLUDE = {
    -- ["ability_name"] = true,
}

function KeyValues:Init()
    print('[KeyValues] Module is active!')
    self.bStarted = true

    self.HeroesList = {}
    self.AbilitiesList = {}
    self.FullyAbilitiesList = {}
    self.OtherAbilitiesList = {}
    self.ItemsList = {}
    self.ActivedNeutralItems = {}
    self.NeutralsItemsList = {}
    self.NeutralsEnchantmentsList = {}
    self.RegisteredNotes = {}
    self.Innates = {}

    self.EntitiesData = {}

    self.ActiveList = LoadKeyValues("scripts/npc/activelist.txt")
    self.HeroesConfig = LoadKeyValues("scripts/npc/npc_abilities_list.txt")
    self.UnitsCustom = LoadKeyValues("scripts/npc/npc_units_custom.txt")
    self.ItemsCustom = LoadKeyValues("scripts/npc/npc_items_custom.txt")
    self.Neutrals = LoadKeyValues("scripts/npc/neutral_items.txt")
    self.ItemsIDs = LoadKeyValues("scripts/npc/npc_ability_ids.txt")
    self.MinimapIconsKV = LoadKeyValues("scripts/mod_textures.txt")

    -- print("================ HEROES TABLE ========================")
    -- DeepPrintTable(self.HeroesList)
    -- print("======================================================")
    -- print("================ ABILITIES TABLE =====================")
    -- DeepPrintTable(self.AbilitiesList)
    -- print("======================================================")

    CustomGameEventManager:RegisterListener("key_values_get_ability_info", function(_, event) self:OnGetAbilityInfo(event) end)
end

function KeyValues:GetHeroMinimapIconID(HeroName)
    if self.MinimapIconsKV["TextureData"] == nil then return end

    local ID = -1
    for Key, Value in pairs(self.MinimapIconsKV["TextureData"]) do
        if Key == "minimap_heroicon_"..HeroName then
            local x = Value.x / 32
            local y = Value.y / 32
            ID = x + (y * 16)
            break
        end
    end

    return ID
end

function KeyValues:LoadNeutrals()
    if self.Neutrals and self.Neutrals["neutral_tiers"] then
        for TierNum, TierInfo in pairs(self.Neutrals["neutral_tiers"]) do
            local TierNumber = tonumber(TierNum)
            if self.NeutralsItemsList[TierNumber] == nil then
                self.NeutralsItemsList[TierNumber] = {}
            end
            if self.NeutralsEnchantmentsList[TierNumber] == nil then
                self.NeutralsEnchantmentsList[TierNumber] = {}
            end
            if TierInfo["items"] then
                for ItemName, Enabled in pairs(TierInfo["items"]) do
                    if Enabled == 1 then
                        table.insert(self.ActivedNeutralItems, ItemName)
                        table.insert(self.NeutralsItemsList[TierNumber], ItemName)
                    end
                end
            end
            if TierInfo["enhancements"] then
                for ItemName, Level in pairs(TierInfo["enhancements"]) do
                    local Values = {}
                    local KV = GetAbilityKeyValuesByName(ItemName)
                    if KV and KV["AbilityValues"] then
                        Values = KV["AbilityValues"]
                    end

                    self.NeutralsEnchantmentsList[TierNumber][ItemName] = {
                        level = Level,
                        values = Values
                    }
                end
            end
        end
    end

    -- CustomNetTables:SetTableValue("globals", "neutrals", self.ActivedNeutralItems)
    PlayerTables:SetTableValue("globals", "neutrals", self.ActivedNeutralItems)
end

function KeyValues:GetNeutralsByTier(Tier)
    if self.NeutralsItemsList[Tier] ~= nil then
        return self.NeutralsItemsList[Tier]
    end
    return {}
end

function KeyValues:GetEnchantsByTier(Tier)
    if self.NeutralsEnchantmentsList[Tier] ~= nil then
        return self.NeutralsEnchantmentsList[Tier]
    end
    return {}
end

function KeyValues:GetNeutralItemTier(ItemName)
    for Tier, TierInfo in pairs(self.NeutralsItemsList) do
        for _, name in ipairs(TierInfo) do
            if name == ItemName then
                return Tier
            end
        end
    end

    return 1
end

function KeyValues:GetEnchantInfo(Tier, EnchantName)
    if self.NeutralsEnchantmentsList[Tier] ~= nil then
        return self.NeutralsEnchantmentsList[Tier][EnchantName]
    end

    return nil
end

function KeyValues:GetActiveNeutrals()
    return self.ActivedNeutralItems
end

function KeyValues:IsNeutralItem(ItemName)
    return table.contains(self.ActivedNeutralItems, ItemName)
end

function KeyValues:LoadItemsList()

    for ItemName, ItemInfo in pairs(self.ItemsCustom) do
        if type(ItemInfo) == "table" then
            local KV = GetAbilityKeyValuesByName(ItemName)
            if KV and KV["ID"] then
                self.ItemsList[ItemName] = KV["ID"]
            end
        end
    end

    if self.ItemsIDs["ItemAbilities"] and self.ItemsIDs["ItemAbilities"]["Locked"] then
        for ItemName, ItemID in pairs(self.ItemsIDs["ItemAbilities"]["Locked"]) do
            self.ItemsList[ItemName] = ItemID
        end
    end

    -- CustomNetTables:SetTableValue("globals", "items_info", self.ItemsList)
    PlayerTables:SetTableValue("globals", "items_info", self.ItemsList)
end

function KeyValues:GetHeroBaseStats(HeroName)
    local KV = GetUnitKeyValuesByName(HeroName) or {}

    local function pick(value, default)
        return tonumber(value) or default
    end

    return {
        str              = pick(KV.AttributeBaseStrength,     0),
        str_gain         = pick(KV.AttributeStrengthGain,     0),
        agi              = pick(KV.AttributeBaseAgility,      0),
        agi_gain         = pick(KV.AttributeAgilityGain,      0),
        int              = pick(KV.AttributeBaseIntelligence, 0),
        int_gain         = pick(KV.AttributeIntelligenceGain, 0),

        hp               = pick(KV.StatusHealth,              0),
        hp_regen         = pick(KV.StatusHealthRegen,         0),
        mana             = pick(KV.StatusMana,                0),
        mana_regen       = pick(KV.StatusManaRegen,           0),

        armor            = pick(KV.ArmorPhysical,             0),
        magic_resist     = pick(KV.MagicalResistance,         25),

        damage_min       = pick(KV.AttackDamageMin,           0),
        damage_max       = pick(KV.AttackDamageMax,           0),
        attack_rate      = pick(KV.AttackRate,                1.7),
        attack_range     = pick(KV.AttackRange,               150),
        move_speed       = pick(KV.MovementSpeed,             300),
    }
end

function KeyValues:LoadHeroesList()
    for HeroName, Active in pairs(self.ActiveList) do
        if Active == 1 then
            self.HeroesList[HeroName] = {
                id = DOTAGameManager:GetHeroIDByName(HeroName),
                Name = HeroName,
                primary_attribute = self:GetHeroPrimaryAttribute(HeroName),
                abilities = self:GetHeroAbilities(HeroName),
                facet_abilities = self:GetHeroFacetAbilities(HeroName),
                innate_abilities = self:GetHeroInnateAbilities(HeroName),

                sss_category = self:GetSSSHeroCategory(HeroName),

                minimap_icon_id = self:GetHeroMinimapIconID(HeroName),

                base_stats = self:GetHeroBaseStats(HeroName),

                bBanned = false,
            }
        end
    end

    -- CustomNetTables:SetTableValue("globals", "heroes_info", self.HeroesList)
    PlayerTables:SetTableValue("globals", "heroes_info", self.HeroesList)
end

function KeyValues:GetHero(HeroName)
    return self.HeroesList[HeroName]
end

function KeyValues:GetAbility(AbilityName)
    return self.AbilitiesList[AbilityName]
end

function KeyValues:GetAllHeroes()
    return self.HeroesList
end

function KeyValues:GetAllAbilities()
    return self.AbilitiesList
end

function KeyValues:GetSSSHeroCategory(HeroName)
    local HeroesList = SPEICAL_TIERS_TABLE["HEROES"]
    if HeroesList then
        local SSS = HeroesList["SSS"]
        if SSS then
            for CATEGORY, LIST in pairs(SSS) do
                if table.contains(LIST, HeroName) then
                    return CATEGORY
                end
            end
        end
    end

    return "NONE"
end

-- Бинарная проверка — герой в SSS-тире или нет. Удобнее GetSSSHeroCategory для мест,
-- где конкретная подгруппа (MAGICAL/PHYSICAL/UNIVERSAL) не важна — например лимит
-- SSS в рандом-пуле игрока (HeroBuilder:GenerateListRandomHeroes).
function KeyValues:IsHeroInSSSTier(HeroName)
    return self:GetSSSHeroCategory(HeroName) ~= "NONE"
end

function KeyValues:GetHeroInnatesAndFacetsAbilities(HeroName)
    if not self.HeroesList[HeroName] then return {} end

    local Result = {}

    for _, AbilityName in ipairs(self.HeroesList[HeroName].facet_abilities) do
        if not table.contains(Result, AbilityName) then
            table.insert(Result, AbilityName)
        end
    end

    for _, AbilityName in ipairs(self.HeroesList[HeroName].innate_abilities) do
        if not table.contains(Result, AbilityName) then
            table.insert(Result, AbilityName)
        end
    end

    return Result
end

function KeyValues:LoadAbilities()
    for RawHeroName, AbilitiesList in pairs(self.HeroesConfig) do
        local HeroName = "npc_dota_hero_"..RawHeroName
 
        for key, value in pairs(AbilitiesList) do
            if type(value) ~= "table" and self.AbilitiesList[value] == nil then
                self.AbilitiesList[value] = {
                    -- bIsMain = true,
                    HeroName = HeroName,
                    -- bIsFacet = (self.HeroesList[HeroName] and table.contains(self.HeroesList[HeroName].facet_abilities, value)),
                    -- bIsInnate = (self.HeroesList[HeroName] and table.contains(self.HeroesList[HeroName].innate_abilities, value)),
                    bBanned = false,
                }

                self.FullyAbilitiesList[value] = HeroName
            end
        end

        for key, value in pairs(AbilitiesList) do
            if type(value) == "table" and self.AbilitiesList[key] ~= nil then
                if self.AbilitiesList[key].LinkedAbilities == nil then
                    self.AbilitiesList[key].LinkedAbilities = {}
                end

                for k, v in pairs(value) do
                    self.AbilitiesList[key].LinkedAbilities[k] = v

                    self.FullyAbilitiesList[k] = HeroName
                end
            end
        end
    end
    -- CustomNetTables:SetTableValue("globals", "abilities_info", self.AbilitiesList)
    PlayerTables:SetTableValue("globals", "abilities_info", self.AbilitiesList)
end

function KeyValues:LoadOtherAbilities()
    for RawHeroName, AbilitiesList in pairs(self.HeroesConfig) do
        local HeroName = "npc_dota_hero_"..RawHeroName

        if self.HeroesList[HeroName] then
            if self.HeroesList[HeroName].facet_abilities then
                for _, AbilityName in pairs(self.HeroesList[HeroName].facet_abilities) do
                    self.OtherAbilitiesList[AbilityName] = true
                    self.FullyAbilitiesList[AbilityName] = HeroName
                end
            end
            if self.HeroesList[HeroName].innate_abilities then
                for _, AbilityName in pairs(self.HeroesList[HeroName].innate_abilities) do
                    self.OtherAbilitiesList[AbilityName] = true
                    self.FullyAbilitiesList[AbilityName] = HeroName
                    self.Innates[AbilityName] = true
                end
            end
        end

        for key, value in pairs(AbilitiesList) do
            if type(value) == "table" then
                for k, v in pairs(value) do
                    self.OtherAbilitiesList[k] = true
                    self.FullyAbilitiesList[k] = HeroName
                end
            end
        end
    end

    for AbilityName, AbilityInfo in pairs(ABILITIES_SETTINGS) do
        if AbilityInfo.ScepterAbilities then
            for k, v in pairs(AbilityInfo.ScepterAbilities) do
                self.OtherAbilitiesList[v] = true

                if self.AbilitiesList[v] ~= nil then
                    self.FullyAbilitiesList[v] = self.AbilitiesList[v].HeroName
                end
            end
        end
        if AbilityInfo.ShardAbilities then
            for k, v in pairs(AbilityInfo.ShardAbilities) do
                self.OtherAbilitiesList[v] = true

                if self.AbilitiesList[v] ~= nil then
                    self.FullyAbilitiesList[v] = self.AbilitiesList[v].HeroName
                end
            end
        end
    end

    for HeroName, HeroInfo in pairs(HEROES_SETTINGS) do
        if HeroInfo.ScepterAbilities then
            for k, v in pairs(HeroInfo.ScepterAbilities) do
                self.OtherAbilitiesList[v] = true
                self.FullyAbilitiesList[v] = HeroName
            end
        end
        if HeroInfo.ShardAbilities then
            for k, v in pairs(HeroInfo.ShardAbilities) do
                self.OtherAbilitiesList[v] = true
                self.FullyAbilitiesList[v] = HeroName
            end
        end
    end
    
    -- CustomNetTables:SetTableValue("globals", "other_abilities_list", self.OtherAbilitiesList)
    PlayerTables:SetTableValue("globals", "other_abilities_list", self.OtherAbilitiesList)
    PlayerTables:SetTableValue("globals", "innate_abilities", self.Innates)
end

-- Сканирует KV-файлы и собирает список способностей, которые мы изменили
-- (полностью кастомные либо с правками значений). Используется клиентом
-- (ability_colors.js) для подсветки в окне выбора способностей.
function KeyValues:LoadModifiedAbilities()
    local Modified = {}

    local function isAllowed(name, info)
        if type(name) ~= "string" then return false end
        if name:sub(1, 5) == "item_" then return false end
        if name:find("special_bonus") then return false end
        if name:find("_innate") then return false end
        if MODIFIED_ABILITIES_EXCLUDE[name] then return false end
        if type(info) == "table" and (info.Innate == 1 or info.Innate == "1") then
            return false
        end
        return true
    end

    local Sources = {
        "scripts/npc/npc_abilities_custom.txt",
        "scripts/npc/kv/dota_abilities.txt",
        "scripts/npc/npc_abilities_override.txt",
    }

    for _, Path in ipairs(Sources) do
        local KV = LoadKeyValues(Path)
        if KV then
            for k, v in pairs(KV) do
                if type(v) == "table" and isAllowed(k, v) then
                    Modified[k] = true
                end
            end
        end
    end

    for name, _ in pairs(MODIFIED_ABILITIES_INCLUDE) do
        Modified[name] = true
    end

    self.ModifiedAbilities = Modified
    PlayerTables:SetTableValue("globals", "modified_abilities", Modified)
end

function KeyValues:OnGetAbilityInfo(event)
    if event.PlayerID == nil then return end
    
    local Player = PlayerResource:GetPlayer(event.PlayerID)
    if Player == nil then return end

    local AbilityName = event.ability_name
    if not self.RegisteredNotes[AbilityName] then
        local KV = GetAbilityKeyValuesByName(AbilityName)
        if KV then
            local AbilityValues = {}
            if KV["AbilityValues"] then
                AbilityValues = KV["AbilityValues"]
            end

            self.RegisteredNotes[AbilityName] = AbilityValues

            CustomGameEventManager:Send_ServerToPlayer(Player, "key_values_send_ability_info", {ability_name = AbilityName, values=AbilityValues})
        end
    else
        CustomGameEventManager:Send_ServerToPlayer(Player, "key_values_send_ability_info", {ability_name = AbilityName, values=self.RegisteredNotes[AbilityName]})
    end
end

function KeyValues:UpdateHeroesAndAbilitiesInfo()
    -- CustomNetTables:SetTableValue("globals", "heroes_info", self.HeroesList)
    PlayerTables:SetTableValue("globals", "heroes_info", self.HeroesList)
    -- CustomNetTables:SetTableValue("globals", "abilities_info", self.AbilitiesList)
    PlayerTables:SetTableValue("globals", "abilities_info", self.AbilitiesList)
end

function KeyValues:GetHeroPrimaryAttribute(FindHeroName)
    local Attribute = DOTA_ATTRIBUTE_ALL
    local KV = GetUnitKeyValuesByName(FindHeroName)
    if KV then
        if KV.AttributePrimary == "DOTA_ATTRIBUTE_STRENGTH" then
            Attribute = DOTA_ATTRIBUTE_STRENGTH
        elseif KV.AttributePrimary == "DOTA_ATTRIBUTE_AGILITY" then
            Attribute = DOTA_ATTRIBUTE_AGILITY
        elseif KV.AttributePrimary == "DOTA_ATTRIBUTE_INTELLECT" then
            Attribute = DOTA_ATTRIBUTE_INTELLECT
        end
    end

    return Attribute
end

function KeyValues:GetHeroAbilities(FindHeroName)
    local Abilities = {}
    for RawHeroName, AbilitiesList in pairs(self.HeroesConfig) do
        local HeroName = "npc_dota_hero_"..RawHeroName

        if FindHeroName == HeroName then
            local keys = {}
            for key, value in pairs(AbilitiesList) do
                if type(value) ~= "table" then
                    table.insert(keys, key)
                end
            end
            table.sort(keys, function(a, b)
                local na, nb = tonumber(a), tonumber(b)
                if na and nb then return na < nb end
                if na then return true end
                if nb then return false end
                return tostring(a) < tostring(b)
            end)
            for _, key in ipairs(keys) do
                table.insert(Abilities, AbilitiesList[key])
            end
        end
    end
    return Abilities
end

function KeyValues:GetHeroFacetAbilities(FindHeroName)
    local Facets = {}
    local KV = GetUnitKeyValuesByName(FindHeroName)
    if KV and KV.Facets then
        for i, FacetInfo in pairs(KV.Facets) do
            if FacetInfo.Abilities and FacetInfo.Deprecated ~= 1 then
                for j, AbilityInfo in pairs(FacetInfo.Abilities) do
                    if AbilityInfo.AutoLevelAbility == nil or AbilityInfo.AutoLevelAbility ~= "false" then
                        table.insert(Facets, AbilityInfo.AbilityName)
                    end
                end
            end
        end
    end
    return Facets
end

function KeyValues:GetHeroInnateAbilities(FindHeroName)
    local Innates = {}
    local KV = GetUnitKeyValuesByName(FindHeroName)
    if KV then
        for i = 1, 35 do
            if KV["Ability"..i] ~= nil and not string.find(KV["Ability"..i], "special_bonus") then
                local AbilitySettings = ABILITIES_SETTINGS[KV["Ability"..i]]
                local bIgnore = (AbilitySettings and AbilitySettings.bIgnoredInnate)
                if not bIgnore then
                    local AbilityKV = GetAbilityKeyValuesByName(KV["Ability"..i])
                    if AbilityKV and AbilityKV.Innate == 1 then
                        table.insert(Innates, KV["Ability"..i])
                    end
                end
            end
        end
    end
    return Innates
end

function KeyValues:IsBannedAbility(AbilityName)
    if self.AbilitiesList[AbilityName] == nil then return true end

    return self.AbilitiesList[AbilityName].bBanned
end

function KeyValues:IsBannedHero(HeroName)
    -- [ВРЕМЕННО] Invoker убран из пула — сломаны Aghanim и Shard. Снять после фикса реворка.
    if HeroName == "npc_dota_hero_invoker" then return true end

    if self.HeroesList[HeroName] == nil then return true end

    return self.HeroesList[HeroName].bBanned
end

function KeyValues:GetHeroNameByAbilityName(AbilityName)
    return self.FullyAbilitiesList[AbilityName]
end

if not KeyValues.bStarted then KeyValues:Init() end