--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


---@diagnostic disable: undefined-global
SYSTIMERS_VERSION = "1.08"

-- Binary Heap implementation copy-pasted from https://gist.github.com/starwing/1757443a1bd295653c39
-- BinaryHeap[1] always points to the element with the lowest "key" variable
-- API
-- BinaryHeap(key) - Creates a new BinaryHeap with key. The key is the name of the integer variable used to sort objects.
-- BinaryHeap:Insert - Inserts an object into BinaryHeap
-- BinaryHeap:Remove - Removes an object from BinaryHeap

BinaryHeap = BinaryHeap or {}
BinaryHeap.__index = BinaryHeap

function BinaryHeap:Insert(item)
	local index = #self + 1
	local key = self.key
	item.index = index
	self[index] = item
	while index > 1 do
		local parent = math.floor(index / 2)
		if self[parent][key] <= item[key] then
			break
		end
		self[index], self[parent] = self[parent], self[index]
		self[index].index = index
		self[parent].index = parent
		index = parent
	end
	return item
end

function BinaryHeap:Remove(item)
	local index = item.index
	if self[index] ~= item then
		return
	end
	local key = self.key
	local heap_size = #self
	if index == heap_size then
		self[heap_size] = nil
		return
	end
	self[index] = self[heap_size]
	self[index].index = index
	self[heap_size] = nil
	while true do
		local left = index * 2
		local right = left + 1
		if not self[left] then
			break
		end
		local newindex = right
		if self[index][key] >= self[left][key] then
			if not self[right] or self[left][key] < self[right][key] then
				newindex = left
			end
		elseif not self[right] or self[index][key] <= self[right][key] then
			break
		end
		self[index], self[newindex] = self[newindex], self[index]
		self[index].index = index
		self[newindex].index = newindex
		index = newindex
	end
end

function BinaryHeap:Find(name)
	for i, v in ipairs(self) do
		if v.name == name then
			return v
		end
	end
	return nil
end

setmetatable(BinaryHeap, {
	__call = function(self, key)
		return setmetatable({ key = key }, self)
	end,
})

function table.merge(input1, input2)
	for i, v in pairs(input2) do
		input1[i] = v
	end
	return input1
end

TIMERS_THINK = TIMERS_THINK or 0.01
local isLocal = IsInToolsMode()
local call = function(err)
	print("[SysTimers] error: " .. tostring(err))
	return tostring(err)
end
local SYSTIMER_ERROR_HANDLER = isLocal and debug.traceback or call

if _G.SysTimers == nil then
	print("[SysTimers] creating SysTimers")
	_G.SysTimers = {}
	setmetatable(SysTimers, {
		__call = function(t, ...)
			return t:CreateTimer(...)
		end,
	})
end

function SysTimers:start()
	self.started = true
	SysTimers = self
	self:InitializeTimers()
	self.nextTickCallbacks = {}

	local ent = SpawnEntityFromTableSynchronous("info_target", { targetname = "systimers_lua_thinker" })
	ent:SetThink("Think", self, "systimers", TIMERS_THINK)
end

function SysTimers:_ThinkBody()
	local nextTickCallbacks = table.merge({}, SysTimers.nextTickCallbacks)
	SysTimers.nextTickCallbacks = {}
	for _, cb in ipairs(nextTickCallbacks) do
		local status, result = xpcall(cb, SYSTIMER_ERROR_HANDLER)
		if not status then
			pcall(function()
				SysTimers:HandleEventError(result)
			end)
		end
	end

	if GameRules:State_Get() > DOTA_GAMERULES_STATE_POST_GAME then
		return
	end

	self:ExecuteTimers(self.realTimeHeap, Time())
	self:ExecuteTimers(self.gameTimeHeap, GameRules:GetGameTime())
end

function SysTimers:Think()
	-- 顶层 xpcall：确保任何 xpcall 外抛出的异常都不会让 Think 返回 nil，
	-- 从而避免 Source 引擎因 Thinker 返回 nil 而永久停止该 thinker。
	local ok, err = xpcall(function()
		SysTimers:_ThinkBody()
	end, SYSTIMER_ERROR_HANDLER)
	if not ok then
		pcall(function()
			SysTimers:HandleEventError(err)
		end)
	end
	return TIMERS_THINK
end

