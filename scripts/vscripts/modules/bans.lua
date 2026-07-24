--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Бан героев

if Bans == nil then
	Bans = class({})
end

function Bans:Init()
    print('[Bans] Module is active!')

    self.bStarted = true

    self.Players = {}
    self.BanList = {
        heroes = {},
        abilities = {}
    }

    CustomGameEventManager:RegisterListener("bans_ban", function(_, event) self:OnPlayerWantBan(event) end)
    CustomGameEventManager:RegisterListener("bans_random_bans", function(_, event) self:OnPlayerWantRandomBans(event) end)
    CustomGameEventManager:RegisterListener("bans_banned_showed", function(_, event) self:OnBansShowed(event) end)

    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap( Bans, "GameStateChanged"), self)

    CustomNetTables:SetTableValue("globals", "ban_info", self.BanList)

    self.DummyUnit = CreateUnitByName("npc_dummy_unit_thinker", Vector(0,0,0), false, nil, nil, DOTA_TEAM_NEUTRALS)
    self.DummyUnit:AddNewModifier(self.DummyUnit, nil, "modifier_dummy", {})

    self.DebuffImmuneAbility = self.DummyUnit:FindAbilityByName("ability_damage_through_debuff_immune")
    self.SpecialEmptyAbility = self.DummyUnit:FindAbilityByName("ability_special_empty")
end

function Bans:GameStateChanged()
    local State = GameRules:State_Get()
    if State == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        PrecacheUnitFromTableAsync(self.DummyUnit, function(id)end)
        PrecacheItemByNameAsync("ability_special_empty", function(id)end)
    end
end

function Bans:GetDebuffImmuneAbility()
    return self.DebuffImmuneAbility
end

function Bans:GetEmptyAbility()
    return self.SpecialEmptyAbility
end

function Bans:ModifyPlayerBanCount(PlayerID, BansInfo)
    if self.Players[PlayerID] == nil then
        self.Players[PlayerID] = {
            banned_atleast_one_time = false,
            used_random_bans = false,
            heroes = 0,
            abilities = 0,
            random_heroes = 0,
            random_abilities = 0,
            showed_banned_list = false,
            banned_heroes = {},
            banned_abilities = {},
        }
    end
    if self.Players[PlayerID].used_random_bans == false then
        self.Players[PlayerID].heroes = self.Players[PlayerID].heroes + BansInfo.heroes
        self.Players[PlayerID].abilities = self.Players[PlayerID].abilities + BansInfo.abilities

        self.Players[PlayerID].random_heroes = self.Players[PlayerID].random_heroes + BansInfo.random_heroes
        self.Players[PlayerID].random_abilities = self.Players[PlayerID].random_abilities + BansInfo.random_abilities

        PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
    end

    -- self:OnPlayerWantRandomBans({PlayerID = PlayerID})
end

-- Аналог ModifyPlayerBanCount, но ВЫСТАВЛЯЕТ значения, а не прибавляет к текущим.
-- Используется турнирными оверрайдами (PLAYER_BANS_OVERRIDES в constants/main.lua):
-- нужно сбросить уже выданные base-баны и поставить ровно нужное количество вне зависимости
-- от того, есть ли у игрока battle pass.
function Bans:SetPlayerBanCount(PlayerID, BansInfo)
    if self.Players[PlayerID] == nil then
        self.Players[PlayerID] = {
            banned_atleast_one_time = false,
            used_random_bans = false,
            heroes = 0,
            abilities = 0,
            random_heroes = 0,
            random_abilities = 0,
            showed_banned_list = false,
            banned_heroes = {},
            banned_abilities = {},
        }
    end
    if self.Players[PlayerID].used_random_bans == false then
        self.Players[PlayerID].heroes = BansInfo.heroes or self.Players[PlayerID].heroes
        self.Players[PlayerID].abilities = BansInfo.abilities or self.Players[PlayerID].abilities
        self.Players[PlayerID].random_heroes = BansInfo.random_heroes or self.Players[PlayerID].random_heroes
        self.Players[PlayerID].random_abilities = BansInfo.random_abilities or self.Players[PlayerID].random_abilities

        PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
    end
end

function Bans:OnBansShowed(event)
    local PlayerID = event.PlayerID

    if self.Players[PlayerID] == nil then return end
    
    self.Players[PlayerID].showed_banned_list = true

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
end

