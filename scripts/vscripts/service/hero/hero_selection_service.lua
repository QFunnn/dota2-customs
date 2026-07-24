--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



if HeroSelectionService == nil then HeroSelectionService = class({}) end ---@class HeroSelectionService

---@class PlayerHeroSelectInfo
---@field herolist table<integer, string[]>
---@field page integer
---@field reroll_count integer
---@field rerollButtonEnabled boolean

function HeroSelectionService:Init()
    self.allHeroeNames = table.deepcopy(GameRulesCustom.heroesPoolList)
    self.PlayerHeroSelect = {} ---@type table<PlayerID, PlayerHeroSelectInfo>
    self.playerHeroList = {} ---@type table<PlayerID, string[]>
    self.heroNameToPlayerIdMap = {} ---@type table<string, PlayerID> [npc_dota_hero_axe]: PlayerID
    self.Hero = {} ---@type table<PlayerID, string> подтверждённый герой игрока

    for i = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if not PlayerResource:IsFakeClient(i) then
            self.PlayerHeroSelect[i] = {
                herolist = {},
                page = 1,
                reroll_count = 1,
                rerollButtonEnabled = true
            }
            self.playerHeroList[i] = {}
            self.Hero[i] = ""
        end
    end
end

---@return string|nil
function HeroSelectionService:RandomHeroFromPool()
    return table.random(self.allHeroeNames)
end

---@param playerId integer
function HeroSelectionService:GenerateHeroSelection(playerId)
    logger:Logf("Generaete hero selection for playerId %d", playerId)
    local heroList = table.random_some(self.allHeroeNames, 7)
    if heroList == nil then return end

    for i = 1, #heroList do
        local heroName = heroList[i]
        table.remove_item(self.allHeroeNames, heroName)
        table.insert(self.playerHeroList[playerId], heroName)
        self.heroNameToPlayerIdMap[heroName] = playerId
    end
    self:RefreshHeroSelection(playerId, self.playerHeroList[playerId])
end

function HeroSelectionService:InternalSelectHeroForPlayersIfNotLockedIn()
    for playerID = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if PlayerResource:IsFakeClient(playerID) then
            goto continue
        end
        if self.Hero[playerID] ~= "" then
            goto continue
        end
        local player = PlayerResource:GetPlayer(playerID)
        if not player then
            goto continue
        end
        local heroList = self.playerHeroList[playerID]
        if not heroList or not heroList[1] then
            goto continue
        end
        player:SetSelectedHero(heroList[1])
        CustomGameEventManager:Send_ServerToAllClients("update_hero_select_state", {
            heroName = heroList[1],
            PlayerID = playerID
        })

        ::continue::
    end
end

---@param heroName string
function HeroSelectionService:OnHeroBan(heroName)
    table.remove_item(self.allHeroeNames, heroName)
    if not self.heroNameToPlayerIdMap[heroName] then return end

    local playerId = self.heroNameToPlayerIdMap[heroName]
    local newHero = table.random(self.allHeroeNames)
    logger:Logf("NewHero = %s", newHero)
    self.heroNameToPlayerIdMap[heroName] = nil
    if newHero then
        table.remove_item(self.allHeroeNames, newHero)
        self.heroNameToPlayerIdMap[newHero] = playerId
    end
    for i = 1, #self.playerHeroList[playerId] do
        if self.playerHeroList[playerId][i] == heroName then
            self.playerHeroList[playerId][i] = newHero
            break
        end
    end
    self:RefreshHeroSelection(playerId, self.playerHeroList[playerId])
end

---@param event any
function HeroSelectionService:OnRerollHeroes(event)
    logger:Log("RerollHeroes call.")
    local playerId = event.PlayerID
    if playerId ~= nil and playerId ~= -1 then
        if self.PlayerHeroSelect[playerId].rerollButtonEnabled == true then
            local playerHeroSelect = self.PlayerHeroSelect[playerId]
            playerHeroSelect.page = playerHeroSelect.page + 1
            playerHeroSelect.rerollButtonEnabled = playerHeroSelect.reroll_count == playerHeroSelect.page + 1
            self.PlayerHeroSelect[playerId] = playerHeroSelect
            self:UpdateHeroSelectNetTable(playerId)
        end
    end
end

---@param playerId PlayerID
function HeroSelectionService:UpdateHeroSelectNetTable(playerId)
    logger:Logf("NetTable was updated")
    PrintTable(self.PlayerHeroSelect[playerId])
    CustomNetTables:SetTableValue("hero_select", tostring(playerId), self.PlayerHeroSelect[playerId])
end

---@param playerId PlayerID
---@param choice any
function HeroSelectionService:RefreshHeroSelection(playerId, choice)
    for i = 1, self.PlayerHeroSelect[playerId].reroll_count + 1 do
        self.PlayerHeroSelect[playerId].herolist[i] = { choice[1] }
        for j = (i - 1) * 3 + 2, i * 3 + 1 do
            table.insert(self.PlayerHeroSelect[playerId].herolist[i], choice[j])
        end
    end
    self:UpdateHeroSelectNetTable(playerId)
end

---@param event {heroName: string, PlayerID: PlayerID}
function HeroSelectionService:OnHeroSelected(event)
    logger:Logf("OnHeroSelected call. HeroName = %s", event.heroName)
    local heroName = event.heroName
    local playerId = event.PlayerID
    local player = PlayerResource:GetPlayer(playerId)

    if not player then
        logger:Log("HeroSelected, but hPlayer is null")
        return
    end

    if not DevUtils:Check() then
        local currentPage = self.PlayerHeroSelect[playerId].page
        if not table.contains(self.PlayerHeroSelect[playerId].herolist[currentPage], heroName) then
            return
        end
    end

    GameRulesCustom:RemoveHeroFromBlacklist(heroName)
    self.Hero[playerId] = heroName
    player:SetSelectedHero(heroName)
    CustomGameEventManager:Send_ServerToAllClients("update_hero_select_state",
        {
            heroName = heroName,
            PlayerID = playerId
        })
end