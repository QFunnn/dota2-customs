--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


--- @return integer playersPerTeam
--- @return integer teamCount
function GameMode:GetAllTeamInfo()
	local playersPerTeam = 8
	local teamCount = 1
	local mapName = GetMapName()

	if string.find(mapName, "1x8") then
		playersPerTeam = 8
		teamCount = 1
	elseif mapName == "2x6" then
		playersPerTeam = 6
		teamCount = 2
	end

	return playersPerTeam, teamCount
end

---@return Match
function GameMode:GetMatch()
	if self.match == nil then
		self.match = Match()
	end
	return self.match
end

---@return integer|Uint64
function GameMode:GetMatchID()
	return self:GetMatch():GetId()
end