--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/abilities/trait/trait_155 copy.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__Decorate
local g = c.__TS__SourceMapTraceBack
g(
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
		["20"] = 11,
		["22"] = 12,
		["23"] = 12,
		["24"] = 13,
		["25"] = 12,
		["29"] = 6,
		["30"] = 5,
		["31"] = 4,
		["32"] = 5,
		["34"] = 5,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
h.trait_155 = d()
local l = h.trait_155
l.name = "trait_155"
e(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		local m = self:GetCaster()
		local n = m:GetPlayerOwnerID()
		PlayerData:clearArtifact(n)
		local o = GameState:getArtifactRounds()
		do
			local p = #o - 1
			while p >= 0 do
				PlayerData:selectArtifactByRound(n, o[p + 1], "item_artifact_124")
				p = p - 1
			end
		end
	end
end
l = f({ k(nil) }, l)
h.trait_155 = l
return h