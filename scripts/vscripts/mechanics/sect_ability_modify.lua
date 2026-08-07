--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/mechanics/sect_ability_modify.ts"
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
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["18"] = 6,
		["19"] = 12,
		["20"] = 12,
		["21"] = 16,
		["22"] = 17,
		["23"] = 16,
		["24"] = 3,
		["25"] = 25,
		["26"] = 26,
	}
)
local i = {}
local j = require("lib.tstl-utils")
local k = j.reloadable
local l = d()
l.name = "CAbilityModify"
e(l, CModule)
function l.prototype.init(self, m)
	if not m then
		self:reset()
	end
end
function l.prototype.addSectAbilityModify(self, n, o) end
function l.prototype.reset(self)
	self.ModifyList = {}
end
l = f({ k }, l)
if _G.AbilityModify == nil then
	_G.AbilityModify = g(l)
end
return i