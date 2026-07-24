--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if AbilityQuota == nil then AbilityQuota = class({}) end ---@class AbilityQuota

local ABILITY_SELECTION_ROUNDS = {
    { RoundNumber = 1, Limit = 2 },
    { RoundNumber = 3, Limit = 3 },
    { RoundNumber = 6, Limit = 4 },
    { RoundNumber = 9, Limit = 5 },
}

---@param roundNumber integer
---@return integer limit
---@return boolean isSelectionRound
local function computeBasicForRound(roundNumber)
    local limit = 2
    local isSelectionRound = false
    for i = #ABILITY_SELECTION_ROUNDS, 1, -1 do
        local node = ABILITY_SELECTION_ROUNDS[i]
        if roundNumber >= node.RoundNumber then
            limit = node.Limit
            if roundNumber == node.RoundNumber then
                isSelectionRound = true
            end
            break
        end
    end
    return limit, isSelectionRound
end

function AbilityQuota:Init()
    self.basic = {} ---@type table<PlayerID, integer>
    self.bonus = {} ---@type table<PlayerID, integer>
    self.total = {} ---@type table<PlayerID, integer>

    for i = 0, CHC_MAX_PLAYER_COUNT - 1 do
        self.basic[i] = 0
        self.bonus[i] = 0
        self.total[i] = 0
    end
end

---@param playerId PlayerID
---@param n integer
function AbilityQuota:SetBasic(playerId, n)
    self.basic[playerId] = n
    self.total[playerId] = self.basic[playerId] + (self.bonus[playerId] or 0)
end

---@param roundNumber integer
---@return boolean isSelectionRound
function AbilityQuota:ApplyRoundBasic(roundNumber)
    local limit, isSelectionRound = computeBasicForRound(roundNumber)
    for playerId = 0, CHC_MAX_PLAYER_COUNT - 1 do
        self:SetBasic(playerId, limit)
    end
    return isSelectionRound
end

---@param playerId PlayerID
---@param n integer
function AbilityQuota:AddBonus(playerId, n)
    self.bonus[playerId] = (self.bonus[playerId] or 0) + n
    self.total[playerId] = (self.basic[playerId] or 0) + self.bonus[playerId]
end

---@param playerId PlayerID
---@param delta integer
function AbilityQuota:AddTotal(playerId, delta)
    self.total[playerId] = (self.total[playerId] or 0) + delta
end

---@param playerId PlayerID
---@return integer
function AbilityQuota:GetTotal(playerId)
    return self.total[playerId] or 0
end