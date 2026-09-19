--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class BetService
---@field betMap table<integer, table<any, any>>
---@field totalBetSum table<integer, integer>
---@field baseBonus integer
---@field isClosed boolean
BetService = BetService or {}

function BetService:Reset()
	self.betMap = {}
	self.totalBetSum = {}
	self.baseBonus = 150
	self.isClosed = true
	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		self.totalBetSum[playerId] = 0
	end
end

---Сбросить очереди ставок (перед новой дуэлью).
function BetService:ClearBets()
	self.betMap = {}
end

---Открыть приём ставок для пары команд.
---@param teamId1 integer
---@param teamId2 integer
function BetService:OpenForTeams(teamId1, teamId2)
	self.betMap[teamId1] = {}
	self.betMap[teamId2] = {}
	self.isClosed = false
end

---@param value number
function BetService:SetBaseBonus(value)
	self.baseBonus = value
end

---@return table<integer, table<any, any>>
function BetService:GetBetMap()
	return self.betMap
end

---@return integer
function BetService:GetBaseBonus()
	return self.baseBonus
end

---@param playerId integer
---@return integer
function BetService:GetTotalBetSum(playerId)
	return self.totalBetSum[playerId]
end

---Обработчик события ставки с UI
---@param event any
function BetService:ConfirmBet(event)
	if not event.PlayerID then
		return
	end

	local nPlayerId = event.PlayerID
	local maxBetGold = math.floor(PlayerResource:GetGold(nPlayerId) / 2)

	if type(event.value) ~= "number" then
		logger:Log("Bet value is not number")
		return
	end

	if self.isClosed then
		logger:Log("Bet already end")
		return
	end

	if not GameMode:GetMatch():IsTeamAlive(PlayerResource:GetTeam(nPlayerId)) then
		logger:Log("Team Already Lose")
		return
	end

	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerId)
	if hHero == nil or hHero:IsNull() then
		return
	end
	if not hHero:IsAlive() and not hHero:IsReincarnating() then
		logger:Log("Dead player can't bet")
		return
	end

	local isAlreadyBet = false

	for _, dataList in pairs(self.betMap) do
		for _, data in ipairs(dataList) do
			if data.nPlayerId == nPlayerId then
				isAlreadyBet = true
			end
		end
	end

	if isAlreadyBet then
		logger:Log("Already Bet")
		return
	end

	local betValue = math.floor(event.value)

	if betValue <= 0 then
		return
	end
	if betValue > maxBetGold then
		betValue = maxBetGold
	end

	if self.betMap[event.wish_team_id] == nil then
		logger:Log("Bet wish team Id:" .. event.wish_team_id .. "is null")
		return
	end

	if self.betMap[PlayerResource:GetTeam(nPlayerId)] ~= nil then
		logger:Log("Duel participant can't bet")
		return
	end

	local data = {}
	data.nPlayerId = nPlayerId
	data.nValue = betValue
	table.insert(self.betMap[event.wish_team_id], data)

	self.baseBonus = self.baseBonus + betValue

	if self.totalBetSum[nPlayerId] then
		self.totalBetSum[nPlayerId] = self.totalBetSum[nPlayerId] + betValue
	end

	hHero:SpendGold(betValue, DOTA_ModifyGold_Unspecified)
	hHero:EmitSound("DOTA_Item.Hand_Of_Midas")
	local pfx = ParticleManager:CreateParticle(
		"particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf",
		PATTACH_ABSORIGIN,
		hHero
	)
	ParticleManager:ReleaseParticleIndex(pfx)

	self:BroadcastPvpBetAcceptedForTeam(event.wish_team_id, nPlayerId)
end

---@param teamId integer
---@param betPlayerId integer
function BetService:BroadcastPvpBetAcceptedForTeam(teamId, betPlayerId)
	for playerId = 0, MAX_PLAYER_COUNT - 1 do
		if PlayerResource:IsValidPlayer(playerId) then
			local hPlayer = PlayerResource:GetPlayer(playerId)
			if hPlayer then
				-- Ищем команду, на которую поставил САМ получатель события,
				-- иначе при ставке другого игрока potential_win считается для
				-- "не моей" команды и возвращает 0, обнуляя прогноз.
				local recipientBetTeam = nil
				for tid, list in pairs(self.betMap) do
					for _, d in ipairs(list) do
						if d and d.nPlayerId == playerId then
							recipientBetTeam = tid
							break
						end
					end
					if recipientBetTeam then
						break
					end
				end

				local potentialWin = 0
				if recipientBetTeam then
					potentialWin = self:GetPotentialBetWin(playerId, recipientBetTeam)
				end

				CustomGameEventManager:Send_ServerToPlayer(hPlayer, "PvpBetAccepted", {
					betMap = self.betMap,
					potential_win = potentialWin,
					is_self = (playerId == betPlayerId) and 1 or 0,
				})
			end
		end
	end
end

