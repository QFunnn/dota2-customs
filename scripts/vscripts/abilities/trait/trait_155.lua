--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_155"
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
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["25"] = 15,
		["26"] = 16,
		["29"] = 19,
		["30"] = 20,
		["31"] = 20,
		["32"] = 20,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 20,
		["37"] = 20,
		["38"] = 15,
		["39"] = 22,
		["42"] = 6,
		["43"] = 5,
		["44"] = 4,
		["45"] = 5,
		["47"] = 5,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.trait_155 = c()
local k = g.trait_155
k.name = "trait_155"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		local l = self:GetCaster()
		local m = l:GetPlayerOwnerID()
		local n = PlayerData:getplayerData(m)
		if n and not n:IsBotData() then
			local o = GameState:getArtifactRounds()
			local p = math.min(#n.artifacts, #o)
			PlayerData:clearArtifact(m)
			local q
			q = function(r, s)
				if s >= p then
					return
				end
				local t = o[s + 1]
				PlayerData:selectArtifactByRound(m, t, "item_artifact_128", function()
					return q(nil, s + 1)
				end, true, false)
			end
			q(nil, 0)
		end
	end
end
k = e({ j(nil) }, k)
g.trait_155 = k
return g