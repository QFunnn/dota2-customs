--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_abilities_fix = class({}) ---@class modifier_abilities_fix : CDOTA_Modifier_Lua

function modifier_abilities_fix:IsHidden()
    return true
end

function modifier_abilities_fix:IsDebuff()
    return false
end

function modifier_abilities_fix:IsPurgable()
    return false
end

function modifier_abilities_fix:IsPurgeException()
    return false
end

function modifier_abilities_fix:AllowIllusionDuplicate()
    return false
end

function modifier_abilities_fix:RemoveOnDeath()
    return false
end

function modifier_abilities_fix:DestroyOnExpire()
    return false
end

function modifier_abilities_fix:IsPermanent()
    return true
end

function modifier_abilities_fix:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_DEATH
    }
end

local abilityPairs = {
    { "ancient_apparition_ice_blast",  "ancient_apparition_ice_blast_release" },
    { "nyx_assassin_burrow",           "nyx_assassin_unburrow" },
    { "naga_siren_song_of_the_siren",  "naga_siren_song_of_the_siren_cancel" },
    { "phoenix_sun_ray",               "phoenix_sun_ray_stop" },
    { "primal_beast_onslaught",        "primal_beast_onslaught_release" },
    { "pangolier_gyroshell",           "pangolier_gyroshell_stop" },
    { "crystal_maiden_freezing_field", "crystal_maiden_freezing_field_stop" },
    { "phoenix_icarus_dive",           "phoenix_icarus_dive_stop" },
    { "techies_reactive_tazer",        "techies_reactive_tazer_stop" },
    { "kez_shodo_sai",                 "kez_shodo_sai_parry_cancel" }
}

local abilitySwap = {}
for _, pair in pairs(abilityPairs) do
    local first = pair[1]
    local second = pair[2]
    abilitySwap[first] = second
    abilitySwap[second] = first
end


local abilityModifier = {
    ["naga_siren_song_of_the_siren"] = "modifier_naga_siren_song_of_the_siren_aura",
    ["phoenix_sun_ray"] = "modifier_phoenix_sun_ray",
    ["primal_beast_onslaught"] = "modifier_primal_beast_onslaught_windup",
    ["pangolier_gyroshell"] = "modifier_pangolier_gyroshell",
    ["crystal_maiden_freezing_field"] = "modifier_crystal_maiden_freezing_field",
    ["phoenix_icarus_dive"] = "modifier_phoenix_icarus_dive",
    ["techies_reactive_tazer"] = "modifier_techies_reactive_tazer",
    ["kez_shodo_sai"] = "modifier_kez_shodo_sai_parry"
}

---@param event ModifierAbilityEvent
function modifier_abilities_fix:OnAbilityFullyCast(event)
    if IsValid(event.ability) and IsValid(event.unit) then
        local abilityName = event.ability:GetAbilityName()
        if abilityName == "crystal_maiden_freezing_field" and not event.unit:HasScepter() then
            return
        end
        local abilitySwapName = abilitySwap[abilityName]
        if abilitySwapName then
            local abilityToSwap = event.unit:FindAbilityByName(abilitySwapName) ---@type CDOTA_Ability_Lua
            if not IsValid(abilityToSwap) then
                return
            end
            if IsValid(abilityToSwap) then
                abilityToSwap:SetHidden(false)
            end
            if IsValid(event.ability) then
                event.ability:SetHidden(true)
            end
        end

        local modifierName = abilityModifier[abilityName]
        if modifierName then
            local modifier = event.unit:FindModifierByName(modifierName)
            if IsValid(modifier) then
                Timers:CreateTimer(modifier:GetDuration() + FrameTime(), function()
                    if IsValid(event.ability) then
                        if event.unit:HasModifier(modifierName) then
                            return
                        end
                        event.ability:SetHidden(false)
                    end
                end)
            end
        end
    end
end

function modifier_abilities_fix:OnDeath(params)
    local hero = params.unit ---@class CDOTA_BaseNPC
    if not IsValid(hero) then return end
    for _, pair in pairs(abilityPairs) do
        local main = hero:FindAbilityByName(pair[1])
        local alt = hero:FindAbilityByName(pair[2])
        if IsValid(main) then
            ---@cast main CDOTABaseAbility
            main:SetHidden(false)
        end
        if IsValid(alt) then
            ---@cast alt CDOTABaseAbility
            alt:SetHidden(true)
        end
    end
    -- if hero:HasAbility("nyx_assassin_burrow") then
    --     Timers:CreateTimer(FrameTime(), function()
    --         hero:FindAbilityByName("nyx_assassin_burrow"):SetHidden(false)
    --         hero:FindAbilityByName("nyx_assassin_unburrow"):SetHidden(true)
    --     end)
    -- end --todo потестить
end