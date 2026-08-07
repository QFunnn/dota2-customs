--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "lib/tstl-utils"
local b = require("lualib_bundle")
local c = b.__TS__ObjectAssign
local d = {}
local e = _G
if e.reloadCache == nil then
	e.reloadCache = {}
end
function d.reloadable(self, f)
	local g = f.name
	if e.reloadCache[g] == nil then
		e.reloadCache[g] = f
	end
	c(e.reloadCache[g].prototype, f.prototype)
	return e.reloadCache[g]
end
return d