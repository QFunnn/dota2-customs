--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param playerId integer
---@param abilityName string
---@param levelNumber integer?
---@param flCoolDown float?
---@param unit CDOTA_BaseNPC?
function HeroBuilder:AddAbility(playerId, abilityName, levelNumber, flCoolDown, unit)
    logger:Log("AbilityName = " .. abilityName)
    local hero = unit or PlayerResource:GetSelectedHeroEntity(playerId)
    if not hero then return end ---@cast hero CDOTA_BaseNPC_Hero

    local shortHeroName = AbilityPool:GetAbilityHero(abilityName)
    if shortHeroName ~= nil and not HeroBuilder.PrecachedHeroList[shortHeroName] then
        PrecacheUnitByNameAsync("npc_dota_hero_" .. shortHeroName, function()
            logger:Log("precache:", shortHeroName, "done")
            HeroBuilder.PrecachedHeroList[shortHeroName] = true
        end)
    end

    if not IsValidEntity(hero) or hero:HasAbility(abilityName) then return end

    local hasInvulnerable = false
    if hero:HasModifier("modifier_hero_refreshing") then
        hasInvulnerable = true
        hero:RemoveModifierByName("modifier_hero_refreshing")
    end

    local ability = hero:AddAbility(abilityName)
    if hasInvulnerable then
        hero:AddNewModifier(hero, nil, "modifier_hero_refreshing", {})
    end

    if not IsValid(ability) or (not hero:HasAbility(abilityName)) then return end

    ability:SetRefCountsModifiers(true)
    ability:ClearInnateModifiers()

    ability:MarkAbilityButtonDirty()
    if hero.CalculateStatBonus and type(hero.CalculateStatBonus) == "function" then
        hero:CalculateStatBonus(false)
    end

    if flCoolDown and flCoolDown > 0 then
        ability:StartCooldown(flCoolDown)
    end

    ability:SetLevel(0)
    if levelNumber and levelNumber > 0 then
        ability:SetLevel(levelNumber)
    end

    ability:SetHidden(false)

    if not unit then
        AbilitySelectionService:Reset(playerId)
    end

    if Util:GetPlayerAbilityCount(playerId) < AbilityQuota:GetTotal(playerId) and Util:GetPlayerAbilityCount(playerId) < 6 then
        AbilitySelectionService:ShowRandomAbilitySelection(playerId)
    end

    Timers:CreateTimer(0.1, function()
        if not ability or ability:IsNull() then
            logger:Log("hNewAbility is null")
            return false
        end

        if ability.sRemovalTimer then
            logger:Log("hNewAbility in RemovalTimer")
            return
        end
        self:SetAbilityToSlot(hero, ability)
        self:AddLinkedAbilities(hero, abilityName, levelNumber)
        self:AddScepterLinkAbilities(hero)
        self:AddShardLinkAbilities(hero, abilityName)
        self:FixShardAbilities(hero)
        self:RefreshAbilityOrder(playerId)

        return nil
    end)
end

---Добавляет способности связанные с аганим скиптером
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilder:AddScepterAbility(hero)
    if (not hero) or (not hero:IsRealHero()) or (not hero:GetUnitName()) then return end

    if scepterAbilities[hero:GetUnitName()] then
        local abilityList = scepterAbilities[hero:GetUnitName()]
        for i, abilityName in ipairs(abilityList) do
            local ability = hero:FindAbilityByName(abilityName)
            if not ability then
                local scepterAbility = hero:AddAbility(abilityName)
                if IsValid(scepterAbility) then
                    hero:RemoveModifierByName(scepterAbility:GetIntrinsicModifierName() or "")
                    scepterAbility:SetLevel(1)
                    scepterAbility.bScepterAbility = true
                    scepterAbility:MarkAbilityButtonDirty()
                    if i == 1 then
                        self:SetAbilityToSlot(hero, scepterAbility)
                        Timers:CreateTimer(0.5, function()
                            if scepterAbility and (not scepterAbility:IsNull()) and scepterAbility:IsHidden() then
                                scepterAbility:SetHidden(false)
                                hero:FindHotKeyForAbility(abilityName)
                            end
                            return nil
                        end)
                    elseif string.find(GetAbilityKeyValuesByName(abilityName).AbilityBehavior, "DOTA_ABILITY_BEHAVIOR_HIDDEN") == nil then
                        self:SetAbilityToSlot(hero, scepterAbility)
                        Timers:CreateTimer(0.5, function()
                            if scepterAbility and (not scepterAbility:IsNull()) and scepterAbility:IsHidden() then
                                scepterAbility:SetHidden(false)
                                hero:FindHotKeyForAbility(abilityName)
                            end
                            return nil
                        end)
                    end
                end
            end
        end
    end

    if hero.GetPlayerID and hero:GetPlayerID() then
        Timers:CreateTimer(FrameTime(), function()
            if not IsValid(hero) then
                return FrameTime()
            else
                HeroBuilder:RefreshAbilityOrder(hero:GetPlayerID())
                return nil
            end
        end)
    end
