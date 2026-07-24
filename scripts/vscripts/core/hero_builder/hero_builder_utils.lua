--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param hHero CDOTA_BaseNPC_Hero
function HeroBuilder:FixInnateAbilities(hHero)
    local heroName = hHero:GetUnitName()
    logger:Log("[HeroBuilder:FixInnateAbilities] HeroName = " .. heroName)

    if heroName == "npc_dota_hero_chen" then
        hHero:AddNewModifier(hHero, nil, "modifier_chen_base", {})
        return
    end
end

---@param abilityName string
---@return boolean
function HeroBuilder:IsInnateAbility(abilityName)
    local kv = GetAbilityKeyValuesByName(abilityName)
    -- logger:Log(abilityName, kv.Innate, kv and kv.Innate == 1)
    if kv and tonumber(kv.Innate) == 1 then
        return true
    end
    return false
end

---@param hHero CDOTA_BaseNPC_Hero
function HeroBuilder:RegisterScepterOwner(hHero)
    if not hHero or not hHero:IsMainHero() then return end
    self.scepterOwners[hHero:GetEntityIndex()] = hHero
end

---@param hHero CDOTA_BaseNPC_Hero
function HeroBuilder:UnregisterScepterOwner(hHero)
    if not hHero or not hHero:IsMainHero() then return end
    if hHero:GetEntityIndex() and self.scepterOwners[hHero:GetEntityIndex()] then
        self.scepterOwners[hHero:GetEntityIndex()] = nil
    end
end

---@param hHero CDOTA_BaseNPC_Hero
function HeroBuilder:OnScepterLost(hHero)
    if not hHero or not hHero:IsMainHero() then return end

    self:UnregisterScepterOwner(hHero)

    for i = 0, hHero:GetAbilityCount() - 1 do
        local hAbility = hHero:GetAbilityByIndex(i)

        if hAbility and hAbility.bScepterAbility then
            local sAbilityName = hAbility:GetAbilityName()
            hHero:RemoveAbilityWithRestructure(sAbilityName)
        end
    end

    self:RefreshAbilityOrder(hHero:GetPlayerOwnerID())

    if hHero:HasModifier("modifier_bloodseeker_blood_mist") then
        hHero:RemoveModifierByName("modifier_bloodseeker_blood_mist")
    end

    EventDriver:Dispatch("Hero:scepter_lost", {hero = hHero})
end

---Обработка владельцов скипетров
function HeroBuilder:ProcessScepterOwners()
    for _, hHero in pairs(self.scepterOwners) do
        if hHero and not hHero:IsNull() and not hHero:HasScepter() then
            self:OnScepterLost(hHero)
        end
    end
end

---@param nPlayerID integer
function HeroBuilder:RefreshAbilityOrder(nPlayerID)
    local hPlayer = PlayerResource:GetPlayer(nPlayerID)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hPlayer and IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        Timers:CreateTimer(0.1, function()
            if IsValid(hHero) then
                hHero.sSwapUISecret = CreateSecretKey()
                CustomGameEventManager:Send_ServerToPlayer(hPlayer, "RefreshAbilityOrder", { swap_ui_secret = hHero.sSwapUISecret })
                CustomGameEventManager:Send_ServerToTeam(hHero:GetTeamNumber(), "UpdateTeamPlayers", {})
            end
            return nil
        end)
    end
end

---@param hHero CDOTA_BaseNPC_Hero?
---@param hAbility CDOTABaseAbility?
function HeroBuilder:SetAbilityToSlot(hHero, hAbility)
    if not hHero then return end
    if not hAbility then return end

    for i = 0, 5 do
        local hSlotAbility = hHero:GetAbilityByIndex(i)

        if not hSlotAbility or hSlotAbility:IsNull() then
            logger:LogError("Can't find hSlotAbility")
        end

        if hSlotAbility and hSlotAbility.nPlaceholder then
            hHero:SwapAbilities(hSlotAbility, hAbility, false, true)
            hAbility:SetAbilityIndex(hSlotAbility.nPlaceholder - 1)
            return
        end
    end
end