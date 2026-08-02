--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local ____exports = {}
local SLHeap = __TS__Class()
SLHeap.name = "SLHeap"
function SLHeap.prototype.____constructor(self, filter)
	self._heap_tree = {}
	self._length = 0
	self._top = 1
	self._Filter = filter
end
function SLHeap.prototype._BubbleUp(self, pos)
	local values = self._heap_tree
	while pos > self._top do
		local parent = math.floor(pos / 2)
		if not self:_Filter(values[pos], values[parent]) then
			break
		end
		self:_Swap(parent, pos)
		pos = parent
	end
end
function SLHeap.prototype._SinkDown(self, pos)
	local values = self._heap_tree
	local last = self._length
	while true do
		local min = pos
		local child = 2 * pos
		do
			local index = child
			while index <= child + 1 do
				if index <= last and self:_Filter(values[index], values[min]) then
					min = index
				end
				index = index + 1
			end
		end
		if min == pos then
			break
		end
		self:_Swap(pos, min)
		pos = min
	end
end
function SLHeap.prototype._Swap(self, i, j)
	local current, target = self._heap_tree[i], self._heap_tree[j]
	self._heap_tree[j] = current
	self._heap_tree[i] = target
end
function SLHeap.prototype._Erase(self, pos)
	self._heap_tree[pos] = nil
	self._length = self._length - 1
end
function SLHeap.prototype._Filter(self, a, b)
	return a < b
end
function SLHeap.prototype.Insert(self, value)
	assert(value ~= nil, "value is undefined")
	self._length = self._length + 1
	local pos = self._length
	self._heap_tree[pos] = value
	self:_BubbleUp(pos)
end
function SLHeap.prototype.Peek(self)
	return self._heap_tree[self._top]
end
function SLHeap.prototype.Size(self)
	return self._length
end
function SLHeap.prototype.Pop(self)
	if self._heap_tree[self._top] ~= nil then
		return self:Remove(self._top)
	end
end
function SLHeap.prototype.Remove(self, pos)
	if pos < 1 then
		return
	end
	local last = self._length
	if pos < last then
		local value = self._heap_tree[pos]
		self:_Swap(pos, last)
		self:_Erase(last)
		self:_BubbleUp(pos)
		self:_SinkDown(pos)
		return value
	elseif pos == last then
		local value = self._heap_tree[pos]
		self:_Erase(pos)
		return value
	else
		return
	end
end
function SLHeap.prototype.Info(self, msg_func)
	local result = ""
	for index in pairs(self._heap_tree) do
		local ____msg_func_0
		if msg_func then
			____msg_func_0 = msg_func(nil, self._heap_tree[index])
		else
			____msg_func_0 = self._heap_tree[index]
		end
		result = result .. ((index .. ":") .. tostring(____msg_func_0)) .. "\n"
	end
	return result
end
____exports.SLTimer = __TS__Class()
local SLTimer = ____exports.SLTimer
SLTimer.name = "SLTimer"
function SLTimer.prototype.____constructor(self, is_system_timer)
	self._think_min_interval = 0.033334
	self._now_time = 0
	self._timer_id_map = {}
	self._timer_heap = __TS__New(SLHeap, function(____, t1, t2)
		if t1.end_time < t2.end_time then
			return true
		elseif t1.end_time == t2.end_time then
			return t1.id < t2.id
		else
			return false
		end
	end)
	self._count = 1
	self._is_system_timer = is_system_timer
	self._timer_ent = SpawnEntityFromTableSynchronous("info_target", { targetname = DoUniqueString("SLTimer") })
	self._think_return_time = is_system_timer and 0.01 or self._think_min_interval
	self._timer_ent:SetThink("_Think", self, self.constructor.name, 0)
end
function SLTimer.prototype.CreateTimer(self, p1, p2)
	local delay
	local callback
	if type(p1) == "number" then
		delay = p1
		callback = p2
	else
		delay = 0
		callback = p1
	end
	local timer_delay = self:_GetMinDelay(delay)
	local timer = {
		end_time = self._now_time + timer_delay,
		call_back = callback,
		id = self:_GenerateTimerId(),
		is_remove = false,
	}
	assert(timer.call_back, "Invalid timer created")
	self._timer_id_map[timer.id] = timer
	self._timer_heap:Insert(timer)
	return timer.id
end
function SLTimer.prototype.RemoveTimer(self, timer_id)
	if not timer_id then
		return
	end
	local timer = self._timer_id_map[timer_id]
	if timer then
		self._timer_id_map[timer_id] = nil
		timer.is_remove = true
		if self._running_timer == timer then
			self._remove_self = true
		end
	end
end
function SLTimer.prototype.RemoveTimers_All(self)
	for ____, timer_id in ipairs(__TS__ObjectKeys(self._timer_id_map)) do
		self:RemoveTimer(tonumber(timer_id))
	end
end
function SLTimer.prototype.IsValid(self, timer_id)
	if timer_id and self._timer_id_map[timer_id] ~= nil and self._timer_id_map[timer_id].is_remove ~= true then
		return true
	else
		return false
	end
end
function SLTimer.prototype.Size(self)
	return #__TS__ObjectKeys(self._timer_id_map)
end
function SLTimer.prototype._GetMinDelay(self, delay)
	return math.max(delay, self._think_min_interval)
end
function SLTimer.prototype._GenerateTimerId(self)
	local id = self._count
	self._count = self._count + 1
	return id
end
function SLTimer.prototype._Think(self)
	self:_UpdateNowTime()
	local now = self._now_time
	local current_timer = self._timer_heap:Peek()
	while current_timer and now >= current_timer.end_time do
		self._timer_heap:Pop()
		self._running_timer = current_timer
		self._remove_self = false
		if current_timer.is_remove ~= true then
			local status, result = xpcall(current_timer.call_back, function(err)
				SLError(nil, err)
			end)
			self._running_timer = nil
			if status then
				if result and not self._remove_self then
					current_timer.end_time = current_timer.end_time + self:_GetMinDelay(result)
					self._timer_heap:Insert(current_timer)
				else
					self:RemoveTimer(current_timer.id)
				end
			else
				self:_HandleError(result)
				self:RemoveTimer(current_timer.id)
			end
		end
		current_timer = self._timer_heap:Peek()
	end
	return self._think_return_time
end
function SLTimer.prototype._UpdateNowTime(self)
	self._now_time = self._now_time + self._think_min_interval
end
function SLTimer.prototype._HandleError(self, err)
	if IsInToolsMode() then
		print("[error on timer] : ", err)
	end
	if self._on_cache_error then
		self:_on_cache_error(err)
	end
end
function SLTimer.prototype.RegisterOnCacheError(self, on_catch)
	self._on_cache_error = on_catch
end
_G.Timers = _G.Timers or __TS__New(____exports.SLTimer)
_G.SysTimer = _G.SysTimer or __TS__New(____exports.SLTimer, true)
return ____exports