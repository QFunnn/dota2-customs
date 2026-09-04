--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


-- Список SteamID администраторов.
--
-- ЕДИНСТВЕННЫЙ источник истины — таблица `admin` в БД, отдаётся эндпоинтом `get_admins`
-- (D2_Server/routes/api.js). Хардкод-списка здесь БОЛЬШЕ НЕТ (решение владельца 2026-08-04):
-- права выдаёт только БД, а если список не приехал — админов в матче нет вообще.
--
-- Почему так безопаснее: раньше в файле лежали 7 ID, они подменяли собой БД при любом сбое
-- запроса, и добавленные в таблицу люди прав не получали, а удалённые — сохраняли.
--
-- Разработке это не мешает: в тулзах и чит-режиме админские команды и так открыты по
-- GameRules:IsCheatMode() (см. utils/debugger.lua:33), запросы к серверу там не идут.

if Admins == nil then
	_G.Admins = class({})
end

function Admins:Init()
	if self.bInitialized then
		return
	end
	self.bInitialized = true

	-- До ответа сервера админов нет. Список приезжает в Admins:LoadFromServer.
	self.AdminIDs = {}
	self.LoadedFromServer = false
end

-- Загружает свежий список с сервера. Безопасно вызывать многократно.
-- При ошибке/таймауте список остаётся пустым — то есть админов в этом матче не будет.
function Admins:LoadFromServer()
	SendRequest(SERVER_URL .. "get_admins", {}, function(Res)
		if not Res or type(Res.admins) ~= "table" then
			print("[Admins] Empty/invalid response, admin list stays empty (" .. self:Count() .. " admins)")
			return
		end

		local NewList = {}
		local Count = 0
		for _, SteamID in ipairs(Res.admins) do
			NewList[tostring(SteamID)] = true
			Count = Count + 1
		end

		-- Пустой ответ применяем как есть: в БД ноль строк = админов нет.
		-- Прежняя «защита» тут оставляла старый список и маскировала бы удаление из таблицы.
		self.AdminIDs = NewList
		self.LoadedFromServer = true
		print("[Admins] Loaded " .. Count .. " admin(s) from server")
	end, true)
end

function Admins:Count()
	local n = 0
	for _ in pairs(self.AdminIDs) do
		n = n + 1
	end
	return n
end

function Admins:IsAdmin(SteamID)
	if SteamID == nil then
		return false
	end
	return self.AdminIDs[tostring(SteamID)] == true
end

function Admins:IsAdminPlayer(PlayerID)
	if PlayerID == nil or not PlayerResource:IsValidPlayerID(PlayerID) then
		return false
	end
	return self:IsAdmin(PlayerResource:GetSteamAccountID(PlayerID))
end

if not Admins.bInitialized then
	Admins:Init()
end