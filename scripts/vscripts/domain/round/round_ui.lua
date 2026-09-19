--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Обновляет видимость кнопки готовности.
---@param visible boolean
function Round:SetReadyButtonVisible(visible)
	CustomGameEventManager:Send_ServerToAllClients("UpdateReadyButton", { visible = visible })
end

---@param limit integer|nil
function Round:UpdateNextRoundsNetTable(limit)
	local entries = {}
	local maxCount = limit or 10

	for index = 1, maxCount do
		local roundNumber = self.roundNumber + index
		local round = GameMode.RoundList and GameMode.RoundList[roundNumber]
		if round and round.RoundName and round.RoundData then
			entries[tostring(index)] = {
				number = roundNumber,
				name = "#" .. round.RoundName,
				count = CountCreatures(round.RoundData),
				abilities = BuildAbilityListForUI(round.RoundData),
			}
		end
	end

	CustomNetTables:SetTableValue("rounds", "next", {
		current = self.roundNumber,
		entries = entries,
	})
end

---Скрывает окно ставок PvP для конкретного игрока.
---@param playerID integer
function Round:HidePvpBetForPlayer(playerID)
	local hPlayer = PlayerResource:GetPlayer(playerID)
	if hPlayer then
		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "HidePvpBet", {
			security_key = Security:GetSecurityKey(playerID),
		})
	end
end

---Показывает сводку PvP игроку-наблюдателю.
---@param playerID integer
---@param players table<integer, {playerID: integer, teamID: integer}>
---@param firstTeamId integer
---@param secondTeamId integer
function Round:ShowPvpBrief(playerID, players, firstTeamId, secondTeamId)
	local hPlayer = PlayerResource:GetPlayer(playerID)
	if hPlayer then
		local betTeamId = nil
		for teamId, list in pairs(BetService:GetBetMap()) do
			for _, data in ipairs(list) do
				if data and data.nPlayerId == playerID then
					betTeamId = teamId
					break
				end
			end
			if betTeamId then
				break
			end
		end

		local potentialWin = 0
		if betTeamId then
			potentialWin = BetService:GetPotentialBetWin(playerID, betTeamId)
		end

		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "ShowPvpBrief", {
			players = players,
			firstTeamId = firstTeamId,
			secondTeamId = secondTeamId,
			betMap = BetService:GetBetMap(),
			bonusPool = math.floor(BetService:GetBaseBonus()),
			potential_win = potentialWin,
			has_placed_bet = (betTeamId ~= nil) and 1 or 0,
		})
	end
end

---Обработчик клика "Готов". Помечает игрока готовым и обновляет UI.
---@param keys {PlayerID: integer}
function Round:PlayerReady(keys)
	local playerId = keys.PlayerID
	if not playerId then
		return
	end
	local hPlayer = PlayerResource:GetPlayer(playerId)
	if hPlayer then
		self.readyPlayers[playerId] = true
		CustomGameEventManager:Send_ServerToAllClients("UpdatePlayerReadyList", { readyPlayers = self.readyPlayers })
		CustomGameEventManager:Send_ServerToPlayer(hPlayer, "UpdateReadyButton", { visible = false })
	end
end

---Доступ к спавнеру команды.
---@param nTeamNumber integer
---@return Spawner
function Round:GetTeamSpawner(nTeamNumber)
	return self.spawners[nTeamNumber]
end