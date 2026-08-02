--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
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