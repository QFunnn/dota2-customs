--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if DataManager == nil then ---@class DataManager
	DataManager = {}
end

function DataManager:Init()

	self.DamageData = {} ---@type table<integer, {startTime: number, endtime: number, data: table<string, {abilityName: string, damage_type: DAMAGE_TYPES, damage: number}>}>

	for iPlayerID = 0, 11 do
		self.DamageData[iPlayerID] = {
			startTime = GameRulesCustom:GetGameTime(),
			endtime = GameRulesCustom:GetGameTime(),
			data = {}
		}
	end

end

---Запускает таймер для всех игроков по подсчету урона
function DataManager:StartRecordForAllPlayers()
	for iPlayerID = 0, 11 do
		self.DamageData[iPlayerID] = {
			startTime = GameRulesCustom:GetGameTime(),
			endtime = GameRulesCustom:GetGameTime() + 99999,
			data = {}
		}
		self:UpdateDamageData(iPlayerID)

		local timerName = "DamageRecord_" .. tostring(iPlayerID)
		Timers:RemoveTimer(timerName) -- удалить старый таймер, если был

		Timers:CreateTimer(timerName, {
			useGameTime = true,
			endTime = 1,
			callback = function()
				if GameRulesCustom:GetGameTime() >= self.DamageData[iPlayerID].endtime then
					return nil
				end
				self:UpdateDamageData(iPlayerID)
				return 1
			end
		})
	end
end

---Остановить запись урона для игрока
---@param iPlayerID integer
function DataManager:EndRecord(iPlayerID)
	self.DamageData[iPlayerID].endtime = GameRulesCustom:GetGameTime()
	self:UpdateDamageData(iPlayerID)
end

---Обновить информацию в UI о нанесенном урона для определенного игрока
---@param iPlayerID integer
function DataManager:UpdateDamageData(iPlayerID)
	if PlayerResource:IsValidPlayer(iPlayerID) then
		local player = PlayerResource:GetPlayer(iPlayerID)
		if player then
			CustomGameEventManager:Send_ServerToPlayer(player, "UpdateDamageData", self.DamageData[iPlayerID].data)	
		end
	end
end

---comment
---@param iPlayerID integer
---@param abilityName string
---@param damage_type string
---@return string?
function DataManager:FindKeyForRecord(iPlayerID, abilityName, damage_type)
	for key, value in pairs(self.DamageData[iPlayerID].data) do
		if value.abilityName == abilityName and value.damage_type == damage_type then
			return key
		end
	end
	return nil
end

---Записать нанесенный игроком урон в таблицу урона
---@param iPlayerID integer
---@param abilityName string
---@param damage number
---@param damage_type DAMAGE_TYPES
function DataManager:RecordDamage(iPlayerID, abilityName, damage, damage_type)
	local time = GameRulesCustom:GetGameTime()
	if self.DamageData and self.DamageData[iPlayerID] and self.DamageData[iPlayerID].data and time > self.DamageData[iPlayerID].startTime and time < self.DamageData[iPlayerID].endtime then
		local key = abilityName .. damage_type
		if self.DamageData[iPlayerID].data[key] ~= nil then
			self.DamageData[iPlayerID].data[key].damage = (self.DamageData[iPlayerID].data[key].damage or 0) + damage
		else
			self.DamageData[iPlayerID].data[key] = {
				abilityName = abilityName,
				damage_type = damage_type,
				damage = damage
			}
		end
	end
end