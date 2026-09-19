--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---@class Round
---@field match Match
---@field pvp Pvp
---@field roundNumber integer
---@field roundTimeLimit integer
---@field roundTimeExceeded boolean
---@field spawners table<integer, Spawner>
---@field isEnd boolean
if Round == nil then
	Round = class({})
end

require("domain.round.pvp")
require("domain.round.round_config")
require("domain.round.round_utils")
require("domain.round.round_ui")
require("domain.round.round_pvp")

---@class CDOTA_BaseNPC_Hero
---@field abilitiesList table
---@field nDeathTime number

---@param match Match
---@param roundNumber integer
function Round:constructor(match, roundNumber)
	logger:Log("Round constructor call.")
	self.match = match
	self.pvp = Pvp()
	self.spawners = {} ---@type table<integer, Spawner>
	self.isEnd = false
	self.roundNumber = roundNumber
	self.creatureCount = 0
	if self.roundNumber >= 1 then
		GameRulesCustom:SetSafeToLeave(true)
	end
	self.roundTimeExceeded = false
	self.playerRank = 0
	self.prepareTotalTime = BASE_PREPARE_TIME
	self.roundTimeLimit = ROUND_LIMIT_TIME
	self.readyPlayers = {} ---@type table<integer, boolean>
end

---@return Pvp
function Round:GetPvp()
	return self.pvp
end

---@return integer
function Round:GetTimeLimit()
	return self.roundTimeLimit
end

---@return boolean
function Round:IsTimeExceeded()
	return self.roundTimeExceeded
end

function Round:Prepare()
	self:ResetPlayerReady()

	local isSelectAbilityRound = AbilityQuota:ApplyRoundBasic(self.roundNumber)

	if isSelectAbilityRound then
		self.prepareTotalTime = BASE_PREPARE_TIME + 15
	end

	self.aliveTeamCount = 0
	for _, team in pairs(self.match:GetTeams()) do
		if not team:IsAlive() then
			goto continue
		end
		self.aliveTeamCount = self.aliveTeamCount + 1
		if not isSelectAbilityRound then
			goto continue
		end
		for _, playerId in ipairs(team:GetPlayers()) do
			local hero = PlayerResource:GetSelectedHeroEntity(playerId)
			if hero and hero.abilitiesList and #hero.abilitiesList < AbilityQuota:GetTotal(playerId) then
				AbilitySelectionService:ShowRandomAbilitySelection(playerId)
			end
		end
		::continue::
	end

	if GameMode:GetMatchType() == MATCH_TYPE_DUO then
		ROUND_BASE_BONUS = 320
	end

	self.flBonus = ComputeRoundBonus(self.roundNumber)

	self.roundName = ""
	if
		GameMode.RoundList
		and GameMode.RoundList[self.roundNumber]
		and GameMode.RoundList[self.roundNumber].RoundName
	then
		self.roundName = GameMode.RoundList[self.roundNumber].RoundName
	end

	if
		not (
			GameMode.RoundList
			and GameMode.RoundList[self.roundNumber]
			and GameMode.RoundList[self.roundNumber].RoundData
		)
	then
		return
	end

	local roundData = GameMode.RoundList[self.roundNumber].RoundData
	self.creatureCount = CountCreatures(roundData)
	local abilityList = BuildAbilityListForUI(roundData)
	self:UpdateNextRoundsNetTable(10)
	if DebugTool and type(DebugTool.UpdateFutureRoundsNetTable) == "function" then
		DebugTool:UpdateFutureRoundsNetTable()
	end

	self.flExpMulti = 1
	if GameMode:GetMatchType() == MATCH_TYPE_DUO then
		self.flExpMulti = 2
	end

	if PvpMatchmaker:IsPvpRound(self.roundNumber) then
		if self.roundName ~= "round_roshan" then
			if GameMode:GetMatchType() == MATCH_TYPE_DUO then
				self.prepareTotalTime = self.prepareTotalTime + 5
			else
				self.prepareTotalTime = self.prepareTotalTime + 2
			end
			PvpService:RoundPrepare(self.roundNumber)
		end
	end

	self.prepareTotalTime = self:GetPrepareRoundTime()

	self.prepareTime = 0
	CustomGameEventManager:Send_ServerToAllClients("CreateQuest", {
		name = "RoundPrepare",
		text = "#round_prepare",
		svalue = 0,
		evalue = self.prepareTotalTime,
		text_value = self.roundNumber,
		text_value_2 = "#" .. self.roundName,
		creature_count = self.creatureCount,
		tAbilityList = abilityList,
		bRoundStart = true,
	})
	self:SetReadyButtonVisible(true)

	GameListener:SubscribeProtected("PlayerReady", function(event)
		self:PlayerReady(event)
	end)

	self:StartPrepareTimerAsync()
