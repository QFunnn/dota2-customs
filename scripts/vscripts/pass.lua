--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Pass == nil then Pass = class({}) end ---@class Pass

---@enum PlayerActions
BAN_ACTION_ACTOR = 1
BAN_ACTION_HERO = 2
BAN_ACTION_ABILITY = 3

local STREAMER_PLUS_TAG_CODE = "STREAMER_PLUS"
local IS_TEST_BAN_ACTIVATED = false

local MAX_ABILITIES_BAN_COUNT = 3
local MAX_HEROES_BAN_COUNT = 2

---@class BanState
---@field left integer
---@field total integer
---@field list string[]

---@class PlayerBans
---@field heroes BanState
---@field abilities BanState
---@field hasUnlimitedBans boolean

---@class BanHeroEvent
---@field PlayerID PlayerID
---@field heroName string

---@class BanAbilityEvent
---@field PlayerID PlayerID
---@field abilityName string

function Pass:Init()
    ListenToGameEvent("game_rules_state_change", function(_) self:OnGameRulesStateChange() end, self)
    GameListener:SubscribeProtected("ban_ability", function(event) self:OnBanAbility(event) end)
    GameListener:SubscribeProtected("ban_hero", function(event) self:OnBanHero(event) end)

    self.banMap = {}
    self.banInfosByPlayerId = {} ---@type table<PlayerID, PlayerBans>
    self.banHeroMap = {} ---@type table<string, boolean> --- heroName = true
    self.banAbilitiesMap = {} ---@type table<string, boolean> --- ability = true
end

function Pass:InitPlayersData()
    for playerId = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if not PlayerResource:IsFakeClient(playerId) and PlayerResource:IsValidPlayer(playerId) then
            self.banInfosByPlayerId[playerId] = {
                hasUnlimitedBans = self:HasUnlimitedBans(playerId),
                heroes = {
                    left = MAX_HEROES_BAN_COUNT,
                    total = MAX_HEROES_BAN_COUNT,
                    list = {}
                },
                abilities = {
                    left = MAX_ABILITIES_BAN_COUNT,
                    total = MAX_ABILITIES_BAN_COUNT,
                    list = {}
                }
            }
            self:UpdatePlayerNetTable(playerId)
        end
    end
end

---@param playerId PlayerID
function Pass:UpdatePlayerNetTable(playerId)
    CustomNetTables:SetTableValue("player_bans", tostring(playerId), self.banInfosByPlayerId[playerId])
end

function Pass:TestAllBan()
    if IS_TEST_BAN_ACTIVATED == true then return end

    logger:Logf("AllHeroesCount = %d", #GameRulesCustom.heroesPoolList)
    for i = 1, #GameRulesCustom.heroesPoolList - 9 do
        logger:Logf("%s was banned", GameRulesCustom.heroesPoolList[i])
        HeroSelectionService:OnHeroBan(GameRulesCustom.heroesPoolList[i])
        GameRulesCustom:AddHeroToBlacklist(GameRulesCustom.heroesPoolList[i])
    end
    IS_TEST_BAN_ACTIVATED = true
end

---@param event BanHeroEvent
function Pass:OnBanHero(event)
    if BAN_PHASE_TIME_REMAIN <= 0 then return end
    if self.banInfosByPlayerId[event.PlayerID].heroes.left <= 0 and not self.banInfosByPlayerId[event.PlayerID].hasUnlimitedBans == true then return end

    local fullHeroName = "npc_dota_hero_" .. event.heroName
    if self.banHeroMap[fullHeroName] == true then return end

    if fullHeroName == "npc_dota_hero_antimage" and IsInToolsMode() then
        self:TestAllBan()
    end

    self.banHeroMap[fullHeroName] = true
    HeroSelectionService:OnHeroBan(fullHeroName)
    GameRulesCustom:AddHeroToBlacklist(fullHeroName)

    self.banInfosByPlayerId[event.PlayerID].heroes.left = self.banInfosByPlayerId[event.PlayerID].heroes.left - 1
    table.insert(self.banInfosByPlayerId[event.PlayerID].heroes.list, fullHeroName)
    self:UpdatePlayerNetTable(event.PlayerID)
end

---@param event BanAbilityEvent
function Pass:OnBanAbility(event)
    if BAN_PHASE_TIME_REMAIN <= 0 then return end
    if self.banInfosByPlayerId[event.PlayerID].abilities.left <= 0 and not self.banInfosByPlayerId[event.PlayerID].hasUnlimitedBans == true then return end

    local heroName = AbilityPool:GetAbilityHero(event.abilityName)

    if not heroName then return end
    if self.banAbilitiesMap[event.abilityName] == true then return end

    AbilityPool:RemoveAbility(event.abilityName)

    self.banAbilitiesMap[event.abilityName] = true
    self.banInfosByPlayerId[event.PlayerID].abilities.left = self.banInfosByPlayerId[event.PlayerID].abilities.left - 1
    table.insert(self.banInfosByPlayerId[event.PlayerID].abilities.list, event.abilityName)
    self:UpdatePlayerNetTable(event.PlayerID)
end

---@param playerId PlayerID
---@return boolean
function Pass:HasUnlimitedBans(playerId)
    local uid = GetSteamID(playerId)
    local playerTagTable = CustomNetTables:GetTableValue("service", "player_tag") or {}
    local tag = playerTagTable[uid]

    -- return true
    return tag ~= nil and tag.code == STREAMER_PLUS_TAG_CODE
end

function Pass:OnGameRulesStateChange()
    if GameRulesCustom:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        for playerId, banInfo in pairs(self.banInfosByPlayerId) do
            local uid = PlayerResource:GetSteamAccountID(playerId);
            local bans = {}
            if banInfo.abilities ~= nil then
                for _, abilityName in ipairs(banInfo.abilities.list) do
                    table.insert(bans, {
                        typeCode = "ABILITY",
                        value = abilityName
                    })
                end
            end

            if banInfo.heroes ~= nil then
                for _, heroName in ipairs(banInfo.heroes.list) do
                    table.insert(bans, {
                        typeCode = "HERO",
                        value = heroName
                    })
                end
            end
            PlayerOutboundApi:UpdateBans(tostring(uid), bans)
        end
    end
end