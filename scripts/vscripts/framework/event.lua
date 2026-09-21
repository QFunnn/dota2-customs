--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "framework/event"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__Delete
local f = b.__TS__New
local g = b.__TS__ObjectKeys
local h = b.__TS__DecorateLegacy
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = c()
l.name = "EventRateLimiter"
function l.prototype.____constructor(self) end
function l.prototype.Allow(self, m, n, o)
	if o then
		return false
	end
	if self.lastTrigger ~= nil and m - self.lastTrigger < n then
		return false
	end
	self.lastTrigger = m
	return true
end
local p = c()
p.name = "MEvent"
d(p, CModule)
function p.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.eventId = 1
	self.eventIdMap = {}
end
function p.prototype.initPriority(self)
	return 9
end
function p.prototype.init(self, q)
	if not q then
	else
		self:cleanupModuleListeners()
	end
end
function p.prototype.reset(self) end
function p.prototype.cleanupModuleListeners(self)
	self:print("cleanupModuleListeners")
	for r, s in pairs(self.eventIdMap) do
		do
			local t = #s - 1
			while t >= 0 do
				local u = s[t + 1]
				local v = u.context
				if v ~= nil then
					v = v.isModule
				end
				if v == true then
					table.remove(s, t + 1)
				end
				t = t - 1
			end
		end
		if #s == 0 then
			e(self.eventIdMap, r)
		end
	end