---@param playerId integer
---@param teamId integer
---@return integer
function BetService:GetPotentialBetWin(playerId, teamId)
	local list = self.betMap[teamId]
	if not list then
		return 0
	end

	local totalBet = 0
	local playerBet = 0
	for _, data in ipairs(list) do
		if data and data.nValue then
			totalBet = totalBet + data.nValue
			if data.nPlayerId == playerId then
				playerBet = playerBet + data.nValue
			end
		end
	end

	if totalBet <= 0 or playerBet <= 0 then
		return 0
	end

	local flRatio = playerBet / totalBet
	local bonusGoldCount = math.floor(self.baseBonus * flRatio)
	local payout = math.ceil(bonusGoldCount * (100 + GoldService:GetPlayerBonusGoldPercentage(playerId)) * 0.01)
	local netWin = payout - playerBet
	if netWin < 0 then
		netWin = 0
	end
	return netWin
end

-- Награждаем победителя дуели
function BetService:RewardWinnerBonus(nPlayerId, nBonusGold)
	local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerId)
	if not hHero then
		return
	end

	local nTotalWave
	if nBonusGold > 7000 then
		nTotalWave = 80 -- если выиграл больше 7к, отдаём выигранное за 40 волн
	else
		nTotalWave = math.ceil(nBonusGold / 66)
	end
	local nGoldPerWave = math.ceil(nBonusGold / nTotalWave)

	local nParticle2 = ParticleManager:CreateParticle(
		"particles/econ/events/ti6/teleport_start_ti6_lvl3_rays.vpcf",
		PATTACH_CUSTOMORIGIN_FOLLOW,
		hHero
	)
	ParticleManager:SetParticleControlEnt(
		nParticle2,
		0,
		hHero,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		hHero:GetOrigin(),
		true
	)
	local nWave = 0

	Timers:CreateTimer(function()
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hHero, nGoldPerWave, nil)
		hHero:ModifyGoldFiltered(nGoldPerWave, true, DOTA_ModifyGold_Unspecified)
		nWave = nWave + 1
		if nWave == nTotalWave then
			ParticleManager:DestroyParticle(nParticle2, false)
			ParticleManager:ReleaseParticleIndex(nParticle2)
			return nil
		else
			return 0.15
		end
	end)
end

---Выдать награду победителю ставки
---@param playerId integer
---@param bonusGold integer
function BetService:RewardBetBonus(playerId, bonusGold)
	local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

	if not hHero then
		return
	end

	local nTotalWave
	if bonusGold > 7000 then
		nTotalWave = 80 -- если выиграл больше 7к, отдаём выигранное за 40 волн
	else
		nTotalWave = math.ceil(bonusGold / 66)
	end
	local nGoldPerWave = math.ceil(bonusGold / nTotalWave)

	local nWave = 0

	Timers:CreateTimer(function()
		SendOverheadEventMessage(nil, OVERHEAD_ALERT_GOLD, hHero, nGoldPerWave, nil)
		hHero:ModifyGoldFiltered(nGoldPerWave, true, DOTA_ModifyGold_Unspecified)
		if math.mod(nWave, 15) == 0 then
			local nParticle = ParticleManager:CreateParticle(
				"particles/econ/items/ogre_magi/ogre_magi_jackpot/ogre_magi_jackpot_spindle_rig.vpcf",
				PATTACH_OVERHEAD_FOLLOW,
				hHero
			)
			ParticleManager:ReleaseParticleIndex(nParticle)
		end
		nWave = nWave + 1
		if nWave == nTotalWave then
			return nil
		else
			return 0.15
		end
	end)
end

---@param playerId integer
---@param value integer
function BetService:SumBetReward(playerId, value)
	PvpRecordBook:AddBetReward(playerId, value)
end

---Подвести итог информации о ставках и отправить сообщение в Barrage
function BetService:SummarizeBetInfo()
	self.isClosed = true

	if PvpService:IsDuelEnded() then
		return
	end

	-- Бесплатные ставки участников PVP
	local pvpFreeBet = 0

	for teamId, list in pairs(self.betMap) do
		local totalBet = 0

		for _, data in ipairs(list) do
			totalBet = totalBet + data.nValue
		end

		if string.find(GetMapName(), "1x8") then
			local data = {}
			data.type = "bet_summary_solo"
			data.playerId = PlayerResource:GetNthPlayerIDOnTeam(teamId, 1)
			data.gold_value = totalBet
			Barrage:FireBullet(data, {
				PvpService:GetPair()[1],
				PvpService:GetPair()[2],
			})
		end

		if GetMapName() == "2x6" then
			local data = {}
			data.type = "bet_summary"
			data.teamId = teamId
			data.gold_value = totalBet
			Barrage:FireBullet(data, {
				PvpService:GetPair()[1],
				PvpService:GetPair()[2],
			})
		end

		for _, nPlayerID in ipairs(GameMode:GetMatch():GetTeam(teamId):GetPlayers()) do
			local data = {}
			local pvpBetRatio = 0.05

			if GetMapName() == "2x6" then
				pvpBetRatio = 0.02
			end

			if GetMapName() == "5v5" then
				pvpBetRatio = 0.08
			end

			data.nValue = math.floor(self.baseBonus * pvpBetRatio)
			data.nPlayerId = nPlayerID
			data.sType = "pvp_free"
			totalBet = totalBet + data.nValue
			pvpFreeBet = pvpFreeBet + data.nValue

			table.insert(list, data)
		end

		-- Рассчитать процентное соотношение ставок
		for _, data in ipairs(list) do
			local flRatio = data.nValue / totalBet
			data.flRatio = flRatio
		end
	end

	self.baseBonus = self.baseBonus + pvpFreeBet