function Bans:OnPlayerWantBan(event)
    local ToBan = event.to_ban
    local ToBanType = event.to_ban_type
    local PlayerID = event.PlayerID

    if self.Players[PlayerID] == nil then return end

    if ToBanType == "HERO" then
        self:OnPlayerWantBanHero(PlayerID, ToBan)
    end

    if ToBanType == "ABILITY" then
        self:OnPlayerWantBanAbility(PlayerID, ToBan)
    end
end

function Bans:OnPlayerWantRandomBans(event)
    local PlayerID = event.PlayerID

    if self.Players[PlayerID] == nil or self.Players[PlayerID].used_random_bans or self.Players[PlayerID].banned_atleast_one_time then return end

    for i = 1, self.Players[PlayerID].random_heroes do
        local SSSHeroes = self:GetAllRandomBansGroupUnbanned("HEROES", "SSS")
        local AHeroes = self:GetAllRandomBansGroupUnbanned("HEROES", "A")
        local AllUnbanedHeroes = self:GetAllUnbannedHeroes()
        local PlayerFavoriteBans = Server:GetUnbannedPlayerFavoriteBans(PlayerID, "HEROES")
        if #PlayerFavoriteBans > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["FAVORITES"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self.DummyUnit) then
            local rHero = table.random(PlayerFavoriteBans)
            if KeyValues.HeroesList[rHero] then

                KeyValues.HeroesList[rHero].bBanned = true

                table.insert(self.BanList.heroes, rHero)

                table.insert(self.Players[PlayerID].banned_heroes, rHero)
            end
        elseif #SSSHeroes > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["SSS"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self.DummyUnit) then
            local rHero = table.random(SSSHeroes)
            if KeyValues.HeroesList[rHero] then

                KeyValues.HeroesList[rHero].bBanned = true

                table.insert(self.BanList.heroes, rHero)

                table.insert(self.Players[PlayerID].banned_heroes, rHero)
            end
        elseif #AHeroes > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["A"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_2, self.DummyUnit) then
            local rHero = table.random(AHeroes)
            if KeyValues.HeroesList[rHero] then

                KeyValues.HeroesList[rHero].bBanned = true

                table.insert(self.BanList.heroes, rHero)

                table.insert(self.Players[PlayerID].banned_heroes, rHero)
            end
        elseif #AllUnbanedHeroes > 0 then
            local rHero = table.random(AllUnbanedHeroes)
            if KeyValues.HeroesList[rHero] then

                KeyValues.HeroesList[rHero].bBanned = true

                table.insert(self.BanList.heroes, rHero)

                table.insert(self.Players[PlayerID].banned_heroes, rHero)
            end
        end
    end

    for i = 1, self.Players[PlayerID].random_abilities do
        local SSSAbilities = self:GetAllRandomBansGroupUnbanned("ABILITIES", "SSS")
        local AAbilities = self:GetAllRandomBansGroupUnbanned("ABILITIES", "A")
        local AllUnbanedAbility = self:GetAllUnbannedAbilities()
        local PlayerFavoriteBans = Server:GetUnbannedPlayerFavoriteBans(PlayerID, "ABILITIES")
        if #PlayerFavoriteBans > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["FAVORITES"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self.DummyUnit) then
            local rAbility = table.random(PlayerFavoriteBans)
            if KeyValues.AbilitiesList[rAbility] then

                KeyValues.AbilitiesList[rAbility].bBanned = true

                table.insert(self.BanList.abilities, rAbility)

                table.insert(self.Players[PlayerID].banned_abilities, rAbility)
            end
        elseif #SSSAbilities > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["SSS"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_3, self.DummyUnit) then
            local rAbility = table.random(SSSAbilities)
            if KeyValues.AbilitiesList[rAbility] then

                KeyValues.AbilitiesList[rAbility].bBanned = true

                table.insert(self.BanList.abilities, rAbility)

                table.insert(self.Players[PlayerID].banned_abilities, rAbility)
            end
        elseif #AAbilities > 0 and RollPseudoRandomPercentage(RANDOM_BANS_CHANCES["A"], DOTA_PSEUDO_RANDOM_CUSTOM_GAME_4, self.DummyUnit) then
            local rAbility = table.random(AAbilities)
            if KeyValues.AbilitiesList[rAbility] then

                KeyValues.AbilitiesList[rAbility].bBanned = true

                table.insert(self.BanList.abilities, rAbility)

                table.insert(self.Players[PlayerID].banned_abilities, rAbility)
            end
        elseif #AllUnbanedAbility > 0 then
            local rAbility = table.random(AllUnbanedAbility)
            if KeyValues.AbilitiesList[rAbility] then
                KeyValues.AbilitiesList[rAbility].bBanned = true

                table.insert(self.BanList.abilities, rAbility)

                table.insert(self.Players[PlayerID].banned_abilities, rAbility)
            end
        end
    end

    self.Players[PlayerID].random_heroes = 0
    self.Players[PlayerID].random_abilities = 0
    self.Players[PlayerID].heroes = 0
    self.Players[PlayerID].abilities = 0
    self.Players[PlayerID].used_random_bans = true
    self.Players[PlayerID].banned_atleast_one_time = true

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
    CustomNetTables:SetTableValue("globals", "ban_info", self.BanList)
