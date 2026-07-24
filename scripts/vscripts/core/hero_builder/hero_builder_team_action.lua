--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Обработчик инициализации командного свапа
---@param event any
function HeroBuilder:ProposeTeammateSwap(event)
    if not event.own or not event.other then return end
    local hProposeHero = PlayerResource:GetSelectedHeroEntity(event.PlayerID)

    if not hProposeHero then
        logger:Log("hProposeHero is nil")
        return
    end

    if hProposeHero.sTeamSwapUISecret ~= event.ui_secret then
        logger:Log("event.ui_secret" .. event.ui_secret .. "is wrong")
        return
    end

    if not hProposeHero.nSwappingItemIndex then
        logger:Log("hProposeHero.nSwappingItemIndex is false")
        return
    end

    local hFirstAbility = EntIndexToHScript(event.own)

    if not hFirstAbility then return end
    if not hFirstAbility:GetCaster() then return end

    if event.PlayerID ~= hFirstAbility:GetCaster():GetPlayerID() then
        logger:Log("event.PlayerID is wrong")
        return
    end

    event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
    event.proposer_id = event.PlayerID

    local hSecondAbility = EntIndexToHScript(event.other)
    if not hSecondAbility then
        logger:Log("hSecondAbility is nil")
        return
    end

    local hFirstPlayer = hFirstAbility:GetCaster():GetPlayerOwner()
    local hSecondPlayer = hSecondAbility:GetCaster():GetPlayerOwner()

    local hFirstHero = hFirstAbility:GetCaster()
    local hSecondHero = hSecondAbility:GetCaster()

    if abilityExclusion[hSecondAbility:GetAbilityName()] then
        for _, sExclusion in ipairs(abilityExclusion[hSecondAbility:GetAbilityName()]) do
            if table.contains(hFirstHero.abilitiesList, sExclusion) and sExclusion ~= hFirstAbility:GetAbilityName() then
                if hFirstPlayer then
                    CustomGameEventManager:Send_ServerToPlayer(hFirstPlayer, "ConflictAbility", {})
                end
                self:SwapNotValide(event)
                return
            end
        end
    end

    if abilityExclusion[hFirstAbility:GetAbilityName()] then
        for _, sExclusion in ipairs(abilityExclusion[hFirstAbility:GetAbilityName()]) do
            if table.contains(hSecondHero.abilitiesList, sExclusion) and sExclusion ~= hSecondAbility:GetAbilityName() then
                if hFirstPlayer then
                    CustomGameEventManager:Send_ServerToPlayer(hFirstPlayer, "ConflictTeammateAbility", {})
                end
                self:SwapNotValide(event)
                return
            end
        end
    end

    if heroExclusion[hFirstHero:GetUnitName()] then
        for _, sExclusion in ipairs(heroExclusion[hFirstHero:GetUnitName()]) do
            if sExclusion == hSecondAbility:GetAbilityName() then
                if hFirstPlayer then
                    CustomGameEventManager:Send_ServerToPlayer(hFirstPlayer, "ConflictModel", {})
                end
                self:SwapNotValide(event)
                return
            end
        end
    end

    if heroExclusion[hSecondHero:GetUnitName()] then
        for _, sExclusion in ipairs(heroExclusion[hSecondHero:GetUnitName()]) do
            if sExclusion == hFirstAbility:GetAbilityName() then
                if hFirstPlayer then
                    CustomGameEventManager:Send_ServerToPlayer(hFirstPlayer, "ConflictTeammateModel", {})
                end
                self:SwapNotValide(event)
                return
            end
        end
    end

    local sVerification = tostring(event.own) .. "_" .. tostring(event.other)
    self.pendingSwaps[sVerification] = event

    if (hSecondHero and hSecondHero.bTakenOverByBot) or PlayerResource:IsFakeClient(hSecondHero:GetPlayerID()) then
        self:AcceptTeammateSwap(event)
    else
        CustomGameEventManager:Send_ServerToTeam(hSecondAbility:GetCaster():GetTeamNumber(), "LockAbilities", event)
        Timers:CreateTimer(1 / 15, function()
            CustomGameEventManager:Send_ServerToPlayer(hSecondPlayer, "SwapProposed", event)
            return nil
        end)

        Timers:CreateTimer(sVerification, {
            useGameTime = false,
            endTime = 19.8,
            callback = function()
                self:ResetSwapStatus(event, false)
                return nil
            end
        })
    end
end

