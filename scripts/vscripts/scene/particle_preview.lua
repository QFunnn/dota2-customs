--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "scene/particle_preview"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["5"] = 1,
		["6"] = 1,
		["7"] = 8,
		["8"] = 8,
		["10"] = 11,
		["11"] = 11,
		["12"] = 11,
		["13"] = 11,
		["14"] = 12,
		["15"] = 11,
		["16"] = 11,
		["17"] = 15,
		["18"] = 15,
		["19"] = 15,
		["20"] = 15,
		["21"] = 16,
		["22"] = 15,
		["23"] = 15,
	}
)
local d = {}
local e = require("lib.dota_ts_adapter")
local f = e.registerEntityFunction
if not _G.placeHolders then
	_G.placeHolders = {}
end
f(nil, "Precache", function()
	print("Scene Precache:")
end)
f(nil, "Spawn", function()
	print("Scene Spawn:")
end)
return d