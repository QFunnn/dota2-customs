--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class PvpMatchmaker
---@field pairs PvpPair[]
---@field lastPair { nFirstTeamId: integer, nSecondeTeamId: integer }?
---@field secondLastPair { nFirstTeamId: integer, nSecondeTeamId: integer }?
---@field lastPvpRound integer
---@field interval integer
PvpMatchmaker = PvpMatchmaker or {}

function PvpMatchmaker:Reset()
	self.pairs = {}
	self.lastPair = nil
	self.secondLastPair = nil
	self.lastPvpRound = IsInToolsMode() and 0 or 1
	self.interval = 1
end

---Пора ли устраивать PvP-раунд (интервал с прошлой дуэли исчерпан).
---@param roundNumber integer
---@return boolean
function PvpMatchmaker:IsPvpRound(roundNumber)
	return roundNumber - self.lastPvpRound >= self.interval
end

---@param roundNumber integer
function PvpMatchmaker:MarkRound(roundNumber)
	self.lastPvpRound = roundNumber
end

---@return integer
function PvpMatchmaker:GetLastRound()
	return self.lastPvpRound
end

function PvpMatchmaker:RefreshInterval()
	self.interval = self:ComputeInterval()
end

---Интервал дуэлей между раундами по числу живых команд с игроками.
---@return integer
function PvpMatchmaker:ComputeInterval()
	local pvpValidTeamMap = {} ---@type table<integer, boolean>
	local validTeamNumber = 0

	for teamNumber, team in pairs(GameMode:GetMatch():GetTeams()) do
		if not team:IsAlive() then
			goto continue
		end

		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if
				PlayerResource:IsValidPlayer(playerId)
				and (IsInToolsMode() or PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED)
				and IsValid(PlayerResource:GetSelectedHeroEntity(playerId))
			then
				if PlayerResource:GetTeam(playerId) == teamNumber then
					if pvpValidTeamMap[teamNumber] == nil then
						validTeamNumber = validTeamNumber + 1
						pvpValidTeamMap[teamNumber] = true
					end
				end
			end
		end

		::continue::
	end

	if validTeamNumber == 3 or validTeamNumber == 4 or validTeamNumber == 5 then
		return 2
	end

	if validTeamNumber == 2 or validTeamNumber == 1 then
		return 3
	end
	return 0
end

---@return boolean
function PvpMatchmaker:HasPairs()
	return #self.pairs > 0
end

---Пересобрать очередь пар из живых команд (все пары каждый-с-каждым).
function PvpMatchmaker:BuildPairs()
	self.pairs = {}
	local pvpValidTeamMap = {}
	local validTeamCount = 0
	local pvpValidTeamList = {}

	for teamNumber, team in pairs(GameMode:GetMatch():GetTeams()) do
		if not team:IsAlive() then
			goto continue
		end
		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if
				PlayerResource:IsValidPlayer(playerId)
				and (IsInToolsMode() or PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED)
				and IsValid(PlayerResource:GetSelectedHeroEntity(playerId))
			then
				if PlayerResource:GetTeam(playerId) == teamNumber then
					if pvpValidTeamMap[teamNumber] == nil then
						validTeamCount = validTeamCount + 1
						pvpValidTeamMap[teamNumber] = true
						table.insert(pvpValidTeamList, teamNumber)
					end
				end
			end
		end

		::continue::
	end

	if validTeamCount == 1 then
		logger:Log("[PvpMatchmaker:BuildPairs] Only One PVP team, return...")
		return
	end

	for _, nTeamNumber in ipairs(pvpValidTeamList) do
		for _, nEnemyTeamNumber in ipairs(pvpValidTeamList) do
			if nEnemyTeamNumber < nTeamNumber then
				local pair = {
					nFirstTeamId = nTeamNumber,
					nSecondeTeamId = nEnemyTeamNumber,
					nTeamJoinTimes = 0,
				} ---@type PvpPair
				table.insert(self.pairs, pair)
			end
		end
	end
end

---Выбрать и извлечь пару из очереди (избегая недавних составов).
---@return PvpPair
function PvpMatchmaker:TakePair()
	self.pairs = table.shuffle(self.pairs)

	for _, pair in ipairs(self.pairs) do
		pair.nScore = pair.nTeamJoinTimes

		if self.lastPair then
			if pair.nFirstTeamId == self.lastPair.nFirstTeamId or pair.nFirstTeamId == self.lastPair.nSecondeTeamId then
				pair.nScore = pair.nScore + 1
			end
			if
				pair.nSecondeTeamId == self.lastPair.nFirstTeamId
				or pair.nSecondeTeamId == self.lastPair.nSecondeTeamId
			then
				pair.nScore = pair.nScore + 1
			end
		end

		if self.secondLastPair then
			if
				pair.nFirstTeamId == self.secondLastPair.nFirstTeamId
				or pair.nFirstTeamId == self.secondLastPair.nSecondeTeamId
			then
				pair.nScore = pair.nScore + 0.1
			end
			if
				pair.nSecondeTeamId == self.secondLastPair.nFirstTeamId
				or pair.nSecondeTeamId == self.secondLastPair.nSecondeTeamId
			then
				pair.nScore = pair.nScore + 0.1
			end
		end
	end

	table.sort(self.pairs, function(a, b)
		return a.nScore < b.nScore
	end)

	local result = self.pairs[1]
	table.remove(self.pairs, 1)

	for i = 1, #self.pairs do
		if self.pairs[i] then
			if
				self.pairs[i].nFirstTeamId == result.nFirstTeamId
				or self.pairs[i].nSecondeTeamId == result.nFirstTeamId
			then
				self.pairs[i].nTeamJoinTimes = self.pairs[i].nTeamJoinTimes + 1
			end
			if
				self.pairs[i].nFirstTeamId == result.nSecondeTeamId
				or self.pairs[i].nSecondeTeamId == result.nSecondeTeamId
			then
				self.pairs[i].nTeamJoinTimes = self.pairs[i].nTeamJoinTimes + 1
			end
		end
	end

	return result
end

---Запомнить только что выбранную пару (для избегания повторов).
---@param pair PvpPair
function PvpMatchmaker:RememberPair(pair)
	if self.lastPair then
		self.secondLastPair = self.lastPair
	end
	self.lastPair = {
		nFirstTeamId = pair.nFirstTeamId,
		nSecondeTeamId = pair.nSecondeTeamId,
	}
end

---Убирает из очереди все пары, затрагивающие команду.
---@param teamNumber integer
function PvpMatchmaker:RemovePairsForTeam(teamNumber)
	local i, max = 1, #self.pairs
	while i <= max do
		local pair = self.pairs[i]
		if teamNumber == pair.nFirstTeamId or teamNumber == pair.nSecondeTeamId then
			table.remove(self.pairs, i)
			i = i - 1
			max = max - 1
		end
		i = i + 1
	end
end