end
function p.prototype.Register(self, r, w, x, y)
	local z, A = self.eventIdMap, r
	if z[A] == nil then
		z[A] = {}
	end
	local B, C = self, "eventId"
	local D = B[C]
	B[C] = D + 1
	local E = D
	local u = { context = x, eventID = E, callback = w, filter = y }
	local F = self.eventIdMap[r]
	F[#F + 1] = u
	return E
end
function p.prototype.RegisterForOwner(self, r, w, G, x, H)
	local y
	if
		(H and H.ownerFilter) ~= false
		and (r == "damage_event" or r == "crit_event" or r == "expose_effect" or r == "lightning_strike")
	then
		y = function(I, J)
			if not IsValid(G) then
				return false
			end
			local K = G:GetPlayerOwnerID()
			local function L(I, M)
				if M == G then
					return true
				end
				if K >= 0 and IsValid(M) and M:GetPlayerOwnerID() == K then
					return true
				end
				return false
			end
			return L(nil, J.attacker) or L(nil, J.target) or L(nil, J.caster)
		end
	end
	if (H and H.cooldown) ~= nil then
		local N = y
		local O = f(l)
		y = function(I, J)
			return (not N or N(nil, J))
				and O:Allow(
					GameRules:GetGameTime(),
					H.cooldown,
					H.allowNested == false and (G.__eventProcDepth or 0) > 0
				)
		end
		local P = w
		w = function(self, J)
			G.__eventProcDepth = (G.__eventProcDepth or 0) + 1
			do
				local Q, R = pcall(function()
					P(self, J)
				end)
				do
					G.__eventProcDepth = math.max(0, (G.__eventProcDepth or 1) - 1)
				end
				if not Q then
					error(R, 0)
				end
			end
		end
	end
	return self:Register(r, w, x, y)
end
function p.prototype.RegisterWithPriority(self, r, w, S, x)
	if S == nil then
		S = 100
	end
	local T, U = self.eventIdMap, r
	if T[U] == nil then
		T[U] = {}
	end
	local V, W = self, "eventId"
	local X = V[W]
	V[W] = X + 1
	local E = X
	local u = { context = x, eventID = E, callback = w, priority = S }
	local s = self.eventIdMap[r]
	local Y = #s
	do
		local t = 0
		while t < #s do
			local Z = s[t + 1].priority or 100
			if S < Z then
				Y = t
				break
			end
			t = t + 1
		end
	end
	table.insert(s, Y + 1, u)
	return E
end
function p.prototype.Unregister(self, _)
	for r, s in pairs(self.eventIdMap) do
		do
			local t = #s - 1
			while t >= 0 do
				if s[t + 1].eventID == _ then
					table.remove(s, t + 1)
					if #s == 0 then
						e(self.eventIdMap, r)
					end
					return true
				end
				t = t - 1
			end
		end
	end
	return false
end
function p.prototype.UnregisterContext(self, x)
	local a0 = 0
	for r, s in pairs(self.eventIdMap) do
		do
			local t = #s - 1
			while t >= 0 do
				if s[t + 1].context == x then
					table.remove(s, t + 1)
					a0 = a0 + 1
				end
				t = t - 1
			end
		end
		if #s == 0 then
			e(self.eventIdMap, r)
		end
	end
	return a0
end
function p.prototype.UnregisterAll(self, r)
	local s = self.eventIdMap[r]
	if not s then
		return 0
	end
	local a0 = #s
	e(self.eventIdMap, r)
	return a0
end
function p.prototype.HasListeners(self, r)
	local s = self.eventIdMap[r]
	return s ~= nil and #s > 0
end
function p.prototype.GetListenerCount(self, r)
	if r ~= nil then
		local a1 = self.eventIdMap[r]
		return a1 and #a1 or 0
	end
	local a2 = 0
	for a3, s in pairs(self.eventIdMap) do
		a2 = a2 + #s
	end
	return a2
end
function p.prototype.Fire(self, r, J)
	local s = self.eventIdMap[r]
	if not s or #s == 0 then
		return
	end
	local a4
	do
		local t = #s - 1
		while t >= 0 do
			do
				local u = s[t + 1]
				if not u or not u.callback then
					table.remove(s, t + 1)
					goto a5
				end
				if u.filter ~= nil and not u:filter(J) then
					goto a5
				end
				local a6, a7 = xpcall(u.callback, traceback, u.context, J)
				if not a6 then
					if a4 == nil then
						a4 = {}
					end
					a4[#a4 + 1] = { eventID = u.eventID, error = a7 }
					print(
						(((("Event listener error:\nType: " .. r) .. "\nID: ") .. tostring(u.eventID)) .. "\nError: ")
							.. tostring(a7)
					)
				end
			end
			::a5::
			t = t - 1
		end
	end
	if #s == 0 then
		e(self.eventIdMap, r)
	end
	return a4
end
function p.prototype.Once(self, r, w, x)
	local E
	local function a8(I, J)
		w(x, J)
		self:Unregister(E)
	end
	E = self:Register(r, a8, x)
	return E
end
function p.prototype.FireClient(self, a9, r, J)
	local aa = PlayerResource:GetPlayer(a9)
	if aa ~= nil then
		CustomGameEventManager:Send_ServerToPlayer(
			aa,
			"lua_server_to_client",
			{ event_name = r, data = json.encode(J) }
		)
	end
end
function p.prototype.RegisterFiltered(self, r, y, w, x)
	local function a8(I, J)
		if y(nil, J) then
			w(x, J)
		end
	end
	return self:Register(r, a8, x)
end
function p.prototype.DebugPrint(self)
	if IsDedicatedServer() then
		return
	end
	print("=== Event System Debug ===")
	print("Total event types: " .. tostring(#g(self.eventIdMap)))
	print("Total listeners: " .. tostring(self:GetListenerCount()))
	print("Next event ID: " .. tostring(self.eventId))
	print("")
	for r, s in pairs(self.eventIdMap) do
		print(((("[" .. r) .. "] (") .. tostring(#s)) .. " listeners)")
		for I, u in ipairs(s) do
			local ab = u.context
			if ab ~= nil then
				ab = ab.constructor
			end
			local ac
			if ab ~= nil then
				ac = ab.name
			end
			local ad = ac
			if ad == nil then
				local ae = u.context
				if ae ~= nil then
					ae = ae.isModule
				end
				ad = ae and "Module" or "Global"
			end
			local af = ad
			local S = u.priority or 100
			print(
				(((("  - ID:" .. tostring(u.eventID)) .. " Priority:") .. tostring(S)) .. " Context:") .. tostring(af)
			)
		end
		print("")
	end
	print("========================")
end
function p.prototype.GetMemoryStats(self)
	local ag = 0
	local ah = 0
	for a3, s in pairs(self.eventIdMap) do
		ah = ah + 1
		ag = ag + #s
	end
	return { eventTypes = ah, listeners = ag, avgListenersPerType = ah > 0 and ag / ah or 0 }
end
p = h({ k }, p)
if Event == nil then
	Event = f(p)
end
return i