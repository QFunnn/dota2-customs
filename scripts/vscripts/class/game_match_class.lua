--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "class/game_match_class"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 2,
		["11"] = 2,
		["12"] = 5,
		["13"] = 6,
		["14"] = 5,
		["15"] = 6,
		["17"] = 6,
		["18"] = 7,
		["19"] = 9,
		["20"] = 5,
		["21"] = 5,
		["22"] = 6,
	}
)
local g = {}
local h = require("lib.tstl-utils")
local i = h.reloadable
local j = require("service.sync_data_entity")
local k = j.SyncDataEntity
g.CPlayerServiceData = c()
local l = g.CPlayerServiceData
l.name = "CPlayerServiceData"
d(l, k)
function l.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.LogCBData = {}
	self.RoomID = 0
end
l = e({ i }, l)
g.CPlayerServiceData = l
return g