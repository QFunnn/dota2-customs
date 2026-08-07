--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "request"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSlice
local f = b.__TS__DecorateLegacy
local g = b.__TS__New
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 11,
		["19"] = 11,
		["20"] = 11,
		["21"] = 11,
		["22"] = 11,
		["23"] = 11,
		["24"] = 11,
		["26"] = 13,
		["27"] = 13,
		["28"] = 13,
		["29"] = 13,
		["30"] = 13,
		["31"] = 13,
		["32"] = 13,
		["34"] = 7,
		["35"] = 25,
		["36"] = 26,
		["37"] = 25,
		["38"] = 32,
		["39"] = 33,
		["40"] = 33,
		["41"] = 33,
		["42"] = 33,
		["43"] = 33,
		["44"] = 33,
		["45"] = 33,
		["46"] = 32,
		["47"] = 42,
		["48"] = 43,
		["49"] = 44,
		["52"] = 46,
		["53"] = 47,
		["56"] = 49,
		["57"] = 50,
		["60"] = 52,
		["61"] = 53,
		["62"] = 53,
		["63"] = 54,
		["64"] = 55,
		["65"] = 57,
		["66"] = 58,
		["67"] = 59,
		["68"] = 60,
		["70"] = 62,
		["72"] = 64,
		["73"] = 65,
		["75"] = 53,
		["76"] = 53,
		["77"] = 53,
		["78"] = 68,
		["79"] = 52,
		["80"] = 42,
		["81"] = 72,
		["82"] = 73,
		["83"] = 74,
		["84"] = 75,
		["85"] = 76,
		["86"] = 77,
		["87"] = 78,
		["90"] = 79,
		["91"] = 79,
		["92"] = 79,
		["93"] = 79,
		["94"] = 80,
		["95"] = 80,
		["96"] = 80,
		["97"] = 80,
		["98"] = 80,
		["99"] = 80,
		["100"] = 80,
		["101"] = 80,
		["102"] = 80,
		["103"] = 80,
		["104"] = 79,
		["105"] = 79,
		["106"] = 79,
		["107"] = 79,
		["108"] = 72,
		["109"] = 97,
		["110"] = 98,
		["111"] = 97,
		["112"] = 104,
		["113"] = 105,
		["114"] = 105,
		["115"] = 105,
		["116"] = 105,
		["117"] = 105,
		["118"] = 105,
		["119"] = 105,
		["120"] = 105,
		["121"] = 105,
		["122"] = 105,
		["123"] = 104,
		["124"] = 119,
		["125"] = 120,
		["126"] = 121,
		["129"] = 123,
		["130"] = 124,
		["133"] = 126,
		["134"] = 127,
		["135"] = 128,
		["136"] = 129,
		["138"] = 131,
		["140"] = 133,
		["141"] = 134,
		["142"] = 135,
		["143"] = 136,
		["144"] = 137,
		["146"] = 139,
		["149"] = 119,
		["150"] = 3,
		["151"] = 147,
		["152"] = 148,
	}
)
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = c()
l.name = "CRequest"
d(l, CModule)
function l.prototype.init(self, m)
	self.tEvents = {}
	if IsServer() then
		CustomUIEvent("server_request", function(self, ...)
			return self:OnServerEvent(...)
		end, self)
	else
		GameEvent("client_request_event", function(self, ...)
			return self:OnClientEvent(...)
		end, self)
	end
end
function l.prototype.RegisterServerEvent(self, n, o, p)
	self.tEvents[n] = { callback = o, context = p }
end
function l.prototype.FireServerEvent(self, n, q, r)
	self:OnServerEvent({ event = n, PlayerID = q, data = json.encode(r), queueIndex = "", _IsFire = true })
end
function l.prototype.OnServerEvent(self, s)
	local t = PlayerResource:GetPlayer(s.PlayerID or -1)
	if t == nil then
		return
	end
	local u = self.tEvents[s.event]
	if u == nil then
		return
	end
	local r = json.decode(s.data)
	if r == nil then
		return
	end
	coroutine.wrap(function()
		local v, w = xpcall(function()
			r.PlayerID = s.PlayerID
			r.queueIndex = s.queueIndex
			local x
			local o = u.callback
			if u.context ~= nil then
				x = o(u.context, r)
			else
				x = o(r)
			end
			if s._IsFire ~= true and type(x) == "table" then
				Request:RequestResponse(s.PlayerID, s.queueIndex, x)
			end
		end, debug.traceback)
		assert(v, w)
	end)()
end
function l.prototype.RequestResponse(self, y, z, x)
	local A = json.encode(x)
	local B = #A
	local C = 102400
	local D = math.ceil(B / C)
	local t = PlayerResource:GetPlayer(y or -1)
	if t == nil then
		return
	end
	ForWithInterval(GameRules:GetGameFrameTime(), D, function(E)
		CustomGameEventManager:Send_ServerToPlayer(
			t,
			"server_request_res",
			{ data = e(A, (E - 1) * C, E * C), queueIndex = z, step = E - 1, done = E == D and 1 or 0 }
		)
	end, false, false)
end
function l.prototype.RegisterClientEvent(self, n, o, p)
	self.tEvents[n] = { callback = o, context = p }
end
function l.prototype.FireClientEvent(self, n, q, r)
	self:OnClientEvent({
		game_event_listener = -1,
		game_event_name = "",
		splitscreenplayer = GetLocalPlayerID(),
		event = n,
		data = json.encode(r),
		queueIndex = "",
		quickReturn = 0,
		_IsFire = true,
	})
end
function l.prototype.OnClientEvent(self, s)
	local u = self.tEvents[s.event]
	if u == nil then
		return
	end
	local r = json.decode(s.data)
	if r == nil then
		return
	end
	local x
	local o = u.callback
	if u.context ~= nil then
		x = o(u.context, r)
	else
		x = o(r)
	end
	if s._IsFire ~= true and type(x) == "table" then
		local F = json.encode(x)
		if s.quickReturn == 0 then
			local z = s.queueIndex
			SendToConsole(((("client_request_event_result " .. z) .. ' "') .. F) .. '"')
		else
			_G.ClientRequestEventResult = F
		end
	end
end
l = f({ k }, l)
if _G.Request == nil then
	_G.Request = g(l)
end
return i