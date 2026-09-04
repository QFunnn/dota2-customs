--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__New = ____lualib.__TS__New
local __TS__Delete = ____lualib.__TS__Delete
local __TS__ArraySort = ____lualib.__TS__ArraySort
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local ____exports = {}
local ____Sync = require("modules.Sync")
local SyncNetTable = ____Sync.SyncNetTable
local getTime = GetSystemTimeMS
____exports.EventCallbackProfilerState = { enabled = false }
____exports.EventCallbackProfiler = __TS__Class()
local EventCallbackProfiler = ____exports.EventCallbackProfiler
EventCallbackProfiler.name = "EventCallbackProfiler"
function EventCallbackProfiler.prototype.____constructor(self)
	self.enabled = false
	self.startedAt = 0
	self.updatedAt = 0
	self.totalCalls = 0
	self.totalTime = 0
	self.syncTransport = "native"
	self.syncTimer = nil
	self.records = {}
	self.syncInterval = 1
	self.maxEvents = 80
	self.maxCallbacksPerEvent = 80
	self.maxTopCallbacks = 120
end
function EventCallbackProfiler.getInstance(self)
	if not ____exports.EventCallbackProfiler.instance then
		____exports.EventCallbackProfiler.instance = __TS__New(____exports.EventCallbackProfiler)
	end
	return ____exports.EventCallbackProfiler.instance
end
function EventCallbackProfiler.prototype.IsEnabled(self)
	return self.enabled
end
function EventCallbackProfiler.prototype.SetEnabled(self, enabled)
	____exports.EventCallbackProfilerState.enabled = enabled
	if self.enabled == enabled then
		self:Sync()
		return
	end
	self.enabled = enabled
	if enabled then
		self:Clear(false)
		self.startedAt = getTime()
		self:StartSyncTimer()
		print("[EventCallbackProfiler] 已开始记录事件回调耗时")
	else
		self:StopSyncTimer()
		print("[EventCallbackProfiler] 已停止记录事件回调耗时")
	end
	self:Sync()
end
function EventCallbackProfiler.prototype.Toggle(self)
	self:SetEnabled(not self.enabled)
end
function EventCallbackProfiler.prototype.GetSyncTransport(self)
	return self.syncTransport
end
function EventCallbackProfiler.prototype.SetSyncTransport(self, transport)
	if transport ~= "native" and transport ~= "xnet" then
		return
	end
	if self.syncTransport == transport then
		self:Sync()
		return
	end
	self.syncTransport = transport
	self:Sync(true)
end
function EventCallbackProfiler.prototype.Clear(self, sync)
	if sync == nil then
		sync = true
	end
	for key in pairs(self.records) do
		__TS__Delete(self.records, key)
	end
	self.totalCalls = 0
	self.totalTime = 0
	local ____table_enabled_0
	if self.enabled then
		____table_enabled_0 = getTime()
	else
		____table_enabled_0 = 0
	end
	self.startedAt = ____table_enabled_0
	self.updatedAt = getTime()
	if sync then
		self:Sync(true)
	end
end
function EventCallbackProfiler.prototype.RecordCallback(
	self,
	eventName,
	scope,
	scopeKey,
	sourceName,
	context,
	priority,
	sequence,
	callback
)
	if not self.enabled then
		callback(nil)
		return
	end
	local start = getTime()
	do
		pcall(function()
			callback(nil)
		end)
		do
			local duration = math.max(0, getTime() - start)
			self:RecordDuration(eventName, scope, scopeKey, sourceName, context, priority, sequence, duration)
		end
	end
end
function EventCallbackProfiler.prototype.RecordDuration(
	self,
	eventName,
	scope,
	scopeKey,
	sourceName,
	context,
	priority,
	sequence,
	duration
)
	local source = sourceName or (scope .. ":") .. scopeKey
	local key = (((((((((eventName .. "|") .. scope) .. "|") .. scopeKey) .. "|") .. source) .. "|") .. context) .. "|")
		.. tostring(sequence)
	local record = self.records[key]
	if not record then
		record = {
			key = key,
			eventName = eventName,
			scope = scope,
			scopeKey = scopeKey,
			sourceName = source,
			context = context,
			priority = priority,
			sequence = sequence,
			calls = 0,
			totalTime = 0,
			peakTime = 0,
			lastTime = 0,
		}
		self.records[key] = record
	end
	record.calls = record.calls + 1
	record.totalTime = record.totalTime + duration
	record.peakTime = math.max(record.peakTime, duration)
	record.lastTime = duration
	self.totalCalls = self.totalCalls + 1
	self.totalTime = self.totalTime + duration
	self.updatedAt = getTime()
end
function EventCallbackProfiler.prototype.ToSummary(self, record)
	local ____record_key_2 = record.key
	local ____record_eventName_3 = record.eventName
	local ____record_scope_4 = record.scope
	local ____record_scopeKey_5 = record.scopeKey
	local ____record_sourceName_6 = record.sourceName
	local ____record_context_7 = record.context
	local ____record_priority_8 = record.priority
	local ____record_sequence_9 = record.sequence
	local ____record_calls_10 = record.calls
	local ____math_floor_result_11 = math.floor(record.totalTime + 0.5)
	local ____math_floor_result_12 = math.floor(record.peakTime + 0.5)
	local ____temp_1
	if record.calls > 0 then
		____temp_1 = record.totalTime / record.calls
	else
		____temp_1 = 0
	end
	return {
		key = ____record_key_2,
		eventName = ____record_eventName_3,
		scope = ____record_scope_4,
		scopeKey = ____record_scopeKey_5,
		sourceName = ____record_sourceName_6,
		context = ____record_context_7,
		priority = ____record_priority_8,
		sequence = ____record_sequence_9,
		calls = ____record_calls_10,
		totalTime = ____math_floor_result_11,
		peakTime = ____math_floor_result_12,
		avgTime = ____temp_1,
		lastTime = math.floor(record.lastTime + 0.5),
	}
