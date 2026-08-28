--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "class/game_state_class"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ArrayForEach
local e = {}
e.CGameStateBase = c()
local f = e.CGameStateBase
f.name = "CGameStateBase"
function f.prototype.____constructor(self)
	self.eventIDList = {}
end
function f.prototype.dispose(self)
	self:StopTimer()
	d(self.eventIDList, function(g, h)
		Event:Unregister(h)
	end)
end
function f.prototype.OnStateStart(self) end
function f.prototype.OnStateEnd(self) end
function f.prototype.StartThink(self, i, j)
	self.timerID = Timer:GameTimer(i, j)
end
function f.prototype.Register(self, k, j)
	local l = self.eventIDList
	local m = #l + 1
	l[m] = Event:Register(k, j)
	return m
end
function f.prototype.GetName(self)
	return self.constructor.name
end
function f.prototype.StopTimer(self)
	if self.timerID then
		Timer:StopTimer(self.timerID)
		self.timerID = nil
	end
end
return e