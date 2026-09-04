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
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ParseInt = ____lualib.__TS__ParseInt
local ____exports = {}
local ____flame_graph_profiler = require("utils.performance.flame_graph_profiler")
local GetFlameGraphProfiler = ____flame_graph_profiler.GetFlameGraphProfiler
local ____event_callback_profiler = require("utils.performance.event_callback_profiler")
local GetEventCallbackProfiler = ____event_callback_profiler.GetEventCallbackProfiler
local ____Sync = require("modules.Sync")
local SyncGameEvent = ____Sync.SyncGameEvent
local SyncNetTable = ____Sync.SyncNetTable
local ____OnlineDebugAccess = require("modules.OnlineDebugAccess")
local IsTrustedOnlineDebugger = ____OnlineDebugAccess.IsTrustedOnlineDebugger
____exports.FlameGraphCommands = __TS__Class()
local FlameGraphCommands = ____exports.FlameGraphCommands
FlameGraphCommands.name = "FlameGraphCommands"
function FlameGraphCommands.prototype.____constructor(self)
	self.profiler = GetFlameGraphProfiler(nil)
	self.recordingState = 0
	self.recordingTime = 0
	self.timerHandle = nil
	self:registerCommands()
	self:registerUIEvents()
	self:updateDebugState()
end
function FlameGraphCommands.getInstance(self)
	if not ____exports.FlameGraphCommands.instance then
		____exports.FlameGraphCommands.instance = __TS__New(____exports.FlameGraphCommands)
	end
	return ____exports.FlameGraphCommands.instance
end
function FlameGraphCommands.prototype.registerCommands(self)
	ListenToGameEvent("player_chat", function(event)
		return self:handleChatCommand(event)
	end, nil)
	print("[FlameGraphCommands] 已注册性能分析命令")
end
function FlameGraphCommands.prototype.registerUIEvents(self)
	CustomGameEventManager:RegisterListener("performance_start", function(_)
		return self:handleStart()
	end)
	CustomGameEventManager:RegisterListener("performance_stop", function(_)
		return self:handleStop()
	end)
	CustomGameEventManager:RegisterListener("performance_paused", function(_)
		return self:handlePaused()
	end)
	MyGameCustomGameEvent:RegisterAuthenticatedC2SEvent(
		"event_callback_profiler_toggle",
		function(____, playerId, event)
			if not IsTrustedOnlineDebugger(nil, playerId) then
				return
			end
			self:handleEventCallbackProfilerToggle(event)
		end
	)
	MyGameCustomGameEvent:RegisterAuthenticatedC2SEvent("event_callback_profiler_clear", function(____, playerId)
		if not IsTrustedOnlineDebugger(nil, playerId) then
			return
		end
		self:handleEventCallbackProfilerClear()
	end)
	MyGameCustomGameEvent:RegisterAuthenticatedC2SEvent(
		"event_callback_profiler_set_transport",
		function(____, playerId, event)
			if not IsTrustedOnlineDebugger(nil, playerId) then
				return
			end
			self:handleEventCallbackProfilerSetTransport(event.transport)
		end
	)
	print("[FlameGraphCommands] 已注册性能分析UI事件")
end
function FlameGraphCommands.prototype.updateDebugState(self)
	SyncNetTable:SetTableValue(
		"performance_debug",
		"debug_state",
		{ state = self.recordingState, time = self.recordingTime }
	)
end
function FlameGraphCommands.prototype.handleStart(self)
	if self.recordingState == 0 then
		print("开始")
		self:startRecording()
	end
end
function FlameGraphCommands.prototype.handleStop(self)
	if self.recordingState == 0 then
		return
	end
	self:stopRecording()
end
function FlameGraphCommands.prototype.handlePaused(self)
	if self.recordingState == 1 then
		self:pauseRecording()
	elseif self.recordingState == 2 then
		self:resumeRecording()
	end
end
function FlameGraphCommands.prototype.handleEventCallbackProfilerToggle(self, event)
	local raw = event and event.enabled
	local eventCallbackProfiler = GetEventCallbackProfiler(nil)
	if raw == nil or raw == nil then
		eventCallbackProfiler:Toggle()
		return
	end
	eventCallbackProfiler:SetEnabled(raw == 1 or raw == "1")
end
function FlameGraphCommands.prototype.handleEventCallbackProfilerClear(self)
	GetEventCallbackProfiler(nil):Clear()
