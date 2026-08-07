--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "mechanics/timer"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArraySort
local g = b.__TS__Delete
local h = b.__TS__DecorateLegacy
local i = b.__TS__New
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["15"] = 10,
		["16"] = 10,
		["17"] = 11,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 20,
		["23"] = 10,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 25,
		["28"] = 22,
		["29"] = 28,
		["30"] = 29,
		["31"] = 30,
		["32"] = 31,
		["33"] = 33,
		["35"] = 34,
		["36"] = 36,
		["37"] = 38,
		["38"] = 39,
		["40"] = 42,
		["41"] = 43,
		["43"] = 46,
		["44"] = 48,
		["45"] = 49,
		["47"] = 51,
		["48"] = 53,
		["49"] = 54,
		["50"] = 55,
		["51"] = 56,
		["52"] = 59,
		["53"] = 60,
		["54"] = 62,
		["56"] = 65,
		["62"] = 28,
		["63"] = 71,
		["64"] = 72,
		["65"] = 81,
		["66"] = 82,
		["67"] = 83,
		["68"] = 84,
		["69"] = 85,
		["70"] = 85,
		["71"] = 85,
		["72"] = 86,
		["73"] = 87,
		["74"] = 88,
		["75"] = 89,
		["76"] = 90,
		["77"] = 91,
		["79"] = 93,
		["80"] = 94,
		["81"] = 95,
		["82"] = 96,
		["83"] = 97,
		["85"] = 99,
		["86"] = 85,
		["87"] = 85,
		["89"] = 71,
		["90"] = 104,
		["91"] = 105,
		["92"] = 106,
		["93"] = 106,
		["94"] = 106,
		["95"] = 106,
		["96"] = 106,
		["97"] = 106,
		["98"] = 106,
		["99"] = 113,
		["100"] = 114,
		["101"] = 104,
		["102"] = 118,
		["103"] = 119,
		["104"] = 120,
		["105"] = 121,
		["106"] = 122,
		["108"] = 124,
		["109"] = 118,
		["110"] = 128,
		["111"] = 129,
		["112"] = 130,
		["113"] = 131,
		["114"] = 132,
		["116"] = 134,
		["117"] = 128,
		["118"] = 138,
		["119"] = 139,
		["120"] = 138,
		["121"] = 143,
		["122"] = 144,
		["123"] = 145,
		["125"] = 143,
		["126"] = 10,
		["127"] = 154,
		["128"] = 155,
	}
)
local k = {}
local l = require("lib.tstl-utils")
local m = l.reloadable
local n = c()
n.name = "CTimer"
d(n, CModule)
function n.prototype.____constructor(self, ...)
	CModule.prototype.____constructor(self, ...)
	self.index = 1
	self.timerList = {}
	self.record = 0
end
function n.prototype.reset(self)
	self.index = 1
	self.timerList = {}
	self.record = 0
end
function n.prototype.Think(self)
	self.record = self.record + 1
	local o = FRAME_TIME
	local p = f(e(self.timerList))
	for q = #p, 1, -1 do
		do
			local r = p[q]
			local s = self.timerList[r]
			if s == nil then
				goto t
			end
			if GameRules:IsGamePaused() and (s.type == "GameTimer" or s.type == "Modifier") then
				goto t
			end
			if s.entity ~= nil and not IsValid(s.entity) then
				self.timerList[r] = nil
				goto t
			end
			s.stack = s.stack + o
			if s.stack >= s.interval then
				local u, v = xpcall(s.callback, debug.traceback, s.entity or self)
				if type(v) == "number" then
					s.stack = s.stack - s.interval
					s.interval = v
				elseif s.type == "Modifier" then
					s.stack = s.stack - s.interval
				else
					self.timerList[r] = nil
				end
			end
		end
		::t::
	end
end
function n.prototype.init(self, w)
	if not w then
		local x = 0
		local y = 30
		local z = 0
		local A = -1
		TimerManager:Timer(0, function()
			local B = LocalTime().Seconds
			y = y + 1
			if A ~= B then
				z = FRAME_LIMIT_TICK * 30 / y
				y = 0
				A = B
			end
			x = x + 1
			if x > z then
				OVERHEAD_EVENT_MESSAGE_LIMIT_RECORD = {}
				CREATEPARTICLE_FRAME_ALL_LIMIT_COUNTER = 0
				x = 0
			end
			return 0
		end)
	end
end
function n.prototype.startInternalThinker(self, C, D, E, F)
	E = math.max(E, FRAME_TIME)
	self.timerList[self.index] = { interval = E, stack = 0, type = C, entity = D, callback = F }
	self.index = self.index + 1
	return self.index - 1
end
function n.prototype.Timer(self, D, E, F)
	if F == nil then
		F = E
		E = D
		D = nil
	end
	return self:startInternalThinker("Timer", D, E, F)
end
function n.prototype.GameTimer(self, D, E, F)
	if F == nil then
		F = E
		E = D
		D = nil
	end
	return self:startInternalThinker("GameTimer", D, E, F)
end
function n.prototype.StartIntervalThink(self, G, E, F)
	return self:startInternalThinker("Modifier", G, E, F)
end
function n.prototype.StopTimer(self, r)
	if self.timerList[r] then
		g(self.timerList, r)
	end
end
n = h({ m }, n)
if _G.TimerManager == nil then
	_G.TimerManager = i(n)
end
return k