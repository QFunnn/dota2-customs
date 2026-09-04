--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__DecorateLegacy = ____lualib.__TS__DecorateLegacy
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local ____flame_graph_profiler = require("utils.performance.flame_graph_profiler")
local GetFlameGraphProfiler = ____flame_graph_profiler.GetFlameGraphProfiler
local Profile = ____flame_graph_profiler.Profile
local ProfileClass = ____flame_graph_profiler.ProfileClass
local ____flame_graph_commands = require("utils.performance.flame_graph_commands")
local InitFlameGraphCommands = ____flame_graph_commands.InitFlameGraphCommands
local FlameGraphCommands = ____flame_graph_commands.FlameGraphCommands
--- 测试类 - 使用单个方法装饰器
local ProfileDecoratorTest = __TS__Class()
ProfileDecoratorTest.name = "ProfileDecoratorTest"
function ProfileDecoratorTest.prototype.____constructor(self) end
function ProfileDecoratorTest.prototype.testMethod1(self)
	self:simulateWork(50)
	self:testMethod2()
end
__TS__DecorateLegacy({ Profile(nil) }, ProfileDecoratorTest.prototype, "testMethod1", true)
function ProfileDecoratorTest.prototype.testMethod2(self)
	self:simulateWork(30)
end
__TS__DecorateLegacy(
	{ Profile(nil, "自定义方法名.testMethod2") },
	ProfileDecoratorTest.prototype,
	"testMethod2",
	true
)
function ProfileDecoratorTest.prototype.simulateWork(self, ms)
	local startTime = GetSystemTimeMS()
	while GetSystemTimeMS() - startTime < ms do
	end
end
--- 测试类 - 使用类装饰器监控所有方法
local ProfileClassTest = __TS__Class()
ProfileClassTest.name = "ProfileClassTest"
function ProfileClassTest.prototype.____constructor(self) end
function ProfileClassTest.prototype.testMethod1(self)
	self:simulateWork(40)
	self:testMethod2()
end
function ProfileClassTest.prototype.testMethod2(self)
	self:simulateWork(25)
	self:testMethod3()
end
function ProfileClassTest.prototype.testMethod3(self)
	self:simulateWork(15)
end
function ProfileClassTest.prototype.simulateWork(self, ms)
	local startTime = GetSystemTimeMS()
	while GetSystemTimeMS() - startTime < ms do
	end
end
ProfileClassTest = __TS__DecorateLegacy({ ProfileClass }, ProfileClassTest)
--- 手动性能分析测试类
local ManualProfileTest = __TS__Class()
ManualProfileTest.name = "ManualProfileTest"
function ManualProfileTest.prototype.____constructor(self)
	self.profiler = GetFlameGraphProfiler(nil)
end
function ManualProfileTest.prototype.testManualProfiling(self)
	self.profiler:enterFunction("ManualProfileTest.testManualProfiling")
	self:simulateWork(60)
	self:nestedFunction()
	self.profiler:exitFunction()
end
function ManualProfileTest.prototype.nestedFunction(self)
	self.profiler:enterFunction("ManualProfileTest.nestedFunction")
	self:simulateWork(35)
	self.profiler:exitFunction()
end
function ManualProfileTest.prototype.simulateWork(self, ms)
	local startTime = GetSystemTimeMS()
	while GetSystemTimeMS() - startTime < ms do
	end
end
local Debug_Test = __TS__Class()
Debug_Test.name = "Debug_Test"
function Debug_Test.prototype.____constructor(self)
	Timers:CreateTimer(function()
		self:Test()
		do
			local i = 0
			while i < 10000 do
				self:Test2()
				i = i + 1
			end
		end
		return 0.2
	end)
end
function Debug_Test.prototype.Test(self)
	do
		local i = 0
		while i < 10000 do
			math.random(0, 10000)
			math.random(0, 10000)
			math.random(0, 10000)
			math.random(0, 10000)
			i = i + 1
		end
	end
end
function Debug_Test.prototype.Test2(self)
	math.random(0, 10000)
	math.random(0, 10000)
	math.random(0, 10000)
	math.random(0, 10000)
end
Debug_Test = __TS__DecorateLegacy({ ProfileClass }, Debug_Test)
____exports.FlameGraphProfilerTests = __TS__Class()
local FlameGraphProfilerTests = ____exports.FlameGraphProfilerTests
FlameGraphProfilerTests.name = "FlameGraphProfilerTests"
function FlameGraphProfilerTests.prototype.____constructor(self)
	InitFlameGraphCommands(nil)
	print("初始化性能测试!")
	ListenToGameEvent("player_chat", function(____, keys)
		return self:OnPlayerChat(keys)
	end, self)
end
function FlameGraphProfilerTests.prototype.OnPlayerChat(self, keys)
	local strs = __TS__StringSplit(keys.text, " ")
	local cmd = strs[1]
	local args = __TS__ArraySlice(strs, 1)
	if cmd == "-test" then
		FlameGraphCommands:getInstance():handleStart()
		__TS__New(Debug_Test)
	end
	if cmd == "-test2" then
		FlameGraphCommands:getInstance():handleStart()
		print("测试单个方法装饰器...")
		local decoratorTest = __TS__New(ProfileDecoratorTest)
		do
			local i = 0
			while i < 5 do
				decoratorTest:testMethod1()
				i = i + 1
			end
		end
		print("测试类装饰器...")
		local classTest = __TS__New(ProfileClassTest)
		do
			local i = 0
			while i < 5 do
				classTest:testMethod1()
				i = i + 1
			end
		end
		print("测试手动性能分析...")
		local manualTest = __TS__New(ManualProfileTest)
		do
			local i = 0
			while i < 5 do
				manualTest:testManualProfiling()
				i = i + 1
			end
		end
		FlameGraphCommands:getInstance():handleStop()
	end
end
return ____exports