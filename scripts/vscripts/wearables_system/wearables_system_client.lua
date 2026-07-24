--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if not wearables_system then
    wearables_system = class({})
    wearables_system.ReplacementInfo = {}
end

ListenToGameEvent("event_change_ability_icon", function(event)
    local entindex = event.entindex
    local asset = event.asset
    local modifier = event.modifier
    local ability_name = event.ability_name
    local unit = EntIndexToHScript(entindex)
    if unit then
        if modifier == "" then
            modifier = nil
        end
        if ability_name and ability_name ~= "" and ability_name ~= " " then
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_icon_replace[ability_name] = wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_icon_replace[ability_name] or {}
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_icon_replace[ability_name][asset] = modifier
        else
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_icon_replace[asset] = modifier
        end
    end
end, nil)

ListenToGameEvent("event_change_ability_pfx", function(event)
    local entindex = event.entindex
    local asset = event.asset
    local modifier = event.modifier
    local ability_name = event.ability_name
    local unit = EntIndexToHScript(entindex)
    if unit then
        if modifier == "" then
            modifier = nil
        end
        if ability_name and ability_name ~= "" and ability_name ~= " " then
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_pfx_replace[ability_name] = wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_pfx_replace[ability_name] or {}
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_effects_pfx_replace[ability_name][asset] = modifier
        else
            wearables_system.ReplacementInfo[unit:GetUnitName()].ability_pfx_replace[asset] = modifier
        end
    end
end, nil)

ListenToGameEvent("event_init_unit", function(event)
    local hero_name = event.hero_name
    wearables_system.ReplacementInfo[hero_name] = {}
    wearables_system.ReplacementInfo[hero_name].ability_icon_replace = {}
    wearables_system.ReplacementInfo[hero_name].ability_pfx_replace = {}

    wearables_system.ReplacementInfo[hero_name].ability_effects_icon_replace = {}
    wearables_system.ReplacementInfo[hero_name].ability_effects_pfx_replace = {}
end, nil)

function wearables_system:GetAbilityIconReplacement(unit, icon_name, ability_handle, ability_name_new)
if not unit then 
    if ability_handle then
        unit = ability_handle:GetCaster()
    end
    if not unit then
        return icon_name 
    end
end

local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
if not replacement_info then return icon_name end
local ability_name = nil
if ability_name_new then
    ability_name = ability_name_new
end
if ability_handle and ability_name == nil then
    ability_name = wearables_system:GetAbilityIconTry(ability_handle)
end
if ability_name then
    local ability_effects_icon_replace = replacement_info.ability_effects_icon_replace[ability_name]
    if ability_effects_icon_replace and ability_effects_icon_replace[icon_name] then return ability_effects_icon_replace[icon_name] end
end
local ability_icon_replace = replacement_info.ability_icon_replace[icon_name]
if ability_icon_replace then return ability_icon_replace end
return icon_name
end

function wearables_system:GetAbilityIconTry(ability_handle)
    if ability_handle.GetAbilityName then
        return ability_handle:GetAbilityName()
    elseif ability_handle.GetAbility then
        if ability_handle:GetAbility() and ability_handle:GetAbility().GetAbilityName then
            return ability_handle:GetAbility():GetAbilityName()
        end
    end
    return nil
end

function wearables_system:GetParticleReplacement(unit, particle_name, ability_handle)
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return particle_name end
    local pct_replace = replacement_info.ability_pfx_replace[particle_name] 
    if pct_replace then
        return pct_replace
    end
    return particle_name
end

function wearables_system:GetParticleReplacementAbility(unit, particle_name, ability_handle, ability_name_new)
    local ability_name = nil
    if ability_name_new then
        ability_name = ability_name_new
    end
    if ability_handle and ability_name == nil then
        ability_name = wearables_system:GetAbilityIconTry(ability_handle)
    end
    local replacement_info = self.ReplacementInfo[unit:GetUnitName()]
    if not replacement_info then return particle_name end
    if ability_name then
        if replacement_info.ability_effects_pfx_replace[ability_name] and replacement_info.ability_effects_pfx_replace[ability_name][particle_name] then
            return replacement_info.ability_effects_pfx_replace[ability_name][particle_name]
        end
    end
    local pct_replace = replacement_info.ability_pfx_replace[particle_name] 
    if pct_replace then
        return pct_replace
    end
    return particle_name
end