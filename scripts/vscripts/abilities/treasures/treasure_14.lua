--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_14"
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
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["26"] = 14,
		["27"] = 15,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["33"] = 17,
		["34"] = 17,
		["35"] = 17,
		["37"] = 14,
		["38"] = 19,
		["40"] = 5,
		["41"] = 4,
		["42"] = 3,
		["43"] = 4,
		["45"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_14 = c()
local k = g.treasure_14
k.name = "treasure_14"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster():GetPlayerOwnerID()
		local m = PlayerData:getplayerData(l)
		if not m or m:IsBotData() then
			return
		end
		local n = GameState:getArtifactRounds()
		local o = math.min(#m.artifacts, #n)
		PlayerData:clearArtifact(l)
		local p
		p = function(q, r)
			if r < o then
				PlayerData:selectArtifactByRound(l, n[r + 1], "item_artifact_128", function()
					return p(nil, r + 1)
				end, true, false)
			end
		end
		p(nil, 0)
	end
end
k = e({ j(nil) }, k)
g.treasure_14 = k
return g