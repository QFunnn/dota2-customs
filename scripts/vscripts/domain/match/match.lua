--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class Match
---@field id integer|Uint64
---@field type MatchType
---@field currentRound Round?
---@field teams table<integer, Team>
---@field place integer
---@field validTeamNumber integer
---@field validPlayerCount integer
---@field placeTeamMap table<integer, integer>
---@field playerPlaceMap table<integer, integer>
---@field playerBookStats table<integer, table<string, integer>>
if Match == nil then
	Match = class({})
end

---@alias MatchType "PVP_SOLO" | "PVP_DUO" | "PVE"

MATCH_TYPE_SOLO = "PVP_SOLO"
MATCH_TYPE_DUO = "PVP_DUO"
MATCH_TYPE_PVE = "PVE"

---@return integer|Uint64
local function resolveId()
	if IsInToolsMode() then
		return RandomInt(1, 999999999)
	end
	return GameRulesCustom:Script_GetMatchID()
end

---@return MatchType
local function resolveType()
	local mapName = GetMapName()
	if mapName == "1x8" then
		return MATCH_TYPE_SOLO
	elseif mapName == "2x6" then
		return MATCH_TYPE_DUO
	end
	return MATCH_TYPE_PVE
end

function Match:constructor()
	self.id = resolveId()
	self.type = resolveType()
	self.playerBookStats = {}
	self:ResetRoster()
end

function Match:ResetRoster()
	self.teams = {}
	self.place = 0
	self.validTeamNumber = 0
	self.validPlayerCount = 0
	self.placeTeamMap = {}
	self.playerPlaceMap = {}
end

---@param playerId integer
---@return table<string, integer>?
function Match:GetPlayerBookStats(playerId)
	return self.playerBookStats[playerId]
end

---@param playerId integer
---@param stats table<string, integer>
function Match:SetPlayerBookStats(playerId, stats)
	self.playerBookStats[playerId] = stats
end

---@param teamId integer
---@return Team
function Match:AddTeam(teamId)
	local team = Team(teamId)
	self.teams[teamId] = team
	return team
end

---@param teamId integer
---@return Team
function Match:GetTeam(teamId)
	return self.teams[teamId]
end

---@return table<integer, Team>
function Match:GetTeams()
	return self.teams
end

---@param teamId integer
---@return boolean
function Match:IsTeamAlive(teamId)
	local team = self.teams[teamId]
	return team ~= nil and team:IsAlive()
end

---@param teamId integer
---@return Vector
function Match:GetTeamLocation(teamId)
	local team = self.teams[teamId]
	return team and team:GetLocation()
end

---@param teamId integer
---@return Vector
function Match:GetTeamStartLocation(teamId)
	local team = self.teams[teamId]
	return team and team:GetStartLocation()
end

---@param teamId integer
---@return boolean
function Match:IsTeamAbandoned(teamId)
	local team = self.teams[teamId]
	return team ~= nil and team:IsAbandoned()
end

---@return integer
function Match:GetPlace()
	return self.place
end

---@param place integer
function Match:SetPlace(place)
	self.place = place
end

---@return integer
function Match:GetValidTeamNumber()
	return self.validTeamNumber
end

---@param count integer
function Match:SetValidTeamNumber(count)
	self.validTeamNumber = count
end

---@return integer
function Match:GetValidPlayerCount()
	return self.validPlayerCount
end

---@param count integer
function Match:SetValidPlayerCount(count)
	self.validPlayerCount = count
end

---@param place integer
---@param teamId integer
function Match:AssignTeamPlace(place, teamId)
	self.placeTeamMap[place] = teamId
end

---@return table<integer, integer>
function Match:GetTeamPlaces()
	return self.placeTeamMap
end

---@param playerId integer
---@param place integer
function Match:AssignPlayerPlace(playerId, place)
	self.playerPlaceMap[playerId] = place
end

---@return table<integer, integer>
function Match:GetPlayerPlaces()
	return self.playerPlaceMap
end

---@param roundNumber integer
---@return Round
function Match:StartRound(roundNumber)
	self.currentRound = Round(self, roundNumber)
	self.currentRound:Prepare()
	return self.currentRound
end

---@return Round?
function Match:GetCurrentRound()
	return self.currentRound
end

---@return integer|Uint64
function Match:GetId()
	return self.id
end

---@return MatchType
function Match:GetType()
	return self.type
end

---@return boolean
function Match:IsSolo()
	return self:GetType() == MATCH_TYPE_SOLO
end

---@return boolean
function Match:IsDuo()
	return self:GetType() == MATCH_TYPE_DUO
end

---@return boolean
function Match:IsPve()
	return self:GetType() == MATCH_TYPE_PVE
end