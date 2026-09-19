--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


function GameMode:FinishRound()
	local match = self:GetMatch()
	local currentRound = match:GetCurrentRound()
	local currentRoundNumber = currentRound.roundNumber
	currentRound:End()
	logger:Log(
		string.format(
			"FinishRound: roundNumber=%d validTeamNumber=%d place=%d",
			currentRoundNumber,
			match:GetValidTeamNumber() or -1,
			match:GetPlace() or -1
		)
	)

	if currentRoundNumber >= 500 and match:GetValidTeamNumber() == 1 and match:GetPlace() == 1 then
		logger:Log(string.format("FinishRound: branch=ForceEndLastSurvivor roundNumber=%d", currentRoundNumber))
		for teamId, team in pairs(match:GetTeams()) do
			if team:IsAlive() then
				MatchLifecycleService:TeamLose(teamId)
			end
		end
	else
		currentRoundNumber = currentRoundNumber + 1
		logger:Log(string.format("FinishRound: branch=NextRound nextRoundNumber=%d", currentRoundNumber))
		match:StartRound(currentRoundNumber)
	end
end