end

function Bans:GetAllRandomBansGroupUnbanned(Category, GroupName)
    if RANDOM_BANS_GROUPS[Category] == nil or RANDOM_BANS_GROUPS[Category][GroupName] == nil then return {} end
    local AllUnbanned = {}

    for _, Name in ipairs(RANDOM_BANS_GROUPS[Category][GroupName]) do
        if Category == "ABILITIES" then
            if KeyValues.AbilitiesList[Name] and KeyValues.AbilitiesList[Name].bBanned == false then
                table.insert(AllUnbanned, Name)
            end
        else
            if KeyValues.HeroesList[Name] and KeyValues.HeroesList[Name].bBanned == false then
                table.insert(AllUnbanned, Name)
            end
        end
    end

    return AllUnbanned
end

function Bans:GetAllUnbannedAbilities()
    local AllUnbanedAbility = {}

    for AbilityName, AbilityInfo in pairs(KeyValues:GetAllAbilities()) do
        if AbilityInfo.bBanned == false then
            table.insert(AllUnbanedAbility, AbilityName)
        end
    end

    return AllUnbanedAbility
end

function Bans:GetAllUnbannedHeroes()
    local AllUnbanedHeroes = {}

    for HeroName, HeroInfo in pairs(KeyValues:GetAllHeroes()) do
        if HeroInfo.bBanned == false then
            table.insert(AllUnbanedHeroes, HeroName)
        end
    end

    return AllUnbanedHeroes
end

function Bans:GetAllBannedHeroes()
    return self.BanList.heroes
end

function Bans:GetAllBannedAbilities()
    return self.BanList.abilities
end

function Bans:OnPlayerWantBanHero(PlayerID, HeroName)
    if self.Players[PlayerID].heroes <= 0 or self.Players[PlayerID].used_random_bans == true or table.contains(self.BanList.heroes, HeroName) then return end

    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if PlayerInfo == nil then return end

    local HeroInfo = KeyValues.HeroesList[HeroName]
    if not HeroInfo then return end

    HeroInfo.bBanned = true

    self.Players[PlayerID].heroes = self.Players[PlayerID].heroes -1
    self.Players[PlayerID].banned_atleast_one_time = true

    table.insert(self.BanList.heroes, HeroName)

    table.insert(self.Players[PlayerID].banned_heroes, HeroName)

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
    CustomNetTables:SetTableValue("globals", "ban_info", self.BanList)

    table.insert(PlayerInfo.current_ban_heroes, HeroName)
end

function Bans:OnPlayerWantBanAbility(PlayerID, AbilityName)
    if self.Players[PlayerID].abilities <= 0 or self.Players[PlayerID].used_random_bans == true or table.contains(self.BanList.abilities, AbilityName) then return end

    local PlayerInfo = Server:GetPlayerInfo(PlayerID)

    if PlayerInfo == nil then return end

    local AbilityInfo = KeyValues.AbilitiesList[AbilityName]
    if not AbilityInfo then return end

    AbilityInfo.bBanned = true

    self.Players[PlayerID].abilities = self.Players[PlayerID].abilities -1
    self.Players[PlayerID].banned_atleast_one_time = true

    table.insert(self.BanList.abilities, AbilityName)

    table.insert(self.Players[PlayerID].banned_abilities, AbilityName)

    PlayerTables:SetTableValue("player_"..PlayerID.."_global", "ban_info", self.Players[PlayerID])
    CustomNetTables:SetTableValue("globals", "ban_info", self.BanList)

    table.insert(PlayerInfo.current_ban_abilities, AbilityName)
end

function Bans:GetPlayerHeroBans(PlayerID)
    if self.Players[PlayerID] == nil then return {} end

    return self.Players[PlayerID].banned_heroes
end

function Bans:GetPlayerAbilityBans(PlayerID)
    if self.Players[PlayerID] == nil then return {} end

    return self.Players[PlayerID].banned_abilities
end

if not Bans.bStarted then Bans:Init() end