end

---Добавить способность связанную с шардом
---@param hero CDOTA_BaseNPC_Hero?
---@param parentAbilityName string
function HeroBuilder:AddShardLinkAbilities(hero, parentAbilityName)
    if hero and hero:IsRealHero() and hero:GetUnitName() and hero:HasShard() then
        for sLoopAbilityName, abilityList in pairs(shardLinkAbilities) do
            local hLoopAbility = hero:FindAbilityByName(sLoopAbilityName)

            if hLoopAbility and not hLoopAbility:IsNull() and hLoopAbility.sRemovalTimer == nil then
                for i, sAbilityName in ipairs(abilityList) do
                    local hAbility = hero:FindAbilityByName(sAbilityName)
                    if not (hAbility and hAbility.sRemovalTimer == nil) then
                        local hShardAbility = hero:AddAbility(sAbilityName)
                        if hShardAbility and (not hShardAbility:IsNull()) then
                            hero:RemoveModifierByName(hShardAbility:GetIntrinsicModifierName() or "")
                            if hShardAbility:GetMaxLevel() == 1 then
                                hShardAbility:SetLevel(1)
                            else
                                hShardAbility:SetLevel(hLoopAbility:GetLevel())
                            end

                            if i == 1 then
                                HeroBuilder:SetAbilityToSlot(hero, hShardAbility)
                                Timers:CreateTimer(FrameTime(), function()
                                    if IsValid(hShardAbility) then
                                        hShardAbility:SetHidden(false)
                                        hero:FindHotKeyForAbility(sAbilityName)
                                    end
                                    return nil
                                end)
                            end
                        end
                    end
                end
            end
        end

        if hero.GetPlayerID and hero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(),
                function()
                    HeroBuilder:RefreshAbilityOrder(hero:GetPlayerID())
                    return nil
                end)
        end
    end
end

---Добавить способности от шарда и аганима героя
---@param heroIndex integer
function HeroBuilder:AddScepterShardAbility(heroIndex)
    local hero = EntIndexToHScript(heroIndex) ---@type CDOTA_BaseNPC?

    if hero and hero:IsRealHero() and hero:GetUnitName() and scepterShardAbilities[hero:GetUnitName()] then ---@cast hero CDOTA_BaseNPC_Hero
        local abilityList = scepterShardAbilities[hero:GetUnitName()]
        for i, abilityName in ipairs(abilityList) do
            local ability = hero:FindAbilityByName(abilityName)
            if not ability then
                local scepterOrShardAbility = hero:AddAbility(abilityName)
                if scepterOrShardAbility then
                    hero:RemoveModifierByName(scepterOrShardAbility:GetIntrinsicModifierName() or "")
                    scepterOrShardAbility:SetLevel(1)
                    scepterOrShardAbility:MarkAbilityButtonDirty()
                    if i == 1 then
                        self:SetAbilityToSlot(hero, scepterOrShardAbility)
                        Timers:CreateTimer(0.5, function()
                            if scepterOrShardAbility and (not scepterOrShardAbility:IsNull()) and scepterOrShardAbility:IsHidden() then
                                scepterOrShardAbility:SetHidden(false)
                                hero:FindHotKeyForAbility(abilityName)
                            end
                            return nil
                        end)
                    end
                end
            end
        end

        if hero.GetPlayerID and hero:GetPlayerID() then
            Timers:CreateTimer(FrameTime(), function()
                self:RefreshAbilityOrder(hero:GetPlayerID())
                return nil
            end)
        end
    end

    if hero and hero:IsRealHero() and hero:GetUnitName() == "npc_dota_hero_lycan" and not hero:IsTempestDouble() and not hero:HasModifier("modifier_arc_warden_tempest_double_lua") then
        if not hero.bElfWolf then
            hero.bElfWolf = true
            ExtraCreature:AddExtraCreature(hero:GetPlayerID(), "npc_dota_elf_wolf")
        end
    end
