--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "requires"
local b = require("lualib_bundle")
local c = b.__TS__SourceMapTraceBack
c(
	debug.getinfo(1).short_src,
	{
		["4"] = 1,
		["6"] = 4,
		["7"] = 5,
		["8"] = 6,
		["9"] = 7,
		["10"] = 8,
		["12"] = 6,
		["15"] = 14,
		["16"] = 15,
		["17"] = 16,
		["18"] = 17,
		["19"] = 18,
		["20"] = 19,
		["21"] = 20,
		["22"] = 21,
		["23"] = 22,
		["24"] = 23,
		["25"] = 24,
		["26"] = 25,
		["27"] = 26,
		["28"] = 27,
		["29"] = 29,
		["31"] = 31,
		["32"] = 32,
	}
)
pcall(require, "encrypt")
do
	if not _G.print_Engine then
		_G.print_Engine = print
		_G.print = function(...)
			if not IsDedicatedServer() then
				print_Engine(...)
			end
		end
	end
end
require("constant")
require("globals.index")
require("request")
require("framework.index")
require("kv")
require("settings")
require("modifiers.index")
require("abilities.index")
require("utils")
if IsServer() then
	require("service.index")
	require("game")
	require("filter")
	require("mechanics.index")
	require("service.service_server")
else
	require("mechanics.index")
	require("service.service_client")
end