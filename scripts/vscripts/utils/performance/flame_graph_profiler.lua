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
local __TS__ArrayUnshift = ____lualib.__TS__ArrayUnshift
local __TS__ArraySplice = ____lualib.__TS__ArraySplice
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local ____exports = {}
local Test
local ____Sync = require("modules.Sync")
local SyncNetTable = ____Sync.SyncNetTable
--- 火焰图性能分析模块
-- 用于收集函数调用信息并生成火焰图数据
-- by: 三村
-- 日期: 2025-04-15
-- version: 1.0.0
-- //@example
-- 示例用法：
-- //@ProfileClass
-- class Myclass{}
local get_time = GetSystemTimeMS
local sync_time = 5
____exports.FlameGraphProfiler = __TS__Class()
local FlameGraphProfiler = ____exports.FlameGraphProfiler
FlameGraphProfiler.name = "FlameGraphProfiler"
function FlameGraphProfiler.prototype.____constructor(self)
	self.isRecording = false
	self.startTime = 0
	self.endTime = 0
	self.maxNode = 1
	self.spikeCalls = {}
	self.spikeCallLimit = 5
	self.rootNode = { name = "root", startTime = 0, children = {}, calls = 1 }
	self.currentNode = self.rootNode
	self.testObj = __TS__New(Test)
end
function FlameGraphProfiler.getInstance(self)
	if not ____exports.FlameGraphProfiler.instance then
		____exports.FlameGraphProfiler.instance = __TS__New(____exports.FlameGraphProfiler)
	end
	return ____exports.FlameGraphProfiler.instance
end
function FlameGraphProfiler.prototype.getAverageOffset(self)
	local test_node = self.rootNode.children[1]
	test_node.totalTime = test_node.totalTime or 0
	return test_node.totalTime / test_node.calls or 0
end
function FlameGraphProfiler.prototype.executeTimeOffset(self)
	do
		local i = 0
		while i < 10 do
			self.testObj:time_offet_test()
			i = i + 1
		end
	end
	Timers:CreateTimer(0.1, function()
		if not self.isRecording then
			return
		end
		do
			local i = 0
			while i < 10 do
				self.testObj:time_offet_test()
				i = i + 1
			end
		end
		return 0.1
	end)
end
function FlameGraphProfiler.prototype.startRecording(self, duration)
	if duration == nil then
		duration = 0
	end
	print("[FlameGraphProfiler] 开始记录性能数据:", duration)
	if self.isRecording then
		print("[FlameGraphProfiler] 已经在记录中，请先停止当前记录")
		return
	end
	self.rootNode = {
		name = "root",
		startTime = get_time(),
		children = {},
		calls = 1,
	}
	self.currentNode = self.rootNode
	self.startTime = get_time()
	self.spikeCalls = {}
	self.isRecording = true
	self:executeTimeOffset()
	local ____print_1 = print
	local ____temp_0
	if duration > 0 then
		____temp_0 = ("，持续" .. tostring(duration)) .. "秒"
	else
		____temp_0 = ""
	end
	____print_1("[FlameGraphProfiler] 开始记录性能数据" .. ____temp_0)
	if duration > 0 then
		self.Timerid = Timers:CreateTimer(duration, function()
			self:stopRecording()
			return nil
		end)
	else
		self.Timerid = Timers:CreateTimer(sync_time, function()
			if not self.isRecording then
				return
			end
			local rootNodeChildren = self:transformNode(self.rootNode)
			rootNodeChildren.totalTime = self:getTotalTime(rootNodeChildren)
			rootNodeChildren.rate =
				math.floor(rootNodeChildren.totalTime / (get_time() - self.startTime) * 10000 * self.maxNode + 0.5)
			rootNodeChildren.spikeCalls = self:getSpikeCalls()
			self:syncToNetTable(rootNodeChildren)
			print("[FlameGraphProfiler] 性能诊断运行中..")
			return sync_time
		end)
	end