end

function Round:Begin()
	local living_player_count = 0
	for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		local hero = PlayerResource:GetSelectedHeroEntity(i)
		if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
			hero:SetMana(hero:GetMaxMana())
			if hero:IsAlive() or hero:IsReincarnating() then
				living_player_count = living_player_count + 1
			end
		end
	end

	DataManager:StartRecordForAllPlayers()

	for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(playerId) then
			self:HidePvpBetForPlayer(playerId)
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("ResetPlayerReadyList", {})
	BetService:SummarizeBetInfo()
	self:SetReadyButtonVisible(false)
	CustomGameEventManager:Send_ServerToAllClients("RemoveQuest", {
		name = "RoundPrepare",
	})

	local global_pvp_flag = PvpService:HasActivePair()
	local pvpPair = PvpService:GetPair()

	if global_pvp_flag then
		logger:Log(
			string.format(
				"Round:Begin PVP roundNumber=%d currentPvpPair={%s,%s} homeTeamId=%s",
				self.roundNumber,
				tostring(pvpPair[1]),
				tostring(pvpPair[2]),
				tostring(PvpService:GetHomeTeamId())
			)
		)
	end

	for teamNumber, team in pairs(self.match:GetTeams()) do
		if team:IsAlive() then
			local isTeamPvpFlag = false
			local teamHasHero = false
			for playerIndex, playerId in ipairs(team:GetPlayers()) do
				local isPlayerPvpFlag = false
				local centerPos = self.match:GetTeamLocation(teamNumber)
				local player = PlayerResource:GetPlayer(playerId)
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				local supposeRoomName = "center_" .. teamNumber

				if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
					teamHasHero = true
					for i, pvpTeamID in ipairs(pvpPair) do
						if pvpTeamID == teamNumber then
							centerPos = PvpService:GetHomeCenter() - Vector((3 - i * 2) * 550, 0, 0)
							supposeRoomName = "center_" .. PvpService:GetHomeTeamId()
							if GameMode:GetMatchType() == MATCH_TYPE_DUO then
								centerPos = centerPos + Vector(0, (3 - playerIndex * 2) * 350, 0)
							end
							isTeamPvpFlag = true
							isPlayerPvpFlag = true
							hero.bJoiningPvp = true
							self:ShowPvpParticle(hero, centerPos)
						end
					end

					if player and not isPlayerPvpFlag and (not PvpService:IsDuelEnded()) then
						hero.bJoiningPvp = false
						local dataList, firstTeamId, secondTeamId
						if pvpPair[1] and pvpPair[2] then
							firstTeamId, secondTeamId = pvpPair[1], pvpPair[2]
							dataList = CollectPvpPlayersForTeams(firstTeamId, secondTeamId)
						end
						if dataList then
							self:ShowPvpBrief(playerId, dataList, firstTeamId, secondTeamId)
						end
					end

					hero:RemoveModifierByName("modifier_hero_refreshing")
					HeroPlacementService:MoveHeroToLocation(playerId, centerPos, nil, supposeRoomName)
				end
			end
			-- без героя спавнер не создаём: крипов бить некому
			if not isTeamPvpFlag and teamHasHero then
				self.spawners[teamNumber] = Spawner()
				self.spawners[teamNumber]:Init(teamNumber, self)
			end
		else
			if global_pvp_flag then
				local dataList = CollectPvpPlayersForTeams(pvpPair[1], pvpPair[2])
				for _, playerId in ipairs(team:GetPlayers()) do
					if PlayerResource:IsValidPlayer(playerId) then
						self:ShowPvpBrief(playerId, dataList, pvpPair[1], pvpPair[2])
					end
				end
			end
		end
	end

	if global_pvp_flag then
		local dataList = CollectPvpPlayersForTeams(pvpPair[1], pvpPair[2])
		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if
				PlayerResource:IsValidPlayer(playerId)
				and (IsInToolsMode() or PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED)
			then
				if PlayerResource:GetTeam(playerId) == DOTA_TEAM_SPECTATOR then
					self:ShowPvpBrief(playerId, dataList, pvpPair[1], pvpPair[2])
				end
			end
		end
	end

	CustomGameEventManager:Send_ServerToAllClients("CreateQuest", {
		name = "RoundTimeLimit",
		text = "#round_time_limit",
		svalue = ROUND_LIMIT_TIME,
		evalue = ROUND_LIMIT_TIME,
		text_value = self.roundNumber,
		bRoundStart = false,
	})
	self:StartRoundTimerAsync()
