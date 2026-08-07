--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "_config"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{ ["7"] = 12, ["10"] = 18, ["11"] = 19, ["12"] = 20, ["14"] = 25, ["15"] = 26, ["16"] = 25 }
)
local d = {}
d.ADDON_NAME = "c1"
d.DEBUG_TAG_SERVER = "c1_debug"
d.DEBUG_TAG_CLIENT = "c1_client_debug"
d.DEBUG_TAG_PUI = "c1_pui_debug"
function d.GetDebugTag(self)
	return IsServer() and d.DEBUG_TAG_SERVER or d.DEBUG_TAG_CLIENT
end
return d