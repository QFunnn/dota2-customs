--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/maps/map_base"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__Delete
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["8"] = 3,
		["9"] = 3,
		["10"] = 3,
		["11"] = 9,
		["12"] = 10,
		["13"] = 11,
		["14"] = 12,
		["15"] = 13,
		["16"] = 9,
		["17"] = 16,
		["18"] = 17,
		["19"] = 16,
		["20"] = 19,
		["21"] = 19,
		["22"] = 21,
		["23"] = 23,
		["24"] = 24,
		["25"] = 25,
		["26"] = 21,
		["27"] = 27,
		["28"] = 28,
		["29"] = 29,
		["30"] = 30,
		["32"] = 27,
		["33"] = 33,
		["34"] = 34,
		["35"] = 35,
		["36"] = 36,
		["37"] = 37,
		["41"] = 41,
		["42"] = 33,
		["43"] = 43,
		["44"] = 43,
	}
)
local f = {}
f.MapBase = c()
local g = f.MapBase
g.name = "MapBase"
function g.prototype.____constructor(self, h, i, j)
	self.mapName = i
	self.position = j
	self.playerID = h
	self.modifierEventIDList = {}
end
function g.prototype.getPlayerID(self)
	return self.playerID
end
function g.prototype.spawn(self) end
function g.prototype.ModifierEvent(self, k, l)
	local m = ModifierEvent(k, l, self)
	self.modifierEventIDList[m] = k
	return m
end
function g.prototype.RemoveModifierEvent(self, m)
	if self.modifierEventIDList[m] ~= nil then
		RemoveModifierEvent(self.modifierEventIDList[m], m)
		d(self.modifierEventIDList, m)
	end
end
function g.prototype._dispose(self)
	if self.modifierEventIDList then
		for m, n in pairs(self.modifierEventIDList) do
			if n then
				RemoveModifierEvent(n, m)
			end
		end
	end
	self:dispose()
end
function g.prototype.dispose(self) end
return f