end
function FlameGraphProfiler.prototype.stopRecording(self)
	if self.Timerid then
		Timers:RemoveTimer(self.Timerid)
	end
	self.Timerid = nil
	self.isRecording = false
	self.endTime = get_time()
	self.rootNode.endTime = self.endTime
	self.rootNode.totalTime = self.endTime - self.rootNode.startTime
	local rootNodeChildren = self:transformNode(self.rootNode)
	rootNodeChildren.totalTime = self:getTotalTime(rootNodeChildren)
	rootNodeChildren.rate =
		math.floor(rootNodeChildren.totalTime / (self.endTime - self.startTime) * 10000 * self.maxNode + 0.5)
	rootNodeChildren.spikeCalls = self:getSpikeCalls()
	DeepPrintTable(rootNodeChildren)
	self:printSpikeCalls()
	self:syncToNetTable(rootNodeChildren)
	print(
		("[FlameGraphProfiler] 记录已停止，总时间: " .. tostring(self.endTime - self.startTime))
			.. "毫秒,P键打开火焰图"
	)
end
function FlameGraphProfiler.prototype.pauseRecording(self)
	if not self.isRecording then
		print("[FlameGraphProfiler] 没有正在进行的记录")
		return
	end
	self.isRecording = false
end
function FlameGraphProfiler.prototype.resumeRecording(self)
	if self.isRecording then
		print("[FlameGraphProfiler] 已经在记录中")
		return
	end
	self.isRecording = true
	print("[FlameGraphProfiler] 已恢复记录性能数据")
