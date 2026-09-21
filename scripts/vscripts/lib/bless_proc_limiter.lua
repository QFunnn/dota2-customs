--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "lib/bless_proc_limiter"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{
		["7"] = 2,
		["8"] = 3,
		["9"] = 2,
		["11"] = 13,
		["12"] = 15,
		["13"] = 15,
		["15"] = 16,
		["16"] = 13,
		["17"] = 19,
		["18"] = 19,
		["19"] = 19,
		["21"] = 19,
		["22"] = 21,
		["23"] = 22,
		["24"] = 22,
		["26"] = 23,
		["27"] = 23,
		["29"] = 24,
		["30"] = 25,
		["31"] = 21,
	}
)
local e = {}
function e.IsLimitedBlessEvent(self, f)
	return f == "damage_event"
		or f == "crit_event"
		or f == "attack_event"
		or f == "poison_event"
		or f == "poison_pool_event"
		or f == "expose_effect"
		or f == "expose_event"
		or f == "ice_mark_effect"
		or f == "ice_mark_event"
		or f == "frozen_event"
		or f == "frozen_attenation"
		or f == "lightning_strike"
		or f == "ice_strike"
		or f == "throw_snowball"
		or f == "blood_spear"
end
function e.IsLimitedBlessListener(self, f, g)
	if g == "item_holy_courage" or g == "item_poison_heal" or g == "item_wind_crit" then
		return false
	end
	return e.IsLimitedBlessEvent(nil, f)
end
e.BlessProcLimiter = c()
local h = e.BlessProcLimiter
h.name = "BlessProcLimiter"
function h.prototype.____constructor(self) end
function h.prototype.Allow(self, i, j)
	if j then
		return false
	end
	if self.lastTrigger ~= nil and i >= self.lastTrigger and i - self.lastTrigger < 0.1 then
		return false
	end
	self.lastTrigger = i
	return true
end
return e