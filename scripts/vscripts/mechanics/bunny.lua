--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/mechanics/bunny.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__New
local h = c.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["15"] = 4,
		["16"] = 7,
		["17"] = 7,
		["18"] = 7,
		["19"] = 7,
		["20"] = 5,
		["21"] = 3,
		["22"] = 14,
		["23"] = 15,
	}
)
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = d()
l.name = "CBunny"
e(l, CModule)
function l.prototype.____constructor(self)
	CModule.prototype.____constructor(self)
	self:print(IsServer(), "CBunny")
end
l = f({ k }, l)
if _G.Bunny == nil then
	_G.Bunny = g(l)
end
return i