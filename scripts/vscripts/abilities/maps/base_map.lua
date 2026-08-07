--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/maps/base_map.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__Delete
local f = c.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 3,
		["9"] = 3,
		["10"] = 3,
		["11"] = 8,
		["12"] = 9,
		["13"] = 10,
		["14"] = 11,
		["16"] = 13,
		["17"] = 8,
		["18"] = 15,
		["19"] = 16,
		["20"] = 15,
		["21"] = 18,
		["22"] = 18,
		["23"] = 20,
		["24"] = 22,
		["25"] = 23,
		["26"] = 24,
		["27"] = 20,
		["28"] = 26,
		["29"] = 27,
		["30"] = 28,
		["31"] = 29,
		["33"] = 26,
		["34"] = 32,
		["35"] = 33,
		["36"] = 34,
		["37"] = 35,
		["38"] = 36,
		["42"] = 32,
	}
)
local g = {}
g.MapBase = d()
local h = g.MapBase
h.name = "MapBase"
function h.prototype.____constructor(self, i, j)
	self.oid = j
	if KeyValues.CosmeticsKV[j] and KeyValues.CosmeticsKV[j].resource then
		self.mapName = KeyValues.CosmeticsKV[j].resource
	end
	self.playerID = i
end
function h.prototype.getPlayerID(self)
	return self.playerID
end
function h.prototype.spawn(self) end
function h.prototype.ModifierEvent(self, k, l)
	local m = ModifierEvent(k, l, self)
	self.modifierEventIDList[m] = k
	return m
end
function h.prototype.RemoveModifierEvent(self, m)
	if self.modifierEventIDList[m] ~= nil then
		RemoveModifierEvent(self.modifierEventIDList[m], m)
		e(self.modifierEventIDList, m)
	end
end
function h.prototype.dispose(self)
	if self.modifierEventIDList then
		for m, n in pairs(self.modifierEventIDList) do
			if n then
				RemoveModifierEvent(n, m)
			end
		end
	end
end
return g