---Обрабатывает событие свапа способности
---@param event any
function HeroBuilder:AcceptTeammateSwap(event)
    xpcall(function()
        if not event.own or not event.other then return end

        local sVerification = tostring(event.own) .. "_" .. tostring(event.other)
        if not self.pendingSwaps[sVerification] then return end

        local swapData = self.pendingSwaps[sVerification]
        if swapData.own ~= event.own or swapData.other ~= event.other then
            return
        end

        Timers:RemoveTimer(sVerification)

        local hFirstAbility = EntIndexToHScript(event.own)
        local hSecondAbility = EntIndexToHScript(event.other)

        if not hFirstAbility or not hSecondAbility then
            logger:Log("hFirstAbility or hSecondAbility not there")
            event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
            self:ResetSwapStatus(event, false)
            return
        end

        if event.item_index and type(event.item_index) == "number" then
            local hSwapItem = EntIndexToHScript(event.item_index)
            if not hSwapItem then
                logger:Log("hSwapItem not there")
                self:ResetSwapStatus(event, false)
                return
            end
        else
            logger:Log("event.item_index is wrong")
            self:ResetSwapStatus(event, false)
            return
        end

        local firstHero = hFirstAbility:GetCaster()
        local secondHero = hSecondAbility:GetCaster()

        local firstAbilityName = hFirstAbility:GetAbilityName()
        local secondAbilityName = hSecondAbility:GetAbilityName()

        local secondPlayerId = secondHero:GetPlayerOwnerID()
        if event.PlayerID ~= secondPlayerId and not (PlayerResource:IsFakeClient(secondPlayerId) or secondHero.bTakenOverByBot) then
            return
        end

        local firstPlayerId = firstHero:GetPlayerOwnerID()

        if not table.contains(firstHero.abilitiesList, firstAbilityName) then
            self:ResetSwapStatus(event, false)
            return
        end

        if not table.contains(secondHero.abilitiesList, secondAbilityName) then
            self:ResetSwapStatus(event, false)
            return
        end

        if not firstHero:HasAbility(firstAbilityName) then
            self:ResetSwapStatus(event, false)
            return
        end

        if not secondHero:HasAbility(secondAbilityName) then
            self:ResetSwapStatus(event, false)
            return
        end

        event.team_nubmer = PlayerResource:GetTeam(event.PlayerID)
        event.proposer_id = firstHero:GetPlayerOwnerID()

        local flFirstCooldown = hFirstAbility:GetCooldownTimeRemaining()
        local flSecondCooldown = hSecondAbility:GetCooldownTimeRemaining()

        firstHero:SetAbilityPoints(firstHero:GetAbilityPoints() + hFirstAbility:GetLevel())
        secondHero:SetAbilityPoints(secondHero:GetAbilityPoints() + hSecondAbility:GetLevel())

        self:RemoveAbility(firstPlayerId, firstAbilityName)
        self:RemoveAbility(secondPlayerId, secondAbilityName)

        self:AddAbility(firstPlayerId, secondAbilityName, nil, flSecondCooldown)
        self:AddAbility(secondPlayerId, firstAbilityName, nil, flFirstCooldown)

        self:ReplaceAbilityList(firstHero, firstAbilityName, secondAbilityName)
        self:ReplaceAbilityList(secondHero, secondAbilityName, firstAbilityName)

        Timers:CreateTimer(0.02, function()
            self:RefreshAbilityOrder(firstHero:GetPlayerOwnerID())
            self:RefreshAbilityOrder(secondHero:GetPlayerOwnerID())
            return nil
        end)

        self:ResetSwapStatus(event, true)

    end, function(e)
        logger:LogError(e)
        self:ResetSwapStatus(event, false)
    end)
end

function HeroBuilder:DeclineTeammateSwap(keys)
    local nPlayerID = keys.PlayerID
    keys.team_nubmer = PlayerResource:GetTeam(nPlayerID)
    self:ResetSwapStatus(keys, false)
end

function HeroBuilder:ResetSwapStatus(event, bAccept)
    if not event.own or not event.other then return end
    local sVerification = tostring(event.own) .. "_" .. tostring(event.other)
    if not self.pendingSwaps[sVerification] then return end

    if event.proposer_id then
        local hProposeHero = PlayerResource:GetSelectedHeroEntity(event.proposer_id)
        hProposeHero.nSwappingItemIndex = nil
    end

    if event.item_index and bAccept then
        local hSwapItem = EntIndexToHScript(event.item_index)
        if hSwapItem and hSwapItem.SpendCharge then
            hSwapItem:SpendCharge()
        end
    end

    event.accepted = bAccept
    self.pendingSwaps[sVerification] = nil
    CustomGameEventManager:Send_ServerToTeam(event.team_nubmer, "UnlockAbilities", event)
end

---Обработчик события невалидного свапа
---@param event any
function HeroBuilder:SwapNotValide(event)
    if not event.own or not event.other then return end

    if event.proposer_id then
        local hProposeHero = PlayerResource:GetSelectedHeroEntity(event.proposer_id)
        hProposeHero.nSwappingItemIndex = nil
    end
    local hPlayer = PlayerResource:GetPlayer(event.PlayerID)
    CustomGameEventManager:Send_ServerToPlayer(hPlayer, "SwapNotValide", event)
end