--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_158"
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
		["11"] = 4,
		["12"] = 5,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 10,
		["21"] = 10,
		["22"] = 10,
		["23"] = 10,
		["24"] = 10,
		["25"] = 10,
		["26"] = 10,
		["27"] = 11,
		["29"] = 6,
		["30"] = 5,
		["31"] = 4,
		["32"] = 5,
		["34"] = 5,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.trait_158 = c()
local k = g.trait_158
k.name = "trait_158"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster()
		local m = l:GetPlayerOwnerID()
		local n = RuneTask:generateRandomRuneList(m, 4, RUNE_TASK_ROUNDS[2], nil, true, "158")
		RuneTask:setRuneRewardList(m, n)
	end
end
k = e({ j(nil) }, k)
g.trait_158 = k
return g