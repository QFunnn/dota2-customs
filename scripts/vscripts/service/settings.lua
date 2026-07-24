--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Settings == nil then Settings = class({}) end ---@class Settings

---@class PlayerSettingsTable
---@field barrageOpacity number
---@field autoViewPvp boolean
---@field autoViewPve boolean
---@field extraCreatureOption ExtraCreatureOption
---@field disableChatWheelMessages boolean
---@field abilitySelectPosition string
---@field abilityReplaceSelectMode string
---@field hidePvpOnRoundStart boolean

local SAVE_DEBOUNCE_SEC = 10

SettingsKey = SettingsKey or {
    BARRAGE_OPACITY             = "barrageOpacity",
    AUTO_VIEW_PVP               = "autoViewPvp",
    AUTO_VIEW_PVE               = "autoViewPve",
    EXTRA_CREATURE_OPTION       = "extraCreatureOption",
    DISABLE_CHAT_WHEEL_MESSAGES = "disableChatWheelMessages",
    ABILITY_SELECT_POSITION     = "abilitySelectPosition",
    ABILITY_REPLACE_SELECT_MODE = "abilityReplaceSelectMode",
    HIDE_PVP_ON_ROUND_START     = "hidePvpOnRoundStart",
}

---@alias PlayerSettingKey
---| "barrageOpacity"
---| "autoViewPvp"
---| "autoViewPve"
---| "extraCreatureOption"
---| "disableChatWheelMessages"
---| "abilitySelectPosition"
---| "abilityReplaceSelectMode"
---| "hidePvpOnRoundStart"

---@type PlayerSettingsTable
local DEFAULTS = {
    barrageOpacity = 100,
    autoViewPvp = false,
    autoViewPve = false,
    extraCreatureOption = ExtraCreatureOption.NONE,
    disableChatWheelMessages = false,
    abilitySelectPosition = "bottom",
    abilityReplaceSelectMode = "hero_panel",
    hidePvpOnRoundStart = false,
}

local BOOLEAN_KEYS = {
    autoViewPvp = true,
    autoViewPve = true,
    disableChatWheelMessages = true,
    hidePvpOnRoundStart = true,
}

local state = {}   ---@type table<PlayerID, PlayerSettingsTable>
local pending = {} ---@type table<string, PlayerSettingsTable>
local timers = {} ---@type table<string, string>

---@param current PlayerSettingsTable|nil
---@param values table|nil
---@return PlayerSettingsTable
local function merge(current, values)
    local result = {}
    for key, default in pairs(DEFAULTS) do
        local value = values and values[key]
        if value == nil then value = current and current[key] end
        if value == nil then value = default end
        if BOOLEAN_KEYS[key] then value = toboolean(value) end
        result[key] = value
    end
    return result
end

---@param playerId PlayerID
---@param settings PlayerSettingsTable
local function writeNetTable(playerId, settings)
    local uid = GetSteamID(playerId)
    logger:Log(string.format("Update NetTables settings for user %s started.", uid))
    CustomNetTables:SetTableValue("player_settings", uid, {
        barrageOpacity = settings.barrageOpacity,
        autoViewPvp = settings.autoViewPvp and 1 or 0,
        autoViewPve = settings.autoViewPve and 1 or 0,
        extraCreatureOption = settings.extraCreatureOption,
        disableChatWheelMessages = settings.disableChatWheelMessages and 1 or 0,
        abilitySelectPosition = settings.abilitySelectPosition,
        abilityReplaceSelectMode = settings.abilityReplaceSelectMode,
        hidePvpOnRoundStart = settings.hidePvpOnRoundStart and 1 or 0,
    })
    logger:Log(string.format("Update NetTables settings for user %s finished.", uid))
end

---@param uid string
local function flush(uid)
    local payload = pending[uid]
    if not payload then return end
    pending[uid] = nil
    timers[uid] = nil
    PlayerOutboundApi:ChangeSettings(uid, payload)
end

---@param playerId PlayerID
---@param settings PlayerSettingsTable
local function schedulePersist(playerId, settings)
    local uid = GetSteamID(playerId)
    pending[uid] = {
        barrageOpacity = math.floor(settings.barrageOpacity),
        autoViewPvp = settings.autoViewPvp,
        autoViewPve = settings.autoViewPve,
        extraCreatureOption = settings.extraCreatureOption,
        disableChatWheelMessages = settings.disableChatWheelMessages,
        abilitySelectPosition = settings.abilitySelectPosition,
        abilityReplaceSelectMode = settings.abilityReplaceSelectMode,
        hidePvpOnRoundStart = settings.hidePvpOnRoundStart,
    }
    if timers[uid] then
        Timers:RemoveTimer(timers[uid])
    end
    timers[uid] = Timers:CreateTimer(SAVE_DEBOUNCE_SEC, function()
        flush(uid)
        return nil
    end)
end

---@param playerId PlayerID
---@param values table|nil
---@param skipPersist boolean|nil
---@return PlayerSettingsTable
function Settings:Apply(playerId, values, skipPersist)
    local merged = merge(state[playerId], values)
    state[playerId] = merged
    writeNetTable(playerId, merged)
    if not skipPersist then
        schedulePersist(playerId, merged)
    end
    return merged
end


---@param playerId PlayerID
---@param key PlayerSettingKey|nil
---@return any
function Settings:Get(playerId, key)
    local setting = state[playerId]
    if not setting then
        setting = merge(nil, nil)
        state[playerId] = setting
    end
    if key ~= nil then return setting[key] end
    return setting
end