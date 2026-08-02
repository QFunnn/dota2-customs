--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/property_system/property_system"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectAssign
local f = b.__TS__ArrayFindIndex
local g = b.__TS__ArraySplice
local h = b.__TS__Delete
local i = b.__TS__ArraySort
local j = b.__TS__ObjectKeys
local k = b.__TS__StringSplit
local l = b.__TS__ParseInt
local m = b.__TS__NumberToFixed
local n = b.__TS__DecorateLegacy
local o = b.__TS__New
local p = {}
local q = require("lib.tstl-utils")
local r = q.reloadable
require("framework.property_system.property_system_types")
require("framework.property_system.properties_tool")
local s = c()
s.name = "MPropertySystem"
d(s, CModule)
function s.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.NETTABLE_NAME = "property_system"
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
			self:RegisterEventPropertyResponses()
		end
		self:print("Property System initialized")
	else
		self:print("Property System reloaded")
	end
	require("framework.property_system.properties")
end
function s.prototype.initPriority(self)
	return 10
end
function s.prototype.reset(self)
	self:ResetSystem()
end
function s.prototype.InitializeCore(self)
	if not PropertyData then
		PropertyData = {
			configs = {},
			playerStorage = {},
			unitStorage = {},
			dirtyKeys = {},
			lastSyncTime = 0,
			stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 },
			eventPropertyResponses = {},
		}
	end
