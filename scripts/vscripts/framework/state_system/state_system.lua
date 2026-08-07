--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/state_system/state_system"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFindIndex
local f = b.__TS__ArraySplice
local g = b.__TS__Delete
local h = b.__TS__ArrayFind
local i = b.__TS__ArraySort
local j = b.__TS__ObjectKeys
local k = b.__TS__StringSplit
local l = b.__TS__ObjectAssign
local m = b.__TS__NumberToFixed
local n = b.__TS__DecorateLegacy
local o = b.__TS__New
local p = {}
local q = require("lib.tstl-utils")
local r = q.reloadable
local s = c()
s.name = "MStateSystem"
d(s, CModule)
function s.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.NETTABLE_NAME = "state_system"
	self.SYNC_INTERVAL = 0.2
	self.MAX_NETTABLE_SIZE = 14000
	self.autoCleanupInterval = 30
end
function s.prototype.init(self, t)
	if not t then
		self:InitializeCore()
		if IsServer() then
			self:InitializeNetTableSync()
			self:StartAutoCleanup()
			if IsInToolsMode() then
				self:RegisterDebugCommands()
			end
		end
		self:print("State System initialized")
	else
		self:print("State System reloaded")
	end
end
function s.prototype.initPriority(self)
	return 10
end
function s.prototype.reset(self)
	self:ResetSystem()
end
function s.prototype.InitializeCore(self)
	if not StateData then
		StateData = {
			unitStorage = {},
			dirtyKeys = {},
			lastSyncTime = 0,
			stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 },
		}
	end
end
function s.prototype.AddStaticState(self, u, v, w, x, y, z)
	if y == nil then
		y = 0
	end
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.static[A]
	if not C then
		C = {}
		B.static[A] = C
	end
	local D = e(C, function(E, F)
		return F.sourceId == w
	end)
	if D ~= -1 then
		local G = self:GetStaticStateValue(u, A)
		C[D + 1].value = x
		C[D + 1].priority = y
		C[D + 1].metadata = z
		self:RecalculateStaticState(u, A)
		local H = self:GetStaticStateValue(u, A)
		if G ~= H then
			Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = H })
		end
	else
		local G = self:GetStaticStateValue(u, A)
		C[#C + 1] = { sourceId = w, value = x, priority = y, addedTime = self:GetCurrentTime(), metadata = z }
		self:RecalculateStaticState(u, A)
		local H = self:GetStaticStateValue(u, A)
		if G ~= H then
			Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = H })
		end
	end
	self:MarkDirty(u, A)
	local I, J = StateData.stats, "totalWrites"
	I[J] = I[J] + 1
	return true
end
function s.prototype.RemoveStaticState(self, u, w, v)
	if v then
		return self:RemoveSingleStaticState(u, w, v)
	else
		local B = StateData.unitStorage[u]
		if not B then
			return false
		end
		local K = false
		for L in pairs(B.static) do
			if self:RemoveSingleStaticState(u, w, L) then
				K = true
			end
		end
		return K
	end
end
function s.prototype.RemoveSingleStaticState(self, u, w, v)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.static[A]
	if not C then
		return false
	end
	local M = e(C, function(E, F)
		return F.sourceId == w
	end)
	if M ~= -1 then
		local G = self:GetStaticStateValue(u, A)
		f(C, M, 1)
		if #C == 0 then
			g(B.static, A)
			g(B.cache, A)
		else
			self:RecalculateStaticState(u, A)
		end
		local H = self:GetStaticStateValue(u, A)
		if G ~= H then
			Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = H })
		end
		self:MarkDirty(u, A)
		return true
	end
	return false
end
function s.prototype.UpdateStaticStateValue(self, u, v, w, H)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.static[A]
	if not C then
		return false
	end
	local N = h(C, function(E, F)
		return F.sourceId == w
	end)
	if N then
		local G = self:GetStaticStateValue(u, A)
		N.value = H
		self:RecalculateStaticState(u, A)
		local O = self:GetStaticStateValue(u, A)
		if G ~= O then
			Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = O })
		end
		self:MarkDirty(u, A)
		return true
	end
	return false
end
function s.prototype.GetStaticStateValue(self, u, v)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local P = B.cache[A]
	local Q, R = StateData.stats, "totalReads"
	Q[R] = Q[R] + 1
	if P ~= nil then
		local S, T = StateData.stats, "cacheHits"
		S[T] = S[T] + 1
		return P.value
	end
	return false
