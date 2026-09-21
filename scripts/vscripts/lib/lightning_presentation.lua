--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "lib/lightning_presentation"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArraySplice
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["12"] = 3,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 2,
		["17"] = 10,
		["18"] = 11,
		["19"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["25"] = 15,
		["26"] = 15,
		["28"] = 16,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["33"] = 21,
		["34"] = 22,
		["35"] = 23,
		["36"] = 24,
		["37"] = 24,
		["41"] = 15,
		["44"] = 26,
		["45"] = 27,
		["46"] = 27,
		["48"] = 28,
		["49"] = 28,
		["50"] = 28,
		["51"] = 28,
		["52"] = 28,
		["53"] = 28,
		["54"] = 28,
		["55"] = 28,
		["56"] = 29,
		["57"] = 10,
	}
)
local f = {}
f.LightningPresentation = c()
local g = f.LightningPresentation
g.name = "LightningPresentation"
function g.prototype.____constructor(self)
	self.recent = {}
	self.interval = 0.1
	self.radiusSquared = 300 * 300
	self.particleBudget = 12
end
function g.prototype.ShouldPlay(self, h, i, j)
	if self.lastTime ~= nil and j < self.lastTime then
		self.recent = {}
	end
	self.lastTime = j
	local k = 0
	local l = false
	do
		local m = #self.recent - 1
		while m >= 0 do
			do
				local n = self.recent[m + 1]
				if j - n.time >= self.interval then
					d(self.recent, m, 1)
					goto o
				end
				k = k + n.cost
				local p = i.x - n.x
				local q = i.y - n.y
				if n.kind == h and p * p + q * q <= self.radiusSquared then
					l = true
				end
			end
			::o::
			m = m - 1
		end
	end
	local r = h == "arc" and 3 or 2
	if l or k + r > self.particleBudget then
		return false
	end
	local s = self.recent
	s[#s + 1] = { time = j, x = i.x, y = i.y, kind = h, cost = r }
	return true
end
return f