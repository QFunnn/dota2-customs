--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@param keys ModifierGainedFilterEvent
---@return boolean
function GameMode:ModifierGainedFilter(keys)
    local hCaster = nil
    local hParent = nil

    if keys then
        if keys.entindex_caster_const ~= nil then
            hCaster = EntIndexToHScript(keys.entindex_caster_const) ---@cast hCaster CDOTA_BaseNPC
        end
        if keys.entindex_parent_const ~= nil then
            hParent = EntIndexToHScript(keys.entindex_parent_const) ---@cast hParent CDOTA_BaseNPC
        end
    end
    if hParent and hParent:GetUnitName() == "npc_dota_broodmother_web" then
        if keys.name_const == "modifier_broodmother_spin_web_web" then
            local hero = hParent:GetOwner()
            local hAbility = hero:FindAbilityByName("broodmother_spin_web")
            hParent:AddNewModifier(hero, hAbility, "modifier_broodmother_spin_web_web_lua", {})
            return false
        end
    end

    if keys and keys.name_const and (keys.name_const == "modifier_item_ultimate_scepter" or keys.name_const == "modifier_item_ultimate_scepter_consumed") then
        local hHero = EntIndexToHScript(keys.entindex_parent_const)
        if hHero:IsRealHero() and not hHero:HasModifier("modifier_illusion") then
            HeroBuilder:AddScepterAbility(hHero)
            HeroBuilder:AddScepterLinkAbilities(hHero)
            HeroBuilder:RegisterScepterOwner(hHero)
            EventDriver:Dispatch("Hero:ScepterReceived", {hero = hHero})
        end
    end
    if keys and keys.name_const and keys.name_const == "modifier_item_aghanims_shard" then
        local hHero = EntIndexToHScript(keys.entindex_parent_const) ---@cast hHero CDOTA_BaseNPC_Hero
        if hHero:IsRealHero() and not hHero:HasModifier("modifier_illusion") then
            HeroBuilder:AddShardLinkAbilities(hHero)
            HeroBuilder:AddScepterShardAbility(keys.entindex_parent_const)
        end
    end

    if keys and keys.name_const and keys.name_const == "modifier_legion_commander_duel" then
        local hUnit = EntIndexToHScript(keys.entindex_parent_const)
        local hModifier = hUnit:FindModifierByName("modifier_legion_commander_duel")
        if hModifier and not hUnit:IsHero() then
            local hCaster = hModifier:GetCaster()
            local hAbility = hModifier:GetAbility()
            local flDuration = hModifier:GetDuration()
            -- Ограничено одним разом за раунд. Снимается в modifier_hero_refreshing
            if hCaster and hAbility and (not hAbility.bRoundDueled) then
                hAbility.bRoundDueled = true
                hUnit:AddNewModifier(hCaster, hAbility, "modifier_legion_commander_duel_creep", {duration = flDuration})
            end
        end
    end

    -- Если способ атаки изменится, зафиксировать это и выполнить исправление с помощью таймера
    if keys.name_const and HeroBuilder.attackCapabilityModifiers[keys.name_const] and keys.entindex_parent_const then
        local hParent = EntIndexToHScript(keys.entindex_parent_const)
        if hParent then
            HeroBuilder:RegisterAttackCapabilityChanged(hParent)
        end
    end

    if keys and keys.name_const and keys.name_const == "modifier_illusion" then
        Illusion:InitIllusion(hParent, hCaster)
    end

    if keys and keys.name_const and keys.name_const == "modifier_fountain_invulnerability" then
        return false
    end

    if keys and keys.name_const and keys.name_const == "modifier_life_stealer_infest_creep" and IsValid(hParent) and hParent ~= nil then
        if hParent:HasModifier("modifier_neutral_upgrade_lua") then
            hParent:Kill(nil, hCaster)
        end
    end

    if keys and keys.name_const and keys.name_const == "modifier_hero_refreshing" and hParent:IsIllusion() then
        return false
    end

    if keys and keys.name_const and keys.name_const == "modifier_lone_druid_spirit_bear_attack_check" then 
        return false
    end

    return true
end