end
function s.prototype.RecalculateStaticState(self, u, v)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.static[A]
	if not C or #C == 0 then
		g(B.cache, A)
		return
	end
	local U = i({ unpack(C) }, function(E, V, W)
		local X = type(V.priority) == "function" and V:priority() or V.priority
		local Y = type(W.priority) == "function" and W:priority() or W.priority
		return X - Y
	end)
	local Z = false
	for E, N in ipairs(U) do
		if N.value == true then
			Z = true
			break
		end
	end
	B.cache[A] = { value = Z, cachedAt = self:GetCurrentTime() }
end
function s.prototype.RegisterDynamicState(self, u, v, w, _, y, z)
	if y == nil then
		y = 100
	end
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.dynamic[A]
	if not C then
		C = {}
		B.dynamic[A] = C
	end
	local D = e(C, function(E, F)
		return F.sourceId == w
	end)
	if D ~= -1 then
		C[D + 1].callback = _
		C[D + 1].priority = y
		C[D + 1].metadata = z
	else
		C[#C + 1] = { sourceId = w, callback = _, priority = y, addedTime = self:GetCurrentTime(), metadata = z }
	end
	local G = self:GetDynamicStateValueInternal(u, A)
	g(B.cache, A)
	local H = self:GetDynamicStateValueInternal(u, A)
	if G ~= H then
		Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = H })
	end
	self:MarkDirty(u, A)
	local a0, a1 = StateData.stats, "totalWrites"
	a0[a1] = a0[a1] + 1
	return true
end
function s.prototype.UnregisterDynamicState(self, u, w, v)
	if v then
		return self:UnregisterSingleDynamicState(u, w, v)
	else
		local B = StateData.unitStorage[u]
		if not B then
			return false
		end
		local K = false
		for L in pairs(B.dynamic) do
			if self:UnregisterSingleDynamicState(u, w, L) then
				K = true
			end
		end
		return K
	end
end
function s.prototype.UnregisterSingleDynamicState(self, u, w, v)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.dynamic[A]
	if not C then
		return false
	end
	local M = e(C, function(E, F)
		return F.sourceId == w
	end)
	if M ~= -1 then
		local G = self:GetDynamicStateValueInternal(u, A)
		f(C, M, 1)
		if #C == 0 then
			g(B.dynamic, A)
		end
		g(B.cache, A)
		local H = self:GetDynamicStateValueInternal(u, A)
		if G ~= H then
			Event:Fire("state_changed", { key = u, stateId = A, oldValue = G, newValue = H })
		end
		self:MarkDirty(u, A)
		return true
	end
	return false
end
function s.prototype.GetDynamicStateValue(self, u, v, a2)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local a3 = B.cache[A]
	if a3 ~= nil then
		local a4, a5 = StateData.stats, "totalReads"
		a4[a5] = a4[a5] + 1
		local a6, a7 = StateData.stats, "cacheHits"
		a6[a7] = a6[a7] + 1
		return a3.value
	end
	local x = self:CalculateDynamicStateValue(u, A, a2)
	B.cache[A] = { value = x, cachedAt = self:GetCurrentTime() }
	local a8, a9 = StateData.stats, "totalReads"
	a8[a9] = a8[a9] + 1
	return x
end
function s.prototype.GetDynamicStateValueInternal(self, u, v)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local a3 = B.cache[A]
	local aa = a3 and a3.value
	if aa == nil then
		aa = false
	end
	return aa
end
function s.prototype.CalculateDynamicStateValue(self, u, v, a2)
	local A = self:NormalizeStateId(v)
	local B = self:GetStorage(u)
	local C = B.dynamic[A]
	if not C or #C == 0 then
		return false
	end
	local U = i({ unpack(C) }, function(E, V, W)
		local X = type(V.priority) == "function" and V:priority() or V.priority
		local Y = type(W.priority) == "function" and W:priority() or W.priority
		return X - Y
	end)
	for E, N in ipairs(U) do
		do
			local function ab(ac)
				self:print(
					(((("[Error] Dynamic state callback failed: " .. A) .. " (") .. N.sourceId) .. "): ")
						.. tostring(ac)
				)
			end
			local ad, ae, af = pcall(function()
				if N:callback(a2) == true then
					return true, true
				end
			end)
			if not ad then
				ae, af = ab(ae)
			end
			if ae then
				return af
			end
		end
	end
	return false
end
function s.prototype.ClearDynamicStateCache(self, u, v)
	local B = self:GetStorage(u)
	if v then
		local A = self:NormalizeStateId(v)
		g(B.cache, A)
	else
		B.cache = {}
	end
