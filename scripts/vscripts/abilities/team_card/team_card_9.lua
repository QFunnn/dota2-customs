--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/team_card/team_card_9"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 7,
		["16"] = 8,
		["17"] = 8,
		["18"] = 8,
		["19"] = 8,
		["21"] = 4,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.team_card_9 = c()
local i = f.team_card_9
i.name = "team_card_9"
d(i, h)
function i.prototype.spawn(self)
	if IsServer() then
		print("team_card_9", self.playerID)
		GroupTeam:reduceTeamPortalCooldown(self.playerID, self:getSpecialValueFor("round_reduce"))
	end
end
return f