end

function Round:StartRoundTimerAsync()
	Timers:CreateTimer(1, function()
		if self.isEnd == true then
			return nil
		end

		local ok, nextWait = xpcall(function()
			self:CheckDeathTeams()

			local isAllTeamFinish = true
			local isNoAliveTeam = true
			for teamNumber, team in pairs(self.match:GetTeams()) do
				if not team:IsAlive() then
					goto continue
				end
				isNoAliveTeam = false
				if self.spawners[teamNumber] and self.spawners[teamNumber].isProgressFinished == false then
					isAllTeamFinish = false
				end
				if not PvpService:IsDuelEnded() then
					isAllTeamFinish = false
				end
				::continue::
			end

			-- Логируем переходы состояний (не каждый тик)
			if isNoAliveTeam and not self._loggedNoAliveTeam then
				self._loggedNoAliveTeam = true
				logger:Log(
					string.format(
						"RoundTick: isNoAliveTeam=true roundNumber=%d roundTimeLimit=%d",
						self.roundNumber,
						self.roundTimeLimit
					)
				)
			end
			if isAllTeamFinish and not self._loggedAllTeamFinish then
				self._loggedAllTeamFinish = true
				logger:Log(
					string.format(
						"RoundTick: isAllTeamFinish=true roundNumber=%d roundTimeLimit=%d validTeamNumber=%d",
						self.roundNumber,
						self.roundTimeLimit,
						self.match:GetValidTeamNumber() or -1
					)
				)
			end
			if self.roundTimeLimit == 0 and not self._loggedTimeLimitZero then
				self._loggedTimeLimitZero = true
				logger:Log(string.format("RoundTick: roundTimeLimit reached 0, roundNumber=%d", self.roundNumber))
				for teamNumber, team in pairs(self.match:GetTeams()) do
					if
						team:IsAlive()
						and self.spawners[teamNumber]
						and self.spawners[teamNumber].isProgressFinished == false
					then
						self.spawners[teamNumber]:LogProgressDump("roundTimeLimit=0")
					end
				end
			end

			if isAllTeamFinish then
				logger:Log(string.format("RoundTick: calling FinishRound roundNumber=%d", self.roundNumber))
				GameMode:FinishRound()
				CustomGameEventManager:Send_ServerToAllClients("RemoveQuest", {
					name = "RoundTimeLimit",
				})
				return nil
			end

			self.roundTimeLimit = self.roundTimeLimit - 1
			if self.roundTimeLimit > 0 then
				CustomGameEventManager:Send_ServerToAllClients("RefreshQuest", {
					name = "RoundTimeLimit",
					text = "#round_time_limit",
					svalue = self.roundTimeLimit,
					evalue = ROUND_LIMIT_TIME,
					text_value = self.roundNumber,
				})
			else
				CustomGameEventManager:Send_ServerToAllClients("RefreshQuest", {
					name = "RoundTimeLimit",
					text = "#round_time_expire",
					svalue = self.roundTimeLimit,
					evalue = ROUND_LIMIT_TIME,
				})
			end

			if self.roundTimeLimit == 0 then
				self.roundTimeExceeded = true
			end
			if self.roundTimeLimit < 0 then
				self:RoundTimeExceeded()
			end

			if self.roundTimeLimit < -200 then
				for teamNumber, team in pairs(self.match:GetTeams()) do
					if
						team:IsAlive()
						and self.spawners[teamNumber]
						and self.spawners[teamNumber].isProgressFinished == false
					then
						self.spawners[teamNumber]:LogProgressDump("force-finish<-200")
						self.spawners[teamNumber]:Finish()
					end
				end
				local units = FindUnitsInRadius(
					DOTA_TEAM_NEUTRALS,
					Vector(0, 0, 0),
					nil,
					FIND_UNITS_EVERYWHERE,
					DOTA_UNIT_TARGET_TEAM_FRIENDLY,
					DOTA_UNIT_TARGET_ALL,
					DOTA_UNIT_TARGET_FLAG_NONE,
					FIND_ANY_ORDER,
					false
				)
				for _, unit in pairs(units) do
					if IsValid(unit) then
						unit:ForceKill(false)
					end
				end
			end

			return 1
		end, function(e)
			logger:LogError(e)
		end)

		if ok then
			return nextWait
		else
			return 1
		end
	end)
