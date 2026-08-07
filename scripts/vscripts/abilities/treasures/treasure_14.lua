--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["11"] = 4,
		["12"] = 5,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 15,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 17,
		["30"] = 17,
		["31"] = 17,
		["32"] = 17,
		["33"] = 17,
		["34"] = 17,
		["35"] = 17,
		["37"] = 15,
		["38"] = 19,
		["40"] = 6,
		["41"] = 5,
		["42"] = 4,
		["43"] = 5,
		["45"] = 5,
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
				PlayerData:selectArtifactByRound(l, n[r + 1], "treasure_14", function()
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