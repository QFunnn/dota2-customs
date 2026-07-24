--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---Получить пару для подготовки в PVP
---@return PvpPair
function PvpModule:GetOnePair()
    self.PvpPairs = table.shuffle(self.PvpPairs)

    for _, pair in ipairs(self.PvpPairs) do
        pair.nScore = pair.nTeamJoinTimes

        if self.lastPair then
            if pair.nFirstTeamId == self.lastPair.nFirstTeamId or pair.nFirstTeamId == self.lastPair.nSecondeTeamId then
                pair.nScore = pair.nScore + 1
            end
            if pair.nSecondeTeamId == self.lastPair.nFirstTeamId or pair.nSecondeTeamId == self.lastPair.nSecondeTeamId then
                pair.nScore = pair.nScore + 1
            end
        end

        if self.secondLastPair then
            if pair.nFirstTeamId == self.secondLastPair.nFirstTeamId or pair.nFirstTeamId == self.secondLastPair.nSecondeTeamId then
                pair.nScore = pair.nScore + 0.1
            end
            if pair.nSecondeTeamId == self.secondLastPair.nFirstTeamId or pair.nSecondeTeamId == self.secondLastPair.nSecondeTeamId then
                pair.nScore = pair.nScore + 0.1
            end
        end
    end

    table.sort(self.PvpPairs, function(a, b) return a.nScore < b.nScore end)

    local result = self.PvpPairs[1]
    table.remove(self.PvpPairs, 1)

    for i = 1, #self.PvpPairs do
        if self.PvpPairs[i] then
            if self.PvpPairs[i].nFirstTeamId == result.nFirstTeamId or self.PvpPairs[i].nSecondeTeamId == result.nFirstTeamId then
                self.PvpPairs[i].nTeamJoinTimes = self.PvpPairs[i].nTeamJoinTimes + 1
            end
            if self.PvpPairs[i].nFirstTeamId == result.nSecondeTeamId or self.PvpPairs[i].nSecondeTeamId == result.nSecondeTeamId then
                self.PvpPairs[i].nTeamJoinTimes = self.PvpPairs[i].nTeamJoinTimes + 1
            end
        end
    end

    return result
end