end

function Round:CheckDeathTeams()
	for teamNumber, team in pairs(self.match:GetTeams()) do
		if not team:IsAlive() then
			goto continue
		end
		local isTeamAlive = false
		for _, playerId in ipairs(team:GetPlayers()) do
			if HeroSelectionService:HasPendingForcedHero(playerId) then
				isTeamAlive = true
			end
			local hero = PlayerResource:GetSelectedHeroEntity(playerId)
			if IsValid(hero) then ---@cast hero CDOTA_BaseNPC_Hero
				if hero:IsAlive() or hero:IsReincarnating() then
					hero.nDeathTime = 0
					isTeamAlive = true
				else
					hero.nDeathTime = (hero.nDeathTime or 0) + 1
				end
				if (hero.nDeathTime or 0) <= 6 then
					isTeamAlive = true
				end
			end
		end
		if isTeamAlive == false then
			for _, playerId in ipairs(team:GetPlayers()) do
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				logger:Logf(
					"CheckDeathTeams: team=%d pid=%d hasHero=%s alive=%s connState=%d forced=%s",
					teamNumber,
					playerId,
					tostring(hero ~= nil),
					tostring(IsValid(hero) and hero:IsAlive()),
					PlayerResource:GetConnectionState(playerId),
					tostring(HeroSelectionService.Hero and HeroSelectionService.Hero[playerId])
				)
			end
			logger:Log(string.format("CheckDeathTeams: teamNumber=%d marked dead -> calling TeamLose", teamNumber))
			MatchLifecycleService:TeamLose(teamNumber)
		end
		::continue::
	end
end

function Round:ResetPlayerReady()
	for _, team in pairs(self.match:GetTeams()) do
		if not team:IsAlive() then
			goto continue
		end
		for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
			if
				PlayerResource:IsValidPlayer(playerId)
				and PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED
			then
				self.readyPlayers[playerId] = false
			end
		end
		::continue::
	end
end

---@return integer
function Round:GetPrepareRoundTime()
	local time = self.prepareTotalTime
	if self.roundNumber >= 40 then
		time = time + 2
	end
	if self.roundNumber >= 50 then
		time = time + 2
	end
	if self.roundNumber >= 60 then
		time = time + 2
	end
	return time
end