end
function EventCallbackProfiler.prototype.SortCallbacks(self, callbacks)
	__TS__ArraySort(callbacks, function(____, a, b)
		if a.totalTime ~= b.totalTime then
			return b.totalTime - a.totalTime
		end
		if a.peakTime ~= b.peakTime then
			return b.peakTime - a.peakTime
		end
		return b.calls - a.calls
	end)
	return callbacks
end
function EventCallbackProfiler.prototype.BuildSnapshot(self, transport)
	if transport == nil then
		transport = self.syncTransport
	end
	local eventMap = {}
	local topCallbacks = {}
	for key in pairs(self.records) do
		local summary = self:ToSummary(self.records[key])
		topCallbacks[#topCallbacks + 1] = summary
		local eventSummary = eventMap[summary.eventName]
		if not eventSummary then
			eventSummary = {
				eventName = summary.eventName,
				calls = 0,
				totalTime = 0,
				peakTime = 0,
				avgTime = 0,
				callbacks = {},
			}
			eventMap[summary.eventName] = eventSummary
		end
		eventSummary.calls = eventSummary.calls + summary.calls
		eventSummary.totalTime = eventSummary.totalTime + summary.totalTime
		eventSummary.peakTime = math.max(eventSummary.peakTime, summary.peakTime)
		local ____eventSummary_callbacks_13 = eventSummary.callbacks
		____eventSummary_callbacks_13[#____eventSummary_callbacks_13 + 1] = summary
	end
	local events = {}
	for eventName in pairs(eventMap) do
		local eventSummary = eventMap[eventName]
		local ____temp_14
		if eventSummary.calls > 0 then
			____temp_14 = eventSummary.totalTime / eventSummary.calls
		else
			____temp_14 = 0
		end
		eventSummary.avgTime = ____temp_14
		eventSummary.callbacks =
			__TS__ArraySlice(self:SortCallbacks(eventSummary.callbacks), 0, self.maxCallbacksPerEvent)
		events[#events + 1] = eventSummary
	end
	__TS__ArraySort(events, function(____, a, b)
		if a.totalTime ~= b.totalTime then
			return b.totalTime - a.totalTime
		end
		if a.peakTime ~= b.peakTime then
			return b.peakTime - a.peakTime
		end
		return b.calls - a.calls
	end)
	local now = getTime()
	local ____transport_16 = transport
	local ____self_enabled_17 = self.enabled
	local ____self_startedAt_18 = self.startedAt
	local ____temp_19 = self.updatedAt or now
	local ____temp_15
	if self.startedAt > 0 then
		____temp_15 = math.max(0, now - self.startedAt)
	else
		____temp_15 = 0
	end
	return {
		transport = ____transport_16,
		enabled = ____self_enabled_17,
		startedAt = ____self_startedAt_18,
		updatedAt = ____temp_19,
		elapsedTime = ____temp_15,
		totalCalls = self.totalCalls,
		totalTime = math.floor(self.totalTime + 0.5),
		eventCount = #events,
		callbackCount = #topCallbacks,
		events = __TS__ArraySlice(events, 0, self.maxEvents),
		topCallbacks = __TS__ArraySlice(self:SortCallbacks(topCallbacks), 0, self.maxTopCallbacks),
	}
end
function EventCallbackProfiler.prototype.Sync(self, clearInactiveTransport)
	if clearInactiveTransport == nil then
		clearInactiveTransport = false
	end
	local snapshot = self:BuildSnapshot()
	local state = {
		enabled = self.enabled,
		startedAt = self.startedAt,
		updatedAt = self.updatedAt,
		totalCalls = self.totalCalls,
		totalTime = math.floor(self.totalTime + 0.5),
		transport = self.syncTransport,
	}
	SyncNetTable:SetTableValue("performance_debug", "event_callback_state", state)
	if self.syncTransport == "native" then
		SyncNetTable:SetTableValue("performance_debug", "event_callback_data", snapshot)
		if clearInactiveTransport then
			GameRules.XNetTable:SetTableValue("performance_debug", "event_callback_data", {})
		end
		return
	end
	GameRules.XNetTable:SetTableValue("performance_debug", "event_callback_data", snapshot)
	if clearInactiveTransport then
		SyncNetTable:SetTableValue("performance_debug", "event_callback_data", {})
	end
end
function EventCallbackProfiler.prototype.StartSyncTimer(self)
	self:StopSyncTimer()
	self.syncTimer = Timers:CreateTimer(self.syncInterval, function()
		if not self.enabled then
			return nil
		end
		self:Sync()
		return self.syncInterval
	end)
end
function EventCallbackProfiler.prototype.StopSyncTimer(self)
	if self.syncTimer then
		Timers:RemoveTimer(self.syncTimer)
		self.syncTimer = nil
	end
end
function ____exports.GetEventCallbackProfiler(self)
	return ____exports.EventCallbackProfiler:getInstance()
end
return ____exports