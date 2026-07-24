--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if ExtraCreature == nil then
    ExtraCreature = class({}) ---@class ExtraCreature
end

function ExtraCreature:Init()
    self.teamCreatureMap = {} ---@type table<DOTATeam_t, table<integer, string>>
end

---@enum ExtraCreatureOption
ExtraCreatureOption = {
    NONE = 1, -- Отобразить только в событиях
    MIN = 2,  -- Отобразить минимально
    MAX = 3,  -- Отобразить почти во весь экран
}

---@param innitialPlayerId integer
---@param creatureName string
function ExtraCreature:AddExtraCreature(innitialPlayerId, creatureName)
    local teamNumber = PlayerResource:GetTeam(innitialPlayerId)
    if not teamNumber then return end

    if not self.teamCreatureMap[teamNumber] then
        self.teamCreatureMap[teamNumber] = {}
    end

    table.insert(self.teamCreatureMap[teamNumber], creatureName)

    self:SendExtraCreatureToAllPlayers(innitialPlayerId, creatureName)
end

---@param playerId integer
---@param creatureName string
function ExtraCreature:RemoveExtraCreature(playerId, creatureName)
    local teamNumber = PlayerResource:GetTeam(playerId)
    if not teamNumber then return end

    if not self.teamCreatureMap or not self.teamCreatureMap[teamNumber] then
        return
    end

    for i = #self.teamCreatureMap[teamNumber], 1, -1 do
        if self.teamCreatureMap[teamNumber][i] == creatureName then
            table.remove(self.teamCreatureMap[teamNumber], i)
            break
        end
    end
end

---@param initiatorPlayerId integer
---@param creatureName string
function ExtraCreature:SendExtraCreatureToAllPlayers(initiatorPlayerId, creatureName)
    for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if not PlayerResource:IsValidPlayer(playerId) then
            goto continue
        end

        local player = PlayerResource:GetPlayer(playerId)
        if not player then
            goto continue
        end

        logger:Logf("SendExtraCreatureEvent. Option = %d", Settings:Get(playerId, SettingsKey.EXTRA_CREATURE_OPTION))
        CustomGameEventManager:Send_ServerToPlayer(player, "ExtraCreatureAddedNew", {
            creatureName = creatureName,
            caller = initiatorPlayerId,
            option = Settings:Get(playerId, SettingsKey.EXTRA_CREATURE_OPTION)
        })

        CustomGameEventManager:Send_ServerToPlayer(player, "ExtraCreatureAdded", {
            string_creatureName = creatureName,
            message = "ReleaseCreature",
            player_id = initiatorPlayerId
        })

        ::continue::
    end
end