function Round:StartPrepareTimerAsync()
	Timers:CreateTimer(1, function()
		self.prepareTime = self.prepareTime + 1
		CustomGameEventManager:Send_ServerToAllClients("RefreshQuest", {
			name = "RoundPrepare",
			text = "#round_prepare",
			svalue = self.prepareTime,
			evalue = self.prepareTotalTime,
			text_value = self.roundNumber,
			text_value_2 = "#" .. self.roundName,
			creature_count = self.creatureCount,
		})
		CustomGameEventManager:Send_ServerToAllClients("UpdateConfirmButton", {
			currentTime = self.prepareTime,
			totalTime = self.prepareTotalTime,
		})

		if self.isEnd then
			CustomGameEventManager:Send_ServerToAllClients("RemoveQuest", {
				name = "RoundPrepare",
			})
			return nil
		end

		local isAllReady = true
		for _, team in pairs(self.match:GetTeams()) do
			if not team:IsAlive() then
				goto continue
			end
			for playerId = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
				if
					PlayerResource:IsValidPlayer(playerId)
					and PlayerResource:GetConnectionState(playerId) == DOTA_CONNECTION_STATE_CONNECTED
				then
					if self.readyPlayers[playerId] == false then
						isAllReady = false
						break
					end
				end
			end
			::continue::
		end

		if isAllReady or (self.prepareTime >= self.prepareTotalTime) then
			logger:Log(
				string.format(
					"PrepareTimer: starting Begin isAllReady=%s prepareTime=%d prepareTotalTime=%d roundNumber=%d",
					tostring(isAllReady),
					self.prepareTime,
					self.prepareTotalTime,
					self.roundNumber
				)
			)
			xpcall(function()
				self:Begin()
			end, function(e)
				logger:LogError(e)
			end)
			return nil
		else
			return 1
		end
	end)
end

function Round:End()
	MatchStateService:Save()
	self.isEnd = true
	PvpService:ResetPair()
	if self.roundNumber and COMPENSATION_ROUNDS[self.roundNumber] then
		self:CompensateRelearnBook(self.roundNumber)
	end
	HeroRefreshService:CleanFurArmySoldier()
	CustomGameEventManager:Send_ServerToAllClients("EndQuest", {})
end

---@param roundNumber integer
function Round:CompensateRelearnBook(roundNumber)
	local dataList = {} ---@type {nGold: integer, nPlayerID: integer}[]

	for _, team in pairs(self.match:GetTeams()) do
		if team:IsAlive() then
			for _, playerId in ipairs(team:GetPlayers()) do
				local hero = PlayerResource:GetSelectedHeroEntity(playerId)
				if hero and PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
					table.insert(dataList, {
						nGold = GoldService:GetTotalGoldForPlayer(playerId),
						nPlayerID = playerId,
					})
				end
			end
		end
	end

	if #dataList < 2 then
		return
	end

	table.sort(dataList, function(a, b)
		return a.nGold < b.nGold
	end)

	local rewards = {
		[1] = { book = true, torn = 2, type = 3 },
		[2] = { book = true, torn = 1, type = 2 },
		[3] = { book = false, torn = 2, type = 1 },
	}

	for pos = 1, math.min(3, #dataList) do
		local entry = dataList[pos]
		local reward = rewards[pos]
		local playerId = entry.nPlayerID
		local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
		if not (hHero and reward) then
			goto continue
		end

		if reward.book then
			local relearnBook = ExtenderStash:GiveItemToPlayerStashInventoryOrDrop(playerId, "item_relearn_book_lua")
			if relearnBook then
				relearnBook:SetPurchaseTime(GameRulesCustom:GetGameTime() - 70)
			end
		end

		for i = 1, reward.torn do
			local hTornPage = ExtenderStash:GiveItemToPlayerStashInventoryOrDrop(playerId, "item_relearn_torn_page_lua")
			if hTornPage then
				hTornPage:SetPurchaseTime(GameRulesCustom:GetGameTime() - 70)
			end
		end

		Barrage:FireBullet({
			type = "compensate_relearn_book",
			round_number = tostring(roundNumber),
			playerId = playerId,
			book_type = reward.type,
		})

		::continue::
	end
end