--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function GameMode:FinishRound()
    local currentRoundNumber = self.currentRound.roundNumber
    self.currentRound:End()
    logger:Log(string.format("FinishRound: roundNumber=%d validTeamNumber=%d place=%d", currentRoundNumber, self.validTeamNumber or -1, self.place or -1))

    if currentRoundNumber >= 500 and self.validTeamNumber == 1 and self.place == 1 then
        logger:Log(string.format("FinishRound: branch=ForceEndLastSurvivor roundNumber=%d", currentRoundNumber))
        for teamId, isAlive in pairs(self.aliveTeamMap) do
            if isAlive then
                self:TeamLose(teamId)
            end
        end
    else
        currentRoundNumber = currentRoundNumber + 1
        logger:Log(string.format("FinishRound: branch=NextRound nextRoundNumber=%d", currentRoundNumber))
        self.currentRound = Round(currentRoundNumber)
    end
end