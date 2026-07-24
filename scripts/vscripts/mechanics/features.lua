--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class FeaturesController
Features = {}

---@class FeatureKey
Features.Keys = {
    EscapeControllerDisabled = "EscapeControllerDisabled",
    HeroRefreshingDisabled = "HeroRefreshingDisabled",
}

local _state = {
    [Features.Keys.EscapeControllerDisabled] = false,
    [Features.Keys.HeroRefreshingDisabled] = false,
}

local NET_TABLE = "features"

local function ToBool(v)
    return v == true or v == 1 or v == "1"
end

local function SaveFeatureToNetTable(featureName)
    CustomNetTables:SetTableValue(NET_TABLE, featureName, {
        state = _state[featureName] == true
    })
end

local function SaveAllToNetTable()
    for featureName, _ in pairs(_state) do
        SaveFeatureToNetTable(featureName)
    end
end

local function LoadFromNetTable()
    for featureName, _ in pairs(_state) do
        local data = CustomNetTables:GetTableValue(NET_TABLE, featureName)

        if data and data.state ~= nil then
            _state[featureName] = ToBool(data.state)
        end
    end
end

LoadFromNetTable()
SaveAllToNetTable()

---@param featureName string
---@return boolean
function Features:GetFeatureState(featureName)
    if _state[featureName] == nil then
        error("Unknown feature: " .. tostring(featureName))
    end

    return _state[featureName] == true
end

---@param featureName string
---@param value boolean
function Features:SetFeatureState(featureName, value)
    if _state[featureName] == nil then
        error("Unknown feature: " .. tostring(featureName))
    end

    _state[featureName] = value == true

    SaveFeatureToNetTable(featureName)

    GameRulesCustom:SendCustomMessage(
        string.format("Feature state '%s' was set to '%s'", featureName, tostring(value)),
        0,
        0
    )
end