end
function FlameGraphProfiler.prototype.transformNode(self, node)
	local result = {
		name = node.name,
		totalTime = math.floor((node.totalTime or 0) + 0.5),
		peakTime = math.floor((node.peakTime or 0) + 0.5),
		calls = node.calls,
	}
	if #node.children == 0 then
		return result
	end
	result.children = {}
	for ____, child in ipairs(node.children) do
		local ____result_children_2 = result.children
		____result_children_2[#____result_children_2 + 1] = self:transformNode(child)
	end
	return result
end
function FlameGraphProfiler.prototype.getTotalTime(self, node)
	local totalTime = 0
	if node.children then
		for ____, child in ipairs(node.children) do
			totalTime = totalTime + child.totalTime
		end
	end
	return totalTime
end
function FlameGraphProfiler.prototype.getNodePath(self, node)
	local path = {}
	local currentNode = node
	while currentNode and currentNode ~= self.rootNode do
		__TS__ArrayUnshift(path, currentNode.name)
		currentNode = currentNode.parent
	end
	return table.concat(path, " -> ")
end
function FlameGraphProfiler.prototype.recordSpikeCall(self, node, totalTime, endTime)
	local spikeCall = {
		name = node.name,
		path = self:getNodePath(node),
		totalTime = math.floor(totalTime + 0.5),
		startTime = math.floor(node.startTime + 0.5),
		endTime = math.floor(endTime + 0.5),
	}
	local insertIndex = #self.spikeCalls
	do
		local i = 0
		while i < #self.spikeCalls do
			if spikeCall.totalTime > self.spikeCalls[i + 1].totalTime then
				insertIndex = i
				break
			end
			i = i + 1
		end
	end
	if insertIndex >= self.spikeCallLimit then
		return
	end
	__TS__ArraySplice(self.spikeCalls, insertIndex, 0, spikeCall)
	if #self.spikeCalls > self.spikeCallLimit then
		table.remove(self.spikeCalls)
	end
end
function FlameGraphProfiler.prototype.getSpikeCalls(self)
	local result = {}
	for ____, spikeCall in ipairs(self.spikeCalls) do
		result[#result + 1] = {
			name = spikeCall.name,
			path = spikeCall.path,
			totalTime = spikeCall.totalTime,
			startTime = spikeCall.startTime,
			endTime = spikeCall.endTime,
		}
	end
	return result
end
function FlameGraphProfiler.prototype.printSpikeCalls(self)
	if #self.spikeCalls == 0 then
		print("[FlameGraphProfiler] 未记录到尖刺调用")
		return
	end
	print(("[FlameGraphProfiler] 单次耗时前" .. tostring(#self.spikeCalls)) .. "个尖刺调用:")
	do
		local i = 0
		while i < #self.spikeCalls do
			local spikeCall = self.spikeCalls[i + 1]
			print(
				(((("[FlameGraphProfiler] #" .. tostring(i + 1)) .. " ") .. tostring(spikeCall.totalTime)) .. "毫秒 ")
					.. spikeCall.path
			)
			i = i + 1
		end
	end
end
function FlameGraphProfiler.prototype.enterFunction(self, functionName)
	if not self.isRecording then
		return
	end
	local existingNode
	for ____, child in ipairs(self.currentNode.children) do
		if child.name == functionName then
			existingNode = child
			break
		end
	end
	if existingNode then
		existingNode.calls = existingNode.calls + 1
		existingNode.parent = self.currentNode
		existingNode.startTime = get_time()
		self.currentNode = existingNode
	else
		local newNode = {
			name = functionName,
			startTime = get_time(),
			children = {},
			parent = self.currentNode,
			calls = 1,
		}
		local ____self_currentNode_children_3 = self.currentNode.children
		____self_currentNode_children_3[#____self_currentNode_children_3 + 1] = newNode
		self.currentNode = newNode
	end
end
function FlameGraphProfiler.prototype.exitFunction(self)
	if not self.isRecording or self.currentNode == self.rootNode then
		return
	end
	local now = get_time()
	local endTime = now - self:getAverageOffset()
	local callTime = math.max(0.00001, endTime - self.currentNode.startTime)
	self.currentNode.endTime = self.currentNode.startTime + callTime
	self.currentNode.totalTime = (self.currentNode.totalTime or 0) + callTime
	self.currentNode.peakTime = math.max(self.currentNode.peakTime or 0, callTime)
	self:recordSpikeCall(self.currentNode, callTime, self.currentNode.endTime)
	if self.currentNode.parent then
		self.currentNode = self.currentNode.parent
	end
end
function FlameGraphProfiler.profile(self, name)
	return function(self, target, propertyKey, descriptor)
		local originalMethod = descriptor.value
		local profilerName = name or (tostring(target.constructor.name) .. ".") .. propertyKey
		descriptor.value = function(self, ...)
			local args = { ... }
			local argCount = select("#", ...)
			local profiler = ____exports.FlameGraphProfiler:getInstance()
			profiler:enterFunction(profilerName)
			local result
			do
				local function ____catch(____error)
					print("函数执行出错:", ____error)
					error(____error, 0)
				end
				local ____try, ____hasReturned = pcall(function()
					result = originalMethod(self, unpack(args, 1, argCount))
				end)
				if not ____try then
					____catch(____hasReturned)
				end
				do
					profiler:exitFunction()
				end
			end
			return result
		end
		print("[FlameGraphProfiler] 装饰器已应用于:", profilerName)
		return descriptor
	end
end
function FlameGraphProfiler.profileClass(self, classInstance, prefix)
	if prefix == nil then
		prefix = ""
	end
	local className = classInstance.name
	for name in pairs(classInstance.prototype) do
		do
			if type(classInstance.prototype[name]) ~= "function" or __TS__StringStartsWith(name, "__") then
				goto __continue62
			end
			local originalMethod = classInstance.prototype[name]
			local fullName = (tostring(className) .. ".") .. name
			classInstance.prototype[name] = function(self, ...)
				local args = { ... }
				local argCount = select("#", ...)
				local profiler = ____exports.FlameGraphProfiler:getInstance()
				profiler:enterFunction(fullName)
				local result
				do
					local function ____catch(____error)
						print("函数执行出错:", ____error)
						error(____error, 0)
					end
					local ____try, ____hasReturned = pcall(function()
						result = originalMethod(self, unpack(args, 1, argCount))
					end)
					if not ____try then
						____catch(____hasReturned)
					end
					do
						profiler:exitFunction()
					end
				end
				return result
			end
			print(("[FlameGraphProfiler] 已为 " .. fullName) .. " 添加性能分析")
		end
		::__continue62::
	end
	classInstance.prototype.print = "123"
	print(("[FlameGraphProfiler] 已为 " .. tostring(className)) .. " 的所有方法添加性能分析")
end
function FlameGraphProfiler.prototype.syncToNetTable(self, rootNodeChildren)
	print("[FlameGraphProfiler] 同步性能数据到网表:")
	SyncNetTable:SetTableValue("performance_debug", "debug_data", rootNodeChildren)
end
function ____exports.GetFlameGraphProfiler(self)
	return ____exports.FlameGraphProfiler:getInstance()
end
local function emptyDecorator(____, str)
	return function(____, target, propertyKey, descriptor)
		return descriptor
	end
end
local function emptyClassDecorator(____, target)
	return target
end
____exports.Profile = ____exports.FlameGraphProfiler.profile
____exports.ProfileClass = ____exports.FlameGraphProfiler.profileClass
Test = __TS__Class()
Test.name = "Test"
function Test.prototype.____constructor(self) end
function Test.prototype.time_offet_test(self) end
__TS__DecorateLegacy({ ____exports.Profile(nil) }, Test.prototype, "time_offet_test", true)
return ____exports