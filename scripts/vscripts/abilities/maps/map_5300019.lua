--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/maps/map_5300019.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{ ["7"] = 1, ["8"] = 1, ["9"] = 3, ["10"] = 3, ["11"] = 3, ["12"] = 3, ["13"] = 4, ["14"] = 4, ["15"] = 7, ["16"] = 7 }
)
local g = {}
local h = require("abilities.maps.map_base")
local i = h.MapBase
g.map_5300019 = d()
local j = g.map_5300019
j.name = "map_5300019"
e(j, i)
function j.prototype.spawn(self) end
function j.prototype.dispose(self) end
return g