function SysTimers:ExecuteTimers(timerList, now)
	if not timerList[1] then
		return
	end

	local currentTimer = timerList[1]

	currentTimer.endTime = currentTimer.endTime or now
	if now >= currentTimer.endTime then
		timerList:Remove(currentTimer)
		SysTimers.runningTimer = currentTimer
		SysTimers.removeSelf = false

		local status, timerResult
		if currentTimer.context then
			status, timerResult = xpcall(function()
				return currentTimer.callback(currentTimer.context, currentTimer)
			end, SYSTIMER_ERROR_HANDLER)
		else
			status, timerResult = xpcall(function()
				return currentTimer.callback(currentTimer)
			end, SYSTIMER_ERROR_HANDLER)
		end

		SysTimers.runningTimer = nil

		if status then
			if timerResult and not SysTimers.removeSelf then
				-- Default behavior avoids catching up missed intervals in the same frame.
				-- Set useOldStyle=true to preserve the legacy "补跑" behavior.
				if currentTimer.useOldStyle then
					currentTimer.endTime = currentTimer.endTime + timerResult
				else
					currentTimer.endTime = now + timerResult
				end
				timerList:Insert(currentTimer)
			end
		else
			pcall(function()
				SysTimers:HandleEventError(timerResult)
			end)
		end
		self:ExecuteTimers(timerList, now)
	end
end

function SysTimers:HandleEventError(err)
	-- 统一转成可打印字符串（err 可能是 table/userdata，tostring 一般不会抛，但仍然防御性处理）
	local ok, text = pcall(tostring, err)
	if not ok or text == nil then
		text = "[unstringifiable error]"
	end

	-- 累计计数，便于控制台 / 全局检查上一次错误
	_G._AK_SYS_ERROR_COUNT = (_G._AK_SYS_ERROR_COUNT or 0) + 1
	_G._AK_LAST_SYS_ERROR = text

	-- 控制台打印（本地/线上都走一份 print，便于现场抓控制台）
	print("[SysTimers][error #" .. tostring(_G._AK_SYS_ERROR_COUNT) .. "] " .. text)

	-- 无效实体类可预见错误：只本地 print，不进云端 ERROR 日志
	local foreseeable = false
	pcall(function()
		if type(IsForeseeableInvalidEntityError) == "function" then
			foreseeable = IsForeseeableInvalidEntityError(text) == true
		end
	end)
	if foreseeable then
		return
	end

	-- 接入项目云日志通道（MyGameLogger 在 MyGameDebugLoading 阶段才被初始化，
	-- 早期 Tick 可能尚未就绪；用 pcall 包住，保证这里绝不抛错）
	pcall(function()
		if MyGameLogger ~= nil and type(MyGameLogger.error) == "function" then
			MyGameLogger:error("[SysTimers] " .. text, {
				count = _G._AK_SYS_ERROR_COUNT,
			})
		end
	end)
end

function SysTimers:CreateTimer(arg1, arg2, context)
	local timer

	if type(arg1) == "function" then
		if arg2 ~= nil then
			context = arg2
		end
		timer = { callback = arg1 }
	elseif type(arg1) == "table" then
		timer = arg1
	elseif type(arg1) == "number" then
		if arg1 ~= arg1 or arg1 == math.huge or arg1 == -math.huge then
			error("Invalid timer duration: " .. arg1)
			return
		end
		timer = { endTime = arg1, callback = arg2 }
	elseif type(arg1) == "string" then
		timer = arg2
		timer.name = arg1
	end
	if not timer.callback then
		print("Invalid timer created")
		return
	end

	local now = GameRules:GetGameTime()
	local timerHeap = self.gameTimeHeap
	if timer.useGameTime ~= nil and timer.useGameTime == false then
		now = Time()
		timerHeap = self.realTimeHeap
	end

	if timer.endTime == nil then
		timer.endTime = now
	else
		timer.endTime = now + timer.endTime
	end

	timer.context = context

	timerHeap:Insert(timer)

	if timer.name == nil then
		timer.name = DoUniqueString("systimer")
	end

	return timer.name
end

function SysTimers:NextTick(callback)
	table.insert(SysTimers.nextTickCallbacks, callback)
end

function SysTimers:RemoveTimer(name)
	local timerHeap = self.gameTimeHeap

	local timer = self.gameTimeHeap:Find(name)

	if timer ~= nil then
		timerHeap:Remove(timer)
	else
		timerHeap = self.realTimeHeap
		timer = self.realTimeHeap:Find(name)
		if timer ~= nil then
			timerHeap:Remove(timer)
		end
	end

	if SysTimers.runningTimer == timer then
		SysTimers.removeSelf = true
	end
end

function SysTimers:InitializeTimers()
	self.realTimeHeap = BinaryHeap("endTime")
	self.gameTimeHeap = BinaryHeap("endTime")
end

if not SysTimers.started then
	SysTimers:start()
end

GameRules.SysTimers = GameRules.SysTimers or SysTimers