--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/client_request_event"
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
		["10"] = 1,
		["11"] = 3,
		["12"] = 4,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["18"] = 8,
		["19"] = 9,
		["21"] = 11,
		["22"] = 5,
		["23"] = 4,
		["24"] = 3,
		["25"] = 4,
		["27"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.client_request_event = c()
local k = g.client_request_event
k.name = "client_request_event"
d(k, i)
function k.prototype.GetAbilityTextureName(self)
	if _G.ClientRequestEventResult ~= nil then
		local l = _G.ClientRequestEventResult
		_G.ClientRequestEventResult = nil
		return l
	end
	return ""
end
k = e({ j(nil) }, k)
g.client_request_event = k
return g