end
function s.prototype.RegisterProperty(self, u)
	local v = u
	local w = u.defaultValue or 0
	local x = u.syncToClient
	if x == nil then
		x = true
	end
	local y = u.syncPriority or 100
	local z = u.enableCache
	if z == nil then
		z = true
	end
	local A = e(
		{},
		v,
		{ defaultValue = w, syncToClient = x, syncPriority = y, enableCache = z, cacheDuration = u.cacheDuration or 0 }
	)
	PropertyData.configs[u.id] = A
	if u.event_name ~= nil and u.event_name ~= "" and u.event_link_id ~= nil and u.event_link_id ~= "" then
		if not PropertyData.eventPropertyResponses[u.event_name] then
			PropertyData.eventPropertyResponses[u.event_name] = {}
		end
		local B = PropertyData.eventPropertyResponses[u.event_name]
		local C = f(B, function(D, E)
			return E.sourcePropertyId == u.id and E.targetPropertyId == u.event_link_id
		end)
		if C ~= -1 then
			return
		end
		B[#B + 1] = { sourcePropertyId = u.id, targetPropertyId = u.event_link_id }
	end
end
function s.prototype.RegisterProperties(self, F)
	for D, u in ipairs(F) do
		self:RegisterProperty(u)
	end
end
function s.prototype.AddStaticProperty(self, G, H, I, J, K)
	local u = self:GetConfig(H)
	if u == nil then
		return false
	end
	local L = self:GetStorage(u.scope, G)
	local M = L.static[H]
	if not M then
		M = {}
		L.static[H] = M
	end
	local C = f(M, function(D, N)
		return N.sourceId == I
	end)
	if C ~= -1 then
		local O = self:GetStaticPropertyValue(u.scope, G, H)
		M[C + 1].value = J
		M[C + 1].metadata = K
		self:RecalculateStaticProperty(u.scope, G, H)
		local P = self:GetStaticPropertyValue(u.scope, G, H)
		if u.notify and O ~= P then
			Event:Fire("property_changed", { scope = u.scope, key = G, propertyId = H, oldValue = O, newValue = P })
		end
	else
		local O = self:GetStaticPropertyValue(u.scope, G, H)
		M[#M + 1] = { sourceId = I, value = J, addedTime = self:GetCurrentTime(), metadata = K }
		self:RecalculateStaticProperty(u.scope, G, H)
		local P = self:GetStaticPropertyValue(u.scope, G, H)
		if u.notify and O ~= P then
			Event:Fire("property_changed", { scope = u.scope, key = G, propertyId = H, oldValue = O, newValue = P })
		end
	end
	if u.syncToClient then
		self:MarkDirty(u.scope, G, H)
	end
	local Q, R = PropertyData.stats, "totalWrites"
	Q[R] = Q[R] + 1
	return true
end
function s.prototype.RemoveStaticProperty(self, G, I, H)
	if H then
		return self:RemoveSingleStaticProperty(G, I, H)
	else
		local S = false
		for T in pairs(PropertyData.configs) do
			if self:RemoveSingleStaticProperty(G, I, T) then
				S = true
			end
		end
		return S
	end
end
function s.prototype.RemoveSingleStaticProperty(self, G, I, H)
	if not self:ValidateProperty(H) then
		return false
	end
	local u = self:GetConfig(H)
	local L = self:GetStorage(u.scope, G)
	local M = L.static[H]
	if not M then
		return false
	end
	local U = f(M, function(D, N)
		return N.sourceId == I
	end)
	if U ~= -1 then
		local O = self:GetStaticPropertyValue(u.scope, G, H)
		g(M, U, 1)
		if #M == 0 then
			h(L.static, H)
			h(L.staticCache, H)
		else
			self:RecalculateStaticProperty(u.scope, G, H)
		end
		local P = self:GetStaticPropertyValue(u.scope, G, H)
		if u.notify and O ~= P then
			Event:Fire("property_changed", { scope = u.scope, key = G, propertyId = H, oldValue = O, newValue = P })
		end
		if u.syncToClient then
			self:MarkDirty(u.scope, G, H)
		end
		return true
	end
	return false
end
function s.prototype.AddStaticPropertyEx(self, H, I, J, V, W, K)
	local u = self:GetConfig(H)
	if u == nil then
		return false
	end
	local G = self:SelectKeyFromContext(u.scope, V, W)
	return self:AddStaticProperty(G, H, I, J, K)
end
function s.prototype.RemoveStaticPropertyEx(self, I, V, W, H)
	local S = false
	if H then
		local u = self:GetConfig(H)
		if u == nil then
			return false
		end
		local G = self:SelectKeyFromContext(u.scope, V, W)
		return self:RemoveStaticProperty(G, I, H)
	else
		for T in pairs(PropertyData.configs) do
			do
				local X = T
				local u = self:GetConfig(X)
				if u == nil then
					goto Y
				end
				local G = self:SelectKeyFromContext(u.scope, V, W)
				if self:RemoveSingleStaticProperty(G, I, X) then
					S = true
				end
			end
			::Y::
		end
		return S
	end
end
function s.prototype.SelectKeyFromContext(self, Z, _, W)
	if Z == PropertyScope.PLAYER then
		return _
	elseif Z == PropertyScope.UNIT then
		if not W then
			self:print("[PropertySystem] Error: UNIT scope property requires unit in context")
			return _
		end
		return W
	end
	self:print("[PropertySystem] Error: Unknown scope " .. tostring(Z))
	return _
end
function s.prototype.GetStaticPropertyValue(self, Z, G, H)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	local L = self:GetStorage(Z, G)
	local a0 = L.staticCache[H]
	local a1, a2 = PropertyData.stats, "totalReads"
	a1[a2] = a1[a2] + 1
	if a0 ~= nil then
		local a3, a4 = PropertyData.stats, "cacheHits"
		a3[a4] = a3[a4] + 1
	end
	return a0 or 0
end
function s.prototype.RecalculateStaticProperty(self, Z, G, H)
	local u = self:GetConfig(H)
	if not u then
		return
	end
	local L = self:GetStorage(Z, G)
	local M = L.static[H]
	if not M or #M == 0 then
		h(L.staticCache, H)
		return
	end
	local a5 = self:GetAggregationInitialValue(u.aggregation, 0)
	for D, a6 in ipairs(M) do
		a5 = self:AggregateValues(u.aggregation, a5, a6.value, u.customAggregator)
	end
	L.staticCache[H] = a5
end
function s.prototype.AddAbilityStaticProperty(self, a7, H, I, J, K)
	if not IsValid(a7) then
		return false
	end
	local u = self:GetConfig(H)
	if u == nil then
		return false
	end
	if u.scope ~= PropertyScope.UNIT then
		self:print("[PropertySystem] Ability extra property only supports UNIT scope: " .. H)
		return false
	end
	if a7.__ExtraStaticPropertyList == nil then
		a7.__ExtraStaticPropertyList = {}
	end
	if a7.__ExtraStaticPropertyCache == nil then
		a7.__ExtraStaticPropertyCache = {}
	end
	local M = a7.__ExtraStaticPropertyList[H]
	if not M then
		M = {}
		a7.__ExtraStaticPropertyList[H] = M
	end
	local C = f(M, function(D, N)
		return N.sourceId == I
	end)
	if C ~= -1 then
		M[C + 1].value = J
		M[C + 1].metadata = K
	else
		M[#M + 1] = { sourceId = I, value = J, addedTime = self:GetCurrentTime(), metadata = K }
	end
	self:RecalculateAbilityStaticProperty(a7, H)
	return true
end
function s.prototype.RemoveAbilityStaticProperty(self, a7, I, H)
	if not IsValid(a7) or a7.__ExtraStaticPropertyList == nil then
		return false
	end
	if H ~= nil then
		return self:RemoveSingleAbilityStaticProperty(a7, I, H)
	end
	local S = false
	for T in pairs(a7.__ExtraStaticPropertyList) do
		if self:RemoveSingleAbilityStaticProperty(a7, I, T) then
			S = true
		end
	end
	return S
end
function s.prototype.GetAbilityExtraPropertyTable(self, a7)
	if not IsValid(a7) then
		return nil
	end
	return a7.__ExtraStaticPropertyCache
end
function s.prototype.ClearAbilityStaticProperties(self, a7)
	if not IsValid(a7) then
		return
	end
	a7.__ExtraStaticPropertyList = nil
	a7.__ExtraStaticPropertyCache = nil
end
function s.prototype.RemoveSingleAbilityStaticProperty(self, a7, I, H)
	local a8 = a7.__ExtraStaticPropertyList
	local M = a8 and a8[H]
	if not M then
		return false
	end
	local U = f(M, function(D, N)
		return N.sourceId == I
	end)
	if U == -1 then
		return false
	end
	g(M, U, 1)
	if #M == 0 then
		h(a7.__ExtraStaticPropertyList, H)
		local a9 = a7.__ExtraStaticPropertyCache
		if a9 ~= nil then
			h(a9, H)
		end
		local D = true
	else
		self:RecalculateAbilityStaticProperty(a7, H)
	end
	return true
end
function s.prototype.RecalculateAbilityStaticProperty(self, a7, H)
	local u = self:GetConfig(H)
	if not u then
		return
	end
	if a7.__ExtraStaticPropertyCache == nil then
		a7.__ExtraStaticPropertyCache = {}
	end
	local aa = a7.__ExtraStaticPropertyList
	local M = aa and aa[H]
	if not M or #M == 0 then
		h(a7.__ExtraStaticPropertyCache, H)
		return
	end
	local a5 = self:GetAggregationInitialValue(u.aggregation, 0)
	for D, a6 in ipairs(M) do
		a5 = self:AggregateValues(u.aggregation, a5, a6.value, u.customAggregator)
	end
	a7.__ExtraStaticPropertyCache[H] = a5
end
function s.prototype.RegisterDynamicProperty(self, G, H, I, ab, ac, K)
	if ac == nil then
		ac = 0
	end
	if not self:ValidateProperty(H) then
		return false
	end
	local u = self:GetConfig(H)
	local L = self:GetStorage(u.scope, G)
	local M = L.dynamic[H]
	if not M then
		M = {}
		L.dynamic[H] = M
	end
	local C = f(M, function(D, N)
		return N.sourceId == I
	end)
	if C ~= -1 then
		M[C + 1].callback = ab
		M[C + 1].priority = ac
		M[C + 1].metadata = K
	else
		M[#M + 1] = { sourceId = I, callback = ab, priority = ac, addedTime = self:GetCurrentTime(), metadata = K }
	end
	i(M, function(D, ad, ae)
		return ad.priority - ae.priority
	end)
	local O = self:GetDynamicPropertyValueInternal(u.scope, G, H)
	h(L.runtimeCache, H)
	local P = self:GetDynamicPropertyValueInternal(u.scope, G, H)
	if u.notify and O ~= P then
		Event:Fire("property_changed", { scope = u.scope, key = G, propertyId = H, oldValue = O, newValue = P })
	end
	if u.syncToClient then
		self:MarkDirty(u.scope, G, H)
	end
	local af, ag = PropertyData.stats, "totalWrites"
	af[ag] = af[ag] + 1
	return true
end
function s.prototype.UnregisterDynamicProperty(self, G, I, H)
	if H then
		return self:UnregisterSingleDynamicProperty(G, I, H)
	else
		local S = false
		for T in pairs(PropertyData.configs) do
			if self:UnregisterSingleDynamicProperty(G, I, T) then
				S = true
			end
		end
		return S
	end
end
function s.prototype.UnregisterSingleDynamicProperty(self, G, I, H)
	if not self:ValidateProperty(H) then
		return false
	end
	local u = self:GetConfig(H)
	local L = self:GetStorage(u.scope, G)
	local M = L.dynamic[H]
	if not M then
		return false
	end
	local U = f(M, function(D, N)
		return N.sourceId == I
	end)
	if U ~= -1 then
		local O = self:GetDynamicPropertyValueInternal(u.scope, G, H)
		g(M, U, 1)
		if #M == 0 then
			h(L.dynamic, H)
		end
		h(L.runtimeCache, H)
		local P = self:GetDynamicPropertyValueInternal(u.scope, G, H)
		if u.notify and O ~= P then
			Event:Fire("property_changed", { scope = u.scope, key = G, propertyId = H, oldValue = O, newValue = P })
		end
		if u.syncToClient then
			self:MarkDirty(u.scope, G, H)
		end
		return true
	end
	return false
end
function s.prototype.GetDynamicPropertyValue(self, Z, G, H, ah)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	local L = self:GetStorage(Z, G)
	if u.enableCache then
		local ai = L.runtimeCache[H]
		local aj = self:GetCurrentFrame()
		if ai ~= nil then
			local ak = aj - ai.frame
			if ak <= (u.cacheDuration or 0) then
				local al, am = PropertyData.stats, "totalReads"
				al[am] = al[am] + 1
				local an, ao = PropertyData.stats, "cacheHits"
				an[ao] = an[ao] + 1
				return ai.value
			end
		end
	end
	local J = self:CalculateDynamicPropertyValue(Z, G, H, ah)
	if u.enableCache then
		L.runtimeCache[H] = { value = J, frame = self:GetCurrentFrame(), time = self:GetCurrentTime() }
	end
	local ap, aq = PropertyData.stats, "totalReads"
	ap[aq] = ap[aq] + 1
	return J
end
function s.prototype.GetDynamicPropertyValueInternal(self, Z, G, H)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	local L = self:GetStorage(Z, G)
	local ai = L.runtimeCache[H]
	return ai and ai.value or 0
end
function s.prototype.CalculateDynamicPropertyValue(self, Z, G, H, ah)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	local L = self:GetStorage(Z, G)
	local M = L.dynamic[H]
	if not M or #M == 0 then
		return 0
	end
	local a5 = self:GetAggregationInitialValue(u.aggregation, 0)
	for D, a6 in ipairs(M) do
		do
			local function ar(as)
				self:print(
					(((("Error in callback for " .. H) .. " (sourceId: ") .. a6.sourceId) .. "): ") .. tostring(as)
				)
			end
			local at, au = pcall(function()
				local J = a6:callback(ah)
				if J ~= nil then
					a5 = self:AggregateValues(u.aggregation, a5, J, u.customAggregator)
				end
			end)
			if not at then
				ar(au)
			end
		end
	end
	return a5
end
function s.prototype.ClearDynamicPropertyCache(self, Z, G, H)
	local L = self:GetStorage(Z, G)
	if H then
		h(L.runtimeCache, H)
	else
		L.runtimeCache = {}
	end
end
function s.prototype.GetPropertyValueCore(self, u, G, ah)
	local Z = u.scope
	if IsServer() then
		local av = u and u.defaultValue or 0
		local aw = self:GetStaticPropertyValue(Z, G, u.id)
		local ax = self:GetStorage(Z, G).dynamic[u.id]
		local ay = ax ~= nil and #ax > 0 and self:GetDynamicPropertyValue(Z, G, u.id, ah) or 0
		local az
		if Z == PropertyScope.UNIT then
			local aA
			if ah ~= nil then
				aA = ah.extraProperties
			end
			local aB
			if aA ~= nil then
				aB = aA[u.id]
			end
			az = aB
		else
			az = nil
		end
		local aC = az
		local a5 = self:AggregateValues(u.aggregation, ay, aw, u.customAggregator)
		if aC ~= nil then
			a5 = self:AggregateValues(u.aggregation, a5, aC, u.customAggregator)
		end
		a5 = self:AggregateValues(u.aggregation, a5, av, u.customAggregator)
		return a5
	else
		return self:GetPropertyValueFromNetTable(Z, G, u.id)
	end
end
function s.prototype.GetPropertyValueEx(self, H, V, W, ah)
	local u = self:GetConfig(H)
	if u == nil then
		return 0
	end
	local G = self:SelectKeyFromContext(u.scope, V, W)
	return self:GetPropertyValueCore(u, G, ah)
end
function s.prototype.GetPropertyValue(self, G, H, ah)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	return self:GetPropertyValueCore(u, G, ah)
end
function s.prototype.GetPropertyValueInternal(self, Z, G, H)
	local u = self:GetConfig(H)
	if not u then
		return 0
	end
	local L = self:GetStorage(Z, G)
	local av = u and u.defaultValue or 0
	local aw = L.staticCache[H] or 0
	local aD = L.runtimeCache[H]
	local ay = aD and aD.value or 0
	local a5 = self:AggregateValues(u.aggregation, ay, aw, u.customAggregator)
	a5 = self:AggregateValues(u.aggregation, a5, av, u.customAggregator)
	return a5
end
function s.prototype.InitializeNetTableSync(self)
	CustomNetTables:SetTableValue(self.NETTABLE_NAME, "init", { version = 1, time = self:GetCurrentTime() })
	Timer:GameTimer(self.SYNC_INTERVAL, function()
		self:SyncDirtyProperties()
		return self.SYNC_INTERVAL
	end)
	self:print("NetTable sync initialized")
end
function s.prototype.SyncDirtyProperties(self)
	local aE = 0
	for aF in pairs(PropertyData.dirtyKeys) do
		aE = aE + 1
	end
	if aE == 0 then
		return
	end
	local aG = j(PropertyData.dirtyKeys)
	local aH = {}
	for D, aI in ipairs(aG) do
		do
			local aJ, aK = unpack(k(aI, "|"), 1, 2)
			local Z = l(aJ)
			local G = l(aK)
			if not self:ShouldSyncEntityToClient(Z, G) then
				goto aL
			end
			local aM = (aJ .. "_") .. aK
			if aH[aM] == nil then
				aH[aM] = {}
			end
			local aN = aH[aM]
			aN[#aN + 1] = aI
		end
		::aL::
	end
	for aM, aO in pairs(aH) do
		local aP = aM
		local aQ = aO
		i(aQ, function(D, ad, ae)
			local D, D, aR = unpack(k(ad, "|"), 1, 3)
			local D, D, aS = unpack(k(ae, "|"), 1, 3)
			local aT = self:GetConfig(aR)
			local aU = self:GetConfig(aS)
			local aV = aT and aT.syncPriority or 100
			local aW = aU and aU.syncPriority or 100
			return aV - aW
		end)
		self:SyncEntityBatch(aP, aQ)
	end
	PropertyData.dirtyKeys = {}
	PropertyData.lastSyncTime = self:GetCurrentTime()
	local aX, aY = PropertyData.stats, "syncCount"
	aX[aY] = aX[aY] + 1
end
function s.prototype.ShouldSyncEntityToClient(self, Z, G)
	if Z ~= PropertyScope.UNIT then
		return true
	end
	local aZ = EntIndexToHScript(G)
	return IsValid(aZ) and aZ:IsRealHero()
end
function s.prototype.SyncEntityBatch(self, aM, a_)
	local b0 = CustomNetTables:GetTableValue(self.NETTABLE_NAME, aM)
	local b1
	if b0 then
		b1 = e({}, b0)
	else
		b1 = {}
	end
	local b2 = b1
	for D, aI in ipairs(a_) do
		local aJ, aK, H = unpack(k(aI, "|"), 1, 3)
		local Z = l(aJ)
		local G = l(aK)
		local J = self:GetPropertyValueInternal(Z, G, H)
		b2[H] = J
	end
	CustomNetTables:SetTableValue(self.NETTABLE_NAME, aM, b2)
end
function s.prototype.GetPropertyValueFromNetTable(self, Z, G, H)
	local aM = (tostring(Z) .. "_") .. tostring(G)
	local a6 = CustomNetTables:GetTableValue(self.NETTABLE_NAME, aM)
	if a6 and a6[H] ~= nil then
		return toFiniteNumber(a6[H], 0)
	end
	return 0
end
function s.prototype.ListenPropertyChange(self, Z, G, H, ab)
	if IsServer() then
		self:print("Warning: ListenPropertyChange should only be called on client")
		return nil
	end
	local b3 = self:GetPropertyValueFromNetTable(Z, G, H)
	return Timer:GameTimer(0.1, function()
		local P = self:GetPropertyValueFromNetTable(Z, G, H)
		if P ~= b3 then
			ab(b3, P)
			b3 = P
		end
		return 0.1
	end)
end
function s.prototype.CleanupSourceProperties(self, G, I)
	self:RemoveStaticProperty(G, I)
	self:UnregisterDynamicProperty(G, I)
end
function s.prototype.CleanupUnitProperties(self, aZ)
	if not aZ then
		return
	end
	local b4 = aZ:GetEntityIndex()
	self:ClearEntityDirtyKeys(PropertyScope.UNIT, b4)
	self:ClearEntityNetTable(PropertyScope.UNIT, b4)
	self:CleanupStorage(PropertyScope.UNIT, b4)
	local _ = aZ:GetPlayerOwnerID()
	if _ ~= -1 then
		self:ClearDynamicPropertyCache(PropertyScope.PLAYER, _)
	end
end
function s.prototype.CleanupPlayerProperties(self, _)
	if _ < 0 then
		return
	end
	self:CleanupStorage(PropertyScope.PLAYER, _)
end
function s.prototype.CleanupStorage(self, Z, G)
	local b5 = Z == PropertyScope.PLAYER and PropertyData.playerStorage or PropertyData.unitStorage
	local L = b5[G]
	if L ~= nil then
		L.static = {}
		L.dynamic = {}
		L.staticCache = {}
		L.runtimeCache = {}
		h(b5, G)
	end
end
function s.prototype.ClearEntityDirtyKeys(self, Z, G)
	local b6 = ((tostring(Z) .. "|") .. tostring(G)) .. "|"
	for aI in pairs(PropertyData.dirtyKeys) do
		local b7 = aI
		if string.sub(b7, 1, string.len(b6)) == b6 then
			h(PropertyData.dirtyKeys, b7)
		end
	end
end
function s.prototype.ClearEntityNetTable(self, Z, G)
	if not IsServer() then
		return
	end
	local aM = (tostring(Z) .. "_") .. tostring(G)
	CustomNetTables:SetTableValue(self.NETTABLE_NAME, aM, nil)
end
function s.prototype.CleanupInvalidModifiers(self)
	local b8 = 0
	for D, L in pairs(PropertyData.playerStorage) do
		b8 = b8 + self:CleanupStorageInvalidModifiers(L)
	end
	for D, L in pairs(PropertyData.unitStorage) do
		b8 = b8 + self:CleanupStorageInvalidModifiers(L)
	end
	if b8 > 0 then
		self:print(("Cleaned up " .. tostring(b8)) .. " invalid modifiers")
	end
	return b8
end
function s.prototype.CleanupStorageInvalidModifiers(self, L)
	return 0
end
function s.prototype.CleanupEmptyStorages(self)
	local b8 = 0
	for G, L in pairs(PropertyData.playerStorage) do
		if self:IsStorageEmpty(L) then
			h(PropertyData.playerStorage, G)
			b8 = b8 + 1
		end
	end
	for G, L in pairs(PropertyData.unitStorage) do
		local b4 = toFiniteNumber(G, -1)
		local b9
		if b4 ~= -1 then
			b9 = EntIndexToHScript(b4)
		else
			b9 = nil
		end
		local ba = b9
		if not IsValid(ba) then
			self:ClearEntityDirtyKeys(PropertyScope.UNIT, b4)
			self:ClearEntityNetTable(PropertyScope.UNIT, b4)
			h(PropertyData.unitStorage, G)
			b8 = b8 + 1
		elseif self:IsStorageEmpty(L) then
			h(PropertyData.unitStorage, G)
			b8 = b8 + 1
		end
	end
	return b8
end
function s.prototype.IsStorageEmpty(self, L)
	local bb = 0
	for aF in pairs(L.static) do
		bb = bb + 1
	end
	local bc = 0
	for aF in pairs(L.dynamic) do
		bc = bc + 1
	end
	local bd = 0
	for aF in pairs(L.staticCache) do
		bd = bd + 1
	end
	local be = 0
	for aF in pairs(L.runtimeCache) do
		be = be + 1
	end
	return bb == 0 and bc == 0 and bd == 0 and be == 0
end
function s.prototype.StartAutoCleanup(self)
	Timer:GameTimer(self.autoCleanupInterval, function()
		self:CleanupInvalidModifiers()
		self:CleanupEmptyStorages()
		return self.autoCleanupInterval
	end)
	self:print(("Auto cleanup started (" .. tostring(self.autoCleanupInterval)) .. "s)")
end
function s.prototype.ResetSystem(self)
	PropertyData.playerStorage = {}
	PropertyData.unitStorage = {}
	PropertyData.dirtyKeys = {}
	PropertyData.stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 }
end
function s.prototype.EstimateEntityNetTableSize(self, Z, G)
	local L = self:GetStorage(Z, G)
	local bf = 50
	for H in pairs(L.static) do
		local T = H
		bf = bf + #T + 10
	end
	for H in pairs(L.dynamic) do
		local T = H
		bf = bf + #T + 10
	end
	return bf
end
function s.prototype.GetNetTableSizeStats(self)
	local bg = {}
	local bh = {}
	local bi = 0
	for _ in pairs(PropertyData.playerStorage) do
		local T = _
		local bf = self:EstimateEntityNetTableSize(PropertyScope.PLAYER, T)
		local G = "PLAYER_" .. tostring(T)
		bg[G] = bf
		bi = bi + bf
		if bf > self.MAX_NETTABLE_SIZE then
			bh[#bh + 1] = ((G .. " exceeds size limit: ") .. tostring(bf)) .. " bytes"
		end
	end
	for b4 in pairs(PropertyData.unitStorage) do
		local bj = b4
		local bf = self:EstimateEntityNetTableSize(PropertyScope.UNIT, bj)
		local G = "UNIT_" .. tostring(bj)
		bg[G] = bf
		bi = bi + bf
		if bf > self.MAX_NETTABLE_SIZE then
			bh[#bh + 1] = ((G .. " exceeds size limit: ") .. tostring(bf)) .. " bytes"
		end
	end
	return { total = bi, entities = bg, warnings = bh }
end
function s.prototype.RegisterEventPropertyResponses(self)
	Event:Register("dungeon_room_complete", function(D, a6)
		if not a6.room:IsCombatRoom() then
			return
		end
		Game:EachPlayer(function(D, V)
			local bk = PlayerResource:GetSelectedHeroEntity(V)
			self:ProcessPropertyEventResponse("dungeon_room_complete", a6.room:GetRoomKey(), V, bk and bk:entindex())
			local bl = GetExpRewardPerEncounter(V)
			local bm = GetGoldRewardPerEncounter(V)
			if bm > 0 then
				Player:ModifyGold(V, bm)
			end
			if bl > 0 then
				Player:AddExperience(V, bl)
			end
			local bn = GetHpRegenPerEncounter(V)
			if IsValid(bk) and bn > 0 then
				bk:Heal(bn, nil)
				local bo = ParticleManager:CreateParticleForce(
					"particles/items3_fx/fish_bones_active.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					bk
				)
				ParticleManager:ReleaseParticleIndex(bo)
				bk:EmitSound("DOTA_Item.HealingSalve.Activate")
			end
			local bp = GetManaRegenPerEncounter(V)
			if IsValid(bk) and bp > 0 then
				bk:GiveMana(bp)
				local bo = ParticleManager:CreateParticleForce(
					"particles/items3_fx/fury_active.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					bk
				)
				ParticleManager:ReleaseParticleIndex(bo)
				bk:EmitSound("DOTA_Item.HealingSalve.Activate")
			end
		end)
	end)
	Event:Register("hero_level_up", function(D, a6)
		local V = a6.unit:GetPlayerOwnerID()
		self:ProcessPropertyEventResponse("hero_level_up", a6.level, V, a6.unit:entindex())
	end)
end
function s.prototype.ProcessPropertyEventResponse(self, bq, br, V, W)
	local bs = PropertyData.eventPropertyResponses[bq]
	if not bs or #bs == 0 then
		return
	end
	local I = (bq .. "_") .. tostring(br)
	for D, E in ipairs(bs) do
		local bt = self:GetPropertyValueEx(E.sourcePropertyId, V, W)
		if bt > 0 then
			self:AddStaticPropertyEx(E.targetPropertyId, I, bt, V, W)
		end
	end
end
function s.prototype.RegisterDebugCommands(self)
	Convars:RegisterCommand("property_status", function()
		self:PrintSystemStatus()
	end, "Print property system status", 0)
	Convars:RegisterCommand("property_stats", function()
		self:PrintPerformanceStats()
	end, "Print performance statistics", 0)
	Convars:RegisterCommand("property_reset_stats", function()
		PropertyData.stats = { totalReads = 0, cacheHits = 0, totalWrites = 0, syncCount = 0 }
		self:print("Stats reset")
	end, "Reset performance statistics", 0)
	Convars:RegisterCommand("property_list", function()
		self:print("=== Registered Properties ===")
		for bu, u in pairs(PropertyData.configs) do
			local X = bu
			self:print((((X .. ": scope=") .. PropertyScope[u.scope]) .. ", type=") .. PropertyValueType[u.valueType])
		end
	end, "List all registered properties", 0)
	Convars:RegisterCommand("property_cleanup", function()
		local bv = self:CleanupInvalidModifiers()
		local bw = self:CleanupEmptyStorages()
		self:print(((("Cleaned: " .. tostring(bv)) .. " modifiers, ") .. tostring(bw)) .. " storages")
	end, "Force cleanup invalid modifiers", 0)
	Convars:RegisterCommand("property_nettable_size", function()
		local bx = self:GetNetTableSizeStats()
		self:print("=== NetTable Size Stats ===")
		self:print(("Total: " .. tostring(bx.total)) .. " bytes")
		self:print("Entities: " .. tostring(bx.entities.size))
		if #bx.warnings > 0 then
			self:print("⚠️ WARNINGS:")
			for D, by in ipairs(bx.warnings) do
				self:print("  " .. by)
			end
		end
		local bz = {}
		for bA, bB in pairs(bx.entities) do
			bz[#bz + 1] = { bA, bB }
		end
		local bC = i(bz, function(D, ad, ae)
			return ae[2] - ad[2]
		end)
		self:print("\nTop 10 largest entities:")
		do
			local bD = 0
			while bD < math.min(10, #bC) do
				self:print(((("  " .. bC[bD + 1][1]) .. ": ") .. tostring(bC[bD + 1][2])) .. " bytes")
				bD = bD + 1
			end
		end
	end, "Show NetTable size statistics", 0)
	self:print("Debug commands registered")
end
function s.prototype.PrintSystemStatus(self)
	local bE = 0
	for aF in pairs(PropertyData.configs) do
		bE = bE + 1
	end
	local bF = 0
	for aF in pairs(PropertyData.playerStorage) do
		bF = bF + 1
	end
	local bG = 0
	for aF in pairs(PropertyData.unitStorage) do
		bG = bG + 1
	end
	local aE = 0
	for aF in pairs(PropertyData.dirtyKeys) do
		aE = aE + 1
	end
	self:print("=== Property System Status ===")
	self:print("Registered Properties: " .. tostring(bE))
	self:print("Player Storages: " .. tostring(bF))
	self:print("Unit Storages: " .. tostring(bG))
	self:print("Dirty Keys: " .. tostring(aE))
	self:print(("Last Sync: " .. m(PropertyData.lastSyncTime, 2)) .. "s")
end
function s.prototype.PrintPerformanceStats(self)
	local bx = PropertyData.stats
	local bH = bx.totalReads > 0 and m(bx.cacheHits / bx.totalReads * 100, 2) or "0.00"
	self:print("=== Performance Stats ===")
	self:print("Total Reads: " .. tostring(bx.totalReads))
	self:print(((("Cache Hits: " .. tostring(bx.cacheHits)) .. " (") .. bH) .. "%)")
	self:print("Total Writes: " .. tostring(bx.totalWrites))
	self:print("Sync Count: " .. tostring(bx.syncCount))
end
function s.prototype.GetStorage(self, Z, G)
	local b5 = Z == PropertyScope.PLAYER and PropertyData.playerStorage or PropertyData.unitStorage
	local L = b5[G]
	if not L then
		L = { static = {}, dynamic = {}, staticCache = {}, runtimeCache = {} }
		b5[G] = L
	end
	return L
end
function s.prototype.GetConfig(self, H)
	return PropertyData.configs[H]
end
function s.prototype.GetScopeOfProperty(self, H)
	local u = self:GetConfig(H)
	return u and u.scope or nil
end
function s.prototype.AggregatePropertyValues(self, H, bI, J)
	local u = PropertyData.configs[H]
	if u == nil then
		return bI + J
	end
	return self:AggregateValues(u.aggregation, bI, J, u.customAggregator)
end
function s.prototype.ValidateProperty(self, H)
	if PropertyData.configs[H] == nil then
		self:print(("Error: Property " .. H) .. " not registered")
		return false
	end
	return true
end
function s.prototype.GetEntityContext(self, ba)
	if not ba or not IsValid(ba) then
		return nil
	end
	if ba.IsPlayer and ba:IsPlayer() then
		local _ = ba:GetPlayerID()
		return { PropertyScope.PLAYER, _ }
	end
	if ba.IsBaseNPC and ba:IsBaseNPC() then
		return { PropertyScope.UNIT, ba:GetEntityIndex() }
	end
	return nil
end
function s.prototype.AggregateValues(self, bJ, bI, J, bK)
	repeat
		local bL = bJ
		local bM = bL == AggregationStrategy.SUM
		if bM then
			return bI + J
		end
		bM = bM or bL == AggregationStrategy.MULTIPLY
		if bM then
			return ((1 + bI * 0.01) * (1 + J * 0.01) - 1) * 100
		end
		bM = bM or bL == AggregationStrategy.DECMUL
		if bM then
			return (1 - (1 - bI * 0.01) * (1 - J * 0.01)) * 100
		end
		bM = bM or bL == AggregationStrategy.MAX
		if bM then
			return math.max(bI, J)
		end
		bM = bM or bL == AggregationStrategy.MIN
		if bM then
			return math.min(bI, J)
		end
		bM = bM or bL == AggregationStrategy.FIRST
		if bM then
			return bI ~= 0 and bI or J
		end
		bM = bM or bL == AggregationStrategy.LAST
		if bM then
			return J
		end
		bM = bM or bL == AggregationStrategy.CUSTOM
		if bM then
			if bK then
				return bK(nil, bI, J)
			end
			return bI + J
		end
		do
			return bI + J
		end
	until true
end
function s.prototype.GetAggregationInitialValue(self, bJ, av)
	repeat
		local bN = bJ
		local bO = bN == AggregationStrategy.MAX
		if bO then
			return -math.huge
		end
		bO = bO or bN == AggregationStrategy.MIN
		if bO then
			return math.huge
		end
		bO = bO or (bN == AggregationStrategy.FIRST or bN == AggregationStrategy.LAST)
		if bO then
			return av
		end
		do
			return av
		end
	until true
end
function s.prototype.GetDirtyKey(self, Z, G, H)
	return (((tostring(Z) .. "|") .. tostring(G)) .. "|") .. H
end
function s.prototype.MarkDirty(self, Z, G, H)
	local aI = self:GetDirtyKey(Z, G, H)
	PropertyData.dirtyKeys[aI] = true
end
function s.prototype.GetCurrentFrame(self)
	return GameRules:GetDOTATime(false, false)
end
function s.prototype.GetCurrentTime(self)
	return GameRules:GetGameTime()
end
function s.prototype.ForceSyncAllDirty(self)
	if not IsServer() then
		return
	end
	local bP = 0
	for aF in pairs(PropertyData.dirtyKeys) do
		bP = bP + 1
	end
	if bP == 0 then
		return
	end
	self:print(("[ForceSyncAllDirty] Syncing " .. tostring(bP)) .. " dirty properties...")
	self:SyncDirtyProperties()
	local bQ = 0
	for aF in pairs(PropertyData.dirtyKeys) do
		bQ = bQ + 1
	end
	self:print("[ForceSyncAllDirty] Sync completed, remaining: " .. tostring(bQ))
end
s = n({ r }, s)
if PropertySystem == nil then
	PropertySystem = o(s)
end
return p