--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/tstl-utils.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
____debugRuntime.register(
	"utils/tstl-utils.lua",
	{
		["8"] = "1:7",
		["9"] = "4:5",
		["10"] = "5:5",
		["12"] = "8:1",
		["13"] = "9:11",
		["14"] = "10:9",
		["15"] = "11:9",
		["17"] = "14:5",
		["18"] = "15:5",
		["19"] = "8:1",
	}
)
local ____exports = {}
local global = _G
if global.reloadCache == nil then
	global.reloadCache = {}
end
function ____exports.reloadable(self, constructor)
	local className = constructor.name
	if global.reloadCache[className] == nil then
		global.reloadCache[className] = constructor
	end
	__TS__ObjectAssign(global.reloadCache[className].prototype, constructor.prototype)
	return global.reloadCache[className]
end
return ____exports