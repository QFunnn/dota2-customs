--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "units/global_timer"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(debug.getinfo(1).short_src, { ["4"] = 2, ["5"] = 3, ["6"] = 2 })
function OnTimer(self)
	TimerManager:Think()
end