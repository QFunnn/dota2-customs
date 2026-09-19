--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if Roulette == nil then
	Roulette = class({}) ---@class Roulette
end

Roulette.RoundDuration = 30
Roulette.SpinDuration = 18.0
Roulette.ResultDuration = 3.0

if IsInToolsMode() then
	Roulette.RoundDuration = 30
end

-- Weights are applied per visible sector; keep every multiplier below 100% expected return.
Roulette.SectorWeights = {
	[2] = 1.0,
	[3] = 1.3,
	[5] = 1.72,
	[10] = 4.3,
}
Roulette.Sectors = {
	2,
	3,
	2,
	5,
	2,
	3,
	2,
	2,
	3,
	2,
	5,
	2,
	3,
	2,
	2,
	3,
	2,
	5,
	2,
	3,
	2,
	2,
	3,
	2,
	5,
	2,
	3,
	2,
	2,
	3,
	2,
	5,
	2,
	3,
	2,
	2,
	3,
	2,
	2,
	10,
}

Roulette.AllowedMultipliers = {
	[2] = true,
	[3] = true,
	[5] = true,
	[10] = true,
}

function Roulette:GetTime()
	return Time()
end

function Roulette:Init()
	if self.bStarted then
		return
	end

	self.bStarted = true
	self.enabled = true
	self.timerGeneration = 0
	self.roundId = 0
	self.phase = "betting"
	self.bets = {}
	self.betOrder = {}
	self.history = {}
	self.nextSpinTime = 0

	GameListener:SubscribeProtected("roulette_make_bet", function(event)
		self:OnMakeBet(event)
	end)

	self:StartBettingRound()
end

function Roulette:StartBettingRound()
	self.timerGeneration = (self.timerGeneration or 0) + 1
	local timerGeneration = self.timerGeneration
	self.roundId = (self.roundId or 0) + 1
	self.phase = "betting"
	self.bets = {}
	self.betOrder = {}
	self.nextSpinTime = self:GetTime() + self.RoundDuration
	if self:IsBackendAvailable() then
		self:SyncState()
	else
		self:SyncState(0)
	end

	Timers:CreateTimer({
		useGameTime = false,
		callback = function()
			if self.timerGeneration ~= timerGeneration or self.phase ~= "betting" then
				return nil
			end

			if not self:IsBackendAvailable() then
				self.nextSpinTime = self:GetTime() + self.RoundDuration
				self:SyncState(0)
				return 1
			end

			local timeLeft = math.max(0, math.ceil(self.nextSpinTime - self:GetTime()))
			self:SyncState(timeLeft)

			if timeLeft <= 0 then
				self:Spin()
				return nil
			end

			return 1
		end,
	})
end

function Roulette:IsBackendAvailable()
	if not Shop or not Shop.IsShopAvailable then
		return false
	end

	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(playerId) and Shop:IsShopAvailable(playerId) then
			return true
		end
	end

	return false
end

function Roulette:RefundOpenBets()
	if not Shop or not Shop.AddCoins then
		return
	end

	for _, playerId in ipairs(self.betOrder or {}) do
		local data = (self.bets or {})[playerId]
		if data and tonumber(data.amount) and data.amount > 0 then
			Shop:AddCoins(playerId, data.amount)
			if Shop.ScheduleInventorySave then
				Shop:ScheduleInventorySave(playerId)
			end
		end
	end
end

---@param timeLeft integer|nil
function Roulette:SyncState(timeLeft)
	local participants = {}

	for _, playerId in ipairs(self.betOrder or {}) do
		local data = (self.bets or {})[playerId]
		if not data then
			goto continue
		end

		table.insert(participants, {
			player_id = data.playerId,
			player_name = data.playerName,
			hero_name = data.heroName,
			amount = data.amount,
			multiplier = data.multiplier,
		})
		::continue::
	end

	CustomNetTables:SetTableValue("roulette", "state", {
		enabled = 1,
		round_id = self.roundId or 0,
		phase = self.phase or "disabled",
		time_remaining = timeLeft or math.max(0, math.ceil((self.nextSpinTime or 0) - self:GetTime())),
		participants = participants,
		history = self.history or {},
		sector_count = #self.Sectors,
	})
end