end
function FlameGraphCommands.prototype.handleEventCallbackProfilerSetTransport(self, transport)
	GetEventCallbackProfiler(nil):SetSyncTransport(transport)
end
function FlameGraphCommands.prototype.startRecording(self)
	self.recordingState = 1
	self.recordingTime = 0
	self.profiler:startRecording(0)
	self.timerHandle = Timers:CreateTimer(1, function()
		if self.recordingState == 1 then
			self.recordingTime = self.recordingTime + 1
			self:updateDebugState()
		end
		return self.recordingState ~= 0 and 1 or nil
	end)
	self:updateDebugState()
	print("[FlameGraphProfiler] 开始记录性能数据")
end
function FlameGraphCommands.prototype.pauseRecording(self)
	self.recordingState = 2
	self.profiler:pauseRecording()
	self:updateDebugState()
	print("[FlameGraphProfiler] 暂停记录性能数据")
end
function FlameGraphCommands.prototype.resumeRecording(self)
	self.recordingState = 1
	self.profiler:resumeRecording()
	self:updateDebugState()
	print("[FlameGraphProfiler] 恢复记录性能数据")
end
function FlameGraphCommands.prototype.stopRecording(self)
	self.recordingState = 0
	self.profiler:stopRecording()
	if self.timerHandle then
		Timers:RemoveTimer(self.timerHandle)
		self.timerHandle = nil
	end
	self:updateDebugState()
	print("[FlameGraphProfiler] 停止记录性能数据")
end
function FlameGraphCommands.prototype.handleChatCommand(self, event)
	local text = event.text
	local playerID = event.playerid
	if not IsInToolsMode() and playerID ~= 0 then
		return
	end
	if __TS__StringStartsWith(text, "-flamegraph") or __TS__StringStartsWith(text, "-fg") then
		local args = __TS__StringSplit(text, " ")
		local subCommand = args[2]
		repeat
			local ____switch39 = subCommand
			local duration
			local ____cond39 = ____switch39 == "start"
			if ____cond39 then
				duration = __TS__ParseInt(args[3] or "0")
				self.profiler:startRecording(duration)
				local ____self_sendMessageToPlayer_3 = self.sendMessageToPlayer
				local ____temp_2
				if duration > 0 then
					____temp_2 = ("，持续" .. tostring(duration)) .. "秒"
				else
					____temp_2 = ""
				end
				____self_sendMessageToPlayer_3(self, playerID, "开始记录性能数据" .. ____temp_2)
				break
			end
			____cond39 = ____cond39 or ____switch39 == "stop"
			if ____cond39 then
				self.profiler:stopRecording()
				self:sendMessageToPlayer(playerID, "停止记录性能数据")
				break
			end
			____cond39 = ____cond39 or ____switch39 == "event"
			if ____cond39 then
				GetEventCallbackProfiler(nil):Toggle()
				self:sendMessageToPlayer(playerID, "切换事件回调性能记录")
				break
			end
			____cond39 = ____cond39 or ____switch39 == "dev"
			if ____cond39 then
				self:startRecording()
				self:sendMessageToPlayer(playerID, "开始持续记录性能数据")
			end
			____cond39 = ____cond39 or ____switch39 == "help"
			if ____cond39 then
				self:sendHelpMessage(playerID)
			end
			do
				self:toggleFlameGraph(playerID)
				break
			end
		until true
	end
end
function FlameGraphCommands.prototype.toggleFlameGraph(self, playerID)
	local player = PlayerResource:GetPlayer(playerID)
	if not player then
		return
	end
	SyncGameEvent:Send_ServerToPlayer(player, "performance_toggle_flamegraph", {})
end
function FlameGraphCommands.prototype.sendHelpMessage(self, playerID)
	local message = (
		(
			("火焰图性能分析命令:\n" .. "-flamegraph start [持续时间] - 开始记录性能数据\n")
			.. "-flamegraph stop - 停止记录性能数据\n"
		) .. "-flamegraph export - 导出火焰图数据\n"
	) .. "-flamegraph help - 显示帮助信息"
	self:sendMessageToPlayer(playerID, message)
end
function FlameGraphCommands.prototype.sendMessageToPlayer(self, playerID, message)
	local player = PlayerResource:GetPlayer(playerID)
	if player then
		SyncGameEvent:Send_ServerToPlayer(player, "game_msg_tip", { msg = message })
	end
end
function ____exports.InitFlameGraphCommands(self)
	____exports.FlameGraphCommands:getInstance()
end
return ____exports