end
function s.prototype.GetStateValue(self, u, v, a2)
	if IsServer() then
		local ag = self:GetStaticStateValue(u, v)
		local ah = self:GetDynamicStateValue(u, v, a2)
		return ag or ah
	else
		return self:GetStateValueFromNetTable(u, v)
	end
end
function s.prototype.GetStateValueInternal(self, u, v)
	local ag = self:GetStaticStateValue(u, v)
	local ah = self:GetDynamicStateValueInternal(u, v)
	return ag or ah
end
function s.prototype.InitializeNetTableSync(self)
	CustomNetTables:SetTableValue(self.NETTABLE_NAME, "init", { version = 1, time = self:GetCurrentTime() })
	Timer:GameTimer(self.SYNC_INTERVAL, function()
		self:SyncDirtyStates()
		return self.SYNC_INTERVAL
	end)
	self:print("NetTable sync initialized")
end
function s.prototype.SyncDirtyStates(self)
	local ai = 0
	for aj in pairs(StateData.dirtyKeys) do
		ai = ai + 1
	end
	if ai == 0 then
		return
	end
	local ak = j(StateData.dirtyKeys)
	local al = {}
	for E, am in ipairs(ak) do
		local an = k(am, "|")
		local u = tonumber(an[1])
		local ao = self:GetEntityKeyForNetTable(u)
		if not al[ao] then
			al[ao] = {}
		end
		local ap = al[ao]
		ap[#ap + 1] = am
	end
	for ao, aq in pairs(al) do
		self:SyncEntityBatch(ao, aq)
	end
	StateData.dirtyKeys = {}
	StateData.lastSyncTime = self:GetCurrentTime()
	local ar, as = StateData.stats, "syncCount"
	ar[as] = ar[as] + 1
end
function s.prototype.SyncEntityBatch(self, ao, at)
	local au = CustomNetTables:GetTableValue(self.NETTABLE_NAME, ao)
	local av
	if au then
		av = l({}, au)
	else
		av = {}
	end
	local aw = av
	for E, am in ipairs(at) do
		local an = k(am, "|")
		local u = tonumber(an[1])
		local v = an[2]
		local x = self:GetStateValueInternal(u, v)
		aw[v] = x
	end
	CustomNetTables:SetTableValue(self.NETTABLE_NAME, ao, aw)
end
function s.prototype.GetStateValueFromNetTable(self, u, v)
	local A = self:NormalizeStateId(v)
	local ao = self:GetEntityKeyForNetTable(u)
	local N = CustomNetTables:GetTableValue(self.NETTABLE_NAME, ao)
	if N and N[A] ~= nil then
		return N[A]
	end
	return false
end
function s.prototype.ListenStateChange(self, u, v, _)
	if IsServer() then
		self:print("[Warning] ListenStateChange should only be used on client")
		return
	end
	local ax = self:GetStateValueFromNetTable(u, v)
	Timer:GameTimer(0.1, function()
		local H = self:GetStateValueFromNetTable(u, v)
		if H ~= ax then
			_(ax, H)
			ax = H
		end
		return 0.1
	end)
end
function s.prototype.CleanupSourceStates(self, u, w)
	self:RemoveStaticState(u, w)
	self:UnregisterDynamicState(u, w)
end
function s.prototype.CleanupUnitStates(self, ay)
	if not ay then
		return
	end
	local az = ay:GetEntityIndex()
	self:CleanupStorage(az)
end
function s.prototype.CleanupStorage(self, u)
	local B = StateData.unitStorage[u]
	if B ~= nil then
		g(StateData.unitStorage, u)
		self:print("Cleaned up storage: Unit " .. tostring(u))
	end
end
function s.prototype.CleanupEmptyStorages(self)
	local aA = 0
	for u, B in pairs(StateData.unitStorage) do
		if self:IsStorageEmpty(B) then
			g(StateData.unitStorage, u)
			aA = aA + 1
		end
	end
	return aA
end
function s.prototype.IsStorageEmpty(self, B)
	local aB = 0
	for aj in pairs(B.static) do
		aB = aB + 1
	end
	local aC = 0
	for aj in pairs(B.dynamic) do
		aC = aC + 1
	end
	local aD = 0
	for aj in pairs(B.cache) do
		aD = aD + 1
	end
	return aB == 0 and aC == 0 and aD == 0
end
function s.prototype.StartAutoCleanup(self)
	Timer:GameTimer(self.autoCleanupInterval, function()
		self:CleanupEmptyStorages()
		return self.autoCleanupInterval
	end)
	self:print(("Auto cleanup started (" .. tostring(self.autoCleanupInterval)) .. "s)")
end
function s.prototype.ResetSystem(self)
	StateData.unitStorage = {}
	StateData.dirtyKeys = {}
	StateData.stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 }
