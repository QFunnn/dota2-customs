--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/card_effect/effect_card_base.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 3,
		["8"] = 3,
		["9"] = 3,
		["10"] = 8,
		["11"] = 9,
		["12"] = 10,
		["13"] = 11,
		["14"] = 8,
		["15"] = 13,
		["16"] = 14,
		["17"] = 13,
		["18"] = 16,
		["19"] = 16,
		["20"] = 18,
		["21"] = 18,
		["22"] = 20,
		["23"] = 21,
		["24"] = 21,
		["25"] = 21,
		["27"] = 21,
		["28"] = 21,
		["29"] = 21,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["35"] = 21,
		["36"] = 20,
	}
)
local f = {}
f.EffectCardBase = d()
local g = f.EffectCardBase
g.name = "EffectCardBase"
function g.prototype.____constructor(self, h, i)
	self.cardName = i
	self.playerID = h
	self.kv = KeyValues.CardEffectKV[i]
end
function g.prototype.getPlayerID(self)
	return self.playerID
end
function g.prototype.spawn(self) end
function g.prototype.dispose(self) end
function g.prototype.getSpecialValueFor(self, j)
	local k = self.kv
	if k ~= nil then
		k = k.AbilityValues
	end
	local l = k
	if l ~= nil then
		l = l[j]
	end
	local m = l
	if m == nil then
		m = 0
	end
	return m
end
return f