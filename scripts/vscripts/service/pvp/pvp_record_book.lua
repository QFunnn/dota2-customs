--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class PvpRecordBook
---@field records table<integer, { bet_history: Bet[], total_bet_reward: integer, win: integer, lose: integer }>
---@field betHistory table<integer, Bet[]>
PvpRecordBook = PvpRecordBook or {}

local BET_HISTORY_LIMIT = 90

function PvpRecordBook:Reset()
	self.records = {}
	self.betHistory = {}
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		self.records[playerId] = {
			bet_history = {},
			total_bet_reward = 0,
			win = 0,
			lose = 0,
		}
	end
end

---@param playerId integer
---@return { bet_history: Bet[], total_bet_reward: integer, win: integer, lose: integer }
function PvpRecordBook:Get(playerId)
	return self.records[playerId]
end

---@param teamId integer
function PvpRecordBook:RecordWinner(teamId)
	for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
		self.records[playerId].win = self.records[playerId].win + 1
	end
end

---@param teamId integer
function PvpRecordBook:RecordLoser(teamId)
	for i = 1, PlayerResource:GetPlayerCountForTeam(teamId) do
		local playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, i)
		self.records[playerId].lose = self.records[playerId].lose + 1
	end
end

---@param playerId integer
---@param value integer
function PvpRecordBook:AddBetReward(playerId, value)
	self.records[playerId].total_bet_reward = self.records[playerId].total_bet_reward + value
end

---@param playerId integer
---@param value integer
---@param winnerId integer
---@param loserId integer
---@param bet integer
---@param multiplier number
---@param pool integer сумма всех ставок в раунде (обе команды)
function PvpRecordBook:RecordBetHistory(playerId, value, winnerId, loserId, bet, multiplier, pool)
	if self.betHistory[playerId] == nil then
		self.betHistory[playerId] = {}
	end

	local winners = {} ---@type integer[]
	local losers = {} ---@type integer[]

	for winnerPlayerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(winnerPlayerId) == winnerId then
			table.insert(winners, winnerPlayerId)
		end
	end

	for loserPlayerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(loserPlayerId) == loserId then
			table.insert(losers, loserPlayerId)
		end
	end

	local data = {
		winners = winners,
		losers = losers,
		value = value,
		bet = bet,
		multiplier = multiplier,
		pool = pool,
	}

	local recordHistory = self.records[playerId].bet_history
	while #recordHistory >= BET_HISTORY_LIMIT do
		table.remove(recordHistory, 1)
	end
	while #self.betHistory[playerId] >= BET_HISTORY_LIMIT do
		table.remove(self.betHistory[playerId], 1)
	end

	table.insert(recordHistory, data)
	table.insert(self.betHistory[playerId], data)
end