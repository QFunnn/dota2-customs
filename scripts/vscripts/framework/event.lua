--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/event"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__ObjectKeys
local g = b.__TS__DecorateLegacy
local h = b.__TS__New
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = c()
l.name = "MEvent"
d(l, CModule)
function l.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.eventId = 1
	self.eventIdMap = {}
end
function l.prototype.initPriority(self)
	return 9
end
function l.prototype.init(self, m)
	if not m then
	else
		self:cleanupModuleListeners()
	end
end
function l.prototype.reset(self) end
function l.prototype.cleanupModuleListeners(self)
	self:print("cleanupModuleListeners")
	for n, o in pairs(self.eventIdMap) do
		do
			local p = #o - 1
			while p >= 0 do
				local q = o[p + 1]
				local r = q.context
				if r ~= nil then
					r = r.isModule
				end
				if r == true then
					table.remove(o, p + 1)
				end
				p = p - 1
			end
		end
		if #o == 0 then
			e(self.eventIdMap, n)
		end
	end
end
function l.prototype.Register(self, n, s, t, u)
	local v, w = self.eventIdMap, n
	if v[w] == nil then
		v[w] = {}
	end
	local x, y = self, "eventId"
	local z = x[y]
	x[y] = z + 1
	local A = z
	local q = { context = t, eventID = A, callback = s, filter = u }
	local B = self.eventIdMap[n]
	B[#B + 1] = q
	return A
end
function l.prototype.RegisterForOwner(self, n, s, C, t)
	local u
	if n == "damage_event" or n == "crit_event" or n == "expose_effect" or n == "lightning_strike" then
		u = function(D, E)
			if not IsValid(C) then
				return false
			end
			local F = C:GetPlayerOwnerID()
			local function G(D, H)
				if H == C then
					return true
				end
				if F >= 0 and IsValid(H) and H:GetPlayerOwnerID() == F then
					return true
				end
				return false
			end
			return G(nil, E.attacker) or G(nil, E.target) or G(nil, E.caster)
		end
	end
	return self:Register(n, s, t, u)
end
function l.prototype.RegisterWithPriority(self, n, s, I, t)
	if I == nil then
		I = 100
	end
	local J, K = self.eventIdMap, n
	if J[K] == nil then
		J[K] = {}
	end
	local L, M = self, "eventId"
	local N = L[M]
	L[M] = N + 1
	local A = N
	local q = { context = t, eventID = A, callback = s, priority = I }
	local o = self.eventIdMap[n]
	local O = #o
	do
		local p = 0
		while p < #o do
			local P = o[p + 1].priority or 100
			if I < P then
				O = p
				break
			end
			p = p + 1
		end
	end
	table.insert(o, O + 1, q)
	return A
end
function l.prototype.Unregister(self, Q)
	for n, o in pairs(self.eventIdMap) do
		do
			local p = #o - 1
			while p >= 0 do
				if o[p + 1].eventID == Q then
					table.remove(o, p + 1)
					if #o == 0 then
						e(self.eventIdMap, n)
					end
					return true
				end
				p = p - 1
			end
		end
	end
	return false
end
function l.prototype.UnregisterContext(self, t)
	local R = 0
	for n, o in pairs(self.eventIdMap) do
		do
			local p = #o - 1
			while p >= 0 do
				if o[p + 1].context == t then
					table.remove(o, p + 1)
					R = R + 1
				end
				p = p - 1
			end
		end
		if #o == 0 then
			e(self.eventIdMap, n)
		end
	end
	return R
end
function l.prototype.UnregisterAll(self, n)
	local o = self.eventIdMap[n]
	if not o then
		return 0
	end
	local R = #o
	e(self.eventIdMap, n)
	return R
end
function l.prototype.HasListeners(self, n)
	local o = self.eventIdMap[n]
	return o ~= nil and #o > 0
end
function l.prototype.GetListenerCount(self, n)
	if n ~= nil then
		local S = self.eventIdMap[n]
		return S and #S or 0
	end
	local T = 0
	for U, o in pairs(self.eventIdMap) do
		T = T + #o
	end
	return T
end
function l.prototype.Fire(self, n, E)
	local o = self.eventIdMap[n]
	if not o or #o == 0 then
		return
	end
	local V = BlessPerformance
		and BlessPerformance.Enabled
		and (n == "damage_event" or n == "crit_event" or n == "expose_effect" or n == "lightning_strike")
	if V then
		BlessPerformance:Increment("event_fires")
	end
	local W
	do
		local p = #o - 1
		while p >= 0 do
			do
				local q = o[p + 1]
				if not q or not q.callback then
					table.remove(o, p + 1)
					goto X
				end
				if q.filter ~= nil and not q:filter(E) then
					goto X
				end
				if V then
					BlessPerformance:Increment("event_listener_calls")
				end
				local Y, Z = xpcall(q.callback, traceback, q.context, E)
				if not Y then
					if W == nil then
						W = {}
					end
					W[#W + 1] = { eventID = q.eventID, error = Z }
					print(
						(((("Event listener error:\nType: " .. n) .. "\nID: ") .. tostring(q.eventID)) .. "\nError: ")
							.. tostring(Z)
					)
				end
			end
			::X::
			p = p - 1
		end
	end
	if #o == 0 then
		e(self.eventIdMap, n)
	end
	return W
end
function l.prototype.Once(self, n, s, t)
	local A
	local function _(D, E)
		s(t, E)
		self:Unregister(A)
	end
	A = self:Register(n, _, t)
	return A
end
function l.prototype.FireClient(self, a0, n, E)
	local a1 = PlayerResource:GetPlayer(a0)
	if a1 ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			a1,
			"lua_server_to_client",
			{ event_name = n, data = json.encode(E) }
		)
	end
end
function l.prototype.RegisterFiltered(self, n, u, s, t)
	local function _(D, E)
		if u(nil, E) then
			s(t, E)
		end
	end
	return self:Register(n, _, t)
end
function l.prototype.DebugPrint(self)
	if IsDedicatedServer() then
		return
	end
	print("=== Event System Debug ===")
	print("Total event types: " .. tostring(#f(self.eventIdMap)))
	print("Total listeners: " .. tostring(self:GetListenerCount()))
	print("Next event ID: " .. tostring(self.eventId))
	print("")
	for n, o in pairs(self.eventIdMap) do
		print(((("[" .. n) .. "] (") .. tostring(#o)) .. " listeners)")
		for D, q in ipairs(o) do
			local a2 = q.context
			if a2 ~= nil then
				a2 = a2.constructor
			end
			local a3
			if a2 ~= nil then
				a3 = a2.name
			end
			local a4 = a3
			if a4 == nil then
				local a5 = q.context
				if a5 ~= nil then
					a5 = a5.isModule
				end
				a4 = a5 and "Module" or "Global"
			end
			local a6 = a4
			local I = q.priority or 100
			print(
				(((("  - ID:" .. tostring(q.eventID)) .. " Priority:") .. tostring(I)) .. " Context:") .. tostring(a6)
			)
		end
		print("")
	end
	print("========================")
end
function l.prototype.GetMemoryStats(self)
	local a7 = 0
	local a8 = 0
	for U, o in pairs(self.eventIdMap) do
		a8 = a8 + 1
		a7 = a7 + #o
	end
	return { eventTypes = a8, listeners = a7, avgListenersPerType = a8 > 0 and a7 / a8 or 0 }
end
l = g({ k }, l)
if Event == nil then
	Event = h(l)
end
return i