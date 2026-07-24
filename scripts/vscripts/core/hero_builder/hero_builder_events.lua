--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function HeroBuilder:RegisterListeners()
    GameListener:SubscribeProtected("hero_selected", function(event) HeroSelectionService:OnHeroSelected(event) end)
    GameListener:SubscribeProtected("ability_selected", function(event) AbilitySelectionService:OnAbilitySelected(event) end)
    GameListener:SubscribeProtected("relearn_book_ability_selected",
        function(event) AbilitySelectionService:OnRelearnBookAbilitySelected(event) end)
    GameListener:SubscribeProtected("SwapAbility", function(event) self:SwapAbility(event) end)
    GameListener:SubscribeProtected("ProposeTeammateSwap", function(event) self:ProposeTeammateSwap(event) end)
    GameListener:SubscribeProtected("AcceptTeammateSwap", function(event) self:AcceptTeammateSwap(event) end)
    GameListener:SubscribeProtected("DeclineTeammateSwap", function(event) self:DeclineTeammateSwap(event) end)
    GameListener:SubscribeProtected("ReorderComplete", function(keys) self:ReorderComplete(keys) end)
    GameListener:SubscribeProtected("RerollHeroes", function(event) HeroSelectionService:OnRerollHeroes(event) end)
    ListenToGameEvent("dota_on_hero_finish_spawn", function(event) self:OnHeroFinishSpawn(event) end, nil)
    --todo разделить ui и game эвенты
end

---Обработчик события todo
---@param event any
function HeroBuilder:ReorderComplete(event)
    if not event.PlayerID then return end

    local nPlayerID = event.PlayerID
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

    if not IsValid(hHero) then return end ---@cast hHero CDOTA_BaseNPC_Hero

    if hHero.sSwapUISecret ~= event.swap_ui_secret then return end

    local sSwap_1 = event.moved_ability
    local sSwap_2 = event.ref_ability

    if hHero then
        local hAbility1 = hHero:FindAbilityByName(sSwap_1)
        local hAbility2 = hHero:FindAbilityByName(sSwap_2)

        if hAbility1 and hAbility2 and not hAbility1:IsHidden() and not hAbility2:IsHidden() then
            hHero:SwapAbilities(hAbility1, hAbility2, true, true)
        end
    end

    self:RefreshAbilityOrder(nPlayerID)
end

---@param event {PlayerID: PlayerID, swap_1: string, swap_2: string}
function HeroBuilder:SwapAbility(event)
    local nPlayerID = event.PlayerID
    local hero = PlayerResource:GetSelectedHeroEntity(nPlayerID)

    local abilityName1 = event.swap_1
    local abilityName2 = event.swap_2

    if hero then
        local ability1 = hero:FindAbilityByName(abilityName1)
        local ability2 = hero:FindAbilityByName(abilityName2)
        if ability1 and ability2 and not ability1:IsHidden() and not ability2:IsHidden() then
            hero:SwapAbilities(ability1, ability2, true, true)
        end
    end

    self:RefreshAbilityOrder(nPlayerID)
end

---@param event {heroindex: EntityIndex}
function HeroBuilder:OnHeroFinishSpawn(event)
    logger:Log("[HeroBuilder:OnHeroFinishSpawn] start.")
    local hero = EntIndexToHScript(event.heroindex) ---@type CDOTA_BaseNPC_Hero?
    if not hero or not IsValidEntity(hero) then return end

    local playerId = hero:GetPlayerOwnerID()
    local heroName = hero:GetUnitName()

    PrecacheUnitByNameAsync(heroName, function()
        logger:Log(string.format("Hero %s precache done.", heroName))
    end, nil)

    if self.HeroInited[playerId] then return end

    if hero.abilitiesList == nil then
        hero.abilitiesList = {}
    end

    if Util:GetSupposeRoom(hero) == "prepare" then
        hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
    end

    hero:AddNewModifier(hero, nil, "modifier_spell_amplify_controller", {})

    local aegises = hero:AddNewModifier(hero, nil, "modifier_aegis", {})
    aegises:SetStackCount(self.initAegisCount)

    hero.nOriginalAttackCapability = hero:GetAttackCapability()

    local tpScroll = hero:FindItemInInventory("item_tpscroll")
    if tpScroll then
        tpScroll:RemoveSelf()
    end

    logger:Log(string.format("%s spawned for player %d", heroName, playerId))

    self:InitHeroAbilities(hero)

    self.HeroInited[playerId] = true
    logger:Log(string.format("%s fully initialized", heroName))
end