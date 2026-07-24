--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if MemoryTracker then return MemoryTracker end
MemoryTracker = {}

local lastMemory = 0
local maxMemory = 0
local iteration = 0
local lastTimerCount = 0

-- история последних замеров для анализа роста
local memoryHistory = {}
local timerHistory = {}

------------------------------------------------------------
-- рекурсивный подсчёт таблиц, функций и userdata
------------------------------------------------------------
local function countObjects(seen, t)
    if seen[t] then return 0, 0, 0 end
    seen[t] = true
    local nTables, nFuncs, nUserdata = 0, 0, 0

    for _, v in pairs(t) do
        local tv = type(v)
        if tv == "table" then
            nTables = nTables + 1
            local t2, f2, u2 = countObjects(seen, v)
            nTables = nTables + t2
            nFuncs = nFuncs + f2
            nUserdata = nUserdata + u2
        elseif tv == "function" then
            nFuncs = nFuncs + 1
        elseif tv == "userdata" then
            nUserdata = nUserdata + 1
        end
    end
    return nTables, nFuncs, nUserdata
end

--[[
🔹 Funcs
Количество Lua-функций и замыканий (closures).
Каждая function() ... end — это новый объект.
Обычно их немного (пару тысяч).
Медленный рост Funcs — признак того, что где-то создаются новые анонимные функции в циклах или таймерах.
]]

--[[
🔹 Tables
Количество таблиц Lua (все массивы, словари, структуры).
Они занимают большую часть Lua-памяти.
В Dota-кастомках — это всё: способности, модификаторы, энтити-данные, настройки, таймеры, event-таблицы и т. д.
Рост Tables → почти всегда рост памяти.
Если число стабильно (±500), GC работает нормально.
]]

--[[
🔹 Userdata
Количество C++ объектов, “обёрнутых” в Lua.
Это все handle-объекты движка: CDOTA_BaseNPC, CEntity, Vector, QAngle, ParticleManager и т. д.
Эти объекты создаются нативным кодом Source 2 и управляются через Lua-ссылку.
]]


------------------------------------------------------------
-- считает активные таймеры (Timers.lua из Dota 2 Workshop Tools)
------------------------------------------------------------
local function countActiveTimers()
    if not Timers or not Timers.timers then return 0 end
    local count = 0
    for _, timer in pairs(Timers.timers) do
        if type(timer) == "table" then
            count = count + 1
        end
    end
    return count
end

------------------------------------------------------------
-- основная функция логирования
------------------------------------------------------------
function MemoryTracker.LogMemoryUsage()
    iteration = iteration + 1
    local totalMemory = collectgarbage("count")
    lastMemory = totalMemory
    if totalMemory > maxMemory then
        maxMemory = totalMemory
    end

    local tCount, fCount, uCount = countObjects({}, _G)
    local timerCount = countActiveTimers()

    table.insert(memoryHistory, totalMemory)
    table.insert(timerHistory, timerCount)
    if #memoryHistory > 5 then table.remove(memoryHistory, 1) end
    if #timerHistory > 5 then table.remove(timerHistory, 1) end

    logger:Log(string.format(
        "[MemoryTracker] Lua: %.2f MB (max %.2f MB) | Tables: %d | Funcs: %d | Userdata: %d | Timers: %d",
        totalMemory / 1024, maxMemory / 1024, tCount, fCount, uCount, timerCount
    ))

    --[[-- Логирование мест создания таймеров
    if iteration % 5 == 0 and MemoryTracker._timerSources then
        logger:InternalLog("------ Timer creation hot spots ------")
        for src, count in pairs(MemoryTracker._timerSources) do
            logger:InternalLog(string.format("  %s : %d timers", src, count))
        end
    end]]
end

---Возвращает текущее потребление памяти Lua VM в виде строки. 
---@return string
function MemoryTracker:GetMemoryUsageMessage()
    local totalMemory = collectgarbage("count")
    local tCount, fCount, uCount = countObjects({}, _G)
    local timerCount = countActiveTimers()
    return string.format(
        "[MemoryTracker] Lua: %.2f MB | Tables: %d | Funcs: %d | Userdata: %d | Timers: %d",
        totalMemory / 1024, tCount, fCount, uCount, timerCount
    )
end

------------------------------------------------------------
-- Создаёт периодическую задачу на проверку памяти
------------------------------------------------------------
---@param interval integer
function MemoryTracker.Start(interval)
    interval = interval or 10
    Timers:CreateTimer(interval, function()
        MemoryTracker.LogMemoryUsage()
        return interval
    end)

    if not _G.__TimerHooked then
        _G.__TimerHooked = true
        local oldCreateTimer = Timers.CreateTimer

        Timers.CreateTimer = function(context, name, args)
            local info = debug.getinfo(2, "Sl")
            local source = string.format("%s:%d", info.short_src or "?", info.currentline or -1)

            -- для статистики
            MemoryTracker._timerSources = MemoryTracker._timerSources or {}
            MemoryTracker._timerSources[source] = (MemoryTracker._timerSources[source] or 0) + 1

            -- подробный лог
            if (MemoryTracker._debug or false) then
                logger:Log(string.format("[Timer] %s", source))
            end

            return oldCreateTimer(context, name, args)
        end
    end
end

return MemoryTracker