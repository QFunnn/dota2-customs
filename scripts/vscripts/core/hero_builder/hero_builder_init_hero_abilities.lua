--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param hero CDOTA_BaseNPC_Hero
function HeroBuilder:InitHeroAbilities(hero)
    logger:Log("InitHeroAbilities started.")
    local innateAbility
    local specialAbilities = {
        "ringmaster_funhouse_mirror",
        "ringmaster_strongman_tonic",
        "ringmaster_whoopee_cushion",
        "ringmaster_summon_unicycle",
        "oracle_diviners_deck",
        "techies_focused_detonate"
    }

    for i = 0, hero:GetAbilityCount() - 1 do
        local ability = hero:GetAbilityByIndex(i)
        if not ability then
            goto continue
        end

        local abilityName = ability:GetAbilityName()
        local isInnateAbility = self:IsInnateAbility(abilityName)
        if isInnateAbility then
            innateAbility = ability
        end

        if not string.find(abilityName, "special_bonus") and not isInnateAbility and not TableFindKey(specialAbilities, abilityName) then
            hero:RemoveAbility(abilityName)
        end

        ::continue::
    end

    for i = 0, 5 do
        local ability = hero:AddAbility("empty_" .. i)
        local indexAbility = hero:GetAbilityByIndex(i)
        if IsValid(indexAbility) and IsValid(innateAbility) and indexAbility ~= ability and indexAbility == innateAbility then ---@cast indexAbility CDOTABaseAbility
            if innateAbility:IsPassive() then
                hero:SwapAbilities(indexAbility, ability, false, false)
            end
        end
        ability.nPlaceholder = i + 1
    end

    local AbilityInfo = InnateAbilities[hero:GetUnitName()]
    if AbilityInfo and type(AbilityInfo) == "table" then
        local AbilityName = AbilityInfo.AbilityName
        local Level = AbilityInfo.AbilityLevel or 1
        if AbilityName then
            local hAbility = hero:FindAbilityByName(AbilityName)
            if not IsValid(hAbility) then
                hAbility = hero:AddAbility(AbilityName)
            end
            if IsValid(hAbility) then ---@cast hAbility CDOTABaseAbility
                hAbility:SetLevel(Level)
            end
        end
    end
    self:FixInnateAbilities(hero)
    self:RefreshAbilityOrder(hero:GetPlayerOwnerID())
end