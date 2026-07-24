--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Удалить все навыки стандартным образом (не затрагивая счётчик умений).
---@param playerId integer
---@param abilityName string
---@param unit CDOTA_BaseNPC | nil
function HeroBuilder:RemoveAbility(playerId, abilityName, unit)
    local hero = unit or PlayerResource:GetSelectedHeroEntity(playerId)
    if not hero then return end
    local ability = hero:FindAbilityByName(abilityName)
    if not ability then return end
    -- Удалить связанные способности
    local linkedAbilities = AbilityPool:GetLinkedAbilities(abilityName)
    if linkedAbilities then
        for _, linkedAbilityName in ipairs(linkedAbilities) do
            local linkedAbility = hero:FindAbilityByName(linkedAbilityName)

            local isStillUsing = false
            for _, otherAbility in pairs(hero.abilitiesList) do
                local otherLinked = AbilityPool:GetLinkedAbilities(otherAbility)
                if (otherAbility ~= abilityName) and otherLinked and table.contains(otherLinked, linkedAbilityName) then
                    isStillUsing = true
                end
            end

            if linkedAbility and (not isStillUsing) then
                if linkedAbility:IsHidden() then
                    hero:RemoveAbilityForEmpty(linkedAbilityName)
                else
                    hero:RemoveAbilityWithRestructure(linkedAbilityName)
                end
            end
        end
    end

    if abilityName == "jakiro_liquid_fire" then
        hero:RemoveAbilityForEmpty("jakiro_liquid_ice")     --todo
    end

    if abilityName == "jakiro_liquid_ice" then
        hero:RemoveAbilityForEmpty("jakiro_liquid_fire")
    end

    hero:RemoveAbilityForEmpty(abilityName)
    Util:RemoveAbilityClean(hero, abilityName)
    HeroBuilder:RemoveScepterLinkAbilities(hero, abilityName)
    HeroBuilder:RemoveShardLinkAbilities(hero, abilityName)
end

---Удалить способности связанные с аганим скипетром
---@param hUnit CDOTA_BaseNPC
---@param rawAbilityName string
function HeroBuilder:RemoveScepterLinkAbilities(hUnit, rawAbilityName)
    if hUnit and hUnit:IsRealHero() and hUnit:GetUnitName() and scepterLinkAbilities[rawAbilityName] then
        for _, sAbilityName in ipairs(scepterLinkAbilities[rawAbilityName]) do
            local hAbility = hUnit:FindAbilityByName(sAbilityName)
            if hAbility then
                if scepterAbilities[hUnit:GetUnitName()] == nil or (not table.contains(scepterAbilities[hUnit:GetUnitName()], sAbilityName)) then
                    hUnit:RemoveAbilityWithRestructure(sAbilityName)
                end
            end
        end

        if hUnit.GetPlayerID and hUnit:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hUnit:GetPlayerID())
                return nil
            end)
        end
    end
end

---Удалить способность связанную с шардом
---@param hUnit CDOTA_BaseNPC
---@param rawAbilityName string
function HeroBuilder:RemoveShardLinkAbilities(hUnit, rawAbilityName)
    if hUnit and hUnit:IsRealHero() and hUnit:GetUnitName() and shardLinkAbilities[rawAbilityName] then
        for _, sAbilityName in ipairs(shardLinkAbilities[rawAbilityName]) do
            local hAbility = hUnit:FindAbilityByName(sAbilityName)
            if hAbility then
                if scepterShardAbilities[hUnit:GetUnitName()] == nil or (not table.contains(scepterShardAbilities[hUnit:GetUnitName()], sAbilityName)) then
                    hUnit:RemoveAbilityWithRestructure(sAbilityName)
                end
            end
        end

        if hUnit.GetPlayerID and hUnit:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                HeroBuilder:RefreshAbilityOrder(hUnit:GetPlayerID())
                return nil
            end)
        end
    end
end

---Удалить все способности у героя
---@param playerId integer
---@return integer
function HeroBuilder:RemoveAllAbility(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        local abilitylist = {}
        for i = 0, hHero:GetAbilityCount() - 1 do
            local ability = hHero:GetAbilityByIndex(i)
            if ability ~= nil then
                hHero:RemoveAbilityByHandle(ability)
            end
        end
        return #abilitylist
    end
    return 0
end