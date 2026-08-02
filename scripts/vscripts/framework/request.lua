--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "framework/request"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringStartsWith
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = c()
k.name = "MRequest"
d(k, CModule)
function k.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.tEvents = {}
end
function k.prototype.initPriority(self)
	return 2
end
function k.prototype.init(self, l)
	if IsServer() then
		CustomUIEvent("server_request_event", function(self, ...)
			return self:OnServerEvent(...)
		end, self)
		CustomUIEvent("cancel_server_request_event", function(self, m)
			local n = m.PlayerID
			local o = CustomNetTables.GetTableValue
			local p = CustomNetTables:GetAllTableKeys("request_" .. tostring(n))
			for o, q in ipairs(p) do
				if e(q, m.queueIndex) then
					CustomNetTables:SetTableValue("request_" .. tostring(n), q, nil)
				end
			end
		end, self)
	else
		GameEvent("client_request_event", function(self, ...)
			return self:OnClientEvent(...)
		end, self)
	end
end
function k.prototype.RegisterServerEvent(self, r, s, t)
	self.tEvents[r] = { callback = s, context = t }
end
function k.prototype.FireServerEvent(self, r, u, v)
	self:OnServerEvent({ event = r, PlayerID = u, data = json.encode(v), queueIndex = "", _IsFire = true })
end
function k.prototype.OnServerEvent(self, m)
	local w = PlayerResource:GetPlayer(m.PlayerID or -1)
	if w == nil then
		return
	end
	local x = self.tEvents[m.event]
	if x == nil then
		return
	end
	local v = json.decode(m.data)
	if v == nil then
		return
	end
	coroutine.wrap(function()
		local y, z = xpcall(function()
			v.PlayerID = m.PlayerID
			local A
			local s = x.callback
			if x.context ~= nil then
				A = s(x.context, v)
			else
				A = s(v)
			end
			if m._IsFire ~= true and type(A) == "table" then
				local B = 8192
				local C = json.encode(A)
				local D = #C
				local E = math.ceil(D / B)
				local F = 1
				local G = m.queueIndex
				local H = ""
				for I = 1, E, 1 do
					local J = Clamp((I - 1) * B + 1, 1, D)
					local K = Clamp(I * B, 1, D)
					H = H .. string.sub(C, J, K)
					CustomNetTables:SetTableValue(
						"request_" .. tostring(v.PlayerID),
						(G .. "_____") .. tostring(F),
						{ result = string.sub(C, J, K), maxStep = E, nowStep = F }
					)
					F = F + 1
				end
			end
		end, traceback)
		assert(y, z)
	end)()
end
function k.prototype.RegisterClientEvent(self, r, s, t)
	self.tEvents[r] = { callback = s, context = t }
end
function k.prototype.FireClientEvent(self, r, u, v)
	self:OnClientEvent({
		game_event_listener = -1,
		game_event_name = "",
		splitscreenplayer = GetLocalPlayerID(),
		event = r,
		data = json.encode(v),
		_IsFire = true,
	})
end
function k.prototype.OnClientEvent(self, L)
	local M = self.tEvents[L.event]
	if M == nil then
		return
	end
	local v = json.decode(L.data)
	if v == nil then
		return
	end
	local A
	local s = M.callback
	if M.context ~= nil then
		A = s(M.context, v)
	else
		A = s(v)
	end
	if L._IsFire ~= true and type(A) == "table" then
		local C = json.encode(A)
		_G.ClientRequestEventResult = C
	end
end
k = f({ j }, k)
if Request == nil then
	Request = g(k)
end
return h