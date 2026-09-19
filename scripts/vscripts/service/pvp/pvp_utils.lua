--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


---Очищает данные таблицы
---@generic K, V
---@param tempTable table<K, V>
---@param id integer
function CleanTempData(tempTable, id)
	for teamNumber, team in pairs(GameMode:GetMatch():GetTeams()) do
		if team:IsAlive() and tempTable[teamNumber] then
			table.remove_item(tempTable[teamNumber], id)
		end
	end
end

---Обработчик события мьюта игроков
---@param keys {PlayerID: PlayerID, toPlayerId: PlayerID, disable: boolean}
function PvpService:ToggleMute(keys)
	if
		PvpService.MuteMap
		and PvpService.MuteMap[keys.PlayerID]
		and PvpService.MuteMap[keys.PlayerID][keys.toPlayerId]
	then
		PvpService.MuteMap[keys.PlayerID][keys.toPlayerId] = ((keys.disable or 0) == 1)
	end
end