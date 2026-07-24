--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Список SteamID администраторов.
-- Источник истины — таблица `admins` на сервере (endpoint `get_admins`).
-- Хардкод-список ниже используется как fallback:
--   1. При работе в тулзах / чит-режиме (SERVER_ENABLE_WITH_CHEATS = false → запросы не идут).
--   2. Пока ответ от сервера ещё не пришёл (запрос асинхронный).
--   3. Если запрос упал после всех попыток (нет интернета у сервера, БД лежит и т.п.).
local FALLBACK_ADMIN_IDS = {
    ["44477"]      = true,
    ["871812405"]  = true,
    ["188428188"]  = true,
    ["257681693"]  = true,
    ["133443476"]  = true,
    ["338450513"]  = true,
    ["1870719845"] = true, -- dev account (локальные тесты без БД)
}

if Admins == nil then
    _G.Admins = class({})
end

function Admins:Init()
    if self.bInitialized then return end
    self.bInitialized = true

    -- Стартуем с fallback, чтобы IsAdmin() работал ещё до ответа сервера.
    self.AdminIDs = {}
    for SteamID in pairs(FALLBACK_ADMIN_IDS) do
        self.AdminIDs[SteamID] = true
    end
    self.LoadedFromServer = false
end

-- Загружает свежий список с сервера. Безопасно вызывать многократно.
-- При ошибке/таймауте просто остаётся текущее (fallback) значение.
function Admins:LoadFromServer()
    SendRequest(SERVER_URL.."get_admins", {}, function(Res)
        if not Res or type(Res.admins) ~= "table" then
            print('[Admins] Empty/invalid response, keeping current list ('..self:Count()..' admins)')
            return
        end

        local NewList = {}
        local Count = 0
        for _, SteamID in ipairs(Res.admins) do
            NewList[tostring(SteamID)] = true
            Count = Count + 1
        end

        -- Защита от случайно пустого ответа: если в БД ноль строк, лучше оставить fallback.
        if Count == 0 then
            print('[Admins] Server returned empty admins list, keeping fallback')
            return
        end

        self.AdminIDs = NewList
        self.LoadedFromServer = true
        print('[Admins] Loaded '..Count..' admin(s) from server')
    end, true)
end

function Admins:Count()
    local n = 0
    for _ in pairs(self.AdminIDs) do n = n + 1 end
    return n
end

function Admins:IsAdmin(SteamID)
    if SteamID == nil then return false end
    return self.AdminIDs[tostring(SteamID)] == true
end

function Admins:IsAdminPlayer(PlayerID)
    if PlayerID == nil or not PlayerResource:IsValidPlayerID(PlayerID) then return false end
    return self:IsAdmin(PlayerResource:GetSteamAccountID(PlayerID))
end

if not Admins.bInitialized then Admins:Init() end