end

---Автоматически поставить ставку бота
---@param playerId integer
function BetService:BotAutoBet(playerId)
	local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

	if not IsValid(hHero) then
		return
	end ---@cast hHero CDOTA_BaseNPC_Hero

	if hHero.nBotSpendGold == nil then
		hHero.nBotSpendGold = 0
	end

	local nCurrentGold = GoldService:GetBotEarnedGold(playerId) - hHero.nBotSpendGold

	local nMaxGold = math.floor(PlayerResource:GetGold(playerId) / 2)

	if self.isClosed then
		logger:Log("Bet already end")
		return
	end

	if not GameMode:GetMatch():IsTeamAlive(PlayerResource:GetTeam(playerId)) then
		logger:Log("Team Already Lose")
		return
	end

	local isAlreadyBet = false

	for _, dataList in pairs(self.betMap) do
		for _, data in ipairs(dataList) do
			if data.nPlayerId == playerId then
				isAlreadyBet = true
			end
		end
	end

	if isAlreadyBet then
		logger:Log("Already Bet")
		return
	end

	local nGoldSum = 0
	local wishTeamList = {}

	local nFinialWishTeamID

	for nPvpTeamID, _ in pairs(self.betMap) do
		local nTotalGold = 0
		for _, nPvpPlayerID in ipairs(GameMode:GetMatch():GetTeam(nPvpTeamID):GetPlayers()) do
			local playerInfo = CustomNetTables:GetTableValue("player_info", tostring(nPvpPlayerID))
			if playerInfo then
				nTotalGold = nTotalGold + playerInfo.gold
			else
				nTotalGold = nTotalGold + 600
			end
		end
		table.insert(wishTeamList, { nGold = nTotalGold, nWishTeamID = nPvpTeamID })
		nGoldSum = nGoldSum + nTotalGold
	end

	if RandomFloat(0, 1) < wishTeamList[1].nGold / nGoldSum then
		nFinialWishTeamID = wishTeamList[1].nWishTeamID
	else
		nFinialWishTeamID = wishTeamList[2].nWishTeamID
	end

	local nValue = math.floor(RandomFloat(0, 1) * nCurrentGold * 0.4)

	if nValue <= 0 then
		return
	end

	local data = {}
	data.nPlayerId = playerId
	data.nValue = nValue
	table.insert(self.betMap[nFinialWishTeamID], data)

	self.baseBonus = self.baseBonus + nValue

	if self.totalBetSum[playerId] then
		self.totalBetSum[playerId] = self.totalBetSum[playerId] + nValue
	end

	hHero.nBotSpendGold = hHero.nBotSpendGold + nValue
	hHero:EmitSound("DOTA_Item.Hand_Of_Midas")
	local pfx = ParticleManager:CreateParticle(
		"particles/econ/items/ogre_magi/ogre_magi_arcana/ogre_magi_arcana_midas_coinshower.vpcf",
		PATTACH_ABSORIGIN,
		hHero
	)
	ParticleManager:ReleaseParticleIndex(pfx)
end

---Выдать награды за сделанные ставки
---@param winnerTeamId integer
---@param loserTeamId integer
---@param pool integer сумма всех ставок в раунде (обе команды)
function BetService:GrantBetBonus(winnerTeamId, loserTeamId, pool)
	for _, data in ipairs(self.betMap[winnerTeamId] or {}) do
		if not data or not data.nPlayerId or not data.flRatio then
			goto continue
		end

		local playerId = data.nPlayerId
		local flRatio = data.flRatio

		local bonusGoldCount = math.floor(self.baseBonus * flRatio)

		local barrageData = {
			playerId = playerId,
			type = "bet_win",
		}

		if data.sType and "pvp_free" == data.sType then
			if flRatio >= 0.99 then
				barrageData.type = "bet_jackpot"
			else
				barrageData.type = "pvp_win"
				bonusGoldCount = bonusGoldCount + math.floor(self.baseBonus * 0.15)
			end
			self:RewardWinnerBonus(playerId, bonusGoldCount)
		else
			self:RewardBetBonus(playerId, bonusGoldCount)
		end

		local grossWinnings =
			math.ceil(bonusGoldCount * (100 + GoldService:GetPlayerBonusGoldPercentage(playerId)) * 0.01)
		barrageData.gold_value = grossWinnings

		Barrage:FireBullet(barrageData)

		self:SumBetReward(playerId, grossWinnings)

		local multiplier = data.nValue > 0 and (grossWinnings / data.nValue) or 0
		PvpRecordBook:RecordBetHistory(
			playerId,
			grossWinnings - data.nValue,
			winnerTeamId,
			loserTeamId,
			data.nValue,
			multiplier,
			pool
		)

		::continue::
	end
end