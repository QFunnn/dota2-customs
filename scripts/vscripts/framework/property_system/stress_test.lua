--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/stress_test"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__NumberToFixed
local g = b.__TS__ArraySort
local h = b.__TS__DecorateLegacy
local i = b.__TS__New
local j = {}
local k = require("lib.tstl-utils")
local l = k.reloadable
local m = c()
m.name = "MPropertySystemStressTest"
d(m, CModule)
function m.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.testUnits = {}
	self.testPropertyIds = {}
	self.testStartTime = 0
	self.testEndTime = 0
	self.updateCount = 0
	self.DEFAULT_CONFIG = {
		unitCount = 100,
		propertiesPerUnit = 20,
		staticPropertiesPerUnit = 10,
		dynamicPropertiesPerUnit = 10,
		sourcesPerProperty = 3,
		duration = 60,
		updateInterval = 0.1,
		enableNetTableSync = true,
	}
end
function m.prototype.init(self, n)
	if not n then
		if IsServer() then
			if IsInToolsMode() then
				self:RegisterCommands()
			end
		end
		self:print("Stress test module loaded")
	end
end
function m.prototype.initPriority(self)
	return 5
end
function m.prototype.StartStressTest(self, o)
	print("StartStressTest")
	if self.testStartTime > 0 then
		self:print("Test already running! Use stop_stress_test first.")
		return
	end
	local p = e({}, self.DEFAULT_CONFIG, o)
	self:print("=== Starting Property System Stress Test ===")
	self:PrintConfig(p)
	self:PrepareTestEnvironment(p)
	self:RegisterTestProperties(p)
	self:CreateTestUnits(p)
	self:AddPropertiesToUnits(p)
	self:StartUpdateLoop(p)
	self.testStartTime = GameRules:GetGameTime()
	self.testEndTime = self.testStartTime + p.duration
	self:print(("Test started! Duration: " .. tostring(p.duration)) .. "s")
	self:print('Use "property_test_status" to check progress')
	self:print('Use "property_test_stop" to stop test')
end
function m.prototype.StopStressTest(self)
	if self.testStartTime == 0 then
		self:print("No test running")
		return
	end
	if self.updateTimer then
		self.updateTimer = nil
	end
	self:GenerateTestReport()
	self:CleanupTest()
	self:print("Test stopped")
end
function m.prototype.PrepareTestEnvironment(self, o)
	self.testUnits = {}
	self.testPropertyIds = {}
	self.updateCount = 0
	self.testStartTime = 0
	self.testEndTime = 0