end

---Добавляем абилку связанную с аганим скипетром
---@param hero CDOTA_BaseNPC_Hero?
function HeroBuilder:AddScepterLinkAbilities(hero)
    if (not hero) or (not hero:IsRealHero()) or (not hero:GetUnitName()) or (not hero:HasScepter()) then return end

    for parentAbilityName, linkedAbilityList in pairs(scepterLinkAbilities) do
        local parentAbility = hero:FindAbilityByName(parentAbilityName)

        if parentAbility and not parentAbility:IsNull() and parentAbility.sRemovalTimer == nil then
            for i, linkedAbilityName in ipairs(linkedAbilityList) do
                local linkedAbility = hero:FindAbilityByName(linkedAbilityName)

                if not (linkedAbility and linkedAbility.sRemovalTimer == nil) then
                    local scepterAbility = hero:AddAbility(linkedAbilityName)

                    if not scepterAbility or scepterAbility:IsNull() then
                        logger:LogError("Can't add ScepterAbility" .. linkedAbilityName)
                        goto continue
                    end

                    hero:RemoveModifierByName(scepterAbility:GetIntrinsicModifierName() or "")
                    scepterAbility:SetLevel(1)
                    scepterAbility.bScepterAbility = true

                    if i == 1 then
                        self:SetAbilityToSlot(hero, scepterAbility)

                        Timers:CreateTimer(0.5, function()
                            if IsValid(scepterAbility) then
                                scepterAbility:SetHidden(false)
                                hero:FindHotKeyForAbility(linkedAbilityName)
                            end
                            return nil
                        end)
                    end
                    ::continue::
                end
            end
        end
    end

    Timers:CreateTimer(FrameTime(), function()
        if IsValid(hero) and hero.GetPlayerID and hero:GetPlayerID() then
            self:RefreshAbilityOrder(hero:GetPlayerID())
        end
        return nil
    end)
end

---Добавить герою свзяанные способности
---@param hHero CDOTA_BaseNPC_Hero
---@param abilityName string
---@param levelNumber integer?
function HeroBuilder:AddLinkedAbilities(hHero, abilityName, levelNumber)
    local linkedAbilities = AbilityPool:GetLinkedAbilities(abilityName)
    if not linkedAbilities then return end

    for _, linkedAbilityName in ipairs(linkedAbilities) do
        if hHero:HasAbility(linkedAbilityName) then
            goto continue
        end

        local newLinkedAbility = hHero:AddAbility(linkedAbilityName)
        if not IsValid(newLinkedAbility) then
            logger:LogError("Failed to add LinkedAbility " .. (linkedAbilityName or "NOT VALID"))
            goto continue
        end

        if linkedAbilityName == "lone_druid_true_form_druid" or linkedAbilityName == "lone_druid_true_form_battle_cry" then
            newLinkedAbility:SetHidden(false)
        end

        if AbilityPool:GetLinkedAbilityLevel(linkedAbilityName) > 0 then
            newLinkedAbility:SetLevel(AbilityPool:GetLinkedAbilityLevel(linkedAbilityName))
        end
        if levelNumber and levelNumber > 0 then
            newLinkedAbility:SetLevel(levelNumber)
        end

        if newLinkedAbility and not newLinkedAbility:IsNull() then
            newLinkedAbility:MarkAbilityButtonDirty()
        end

        Timers:CreateTimer(0.1, function()
            if newLinkedAbility and not newLinkedAbility:IsNull() and not newLinkedAbility:IsHidden() then
                self:SetAbilityToSlot(hHero, newLinkedAbility)
            end
            return nil
        end)

        ::continue::
    end
end

---Чинит способности, связанные с шардом
---@param hero CDOTA_BaseNPC_Hero
function HeroBuilder:FixShardAbilities(hero)
    if hero:HasModifier("modifier_item_aghanims_shard") then
        if hero:HasAbility("sandking_epicenter") then
            if not hero:HasModifier("modifier_sand_king_shard") then
                hero:AddNewModifier(hero, hero:FindAbilityByName("sandking_epicenter"), "modifier_sand_king_shard", {})
            end
        end
    end
end