end
function s.prototype.RegisterDebugCommands(self)
	Convars:RegisterCommand("state_status", function()
		self:PrintSystemStatus()
	end, "Print state system status", 0)
	Convars:RegisterCommand("state_stats", function()
		self:PrintPerformanceStats()
	end, "Print performance statistics", 0)
	Convars:RegisterCommand("state_reset_stats", function()
		StateData.stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 }
		self:print("Statistics reset")
	end, "Reset performance statistics", 0)
	Convars:RegisterCommand("state_list", function()
		local aE = {}
		for E, B in pairs(StateData.unitStorage) do
			for L in pairs(B.static) do
				aE[tostring(L)] = true
			end
			for L in pairs(B.dynamic) do
				aE[tostring(L)] = true
			end
		end
		self:print("=== Known States ===")
		for L in pairs(aE) do
			self:print(L)
		end
	end, "List all known states", 0)
	Convars:RegisterCommand("state_cleanup", function()
		local aF = self:CleanupEmptyStorages()
		self:print(("Cleaned up " .. tostring(aF)) .. " empty storages")
	end, "Force cleanup empty storages", 0)
	self:print("Debug commands registered")
end
function s.prototype.PrintSystemStatus(self)
	local aG = 0
	for aj in pairs(StateData.unitStorage) do
		aG = aG + 1
	end
	local ai = 0
	for aj in pairs(StateData.dirtyKeys) do
		ai = ai + 1
	end
	self:print("=== State System Status ===")
	self:print("Unit Storages: " .. tostring(aG))
	self:print("Dirty Keys: " .. tostring(ai))
	self:print(("Last Sync: " .. m(StateData.lastSyncTime, 2)) .. "s")
end
function s.prototype.PrintPerformanceStats(self)
	local aH = StateData.stats
	local aI = aH.totalReads > 0 and m(aH.cacheHits / aH.totalReads * 100, 2) or "0.00"
	self:print("=== Performance Stats ===")
	self:print("Total Reads: " .. tostring(aH.totalReads))
	self:print(((("Cache Hits: " .. tostring(aH.cacheHits)) .. " (") .. aI) .. "%)")
	self:print("Total Writes: " .. tostring(aH.totalWrites))
	self:print("Sync Count: " .. tostring(aH.syncCount))
end
function s.prototype.GetStorage(self, u)
	local B = StateData.unitStorage[u]
	if not B then
		B = { static = {}, dynamic = {}, cache = {} }
		StateData.unitStorage[u] = B
	end
	return B
end
function s.prototype.GetEntityContext(self, aJ)
	if not aJ or not IsValid(aJ) then
		return nil
	end
	if aJ.IsBaseNPC and aJ:IsBaseNPC() then
		return aJ:GetEntityIndex()
	end
	return nil
end
function s.prototype.NormalizeStateId(self, v)
	return tostring(v)
end
function s.prototype.GetDirtyKey(self, u, v)
	local A = self:NormalizeStateId(v)
	return (tostring(u) .. "|") .. A
end
function s.prototype.MarkDirty(self, u, v)
	local am = self:GetDirtyKey(u, v)
	StateData.dirtyKeys[am] = true
end
function s.prototype.GetEntityKeyForNetTable(self, u)
	return "unit_" .. tostring(u)
end
function s.prototype.GetCurrentTime(self)
	return GameRules:GetGameTime()
end
function s.prototype.ForceSyncAllDirty(self)
	if not IsServer() then
		return
	end
	local aK = 0
	for aj in pairs(StateData.dirtyKeys) do
		aK = aK + 1
	end
	if aK == 0 then
		return
	end
	self:print(("[ForceSyncAllDirty] Syncing " .. tostring(aK)) .. " dirty states...")
	self:SyncDirtyStates()
	local aL = 0
	for aj in pairs(StateData.dirtyKeys) do
		aL = aL + 1
	end
	self:print("[ForceSyncAllDirty] Sync completed, remaining: " .. tostring(aL))
end
s = n({ r }, s)
if StateSystem == nil then
	StateSystem = o(s)
end
return p