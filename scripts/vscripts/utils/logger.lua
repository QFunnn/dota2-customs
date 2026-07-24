--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if logger == nil then
    _G.logger = class({})
end

local LOG_BUFFER_CAP = 500

local function GetCaller()
	-- На проде недоступен дебаг
	if type(debug) ~= "table" or type(debug.getinfo) ~= "function" then
		return ""
	end

	local ok, info = pcall(debug.getinfo, 3, "nSl")
	if not ok or not info then
		return ""
	end

	local method = info.name or "anonymous"

	local src = info.short_src or "?"

	-- вытаскиваем только имя файла
	local file = src:match("([^/\\]+)$") or src
	local line = info.currentline or 0

	return string.format("[%s] [%s:%d]", file, method, line)
end

-- Внутренний буфер лог-записей (кольцевой, макс LOG_BUFFER_CAP строк)
local _logBuffer = {} ---@type string[]
local _logCount  = 0  -- сколько записей всего добавлено (для кольца не нужно, но удобно)

local function PushToBuffer(entry)
    if #_logBuffer >= LOG_BUFFER_CAP then
        table.remove(_logBuffer, 1)
    end
    _logBuffer[#_logBuffer + 1] = entry
    _logCount = _logCount + 1
end

---Логируем в консоль, если находимся в InToolsMode; ВСЕГДА добавляем в буфер.
---@param ... any
function logger:Log(...)
	local parts = {}
	for i = 1, select("#", ...) do
		parts[#parts + 1] = tostring(select(i, ...))
	end

	local prefix = GetCaller()
	local line = prefix .. " " .. table.concat(parts, " ")

    PushToBuffer(line)

    if IsInToolsMode() then
        print(line)
    end
end

--- Логируем через string.format; ВСЕГДА добавляем в буфер.
---@param fmt string
---@param ... any
function logger:Logf(fmt, ...)
    local ok, message = pcall(string.format, fmt, ...)
    local prefix = GetCaller()
    local line

    if ok then
        line = prefix .. " " .. message
    else
        line = prefix .. " [Logf format error] " .. tostring(message)
    end

    PushToBuffer(line)

    if IsInToolsMode() then
        print(line)
    end
end

--- Логируем таблицу в консоль, если находимся в InToolsMode
---@param table table
function logger:LogTable(table)
    if not IsInToolsMode() then
        return
    end
    DeepPrintTable(table)
end

---Логирует всё, не смотря на условие InToolsMode
---@param ... any
function logger:InternalLog(...)
    print(...)
end

---Лог ошибок; ВСЕГДА пишет в буфер с префиксом [ERROR].
---@param ... any
function logger:LogError(...)
    local parts = {}
    for i = 1, select("#", ...) do
        parts[#parts + 1] = tostring(select(i, ...))
    end

    local prefix = GetCaller()
    local line = prefix .. " [ERROR] " .. table.concat(parts, " ")

    PushToBuffer(line)

    if IsInToolsMode() then
        print(line)
    end
end

---Возвращает накопленные записи, склеенные через \n, и очищает буфер.
---Если буфер пуст — возвращает пустую строку.
---@return string
function logger:GetAndClear()
    if #_logBuffer == 0 then
        return ""
    end
    local result = table.concat(_logBuffer, "\n")
    _logBuffer = {}
    return result
end