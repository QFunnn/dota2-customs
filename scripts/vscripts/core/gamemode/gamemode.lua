--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("core.gamemode.gamemode_bots")
require("core.gamemode.gamemode_end")
require("core.gamemode.gamemode_events_custom")
require("core.gamemode.gamemode_events")
require("core.gamemode.gamemode_filters_register")
require("core.gamemode.gamemode_game_rules_state_change_event")
require("core.gamemode.gamemode_init")
require("core.gamemode.gamemode_precache")
require("core.gamemode.gamemode_round_config")
require("core.gamemode.gamemode_round_finish")
require("core.gamemode.gamemode_spawn_units")
require("core.gamemode.gamemode_team")
require("core.gamemode.gamemode_update")
require("core.gamemode.gamemode_utils")


function GameMode:Activate()
    logger:Log("[Activate] Stared")
    require("core.gamemode.gamemode_config")

    CustomNetTables:SetTableValue("admin", "admins", { 364993705, 1278954310 })

    self:InitGlobals()
    self:InitSystems()
    self:ConfigureGameRules()
    self:ConfigureXPTable()
    self:RegisterEventListeners()
    self:RegisterCustomEventListeners()
    self:RegisterFilters()
    self:SetupAutoLaunchTimer()

    logger:Log("[Activate] Ended")
end

function GameMode:Reload()
    logger:Log("Reload Scripts Started")

    if GameRulesCustom:State_Get() <= DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD then
        return
    end

    GameRulesCustom:Playtesting_UpdateAddOnKeyValues()
    FireGameEvent("client_reload_game_keyvalues", {})

    local allUnits = FindUnitsInRadius(
        DOTA_TEAM_GOODGUYS,
        Vector(0, 0, 0),
        nil,
        -1,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
        DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
        FIND_ANY_ORDER,
        false
    )

    for _, unit in pairs(allUnits) do
        if IsValid(unit) then
            for abilityIndex = 0, unit:GetAbilityCount() - 1 do
                local ability = unit:GetAbilityByIndex(abilityIndex)
                if not IsValid(ability) then ---@cast ability CDOTABaseAbility
                    goto continue
                end
                if ability:GetLevel() > 0 then
                    local modifierName = ability:GetIntrinsicModifierName()
                    if modifierName and modifierName ~= "" then
                        ability:RefreshIntrinsicModifier()
                    end
                end
                ::continue::
            end

            for itemSlot = DOTA_ITEM_SLOT_1, DOTA_STASH_SLOT_6 do
                local item = unit:GetItemInSlot(itemSlot)
                if IsValid(item) then ---@cast item CDOTA_Item
                    local modifierName = item:GetIntrinsicModifierName()
                    if modifierName and modifierName ~= "" then
                        item:RefreshIntrinsicModifier()
                    end
                end
            end
        end
    end

    logger:Log("Reload Scripts completed")
end

---@return string
function GameMode:GetMatchType()
    mapName = GetMapName()
    if mapName == "1x8" then
        return MATCH_TYPE_SOLO
    elseif mapName == "2x6" then
        return MATCH_TYPE_DUO
    end
    return MATCH_TYPE_PVE
end

---@enum MatchType
MATCH_TYPE_SOLO = "PVP_SOLO"
MATCH_TYPE_DUO = "PVP_DUO"
MATCH_TYPE_PVE = "PVE"