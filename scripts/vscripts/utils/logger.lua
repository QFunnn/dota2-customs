--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


if logger == nil then
	_G.logger = class({})
end

local LOG_BUFFER_CAP = 1000

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
local _logCount = 0 -- сколько записей всего добавлено (для кольца не нужно, но удобно)

local _streamPlayers = {} ---@type table<PlayerID, boolean>

local function EmitLiveLine(entry)
	if next(_streamPlayers) == nil then
		return
	end
	for playerId, _ in pairs(_streamPlayers) do
		local player = PlayerResource:GetPlayer(playerId)
		if player then
			CustomGameEventManager:Send_ServerToPlayer(player, "debug_log_line", { line = entry })
		end
	end
end

local function PushToBuffer(entry)
	if #_logBuffer >= LOG_BUFFER_CAP then
		table.remove(_logBuffer, 1)
	end
	_logBuffer[#_logBuffer + 1] = entry
	_logCount = _logCount + 1

	EmitLiveLine(entry)
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

local FLUSH_SNAPSHOT_LINES = 300
local FLUSH_LINES_PER_TICK = 30

---@param playerId PlayerID
function logger:OpenLogWindowForPlayer(playerId)
	local player = PlayerResource:GetPlayer(playerId)
	if not player then
		return
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "debug_log_open", {})
	_streamPlayers[playerId] = true

	local snapshot = {}
	local startIdx = math.max(1, #_logBuffer - FLUSH_SNAPSHOT_LINES + 1)
	for i = startIdx, #_logBuffer do
		snapshot[#snapshot + 1] = _logBuffer[i]
	end

	-- порциями, чтобы не переполнить очередь событий Panorama
	local idx = 1
	Timers:CreateTimer(0, function()
		local hPlayer = PlayerResource:GetPlayer(playerId)
		if not hPlayer or not _streamPlayers[playerId] then
			return nil
		end
		for _ = 1, FLUSH_LINES_PER_TICK do
			if idx > #snapshot then
				return nil
			end
			CustomGameEventManager:Send_ServerToPlayer(hPlayer, "debug_log_line", { line = snapshot[idx] })
			idx = idx + 1
		end
		return 0.05
	end)
end

---@param playerId PlayerID
function logger:CloseLogStream(playerId)
	_streamPlayers[playerId] = nil
end