end
function m.prototype.RegisterTestProperties(self, o)
	self:print("Registering test properties...")
	local q = {
		{ prefix = "damage", aggregation = AggregationStrategy.SUM },
		{ prefix = "armor", aggregation = AggregationStrategy.SUM },
		{ prefix = "speed", aggregation = AggregationStrategy.MULTIPLY },
		{ prefix = "crit", aggregation = AggregationStrategy.MAX },
		{ prefix = "resist", aggregation = AggregationStrategy.MIN },
	}
	do
		local r = 0
		while r < o.propertiesPerUnit do
			local s = q[r % #q + 1]
			local t = (("test_" .. s.prefix) .. "_") .. tostring(r)
			PropertySystem:RegisterProperty({
				id = t,
				scope = PropertyScope.UNIT,
				valueType = PropertyValueType.NUMBER,
				aggregation = s.aggregation,
				defaultValue = s.prefix == "speed" and 1 or 0,
				syncToClient = o.enableNetTableSync,
				syncPriority = r,
				enableCache = true,
				cacheDuration = 1,
			})
			local u = self.testPropertyIds
			u[#u + 1] = t
			r = r + 1
		end
	end
	self:print(("Registered " .. tostring(#self.testPropertyIds)) .. " test properties")
end
function m.prototype.CreateTestUnits(self, o)
	self:print("Creating test units...")
	local v = Entities:FindByClassname(nil, "info_player_start_goodguys")
	local w = v ~= nil and v:GetAbsOrigin() or Vector(0, 0, 128)
	do
		local r = 0
		while r < o.unitCount do
			local x = Vector(RandomFloat(-500, 500), RandomFloat(-500, 500), 0)
			local y = SpawnEntityFromTableSynchronous(
				"dota_prop_customtexture",
				{ origin = w:__add(x), model = "models/props_gameplay/tombstone.vmdl" }
			)
			if y ~= nil then
				local z = self.testUnits
				z[#z + 1] = y
			end
			r = r + 1
		end
	end
	self:print(("Created " .. tostring(#self.testUnits)) .. " test units")
end
function m.prototype.AddPropertiesToUnits(self, o)
	self:print("Adding properties to units...")
	local A = 0
	local B = 0
	for C, y in ipairs(self.testUnits) do
		local D = y:GetEntityIndex()
		do
			local r = 0
			while r < o.staticPropertiesPerUnit do
				local t = self.testPropertyIds[r + 1]
				do
					local E = 0
					while E < o.sourcesPerProperty do
						local F = (("source_" .. tostring(r)) .. "_") .. tostring(E)
						local G = RandomFloat(1, 100)
						PropertySystem:AddStaticProperty(D, t, F, G)
						A = A + 1
						E = E + 1
					end
				end
				r = r + 1
			end
		end
		do
			local r = 0
			while r < o.dynamicPropertiesPerUnit do
				local t = self.testPropertyIds[o.staticPropertiesPerUnit + r + 1]
				do
					local E = 0
					while E < o.sourcesPerProperty do
						local F = (("dynamic_" .. tostring(r)) .. "_") .. tostring(E)
						local function H()
							return y:GetHealth() * 0.01
						end
						PropertySystem:RegisterDynamicProperty(D, t, F, H, E)
						B = B + 1
						E = E + 1
					end
				end
				r = r + 1
			end
		end
	end
	self:print(("Added " .. tostring(A)) .. " static properties")
	self:print(("Added " .. tostring(B)) .. " dynamic properties")
end
function m.prototype.StartUpdateLoop(self, o)
	self:print("Starting update loop...")
	self.updateTimer = Timer:GameTimer(o.updateInterval, function()
		local I = GameRules:GetGameTime()
		if I >= self.testEndTime then
			self:StopStressTest()
			return nil
		end
		self:PerformUpdate(o)
		return o.updateInterval
	end)
end
function m.prototype.PerformUpdate(self, o)
	self.updateCount = self.updateCount + 1
	local J = math.floor(o.unitCount * 0.1)
	local K = {}
	do
		local r = 0
		while r < J do
			do
				local y = self.testUnits[RandomInt(0, #self.testUnits - 1) + 1]
				if not y or not IsValid(y) then
					goto L
				end
				local D = y:GetEntityIndex()
				local M = RandomInt(0, o.staticPropertiesPerUnit - 1)
				local t = self.testPropertyIds[M + 1]
				local N = RandomInt(0, o.sourcesPerProperty - 1)
				local F = (("source_" .. tostring(M)) .. "_") .. tostring(N)
				K[#K + 1] = { unit = y, propertyId = t }
			end
			::L::
			r = r + 1
		end
	end
	for C, O in ipairs(K) do
		local y = O.unit
		local t = O.propertyId
		local D = y:GetEntityIndex()
		PropertySystem:GetPropertyValue(D, t)
	end
	local P = math.max(1, math.floor(o.unitCount * 0.1))
	do
		local r = 0
		while r < P do
			do
				local y = self.testUnits[r % #self.testUnits + 1]
				if not y or not IsValid(y) then
					goto Q
				end
				local D = y:GetEntityIndex()
				do
					local R = 0
					while R < math.min(3, o.propertiesPerUnit) do
						local t = self.testPropertyIds[R + 1]
						PropertySystem:GetPropertyValue(D, t)
						R = R + 1
					end
				end
			end
			::Q::
			r = r + 1
		end
	end
end
function m.prototype.GenerateTestReport(self)
	local S = GameRules:GetGameTime() - self.testStartTime
	self:print("=== Property System Stress Test Report ===")
	self:print(("Duration: " .. f(S, 2)) .. "s")
	self:print("Updates: " .. tostring(self.updateCount))
	self:print("Average UPS: " .. f(self.updateCount / S, 2))
	local T = PropertyData.stats
	self:print("\n=== Performance Stats ===")
	self:print("Total Reads: " .. tostring(T.totalReads))
	self:print(((("Cache Hits: " .. tostring(T.cacheHits)) .. " (") .. f(T.cacheHits / T.totalReads * 100, 2)) .. "%)")
	self:print("Total Writes: " .. tostring(T.totalWrites))
	self:print("Sync Count: " .. tostring(T.syncCount))
	local U = PropertySystem:GetNetTableSizeStats()
	self:print("\n=== NetTable Size Stats ===")
	self:print(("Total Size: " .. tostring(U.total)) .. " bytes")
	self:print("Entity Count: " .. tostring(U.entities.size))
	if #U.warnings > 0 then
		self:print("\n⚠️ SIZE WARNINGS:")
		for C, V in ipairs(U.warnings) do
			self:print("  " .. V)
		end
	end
	local W = {}
	for X, Y in pairs(U.entities) do
		W[#W + 1] = { X, Y }
	end
	local Z = g(W, function(C, _, a0)
		return a0[2] - _[2]
	end)
	self:print("\nTop 5 largest entities:")
	do
		local r = 0
		while r < math.min(5, #Z) do
			self:print(((("  " .. Z[r + 1][1]) .. ": ") .. tostring(Z[r + 1][2])) .. " bytes")
			r = r + 1
		end
	end
	self:print("\n=== Storage Stats ===")
	local a1 = 0
	for a2 in pairs(PropertyData.playerStorage) do
		a1 = a1 + 1
	end
	local a3 = 0
	for a2 in pairs(PropertyData.unitStorage) do
		a3 = a3 + 1
	end
	local a4 = 0
	for a2 in pairs(PropertyData.dirtyKeys) do
		a4 = a4 + 1
	end
	self:print("Player Storages: " .. tostring(a1))
	self:print("Unit Storages: " .. tostring(a3))
	self:print("Dirty Keys: " .. tostring(a4))
end
function m.prototype.PrintConfig(self, o)
	self:print("Test Configuration:")
	self:print("  Units: " .. tostring(o.unitCount))
	self:print("  Properties/Unit: " .. tostring(o.propertiesPerUnit))
	self:print("  Static: " .. tostring(o.staticPropertiesPerUnit))
	self:print("  Dynamic: " .. tostring(o.dynamicPropertiesPerUnit))
	self:print("  Sources/Property: " .. tostring(o.sourcesPerProperty))
	self:print(("  Duration: " .. tostring(o.duration)) .. "s")
	self:print(("  Update Interval: " .. tostring(o.updateInterval)) .. "s")
	self:print("  NetTable Sync: " .. tostring(o.enableNetTableSync))
	local a5 = o.unitCount * o.propertiesPerUnit * o.sourcesPerProperty
	self:print("  Total Properties: " .. tostring(a5))
end
function m.prototype.CleanupTest(self)
	self:print("Cleaning up test...")
	PropertySystem:ForceSyncAllDirty()
	for C, y in ipairs(self.testUnits) do
		if y and IsValid(y) then
			PropertySystem:CleanupUnitProperties(y)
			UTIL_Remove(y)
		end
	end
	self.testUnits = {}
	self.testPropertyIds = {}
	self:print("Test stopped")
end
function m.prototype.RegisterCommands(self)
	Convars:RegisterCommand("property_test_start", function()
		print("property_test_start")
		self:StartStressTest()
	end, "Start property system stress test", 0)
	Convars:RegisterCommand("property_test_start_small", function()
		self:StartStressTest({
			unitCount = 10,
			propertiesPerUnit = 10,
			staticPropertiesPerUnit = 5,
			dynamicPropertiesPerUnit = 5,
			sourcesPerProperty = 2,
			duration = 30,
		})
	end, "Start small stress test (10 units, 30s)", 0)
	Convars:RegisterCommand("property_test_start_large", function()
		self:StartStressTest({
			unitCount = 200,
			propertiesPerUnit = 30,
			staticPropertiesPerUnit = 15,
			dynamicPropertiesPerUnit = 15,
			sourcesPerProperty = 5,
			duration = 120,
		})
	end, "Start large stress test (200 units, 120s)", 0)
	Convars:RegisterCommand("property_test_stop", function()
		self:StopStressTest()
	end, "Stop current stress test", 0)
	Convars:RegisterCommand("property_test_status", function()
		if self.testStartTime == 0 then
			self:print("No test running")
			return
		end
		local I = GameRules:GetGameTime()
		local a6 = I - self.testStartTime
		local a7 = self.testEndTime - I
		self:print("=== Test Status ===")
		self:print(("Elapsed: " .. f(a6, 2)) .. "s")
		self:print(("Remaining: " .. f(a7, 2)) .. "s")
		self:print("Updates: " .. tostring(self.updateCount))
		self:print("Units: " .. tostring(#self.testUnits))
		self:print("Properties: " .. tostring(#self.testPropertyIds))
	end, "Show test status", 0)
	Convars:RegisterCommand("property_test_nettable", function()
		self:TestNetTableSize()
	end, "Test NetTable size limit with single unit", 0)
end
function m.prototype.TestNetTableSize(self)
	self:print("=== NetTable Size Test ===")
	self:print("Creating unit with increasing properties until size limit...")
	local v = Entities:FindByClassname(nil, "info_player_start_goodguys")
	local w = v ~= nil and v:GetAbsOrigin() or Vector(0, 0, 128)
	local y = SpawnEntityFromTableSynchronous(
		"dota_prop_customtexture",
		{ origin = w, model = "models/props_gameplay/tombstone.vmdl" }
	)
	if not y then
		self:print("Failed to create test unit")
		return
	end
	local D = y:GetEntityIndex()
	local a8 = 0
	while true do
		local t = "nettable_test_prop_" .. tostring(a8)
		PropertySystem:RegisterProperty({
			id = t,
			scope = PropertyScope.UNIT,
			valueType = PropertyValueType.NUMBER,
			aggregation = AggregationStrategy.SUM,
			syncToClient = true,
		})
		do
			local E = 0
			while E < 10 do
				PropertySystem:AddStaticProperty(D, t, "source_" .. tostring(E), RandomFloat(1, 100))
				E = E + 1
			end
		end
		a8 = a8 + 1
		local a9 = PropertySystem:EstimateEntityNetTableSize(PropertyScope.UNIT, D)
		self:print(((("Properties: " .. tostring(a8)) .. ", Estimated Size: ") .. tostring(a9)) .. " bytes")
		if a9 > 13000 then
			self:print("\n⚠️ Approaching size limit!")
			self:print("Maximum safe properties: ~" .. tostring(a8))
			self:print(("With 10 sources per property: " .. tostring(a8 * 10)) .. " total values")
			break
		end
		if a8 > 1000 then
			self:print("Reached safety limit (1000 properties)")
			break
		end
	end
	Timer:GameTimer(0.5, function()
		local U = PropertySystem:GetNetTableSizeStats()
		self:print("\n=== Final Stats ===")
		self:print("Total entities: " .. tostring(U.entities.size))
		self:print(("Total size: " .. tostring(U.total)) .. " bytes")
		if #U.warnings > 0 then
			self:print("\n⚠️ WARNINGS:")
			for C, V in ipairs(U.warnings) do
				self:print("  " .. V)
			end
		end
		UTIL_Remove(y)
		return nil
	end)
end
m = h({ l }, m)
if PropertySystemStressTest == nil then
	PropertySystemStressTest = i(m)
end
return j