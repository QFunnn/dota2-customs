--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "lib/tstl-utils"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = b.__TS__SourceMapTraceBack
d(
	debug.getinfo(1).short_src,
	{ ["6"] = 1, ["7"] = 2, ["8"] = 3, ["10"] = 6, ["11"] = 7, ["12"] = 8, ["13"] = 9, ["15"] = 12, ["16"] = 13, ["17"] = 6 }
)
local e = {}
local f = _G
if f.reloadCache == nil then
	f.reloadCache = {}
end
function e.reloadable(self, g)
	local h = g.name
	if f.reloadCache[h] == nil then
		f.reloadCache[h] = g
	end
	c(f.reloadCache[h].prototype, g.prototype)
	return f.reloadCache[h]
end
return e