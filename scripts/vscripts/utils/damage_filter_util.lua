--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if damage_filter_util == nil then
    _G.damage_filter_util = class({})
end

damage_filter_util.abilities_oneshot = 
{
    --["enigma_demonic_conversion_custom"] = true,
    --["night_stalker_hunter_in_the_night_custom"] = true,
    --["night_stalker_darkness_passive"] = true,
    --["doom_bringer_devour_custom"] = true,
    --["pudge_meat_hook"] = true,
    --["mirana_arrow"] = true,
    --["item_hand_of_midas_custom"] = true,
    --["life_stealer_infest"] = true,
    --["life_stealer_consume"] = true,
}

damage_filter_util.abilities_oneshot_curse = 
{
    ["life_stealer_infest"] = true,
    ["life_stealer_consume"] = true,
}

-- Способности, которые наносят урон от максимального здоровья крипа
damage_filter_util.abilities_max_health_damage = 
{
    ["pudge_meat_hook"] = true,
    ["mirana_arrow"] = true,
    ["night_stalker_hunter_in_the_night_custom"] = true,
    ["item_hand_of_midas_custom"] = true,
    ["doom_bringer_devour_custom"] = true,
    ["enigma_demonic_conversion_custom"] = true,
    ["snapfire_gobble_up_custom"] = true
}

function damage_filter_util:GetNewDamageFromAbilities(params, attacker, target)
    local damage = params.damage
    local ability = nil
    local ability_name = ""
    if params.entindex_inflictor_const then
        ability = EntIndexToHScript(params.entindex_inflictor_const)
    end
    if ability then
        ability_name = ability:GetAbilityName()
    end
    
    -- Полностью отключаем урон от шарда на Meat Hook
    -- Шард наносит дополнительный урон с флагом DOTA_DAMAGE_FLAG_PROPERTY_FIRE (8)
    if ability and ability_name == "pudge_meat_hook" then
        -- Проверяем, является ли это уроном от шарда (огненный урон)
        if params.damage_flags and params.damage_flags == 8 then
            -- Полностью отменяем дополнительный урон от шарда для всех целей
            return 0
        end
    end

    if target and (target:GetUnitName() == "npc_dota_roshan" or target:GetUnitName() == "npc_dota_nian") and ability and ability_name == "mirana_arrow" then
        return 0
    end

    -- Hydra's Breath не должна наносить урон Roshan / Nian (задача #46).
    -- string.find покрывает все 6 ванильных вариантов: item_hydras_breath, _2..._6.
    if target and (target:GetUnitName() == "npc_dota_roshan" or target:GetUnitName() == "npc_dota_nian") and ability and string.find(ability_name, "item_hydras_breath") then
        return 0
    end

    if ability and ability_name == "oracle_false_promise_custom" then
        if target:HasModifier("modifier_hero_refreshing") then
            damage = 0
        end
    elseif ability and "sandking_burrowstrike" == ability_name then
        if attacker and attacker.HasScepter and attacker:HasScepter() then
            local sandking_caustic_finale_lua = attacker:FindAbilityByName("sandking_caustic_finale_lua")
            if sandking_caustic_finale_lua and sandking_caustic_finale_lua:GetLevel() >= 1 and target then
                local nDuration = sandking_caustic_finale_lua:GetSpecialValueFor( "caustic_finale_duration" )
                target:AddNewModifier(attacker, sandking_caustic_finale_lua, "modifier_sand_king_caustic_finale_lua_debuff", {duration = nDuration})
            end
        end
    end

    -- Суммарные стаки курс, режущих исходящий урон: report-курса (наказание за репорты,
    -- MULTIPLE, считается ВСЕГДА, в т.ч. в PVP) + обычная modifier_loser_curse (только вне PVP).
    -- 0.2 за стак, суммарно. Быстрый гейт HasModifier, чтобы не перебирать модификаторы зря.
    local curseStacks = 0
    if attacker and not attacker:IsNull()
       and (attacker:HasModifier("modifier_report_curse")
            or (not attacker:IsUnitInPVP() and attacker:HasModifier("modifier_loser_curse"))) then
        for _, m in pairs(attacker:FindAllModifiers()) do
            if m and m.GetName and m:GetName() == "modifier_report_curse" then
                curseStacks = curseStacks + (m:GetStackCount() or 0)
            end
        end
        if not attacker:IsUnitInPVP() then
            local lc = attacker:FindModifierByName("modifier_loser_curse")
            if lc then curseStacks = curseStacks + (lc:GetStackCount() or 0) end
        end
    end

    -- Показываем процент урона для способностей из списка abilities_max_health_damage
    if ability and damage_filter_util.abilities_max_health_damage[ability:GetAbilityName()] and target and not target:IsHero() then
        local damagePercent = 1.0 - (curseStacks * 0.2)

        -- Показываем визуальную надпись над крипом с процентом урона
        local damagePercentDisplay = math.floor(damagePercent * 100)
        SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, target, damagePercentDisplay, nil)

        -- Рассчитываем урон
        if damagePercent <= 0 then
            damage = 0
        else
            damage = target:GetMaxHealth() * damagePercent
        end
    elseif curseStacks > 0 then
        if ability == nil or (ability ~= nil and not damage_filter_util.abilities_oneshot_curse[ability:GetAbilityName()]) then
            damage = tonumber(damage) * math.max(0, 1 - (0.2 * curseStacks))
        end
    end

    if ability ~= nil and damage_filter_util.abilities_oneshot[ability:GetAbilityName()] ~= nil then
        if GameMode.currentRound and GameMode.currentRound.nRoundNumber > 70 then
            if target and RollPercentage(30) and target:GetHealth() > target:GetMaxHealth() * 0.51 and not target:IsHero() then
                damage = target:GetMaxHealth() * 0.51
            end
        end
    end

    return damage
end