---@param event table
function Roulette:OnMakeBet(event)
	local playerId = tonumber(event.PlayerID)
	if playerId == nil or not PlayerResource:IsValidPlayer(playerId) then
		return
	end

	if not self.enabled or self.phase ~= "betting" then
		return
	end

	if not Shop or not Shop.IsShopAvailable or not Shop:IsShopAvailable(playerId) then
		return
	end

	if self.bets[playerId] ~= nil then
		return
	end

	local amount = math.floor(tonumber(event.amount) or 0)
	local selectedMultiplier = math.floor(tonumber(event.multiplier) or 0)

	if amount <= 0 then
		return
	end

	if not self.AllowedMultipliers[selectedMultiplier] then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(playerId)
	if not IsValidEntity(hero) then ---@cast hero CDOTA_BaseNPC_Hero
		return
	end

	local currentCoins = Shop.GetCoins and Shop:GetCoins(playerId) or 0
	if currentCoins < amount then
		return
	end

	if not Shop:SpendCoins(playerId, amount) then
		return
	end
	if Shop.ScheduleInventorySave then
		Shop:ScheduleInventorySave(playerId)
	end

	self.bets[playerId] = {
		playerId = playerId,
		playerName = PlayerResource:GetPlayerName(playerId),
		heroName = PlayerResource:GetSelectedHeroName(playerId),
		amount = amount,
		multiplier = selectedMultiplier,
	}
	table.insert(self.betOrder, playerId)

	hero:EmitSound("DOTA_Item.Hand_Of_Midas")
	self:SyncState()
end

function Roulette:Spin()
	if not self:IsBackendAvailable() then
		self:RefundOpenBets()
		self:StartBettingRound()
		return
	end

	self.phase = "spinning"

	local timerGeneration = self.timerGeneration
	local roundId = self.roundId
	local spinBets = self.bets or {}
	local spinBetOrder = self.betOrder or {}
	local sector = self:RollSector()
	local resultMultiplier = self.Sectors[sector + 1]

	self:SyncState(0)
	CustomGameEventManager:Send_ServerToAllClients("roulette_spin_started", {
		round_id = roundId,
		sector = sector,
		multiplier = resultMultiplier,
		sector_count = #self.Sectors,
		spin_duration = self.SpinDuration,
	})

	Timers:CreateTimer({
		useGameTime = false,
		endTime = self.SpinDuration + 0.15,
		callback = function()
			if self.timerGeneration ~= timerGeneration then
				return nil
			end

			self:ResolveSpin(roundId, sector, resultMultiplier, spinBets, spinBetOrder, timerGeneration)
			return nil
		end,
	})
end

function Roulette:RollSector()
	local totalWeight = 0

	for _, multiplier in ipairs(self.Sectors) do
		totalWeight = totalWeight + (self.SectorWeights[multiplier] or 1)
	end

	local roll = RandomFloat(0, totalWeight)
	local cursor = 0

	for sector, multiplier in ipairs(self.Sectors) do
		cursor = cursor + (self.SectorWeights[multiplier] or 1)
		if roll <= cursor then
			return sector - 1
		end
	end

	return RandomInt(0, #self.Sectors - 1)
end

---@param roundId integer
---@param sector integer
---@param resultMultiplier integer
---@param spinBets table
---@param spinBetOrder table
---@param timerGeneration integer
function Roulette:ResolveSpin(roundId, sector, resultMultiplier, spinBets, spinBetOrder, timerGeneration)
	if self.timerGeneration ~= timerGeneration then
		return
	end

	local results = {}
	self.phase = "result"

	table.insert(self.history, 1, {
		round_id = roundId,
		sector = sector,
		multiplier = resultMultiplier,
	})
	while #self.history > 24 do
		table.remove(self.history)
	end

	for _, playerId in ipairs(spinBetOrder or {}) do
		local data = (spinBets or {})[playerId]
		if not data then
			goto continue
		end

		local hero = PlayerResource:GetSelectedHeroEntity(playerId)
		if not hero then
			goto continue
		end

		local payout = 0
		local isWin = data.multiplier == resultMultiplier

		if isWin and IsValidEntity(hero) then
			payout = data.amount * data.multiplier
			if Shop and Shop.AddCoins then
				Shop:AddCoins(playerId, payout)
				if Shop.ScheduleInventorySave then
					Shop:ScheduleInventorySave(playerId)
				end
			end
			hero:EmitSound("DOTA_Item.Hand_Of_Midas")
		elseif IsValidEntity(hero) then
			hero:EmitSound("General.Cancel")
		end

		table.insert(results, {
			player_id = playerId,
			player_name = data.playerName,
			hero_name = data.heroName,
			amount = data.amount,
			selected_multiplier = data.multiplier,
			payout = payout,
			win = isWin and 1 or 0,
		})
		::continue::
	end

	self:SyncState()
	CustomGameEventManager:Send_ServerToAllClients("roulette_spin_finished", {
		round_id = roundId,
		sector = sector,
		multiplier = resultMultiplier,
		results = results,
	})

	Timers:CreateTimer({
		useGameTime = false,
		endTime = self.ResultDuration,
		callback = function()
			if self.timerGeneration == timerGeneration and self.roundId == roundId and self.phase == "result" then
				self:StartBettingRound()
			end
			return nil
		end,
	})
end